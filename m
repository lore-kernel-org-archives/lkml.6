Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B27C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DA7222D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191719;
	bh=MjeA40xQx8Xz0BvTjQkzaok3iAT4fUgiCm97fjNYZzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EJENEb0RURGjuK1O/KfG58cCnmHJ4U6+1cGi3wZsUvCHPHzD1Cbg54CLRGOxCZmWK
	 KSKiu0Heq634k/WmgcFOsP2xLB7nY2laBqV8F67601mi2Ns8Jlrus3olA2q/5rZyyS
	 HdJVV9fY6A55afMsBsJYvSkZMLnbJ/gFy20QX3ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbfBOAsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389722AbfBOAse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:48:34 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1087222D9;
        Fri, 15 Feb 2019 00:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191713;
        bh=MjeA40xQx8Xz0BvTjQkzaok3iAT4fUgiCm97fjNYZzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5EHfThs27cA9o+B/yZw0kznsmViIGz28oqB5ILP9tMYVtpOJBia0zCGPPpQHZa2v
         xZJMIFRQR0ipJt+ewjDb2A/q7nJXqDAOlfOenVj3FThqNqevJYb6IDwXESqmyTSlLT
         r1ib+hxOISPEYMO0+WNYT0PeOwZrxsfXFZ4ursKk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/43] perf tools: Rename LIB_FILE to LIBPERF_A
Date:   Thu, 14 Feb 2019 21:45:33 -0300
Message-Id: <20190215004539.23571-38-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.19.1

