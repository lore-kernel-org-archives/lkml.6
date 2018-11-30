Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A08C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C11C20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C11C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeLAC4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbeLAC4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:56:32 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52705214DA;
        Fri, 30 Nov 2018 15:46:48 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gSl0B-0005zB-9f; Fri, 30 Nov 2018 10:46:47 -0500
Message-Id: <20181130154647.176265533@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 30 Nov 2018 10:44:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 3/9] tools/lib/traceevent: Install trace-seq.h API header file
References: <20181130154403.150474900@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch installs trace-seq.h header file on "make install".

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
-- 
2.19.1


