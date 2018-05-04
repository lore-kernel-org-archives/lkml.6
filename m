Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbeEDTGw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:06:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42925 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751646AbeEDTGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:06:49 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
        horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com
Cc: f.fainelli@gmail.com, opendmb@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com
Subject: [PATCH v9 01/12] ARM: Allow this header to be included by assembly files
Date: Fri,  4 May 2018 21:05:34 +0200
Message-Id: <20180504190545.5114-2-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504190545.5114-1-mylene.josserand@bootlin.com>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

The constants defined in this file are equally useful in assembly and C
source files. The arm64 architecture version of this file allows
inclusion in both assembly and C source files, so this this commit adds
that capability to the arm architecture version so that the constants
don't need to be defined in multiple places.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/include/asm/cputype.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb546425da8a..e7632f536633 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -2,9 +2,6 @@
 #ifndef __ASM_ARM_CPUTYPE_H
 #define __ASM_ARM_CPUTYPE_H
 
-#include <linux/stringify.h>
-#include <linux/kernel.h>
-
 #define CPUID_ID	0
 #define CPUID_CACHETYPE	1
 #define CPUID_TCM	2
@@ -98,6 +95,11 @@
 /* Qualcomm implemented cores */
 #define ARM_CPU_PART_SCORPION		0x510002d0
 
+#ifndef __ASSEMBLY__
+
+#include <linux/stringify.h>
+#include <linux/kernel.h>
+
 extern unsigned int processor_id;
 
 #ifdef CONFIG_CPU_CP15
@@ -326,4 +328,6 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
 #define cpuid_feature_extract(reg, field) \
 	cpuid_feature_extract_field(read_cpuid_ext(reg), field)
 
+#endif /* __ASSEMBLY__ */
+
 #endif
-- 
2.11.0
