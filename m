Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76409C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DFC205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hDa0FhZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DFC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJPWrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:47:42 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39274 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeJPWrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:40 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181016145650euoutp026b8c345b8df599b64695eb35a18c3ecf~eHqOdJ0hq0414504145euoutp02r
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:56:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181016145650euoutp026b8c345b8df599b64695eb35a18c3ecf~eHqOdJ0hq0414504145euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539701810;
        bh=jg7rb3XNh+fTjaJXSjAFMxa0KmfItCcYC/IdO2jxbJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDa0FhZVPjAaIZnaG8mkF4bQisX9TTDMJetmcjSVskysE2JWP4avFukvsIpWyxxPl
         Fq9d0SheoaE5OQlS33j/4Bq5hAp1+B/05dTIndtuG+DiStP2EGFFlb3kY7DjAtap8q
         wTHpZNlIfn17xz8MHkom6iY6FgbtyxvcuN5br2Kg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016145649eucas1p29698529ae8a7276dc10b5895f8a6e277~eHqNpUFoa0771607716eucas1p28;
        Tue, 16 Oct 2018 14:56:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C9.C2.04441.13CF5CB5; Tue, 16
        Oct 2018 15:56:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a~eHqM4Yhz82489624896eucas1p25;
        Tue, 16 Oct 2018 14:56:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016145648eusmtrp2cb8887df6ae686cb254f92c921622252~eHqMpGoOS3061930619eusmtrp2Z;
        Tue, 16 Oct 2018 14:56:48 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-d5-5bc5fc310c88
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 01.BA.04128.03CF5CB5; Tue, 16
        Oct 2018 15:56:48 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145647eusmtip2e1866afa6b261e9062fb6e64152f8bd5~eHqL6ygI22715427154eusmtip2W;
        Tue, 16 Oct 2018 14:56:47 +0000 (GMT)
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
Subject: [PATCH 07/11] DT: arm64: exynos7: add support for thermal trip
 irq-mode
Date:   Tue, 16 Oct 2018 16:56:18 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHec/ZOTtOl8cp7cVbNIhupK2CDmil0IeTUZgUUftQKw9ectN2
        vGQEGXjPlppmaE1LU1vSdJpNMavlFMu7ppuXKLTARBOXZpDZ5pn17fc87///fx4eXgIVGTBP
        IkoZz6iU8hgJLuA1tv/q2SX9bZLtnu72oeru6TBq6nUGoDRWH6q0rQejSoeGMer25AxK9fbW
        8qnRFG9KP2lrPUyv4FGDzfdxynqrDVCPR/oRKu1lG5+a+qzGg1zpGk0NoJuKJ/h0ecs0Quu1
        WTg9PtyC0/UV1+ly9R2MfjPXgtDqBi2grXrfUMFZQWA4ExOVyKj8D54XROomK5E4jduVpdZ5
        LAWYhdnAiYDkPliSr8OygYAQkdUAfjRWo1zxA8CU/gXErhKRVgDHh86sO7otY4ATVQFomjfj
        /xxPSpdsWQSBk37QoL1s73uQJQBaW8v59gIl8xCYV/UVs0e5k2HwhrYO2JlHboE58w0IN8IX
        WnqyUDs7kUfhqLlsbSdIvuPD1vL2NYOQTITLRdk4ZzgMX6Wa+By7w28dDQ72hqtNpY5QFnZn
        ah36azCj0+DQBMC3Hf1rW6Pkdqhr9rcjJIOhrugIhxugedbNLkZtmN9YhHJtIcxMF3EZ22BD
        Tp9jzkZYVXPXkU3DQnUmjzuPxnbd7lQsF2wq/j+rDAAtEDMJrCKCYaVKJsmPlSvYBGWE38VY
        hR7Y/tP7Px0LBrA4cMEISAJIXITLI20yESZPZJMVRgAJVOIhjBgwyUTCcHnyVUYVe06VEMOw
        RuBF8CRiYaWmTiYiI+TxzCWGiWNU668I4eSZAvZkmbrGjH4nTwvx4/17260zO5+fCglzPXYz
        JNpLPLHVEPjpEWW2DiyG6/vi6sseqJukq+rVoIDllcnagoDvHgF0qNeh4Zm4Vmd6trOuaO5E
        6oekwhWL8+b2Lv+CqP0SsWXQjOXlfgnOf1p8YCQVkYS7L7p4Wkxpz6KyZC8Ko39KeGykXLoD
        VbHyv6E1arJLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7oGf45GGzzcpG6xccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLfofv2a2OH9+A7vFrQYZi02PgUIL25awWFzeNYfN4nPvEUaLpdcv
        Mlm07j3CbvHkYR+bA7/HmnlrGD12zrrL7rF4z0smj02rOtk87lzbw+axeUm9x+K+yaweB9/t
        YfLo27KK0ePzJrkArig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TU
        nMyy1CJ9uwS9jPWPlzEVzBOs+LbvA2sD4w3eLkZODgkBE4mzN28zdjFycQgJLGWUODzxEDNE
        Qkxi0r7t7BC2sMSfa11sEEWfGCWeN78Fcjg42AT0JHasKgSJiwjMZ5Q4uukyWBGzwFwmiZUN
        y5lAuoUFAiRe7PjNBmKzCKhK9HzYwgTSzCvgJdHbbgqxQE7i5rlOsMWcAt4St24sYAYpEQIq
        ubiYcQIj3wJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiB8bLt2M8tOxi73gUfYhTgYFTi
        4f1x/Ui0EGtiWXFl7iFGCQ5mJRHe9EtHo4V4UxIrq1KL8uOLSnNSiw8xmgKdNJFZSjQ5HxjL
        eSXxhqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGMudshSq4ha7bVH/
        fFkj87xm86KeEw9Sao0iNHi9nKRC077yzZcN5DOQciq5Epv71P508Y2JU4RDD23UK7ksKlTb
        vrDg29kcORebo9P2uO4pqJBiWLll1cQF66R0Vdbv5zJbxce+Yiq/RGRA6qzCxF8GFp2ca75P
        ZvrwLjWN41KDz528FZ6WSizFGYmGWsxFxYkAXpkFOa0CAAA=
Message-Id: <20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a~eHqM4Yhz82489624896eucas1p25@eucas1p2.samsung.com>
X-CMS-MailID: 20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a@eucas1p2.samsung.com>
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
 arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
index d3301b8..39185af 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
@@ -11,40 +11,48 @@ trips {
 		temperature = <75000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-1 {
 		temperature = <80000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-2 {
 		temperature = <85000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-3 {
 		temperature = <90000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-4 {
 		temperature = <95000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-5 {
 		temperature = <100000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-6 {
 		temperature = <110000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-crit-0 {
 		temperature = <115000>; /* millicelsius */
 		hysteresis = <0>; /* millicelsius */
 		type = "critical";
+		irq-mode;
 	};
 };
-- 
2.7.4

