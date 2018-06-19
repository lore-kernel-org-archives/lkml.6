Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ABCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39ED52075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RPhDUO0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39ED52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937554AbeFSIV7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:21:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56007 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937346AbeFSIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:20:07 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180619082005euoutp015eafe6bd23d035fb8d36a1139196bd02~5ge1i6Iib0236902369euoutp01F;
        Tue, 19 Jun 2018 08:20:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180619082005euoutp015eafe6bd23d035fb8d36a1139196bd02~5ge1i6Iib0236902369euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529396405;
        bh=NrnpQGzrcOEo7lqdPrwfPBxurrzxdNfZULW3nu1PSsU=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=RPhDUO0UeOUD9pAbBNe0AXQw1sg8dQStaDpwY51xcedBP4A45443ua+hse0VDl1/A
         spu0zAsyraNwYPEYeOVulEJe8k+urqpXd23UuvXZjyjwNRx8rSvGugSLQHKkVpp3xB
         H6I1CD6zOZrP8WJ/s3WxFN5RK5eeaWEhyRecP/vY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619082004eucas1p1f71313cf6e209ed9d01cff12a3822f4f~5ge0w1rDI0549505495eucas1p1z;
        Tue, 19 Jun 2018 08:20:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F4.89.17380.3BCB82B5; Tue, 19
        Jun 2018 09:20:03 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619082003eucas1p1ee69166282872a3c031caf08cb550269~5ge0CH7xP0546705467eucas1p1a;
        Tue, 19 Jun 2018 08:20:03 +0000 (GMT)
X-AuditID: cbfec7f4-713ff700000043e4-e7-5b28bcb3c470
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.66.04178.3BCB82B5; Tue, 19
        Jun 2018 09:20:03 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PAK00EJ59T2RV00@eusync4.samsung.com>;
        Tue, 19 Jun 2018 09:20:03 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v3 8/9] ARM: dts: exynos5250: add DSI node
Date:   Tue, 19 Jun 2018 10:19:29 +0200
Message-id: <1529396370-18761-9-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfSzUcRzH+/4e7vdzc+23Q76ptF1rpEVo9S0yNm2/plr6p6Kln/yG5Q53
        KD3INM+Rh7NUOhZO3aQ6T2XSOubQHEaUeRotXag1D2XTg/PLf6/v5/3w2fe7L41L00gHOlIR
        xysVXJRMJCYa2pdNe2qbnYP3agoPoOEaE4lyTJ0YSsmYI9GL4mckKm1bnQ0sfhehgvE8An0Z
        6yPQnakZHPX0PKdQd8oshTLzKyiknxokUX9TiQgV97RgqMw8TKCnbaMUqhzqw1Dq6zYKFRea
        RWi5SUP42rHVmmrA9ufmYOyr+6MU+yDjHsnqdZkitnFpgmTHs40YW1txk82t0wF2Xu94Uhwk
        9g7joyITeKWbzwVxRPOtQTymXXzlR1EVSAatdBawoiGzD2o+F4qygJiWMo8BvLX4F7MIUmYe
        wPyx6+umrr4npDDXAqh+AwT+C+BSp2cWoGkR4wKr00MsPbaMDsDaD3PAcsCZIhL2ls6shW2Y
        Q7CjJp+yMMHshOPahjWWMP6wNX2IEJY5wo+mTNzCVswReP/hT8xSBJlCChqnukjB5A+n28v/
        B2zgV2MdJfBWmJnxFhP4GnxiriKEcDKAC6P9uCB4wVZj31oRzmyEBQ13ccsVICOBGWlSwcLC
        yqdaSniWYgAfqbupPLC5DGzQAXs+XiUP51UeCv6yq4qTq+IV4a4Xo+V6sPo73v0xLrwETSuh
        BsDQQGYtcX7mFCwluQRVotwAII3LbCX1lc7BUkkYl3iVV0aHKOOjeJUBbKEJmb3kvHNSkJQJ
        5+L4SzwfwyvXVYy2ckgGoTZJfrsp07mVxqP2xk+nGsUDmw5HGrzFVQr5e5/fY+6xRjv1RO+k
        m37xWNgvWzV3NsLP23M2Nqo7sEtini6f2i3jvp05fddjOURbErBrOrXFWpEdYNI2FI3cCAyU
        5B6c8Y0uMJllI/WeJ5y2zYf3e+0Isa/NO759uEP9wHNy/20ZoYrg3F1wpYr7BwcmjLQZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t/xa7qb92hEG1xZJ2Zxa905VovecyeZ
        LJo63rJabJyxntVi/hGg2JWv79ksJt2fwGLx4t5FFov+x6+ZLc6f38BucbbpDbtF58Ql7Bab
        Hl9jtbi8aw6bxYzz+5gsFry8xWKx9shddoul1y8yWbTuPcJuMWPySzaLn7vmsTiIeqyZt4bR
        43JfL5PHzll32T1md8xk9di0qpPNY/u3B6we97uPM3lsXlLv0bdlFaPH501yAVxRXDYpqTmZ
        ZalF+nYJXBl7mq8xFxzjqvg4dTljA+Nhji5GTg4JAROJUxdXsnYxcnEICSxhlJg8fy4bSEJI
        oJFJYv0Bxi5GDg42AS2JNe3xIDUiAqsYJab+vcMO4jALzGaVePVoAiNIg7CAlcSJdRPZQWwW
        AVWJ+8u2gdm8Ai4Sh9uvs0Bsk5O4ea6TGcTmFHCVmDX3OxPEMheJF6uvME1g5FnAyLCKUSS1
        tDg3PbfYUK84Mbe4NC9dLzk/dxMjMPC3Hfu5eQfjpY3BhxgFOBiVeHgbNqpHC7EmlhVX5h5i
        lOBgVhLh3bpUI1qINyWxsiq1KD++qDQntfgQozQHi5I473mDyighgfTEktTs1NSC1CKYLBMH
        p1QDY6tJNNuqSU9qhFdPm3d7YpJ5d5Gn0LbVz8snRi8658MeuJBt6lO96MhOo2cBZnpnBIUs
        dvW7fm4353q2dQePTUbv07XOHbI8W5XU+37Wqj1d/qcrvCiHcZbt1Yne37VKCp9PZ4myn3z0
        zpclPrrlvp9WbMm8GCTTsCCWrfVU4dVj0kXmnN5vlFiKMxINtZiLihMBljbRx3gCAAA=
X-CMS-MailID: 20180619082003eucas1p1ee69166282872a3c031caf08cb550269
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180619082003eucas1p1ee69166282872a3c031caf08cb550269
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619082003eucas1p1ee69166282872a3c031caf08cb550269@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Hajda <a.hajda@samsung.com>

The patch adds common part of DSI node for Exynos5250 platforms
and a required mipi-phy node.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 2daf505..9965eca 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -733,6 +733,27 @@
 			#phy-cells = <0>;
 		};
 
+		mipi_phy: video-phy@10040710 {
+			compatible = "samsung,s5pv210-mipi-video-phy";
+			reg = <0x10040710 0x100>;
+			#phy-cells = <1>;
+			syscon = <&pmu_system_controller>;
+		};
+
+		dsi_0: dsi@14500000 {
+			compatible = "samsung,exynos4210-mipi-dsi";
+			reg = <0x14500000 0x10000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			samsung,power-domain = <&pd_disp1>;
+			phys = <&mipi_phy 3>;
+			phy-names = "dsim";
+			clocks = <&clock CLK_DSIM0>, <&clock CLK_SCLK_MIPI1>;
+			clock-names = "bus_clk", "sclk_mipi";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		adc: adc@12d10000 {
 			compatible = "samsung,exynos-adc-v1";
 			reg = <0x12D10000 0x100>;
-- 
2.7.4

