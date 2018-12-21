Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F7FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B735E21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n17Qm+hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403845AbeLUOcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:32:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55435 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbeLUOcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:32:53 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181221143251euoutp02497b995a60f735cfee592d9d7f0d9ac8~yX6ISQCom2385623856euoutp02N;
        Fri, 21 Dec 2018 14:32:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181221143251euoutp02497b995a60f735cfee592d9d7f0d9ac8~yX6ISQCom2385623856euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545402771;
        bh=ahkRAumYYAICvmE7+o7dBuBDPekBlTqo0/YrzIL35s0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=n17Qm+huQG3wQbj+Oo716OmeIUR1KT++6jtUjxmoKli/4Px81cH5PTeSUVhFrhZWJ
         EAdLl1Zd5EGlRItw+ZrZQ6ZP99DzvXhLEhRh74OD4jd/yBywv7lgyrwb9Qn7+BU0xy
         9bSjrQJcZ9Gn+PTwt13ez9NV50PBLY7qso3RtYhM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181221143251eucas1p1d83383710c83ae0694a732a072090977~yX6HyglzX1745117451eucas1p1v;
        Fri, 21 Dec 2018 14:32:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A8.DF.04441.299FC1C5; Fri, 21
        Dec 2018 14:32:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181221143250eucas1p120b2d4dbcb990c5893e0fa4c6a7dd861~yX6G2Mb7O2463724637eucas1p1x;
        Fri, 21 Dec 2018 14:32:50 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-ef-5c1cf9928643
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 66.AC.04128.199FC1C5; Fri, 21
        Dec 2018 14:32:49 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PK3006BBCEKWR10@eusync4.samsung.com>;
        Fri, 21 Dec 2018 14:32:49 +0000 (GMT)
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
Subject: [PATCH v2 1/4] mfd: exynos-lpass: Enable UART module support
Date:   Fri, 21 Dec 2018 15:32:28 +0100
Message-id: <20181221143228.934-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181221103907.GK13248@dell>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWy7djP87qTfsrEGEzdZmOxccZ6VovTn7ax
        WzQvXs9mcf78BnaL+1+PMlpc3jWHzWLG+X1MFmcW97JbrD1yl93i8Jt2VosZk1+yOXB7bFrV
        yeZx59oeNo/9c9ewe/RtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfG8c1H2AvW81b0rrnH2MC4
        kruLkZNDQsBEYumHlWxdjFwcQgIrGCUm7jvDDuF8ZpToPf6TsYuRA6xqwX9NkAYhgWWMEiuO
        GUPUNDBJzHi5ggkkwSZgKNH1tosNxBYRSJZ4NvcII0gRs8BDJomOi99YQBLCAq4Ss84uZQWx
        WQRUJVbt6QRr4BWwljhx+Tg7xEnyEqs3HGAGsTkFtCR+dpxnBRkkIbCCTeL/+n9sEEUuEv+O
        XWGBsIUlXh3fAtUsI3F5cjcLREMzo0T7jFnsEE4Po8TWOTuguq0lDh+/CHYGswCfxKRt05kh
        /uSV6GgTgijxkPjbdYEF4udaibPPu1gnMEouYGRYxSieWlqcm55abJiXWq5XnJhbXJqXrpec
        n7uJERipp/8d/7SD8eulpEOMAhyMSjy8E77JxAixJpYVV+YeYpTgYFYS4e2wBQrxpiRWVqUW
        5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpg9LOK3lBu+ZbFxN75BvPN
        t0dStbK3K+b8bP393jv1vb7q83znRSJmT3zSdVuu7r/QYNAbHrAuIyk2rUrk+KcN6t9EDdfV
        7ViRsnPxXdur+TuPsdt7TkhvqK/neMdv9/WP+ab7s0o1wics4nPPOPtO1lLr37Qq47kFbdwW
        4Soxv1y9zsWdFNunxFKckWioxVxUnAgAGmlgy9ACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsVy+t/xa7oTf8rEGOybYmWxccZ6VovTn7ax
        WzQvXs9mcf78BnaL+1+PMlpc3jWHzWLG+X1MFmcW97JbrD1yl93i8Jt2VosZk1+yOXB7bFrV
        yeZx59oeNo/9c9ewe/RtWcXo8XmTXABrFJdNSmpOZllqkb5dAlfG8c1H2AvW81b0rrnH2MC4
        kruLkYNDQsBEYsF/zS5GLg4hgSWMErffXWeGcJqYJBovHmTpYuTkYBMwlOh628UGYosIJEvs
        +vuCFaSIWeAxk8SUlhdgRcICrhKzzi5lBbFZBFQlVu3pBGvgFbCWOHH5ODuILSEgL7F6wwFm
        EJtTQEviZ8d5VpArhAQ0Jb585prAyLOAkWEVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYIht
        O/Zzyw7GrnfBhxgFOBiVeHgnfJOJEWJNLCuuzD3EKMHBrCTC22ELFOJNSaysSi3Kjy8qzUkt
        PsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cCYaC4tPMv78CPOlmpRyeCbL+s7H+R9
        37TE6YKk4KY3HC7xf3jePNFq/qpxspfx43Xta4c3eTzii2mTKFZPDcnt9ZquZK7FfiM2vffy
        wm/Nh24VXrDwv+OlkT9j7t7LB7xbTrF9UupdzCPCwePb2cMrVtXQpm3a+NXx6TTtiFNu++21
        you+rldiKc5INNRiLipOBAB5jaCRLQIAAA==
X-CMS-MailID: 20181221143250eucas1p120b2d4dbcb990c5893e0fa4c6a7dd861
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181221143250eucas1p120b2d4dbcb990c5893e0fa4c6a7dd861
References: <20181221103907.GK13248@dell>
        <CGME20181221143250eucas1p120b2d4dbcb990c5893e0fa4c6a7dd861@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beomho Seo <beomho.seo@samsung.com>

This patch enables proper interrupts routing between UART module
in Exynos Audio SubSystem and the rest of the SoC. This routing is
completely transparent for UART device and CPU/GIC. UART driver requests
interrupts from the respective controller and enables/masks/handles it
by itself via standard methods.

There are boards (for example TM2), which use UART module in Exynos Audio
SubStem for communication with BlueTooth chip.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
[mszyprow: rephrased commit message, added UART reset]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changelog
v2:
- rephrased and extended commit message
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

