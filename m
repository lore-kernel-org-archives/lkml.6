Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751975AbeEDTHJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:07:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43000 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeEDTHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:07:03 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org,
        horms@verge.net.au, geert@linux-m68k.org, magnus.damm@gmail.com
Cc: f.fainelli@gmail.com, opendmb@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com
Subject: [PATCH v9 08/12] ARM: sun9i: smp: Rename clusters's power-off
Date: Fri,  4 May 2018 21:05:41 +0200
Message-Id: <20180504190545.5114-9-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504190545.5114-1-mylene.josserand@bootlin.com>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare the support for sun8i-a83t, rename the macro that handles
the power-off of clusters because it is different from sun9i-a80 to
sun8i-a83t.

The power off register for clusters are different from a80 and a83t.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/mc_smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 727968d6a3e5..03f021d0c73e 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -60,7 +60,7 @@
 #define PRCM_CPU_PO_RST_CTRL_CORE(n)	BIT(n)
 #define PRCM_CPU_PO_RST_CTRL_CORE_ALL	0xf
 #define PRCM_PWROFF_GATING_REG(c)	(0x100 + 0x4 * (c))
-#define PRCM_PWROFF_GATING_REG_CLUSTER	BIT(4)
+#define PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I	BIT(4)
 #define PRCM_PWROFF_GATING_REG_CORE(n)	BIT(n)
 #define PRCM_PWR_SWITCH_REG(c, cpu)	(0x140 + 0x10 * (c) + 0x4 * (cpu))
 #define PRCM_CPU_SOFT_ENTRY_REG		0x164
@@ -255,7 +255,7 @@ static int sunxi_cluster_powerup(unsigned int cluster)
 
 	/* clear cluster power gate */
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
-	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER;
+	reg &= ~PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
@@ -452,7 +452,7 @@ static int sunxi_cluster_powerdown(unsigned int cluster)
 	/* gate cluster power */
 	pr_debug("%s: gate cluster power\n", __func__);
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
-	reg |= PRCM_PWROFF_GATING_REG_CLUSTER;
+	reg |= PRCM_PWROFF_GATING_REG_CLUSTER_SUN9I;
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
-- 
2.11.0
