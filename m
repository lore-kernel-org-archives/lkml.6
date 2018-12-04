Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACACC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA3F20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srg0HPF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA3F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbeLDUyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:54:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36979 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLDUyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:54:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so10717957wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TIdz95ThPzutAt/0Gs1laVAbtjq4MULqHeE84zRq5M4=;
        b=Srg0HPF9yl1uMhsYa3XeqGIcyp4t8/Ltzhk2DGkBzpl0snuECUbhBQ6JAfiiz5BUFv
         kqGWRIk3WPlKkw5Ce547rtijE5yJFxbXZRqupm+43w4I8oOxIlbSgYW7opCfExjIYVWS
         Abt5Mlduh8EDmc9I7p2w6LGTH5Y1lrBqUNtdQgfyXi/sjPY39XI0hrybb5XnEO3zlzfE
         rUizDTQ10bC0CC+35MV2ZiMpyrxs0AXwe7S2Fc8NfsjdIRL5Y9NhNHV7GgHuZGxim5ds
         SEPEsYXstsXNWnhbz/l9CaAYspzHWqj7uGYWC7/7MGBsSN69KI6aXUO2ZANNeJWQVNs2
         cGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=TIdz95ThPzutAt/0Gs1laVAbtjq4MULqHeE84zRq5M4=;
        b=EhI9op6sl335dAgRESJqfVCwXWKE+gEjXzzVW0TATWQbnGy9DWrWGPFGPbr7Ci6W96
         NEX9g3qSnKFDwuClxWLsk5Ue3/NKdZMcG4k0P8bKbX4RND0hkuO+qtd3nL9WOWC5Rp1N
         VmA5NnA/jlMlH/OWCtRwzpP30ihJHojDuK8sEB9HmZIAARhjOcfPkGQHPWMs0j2/GNbv
         W47F9Zs+qpPH/e7GzQ91W8inprvRauwA4r4jUIqOKpyJ0TekcfswNpr6RkdxP/L2+eD6
         xP1M+qXiUOatYO/kx5ppHlyyBOLOrjZFMAZfCJG43lBnZOkRKgF284eqKD36PRHkON4w
         5r9g==
X-Gm-Message-State: AA+aEWaKY1CQnKfZj+6vxknUiYJ5tg3b1hAKdB7bsOL87tESvTydCLQ4
        ZdRbNmYH4aaa75oLVZpW0YvrBKi4
X-Google-Smtp-Source: AFSGD/UJkTIVQrq1HBP75IjCNFDKZmFdowtVuPrMDZmjrLIUNiXoZZDLOe9zF8k3wV8mEaamECMN+A==
X-Received: by 2002:a1c:35ca:: with SMTP id c193mr13421476wma.146.1543956840524;
        Tue, 04 Dec 2018 12:54:00 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id n127sm4074949wmd.20.2018.12.04.12.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 12:53:58 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id A71D21141016; Tue,  4 Dec 2018 21:53:51 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/32: Move the old 6xx -mcpu logic before the TARGET_CPU logic
Date:   Tue,  4 Dec 2018 21:53:45 +0100
Message-Id: <20181204205345.9514-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code:

  ifdef CONFIG_6xx
  KBUILD_CFLAGS          += -mcpu=powerpc
  endif

was added in 2006 in commit f48b8296b315 ("[PATCH] powerpc32: Set cpu
explicitly in kernel compiles"). This change was acceptable since the
TARGET_CPU logic was 64-bit only.

Since commit 0e00a8c9fd92 ("powerpc: Allow CPU selection
also on PPC32") this logic is no longer acceptable after the TARGET_CPU
specific. It currently appends -mcpu=powerpc at the end of the command
line, after any TARGET_CPU specific:

  gcc -Wp,-MD,init/.do_mounts.o.d ...
    -mcpu=powerpc -mbig-endian -m32 ...
    -mcpu=e300c2 ...
    -mcpu=powerpc ...
    ../init/do_mounts.c

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg142315.html
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8a2ce14d68d0..544b30667ea5 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -30,6 +30,10 @@ endif
 endif
 endif
 
+ifdef CONFIG_6xx
+KBUILD_CFLAGS		+= -mcpu=powerpc
+endif
+
 ifeq ($(CROSS_COMPILE),)
 KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
 else
@@ -241,10 +245,6 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)
 # often slow when they are implemented at all
 KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
 
-ifdef CONFIG_6xx
-KBUILD_CFLAGS		+= -mcpu=powerpc
-endif
-
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
-- 
2.19.2

