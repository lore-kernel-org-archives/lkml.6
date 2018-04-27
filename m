Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932635AbeD0NZj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:25:39 -0400
Received: from mail3.emtrion.de ([80.150.99.69]:54661 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932420AbeD0NZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:25:20 -0400
From: <jan.tuerk@emtrion.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        "GitAuthor: Jan Tuerk" <jan.tuerk@emtrion.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 7/7] ARM: imx_v6_v7_defconfig: Enable DA0963 PMIC support.
Date: Fri, 27 Apr 2018 15:24:42 +0200
Message-ID: <20180427132445.3458-8-jan.tuerk@emtrion.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180427132445.3458-1-jan.tuerk@emtrion.com>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-1-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-11.0.0.4283-8.100.1062-23808.007
X-TM-AS-Result: No--0.224800-8.000000-31
X-TM-AS-MatchedID: 701762-702358-704171-702898-703523-703720-701016-188019-7
        00624-148004-148036-42000-42003
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Tuerk <jan.tuerk@emtrion.com>

All recent emtrion modules based on i.mx6 make use of the DA0963.
Therefore enable it with the following defaults:
	- CONFIG_MFD_DA9063=y
	- CONFIG_REGULATOR_DA9063=y
	- CONFIG_DA9063_WATCHDOG=m
MFD and REGULATOR are built-in to have it at Kernel boot-time.
The WATCHDOG is optional and could be loaded from userspace.

Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 3a308437b088..691d431250d4 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -214,9 +214,11 @@ CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_DA9062_WATCHDOG=y
+CONFIG_DA9063_WATCHDOG=m
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_DA9052_I2C=y
 CONFIG_MFD_DA9062=y
+CONFIG_MFD_DA9063=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_STMPE=y
@@ -225,6 +227,7 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
 CONFIG_REGULATOR_DA9062=y
+CONFIG_REGULATOR_DA9063=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
-- 
2.11.0
