-- Hosted projects may still grant API roles access by default. Declare
-- the CRM's privileges explicitly so installation works with either
-- setting and signed-out clients cannot query CRM tables.
REVOKE ALL PRIVILEGES ON TABLE
  public.account_invitations, public.accounts, public.ai_configs,
  public.ai_knowledge_chunks, public.ai_knowledge_documents, public.ai_usage_log,
  public.api_keys, public.automation_logs, public.automation_pending_executions,
  public.automation_steps, public.automations, public.broadcast_recipients,
  public.broadcasts, public.contact_custom_values, public.contact_notes,
  public.contact_tags, public.contacts, public.conversations, public.custom_fields,
  public.deals, public.flow_nodes, public.flow_run_events, public.flow_runs,
  public.flows, public.member_presence, public.message_reactions,
  public.message_templates, public.messages, public.notifications,
  public.pending_message_statuses, public.pipeline_stages, public.pipelines,
  public.profiles, public.quick_replies, public.tags, public.webhook_endpoints,
  public.whatsapp_config
FROM PUBLIC, anon, authenticated;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
  public.account_invitations, public.ai_configs, public.ai_knowledge_chunks,
  public.ai_knowledge_documents, public.api_keys, public.automation_steps,
  public.automations, public.broadcast_recipients, public.broadcasts,
  public.contact_custom_values, public.contact_notes, public.contact_tags,
  public.contacts, public.conversations, public.custom_fields, public.deals,
  public.flow_nodes, public.flows, public.message_reactions, public.message_templates,
  public.messages, public.pipeline_stages, public.pipelines, public.quick_replies,
  public.tags, public.webhook_endpoints, public.whatsapp_config
TO authenticated;

GRANT SELECT, UPDATE ON TABLE public.accounts, public.profiles TO authenticated;
GRANT SELECT ON TABLE
  public.ai_usage_log, public.automation_logs, public.flow_run_events,
  public.flow_runs, public.member_presence, public.notifications
TO authenticated;
GRANT UPDATE (read_at) ON TABLE public.notifications TO authenticated;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
  public.account_invitations, public.accounts, public.ai_configs,
  public.ai_knowledge_chunks, public.ai_knowledge_documents, public.ai_usage_log,
  public.api_keys, public.automation_logs, public.automation_pending_executions,
  public.automation_steps, public.automations, public.broadcast_recipients,
  public.broadcasts, public.contact_custom_values, public.contact_notes,
  public.contact_tags, public.contacts, public.conversations, public.custom_fields,
  public.deals, public.flow_nodes, public.flow_run_events, public.flow_runs,
  public.flows, public.member_presence, public.message_reactions,
  public.message_templates, public.messages, public.notifications,
  public.pending_message_statuses, public.pipeline_stages, public.pipelines,
  public.profiles, public.quick_replies, public.tags, public.webhook_endpoints,
  public.whatsapp_config
TO service_role;

-- Keep peek_invitation as the only app RPC intended for signed-out
-- callers. Revoke both PUBLIC and direct anon grants from internal RPCs.
REVOKE EXECUTE ON FUNCTION
  public._bcast_cols_for_status(TEXT),
  public.filter_contacts_by_tags(UUID[], TEXT, INTEGER, INTEGER),
  public.is_account_member(UUID, public.account_role_enum),
  public.match_ai_knowledge_fts(UUID, TEXT, INTEGER),
  public.match_ai_knowledge_semantic(UUID, TEXT, INTEGER),
  public.redeem_invitation(TEXT),
  public.remove_account_member(UUID),
  public.set_member_role(UUID, public.account_role_enum),
  public.touch_presence(TEXT),
  public.transfer_account_ownership(UUID)
FROM PUBLIC, anon;

GRANT EXECUTE ON FUNCTION public.touch_presence(TEXT) TO authenticated;
