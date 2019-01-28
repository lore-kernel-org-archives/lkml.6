Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7906C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A325E21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MGzaN4L3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfA1TV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:21:57 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34427 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfA1TVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:21:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190128192153euoutp0296c2b7b253ecdf41399be2c25cc5ee2d~_GXUx78Hh2449024490euoutp02n
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 19:21:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190128192153euoutp0296c2b7b253ecdf41399be2c25cc5ee2d~_GXUx78Hh2449024490euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548703313;
        bh=gwLpP+fJxTXiUYPFk84WkmAXe+Yg2TY9OIz8w3v3/E8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGzaN4L3mtSYiryYQ6L1uaU9vYg2Vk5v70ij+Ttqqvn93fc93mYWlgFbdtWlljYqY
         HG1fAilgByxfObLlMkFFGhhtBE62HocbQn3tQ3BHN6Lg1RKhgA4Le/WKEE/mL3Flk6
         Xz/mnp76H7ZVy7eSonpkLvnborq7I3FSIve6XR1s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190128192152eucas1p2c454e5d3852250b45f2d70d6fc92eb80~_GXT8bLp30030000300eucas1p2u;
        Mon, 28 Jan 2019 19:21:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 89.C5.04294.F465F4C5; Mon, 28
        Jan 2019 19:21:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96~_GXTFkPPE0392103921eucas1p1R;
        Mon, 28 Jan 2019 19:21:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190128192150eusmtrp195cadf4a98757e4452534a142e365988~_GXS23PRP2976329763eusmtrp1K;
        Mon, 28 Jan 2019 19:21:50 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-97-5c4f564f7f82
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.F8.04284.E465F4C5; Mon, 28
        Jan 2019 19:21:50 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190128192150eusmtip1b24278debb2da6af81d1826be48a127d~_GXSMyDbO0091700917eusmtip1Z;
        Mon, 28 Jan 2019 19:21:50 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date:   Mon, 28 Jan 2019 20:21:32 +0100
Message-Id: <1548703299-15806-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7r+Yf4xBlPuGFtsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7Ba3GmQsNj2+xmpxedccNosZ5/cxWSy9fpHJ4nbjCjaL1r1H2C0O
        v2lndeD1WDNvDaPHplWdbB6bl9R7HHy3h8mjb8sqRo/Pm+QC2KK4bFJSczLLUov07RK4MlZM
        X8FesFqw4sems8wNjHf4uhg5OSQETCS2nv/K1sXIxSEksIJR4sy934wQzhdGiZOvPrFAOJ8Z
        JdbcWM7excgB1jL5Jz9EfDmjxKHpc1hARoF1fP7GBFLDJqAnsWNVIUhYREBO4ubXu2AbmAVm
        M0tM3/WJDSQhLBAgMfvnDmYQm0VAVeL8rOdgcV4BL4mzh9azQJwH1HyuE6yGU8Bb4nTfArDr
        JAQWsUtM7TvJBnGQi8S+c1D1whKvjm9hh7BlJE5P7oGKF0uc7VjFBmHXSLSf3AFVYy1x+PhF
        VpAxzAKaEut36UOEHSXOz78P9S6fxI23giBhZiBz0rbpzBBhXomONiGIag2JLT0XmCBsMYnl
        a6ZBDfeQWDGpGRqC8xgl1r25wjSBUX4WwrIFjIyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLz
        czcxAhPM6X/Hv+xg3PUn6RCjAAejEg+vAZt/jBBrYllxZe4hRgkOZiUR3qnX/WKEeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1MLpdVjqZ2/DpoNz30Pef
        TiTbpm8PrHfQOC26/9uB80yPQr8tviq/Sfasa++B3b6TFN9L7a+OXhI7tfVLaX5325eHCUcv
        uYtal+yeflzhcBNz2dqdnJqLT8wS8vmWmfE94je/e929jxp1F6ZXXttnHhFiJrXyoWUl84c0
        HpeLNh9XqS2R8d7Sxq/EUpyRaKjFXFScCAAcucoxLAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t/xu7p+Yf4xBssXG1psnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7Ba3GmQsNj2+xmpxedccNosZ5/cxWSy9fpHJ4nbjCjaL1r1H2C0O
        v2lndeD1WDNvDaPHplWdbB6bl9R7HHy3h8mjb8sqRo/Pm+QC2KL0bIryS0tSFTLyi0tslaIN
        LYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MlZMX8FesFqw4sems8wNjHf4uhg5
        OCQETCQm/+TvYuTiEBJYyiixYs85xi5GTqC4mMSkfdvZIWxhiT/Xutggij4xSqz+MZMdpJlN
        QE9ix6pCkBoRATmJm1/vgtUwCyxnlpi79gIbSEJYwE/i2fQWVhCbRUBV4vys52BxXgEvibOH
        1rNALABqPtfJDGJzCnhLnO5bAHaEEFDN9MkvWCYw8i1gZFjFKJJaWpybnltsqFecmFtcmpeu
        l5yfu4kRGPTbjv3cvIPx0sbgQ4wCHIxKPLwGbP4xQqyJZcWVuYcYJTiYlUR4p173ixHiTUms
        rEotyo8vKs1JLT7EaAp01ERmKdHkfGBE5pXEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnN
        Tk0tSC2C6WPi4JRqYCw+YbvrvXWTqufrt2dvr1Xw199yen114o8DPS9eKn1+Y9XE1iu4cZVK
        oaLihJCgxnzhwwqiZx9dT36oU202wd97R01b58MZnp+kLszWf6YQv+prCO/fD/V3fx6sc3pu
        9HXBg8gQ+6KjHIqB+rb8rIeaj96MqJCXnRYqaemzS9fra6hB33wXeyWW4oxEQy3mouJEAHg2
        2n2QAgAA
X-CMS-MailID: 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new IDs for clocks used by Dynamic Memory Controller in
Exynos5422 SoC.

CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: linux-samsung-soc@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 355f469..1827a64 100644
--- a/include/dt-bindings/clock/exynos5420.h
+++ b/include/dt-bindings/clock/exynos5420.h
@@ -60,6 +60,7 @@
 #define CLK_MAU_EPLL		159
 #define CLK_SCLK_HSIC_12M	160
 #define CLK_SCLK_MPHY_IXTAL24	161
+#define CLK_SCLK_BPLL		162
 
 /* gate clocks */
 #define CLK_UART0		257
@@ -195,6 +196,16 @@
 #define CLK_ACLK432_CAM		518
 #define CLK_ACLK_FL1550_CAM	519
 #define CLK_ACLK550_CAM		520
+#define CLK_CLKM_PHY0		521
+#define CLK_CLKM_PHY1		522
+#define CLK_ACLK_PPMU_DREX0_0	523
+#define CLK_ACLK_PPMU_DREX0_1	524
+#define CLK_ACLK_PPMU_DREX1_0	525
+#define CLK_ACLK_PPMU_DREX1_1	526
+#define CLK_PCLK_PPMU_DREX0_0	527
+#define CLK_PCLK_PPMU_DREX0_1	528
+#define CLK_PCLK_PPMU_DREX1_0	529
+#define CLK_PCLK_PPMU_DREX1_1	530
 
 /* mux clocks */
 #define CLK_MOUT_HDMI		640
@@ -217,6 +228,10 @@
 #define CLK_MOUT_EPLL		657
 #define CLK_MOUT_MAU_EPLL	658
 #define CLK_MOUT_USER_MAU_EPLL	659
+#define CLK_MOUT_DPLL		660
+#define CLK_MOUT_ACLK_G3D	661
+#define CLK_MOUT_SCLK_SPLL	662
+#define CLK_MOUT_MX_MSPLL_CCORE_PHY	663
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
@@ -248,8 +263,9 @@
 #define CLK_DOUT_CCLK_DREX0	794
 #define CLK_DOUT_CLK2X_PHY0	795
 #define CLK_DOUT_PCLK_CORE_MEM	796
+#define CLK_FF_DOUT_SPLL2	797
 
 /* must be greater than maximal clock id */
-#define CLK_NR_CLKS		797
+#define CLK_NR_CLKS		798
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
-- 
2.7.4

