Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85889C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAB42080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 08:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="PJHiINlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAB42080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeLNIGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 03:06:15 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:28079 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeLNIGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 03:06:14 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wBE85gQU007194;
        Fri, 14 Dec 2018 17:05:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wBE85gQU007194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544774744;
        bh=eeLM3yACvMlm4qQoSUGrytPeIoGakC/t2YMNbBYPQoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJHiINlb+62e7Kp1CNGERxt0eQy2NFM8igUhXRJTBeoJHQNzySzDYvBvZTrGTaUIU
         Ec76Uy9tsDYBFx6IisQZ8dbC1rac+VJzOkcIIinktPAw2QquJiugWcUmsbBmfBzgTf
         51Vg/8J6ffS4WiFM9+d5tvyBMy7jAq8ddlPJZeIWfKgeFOTclI31ZdqYHtriSNSJSt
         6YjviPDtV9TUCqOAKDOxKx7qytOpoxI8O56rRoh0she/AGpRbW+e8pqHsT5Nb8piwj
         cdK/wIPnYzSfwRbzgKOy28Y8sE4aFcH3zget/lWjNO1YFoOWt+A9x6WPiLohlS8FzY
         SnpNi519uv0WA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kbuild: add -Werror=implicit-int flag unconditionally
Date:   Fri, 14 Dec 2018 17:05:39 +0900
Message-Id: <1544774739-13471-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544774739-13471-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544774739-13471-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag is documented in the GCC 4.6 manual, and recognized by
Clang as well. Let's rip off the cc-option switch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index bcb943e..b63699b 100644
--- a/Makefile
+++ b/Makefile
@@ -425,7 +425,7 @@ LINUXINCLUDE    := \
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
 KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
-		   -Werror-implicit-function-declaration \
+		   -Werror-implicit-function-declaration -Werror=implicit-int \
 		   -Wno-format-security \
 		   -std=gnu89
 KBUILD_CPPFLAGS := -D__KERNEL__
@@ -825,9 +825,6 @@ KBUILD_CFLAGS  += $(call cc-option,-fno-stack-check,)
 # conserve stack if available
 KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
 
-# disallow errors like 'EXPORT_GPL(foo);' with missing header
-KBUILD_CFLAGS   += $(call cc-option,-Werror=implicit-int)
-
 # Prohibit date/time macros, which would make the build non-deterministic
 KBUILD_CFLAGS   += $(call cc-option,-Werror=date-time)
 
-- 
2.7.4

