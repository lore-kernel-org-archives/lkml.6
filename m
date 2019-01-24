Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944C2C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6616621872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RwTzTyir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfAXPpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:45:44 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55958 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfAXPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:45:42 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190124154540euoutp01a539fa72fbafe51fbd8a40c69c2cebae~801Z_OrF22738827388euoutp01l
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 15:45:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190124154540euoutp01a539fa72fbafe51fbd8a40c69c2cebae~801Z_OrF22738827388euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548344740;
        bh=PzMg4GV1XDi6Y5SAe2HJT0Zvt3QmVJ+RidOcaZENDo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwTzTyirfyeAfbVWUkiVSEV/nFSW7shTHJ37uwP+8qUr/zL62WN9UwStH6zu9i7Wn
         x4d4ChJgtFNimI28/U7D4O6s+wLLe2qxq6smZh6fyakSXsLyIqdZv4VgBMRMFWeJ/R
         HSKincZpANhSvQJy9nWa8i3O+xy6rpC6zloGI6go=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190124154539eucas1p1dbf6c93dca26dc85f023df86cb467229~801ZWGLAd1368013680eucas1p1V;
        Thu, 24 Jan 2019 15:45:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 49.31.04806.3ADD94C5; Thu, 24
        Jan 2019 15:45:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190124154538eucas1p2cdc2ce1eab4446e3ac139fd07d622ca7~801YlMxaD0349803498eucas1p2c;
        Thu, 24 Jan 2019 15:45:38 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190124154538eusmtrp26496d38667cad7a9a33d0476054bc169~801YWj5ga1826018260eusmtrp2q;
        Thu, 24 Jan 2019 15:45:38 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-e6-5c49dda367bf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.59.04284.2ADD94C5; Thu, 24
        Jan 2019 15:45:38 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190124154537eusmtip22c457d4332a782cda8616e044cae4f91~801XndraN2489624896eusmtip2X;
        Thu, 24 Jan 2019 15:45:37 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@partner.samsung.com>
To:     k.konieczny@partner.samsung.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 1/3] arm64: dts: exynos: add SlimSSS for Exynos5433
Date:   Thu, 24 Jan 2019 16:45:19 +0100
Message-Id: <20190124154521.13589-2-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190124154521.13589-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djP87qL73rGGLTOEbHYOGM9q8X8I+dY
        Lfr2/We06H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y26x9PpFJovWvUfYHbg91sxb
        w+ixaVUnm8fmJfUeB9/tYfLo27KK0ePzJrkAtigum5TUnMyy1CJ9uwSujHnTdzEW9HNUtF5d
        xNrA+JSti5GTQ0LARGL90r3MXYxcHEICKxglnv26AuV8YZRYvnQqI4TzmVGi78pudpiWebNe
        Q1UtZ5RYcPIQO1zLw01HwAazCZhLPNp+hgnEFhFQlph8bzpYB7PAfyaJhXeWgBUJC7hJ3L91
        ixXEZhFQldh6/gXQJA4OXgEXiecHOCC2yUtMW90FNodTwFVi74RmFhCbV0BQ4uTMJ2A2M1BN
        89bZYPMlBDaxS2x51MAK0ewicXzGRxYIW1ji1fEtUC/ISPzfOZ8Jwi6X2L31GTtEcwujxNzJ
        i6AS1hKHj19kBTmIWUBTYv0ufYiwo0T7ghNsIGEJAT6JG28FIW7gk5i0DeRHkDCvREebEES1
        rsS8/2egrpGW6Pq/Dsr2kFh18h/LBEbFWUi+mYXkm1kIexcwMq9iFE8tLc5NTy02zkst1ytO
        zC0uzUvXS87P3cQITE6n/x3/uoNx35+kQ4wCHIxKPLwdhzxjhFgTy4orcw8xSnAwK4nwul50
        ixHiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TBKdXA6ByWt2Lu
        T52vlzWZTvdXp2WvVL6UXiq5far116u2r3flVHvE/E4vW+D8w3S+btzLP7unGAsuU3M+fKf0
        VL7tal4R3m7LqZfY/y39ruwWm76FVemTwlmjBtmTv1LXhEduXcl2RfFibFxWYeuFr5y3d//X
        Tp2XV53B/YYr3rxrvt+JRnmt2fXflViKMxINtZiLihMBmt8PaUoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7qL7nrGGDzcqGSxccZ6Vov5R86x
        WvTt+89o0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl91i6fWLTBate4+wO3B7rJm3
        htFj06pONo/NS+o9Dr7bw+TRt2UVo8fnTXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYm
        lnqGxuaxVkamSvp2NimpOZllqUX6dgl6GfOm72Is6OeoaL26iLWB8SlbFyMnh4SAicS8Wa+Z
        uxi5OIQEljJKdPWtYIVISEs0nl7NBGELS/y51sUGUfSJUeLul5NgCTYBc4lH28+A2SICyhKT
        700Hm8Qs0M4ssWb3NrAVwgJuEvdv3QKbyiKgKrH1/Av2LkYODl4BF4nnBzggFshLTFvdBTaH
        U8BVYu+EZhYQWwioZO63WWBjeAUEJU7OfAIWZwaqb946m3kCo8AsJKlZSFILGJlWMYqklhbn
        pucWG+oVJ+YWl+al6yXn525iBEbRtmM/N+9gvLQx+BCjAAejEg9vxyHPGCHWxLLiytxDjBIc
        zEoivK4X3WKEeFMSK6tSi/Lji0pzUosPMZoC/TCRWUo0OR8Y4Xkl8YamhuYWlobmxubGZhZK
        4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhgDd1j+4SueFfS9PpXJUkDMdfXitmsclm8dLByn
        S7L0Taj42zhBcOuJ/k61BVHpiam8+zskmLPU8u+Wr5uhktYm13GIeXdDy9X2+x9XbDPjL+8+
        wH3vvuPTS62tGwMEfHc81S35uKx9EqvZm4Uqyozq84N3Hbgsydn4NWOOYNOS15ccc8u8jJVY
        ijMSDbWYi4oTAbTScbS4AgAA
X-CMS-MailID: 20190124154538eucas1p2cdc2ce1eab4446e3ac139fd07d622ca7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190124154538eucas1p2cdc2ce1eab4446e3ac139fd07d622ca7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190124154538eucas1p2cdc2ce1eab4446e3ac139fd07d622ca7
References: <20190124154521.13589-1-k.konieczny@partner.samsung.com>
        <CGME20190124154538eucas1p2cdc2ce1eab4446e3ac139fd07d622ca7@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for SlimSSS (aka Slim SecuritySubSystem) in Exynos5433 SoC.
The users can use compatibility "samsung,exynos5433-slim-sss".

Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index e7cd3b67d818..9e5fcb6c7776 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -559,6 +559,15 @@
 				<&cmu_top CLK_DIV_ACLK_IMEM_200>;
 		};
 
+		slim_sss: slim-sss@11140000 {
+			compatible = "samsung,exynos5433-slim-sss";
+			reg = <0x11140000 0x1000>;
+			interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "aclk", "pclk";
+			clocks = <&cmu_imem CLK_ACLK_SLIMSSS>,
+				 <&cmu_imem CLK_PCLK_SLIMSSS>;
+		};
+
 		pd_gscl: power-domain@105c4000 {
 			compatible = "samsung,exynos5433-pd";
 			reg = <0x105c4000 0x20>;
-- 
2.20.0

