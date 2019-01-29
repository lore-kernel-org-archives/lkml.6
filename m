Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2109C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AD921874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jFwR42s4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfA2Rzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:55:31 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48932 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfA2Rz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:55:27 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190129175525euoutp0272b5df3f533d3bf5657c3adc12e5760a~_Y1HsueOi2978229782euoutp02h
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 17:55:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190129175525euoutp0272b5df3f533d3bf5657c3adc12e5760a~_Y1HsueOi2978229782euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548784525;
        bh=gwLpP+fJxTXiUYPFk84WkmAXe+Yg2TY9OIz8w3v3/E8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jFwR42s4j7X1gbndXQsHlZtcRcEWBqJi9AWYkrdRRvQ5VY1fNb1ACDr6NerjJjZOW
         AkkoGDLCwG51rrooN7dlr1GsrNsopuBsMCYTKDxblL9m+1bzls2AhP0s0J2xvFy1xS
         qKSF88YtEZeHoJFpE1j1jA7syqV1DbJ9BnAJ+otI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190129175524eucas1p10d4d6eb99420da18cc9456dbf4dd499e~_Y1G1rYg02428624286eucas1p1V;
        Tue, 29 Jan 2019 17:55:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 28.F7.04441.C83905C5; Tue, 29
        Jan 2019 17:55:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190129175523eucas1p29b8c5355878356e50d8b234fc20ddf39~_Y1F47zdp0932709327eucas1p2l;
        Tue, 29 Jan 2019 17:55:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190129175523eusmtrp25b4039064100d24325ec980b425ee6c2~_Y1FpS3010424104241eusmtrp2V;
        Tue, 29 Jan 2019 17:55:23 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-0f-5c50938c05da
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C6.09.04284.B83905C5; Tue, 29
        Jan 2019 17:55:23 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190129175522eusmtip1fbcfa75e3738081d8137179320db6f34~_Y1E_1-3q2139021390eusmtip1F;
        Tue, 29 Jan 2019 17:55:22 +0000 (GMT)
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
Subject: [PATCH v2 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date:   Tue, 29 Jan 2019 18:55:07 +0100
Message-Id: <1548784514-26649-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87o9kwNiDG52cFtsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XlXXPYLD73HmG0mHF+H5PF2iN32S2W
        Xr/IZHG7cQWbReveI+wWh9+0szoIeKyZt4bRY9OqTjaPzUvqPQ6+28Pk0bdlFaPH501yAWxR
        XDYpqTmZZalF+nYJXBkrpq9gL1gtWPFj01nmBsY7fF2MnBwSAiYSWxdtYuti5OIQEljBKDHz
        3DUmCOcLo8TC7R8YIZzPjBIbHyxih2k5M3MqVGI5o8TjybfZ4VoWzfwK1M/BwSagJ7FjVSFI
        g4hAtcSd6/uZQWqYBe4wSeyduZQFJCEsECxx78NcMJtFQFVi15EPTCA2r4CXxI1dn1ggtslJ
        3DzXyQxicwp4S3Q8vgO2WUJgF7vExc03mSGKXCSmtJ9khLCFJV4d3wJ1qozE/53zmSDsYomz
        HavYIOwaifaTO6BqrCUOH7/ICnI0s4CmxPpd+iCmhICjxIP5NRAmn8SNt4IgxcxA5qRt05kh
        wrwSHW1CEDM0JLb0XIDaIyaxfM00qNkeErs/zGaGhM48RonZ/d9ZJzDKz0LYtYCRcRWjeGpp
        cW56arFhXmq5XnFibnFpXrpecn7uJkZgCjr97/inHYxfLyUdYhTgYFTi4WUIDogRYk0sK67M
        PcQowcGsJMJr+Ns/Rog3JbGyKrUoP76oNCe1+BCjNAeLkjhvNcODaCGB9MSS1OzU1ILUIpgs
        EwenVAOja13Zz+CiNcLL/MKWl5+e4LFJQcUnyFok/kGQteymmuSZHF2sv2se/2h55f69vnl7
        VWjbVTndHS3T031/3vqtcejA3zqh1BDHxj8163/yt7wMt9FJybypfLH0j/8KB+V5Pz5P9dwf
        w316n3SibhGn7xcPb473BfVByaGhOXavSnKu9OY7v1diKc5INNRiLipOBACpQcJiPQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmkeLIzCtJLcpLzFFi42I5/e/4Xd3uyQExBi+3sltsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XlXXPYLD73HmG0mHF+H5PF2iN32S2W
        Xr/IZHG7cQWbReveI+wWh9+0szoIeKyZt4bRY9OqTjaPzUvqPQ6+28Pk0bdlFaPH501yAWxR
        ejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkrpq9g
        L1gtWPFj01nmBsY7fF2MnBwSAiYSZ2ZOZQSxhQSWMkp8bQ6AiItJTNq3nR3CFpb4c62LrYuR
        C6jmE6PE0RObWboYOTjYBPQkdqwqBKkREaiX6H9ziQ3EZhZ4xSTR8F4DxBYWCJQ4d38bE4jN
        IqAqsevIBzCbV8BL4sauTywQ8+Ukbp7rZAaxOQW8JToe34G6x0vi2+sfbBMY+RYwMqxiFEkt
        Lc5Nzy021CtOzC0uzUvXS87P3cQIjIhtx35u3sF4aWPwIUYBDkYlHl6G4IAYIdbEsuLK3EOM
        EhzMSiK8hr/9Y4R4UxIrq1KL8uOLSnNSiw8xmgIdNZFZSjQ5HxiteSXxhqaG5haWhubG5sZm
        FkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGO1/M7zY/Od20ow937cJGjX+Ndw/y+GD3XWW
        m29W62c8ve+QF8XzIEb1xc51ufPq76xOfyJRcK1EgHuhLnvqqoX3eyyNDPbm3a+SSb08/+Ov
        47lqSnx8/J7T/FYtDpsvdfbKGtMb3ywMT05P3MW6WeW+gvUGO8e66bHfGZKuvd/psyvhstGz
        t6eVWIozEg21mIuKEwHyCvy9ngIAAA==
X-CMS-MailID: 20190129175523eucas1p29b8c5355878356e50d8b234fc20ddf39
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190129175523eucas1p29b8c5355878356e50d8b234fc20ddf39
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190129175523eucas1p29b8c5355878356e50d8b234fc20ddf39
References: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190129175523eucas1p29b8c5355878356e50d8b234fc20ddf39@eucas1p2.samsung.com>
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

