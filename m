Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62664C282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DB2218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 04:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+bujeUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfAZEHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 23:07:01 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43063 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfAZEHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 23:07:00 -0500
Received: by mail-ed1-f67.google.com with SMTP id f9so8895879eds.10;
        Fri, 25 Jan 2019 20:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzGp4f5mj60UhOCZqN/eEORXWRoInqsbZGO2akYdCy0=;
        b=h+bujeUeE17D0y8QwbvANrZPFPrItuMxLv41QWHuHQe7jZxsqQoTg/QafkQp36HV8W
         r3ndwX/etR3BfSi/GkeCpKUx4ABXQ1JT74yW7aozIImuFau803R/L+J9jOGtusMEz5Pi
         Qfh95S2bYYTyy9JrT2TpZdYiAgsgbhrRNMvx602yVwUAvbM5/9qBq4TZKybXm4KBVU8X
         mIC720jVoOn/UhPRuwKPZijb4Pjpao1qToD7j4hs/cu5nuFZ5t/vW5EUhjx/eCoS4w14
         wnGMegSGGNqHcjALkFIOotIHGUoHiqcz0p7dQAMMxTH2MdbV7I4bj5hrHQavAs/LyK5K
         9uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzGp4f5mj60UhOCZqN/eEORXWRoInqsbZGO2akYdCy0=;
        b=eoVFFPvNo35CkPx9X0165LafH6aPGURgE5IqsdSRwYKBjXNJMgskmRsoNco9ARPGF7
         kfi1PzxOj9irEP4hhdJe4SGYsjz+JNeeUBUcZfyKTh111m9LJ9Wo6sHEhVsPY6fCWlwi
         lM4PBywYcK8tWZ7zB+OD0VWqJpsMC6dGCAgJj3ouO7kRMfCP6wouby5cCiGNy5aI0cxt
         aR7cl/C16oqVbPN8qdLSjPnfBiZTzsNqZPW8PsgUS7NixKmHAzPcJkaRQroBXnEbgvu7
         SBqdhJJm7U5qA1i9bgHx4c/aRnRHmvkXyk6nB2QSArfRuzcGxTB/PV04hFX+7BukhqSd
         wPZQ==
X-Gm-Message-State: AJcUukdXgcQl+M4vGOtKQiWWlNOYOqDU2J4JmUTd9WVAYfCWPuSLpbiZ
        YBI5pHiv2Fo64+FHRfDhqR2ROo8tpY+6NQ==
X-Google-Smtp-Source: ALg8bN53xR6ipP+cZObsAMMommYUAv3P6GEQwW2RXGorZmvuAPPXcmhaLuts5aIImEo5svuz/9oCNw==
X-Received: by 2002:a50:8863:: with SMTP id c32mr12583176edc.156.1548475618118;
        Fri, 25 Jan 2019 20:06:58 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id s46sm12047978edd.9.2019.01.25.20.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 20:06:57 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tri Vo <trong@android.com>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nicolas Pitre <nico@linaro.org>
Subject: [PATCH RESEND] ARM: Ensure that NEON code always compiles with Clang
Date:   Fri, 25 Jan 2019 21:01:13 -0700
Message-Id: <20190126040111.9013-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181215212304.19390-1-natechancellor@gmail.com>
References: <20181215212304.19390-1-natechancellor@gmail.com>
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

>From lib/Basic/Targets/ARM.cpp in the Clang source:

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
Acked-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

Resending with Nicolas's ack and Nick's review, to give others a chance
to pitch in with review/testing before submitting it to the patch
system (specifically Stefan, sorry I should have included you in the
previous posting).

With this patch and:
* A tip of tree LLVM build (I used apt.llvm.org)
* Clang GCOV support: https://lore.kernel.org/lkml/20190122233749.42220-1-trong@android.com/
* Two minor hacks for unrelated issues that are still being worked through:
  * https://raw.githubusercontent.com/nathanchance/patches/c313b2fa0efb/linux/build-hax/0003-DO-NOT-UPSTREAM-ARM-Don-t-select-HAVE_FUNCTION_TRACE.patch (see https://github.com/ClangBuiltLinux/linux/issues/35)
  * https://gist.githubusercontent.com/nathanchance/b2f5a4015abade1a41e78d5fc3235c5b/raw/744321882ab05511331f26896bad7c9f0056a6a5/gistfile1.txt (see https://github.com/ClangBuiltLinux/linux/issues/325)

I can build and link a little endian allyesconfig ARM kernel. This
patch alone works with GCC 8.2.0 and binutils 2.31.1.

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
index 2c40aeab3eaa..c691b901092f 100644
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
index 4e90d443d1b0..e723eacf7868 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -39,7 +39,7 @@ endif
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

