Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348A6C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC812184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NdURfDCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfA2Rzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:55:55 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48963 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbfA2Rza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:55:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190129175528euoutp02048eb717e378430bd30ab1976d52b004~_Y1KK2Uvk3063230632euoutp02E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 17:55:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190129175528euoutp02048eb717e378430bd30ab1976d52b004~_Y1KK2Uvk3063230632euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548784528;
        bh=4mLNlO8kn7enl8xaIirmpn61OEmGZImpqy0vkgZZ1Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NdURfDCvckgOzNRSLSaLr+rb2+z9eAAhX4f2Oq4/B4EijpvW+vkX2pyrSNhf4UCF4
         hZ4cHheJikou5nEyc1/Qpg27j1pPm6VDFljOxgp/q8FSOZ6sOjsK42cP5S5DZlEANQ
         fQmRAkvmTaFD21pB3IB/64OpPFMLLwwoprksB1eo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190129175527eucas1p189d7c136bb9ff6845b5a7b1fd59ea1ec~_Y1JcdOp52455524555eucas1p1Z;
        Tue, 29 Jan 2019 17:55:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1A.F7.04441.E83905C5; Tue, 29
        Jan 2019 17:55:26 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190129175526eucas1p197f5db6208ee52e25fecd58fe7c608e4~_Y1IlJeFG2431324313eucas1p1U;
        Tue, 29 Jan 2019 17:55:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190129175526eusmtrp26d893244c35d860c6c408b6a9e249dee~_Y1IWPi3e0424104241eusmtrp2b;
        Tue, 29 Jan 2019 17:55:26 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-1a-5c50938e980d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E9.09.04284.D83905C5; Tue, 29
        Jan 2019 17:55:25 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190129175525eusmtip168a03d84198eddbe7d27127b05513acf~_Y1HouIv72139021390eusmtip1H;
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
Subject: [PATCH v2 5/8] dt-bindings: devfreq: add Exynos5422 DMC device
 description
Date:   Tue, 29 Jan 2019 18:55:11 +0100
Message-Id: <1548784514-26649-6-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djPc7p9kwNiDL7dtLbYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ3UQ8Fgzbw2jx6ZVnWwem5fUexx8t4fJo2/LKkaPz5vkAtii
        uGxSUnMyy1KL9O0SuDJ2XFjBVtClVnH8/17WBsYm+S5GTg4JAROJlZNesHQxcnEICaxglHi8
        4TErhPOFUWLz/NuMEM5nRokvnd+BMhxgLQ8muEHElzNKvPjUidBxvHkhI0gRm4CexI5VhSAr
        RASqJe5c388MUsMscIdJYu/MpSwgCWGBUIl5/Q+ZQWwWAVWJf8dWgdm8Al4SC3ftZYW4T07i
        5rlOsDingLdEx+M7YBdJCGxjlzi77z0jRJGLxJ1Hr9khbGGJV8e3QNkyEv93zmeCsIslznas
        YoOwayTaT+6AqrGWOHz8IthnzAKaEut36UOEHSXeLJ3OAvEwn8SNt4IgYWYgc9K26cwQYV6J
        jjYhiGoNiS09F6AWiUksXzMNariHxKtlf9khwTOPUWJOyzbWCYzysxCWLWBkXMUonlpanJue
        WmyYl1quV5yYW1yal66XnJ+7iRGYgk7/O/5pB+PXS0mHGAU4GJV4eBmCA2KEWBPLiitzDzFK
        cDArifAa/vaPEeJNSaysSi3Kjy8qzUktPsQozcGiJM5bzfAgWkggPbEkNTs1tSC1CCbLxMEp
        1cDocNXc9JDLluPLXyyznMe9lLNngbdNxIzOet6Ktz86p/sfOjA/4+OClQfW3+xNvqZh8++v
        e4noMbH123RVLGabzfwTzldTM0Xe9VnodrmPjQfzT9aeW7fgWOhJj+vpc6wnh8ndPX9g+y9D
        jbufGlpb4n9fuqypq/R7wZNVz8sSD348dD3v/PETZUosxRmJhlrMRcWJABEULHs9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4Xd3eyQExBku3WVtsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XlXXPYLD73HmG0mHF+H5PF2iN32S2W
        Xr/IZHG7cQWbReveI+wWh9+0szoIeKyZt4bRY9OqTjaPzUvqPQ6+28Pk0bdlFaPH501yAWxR
        ejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehk7Lqxg
        K+hSqzj+fy9rA2OTfBcjB4eEgInEgwluXYxcHEICSxkl7j97z97FyAkUF5OYtG87lC0s8eda
        FxtE0SdGiZVtq9lBmtkE9CR2rCoEqRERqJfof3OJDcRmFnjFJNHwXgPEFhYIllh7fxfYHBYB
        VYl/x1Yxg9i8Al4SC3ftZYWYLydx81wnWJxTwFui4/EdRhBbCKjm2+sfbBMY+RYwMqxiFEkt
        Lc5Nzy021CtOzC0uzUvXS87P3cQIjIhtx35u3sF4aWPwIUYBDkYlHl6G4IAYIdbEsuLK3EOM
        EhzMSiK8hr/9Y4R4UxIrq1KL8uOLSnNSiw8xmgIdNZFZSjQ5HxiteSXxhqaG5haWhubG5sZm
        FkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGJP4Uqd9m3lsfaUMU47ZthiWgzZLci8IrGTd
        Xjt3jZGdrcrRSKufzl+O7v5bmfanhvFPvWtVYdONuBmKluXhZeFWbW4iN7V/ySh80mHI/RQf
        mX1l3YWF1/mOCyucEVeJWepWu9jDm9nwVH1i28MFlmKdqZMt9msYXZy4eJfOzdVvnEqZld2d
        lViKMxINtZiLihMB+hS2yp4CAAA=
X-CMS-MailID: 20190129175526eucas1p197f5db6208ee52e25fecd58fe7c608e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190129175526eucas1p197f5db6208ee52e25fecd58fe7c608e4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190129175526eucas1p197f5db6208ee52e25fecd58fe7c608e4
References: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190129175526eucas1p197f5db6208ee52e25fecd58fe7c608e4@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds description for DT binding for a new Exynos5422 Dynamic
Memory Controller device.
It also contains needed MAINTAINERS file update.

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
 .../devicetree/bindings/devfreq/exynos5422-dmc.txt | 106 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt

diff --git a/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
new file mode 100644
index 0000000..229efba
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
@@ -0,0 +1,106 @@
+* Exynos5422 frequency and voltage scaling for Dynamic Memory Controller device
+
+The Samsung Exynos5422 SoC has DMC (Dynamic Memory Controller) to which the DRAM
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
+	ppmu_dmc0_0: ppmu@10d00000 {
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
+	ppmu_dmc0_1: ppmu@10d10000 {
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
+	ppmu_dmc1_0: ppmu@10d10000 {
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
+	ppmu_dmc1_1: ppmu@10d70000 {
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
+	dmc: memory-controller@10c20000 {
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
+				<&clock CLK_CLKM_PHY1>;
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
+				"clkm_phy1";
+
+		status = "okay";
+		devfreq-events = <&ppmu_dmc0_0>, <&ppmu_dmc0_1>,
+				<&ppmu_dmc1_0>, <&ppmu_dmc1_1>;
+	};
+
+
diff --git a/MAINTAINERS b/MAINTAINERS
index e81dfbf..ab0d8a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3316,6 +3316,7 @@ L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	drivers/devfreq/exynos5422-dmc.c
+F:	Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
 
 BUSLOGIC SCSI DRIVER
 M:	Khalid Aziz <khalid@gonehiking.org>
-- 
2.7.4

