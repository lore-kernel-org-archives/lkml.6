Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA99C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65F120881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RIPxgin7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65F120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeJPWr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:47:59 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57299 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbeJPWrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016145655euoutp0142d603f8938e290d3f1eda4d4524d4da~eHqTLLqVU0565605656euoutp01i
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:56:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016145655euoutp0142d603f8938e290d3f1eda4d4524d4da~eHqTLLqVU0565605656euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539701815;
        bh=MnvpqqdEvGeEE5waFkqMHu3DJCETm0FWhKWgd8aEtK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIPxgin7wgBvBQojqPpNYDKe/flCEhUmlbhZwvdNIlz2X5zVOzIAzA9ncX/B13ODt
         dGJOlHlWqOKCCoEIf8gbey8petApoQ/3XWc1gkeyTkYCE75c1BLIS+IrNl0+wV1eBe
         T+DkSoExT3nIbs4RS3o9PD58LTm7csrNK8Ce5ZCg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016145654eucas1p24158e64918caa0ee0a3214127dccd672~eHqSdMeav0771607716eucas1p2A;
        Tue, 16 Oct 2018 14:56:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 71.70.04294.63CF5CB5; Tue, 16
        Oct 2018 15:56:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145653eucas1p2c408ac952ed5c351c98398fa3df373e6~eHqRiOtv50773307733eucas1p20;
        Tue, 16 Oct 2018 14:56:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181016145653eusmtrp160c0ae2dffad8701ad44be0ab0b29b3a~eHqRSP2hD1180411804eusmtrp1B;
        Tue, 16 Oct 2018 14:56:53 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-ed-5bc5fc365541
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A3.E9.04284.53CF5CB5; Tue, 16
        Oct 2018 15:56:53 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145653eusmtip29d4ab85755aa74dcf1929ad513e4f432~eHqQqdvox2834828348eusmtip2F;
        Tue, 16 Oct 2018 14:56:53 +0000 (GMT)
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
Subject: [PATCH 11/11] DT: arm: exynos: add support for thermal trip
 irq-mode
Date:   Tue, 16 Oct 2018 16:56:22 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHfXe2s+NwepqWL15hEpjRrIg6UEn3TheoD33JQbrypJJT2/Ha
        BQeWl6nLGyZac+ZqtSTTpszhvelQSTNLzZwkimGSfpiFpmU7nlXffu//ef7P/+HhxRCRkeeD
        xcYnUYp4WZwYFXCbelYGduxd65bubFwNIerL63jETEc2IDR2f6LKMsAjqt6P8Ih70/MIMTj4
        kk+MK/2IhmmHVJ2l4xLD5gcoYS+wAOLx6BCHuNtq4RMzU2r0kAdZq6kFZHOFjU/WtMxxyAZD
        LkpOjLSg5CtdBlmjLuGRnQstHFJtNADS3hBwXhAuOBBFxcWmUIrQsEhBjGphEU00C9O07SeV
        wCZQAQyD+B64rPdQAVdMhD8FMH/STQUEDl5ysKmDzxbsAD5c9WKY6ddWTfBYXQ+gdfnqP8Pn
        zgo+MxTFJdBkuM7oXnglgPa2Gj7zQPAiDizSz264PfFzsKPv0UYCF98KWwuGUTYhAH4cyEUY
        dsXPwPExLcKYId7Hh2U/KjlMQYinwF67EbCGY3C1sIjDsif8ajXyWfaD/SX5XJZp+CbH4Ay4
        BbN7Tc6e/fC1dYjHbI3g22CdOZSVD8Oe5iUueyF3OPZtEyMjDixuuo+wshDmZInY7mBozH/r
        XGAL1NeWOYeT0Db/yXlDDYDVI3GFILDif5YWAAPwppJpeTRF746nUiW0TE4nx0dLriTIG4Dj
        L/X/ti6ZgHntchfAMSB2Ey6PWqQiniyFTpd3AYghYi9h9LtuqUgYJUu/QSkSIhTJcRTdBXwx
        rthb+ERTLxXh0bIk6hpFJVKKv1UO5uqjBBHHL0xHlX+R94vqLd2ebRfVZ4vDf+ap2/Eg3Z3G
        kEWisyhmts9/AcnUbk8buDm5z/bd3eXIB6HK3NU0l2Gwld6O1OQF+3RkSFaWlWZl5qq1+tdz
        l7DOqc1BGf5HJ+0630DTi27k1HDwQZcg+3q4Z8u6vPTSieLTqX5LuthnLhIxl46R7QpBFLTs
        D9/T8GdHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7qmf45GG1zsVLPYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFv2PXzNbnD+/gd3iVoOMxabHQKGFbUtYLC7vmsNm8bn3CKPF0usX
        mSxa9x5ht3jysI/Ngd9jzbw1jB47Z91l91i85yWTx6ZVnWwed67tYfPYvKTeY3HfZFaPg+/2
        MHn0bVnF6PF5k1wAV5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpq
        TmZZapG+XYJeRte792wFu3grFux3b2C8y9XFyMkhIWAisWD+HdYuRi4OIYGljBLfTjawQyTE
        JCbt2w5lC0v8udbFBlH0iVFi4c5DQB0cHGwCehI7VhWCxEUE5jNKHN10GayIWWAuk8TKhuVM
        IEXCAr4Si965gwxiEVCV2NsLUsPBwSvgLTH1rjzEfDmJm+c6mUFsTqDwrRsLmEFKhAS8JC4u
        ZpzAyLeAkWEVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYKxsO/Zz8w7GSxuDDzEKcDAq8fD+
        uH4kWog1say4MvcQowQHs5IIb/qlo9FCvCmJlVWpRfnxRaU5qcWHGE2BTprILCWanA+M47yS
        eENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2ampBalFMH1MHJxSDYzRxvbzXTI3STQtyfmz
        45Xrx1e6jsdnyd5L1Ut5bzx7QuO+N8rajpfS5vWx5p6w9BaRWCTRk+GeGfqqTi1yb5rfr6kb
        T287GbZefq5wZLTlDV6+m3kdAnHBUxaLK2563v4iYm3Ciige03f7sn/IfqlXs3ockLhlf1Cz
        /8SFYQ/PGAZUsFt17VBiKc5INNRiLipOBAB9BMAtqwIAAA==
Message-Id: <20181016145653eucas1p2c408ac952ed5c351c98398fa3df373e6~eHqRiOtv50773307733eucas1p20@eucas1p2.samsung.com>
X-CMS-MailID: 20181016145653eucas1p2c408ac952ed5c351c98398fa3df373e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145653eucas1p2c408ac952ed5c351c98398fa3df373e6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145653eucas1p2c408ac952ed5c351c98398fa3df373e6
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145653eucas1p2c408ac952ed5c351c98398fa3df373e6@eucas1p2.samsung.com>
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
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index a2046f5..c255466 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -121,22 +121,26 @@
 		cpu_alert0: cpu-alert-0 {
 			temperature = <50000>; /* millicelsius */
 			hysteresis = <5000>; /* millicelsius */
-			type = "active";
+			type = "passive";
+			irq-mode;
 		};
 		cpu_alert1: cpu-alert-1 {
 			temperature = <60000>; /* millicelsius */
 			hysteresis = <5000>; /* millicelsius */
-			type = "active";
+			type = "passive";
+			irq-mode;
 		};
 		cpu_alert2: cpu-alert-2 {
 			temperature = <70000>; /* millicelsius */
 			hysteresis = <5000>; /* millicelsius */
-			type = "active";
+			type = "passive";
+			irq-mode;
 		};
 		cpu_crit0: cpu-crit-0 {
 			temperature = <120000>; /* millicelsius */
 			hysteresis = <0>; /* millicelsius */
 			type = "critical";
+			irq-mode;
 		};
 	};
 
-- 
2.7.4

