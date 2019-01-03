Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233EBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E812121871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519643;
	bh=usmTxOzty+CWSWHhUun2cUdXmXfzhu6LUFdjHQIKjZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XlVKNmyfswiXyT/IMBib8stnyRJD7Q8YePSlIiq2NkABG5PPMq2UjIfLPxNcEXjiK
	 yQcnJUNJ/wAbHZzYUZkIcbJOP7hEDoV9lGBEFK64QtExMSk2KwvuN8P66gclNUhkBr
	 1yyEYvmqXw2nUCVT2pcHPkBgD79dvJT3yYHoFXoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfACMrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731536AbfACMrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:18 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D0D2184B;
        Thu,  3 Jan 2019 12:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519638;
        bh=usmTxOzty+CWSWHhUun2cUdXmXfzhu6LUFdjHQIKjZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2qX7GKalR/kzI2S0BPU55OO3j74GndeQJ9XrOM27fzfoloVqzvQGVGH4VYdQLLngR
         as+v2cUEV+Z1eYrOKlsOpJSsLtkxeUQUp9Xwbfiq2/QQ9ApDmbTt8Da3YlvG+nl8Ad
         9EFOpr/N8l/r12megEpN64McAceKTwRxPN6EMqXw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Herton Krzesinski <herton@redhat.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/29] tools thermal tmon: Allow overriding CFLAGS assignments
Date:   Thu,  3 Jan 2019 09:45:59 -0300
Message-Id: <20190103124609.29672-20-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.19.2

