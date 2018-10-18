Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63844C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2466121473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2466121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJROUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:20:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55481 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeJROUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:20:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9I6KhC7708073
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 23:20:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9I6Kh6D708070;
        Wed, 17 Oct 2018 23:20:43 -0700
Date:   Wed, 17 Oct 2018 23:20:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-298faf53200fc02af38d32715697df6e661c1257@git.kernel.org>
Cc:     rostedt@goodmis.org, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        herton@redhat.com, tz.stoyanov@gmail.com, y.karadz@gmail.com,
        hpa@zytor.com
Reply-To: y.karadz@gmail.com, jolsa@kernel.org, herton@redhat.com,
          linux-kernel@vger.kernel.org, tz.stoyanov@gmail.com,
          hpa@zytor.com, rostedt@goodmis.org, tglx@linutronix.de,
          acme@redhat.com, mingo@kernel.org
In-Reply-To: <20181016150614.21260-3-jolsa@kernel.org>
References: <20181016150614.21260-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Pass build flags to traceevent build
Git-Commit-ID: 298faf53200fc02af38d32715697df6e661c1257
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

Commit-ID:  298faf53200fc02af38d32715697df6e661c1257
Gitweb:     https://git.kernel.org/tip/298faf53200fc02af38d32715697df6e661c1257
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 16 Oct 2018 17:06:07 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 16 Oct 2018 14:57:59 -0300

perf tools: Pass build flags to traceevent build

So the extra user build flags are propagated to libtraceevent.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: "Herton R. Krzesinski" <herton@redhat.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Cc: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
Link: http://lkml.kernel.org/r/20181016150614.21260-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5224ade3d5af..0be411695379 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -635,7 +635,7 @@ $(LIBPERF_IN): prepare FORCE
 $(LIB_FILE): $(LIBPERF_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN) $(LIB_OBJS)
 
-LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ)
+LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(LDFLAGS)'
 
 $(LIBTRACEEVENT): FORCE
 	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent.a
