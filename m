Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeCUOxh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:53:37 -0400
Received: from forward100p.mail.yandex.net ([77.88.28.100]:47314 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752283AbeCUOxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:53:33 -0400
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: jhogan@kernel.org
Cc: chenhc@lemote.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/2] MIPS: Loongson64: Define has_cpu_mips64r2_user for Loongson-3
Date: Wed, 21 Mar 2018 22:53:04 +0800
Message-Id: <20180321145304.4639-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321145304.4639-1-jiaxun.yang@flygoat.com>
References: <20180321145304.4639-1-jiaxun.yang@flygoat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All loongson-3 processors support mips64r2 usermode instructions.
However 3A1000 3B1000 3B1500 should be treated as mips64r1 in kernel.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index 581915ce231c..71c893249374 100644
--- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
@@ -49,6 +49,7 @@
 #define cpu_has_wsbh		1
 #define cpu_has_ic_fills_f_dc	1
 #define cpu_hwrena_impl_bits	0xc0000000
+#define cpu_has_mips64r2_user  1
 #endif
 
 #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
-- 
2.16.2
