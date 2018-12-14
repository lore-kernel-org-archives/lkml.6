Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD8C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E667D21104
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YMKuDdp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E667D21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbeLNLe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:34:26 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38122 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeLNLeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:34:19 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181214113417euoutp01e23e87ac84918eb5bdb116f340422ded~wL9OImJqL0645006450euoutp01K;
        Fri, 14 Dec 2018 11:34:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181214113417euoutp01e23e87ac84918eb5bdb116f340422ded~wL9OImJqL0645006450euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544787257;
        bh=ZEfoROt+XjAokHVeJM29CvElIc1nKx1oX3xABzSZfDQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=YMKuDdp/MvcLw4KpSN2bBDSlWTZFCq9lzqejR5AxOWb52hd12tCTQuH4myboXLHpS
         zs7xMqdcHK5c9NPAgVmZrTLaXzZ7Pa0kjzQIdccXxIzPJyy/GhluurGZpiU3CsMc2l
         NQSJaZCSDlBIZ5u4r9OBuSRoYvSMyNm0roNe1pBY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181214113417eucas1p13f7a87535a00c22d76103050837d22cd~wL9NrRKRk2296922969eucas1p1B;
        Fri, 14 Dec 2018 11:34:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4C.A2.04806.835931C5; Fri, 14
        Dec 2018 11:34:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181214113416eucas1p2002adf7b5438c525c34ff3274ceacbd1~wL9Mz9P8N2195821958eucas1p2N;
        Fri, 14 Dec 2018 11:34:16 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-75-5c139538c3ca
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BA.D8.04284.835931C5; Fri, 14
        Dec 2018 11:34:16 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PJQ004655GZZA10@eusync3.samsung.com>;
        Fri, 14 Dec 2018 11:34:16 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/4] mfd: exynos-lpass: Enable UART module support
Date:   Fri, 14 Dec 2018 12:34:07 +0100
Message-id: <20181214113410.22848-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181214113410.22848-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7djPc7oWU4VjDPqaLCw2zljPanH60zZ2
        i+bF69kszp/fwG5x/+tRRovLu+awWcw4v4/J4sziXnaLtUfuslscftPOajFj8ks2B26PTas6
        2TzuXNvD5rF/7hp2j74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4Mp41HCFpeAOV8Wkx8/YGxgn
        cHYxcnJICJhI/Lq8lqWLkYtDSGAFo8Tqk+uYIJzPjBIf53xigqla2X+IGSKxjFFiy60+VpCE
        kEADk8SCrnwQm03AUKLrbRcbiC0ikCzxbO4RRpAGZoGHTBIdF78B7eDgEBZwkjj4PQWkhkVA
        VeL3ikZ2EJtXwFbi5oZ3UMvkJVZvOMAMYnMK2Ekc27KJHWSOhMAKNone/7cYIYpcJO4dfcMK
        YQtLvDq+hR3ClpHo7DjIBNHQzCjRPmMWVHcPo8TWOTvYIKqsJQ4fvwjWzSzAJzFp23RmkOsk
        BHglOtqEIEwPib5PeRAfT2SU2Hb7J9sERskFjAyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLz
        czcxAiP19L/jX3cw7vuTdIhRgINRiYf3xGyhGCHWxLLiytxDjBIczEoivGGtwjFCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGA/G9Jyszu6LDWGvLHF9
        a+r2bua66Vs9Ftften61Z+fFhI8cU7vurNnwu+nAg9g5z9yyls7b5Xn7cXpq4k/j2RNdWd5N
        28j+7tLnlR2Wyi8qVNenykjrsDf9ilsRZ/BLL1+HofJ7/XJbyQztuvczlY1tuspFDOs4hT23
        hz+TevBeyOwrc8BVDiWW4oxEQy3mouJEANlaxTfQAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t/xq7oWU4VjDD7NELLYOGM9q8XpT9vY
        LZoXr2ezOH9+A7vF/a9HGS0u75rDZjHj/D4mizOLe9kt1h65y25x+E07q8WMyS/ZHLg9Nq3q
        ZPO4c20Pm8f+uWvYPfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugSvjUcMVloI7XBWTHj9jb2Cc
        wNnFyMkhIWAisbL/EHMXIxeHkMASRokHGyayQDhNTBLHpy9lBqliEzCU6HrbxQZiiwgkS+z6
        +4IVpIhZ4DGTxJSWF0AdHBzCAk4SB7+ngNSwCKhK/F7RyA5i8wrYStzc8I4JYpu8xOoNB8Bm
        cgrYSRzbsgmsRgio5uv0L4wTGHkWMDKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECAyybcd+
        bt7BeGlj8CFGAQ5GJR7eA1OEYoRYE8uKK3MPMUpwMCuJ8Ia1CscI8aYkVlalFuXHF5XmpBYf
        YpTmYFES5z1vUBklJJCeWJKanZpakFoEk2Xi4JRqYMxQ/e+hHqxxT/zMudQtgvlm1dIrOla4
        Tfk/7cu2mftWzVm6UfT59xnrDy+atut6V5hI4aG5h15lHFjomL6I61faucIIlwdHKs+mK73r
        qJSsUbSY5bF7+mXDRyfvFNr9Dbv3U/P959uJi9VnX5bm+h2Tr3o7SKb8RVTcqk79N+5qW36I
        HeA2XpCuxFKckWioxVxUnAgAdMH28S4CAAA=
X-CMS-MailID: 20181214113416eucas1p2002adf7b5438c525c34ff3274ceacbd1
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214113416eucas1p2002adf7b5438c525c34ff3274ceacbd1
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
        <CGME20181214113416eucas1p2002adf7b5438c525c34ff3274ceacbd1@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beomho Seo <beomho.seo@samsung.com>

This patch enables support for UART module in Exynos Audio SubSystem.
There are boards (for example TM2), which use it for communication with
bluetooth chip.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
[mszyprow: rephrased commit message, added UART reset]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/mfd/exynos-lpass.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index ca829f85672f..2713de989f05 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -82,11 +82,13 @@ static void exynos_lpass_enable(struct exynos_lpass *lpass)
 		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
 
 	regmap_write(lpass->top, SFR_LPASS_INTR_CPU_MASK,
-		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
+		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S |
+		     LPASS_INTR_UART);
 
 	exynos_lpass_core_sw_reset(lpass, LPASS_I2S_SW_RESET);
 	exynos_lpass_core_sw_reset(lpass, LPASS_DMA_SW_RESET);
 	exynos_lpass_core_sw_reset(lpass, LPASS_MEM_SW_RESET);
+	exynos_lpass_core_sw_reset(lpass, LPASS_UART_SW_RESET);
 }
 
 static void exynos_lpass_disable(struct exynos_lpass *lpass)
-- 
2.17.1

