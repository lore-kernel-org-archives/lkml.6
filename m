Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6256DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C233217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeLROCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:02:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39365 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeLROCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:02:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIE2O2C2852607
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:02:24 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIE2NJB2852604;
        Tue, 18 Dec 2018 06:02:23 -0800
Date:   Tue, 18 Dec 2018 06:02:23 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-4c784894ac29195af24362125a72beda4aeb8b9f@git.kernel.org>
Cc:     tstoyanov@vmware.com, rostedt@goodmis.org,
        akpm@linux-foundation.org, hpa@zytor.com, jolsa@redhat.com,
        mingo@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com
Reply-To: namhyung@kernel.org, akpm@linux-foundation.org, hpa@zytor.com,
          jolsa@redhat.com, mingo@kernel.org, tstoyanov@vmware.com,
          rostedt@goodmis.org, acme@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181130154647.176265533@goodmis.org>
References: <20181130154647.176265533@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Install trace-seq.h API
 header file
Git-Commit-ID: 4c784894ac29195af24362125a72beda4aeb8b9f
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

Commit-ID:  4c784894ac29195af24362125a72beda4aeb8b9f
Gitweb:     https://git.kernel.org/tip/4c784894ac29195af24362125a72beda4aeb8b9f
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 30 Nov 2018 10:44:06 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:55:59 -0300

tools lib traceevent: Install trace-seq.h API header file

This patch installs trace-seq.h header file on "make install".

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154647.176265533@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/Makefile b/tools/lib/traceevent/Makefile
index adb16f845ab3..67fe5d7ef190 100644
--- a/tools/lib/traceevent/Makefile
+++ b/tools/lib/traceevent/Makefile
@@ -285,7 +285,7 @@ define do_install_pkgconfig_file
 	fi
 endef
 
-install_lib: all_cmd install_plugins install_pkgconfig
+install_lib: all_cmd install_plugins install_headers install_pkgconfig
 	$(call QUIET_INSTALL, $(LIB_TARGET)) \
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIB_INSTALL) $(DESTDIR)$(libdir_SQ)
@@ -302,6 +302,7 @@ install_headers:
 	$(call QUIET_INSTALL, headers) \
 		$(call do_install,event-parse.h,$(prefix)/include/traceevent,644); \
 		$(call do_install,event-utils.h,$(prefix)/include/traceevent,644); \
+		$(call do_install,trace-seq.h,$(prefix)/include/traceevent,644); \
 		$(call do_install,kbuffer.h,$(prefix)/include/traceevent,644)
 
 install: install_lib
