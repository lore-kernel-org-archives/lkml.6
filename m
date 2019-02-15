Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CBDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08D621934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmz7UbHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfBOBka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:40:30 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39454 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbfBOBka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:40:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so6674200edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 17:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uwCXhwiC/fPv5tuKoeJDhMs1VaHJk1Bz4OiYh196ZEI=;
        b=dmz7UbHpHt7I1SGc8Gs/EB6ga54A+68M5SljCar/19SNyBDCsu8+JuLZDU5A7T7amu
         uIZzrWB8cWyqpm1VeNkeZjmDRe0N6CvUezVXvAjCmX/X81ubQsGodB9e7ENf2PZFGhQ0
         L9RbPJ6kmT7ZOS2HyP1STiKnDQKMl9fISM6pjelNo3jgscYGnXzCt9rs3/gQZgyiKQaR
         R2FuFKSgMJtqPXdmhoFCzvFqM8GDrjVbWJvsHjrPrK7igAz6Mw+FtopIXwQ5KasX9uSU
         CdyGGEy+PjwVa76ugrhk6XhoJg7ha4XjyusyCy5ugk8uLq/ML+znPiZA5dGW2wAVhUtx
         WjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uwCXhwiC/fPv5tuKoeJDhMs1VaHJk1Bz4OiYh196ZEI=;
        b=LXBy3+jw3tRFHSbHcr9q8Rx9yquw5UUjhdTOzu+56hlmfCJgzRCgsXfkNceE06NPCv
         niWldfHTG9Hdl07s7sY0WaluySMM9OV6xQldBxxCtljaLsRvWUx0pQ9gi9OyUwAgeGVC
         vryRh1HoDlE9rHjhJED3cevULkJBNMMOFH+tRFNUq5ik17+6l12ZCfEjf/k18XsjHqRu
         FrK6akkYn9YD4pYus/x8z7O/lHTPjzLdn3SvdzpO/vXawfapFKDa6NA+27p0RBjtx5LD
         JlrtUYCFyBFEZ6VmfdzX2PbHIEqapiW7+lTyK1l1neQqAi25YWowSJOyhOrU7yhp1V5t
         jR3g==
X-Gm-Message-State: AHQUAuboVQjStA898Ti0j8rWdV4iSvbgY0amw1H0Enyw+CkZPZ8JCB3T
        Lr1nK6EquYeojucpQHV1ZgY=
X-Google-Smtp-Source: AHgI3IY6h1L+htqNpwMawWWiNbFCgqHnX2tvGsFZ3dowxODW0XHXL8DR9mBSTU+HUnawjSDXPWnzbw==
X-Received: by 2002:a50:a4ce:: with SMTP id x14mr5288893edb.229.1550194828224;
        Thu, 14 Feb 2019 17:40:28 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id l25sm1090247edr.45.2019.02.14.17.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 17:40:27 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when building with Clang
Date:   Thu, 14 Feb 2019 18:39:59 -0700
Message-Id: <20190215013959.21320-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit cc9f8349cb33 ("arm64: crypto: add NEON accelerated XOR
implementation"), Clang builds for arm64 started failing with the
following error message.

arch/arm64/lib/xor-neon.c:58:28: error: incompatible pointer types
assigning to 'const unsigned long *' from 'uint64_t *' (aka 'unsigned
long long *') [-Werror,-Wincompatible-pointer-types]
                v3 = veorq_u64(vld1q_u64(dp1 +  6), vld1q_u64(dp2 + 6));
                                         ^~~~~~~~
/usr/lib/llvm-9/lib/clang/9.0.0/include/arm_neon.h:7538:47: note:
expanded from macro 'vld1q_u64'
  __ret = (uint64x2_t) __builtin_neon_vld1q_v(__p0, 51); \
                                              ^~~~

There has been quite a bit of debate and triage that has gone into
figuring out what the proper fix is, viewable at the link below, which
is still ongoing. Ard suggested disabling this warning with Clang with a
pragma so no neon code will have this type of error. While this is not
at all an ideal solution, this build error is the only thing preventing
KernelCI from having successful arm64 defconfig and allmodconfig builds
on linux-next. Getting continuous integration running is more important
so new warnings/errors or boot failures can be caught and fixed quickly.

Link: https://github.com/ClangBuiltLinux/linux/issues/283
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm64/include/asm/neon-intrinsics.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/neon-intrinsics.h b/arch/arm64/include/asm/neon-intrinsics.h
index 2ba6c6b9541f..71abfc7612b2 100644
--- a/arch/arm64/include/asm/neon-intrinsics.h
+++ b/arch/arm64/include/asm/neon-intrinsics.h
@@ -36,4 +36,8 @@
 #include <arm_neon.h>
 #endif
 
+#ifdef CONFIG_CC_IS_CLANG
+#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
+#endif
+
 #endif /* __ASM_NEON_INTRINSICS_H */
-- 
2.21.0.rc1

