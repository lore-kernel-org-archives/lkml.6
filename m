Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25BCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556FD2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VoSB+mgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfA2R4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:56:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48951 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728611AbfA2Rz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:55:29 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190129175528euoutp026afa38176a185594865bee7651e2e9d4~_Y1Kd1Eys2896328963euoutp02L
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 17:55:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190129175528euoutp026afa38176a185594865bee7651e2e9d4~_Y1Kd1Eys2896328963euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548784528;
        bh=XwvE819PGgCk+v7COODs9vF1APcF4d1ePy+6X2BCL3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VoSB+mgjGAX1k6XueE6btc/d/8Mmwfd9gQqgYyiJE2rEmZP3DcBNEGzRk+KJCrDW5
         bWjL2cSD3NAhTHHiPp5TOYW6RCNLtpnaWFCHlA58bFwjuRolFbcE+odxb0Bv8EbY3N
         Dmv1bsZI85gPeQ2wK3oybD1hFb/tVJWkBEM/wQg0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190129175527eucas1p12fec21b95a387b8037380550df3ecde6~_Y1J0Z8xy2162921629eucas1p1x;
        Tue, 29 Jan 2019 17:55:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4B.F7.04441.F83905C5; Tue, 29
        Jan 2019 17:55:27 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190129175526eucas1p253dc2e8a0d64b34d95c84d585fb0fac0~_Y1JK5vau0932709327eucas1p2q;
        Tue, 29 Jan 2019 17:55:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190129175526eusmtrp22d690ab4c64bda3ded7aabef526dadce~_Y1I8C0lP0424104241eusmtrp2c;
        Tue, 29 Jan 2019 17:55:26 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-1c-5c50938f1f89
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 47.EE.04128.E83905C5; Tue, 29
        Jan 2019 17:55:26 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190129175526eusmtip1d3eac630f4a785d49679f27b9081360c~_Y1ISuS_z2140821408eusmtip1y;
        Tue, 29 Jan 2019 17:55:25 +0000 (GMT)
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
Subject: [PATCH v2 6/8] DT: arm: exynos: add DMC device for exynos5422
Date:   Tue, 29 Jan 2019 18:55:12 +0100
Message-Id: <1548784514-26649-7-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djP87r9kwNiDL5vlbDYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ3UQ8Fgzbw2jx6ZVnWwem5fUexx8t4fJo2/LKkaPz5vkAtii
        uGxSUnMyy1KL9O0SuDIunp7FXLBUvuLtSZ0GxibJLkZODgkBE4m1f8+ygdhCAisYJQ7tqO1i
        5AKyvzBKzPuxhg3C+cwocWHvQuYuRg6wjpkfKyDiyxklHpx7wQTXsWHOD7AiNgE9iR2rCkGm
        ighUS9y5vp8ZpIZZ4A6TxN6ZS1lAEsICbhK3u1rAbBYBVYmlk18xg9i8Al4S31cvZ4U4T07i
        5rlOsDingLdEx+M7jCCDJAS2sUucPL+ZBaLIReLn3DVMELawxKvjW9ghbBmJ/zvnQ8WLJc52
        rGKDsGsk2k/ugKqxljh8/CIryNHMApoS63fpQ4QdJR5/3M4G8TCfxI23giBhZiBz0rbp0HDg
        lehoE4Ko1pDY0nMBapGYxPI106CGe0jMe9AIDZ55jBItu3uZJjDKz0JYtoCRcRWjeGppcW56
        arFhXmq5XnFibnFpXrpecn7uJkZg+jn97/inHYxfLyUdYhTgYFTi4WUIDogRYk0sK67MPcQo
        wcGsJMJr+Ns/Rog3JbGyKrUoP76oNCe1+BCjNAeLkjhvNcODaCGB9MSS1OzU1ILUIpgsEwen
        VAOjQO2s96fib9rZ+Ld231Da7vlNXYnr71OttawyK1fYC0rNSOtMUt6rKszpyHNK5dReuV2H
        2E7t3Frx/M19h1fZyS75q8L+eO6oXmk3/zGjo4XTr/K07JSLAXLX3BoiJll+2P5qatgT1fb1
        n/jrWPkubuPUnvjrorreXZcfziU5qjfm128QzrNWYinOSDTUYi4qTgQApoBKXjsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4Xd2+yQExBhcnaVpsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XlXXPYLD73HmG0mHF+H5PF2iN32S2W
        Xr/IZHG7cQWbReveI+wWh9+0szoIeKyZt4bRY9OqTjaPzUvqPQ6+28Pk0bdlFaPH501yAWxR
        ejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkXT89i
        LlgqX/H2pE4DY5NkFyMHh4SAicTMjxVdjFwcQgJLGSUev37J0sXICRQXk5i0bzs7hC0s8eda
        FxtE0SdGiUXbp7OBNLMJ6EnsWFUIUiMiUC/R/+YSG4jNLPCKSaLhvQaILSzgJnG7qwVsJouA
        qsTSya+YQWxeAS+J76uXs0LMl5O4ea4TLM4p4C3R8fgOI4gtBFTz7fUPtgmMfAsYGVYxiqSW
        Fuem5xYb6RUn5haX5qXrJefnbmIExsO2Yz+37GDsehd8iFGAg1GJh5chOCBGiDWxrLgy9xCj
        BAezkgiv4W//GCHelMTKqtSi/Pii0pzU4kOMpkBHTWSWEk3OB8ZqXkm8oamhuYWlobmxubGZ
        hZI473mDyighgfTEktTs1NSC1CKYPiYOTqkGRhkr5elPT/e3KTVl3eK12VWUFsGz+Glfaibf
        IVuPS2d8/qub5Otf7Wc7dsmSX7BIo0FfLq9cZ94T0Yl//I9/O2L184P46VXhWzMkQ1Mi3r2X
        4K73nPv0k2bJZonJLWoqkts+K/T0znynucfD2P6089tbHAuqZd9fVPLKXHGy7uLHOQenK5/e
        qMRSnJFoqMVcVJwIAMLLVz6dAgAA
X-CMS-MailID: 20190129175526eucas1p253dc2e8a0d64b34d95c84d585fb0fac0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190129175526eucas1p253dc2e8a0d64b34d95c84d585fb0fac0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190129175526eucas1p253dc2e8a0d64b34d95c84d585fb0fac0
References: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190129175526eucas1p253dc2e8a0d64b34d95c84d585fb0fac0@eucas1p2.samsung.com>
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
 arch/arm/boot/dts/exynos5420.dtsi             | 69 +++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 +++++++++
 2 files changed, 91 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index aaff158..4d76335 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -235,6 +235,27 @@
 			status = "disabled";
 		};
 
+		dmc: memory-controller@10c20000 {
+			compatible = "samsung,exynos5422-dmc";
+			reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
+				<0x10030000 0x1000>, <0x10000000 0x1000>;
+			clocks = <&clock CLK_FOUT_SPLL>,
+				<&clock CLK_MOUT_SCLK_SPLL>,
+				<&clock CLK_FF_DOUT_SPLL2>,
+				<&clock CLK_FOUT_BPLL>,	<&clock CLK_MOUT_BPLL>,
+				<&clock CLK_SCLK_BPLL>,
+				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
+				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
+				<&clock CLK_MOUT_MCLK_CDREX>,
+				<&clock CLK_DOUT_CLK2X_PHY0>,
+				<&clock CLK_CLKM_PHY0>,	<&clock CLK_CLKM_PHY1>;
+			clock-names = "fout_spll", "mout_sclk_spll",
+				"ff_dout_spll2", "fout_bpll", "mout_bpll",
+				"sclk_bpll", "mout_mx_mspll_ccore",
+				"mout_mx_mspll_ccore_phy", "mout_mclk_cdrex",
+				"dout_clk2x_phy0", "clkm_phy0", "clkm_phy1";
+		};
+
 		nocp_mem0_0: nocp@10ca1000 {
 			compatible = "samsung,exynos5420-nocp";
 			reg = <0x10CA1000 0x200>;
@@ -271,6 +292,54 @@
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

