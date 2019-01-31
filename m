Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B935C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDC2218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eq1kM6kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfAaIub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:50:31 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49076 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfAaIuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:50:14 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190131085009euoutp01f734af4461d08b0f8afcd135f9488524~_4rnNXKlo2230222302euoutp01s
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 08:50:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190131085009euoutp01f734af4461d08b0f8afcd135f9488524~_4rnNXKlo2230222302euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548924609;
        bh=gAM5TRktEeGRdR7DfQ1QhDkjvwroBHzBH5M4lKDBh1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eq1kM6kjwX3NI2/vmcw1895n+GZVTpS0bDBDqWLPb62r0QFdl5vYz5sDRBQCZ8M6d
         ksAfdBh3rXwklbqzQOmj1h8IcVYB37qcd4T5y6HYKtJg6uU7JAdG8GHp08wNeFqTlJ
         nvvKb9G+DM5sM+3x8DZCQaRk4OYqJsqbTOva5q7k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190131085008eucas1p2ba839b83132ff9ec44e10359baa62cfc~_4rmSVvQu1766917669eucas1p2Q;
        Thu, 31 Jan 2019 08:50:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 32.2C.04294.0C6B25C5; Thu, 31
        Jan 2019 08:50:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190131085007eucas1p2f16107042b8ce5638811840618bcf017~_4rlfbQr92508525085eucas1p2o;
        Thu, 31 Jan 2019 08:50:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190131085007eusmtrp2215325dae20568f3f1fe00cb1c4725a3~_4rlOzgi42341223412eusmtrp2b;
        Thu, 31 Jan 2019 08:50:07 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-9c-5c52b6c0c7b8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B6.7B.04128.FB6B25C5; Thu, 31
        Jan 2019 08:50:07 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190131085006eusmtip1d88b419e5223447199ba87ec5d9ab703~_4rkeoV8E1303413034eusmtip1G;
        Thu, 31 Jan 2019 08:50:06 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos 5422
 SoC
Date:   Thu, 31 Jan 2019 09:49:49 +0100
Message-Id: <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRj229nZOYpHj0fJLzODkVBKmhH1gV0MKpYh2gWJMmrpYQ6v7XjJ
        tJrmdWiKUEpp+kPQlqIulTUv2SaK5mVieEktRWqlZoWjCG85z6p/z/dc3ud94SMx5hnuRspj
        E1hFrDRaLLITtnT/HtzX2XI+bL+mgEaNpfU4GjObcFTRNYijwrkFDA0NNRBoIGORQO+U7kgz
        N4qjH/nvcTSiKxOh5YIugEqHOgSormuaQMN9p9Bkeo0IGRZzcLQ+2igMcJJ8G88iJBp1nkjy
        ouqe5PVSm0DyoEkNJMsajxDRZbsjEWy0PIlV+B67bhfZ3roqjNcytxp0mYQSfHdUAVsS0gdh
        lumjUAXsSIauAbBW1QP4hxnAeUO3VVkGsLL3E64C5FbEaIrn+WoA+/srRf8SqpJpwmIS0T5Q
        q75pqXChU+HU2CvM4sFoJQa1GUVCi+BMB8OsX7MCi19Ie8KyNk8LTdGBUDtfQPDrecCJwTzM
        gm3ps7BKtYbxfAcBzT9xHp+Ea8ZqK+8M53uarFl3uPGyQsBjDg7kqkU8ToM5vVqrxx8aeoa3
        7sLovbBe56sCxCZ9ArYH8Mc6wPGvThYvtgmLW0ownqZgbjbDj9gDm/KN1pptsLr2kXW0BBaX
        F29VMvRTAMc6/IvArsf/myoBUANXNpGLkbHcgVg22YeTxnCJsTKf8LgYDdj8QG/We8xaoFu9
        oQc0CcT21EzduTAGlyZxKTF6AElM7EL5rQSHMVSENOU2q4i7pkiMZjk92EEKxa5Uqs3MFYaW
        SRPYKJaNZxV/VQFp66YE3p+nvkTqAwckq0m1FVTb5KFOZmEGKtcNWGeIMWS7FxU6dGluZqIj
        Sm56GOR9eilNrC6X3fVonn7iN6YevNMbburb2J3ukOzj6BWw2Jxhlgcdbh05XthvjLTJZnc2
        Jd7vzzxKrVz0g2c8oijD8w+erkZdyQUn+9DKWflb+mq3WMhFSv28MAUn/QPzdQXiPAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4Xd3924JiDF40CFpsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XHnnusFpd3zWGz+Nx7hNFixvl9TBZr
        j9xlt7h4ytXiduMKNovDb9pZLf5d28jiIOjx/kYru8emVZ1sHpuX1HscfLeHyaNvyypGj8+b
        5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQy
        9u7+w1KwQ6hiw64W9gbGD/xdjBwcEgImEheeF3QxcnEICSxllJizax1TFyMnUFxMYtK+7ewQ
        trDEn2tdbBBFnxglWpovsoA0swnoSexYVQhSIyJQL9H/5hJYDbNAH7NE4/HFrCAJYQFfiaO/
        V7CD1LMIqErM2aMKEuYV8JLY8aoXar6cxM1zncwgNqeAt8SSrr9gthBQzY9/HxknMPItYGRY
        xSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERgZ24793LKDsetd8CFGAQ5GJR7eB2sDY4RYE8uK
        K3MPMUpwMCuJ8Br+9o8R4k1JrKxKLcqPLyrNSS0+xGgKdNNEZinR5Hxg1OaVxBuaGppbWBqa
        G5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamDc8krC3jr/htiOv9O8deT+hjqFTTop
        +bDvf8mJb7F3y6xz5l730vl4XCRv5VrZtf7Wk58efD334jO5vHDFxERm/5BLkrX1lnsq1PQq
        QtdPb8gJvLsnoj+v5nn3pj0Mwc0Nb0tjzpdN3ndVtqZVzL9+d5vKjVk68g8vyuee1jB84DO7
        x9T9NrsSS3FGoqEWc1FxIgBD/FAZogIAAA==
X-CMS-MailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
Controller frequencies for driver's DRAM timings.

CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: linux-samsung-soc@vger.kernel.org
CC: linux-clk@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 3e87421..8bf9579 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1325,6 +1325,19 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
 	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
 };
 
+static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
+	PLL_35XX_RATE(24 * MHZ, 933000000, 311, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
+	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
+	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
+	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
+	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
+	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
+	PLL_35XX_RATE(24 * MHZ, 138000000, 184, 2, 4),
+};
+
 static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
 	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
 	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
@@ -1467,7 +1480,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
 		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
 		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
-		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
+		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
 	}
 
 	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
-- 
2.7.4

