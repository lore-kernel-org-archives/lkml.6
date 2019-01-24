Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A09C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE1C21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wHNJrb3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfAXKsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:48:22 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:45474 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfAXKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:48:21 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x0OAlYSf031996;
        Thu, 24 Jan 2019 19:47:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x0OAlYSf031996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548326856;
        bh=Bx6qUIZBuAikzmub06CqL/wi+fGcjYmAgLf/mU0X/2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wHNJrb3jqQFVpkiJ5P9ZXKMPMtOMw7kU7CLbMOK63ZfC7FJargkc4JiIzKh6sfSY7
         TOIGp1IBEslGTPsPTbRMXu4qw5tVCsMP1Sc8KlzptlA+/LZuQKAtMYuoPV2ZB7RwJ8
         zYIPOyvelc137iwqCaOv9jQXdSkrBL4ZIF1Izum0FeOVHBN/PAikiGF1dFMGELhSGj
         aRfz+PIPAeGxa0lK1d0JYXHH2fLqlw8ttkFGMA0vXPezsazoEQiGP7X2Osb7JJDH/z
         56W+HVs5sBNFPZziJnjD6mfHViN7xaL5ae6ZPoxEN20IhHqojXdUbzP5AtDLGOkjcX
         pSpH4XN6ZSjLg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kconfig: rename zconf.y to parser.y
Date:   Thu, 24 Jan 2019 19:47:30 +0900
Message-Id: <1548326850-13660-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548326850-13660-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548326850-13660-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a more logical name.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/Makefile              | 7 ++++---
 scripts/kconfig/expr.h                | 2 +-
 scripts/kconfig/lexer.l               | 2 +-
 scripts/kconfig/{zconf.y => parser.y} | 0
 4 files changed, 6 insertions(+), 5 deletions(-)
 rename scripts/kconfig/{zconf.y => parser.y} (100%)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 9278519..7c5dc31 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -143,11 +143,12 @@ help:
 
 # ===========================================================================
 # object files used by all kconfig flavours
-common-objs	:= confdata.o expr.o lexer.lex.o preprocess.o symbol.o zconf.tab.o
+common-objs	:= confdata.o expr.o lexer.lex.o parser.tab.o preprocess.o \
+		   symbol.o
 
-$(obj)/lexer.lex.o: $(obj)/zconf.tab.h
+$(obj)/lexer.lex.o: $(obj)/parser.tab.h
 HOSTCFLAGS_lexer.lex.o	:= -I$(src)
-HOSTCFLAGS_zconf.tab.o	:= -I$(src)
+HOSTCFLAGS_parser.tab.o	:= -I$(src)
 
 # conf: Used for defconfig, oldconfig and related targets
 hostprogs-y	+= conf
diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
index 999edb6..8dde65bc 100644
--- a/scripts/kconfig/expr.h
+++ b/scripts/kconfig/expr.h
@@ -172,7 +172,7 @@ struct symbol {
  *         int "BAZ Value"
  *         range 1..255
  *
- * Please, also check zconf.y:print_symbol() when modifying the
+ * Please, also check parser.y:print_symbol() when modifying the
  * list of property types!
  */
 enum prop_type {
diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index b2d0a3b..c9df1c8 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -15,7 +15,7 @@
 #include <unistd.h>
 
 #include "lkc.h"
-#include "zconf.tab.h"
+#include "parser.tab.h"
 
 #define YY_DECL		static int yylex1(void)
 
diff --git a/scripts/kconfig/zconf.y b/scripts/kconfig/parser.y
similarity index 100%
rename from scripts/kconfig/zconf.y
rename to scripts/kconfig/parser.y
-- 
2.7.4

