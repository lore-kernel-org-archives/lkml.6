Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA1C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3EF2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="co2x3nxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfA1TWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:22:06 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58484 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbfA1TV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:21:57 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190128192156euoutp01b89abc3cb037bbb8e98082275b223aa5~_GXX1HcQj2889728897euoutp01O
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 19:21:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190128192156euoutp01b89abc3cb037bbb8e98082275b223aa5~_GXX1HcQj2889728897euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548703316;
        bh=cwdR9PeB9U1fbRaysP0X7KBDHK6TquXGExqnRLFnqnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=co2x3nxV3MBoF/rhldeOwICfi3OwrPxcmprvCZv3zmB7sA++Bf/n10e7DdBX4vhTk
         5JtctMIZlNL9P2uZvZnLn9GGKQlQg4577TOsZDHy9GX9y5JV9TsWiVOmoBKcjJ/u9X
         NDxaaEt4CdQbnx1Iyi3X8kaFi1F52mdXrtjIne/w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190128192155eucas1p249d2972b148df85114a9bc89e141808d~_GXXTGe5_1921719217eucas1p2z;
        Mon, 28 Jan 2019 19:21:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7B.C5.04294.3565F4C5; Mon, 28
        Jan 2019 19:21:55 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190128192154eucas1p2719b339d9dd0d11468fd8e8ab171e84e~_GXWbYCST3048430484eucas1p2T;
        Mon, 28 Jan 2019 19:21:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190128192154eusmtrp1ff41b44eeca953815d194c1c0fdf90a1~_GXWHiIiS2976329763eusmtrp1Q;
        Mon, 28 Jan 2019 19:21:54 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-9d-5c4f56536d3c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5B.F8.04284.2565F4C5; Mon, 28
        Jan 2019 19:21:54 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190128192153eusmtip1e5f2511b307e1602204973764579fb8d~_GXVmQPGc0144001440eusmtip1K;
        Mon, 28 Jan 2019 19:21:53 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] drivers: devfreq: events: add Exynos PPMU new events
Date:   Mon, 28 Jan 2019 20:21:38 +0100
Message-Id: <1548703299-15806-8-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzned3gMP8Yg4t/JS02zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdouzTW/YLW41yFhsenyN1eLyrjlsFp97jzBazDi/j8niduMKNgce
        j02rOtk8Ni+p9zj4bg+TR9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGUcmDiFpeAyZ8XSL2/Y
        GhjXc3QxcnJICJhING2cwdzFyMUhJLCCUWL31G+MEM4XRolbi39DZT4zSvw//5MJpmXHsefs
        EInljBLPdixjgmvpeLmNrYuRg4NNQE9ix6pCkAYRATmJm1/vsoHUMAu8YZK49/QFK0hCWMBT
        4sSOC+wgNouAqsSivq9gG3gFvCS+/1vHDLENqPlcJ5jNKeAtcbpvAdh9EgKT2SUmP17CDrJM
        QsBF4vvsPIh6YYlXx7ewQ9gyEqcn97BA2MUSZztWsUHYNRLtJ3dA1VhLHD5+kRVkDLOApsT6
        XfoQEx0lJjwwgjD5JG68FQQpZgYyJ22bzgwR5pXoaBOCmKEhsaXnAjR0xCSWr5kGNdtD4sr9
        I2C2kMA8RomHZzMnMMrPQli1gJFxFaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmAyOf3v
        +JcdjLv+JB1iFOBgVOLhNWDzjxFiTSwrrsw9xCjBwawkwjv1ul+MEG9KYmVValF+fFFpTmrx
        IUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBsZmi9WMCSfSJ0c5CUq35a7rSO0Vveie
        dufsVq7LH73eu0ezzgiyyv2rVlveoZBueVrs3fQXxnIfZ021WKCeO/WMR7rpPi35XqGN1qIM
        C+LXHzq43Fxk3jTejJPXBL9PPJZ9sOCi5S/+BSZHHQ/ke3U9XDPRfUr267lrYm5s59/i9e5Y
        6fENUipKLMUZiYZazEXFiQDMMvzkIgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xu7pBYf4xBgcOS1hsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XlXXPYLD73HmG0mHF+H5PF7cYVbA48
        HptWdbJ5bF5S73Hw3R4mj74tqxg9Pm+SC2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
        MzQ2j7UyMlXSt7NJSc3JLEst0rdL0Ms4MHEKS8FlzoqlX96wNTCu5+hi5OSQEDCR2HHsOXsX
        IxeHkMBSRonP/96wQSTEJCbt284OYQtL/LnWxQZR9IlR4nTTTOYuRg4ONgE9iR2rCkFqRATk
        JG5+vQtWwyzwjUni4+4TTCAJYQFPiRM7LoANYhFQlVjU9xUszivgJfH93zpmiAVAzec6wWxO
        AW+J030LGEFsIaCa6ZNfsExg5FvAyLCKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMMS3Hfu5
        eQfjpY3BhxgFOBiVeHgN2PxjhFgTy4orcw8xSnAwK4nwTr3uFyPEm5JYWZValB9fVJqTWnyI
        0RToqInMUqLJ+cD4yyuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnV
        wMj25oHp1PaHd1c9MJ31qC0steZSi/xHrfeGNmJ758mfvPApraxws0nDY6mUwJWy6mcVXj6d
        LZ569kZMe940HjP7VWnCnQstP5/OD76UWCkxPyWSNSJIPMRoLavG6/KcF6euZ0yaY/Tl/80X
        C4Q37W9cO3vWlwdXJ8elf8tWt7vgXPCgOVbxxVslluKMREMt5qLiRADGXib7hwIAAA==
X-CMS-MailID: 20190128192154eucas1p2719b339d9dd0d11468fd8e8ab171e84e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190128192154eucas1p2719b339d9dd0d11468fd8e8ab171e84e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192154eucas1p2719b339d9dd0d11468fd8e8ab171e84e
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190128192154eucas1p2719b339d9dd0d11468fd8e8ab171e84e@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define new performance events supported by Exynos5422 SoC counters.
The counters are built-in in Dynamic Memory Controller and provide
information regarding memory utilization.

CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: MyungJoo Ham <myungjoo.ham@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: linux-pm@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-samsung-soc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index c61de0b..67d6674 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -89,6 +89,12 @@ static struct __exynos_ppmu_events {
 	PPMU_EVENT(d1-cpu),
 	PPMU_EVENT(d1-general),
 	PPMU_EVENT(d1-rt),
+
+	/* For Exynos5422 SoC */
+	PPMU_EVENT(dmc0_0),
+	PPMU_EVENT(dmc0_1),
+	PPMU_EVENT(dmc1_0),
+	PPMU_EVENT(dmc1_1),
 };
 
 static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
-- 
2.7.4

