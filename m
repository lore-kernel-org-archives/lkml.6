Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755966AbeCHPAd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:00:33 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:47234 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752093AbeCHPA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:00:28 -0500
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Mylene Josserand <mylene.josserand@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/4] ARM: sunxi: mc-smp: Fix "lookback" typo
Date: Thu,  8 Mar 2018 23:00:09 +0800
Message-Id: <20180308150012.19045-2-wens@csie.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180308150012.19045-1-wens@csie.org>
References: <20180308150012.19045-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sunxi_mc_smp_lookback function is modeled after the mcpm_loopback
function in the MCPM framework. "lookback" was a typo introduced when
the new function was added.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/mach-sunxi/mc_smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 11e46c6efb90..9db6c4ed5861 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -659,7 +659,7 @@ static int __init nocache_trampoline(unsigned long __unused)
 	BUG();
 }
 
-static int __init sunxi_mc_smp_lookback(void)
+static int __init sunxi_mc_smp_loopback(void)
 {
 	int ret;
 
@@ -749,7 +749,7 @@ static int __init sunxi_mc_smp_init(void)
 	}
 
 	/* Configure CCI-400 for boot cluster */
-	ret = sunxi_mc_smp_lookback();
+	ret = sunxi_mc_smp_loopback();
 	if (ret) {
 		pr_err("%s: failed to configure boot cluster: %d\n",
 		       __func__, ret);
-- 
2.16.2
