Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C91CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D4F214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544486550;
	bh=IQ6bSWYRRQlQ73hVfmiM3U1fjHX0gmcQcIh90+Hb530=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=A0OjqbUaYKTDVN7eLVHkt1/RDpZ1UBrUoQNBSuDt77QO4vilV1NWfBNM5wQpovrB3
	 Ti8Fp3YB68SviNU5xQTi67rndLHB/77qn6rmDtyW7uBqz+H8tEI1B1zf+aoYgwzat2
	 b3YOzdPSVkeuXyNPd1b5Lw3xlF84rAaw1dF4s5YE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D4F214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbeLKAC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:02:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730416AbeLKACV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:02:21 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE575214DE;
        Tue, 11 Dec 2018 00:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544486540;
        bh=IQ6bSWYRRQlQ73hVfmiM3U1fjHX0gmcQcIh90+Hb530=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=D1g1KrYq6ZO3AEhaWBqxLLo3fhOqBcjJQZPdIa7DddDXZsfVNMyK3htRP/lcUs5jY
         ulyFqMfdznXz1NRasm9uIuvHNeTUUrlyP9jjMm81DfYQcCSuablvRkdc985iXiVAd6
         xn3uPO762RI+gPPNJF7uSre1sy/D1xBH+ytTdnLk=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v8 22/22] tracing: Add hist trigger comments for variable-related fields
Date:   Mon, 10 Dec 2018 18:01:36 -0600
Message-Id: <095c3bd35a755500fcb3eb1a26d0c3240bb4e688.1544483273.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Add a few comments to help clarify how variable and variable reference
fields are used in the code.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 81e998bb601e..de5748ff8775 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -40,6 +40,16 @@ enum field_op_id {
 	FIELD_OP_UNARY_MINUS,
 };
 
+/*
+ * A hist_var (histogram variable) contains variable information for
+ * hist_fields having the HIST_FIELD_FL_VAR or HIST_FIELD_FL_VAR_REF
+ * flag set.  A hist_var has a variable name e.g. ts0, and is
+ * associated with a given histogram trigger, as specified by
+ * hist_data.  The hist_var idx is the unique index assigned to the
+ * variable by the hist trigger's tracing_map.  The idx is what is
+ * used to set a variable's value and, by a variable reference, to
+ * retrieve it.
+ */
 struct hist_var {
 	char				*name;
 	struct hist_trigger_data	*hist_data;
@@ -56,11 +66,29 @@ struct hist_field {
 	const char			*type;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
+
+	/*
+	 * Variable fields contain variable-specific info in var.
+	 */
 	struct hist_var			var;
 	enum field_op_id		operator;
 	char				*system;
 	char				*event_name;
+
+	/*
+	 * The name field is used for EXPR and VAR_REF fields.  VAR
+	 * fields contain the variable name in var.name.
+	 */
 	char				*name;
+
+	/*
+	 * When a histogram trigger is hit, if it has any references
+	 * to variables, the values of those variables are collected
+	 * into a var_ref_vals array by resolve_var_refs().  The
+	 * current value of each variable is read from the tracing_map
+	 * using the hist field's hist_var.idx and entered into the
+	 * var_ref_idx entry i.e. var_ref_vals[var_ref_idx].
+	 */
 	unsigned int			var_ref_idx;
 	bool                            read_once;
 };
@@ -389,6 +417,14 @@ struct action_data {
 	unsigned int		n_params;
 	char			*params[SYNTH_FIELDS_MAX];
 
+	/*
+	 * When a histogram trigger is hit, the values of any
+	 * references to variables, including variables being passed
+	 * as parameters to synthetic events, are collected into a
+	 * var_ref_vals array.  This var_ref_idx is the index of the
+	 * first param in the array to be passed to the synthetic
+	 * event invocation.
+	 */
 	unsigned int		var_ref_idx;
 	struct synth_event	*synth_event;
 	bool			use_trace_keyword;
-- 
2.14.1

