Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBCFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FFD20675
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393420AbfBOJso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:48:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33307 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389612AbfBOJso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:48:44 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9mVeN1121365
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:48:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9mViE1121362;
        Fri, 15 Feb 2019 01:48:31 -0800
Date:   Fri, 15 Feb 2019 01:48:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6368942a9223fb8cd9b5623fc0b99d75d5ca93a7@git.kernel.org>
Cc:     peterz@infradead.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        jolsa@kernel.org, hpa@zytor.com
Reply-To: jolsa@kernel.org, hpa@zytor.com, acme@redhat.com,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          namhyung@kernel.org, peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190213123246.4015-3-jolsa@kernel.org>
References: <20190213123246.4015-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Rename LIB_FILE to LIBPERF_A
Git-Commit-ID: 6368942a9223fb8cd9b5623fc0b99d75d5ca93a7
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

Commit-ID:  6368942a9223fb8cd9b5623fc0b99d75d5ca93a7
Gitweb:     https://git.kernel.org/tip/6368942a9223fb8cd9b5623fc0b99d75d5ca93a7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 13 Feb 2019 13:32:38 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:08 -0300

perf tools: Rename LIB_FILE to LIBPERF_A

Simple rename, no functional change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 93de7c7b8007..01f7555fd933 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -344,7 +344,7 @@ endif
 
 export PERL_PATH
 
-LIB_FILE=$(OUTPUT)libperf.a
+LIBPERF_A=$(OUTPUT)libperf.a
 
 PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD)
 ifndef NO_LIBBPF
@@ -688,7 +688,7 @@ endif
 
 $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
 
-$(LIB_FILE): $(LIBPERF_IN)
+$(LIBPERF_A): $(LIBPERF_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN) $(LIB_OBJS)
 
 LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(LDFLAGS)'
@@ -910,7 +910,7 @@ python-clean:
 	$(python-clean)
 
 clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean config-clean fixdep-clean python-clean
-	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIB_FILE) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
+	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
 	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 perf-read-vdsox32 $(OUTPUT)pmu-events/jevents $(OUTPUT)$(LIBJVMTI).so
