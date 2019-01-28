Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5FDC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86362148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rQxN7lZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfA1TWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:22:13 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34465 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfA1TV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:21:57 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190128192155euoutp0279c45b18db6eb310a46a5792f5ce30bf~_GXXbkQHy2531425314euoutp02Z
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 19:21:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190128192155euoutp0279c45b18db6eb310a46a5792f5ce30bf~_GXXbkQHy2531425314euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548703315;
        bh=9K981nRjiB/FyipvsylBPKjyPVRXvGVwtGS2MhaFgPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQxN7lZhMpA7P6rEjwyrgn7XiV9kEHBMdKGf9KunGLZAa2XX7WbNJCt/gdu8/2GHA
         fQgm6SCiO/g5/L1EOSSaJOeRgqLwT9ICesP70Q58QyVxLzdWwJ79I12zg+I+kOeroU
         leRcaqgJklA3RUJe0M/M+w4WUPduWB8TdNlj08bE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190128192154eucas1p275721ffc91bf12ab89c440b36d529c0a~_GXWgxNBk2500025000eucas1p2Z;
        Mon, 28 Jan 2019 19:21:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2B.0F.04441.2565F4C5; Mon, 28
        Jan 2019 19:21:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190128192154eucas1p2e696de47c5aab0cdb80cff32254daaf9~_GXV0ClXs3041130411eucas1p2s;
        Mon, 28 Jan 2019 19:21:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190128192153eusmtrp1104d5d2838175378189e407298205005~_GXVlbqio2976329763eusmtrp1P;
        Mon, 28 Jan 2019 19:21:53 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-a0-5c4f56522868
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8B.2F.04128.1565F4C5; Mon, 28
        Jan 2019 19:21:53 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190128192153eusmtip17afefa1541e838bb3704a144abc77b5e~_GXVGaDw80041400414eusmtip1Q;
        Mon, 28 Jan 2019 19:21:53 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] DT: arm: exynos: add DMC device for exynos5422
Date:   Mon, 28 Jan 2019 20:21:37 +0100
Message-Id: <1548703299-15806-7-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzned2gMP8Yg+5XChYbZ6xntZh/5Byr
        Rf/j18wW589vYLe41SBjsenxNVaLy7vmsFnMOL+PyWLp9YtMFrcbV7BZtO49wu7A7bFm3hpG
        j02rOtk8Ni+p9zj4bg+TR9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGV8bnjIVnBFtmLFmSls
        DYxrxbsYOTkkBEwk3m2cyQZiCwmsYJS4szgUwv7CKDF9E5T9mVGiaQ5QPQdY/ZfNGV2MXEDh
        5YwS/z7dY4FwgOovXr3GDFLEJqAnsWNVIUiviICcxM2vd9lAapgFjjFJNM4CaeDgEBZwlji/
        zgakhkVAVWLS7OmsIDavgJfEzeU72SFuA+o918kMYnMKeEuc7lvACDJHQmAyu8S7lScZIYpc
        JNZsfwplC0u8Or4FqllG4vTkHhYIu1jibMcqNgi7RqL95A6oGmuJw8cvsoLcwyygKbF+lz5E
        2FFi4e737BD/8knceCsIEmYGMidtm84MEeaV6GgTgqjWkNjSc4EJwhaTWL5mGtRwD4ll33oZ
        IaEzj1Giq7WbdQKj/CyEZQsYGVcxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEJpLT/45/
        2sH49VLSIUYBDkYlHl4DNv8YIdbEsuLK3EOMEhzMSiK8U6/7xQjxpiRWVqUW5ccXleakFh9i
        lOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpg3J0V2DVTUX1SWXXM6j8OlrYV76tzN6X9
        vlWju+ygzOe/Bc37yq4ecv7+Mzxrg5emy0ShK8yLm6sYlHfwm2jvSNkp654QtP6rDrus9s4n
        x41lzbn07m4v3issWKIv6ljaz3NLJ5Pvnd67p9MOmF4TY1iiM/FlYuHZ9InVKvdEFnf2+b73
        /XVTiaU4I9FQi7moOBEAV76JtyADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t/xu7qBYf4xBtsWGFtsnLGe1WL+kXOs
        Fv2PXzNbnD+/gd3iVoOMxabH11gtLu+aw2Yx4/w+Joul1y8yWdxuXMFm0br3CLsDt8eaeWsY
        PTat6mTz2Lyk3uPguz1MHn1bVjF6fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKp
        Z2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxueEhW8EV2YoVZ6awNTCuFe9i5OCQEDCR+LI5o4uR
        i0NIYCmjxMRd19i6GDmB4mISk/ZtZ4ewhSX+XOtigyj6xCix8+wtVpBmNgE9iR2rCkFqRATk
        JG5+vQtWwyxwgUni/esdYDXCAs4S59fZgNSwCKhKTJo9nRXE5hXwkri5fCfUfKDec53MIDan
        gLfE6b4FjCC2EFDN9MkvWCYw8i1gZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGN7bjv3c
        soOx613wIUYBDkYlHl4DNv8YIdbEsuLK3EOMEhzMSiK8U6/7xQjxpiRWVqUW5ccXleakFh9i
        NAU6aiKzlGhyPjD28kriDU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1
        MF59m8bOJGfJNLH1UCDrjjvdty2UljLX3Lh0z2uRqInq5l1qDQd2WbLX+da8bz7XJle30Eby
        xNUr7n8f7bh7pmGC2quW+8UX5y7OcC5bOFVtnaSTCMNBm8wjkrvebj0WzNJwK+7H5Deqe9pC
        76bU3BXLfGAnf3nlHGO27dwWx3K31a5en56/9JUSS3FGoqEWc1FxIgAdNFethQIAAA==
X-CMS-MailID: 20190128192154eucas1p2e696de47c5aab0cdb80cff32254daaf9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190128192154eucas1p2e696de47c5aab0cdb80cff32254daaf9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192154eucas1p2e696de47c5aab0cdb80cff32254daaf9
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190128192154eucas1p2e696de47c5aab0cdb80cff32254daaf9@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of Dynamic Memory Controller and PPMU counters.
They are used by exynos5-dmc driver.

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
 arch/arm/boot/dts/exynos5420.dtsi             | 81 +++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 22 ++++++++
 2 files changed, 103 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index aaff158..6880d13 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -1337,6 +1337,87 @@
 				opp-hz = /bits/ 64 <400000000>;
 			};
 		};
+
+		ppmu_dmc0_0: ppmu_dmc0_0@10d00000 {
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
+
+		ppmu_dmc0_1: ppmu_dmc0_1@10d10000 {
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
+		ppmu_dmc1_0: ppmu_dmc1_0@10d10000 {
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
+		ppmu_dmc1_1: ppmu_dmc1_1@10d70000 {
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
+		dmc: dmc@10c20000 {
+			compatible = "samsung,exynos5422-dmc";
+			reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
+				<0x10030000 0x1000>, <0x10000000 0x1000>;
+			clocks =	<&clock CLK_FOUT_SPLL>,
+					<&clock CLK_MOUT_SCLK_SPLL>,
+					<&clock CLK_FF_DOUT_SPLL2>,
+					<&clock CLK_FOUT_BPLL>,
+					<&clock CLK_MOUT_BPLL>,
+					<&clock CLK_SCLK_BPLL>,
+					<&clock CLK_MOUT_MX_MSPLL_CCORE>,
+					<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
+					<&clock CLK_MOUT_MCLK_CDREX>,
+					<&clock CLK_DOUT_CLK2X_PHY0>,
+					<&clock CLK_CLKM_PHY0>,
+					<&clock CLK_CLKM_PHY1>
+					;
+			clock-names =	"fout_spll",
+					"mout_sclk_spll",
+					"ff_dout_spll2",
+					"fout_bpll",
+					"mout_bpll",
+					"sclk_bpll",
+					"mout_mx_mspll_ccore",
+					"mout_mx_mspll_ccore_phy",
+					"mout_mclk_cdrex",
+					"dout_clk2x_phy0",
+					"clkm_phy0",
+					"clkm_phy1"
+					;
+		};
 	};
 
 	thermal-zones {
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index bf09eab..54ee8b2 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -119,6 +119,28 @@
 	status = "okay";
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
+&dmc {
+	devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
+			<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&buck6_reg>;
 };
-- 
2.7.4

