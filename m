Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C617EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C05E2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CeiJdPVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbfAaIuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:50:23 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50886 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfAaIuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:50:14 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190131085011euoutp0247bbc482692fdf5a8ad8ef2c97b7033a~_4rpNnuRF1222712227euoutp02N
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:50:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190131085011euoutp0247bbc482692fdf5a8ad8ef2c97b7033a~_4rpNnuRF1222712227euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548924611;
        bh=XVrdznC9/bIOdsyRV9OXRLLPGrvIyAuOW9k2HCowRn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CeiJdPVcnZHSM6W66Dtc5KZT8qE1RTG5cDcP0Qi64DyI3dt40g8v4eI2p1x8EsqGZ
         WaAbbX+R/mdcXLTz4cQskEmHVclwo5lWrUUc46JmNhZi3cToj0UcCZWdBtVFI+rm/2
         8vU1u+lMNzr0WRhkxOJ0V8iyHuzT1P17w05SaALI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190131085010eucas1p2b5dfedbaedccd7955093976e76035c79~_4roaKDUh2510125101eucas1p2g;
        Thu, 31 Jan 2019 08:50:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 38.1E.04806.2C6B25C5; Thu, 31
        Jan 2019 08:50:10 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190131085009eucas1p166467551006e54130905ebb5eefdefab~_4rnl3Bf22043220432eucas1p17;
        Thu, 31 Jan 2019 08:50:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190131085009eusmtrp2b9c31be1a20e30fca7bb74b754bd8b8d~_4rnOJFzf2341223412eusmtrp2g;
        Thu, 31 Jan 2019 08:50:09 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-69-5c52b6c23b29
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 79.7B.04128.1C6B25C5; Thu, 31
        Jan 2019 08:50:09 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190131085008eusmtip1fcaf91eaa9cac085b93ead996dd5f330~_4rmghq181145511455eusmtip16;
        Thu, 31 Jan 2019 08:50:08 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 6/8] DT: arm: exynos: add DMC device for exynos5422
Date:   Thu, 31 Jan 2019 09:49:52 +0100
Message-Id: <1548924594-19084-7-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djPc7qHtgXFGLx5LmexccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzuog4LFm3hpGj02rOtk8Ni+p9zj4bg+TR9+WVYwenzfJBbBF
        cdmkpOZklqUW6dslcGU8m7yNtWCFQsWzDc/YGxi7JbsYOTgkBEwk/ky37WLk4hASWMEo8Xrb
        ViYI5wujxLo/v1ghnM+MEqv/b2XrYuQE6/h6dhobRGI5o8T7mR2scC0HOg+zgcxlE9CT2LGq
        EKRBRKBa4s71/cwgNcwCd5gk9s5cygKSEBZwk/h2Yg/YVBYBVYmP9yazgti8Al4S05dOY4XY
        Jidx81wnM4jNKeAtsaTrL9ggCYFt7BJ7L9xlgnjCRWJifxVEvbDEq+Nb2CFsGYn/O+czQdjF
        Emc7VkF9UCPRfnIHVI21xOHjF1lBxjALaEqs36UPEXaUmL3tDDPEdD6JG28FQcLMQOakbdOh
        wrwSHW1CENUaElt6LkAtEpNYvmYa1HAPiRnr7kCDah6jxMqfbawTGOVnISxbwMi4ilE8tbQ4
        Nz212DgvtVyvODG3uDQvXS85P3cTIzABnf53/OsOxn1/kg4xCnAwKvHwPlgbGCPEmlhWXJl7
        iFGCg1lJhNfwt3+MEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkm
        Dk6pBka5m9tvd79wuCYawGP8mteLY+fJ7+a7P5ud+q5rPp9t8rPcS4HqjTobH+3yfPnh9qlU
        runRCafKt/6Kn/XXwSTp7rkNx/xjzdSZxBfNfHggbR7Hwub2RpW7l1j/TqwyyP4x55rIj36h
        vHs5exlMog+WyZ1MsldqVtox8XtE4DVOv7d1Z4LXrRdUYinOSDTUYi4qTgQAvx2d2zwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Xd2D24JiDBb0SllsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XlXXPYLD73HmG0mHF+H5PF2iN32S2W
        Xr/IZHG7cQWbReveI+wWh9+0szoIeKyZt4bRY9OqTjaPzUvqPQ6+28Pk0bdlFaPH501yAWxR
        ejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnPJm9j
        LVihUPFswzP2BsZuyS5GTg4JAROJr2ensXUxcnEICSxllPi+bTsrREJMYtK+7ewQtrDEn2td
        UEWfGCV+3VvC0sXIwcEmoCexY1UhSI2IQL1E/5tLbCA2s8ArJomG9xogtrCAm8S3E3vA4iwC
        qhIf700Gm88r4CUxfek0qF1yEjfPdTKD2JwC3hJLuv6C2UJANT/+fWScwMi3gJFhFaNIamlx
        bnpusZFecWJucWleul5yfu4mRmBMbDv2c8sOxq53wYcYBTgYlXh4H6wNjBFiTSwrrsw9xCjB
        wawkwmv42z9GiDclsbIqtSg/vqg0J7X4EKMp0FETmaVEk/OB8ZpXEm9oamhuYWlobmxubGah
        JM573qAySkggPbEkNTs1tSC1CKaPiYNTqoGx482S+r79z/qPPbg1/1AqN0tQ/rJ7Ih3VS20+
        3dx57WSfkNmckMW1R9l38/5gO2HX9dmpbNn5V5PUy49rCzbtnXBmnfADoRdTrmf58B9dN1t+
        bk3+A2ufOq1TCg8mPZ30mt3izBq5C8+0Qngz1HcFHkldEyHnw9Z+pmqL57ZFTzbqv6xMiejd
        qsRSnJFoqMVcVJwIAIJtK9efAgAA
X-CMS-MailID: 20190131085009eucas1p166467551006e54130905ebb5eefdefab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190131085009eucas1p166467551006e54130905ebb5eefdefab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085009eucas1p166467551006e54130905ebb5eefdefab
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085009eucas1p166467551006e54130905ebb5eefdefab@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of Dynamic Memory Controller and PPMU counters.
They are used by exynos5422-dmc driver.

CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: devicetree@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-samsung-soc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi             | 78 +++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 ++++++++
 2 files changed, 100 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index aaff158..574d398 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -235,6 +235,36 @@
 			status = "disabled";
 		};
 
+		dmc: memory-controller@10c20000 {
+			compatible = "samsung,exynos5422-dmc";
+			reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
+				<0x10030000 0x1000>, <0x10000000 0x1000>;
+			clocks = <&clock CLK_FOUT_SPLL>,
+				 <&clock CLK_MOUT_SCLK_SPLL>,
+				 <&clock CLK_FF_DOUT_SPLL2>,
+				 <&clock CLK_FOUT_BPLL>,
+				 <&clock CLK_MOUT_BPLL>,
+				 <&clock CLK_SCLK_BPLL>,
+				 <&clock CLK_MOUT_MX_MSPLL_CCORE>,
+				 <&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
+				 <&clock CLK_MOUT_MCLK_CDREX>,
+				 <&clock CLK_DOUT_CLK2X_PHY0>,
+				 <&clock CLK_CLKM_PHY0>,
+				 <&clock CLK_CLKM_PHY1>;
+			clock-names = "fout_spll",
+				      "mout_sclk_spll",
+				      "ff_dout_spll2",
+				      "fout_bpll",
+				      "mout_bpll",
+				      "sclk_bpll",
+				      "mout_mx_mspll_ccore",
+				      "mout_mx_mspll_ccore_phy",
+				      "mout_mclk_cdrex",
+				      "dout_clk2x_phy0",
+				      "clkm_phy0",
+				      "clkm_phy1";
+		};
+
 		nocp_mem0_0: nocp@10ca1000 {
 			compatible = "samsung,exynos5420-nocp";
 			reg = <0x10CA1000 0x200>;
@@ -271,6 +301,54 @@
 			status = "disabled";
 		};
 
+		ppmu_dmc0_0: ppmu@10d00000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d00000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
+					event-name = "ppmu-event3-dmc0_0";
+				};
+			};
+		};
+
+		ppmu_dmc0_1: ppmu@10d10000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d10000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
+					event-name = "ppmu-event3-dmc0_1";
+				};
+			};
+		};
+
+		ppmu_dmc1_0: ppmu@10d10000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d60000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
+					event-name = "ppmu-event3-dmc1_0";
+				};
+			};
+		};
+
+		ppmu_dmc1_1: ppmu@10d70000 {
+			compatible = "samsung,exynos-ppmu";
+			reg = <0x10d70000 0x2000>;
+			clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
+			clock-names = "ppmu";
+			events {
+				ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
+					event-name = "ppmu-event3-dmc1_1";
+				};
+			};
+		};
+
 		gsc_pd: power-domain@10044000 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10044000 0x20>;
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index bf09eab..e2b59e9 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -127,6 +127,12 @@
 	cpu-supply = <&buck2_reg>;
 };
 
+&dmc {
+	devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
+			<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
+	status = "okay";
+};
+
 &hsi2c_4 {
 	status = "okay";
 
@@ -535,6 +541,22 @@
 	};
 };
 
+&ppmu_dmc0_0 {
+	status = "okay";
+};
+
+&ppmu_dmc0_1 {
+	status = "okay";
+};
+
+&ppmu_dmc1_0 {
+	status = "okay";
+};
+
+&ppmu_dmc1_1 {
+	status = "okay";
+};
+
 &tmu_cpu0 {
 	vtmu-supply = <&ldo7_reg>;
 };
-- 
2.7.4

