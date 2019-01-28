Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCDC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCD92148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HUiWkNO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfA1TW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:22:28 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58495 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfA1TV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:21:56 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190128192155euoutp0138bb4db95535d9a4cce8e82ea40cad5e~_GXW0XYYp2889728897euoutp01M
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 19:21:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190128192155euoutp0138bb4db95535d9a4cce8e82ea40cad5e~_GXW0XYYp2889728897euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548703315;
        bh=H9JwNPpHjdrMsMoOIIi86qiiQO/iJ8OBpEvsDkqVnBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HUiWkNO90hQQ2LnQtKUb2/XIaRgqfhn8Svwyhwfn8FqvEoa6ANoMvbHclUNA3YlYt
         AleaZab9VTLRpX/S1yOb1v5BIyQRZjfXarDfnBxEx/vscjnf8x36aRKevkgYHpF+El
         uFiY/go8Gb8lGOxqx0QV4NvV1i2LqrQ/6EG0+VlI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190128192154eucas1p2e567cb7c241cdebb9bf9b3a37cdf9f58~_GXV5EWze3066330663eucas1p2p;
        Mon, 28 Jan 2019 19:21:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 64.7A.04806.1565F4C5; Mon, 28
        Jan 2019 19:21:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190128192153eucas1p2d7a796cb89e68c1789069562e91296be~_GXUyk06u3041030410eucas1p2g;
        Mon, 28 Jan 2019 19:21:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190128192152eusmtrp1e263e1de2040993146c349f5d43a499c~_GXUj2m182976329763eusmtrp1N;
        Mon, 28 Jan 2019 19:21:52 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-18-5c4f56510318
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9A.2F.04128.0565F4C5; Mon, 28
        Jan 2019 19:21:52 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190128192152eusmtip1bcc3f471e5ca73c05bfe67b1ced0ee22~_GXT7JvDV0144001440eusmtip1J;
        Mon, 28 Jan 2019 19:21:52 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] dt-bindings: devfreq: add DMC device description
Date:   Mon, 28 Jan 2019 20:21:35 +0100
Message-Id: <1548703299-15806-5-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO/fuPlyurlP0oGI1kB7gixZcUqSgYCi4+icihZzuMs1t2q6a
        mpnZQ12mkVSWMRV8DlGbTqaVqZmWrymGVpYagpqpCT6wIZm3O+u/z++cz/f3+3E4JCo2YO5k
        rDaR0WkVagkuFDR3/7L6nD0nj/C3WKX086J6jB5bncXokq5BjC6Y/oHSVmsDQQ9kLRD050xP
        2jQ9itEjrc9weuVeF6CLrG0IXTE2jNDjN6px+varLuLEHlmtoRbITMZcXNZYfl3WsfQSkeU3
        GYFsxeR1Br8gDFIy6thkRucXHCmMqcnKwhNGD6bY6l4QmaBmvx44kJCSwv7GIUQPhKSYqgZw
        0raM8sUqgJtbNgFfrABYZt4COxHLu1t2qwrAm+N1yL9I0dQMoQckiVO+0GK8zAVcKC/4ae0r
        zjkoZUahbWbsbydn6jRcG2wFnC+gvGHv+DUORVQI7M+2r7cdHcxFOXagQmFffing2kCqkoDm
        QivCS6dgRekQzrMznO9pInj2hH2FeQKeWTiQY7Q76TD7vcXuBMI3PcMYNxelDsP6Vj8OIXUS
        thUKedwDPy46cTK6jQ+aH6P8sQjm3BHzPQ7Bprwh+y6usKr2kb23DJoX7mL82xgAnNvoBvfB
        vqf/Z5UCYARuTBKrUTHsUS1zxZdVaNgkrco3Ol5jAtu/pu93z5oFtG1GdQKKBBJHkT8ujxBj
        imQ2VdMJIIlKXEQPx8IixCKlIjWN0cVf1CWpGbYTeJACiZvo6q6pcDGlUiQycQyTwOh2bhHS
        wT0TJK9Lqyf6nbpni3UFVbbKwKLk2Yqf7b3rYUq1fAmRx+sjz5d8U2qpjUTX8Gl1uE1Fhc7o
        F3crM+a+7I1qKMAOOJYtvg1oN2SnHV+OXgp53fGhLJ4wB+k95uOiUy61kOXSCe+RDgEtbjm2
        mh/s831iJb100pBRHDlubesffiKXCNgYRcARVMcq/gC9MeCHMQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42I5/e/4Xd2AMP8Yg8WzNC02zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdouzTW/YLW41yFhsenyN1eLyrjlsFp97jzBazDi/j8li6fWLTBa3
        G1ewWbTuPcLuwOexZt4aRo9NqzrZPDYvqfc4+G4Pk0ffllWMHp83yQWwRenZFOWXlqQqZOQX
        l9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlrGxqYiu4pl7xa91u9gbG
        lQpdjJwcEgImEjtOtDB3MXJxCAksZZT4/XASO0RCTGLSvu1QtrDEn2tdbBBFnxglWu81ACU4
        ONgE9CR2rCoEqRERkJO4+fUuWA2zwEFmif+f/rGCJIQFXCW+ntvFCFLPIqAqcep2LYjJK+Al
        caYd6gag1nOdzCA2p4C3xOm+BYwgthBQyfTJL1gmMPItYGRYxSiSWlqcm55bbKRXnJhbXJqX
        rpecn7uJERj824793LKDsetd8CFGAQ5GJR5eAzb/GCHWxLLiytxDjBIczEoivFOv+8UI8aYk
        VlalFuXHF5XmpBYfYjQFOmkis5Rocj4wMvNK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5ak
        ZqemFqQWwfQxcXBKNTA2sqbb6U2ZbpTRlJgX7NAt4etiw7zrr/eMI68ezt/1LDJO4qnCidvu
        dXffH7P7/eOQR5VLR8t0AccDrXXFKgtet9z8+eTQs3e7hLOz+fuuGTzb8SrgCVtfJ7+jBoMQ
        Y5yAs1r3pJdpO7qXfvhSNyH3he1h/V8+jzVsOl4yt3ao6nSUtdzadEaJpTgj0VCLuag4EQCd
        Hw99lAIAAA==
X-CMS-MailID: 20190128192153eucas1p2d7a796cb89e68c1789069562e91296be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190128192153eucas1p2d7a796cb89e68c1789069562e91296be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192153eucas1p2d7a796cb89e68c1789069562e91296be
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190128192153eucas1p2d7a796cb89e68c1789069562e91296be@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds description for DT binding for a new Exynos5 Dynamic Memory
Controller device.
It also contains needed MAINTAINERS file updates.

CC: MyungJoo Ham <myungjoo.ham@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>
CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: linux-pm@vger.kernel.org
CC: linux-samsung-soc@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 .../devicetree/bindings/devfreq/exynos5-dmc.txt    | 108 +++++++++++++++++++++
 MAINTAINERS                                        |   7 ++
 2 files changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt

diff --git a/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
new file mode 100644
index 0000000..914bd85
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
@@ -0,0 +1,108 @@
+* Exynos5 frequency and voltage scaling for Dynamic Memory Controller device
+
+The Samsung Exynos5 SoC has DMC (Dynamic Memory Controller) to which the DRAM
+memory chips are connected. The driver is to monitor the controller in runtime
+and switch frequency and voltage. To monitor the usage of the controller in
+runtime, the driver uses the PPMU (Platform Performance Monitoring Unit), which
+is able to measure the current load of the memory.
+When 'userspace' governor is used for the driver, an application is able to
+switch the DMC frequency.
+
+Required properties for DMC device for Exynos5422:
+- compatible: Should be "samsung,exynos5422-bus".
+- clock-names : the name of clock used by the bus, "bus".
+- clocks : phandles for clock specified in "clock-names" property.
+- devfreq-events : phandles for PPMU devices connected to this DMC.
+
+The example definition of a DMC and PPMU devices declared in DT is shown below:
+
+	ppmu_dmc0_0: ppmu_dmc0_0@10d00000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d00000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX0_0>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc0_0: ppmu-event3-dmc0_0 {
+				event-name = "ppmu-event3-dmc0_0";
+			};
+		};
+	};
+
+
+	ppmu_dmc0_1: ppmu_dmc0_1@10d10000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d10000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX0_1>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc0_1: ppmu-event3-dmc0_1 {
+				event-name = "ppmu-event3-dmc0_1";
+			};
+		};
+	};
+
+	ppmu_dmc1_0: ppmu_dmc1_0@10d10000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d60000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX1_0>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc1_0: ppmu-event3-dmc1_0 {
+				event-name = "ppmu-event3-dmc1_0";
+			};
+		};
+	};
+
+	ppmu_dmc1_1: ppmu_dmc1_1@10d70000 {
+		compatible = "samsung,exynos-ppmu";
+		reg = <0x10d70000 0x2000>;
+		clocks = <&clock CLK_PCLK_PPMU_DREX1_1>;
+		clock-names = "ppmu";
+		status = "okay";
+		events {
+			ppmu_event_dmc1_1: ppmu-event3-dmc1_1 {
+				event-name = "ppmu-event3-dmc1_1";
+			};
+		};
+	};
+
+	dmc: dmc@10c20000 {
+		compatible = "samsung,exynos5422-dmc";
+		reg = <0x10c20000 0x10000>, <0x10c30000 0x10000>,
+			<0x10030000 0x1000>, <0x10000000 0x1000>;
+		clocks = 	<&clock CLK_FOUT_SPLL>,
+				<&clock CLK_MOUT_SCLK_SPLL>,
+				<&clock CLK_FF_DOUT_SPLL2>,
+				<&clock CLK_FOUT_BPLL>,
+				<&clock CLK_MOUT_BPLL>,
+				<&clock CLK_SCLK_BPLL>,
+				<&clock CLK_MOUT_MX_MSPLL_CCORE>,
+				<&clock CLK_MOUT_MX_MSPLL_CCORE_PHY>,
+				<&clock CLK_MOUT_MCLK_CDREX>,
+				<&clock CLK_DOUT_CLK2X_PHY0>,
+				<&clock CLK_CLKM_PHY0>,
+				<&clock CLK_CLKM_PHY1>
+			;
+		clock-names =	"fout_spll",
+				"mout_sclk_spll",
+				"ff_dout_spll2",
+				"fout_bpll",
+				"mout_bpll",
+				"sclk_bpll",
+				"mout_mx_mspll_ccore",
+				"mout_mx_mspll_ccore_phy",
+				"mout_mclk_cdrex",
+				"dout_clk2x_phy0",
+				"clkm_phy0",
+				"clkm_phy1"
+				;
+
+		status = "okay";
+		devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
+				<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
+	};
+
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 9f64f8d..3581807 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3310,6 +3310,13 @@ S:	Maintained
 F:	drivers/devfreq/exynos-bus.c
 F:	Documentation/devicetree/bindings/devfreq/exynos-bus.txt
 
+DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5
+M:	Lukasz Luba <l.luba@partner.samsung.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/devfreq/exynos5-dmc.txt
+
 BUSLOGIC SCSI DRIVER
 M:	Khalid Aziz <khalid@gonehiking.org>
 L:	linux-scsi@vger.kernel.org
-- 
2.7.4

