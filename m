Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8F0C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62C92171F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 21:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTFiE5ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbeLOVXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 16:23:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33432 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeLOVXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 16:23:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so1756759wmh.0;
        Sat, 15 Dec 2018 13:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbAhpvg6Y90F4G+K9k9yPIb45r9KUwGWnfc1MZxSrNc=;
        b=iTFiE5httGBQlhhpliqzt6RIalaGvHQ5HnZofy8KSyfiTQ0sCCNcKYtAS8OP6HWEW8
         RXOiiLyHRArYHwhh3usoK/8vHb6dk8S677sDGsb0CU/asDU/tWFYiloHE5VJQdAhyU+h
         3d/ljZ3QXBl2SW5hSLWj09OfZM3PqWz5P6jusr9WLL0OQ0rB+uAQYJs+Z4U+1HJb8l3b
         yYeYPlkEo7djmBLTugI4OHR15zGGo9kwrAT3IYEHzrqHJc/2SmH6ecWsdmHRX4Do6f54
         cbTmcQ9C2VOhFubPw/Dy6CaicGR1qZU0dRf7kWRGQZ3Yfff59miOF1WoKwfH4RGaQCUr
         d5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbAhpvg6Y90F4G+K9k9yPIb45r9KUwGWnfc1MZxSrNc=;
        b=h+FJhZPO1w2cHwENwolGr1UKicvNLS0ynLSAkuxNvDFhloyh8/KKMX7wpPVNat7Ytc
         4/4TkLhVsFWchEVzUEvoSO+MgJH5svHy+5jPmQYjjkPE+tEjBGml8uMBPQ5N9xkxNMHL
         C5brxSne7P/pXxkuhhm2FjGGFt1kuqQrQbWwJeuJJaf+QNHgYXte2PidCvw80Tyl8htn
         TwqVY4DiQu8YjDr4vlCN7wgIf69Fupzd2KNzxPrHpojzRHCdufmuTTX7w/17mr2B+frz
         edIDkq1HaGpU/NyLbMLga3Bc6hfyeE4g/P4oRZWXJVVrDetw2G9P3nEjF6vAWHBWzd9V
         Wfvw==
X-Gm-Message-State: AA+aEWYXgf5yaaP36xRcceWs7FX7QAmMJrpNLIyCJMFDgzuRuUDP+Fxw
        AkjlnFMnoldrRpQBsTopNGU=
X-Google-Smtp-Source: AFSGD/U3GYHJ9vxsTjxnGM7T3sn2bzE1kafvlQQ04JR0u107A64ZkisPzmBUsMpKFXH5WNRtUWxyRQ==
X-Received: by 2002:a1c:c10f:: with SMTP id r15mr7163001wmf.27.1544909011793;
        Sat, 15 Dec 2018 13:23:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id o8sm9889931wrx.15.2018.12.15.13.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 13:23:31 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tri Vo <trong@android.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ARM: Ensure that NEON code always compiles with Clang
Date:   Sat, 15 Dec 2018 14:23:05 -0700
Message-Id: <20181215212304.19390-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While building arm32 allyesconfig, I ran into the following errors:

  arch/arm/lib/xor-neon.c:17:2: error: You should compile this file with
  '-mfloat-abi=softfp -mfpu=neon'

  In file included from lib/raid6/neon1.c:27:
  /home/nathan/cbl/prebuilt/lib/clang/8.0.0/include/arm_neon.h:28:2:
  error: "NEON support not enabled"

Building V=1 showed NEON_FLAGS getting passed along to Clang but
__ARM_NEON__ was not getting defined. Ultimately, it boils down to Clang
only defining __ARM_NEON__ when targeting armv7, rather than armv6k,
which is the '-march' value for allyesconfig.

From lib/Basic/Targets/ARM.cpp in the Clang source:

  // This only gets set when Neon instructions are actually available, unlike
  // the VFP define, hence the soft float and arch check. This is subtly
  // different from gcc, we follow the intent which was that it should be set
  // when Neon instructions are actually available.
  if ((FPU & NeonFPU) && !SoftFloat && ArchVersion >= 7) {
    Builder.defineMacro("__ARM_NEON", "1");
    Builder.defineMacro("__ARM_NEON__");
    // current AArch32 NEON implementations do not support double-precision
    // floating-point even when it is present in VFP.
    Builder.defineMacro("__ARM_NEON_FP",
                        "0x" + Twine::utohexstr(HW_FP & ~HW_FP_DP));
  }

Ard Biesheuvel recommended explicitly adding '-march=armv7-a' at the
beginning of the NEON_FLAGS definitions so that __ARM_NEON__ always gets
definined by Clang. This doesn't functionally change anything because
that code will only run where NEON is supported, which is implicitly
armv7.

Link: https://github.com/ClangBuiltLinux/linux/issues/287
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 Documentation/arm/kernel_mode_neon.txt | 4 ++--
 arch/arm/lib/Makefile                  | 2 +-
 arch/arm/lib/xor-neon.c                | 2 +-
 lib/raid6/Makefile                     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/arm/kernel_mode_neon.txt b/Documentation/arm/kernel_mode_neon.txt
index 525452726d31..b9e060c5b61e 100644
--- a/Documentation/arm/kernel_mode_neon.txt
+++ b/Documentation/arm/kernel_mode_neon.txt
@@ -6,7 +6,7 @@ TL;DR summary
 * Use only NEON instructions, or VFP instructions that don't rely on support
   code
 * Isolate your NEON code in a separate compilation unit, and compile it with
-  '-mfpu=neon -mfloat-abi=softfp'
+  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp'
 * Put kernel_neon_begin() and kernel_neon_end() calls around the calls into your
   NEON code
 * Don't sleep in your NEON code, and be aware that it will be executed with
@@ -87,7 +87,7 @@ instructions appearing in unexpected places if no special care is taken.
 Therefore, the recommended and only supported way of using NEON/VFP in the
 kernel is by adhering to the following rules:
 * isolate the NEON code in a separate compilation unit and compile it with
-  '-mfpu=neon -mfloat-abi=softfp';
+  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp';
 * issue the calls to kernel_neon_begin(), kernel_neon_end() as well as the calls
   into the unit containing the NEON code from a compilation unit which is *not*
   built with the GCC flag '-mfpu=neon' set.
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index ad25fd1872c7..0bff0176db2c 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -39,7 +39,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-  NEON_FLAGS			:= -mfloat-abi=softfp -mfpu=neon
+  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
   CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index a6741a895189..4600b62d845f 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -14,7 +14,7 @@
 MODULE_LICENSE("GPL");
 
 #ifndef __ARM_NEON__
-#error You should compile this file with '-mfloat-abi=softfp -mfpu=neon'
+#error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
 #endif
 
 /*
diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 2f8b61dfd9b0..bfec7c87c61e 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -25,7 +25,7 @@ endif
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
 NEON_FLAGS := -ffreestanding
 ifeq ($(ARCH),arm)
-NEON_FLAGS += -mfloat-abi=softfp -mfpu=neon
+NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
 endif
 CFLAGS_recov_neon_inner.o += $(NEON_FLAGS)
 ifeq ($(ARCH),arm64)
-- 
2.20.1

