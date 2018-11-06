Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC003C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F3920827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F3920827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388235AbeKGEoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:44:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53707 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbeKGEoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:44:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JHRLt912144
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:17:27 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JHQ1I912140;
        Tue, 6 Nov 2018 11:17:26 -0800
Date:   Tue, 6 Nov 2018 11:17:26 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-93f8be2799515e01647c5a9b0d17a90a00ebcf82@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, adrian.hunter@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, adrian.hunter@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com
In-Reply-To: <20181105073505.8129-2-adrian.hunter@intel.com>
References: <20181105073505.8129-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf intel-pt: Add more event information to
 debug log
Git-Commit-ID: 93f8be2799515e01647c5a9b0d17a90a00ebcf82
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

Commit-ID:  93f8be2799515e01647c5a9b0d17a90a00ebcf82
Gitweb:     https://git.kernel.org/tip/93f8be2799515e01647c5a9b0d17a90a00ebcf82
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 5 Nov 2018 09:35:04 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Nov 2018 14:53:37 -0300

perf intel-pt: Add more event information to debug log

More event information is useful for debugging, especially MMAP events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/r/20181105073505.8129-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt-decoder/intel-pt-log.c |  5 +++++
 tools/perf/util/intel-pt-decoder/intel-pt-log.h |  1 +
 tools/perf/util/intel-pt.c                      | 16 +++++++++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.c b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
index e02bc7b166a0..5e64da270f97 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-log.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
@@ -31,6 +31,11 @@ static FILE *f;
 static char log_name[MAX_LOG_NAME];
 bool intel_pt_enable_logging;
 
+void *intel_pt_log_fp(void)
+{
+	return f;
+}
+
 void intel_pt_log_enable(void)
 {
 	intel_pt_enable_logging = true;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.h b/tools/perf/util/intel-pt-decoder/intel-pt-log.h
index 45b64f93f358..cc084937f701 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-log.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.h
@@ -22,6 +22,7 @@
 
 struct intel_pt_pkt;
 
+void *intel_pt_log_fp(void);
 void intel_pt_log_enable(void);
 void intel_pt_log_disable(void);
 void intel_pt_log_set_name(const char *name);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 86cc9a64e982..149ff361ca78 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -206,6 +206,16 @@ static void intel_pt_dump_event(struct intel_pt *pt, unsigned char *buf,
 	intel_pt_dump(pt, buf, len);
 }
 
+static void intel_pt_log_event(union perf_event *event)
+{
+	FILE *f = intel_pt_log_fp();
+
+	if (!intel_pt_enable_logging || !f)
+		return;
+
+	perf_event__fprintf(event, f);
+}
+
 static int intel_pt_do_fix_overlap(struct intel_pt *pt, struct auxtrace_buffer *a,
 				   struct auxtrace_buffer *b)
 {
@@ -2010,9 +2020,9 @@ static int intel_pt_process_event(struct perf_session *session,
 		 event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
 		err = intel_pt_context_switch(pt, event, sample);
 
-	intel_pt_log("event %s (%u): cpu %d time %"PRIu64" tsc %#"PRIx64"\n",
-		     perf_event__name(event->header.type), event->header.type,
-		     sample->cpu, sample->time, timestamp);
+	intel_pt_log("event %u: cpu %d time %"PRIu64" tsc %#"PRIx64" ",
+		     event->header.type, sample->cpu, sample->time, timestamp);
+	intel_pt_log_event(event);
 
 	return err;
 }
