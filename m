Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E73C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8F62087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DvVPhYXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfAaIvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:51:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50869 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbfAaIuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:50:09 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190131085007euoutp02a9ea0486640833bb56b95228ff12ea8c~_4rln2pIO1221512215euoutp02F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:50:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190131085007euoutp02a9ea0486640833bb56b95228ff12ea8c~_4rln2pIO1221512215euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548924607;
        bh=gwLpP+fJxTXiUYPFk84WkmAXe+Yg2TY9OIz8w3v3/E8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvVPhYXqnx+RH0YBUrzy9OGRQeIoOfE9m/KM08mgH7WZC1bG1HQcAlvUocEjH08cL
         uM4Qt+HME9+Jhtpl6JW9R7gieXOr6qVKYQJUcylUlABADIzpoM8QE0jCxk+HhrQO6T
         P9oMOXuTR9Y6BX3DuxE+0d+P9T195ZdZWeXwBeog=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190131085006eucas1p24f4a833aac77b897b7e0041da3042921~_4rkzIC8P1523015230eucas1p2G;
        Thu, 31 Jan 2019 08:50:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5F.1C.04294.EB6B25C5; Thu, 31
        Jan 2019 08:50:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7~_4rkB7l_K1766917669eucas1p2L;
        Thu, 31 Jan 2019 08:50:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190131085005eusmtrp25a682463faedede4d97e3e12b825cea4~_4rjy6HaH2341223412eusmtrp2Y;
        Thu, 31 Jan 2019 08:50:05 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-95-5c52b6be7c7b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.B4.04284.DB6B25C5; Thu, 31
        Jan 2019 08:50:05 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190131085005eusmtip16bc9b6839d6c8ddae71916b38a4d4cf3~_4rjGGKNc1145511455eusmtip14;
        Thu, 31 Jan 2019 08:50:05 +0000 (GMT)
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
Subject: [PATCH v3 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date:   Thu, 31 Jan 2019 09:49:47 +0100
Message-Id: <1548924594-19084-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djPc7r7tgXFGFz8r2yxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzuog4LFm3hpGj02rOtk8Ni+p9zj4bg+TR9+WVYwenzfJBbBF
        cdmkpOZklqUW6dslcGWsmL6CvWC1YMWPTWeZGxjv8HUxcnBICJhIvNtt2cXIxSEksIJR4sbZ
        dkYI5wujxMsnt1ggnM+MEsvuPmDuYuQE65jacIUVIrGcUWL+0jXMcC1Hp09kBpnLJqAnsWNV
        IUiDiEC1xJ3r+8FqmAXuMEnsnbmUBSQhLBAsMXn3FzCbRUBV4vz0dawgNq+Al8SO65eZILbJ
        Sdw81wm2mVPAW2JJ11+oK3axS3ye7AVhu0hsa9wIVS8s8er4FnYIW0bi/875UPFiibMdq9gg
        7BqJ9pM7oGqsJQ4fv8gKcjOzgKbE+l36EGFHiTcvLzJBgohP4sZbQZAwM5A5adt0Zogwr0RH
        mxBEtYbElp4LUIvEJJavmQY13EPi1fYWaBjOY5TY9Pkc6wRG+VkIyxYwMq5iFE8tLc5NTy02
        ykst1ytOzC0uzUvXS87P3cQITECn/x3/soNx15+kQ4wCHIxKPLwP1gbGCLEmlhVX5h5ilOBg
        VhLhNfztHyPEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomDU6qB
        UboiUex9qNw+puRjbInJOilvPTcyvJpm+ulOxwwu1gAZnjOWMWsXSYVMi7LfeShvEZvTq53P
        k4UOCxmLpU14kTClkqWbzzlg8cPZ0y7uWh23Uinl26O3a+tOnLshrlbVL/dZ77xcT/UZTl1V
        ncc5AgtmXz6j+FugITpZWoZjp55H5a9J5oyHlViKMxINtZiLihMBA580gDwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Xd2924JiDJYf17PYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ3UQ8Fgzbw2jx6ZVnWwem5fUexx8t4fJo2/LKkaPz5vkAtii
        9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJWTF/B
        XrBasOLHprPMDYx3+LoYOTkkBEwkpjZcYe1i5OIQEljKKLHp9Q4WiISYxKR929khbGGJP9e6
        2CCKPjFK3HtykrmLkYODTUBPYseqQpAaEYF6if43l9hAbGaBV0wSDe81QGxhgUCJtvuLweaw
        CKhKnJ++jhXE5hXwkthx/TITxHw5iZvnOplBbE4Bb4klXX/BbCGgmh//PjJOYORbwMiwilEk
        tbQ4Nz232FCvODG3uDQvXS85P3cTIzAmth37uXkH46WNwYcYBTgYlXh4H6wNjBFiTSwrrsw9
        xCjBwawkwmv42z9GiDclsbIqtSg/vqg0J7X4EKMp0FETmaVEk/OB8ZpXEm9oamhuYWlobmxu
        bGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoHR24T1UHHI9OwPRjOZ6gvTjvjXTbxok3Lk
        GYOCjVpA3K6jbgwO9+KmBTXb1xT+8be2rHhRs5/ly/G2//mBUT/cVLx5jWUf9JTLlHqIzJ0i
        VGV9lf3YR6a+X3/d7qU53suZPDWnS/W9vlbrvwMh7Xot+1udz5u8uPbq3S5P5WnvF4Zm5Lqw
        rlFiKc5INNRiLipOBAAyp4GUnwIAAA==
X-CMS-MailID: 20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085006eucas1p2e4ba3f69e039c394e7cd42389ac8bfa7@eucas1p2.samsung.com>
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

