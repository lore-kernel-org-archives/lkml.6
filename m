Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeCOPPN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:15:13 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47149 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbeCOPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:15:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Shawn Guo <shawnguo@kernel.org>, arm@kernel.org
Cc: fabio.estevam@nxp.com, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Bai Ping <ping.bai@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: imx: fix imx6sll-only build
Date: Thu, 15 Mar 2018 16:13:18 +0100
Message-Id: <20180315151345.3089601-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:yLZ565dXxRWpUxP9bsY4S5IrI/NysgaIds+UZ6snNfOMrYWEpcF
 iclXIi0KoZuQRKEm8EvlW4ONgImixPR8Danu44BsNdYWRS7dJPs4hjqVxSYnOPY7Sjo4J3c
 Czy6pNis+uubffyGn8s5atOYDAFXi4wuxlyj8xP6o+ta2wvgs4qxqf2/rfin+4QczLBBZYD
 /QrMjmzQUskBNRuMRPN5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gys37sihMYU=:qM9wzLF75gVUDczQQLhbrn
 awG7HKXQe0uDEm24OkGnGpIcY0lPERoZQtJpL6JhLY0N3RFnYHJ1MLq7EdXM0uU5YqG6RDC2v
 BbnW7KzmOwT8etSrU/h4p/hKGuYiATXb5OU80A0uoYiXzc+DPb2jhRiRzxBdfNyPI8CtYEnHg
 Er8a62BPdd9lGJGHpubckJ3/0u2MRYfIXyWdSD0uNfaYGM9ZHyKGVy+964FwQGfQ8E6R50vid
 bnq2f8gBiYD+6suRy2SrfvGXHwvfGNemFhl6ak8nkeTZG/0Ic83WJInzfNxxcM6Ip7twR7w25
 4JRu/P23Hr1xiBHh4c/t32eqj85eN+5qPUJGMi/BEQozmDZ/GZJNlFrOVRnelZ1SoX0aSviEA
 fIdjRNcHDVGVyJDFp3ZhQOkWBa0EUTppCHPLRIfKFzOa0C0dQImDcZyq/c6BKB1AzwBF/I9r9
 LHwhgzHIksE2igoiwpnJ+ahRPgD8cOH4S0adb6Aw6VXTKhKkqmoXaYNMOieeR4K0Q2sjlNWOj
 cAxzuF/FXAHaO5uniwhSwfeImQWugaUh+r8+xBL8aQhX3rKsw6zpQaAqw6YGwF85J7PhLd/OG
 y2EaA1wEhcVotVa8KY1aU9vn0iRBGvodUvCblDrDufdePYpmBko6CoXCurTU06fd10XaasYRI
 iFygj99yHRvqAYznpHn97rk6GQdxa3q7EhqX9+RbXUmZNvA4jeVMCAFrgR9wTV0dlBIvAIruq
 z2wGzbJFpL24Y69uZnWoPn5a1N+OKvNkSxBZJQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When selecting SOC_IMX6SLL but not SOC_IMX6SL, we get a link error:

arch/arm/mach-imx/mach-imx6sl.o: In function `imx6sl_init_late':
mach-imx6sl.c:(.init.text+0x14): undefined reference to `imx6sl_cpuidle_init'

This adds the missing line to the Makefile to also build the cpuidle
support that we need here.

Fixes: dee5dee2a5b2 ("ARM: imx: Add basic msl support for imx6sll")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 78fa86aedf34..2327e3e876d8 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -26,6 +26,7 @@ ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
+obj-$(CONFIG_SOC_IMX6SLL) += cpuidle-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
 endif
-- 
2.9.0
