Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2105FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AF2214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544486569;
	bh=1nSJ9GK2ntKyI7c2SkFMV0lNpjApmE8DvRuIWOpcCAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=MtyoY3k59aZhUAY6LM74Tk6inByOnEkzs3oFKmSwfOVEVMDtxs1LCLY3aSGgSH+G9
	 t4eoR0AopVP2ONHX/pK6Iqqn6zg5p3qlAlFIDhUKhq2oWVI63I/ogaiWVPI8GNgR6h
	 NTHkH6yX7rhSSHTK9Tm1JAF6bXfoHFNC3ofggTQ4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AF2214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbeLKACS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:02:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbeLKACM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:02:12 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B5B214ED;
        Tue, 11 Dec 2018 00:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544486532;
        bh=1nSJ9GK2ntKyI7c2SkFMV0lNpjApmE8DvRuIWOpcCAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=telodvEn/qqCRXGP5UQFDR+Pe9E1IlKGlKC0uDzUS+l2I7+guSE/Jx1IK/C6uGRtq
         xRFsAY8qVw0Fnu2+WNo3RSWEWdQ+k6DX/91Dym9gxxh8CWs3pZi3EUTqcSJqBC68bD
         641f8ke71+s3BtMBcotpMfcrwQzTeZYY3NXpXuYY=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v8 17/22] tracing: Remove unnecessary hist trigger struct fields
Date:   Mon, 10 Dec 2018 18:01:31 -0600
Message-Id: <725804f4cd0e90ee3f19048e195e0bff08a189a8.1544483273.git.tom.zanussi@linux.intel.com>
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

track_data->var_ref->var_ref_idx can be used instead of
track_data.var_ref_idx, so remove it.

Also, hist_field.var_idx is completely unused, so remove it too.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9c19932a5321..130ac2cf6893 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -61,7 +61,6 @@ struct hist_field {
 	char				*system;
 	char				*event_name;
 	char				*name;
-	unsigned int			var_idx;
 	unsigned int			var_ref_idx;
 	bool                            read_once;
 };
@@ -419,7 +418,6 @@ struct action_data {
 			 * tracked e.g onmax($var).
 			 */
 			struct hist_field	*var_ref;
-			unsigned int		var_ref_idx;
 
 			/*
 			 * track_var contains the 'invisible' tracking
@@ -3637,7 +3635,7 @@ static void ontrack_action(struct hist_trigger_data *hist_data,
 			   struct ring_buffer_event *rbe,
 			   struct action_data *data, u64 *var_ref_vals)
 {
-	u64 var_val = var_ref_vals[data->track_data.var_ref_idx];
+	u64 var_val = var_ref_vals[data->track_data.var_ref->var_ref_idx];
 
 	if (check_track_val(elt, data, var_val)) {
 		save_track_val(hist_data, elt, data, var_val);
@@ -3694,7 +3692,6 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 {
 	struct hist_field *var_field, *ref_field, *track_var = NULL;
 	struct trace_event_file *file = hist_data->event_file;
-	unsigned int var_ref_idx = hist_data->n_var_refs;
 	char *track_data_var_str;
 	unsigned long flags;
 	int ret = 0;
@@ -3726,8 +3723,6 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 	ref_field->var_ref_idx = hist_data->n_var_refs++;
 	data->track_data.var_ref = ref_field;
 
-	data->track_data.var_ref_idx = var_ref_idx;
-
 	if (data->handler == HANDLER_ONMAX)
 		track_var = create_var(hist_data, file, "__max", sizeof(u64), "u64");
 	if (IS_ERR(track_var)) {
-- 
2.14.1

