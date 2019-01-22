Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE01C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B0A2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfAVKTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:19:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43677 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfAVKTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:19:24 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MAIssc2907367
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:18:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MAIssS2907364;
        Tue, 22 Jan 2019 02:18:54 -0800
Date:   Tue, 22 Jan 2019 02:18:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-d764ac6464915523e68e220b6aa4c3c2eb8e3f94@git.kernel.org>
Cc:     hpa@zytor.com, songliubraving@fb.com, mingo@kernel.org,
        tglx@linutronix.de, daniel@iogearbox.net, peterz@infradead.org,
        acme@redhat.com, ast@kernel.org, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, songliubraving@fb.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, ast@kernel.org, acme@redhat.com,
          peterz@infradead.org, tglx@linutronix.de, daniel@iogearbox.net
In-Reply-To: <20190117161521.1341602-3-songliubraving@fb.com>
References: <20190117161521.1341602-3-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools headers uapi: Sync
 tools/include/uapi/linux/perf_event.h
Git-Commit-ID: d764ac6464915523e68e220b6aa4c3c2eb8e3f94
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d764ac6464915523e68e220b6aa4c3c2eb8e3f94
Gitweb:     https://git.kernel.org/tip/d764ac6464915523e68e220b6aa4c3c2eb8e3f94
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Thu, 17 Jan 2019 08:15:14 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 17:00:57 -0300

tools headers uapi: Sync tools/include/uapi/linux/perf_event.h

Sync changes for PERF_RECORD_KSYMBOL.

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Link: http://lkml.kernel.org/r/20190117161521.1341602-3-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/perf_event.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ea19b5d491bf..1dee5c8f166b 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -372,7 +372,8 @@ struct perf_event_attr {
 				context_switch :  1, /* context switch data */
 				write_backward :  1, /* Write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
-				__reserved_1   : 35;
+				ksymbol        :  1, /* include ksymbol events */
+				__reserved_1   : 34;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -963,9 +964,32 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_NAMESPACES			= 16,
 
+	/*
+	 * Record ksymbol register/unregister events:
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				addr;
+	 *	u32				len;
+	 *	u16				ksym_type;
+	 *	u16				flags;
+	 *	char				name[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_KSYMBOL			= 17,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
+enum perf_record_ksymbol_type {
+	PERF_RECORD_KSYMBOL_TYPE_UNKNOWN	= 0,
+	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
+	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
+};
+
+#define PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER	(1 << 0)
+
 #define PERF_MAX_STACK_DEPTH		127
 #define PERF_MAX_CONTEXTS_PER_STACK	  8
 
