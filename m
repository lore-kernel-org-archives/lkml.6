Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCA1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19D4206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfFS9A+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19D4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeK2QlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:41:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46124 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeK2QlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 11:41:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so513997wrt.13;
        Wed, 28 Nov 2018 21:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1icVngiH04QS477xyYEnX7spvf9lvrlVrynIfHHKn+Y=;
        b=MfFS9A+50KEgBnfeoXpi/2xVAkYKu2RoIGprkyep1epGuWO9P9Elp5EY3LcprqoJS/
         iJ2sJ+ZZa7aMBAEP+3NAeRHLKUXPSKhLnxi2nJSTsCgW0JIsHKygwCRfVgnPgz9fflD/
         xeZRk7EZuOdDjfo2q90QZLVBCCL/7fRb6KUWjcIJeGROOE05Z2iP/rPrCKzWUxdgtNKN
         sQl5R2zlmPr30EaS8Jp6RgO6WS0c0B/bL/E5kWcisJoOguIPeLIQ1CYNNeJwf/60qg3r
         /+LG48/HIzuBNP84zXgvnk9qQei3qyM/A72oE/9ofs8n3o5210nIS0beqFTe1j9iOnWN
         SlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1icVngiH04QS477xyYEnX7spvf9lvrlVrynIfHHKn+Y=;
        b=ios+rZGvtLABU8/2snRWvZZZlpYAHHjHB/tuhKEbBbX8OjE4cHkHcCaO9m3k65FxcL
         uiBBjtGgRGS/YNfX1bBE2/SrDMMVi4QpjZ5reFbRy5t9Natih5FF0uRZnOQFx8RBJ5G0
         BOVkrcmOllRzDgz38hqXNClY1jlPDmTGN4tUrqGZzpoOcC4GYrulwN3az0zS0GxkYzXS
         Hkxbglav2jwDP5ECw9NGznhIK4IX748/46udrDXGSChKHJS3B1kFE63xE2YnFJtMCxbG
         2+LhpI8ZETh0nrRlaN1QPpMf/my6GmLPcxO480e+9VteWlYsNKZZH3gjAx9wFHMpDpck
         GTXQ==
X-Gm-Message-State: AA+aEWaSsFWXM8lZLD4w0Qt4C2RNDEUTHDyHRew7Uevj9gB1sG4RQm+E
        SIy/vxgfuRwthPwkLU621ow=
X-Google-Smtp-Source: AFSGD/VaTj7n+Vqs21CO7+MJ24ZTxjEYLCd6XblinwEV5Kn1RreL2k5CajmZTOq1SPrRUaSXABTBdg==
X-Received: by 2002:adf:8323:: with SMTP id 32mr98589wrd.176.1543469820932;
        Wed, 28 Nov 2018 21:37:00 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e8-v6sm2320053wmf.22.2018.11.28.21.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 21:37:00 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.14] kbuild: allow to use GCC toolchain not in Clang search path
Date:   Wed, 28 Nov 2018 22:35:12 -0700
Message-Id: <20181129053511.8016-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

commit ef8c4ed9db80261f397f0c0bf723684601ae3b52 upstream.

When using a GCC cross toolchain which is not in a compiled in
Clang search path, Clang reverts to the system assembler and
linker. This leads to assembler or linker errors, depending on
which tool is first used for a given architecture.

It seems that Clang is not searching $PATH for a matching
assembler or linker.

Make sure that Clang picks up the correct assembler or linker by
passing the cross compilers bin directory as search path.

This allows to use Clang provided by distributions with GCC
toolchains not in /usr/bin.

Link: https://github.com/ClangBuiltLinux/linux/issues/78
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-and-tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
[nc: Adjust context]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 874d72a3e6a7..cb131e135c42 100644
--- a/Makefile
+++ b/Makefile
@@ -480,13 +480,15 @@ endif
 ifeq ($(cc-name),clang)
 ifneq ($(CROSS_COMPILE),)
 CLANG_TARGET	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
-GCC_TOOLCHAIN	:= $(realpath $(dir $(shell which $(LD)))/..)
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
+CLANG_PREFIX	:= --prefix=$(GCC_TOOLCHAIN_DIR)
+GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
 ifneq ($(GCC_TOOLCHAIN),)
 CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
-KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
-KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
+KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
+KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
 KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
 KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 endif
-- 
2.20.0.rc1

