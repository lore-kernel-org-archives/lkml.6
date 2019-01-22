Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B078C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366DC217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AlaGbE9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbfAVP0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:26:51 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49941 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbfAVP0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:26:11 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190122152610euoutp015c77483ec6ca6198d505729f631cd332~8NRzkybvG0949409494euoutp01b
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:26:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190122152610euoutp015c77483ec6ca6198d505729f631cd332~8NRzkybvG0949409494euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548170770;
        bh=PzMg4GV1XDi6Y5SAe2HJT0Zvt3QmVJ+RidOcaZENDo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AlaGbE9RmLmITcB29dIxsP16Bn54zs0oFR4x/tKueV+4ITNSUYPxBeR9DQLuQ+Xc9
         D6eXeIVx6pYgpcUdjvBrxlR8idWoyUPd3yNuWAeP3j1eBMAK2Adb5llFt2fuLq4xZC
         POKwTQRzxhzZ23YqLauDjLGfntP2C+7thcdHZ8zk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190122152609eucas1p103a9a571fc41292b09fde7fa3aea0051~8NRy10WV20988509885eucas1p1B;
        Tue, 22 Jan 2019 15:26:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C1.69.04294.016374C5; Tue, 22
        Jan 2019 15:26:08 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190122152608eucas1p298d06d6b1232a37be8c1679b7a626811~8NRyCKGhr1516415164eucas1p2q;
        Tue, 22 Jan 2019 15:26:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190122152608eusmtrp2b595d28960f2e91462f7dc6a187ae25a~8NRxzLEdf0539205392eusmtrp2U;
        Tue, 22 Jan 2019 15:26:08 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-e4-5c4736106842
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.89.04284.016374C5; Tue, 22
        Jan 2019 15:26:08 +0000 (GMT)
Received: from AMDC3218.DIGITAL.local (unknown [106.120.51.18]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190122152607eusmtip26678e806b1a425d762ce8cf308001c7a~8NRxQ2SVb0472704727eusmtip27;
        Tue, 22 Jan 2019 15:26:07 +0000 (GMT)
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
Subject: [PATCH v1 1/3] arm64: dts: exynos: add SlimSSS for Exynos5433
Date:   Tue, 22 Jan 2019 16:25:51 +0100
Message-Id: <20190122152553.1537-2-k.konieczny@partner.samsung.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190122152553.1537-1-k.konieczny@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87oCZu4xBv+eWVpsnLGe1WL+kXOs
        Fn37/jNa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbdYev0ik0Xr3iPsDtwea+at
        YfTYtKqTzWPzknqPg+/2MHn0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXxrzpuxgL+jkqWq8u
        Ym1gfMrWxcjJISFgInHl62XWLkYuDiGBFYwSEzqmMoEkhAS+MErcfGsOkfjMKDG99wArTMf8
        Z6tZIBLLGSX+HTjPDOEAdXx91g/WziZgLvFo+xkwW0RAWWLyvelgRcwC/5kkFt5ZArScg0NY
        wE2i+2IOSA2LgKrE9U1rwep5BZwl/r3uZ4bYJi8xbXUXWJxTwEXi/KlVrBA1ghInZz5hAbGZ
        gWqat84Gmy8hsIld4mnbArD5EkANN47UQMwRlnh1fAs7hC0j8X/nfCYIu1xi99Zn7BC9LYwS
        cycvgkpYSxw+fpEVZA6zgKbE+l36EGFHiRWbZzJCjOeTuPFWEOIEPolJ20BeBAnzSnS0CUFU
        60rM+38GGm7SEl3/10HZHhK7rx5gmsCoOAvJM7OQPDMLYe8CRuZVjOKppcW56anFRnmp5XrF
        ibnFpXnpesn5uZsYgYnp9L/jX3Yw7vqTdIhRgINRiYc34YJrjBBrYllxZe4hRgkOZiURXteL
        bjFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUaGKMj3x9r
        +HOi+W+niuuzuNDmPQERd7lb5qtEqs1dwyJkyFfCV1uSWrj3ydUGdZYpv5ZHfjn86g9/8drl
        f5f94bbvtWZ502DQ1rfgjpqrYJ7TPV+7lMdTovcc0WS3UV1wNTZJ60dt1Xb778KqG/XNeKfL
        Xi/bs9bn/pfo3if+UVd1WaMsr5znVWIpzkg01GIuKk4EAEbUAAhIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7oCZu4xBmcfcFlsnLGe1WL+kXOs
        Fn37/jNa9D9+zWxx/vwGdotNj6+xWlzeNYfNYsb5fUwWa4/cZbdYev0ik0Xr3iPsDtwea+at
        YfTYtKqTzWPzknqPg+/2MHn0bVnF6PF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexrzpuxgL+jkqWq8uYm1gfMrWxcjJISFgIjH/2WqW
        LkYuDiGBpYwSK+f9YYJISEs0nl4NZQtL/LnWxQZR9IlR4sXCY2DdbALmEo+2nwErEhFQlph8
        bzozSBGzQDuzxJrd24CKODiEBdwkui/mgNSwCKhKXN+0FqyeV8BZ4t/rfmaIBfIS01Z3gcU5
        BVwkzp9axQpiCwHVPJ4whxWiXlDi5MwnLCA2M1B989bZzBMYBWYhSc1CklrAyLSKUSS1tDg3
        PbfYUK84Mbe4NC9dLzk/dxMjMIq2Hfu5eQfjpY3BhxgFOBiVeHg5zrnGCLEmlhVX5h5ilOBg
        VhLhdb3oFiPEm5JYWZValB9fVJqTWnyI0RToiYnMUqLJ+cAIzyuJNzQ1NLewNDQ3Njc2s1AS
        5z1vUBklJJCeWJKanZpakFoE08fEwSnVwDi5q3o976O5ilbLhfcm7l975V3v9yW+ZQ6x/Mmq
        ks3u2yt83iypNTxlxfjxXf5ylUKjpwcMwpp6En6xKlqebpBVD68O2yB0e87sBzPXFjjJOa+S
        b0wolH9Q9ELae9azvVFln9Lu7vDXfmhXFfNQmuuJZfCD4LqX8x+rmT8LvzdlbfJzDhaZhUos
        xRmJhlrMRcWJAH8RkzG4AgAA
X-CMS-MailID: 20190122152608eucas1p298d06d6b1232a37be8c1679b7a626811
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190122152608eucas1p298d06d6b1232a37be8c1679b7a626811
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190122152608eucas1p298d06d6b1232a37be8c1679b7a626811
References: <20190122152553.1537-1-k.konieczny@partner.samsung.com>
        <CGME20190122152608eucas1p298d06d6b1232a37be8c1679b7a626811@eucas1p2.samsung.com>
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

