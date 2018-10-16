Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B612C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09401205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SZxoLXbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09401205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeJPWro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:47:44 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57299 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeJPWro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016145653euoutp0155fadb4d2090f645dba2da4e0a1a1e69~eHqQ2k7WL0565605656euoutp01e
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:56:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016145653euoutp0155fadb4d2090f645dba2da4e0a1a1e69~eHqQ2k7WL0565605656euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539701813;
        bh=sHvMKeTOPG+IldA992rEfPKQzvL1CjPS6hXEKMWqtj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZxoLXbZNkoRKuKjLLN1SHLBw/NIMtt1e4TPSAyr6MKQqrlV++MEMUUJ3BHBvgARy
         Dbd7XPqf0ZIvQo4QT+GXSSP2NtI7AliEcosBTepf+32zd/aphHjIyntR8xp1/0PrRw
         K1HonN7d5JN3FtEaVb7qFjq/nC4rWJzDye7MRzVc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016145652eucas1p1f5c98ae5ecc067e98bc9b89b589a921c~eHqP_eE-t2005420054eucas1p1i;
        Tue, 16 Oct 2018 14:56:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CB.C2.04441.33CF5CB5; Tue, 16
        Oct 2018 15:56:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8~eHqPK-tM31616816168eucas1p1y;
        Tue, 16 Oct 2018 14:56:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016145651eusmtrp2d8d81cdd81f631cc5052e64ea3c7c49d~eHqO8C9Y93061930619eusmtrp2f;
        Tue, 16 Oct 2018 14:56:51 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-df-5bc5fc332a16
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.BA.04128.33CF5CB5; Tue, 16
        Oct 2018 15:56:51 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145650eusmtip263aa579161d6829f17331a9a964d8113~eHqOYAYyj2834528345eusmtip2H;
        Tue, 16 Oct 2018 14:56:50 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 09/11] DT: arm: exynos: add support for thermal trip
 irq-mode
Date:   Tue, 16 Oct 2018 16:56:20 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHeXd2zo7T1XGKvt5hEKXkTJI4kGlaHw5I6IcK0g+19DRFnbrj
        HUODvKIzM6yWqDV1MczLNFOxTJ1KmnNeUBtKiCZoadJKZ3TzdBZ9+z+/5/J/3ocXR8TPUXc8
        QZFOKxWyJAkm5HeP7hv9g36MxJwoyiI7HrSh5NrrYkDWWbzIeoMRJevn5lGycvUjQk5NtQtI
        c4EnqV89QI+LGvnkbF8tRloqDIBsWpjmkYUvDQJybUWFnT1MtdS1AKpXvSygNP0bPEqvK8Wo
        pfl+jOpszKc0qmqUGtzu51GqLh2gLHrvKGG0MDiOTkrIpJUBIdeE8a1an9RyUfZK4RpWAEzC
        MmCHQyIIWh8u8cuAEBcTTwHc3LcK2ISY+Apgoy6fS1gANG8tIWUA/9uxN3OR41oAd0zzPC44
        aFhq3gFsEUZIYY8ujeXOxCMALa80AjZAiCoerNKuo6yFExEJGwa1gNV84gj8XHpbwO3kDd8Z
        SxFW2xER0LzYgHB8XAA3Ok+yWkRkQqOqxcbPwwH9C8BpJ7g51mWb4wl/99bzOM3AyRIdxuk8
        WPymx1ZzGg6PTaPs0gjhC9v6AjgcBke29Sj34ENwccuRxciBvNt933YHESwpEnPVx2BXuclm
        5AK1LTW24RT82TCLcuepA7DqVj92B/io/5s1AKADrnQGkyynmUAFnSVlZMlMhkIujU1J1oOD
        zzTxa+xLD/g2c30IEDiQOIisC4YYMSrLZHKShwDEEYmzSD4zEiMWxclycmllylVlRhLNDAEP
        nC9xFTXXdcSICbksnU6k6VRa+S/Lw+3cC0D1bvTobu6F9Y0V9ZP9e3PTKmJZWhDqEul3abLS
        3BoSPBr+qSo+aSovKr99oFZxbgvPc4y9rPrwzJ+cvRJmWMBliSETaW4Vu/Y1kZ1HsWxp2VxT
        mrfV+T2oUQdqzL7HsVMmr+G3fLVpJuLm9vgNQITb761+L/WocAjVuJ0Jn5LwmXhZoB+iZGR/
        AIv9yh1IAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7rGf45GGyxs57LYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFv2PXzNbnD+/gd3iVoOMxabHQKGFbUtYLC7vmsNm8bn3CKPF0usX
        mSxa9x5ht3jysI/Ngd9jzbw1jB47Z91l91i85yWTx6ZVnWwed67tYfPYvKTeY3HfZFaPg+/2
        MHn0bVnF6PF5k1wAV5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpq
        TmZZapG+XYJexrrl8gU9vBUPW5+wNTBe4Opi5OCQEDCR+H4ppIuRi0NIYCmjxP1165i6GDmB
        4mISk/ZtZ4ewhSX+XOtigyj6xCix6v4kJpBmNgE9iR2rCkHiIgLzGSWObroMVsQsMJdJYmXD
        crBJwgK+EhtWfGAFsVkEVCXed7aATeUV8Ja4M/8/G8QGOYmb5zqZQWxOoPitGwuYQRYICXhJ
        XFzMOIGRbwEjwypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAaNl27OeWHYxd74IPMQpwMCrx
        8P64fiRaiDWxrLgy9xCjBAezkghv+qWj0UK8KYmVValF+fFFpTmpxYcYTYFumsgsJZqcD4zk
        vJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjOEv/JO68gQ2K/tZ
        iTE++HNRyuLvz1dbKmzn2rAtnqMva9Ummn8tnmuR4ZrmCDvHlr60jILbR64IbOmxPuJe7DzX
        gHnuqevsQoeYHPbo73c6fodr6eKp+7LiNM4428i5/y6MU2fbbdPJcXnD/Ndl/qom9ZrcGwt/
        Obw6sqVWOiyOVfFo+lYRJZbijERDLeai4kQAgcsleqwCAAA=
Message-Id: <20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8~eHqPK-tM31616816168eucas1p1y@eucas1p1.samsung.com>
X-CMS-MailID: 20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for new flash which indicates
that trip point triggers irq when temperature is met.
Exynos5433 supports 8 trip point which will trigger irq.
Above that number other trip points should be registered
without 'irq-mode' flag.
That will force the thermal framework to start polling
the temperature sensor under configured conditions and
handle the trip point.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5420-trip-points.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-trip-points.dtsi b/arch/arm/boot/dts/exynos5420-trip-points.dtsi
index a67a3807..9e16970 100644
--- a/arch/arm/boot/dts/exynos5420-trip-points.dtsi
+++ b/arch/arm/boot/dts/exynos5420-trip-points.dtsi
@@ -11,21 +11,25 @@ trips {
 	cpu-alert-0 {
 		temperature = <85000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "active";
+		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-1 {
 		temperature = <103000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "active";
+		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-2 {
 		temperature = <110000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "active";
+		type = "passive";
+		irq-mode;
 	};
 	cpu-crit-0 {
 		temperature = <120000>; /* millicelsius */
 		hysteresis = <0>; /* millicelsius */
 		type = "critical";
+		irq-mode;
 	};
 };
-- 
2.7.4

