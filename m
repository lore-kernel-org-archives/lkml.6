Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05A5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9DD2177E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550511235;
	bh=lK+JHr7EO0NyLhpmUHMOKSsymoC78ioH0CGzMJHmkDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AUKDdBI+8PVpV31YMm2zL1u2a3gnqOdg3ER2jE/BtL5A4aH0+bvHfl9GtHI173oeV
	 AxhgTvPhNRHCpqP3jyV111Kbin5TiqgqSga07yvPvQxxopiSdhp0WnErtRS3AAamQ7
	 HSGKMVapDw+kw1VU072IPRw87EezWn3rSqACpjvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbfBRRdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388519AbfBRRdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:33:49 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F24F42177E;
        Mon, 18 Feb 2019 17:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550511229;
        bh=lK+JHr7EO0NyLhpmUHMOKSsymoC78ioH0CGzMJHmkDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xAq2P3DPn+Y2Fbda6cAhas0pnMDZmtoqu+WL503tCX3dz8s9VnDtZSqXlTkNjzOgM
         8i15G6qEunRwuTsI4TfScK0YJkJyHIE5kpYEbawYVJLRQwqiCwSgggVx0Utx1sul5m
         cUVy5e8Sd2/1LNVlh160gfM6EMBdYL3MwH2E7eME=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Markus Reichl <reichl@t-online.de>
Subject: [PATCH 3/3] ARM: dts: exynos: Raise maximum buck regulator voltages on Arndale Octa
Date:   Mon, 18 Feb 2019 18:32:58 +0100
Message-Id: <20190218173258.7071-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218173258.7071-1-krzk@kernel.org>
References: <20190218173258.7071-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raise the buck 1-7 regulators voltages to allow cpufreq choosing them
and to fix warnings during boot:

    core: _opp_supported_by_regulators: OPP minuV: 1250000 maxuV: 1250000, not supported by regulator
    cpu cpu0: _opp_add: OPP not supported by regulators (1800000000)

The maximum value is now in sync with other Exynos5420 boards with
S2MPS11 PMIC (SMDK5420, Odroid XU3 family).  This also matches the
values used in old patches done by Linaro Samsung team.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 308c74ebeacd..c7d9604a119e 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -342,48 +342,48 @@
 			buck1_reg: BUCK1 {
 				regulator-name = "PVDD_MIF_1V1";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1100000>;
+				regulator-max-microvolt = <1300000>;
 				regulator-always-on;
 			};
 
 			buck2_reg: BUCK2 {
 				regulator-name = "vdd_arm";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
 
 			buck3_reg: BUCK3 {
 				regulator-name = "PVDD_INT_1V0";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-max-microvolt = <1400000>;
 				regulator-always-on;
 			};
 
 			buck4_reg: BUCK4 {
 				regulator-name = "PVDD_G3D_1V0";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-max-microvolt = <1400000>;
 			};
 
 			buck5_reg: BUCK5 {
 				regulator-name = "PVDD_LPDDR3_1V2";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1200000>;
+				regulator-max-microvolt = <1400000>;
 				regulator-always-on;
 			};
 
 			buck6_reg: BUCK6 {
 				regulator-name = "PVDD_KFC_1V0";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1000000>;
+				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
 
 			buck7_reg: BUCK7 {
 				regulator-name = "VIN_LLDO_1V4";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1400000>;
+				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
 
-- 
2.17.1

