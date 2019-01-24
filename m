Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6701C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734B421855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fnYeYuFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfAXKsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:48:21 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:45475 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfAXKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:48:21 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x0OAlYSe031996;
        Thu, 24 Jan 2019 19:47:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x0OAlYSe031996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548326855;
        bh=r3JocOEABud7PU7j/ttJrZGazZrblFEHVX3UCSq7EbA=;
        h=From:To:Cc:Subject:Date:From;
        b=fnYeYuFm3zhkBuolZzAo0XBG+N5OmQJZJ5vUuxYPqFVUX8sm/RlNc2eVjpfTtI2gQ
         HaGLhWEC0Yxe93SFfZC6OigDbNx//b4Waeb4j1tdVbAbzmpuS82I49SqyyLq/uwTnv
         PvVTEnxazUEJWfzOi2FeyBMoTaLezFXRjt15bOQ3fL904rSlTINEMJ20w1EwEgR8ZX
         vzkDPYdMQDB27b5dHczEYya3jALeir1tQ6EI3wpp23iYOyaIIaQ5wNeLj9GKo7vf0L
         q5iT+oWmR2bqfhTwgcZEt0jnWx8ICfbnTKatERTYNCLdW+gfw+6moNsFhh1LpvCeEs
         AWXNBukAItjFQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: rename zconf.l to lexer.l
Date:   Thu, 24 Jan 2019 19:47:29 +0900
Message-Id: <1548326850-13660-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a more logcal name.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/Makefile             | 6 +++---
 scripts/kconfig/{zconf.l => lexer.l} | 0
 scripts/kconfig/lkc.h                | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename scripts/kconfig/{zconf.l => lexer.l} (100%)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 1819735..9278519 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -143,10 +143,10 @@ help:
 
 # ===========================================================================
 # object files used by all kconfig flavours
-common-objs	:= confdata.o expr.o symbol.o preprocess.o zconf.lex.o zconf.tab.o
+common-objs	:= confdata.o expr.o lexer.lex.o preprocess.o symbol.o zconf.tab.o
 
-$(obj)/zconf.lex.o: $(obj)/zconf.tab.h
-HOSTCFLAGS_zconf.lex.o	:= -I$(src)
+$(obj)/lexer.lex.o: $(obj)/zconf.tab.h
+HOSTCFLAGS_lexer.lex.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)
 
 # conf: Used for defconfig, oldconfig and related targets
diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/lexer.l
similarity index 100%
rename from scripts/kconfig/zconf.l
rename to scripts/kconfig/lexer.l
diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
index 531ff7c..d871539 100644
--- a/scripts/kconfig/lkc.h
+++ b/scripts/kconfig/lkc.h
@@ -90,7 +90,7 @@ void *xrealloc(void *p, size_t size);
 char *xstrdup(const char *s);
 char *xstrndup(const char *s, size_t n);
 
-/* zconf.l */
+/* lexer.l */
 int yylex(void);
 
 struct gstr {
-- 
2.7.4

