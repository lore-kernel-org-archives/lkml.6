Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033166AbeCAQ2I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:28:08 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46460 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032997AbeCAQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:28:06 -0500
X-Google-Smtp-Source: AG47ELsmSnlGLM5k8sPHl9bA5giSpxWx6/ax5B5PSTmXi53XCtk4H2Qp+FQu21XjQaRem/cBGwR2dQ==
From: Rob Herring <robh@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] arm64/efi: Make strrchr() available to the EFI namespace
Date: Thu,  1 Mar 2018 10:28:03 -0600
Message-Id: <20180301162803.5490-1-robh@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libfdt gained a new dependency on strrchr, so make it available to the
EFI namespace before we update libfdt.

Thanks to Ard for providing this fix.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack. This is a dependency on a dtc upstream sync.

 arch/arm64/kernel/image.h | 1 +
 arch/arm64/lib/strrchr.S  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index c7fcb232fe47..a820ed07fb80 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -103,6 +103,7 @@ __efistub_strlen		= KALLSYMS_HIDE(__pi_strlen);
 __efistub_strnlen		= KALLSYMS_HIDE(__pi_strnlen);
 __efistub_strcmp		= KALLSYMS_HIDE(__pi_strcmp);
 __efistub_strncmp		= KALLSYMS_HIDE(__pi_strncmp);
+__efistub_strrchr		= KALLSYMS_HIDE(__pi_strrchr);
 __efistub___flush_dcache_area	= KALLSYMS_HIDE(__pi___flush_dcache_area);
 
 #ifdef CONFIG_KASAN
diff --git a/arch/arm64/lib/strrchr.S b/arch/arm64/lib/strrchr.S
index 61eabd9a289a..f8e2784d5752 100644
--- a/arch/arm64/lib/strrchr.S
+++ b/arch/arm64/lib/strrchr.S
@@ -40,4 +40,4 @@ ENTRY(strrchr)
 	b	1b
 2:	mov	x0, x3
 	ret
-ENDPROC(strrchr)
+ENDPIPROC(strrchr)
-- 
2.14.1
