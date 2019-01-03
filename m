Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED3AC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F722070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfACNUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:20:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfACNUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:20:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DKgFa1385053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:20:42 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DKf1w1385050;
        Thu, 3 Jan 2019 05:20:41 -0800
Date:   Thu, 3 Jan 2019 05:20:41 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ad6b474f445e587e9b56ec44241b1639bccf6738@git.kernel.org>
Cc:     herton@redhat.com, tglx@linutronix.de, mmayer@broadcom.com,
        jolsa@kernel.org, computersforpeace@gmail.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
        hpa@zytor.com, rui.zhang@intel.com
Reply-To: rui.zhang@intel.com, hpa@zytor.com, mingo@kernel.org,
          acme@redhat.com, computersforpeace@gmail.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          mmayer@broadcom.com, herton@redhat.com, tglx@linutronix.de
In-Reply-To: <20181212102537.25902-3-jolsa@kernel.org>
References: <20181212102537.25902-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools thermal tmon: Allow overriding CFLAGS
 assignments
Git-Commit-ID: ad6b474f445e587e9b56ec44241b1639bccf6738
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

Commit-ID:  ad6b474f445e587e9b56ec44241b1639bccf6738
Gitweb:     https://git.kernel.org/tip/ad6b474f445e587e9b56ec44241b1639bccf6738
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 12 Dec 2018 11:25:33 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:08 -0300

tools thermal tmon: Allow overriding CFLAGS assignments

So that the user can provide, e.g. distro package alternative values.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Herton Krzesinski  <herton@redhat.com>
Cc: Markus Mayer <mmayer@broadcom.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Link: http://lkml.kernel.org/r/20181212102537.25902-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/thermal/tmon/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 735a510230c3..89a2444c1df2 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -6,13 +6,13 @@ VERSION = 1.0
 
 BINDIR=usr/bin
 WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
-CFLAGS+= -O1 ${WARNFLAGS}
+override CFLAGS+= -O1 ${WARNFLAGS}
 # Add "-fstack-protector" only if toolchain supports it.
-CFLAGS+= $(call cc-option,-fstack-protector)
+override CFLAGS+= $(call cc-option,-fstack-protector-strong)
 CC?= $(CROSS_COMPILE)gcc
 PKG_CONFIG?= pkg-config
 
-CFLAGS+=-D VERSION=\"$(VERSION)\"
+override CFLAGS+=-D VERSION=\"$(VERSION)\"
 LDFLAGS+=
 TARGET=tmon
 
@@ -29,7 +29,7 @@ TMON_LIBS += $(shell $(PKG_CONFIG) --libs $(STATIC) panelw ncursesw 2> /dev/null
 		     $(PKG_CONFIG) --libs $(STATIC) panel ncurses 2> /dev/null || \
 		     echo -lpanel -lncurses)
 
-CFLAGS    += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
+override CFLAGS += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /dev/null || \
 		     $(PKG_CONFIG) --cflags $(STATIC) panel ncurses 2> /dev/null)
 
 OBJS = tmon.o tui.o sysfs.o pid.o
