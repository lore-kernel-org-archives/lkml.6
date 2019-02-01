Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB0BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B7421726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UYNT6pwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfBAQse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:48:34 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45303 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbfBAQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:47:21 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190201164720euoutp020320994d62f5c5237e9d5473a4232035~-S1h4B3461427814278euoutp02Q
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 16:47:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190201164720euoutp020320994d62f5c5237e9d5473a4232035~-S1h4B3461427814278euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549039640;
        bh=4O5crTvde9vF0PpacAVRzuJF6TGoQktWztAR6yioIxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYNT6pwb7uef0ibRdBvBIQm7p8MOq7/ldbDcSLaSH5Pm+EO8CXwwkHCe86PjeFW0U
         i6ZRw/3A/lsT5f00uEuNYD4iw1Wt/EycWRQZrDM9Kzzg4QLQx8zBT0kXP8PIm7UqO8
         Zns8cwsSkGC/udKgAJbwb+MMcS0iJujjJ0YpckzY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190201164719eucas1p215be3b5beedd0cb48d91179eb3d65edc~-S1g0ytYK1211512115eucas1p2I;
        Fri,  1 Feb 2019 16:47:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6B.E3.04441.618745C5; Fri,  1
        Feb 2019 16:47:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47~-S1f6vZV-2643926439eucas1p1T;
        Fri,  1 Feb 2019 16:47:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190201164717eusmtrp1ab288121c3a3b3e4b6ddc8f0f329c353~-S1fr1jUf3167231672eusmtrp1S;
        Fri,  1 Feb 2019 16:47:17 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-cf-5c547816cea1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 60.30.04128.518745C5; Fri,  1
        Feb 2019 16:47:17 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190201164717eusmtip2efc7e94ed3b0d62cf020a48b5feddfc1~-S1e-svTz3272832728eusmtip2j;
        Fri,  1 Feb 2019 16:47:17 +0000 (GMT)
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
Subject: [PATCH v4 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
Date:   Fri,  1 Feb 2019 17:46:45 +0100
Message-Id: <1549039612-28905-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTURzv7O7uXleL6+bjZGIw7U0uwQ8XsrLHh6FfwoysLLvlTa1t2q7z
        kUZW5mNYioJa5INIpnOhTlExpzmXI0Q3U3ylMRoRli58o2Dl3K2+/f6/x/n/zuHgiLAO9cET
        FMm0UkHJxDw+t7VvbfCIV1pk9NGJCgnZVN6AkmNL31CyyjSIkoX2HwhpsTRi5MCjWYyczPIl
        9fZRlBzueMkjF5+aAFlu6eKQb0zTGFkzNsQhPz2s5ZFPDCaM7J3NRUMJqa5SB6R6bT5P2vz6
        gbTH0cmRPmvRAumi3u8c7zI/JJaWJaTQSsmJ6/z4tkJ+kk2QZrP5ZwHTdjVwwyERDPuqu4Ea
        8HEhUQugdbKDHZYA7NZrUNewCKC6d4T3N6LLHcVcggbAx0Xz3H8Re3bZpoLjPCIQtmvvOgMe
        RAacGutGnB6EmOJAw/MarlMQEefhatcE5sRcYi/sfv9uCwuIMLiqs2KubX5wYjAfcWI3Ihzm
        2du2+kFCj8GV5UGuy3QWri00c1xYBL+bW9iwL+wvKWA9DBzI07JXyIS5H9pZzzHYax5CnaUR
        4iBs6JC46FNw6JVxi4bETjg+5+6kkU1Y3FqGuGgBzMsRutwHYEuBlS3gBTW6UvZwKZx1lLKP
        WAngyNdOpAjsefF/WTUAWuBNqxh5HM0EKejUQIaSMypFXODNRLkebH6g/l/mhXaw/PGGERA4
        EO8QNK5HRAtRKoVJlxsBxBGxh+D07chooSCWSr9HKxNjlCoZzRjBbpwr9hZkbLNdERJxVDJ9
        h6aTaOVflYO7+WSBfTGqes79hplUgwVLOqPfuCbK+ay21nnIkoI8HSVZP2eM2UYwMm0OCKkF
        9Ear529rkySs2PG2x1190RYl0/TP1mdeiEqp6kwYN1Mr+/HKiC9uiXbf9YrDt4yXdmn8C6KW
        rip086Lg412OkOHwOTl/I2XOMOx3UlcV0DIcWijmMvFU0CFEyVB/AO82ZRk8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4PV3RipAYg/Wr9Sw2zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdouzTW/YLW41yFhsenyN1eLyrjlsFp97jzBazDi/j8li7ZG77BZL
        r19ksrjduILNonXvEXaLw2/aWR0EPNbMW8PosWlVJ5vH5iX1Hgff7WHy6NuyitHj8ya5ALYo
        PZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzt/VwF
        D3grHjxQbmA8wt3FyMkhIWAisab9GnsXIxeHkMBSRom2Xa2sEAkxiUn7trND2MISf651sUEU
        fWKUaFzxlqmLkYODTUBPYseqQpAaEYF6if43l9hAbGaBV0wSDe81QEqEBQIlOhaqgoRZBFQl
        9h89ADaSV8BL4vuaC1Dj5SRunutkBrE5BbwlOh5vZwSxhYBqVv07wDyBkW8BI8MqRpHU0uLc
        9NxiI73ixNzi0rx0veT83E2MwGjYduznlh2MXe+CDzEKcDAq8fBu+BUUI8SaWFZcmXuIUYKD
        WUmE1ykrJEaINyWxsiq1KD++qDQntfgQoynQUROZpUST84GRmlcSb2hqaG5haWhubG5sZqEk
        znveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgdG4VDtTSPr21KU3a3nYLsdrBIV31W+/IqL86uHR
        jraoHGEeh9Ns/HNOq+ZvfefVMM3y5Fw54zT5gEy+67/3Kn52bD6V3JqccsA54T+PPGt5z6rZ
        9qxVOtVViw1POarVPylnZbxr1cWw2Hr9h8+cHk7FQaF+D1WXFK5d09DowlTxVUB/xzMvJZbi
        jERDLeai4kQAEk/QtJwCAAA=
X-CMS-MailID: 20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47
References: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190201164718eucas1p1bca3a199d60e109e1da654d8afff2a47@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new IDs for clocks used by Dynamic Memory Controller in
Exynos5422 SoC.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 include/dt-bindings/clock/exynos5420.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
index 355f469..0d00fbb 100644
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
@@ -217,6 +228,8 @@
 #define CLK_MOUT_EPLL		657
 #define CLK_MOUT_MAU_EPLL	658
 #define CLK_MOUT_USER_MAU_EPLL	659
+#define CLK_MOUT_SCLK_SPLL	660
+#define CLK_MOUT_MX_MSPLL_CCORE_PHY	661
 
 /* divider clocks */
 #define CLK_DOUT_PIXEL		768
@@ -248,8 +261,9 @@
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

