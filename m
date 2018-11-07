Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15364C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5F92147A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="shmz/IMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5F92147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbeKHCmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:42:06 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54962 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbeKHCmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:42:04 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181107171047euoutp01457f7ac71fa89744279fadb646802423~k5rdF8j5Q2287822878euoutp01W
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 17:10:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181107171047euoutp01457f7ac71fa89744279fadb646802423~k5rdF8j5Q2287822878euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541610647;
        bh=DQrr2G8nCrd45JW06oy8w1vdeAOBojDxdwLvk9eFqw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shmz/IMIVzFt7A6d9lkerZ4um62iamcNKnraQuPh9uNOPqQAEG4qp/8YLgKNo0CTv
         7wzG4k4OWGQKpQu1aRPNfvTdgUOCsoFtkCfTXfhuG15htTufNyjPDor3KpJEm4t7wG
         jX/m1DncDZEhx0Gc7oXajtE7Ru1/qyhbhB2p+PIs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181107171046eucas1p2e9b48d585eac0485fa44985e201bbef0~k5rcQCAed2796627966eucas1p2W;
        Wed,  7 Nov 2018 17:10:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7A.64.04294.69C13EB5; Wed,  7
        Nov 2018 17:10:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171045eucas1p26ec5feb1b2a397971c919592f6d87b40~k5rbkWmy42801828018eucas1p2S;
        Wed,  7 Nov 2018 17:10:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181107171045eusmtrp23cfae2884156db7bea33d77a5cde3d6d~k5rbYKcRR0545505455eusmtrp2l;
        Wed,  7 Nov 2018 17:10:45 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-cd-5be31c965326
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 34.8F.04284.59C13EB5; Wed,  7
        Nov 2018 17:10:45 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171044eusmtip272a1ff6fa730a0b1b829c17aeec342ae~k5rawO5DW0340803408eusmtip2V;
        Wed,  7 Nov 2018 17:10:44 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 10/11] arm: dts: exynos5422: add support for thermal trip
 irq-mode
Date:   Wed,  7 Nov 2018 18:09:52 +0100
Message-Id: <1541610593-28542-11-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSbUhTURjHO7u7d3fDxW1qntQMRoEGaUkfLhVSEnUhAosw0A868/o+X3Z9
        ydQUwZeZb2SYaUxLTZ0zc05Tm+KWqSX53rRSzBS0ZMaYfjAl27yzvv3O7/yf5znncHBEpEWd
        8cjYRFoWK4kRYwJu5+DW6Kly16XA0+9mMbKtohUll/vzAKkwHyWrB0ZRsnragJIlS2sIOTb2
        ikd+yXIl1UsW9Sy3jktO9TzFSHPRACArxvo4ZP3MBIfM6R3gkcuLxdhFglIpVIDqrpznUbXa
        HxxKrZRj1JxBi1HtdZlUbXEZSunWtRyqWKMElFnt5icIEFwIpWMik2mZl0+wIGJRb+TFr7jd
        3azXollgyrEA4DgkzkKdPKAACHAR0Qhg2bIRYxcbAL4pknPZhRnA5nkD2K8wFbuzvgHAvoVh
        3r+Kjo3neyGM8IRdygSrdyCqADT31e6FEKKGA03bLZa2fNyeuA0HZ0r2CrjECdiuyrRqIXEN
        NrW0ACtDwg1+HpUjVuZbvGLKuNcHEgYezG5+jbKhy/BRYRuPZXv4c0hjY1e4213NYZmBH/OV
        GMvpMO99ly1zHr4dmkCtZ0AID9ja48XqS/DFcB3CXvggnDUesmrEgg87H9u0EObniti0O9QU
        jtsGHYYNqnJbcwrWfHhie1AFgAv9X9FScKzy/7AaAJTAiU5ipOE04x1Lp3gyEimTFBvueSdO
        qgaWPzXyZ2ijC/TshOgBgQOxnXC8YzFQhEqSmVSpHkAcETsIi5q/B4qEoZLUe7QsLkiWFEMz
        euCCc8VOwrQD3wJFRLgkkY6m6Xhatr/LwfnOWSBp2u5lFGE3uc7v5m891+8W+E/qlH6yrYy1
        OaNHbfxYY1NfTtjq8UnfI/cHR6tGqsMNGc2KjnM38ewU1UJw6S1d0K+VbakoTC/ZGeZpHX1N
        Plc1pv6cK5yRmaaoVbPJ+1Ov/+/NrQezctfyeAdF+vUby7shsui0hLBGl5T01mQxl4mQnDmJ
        yBjJX6gZHqZPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7pTZR5HG2xbKWmxccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLfofv2a2OH9+A7vFrQYZi02PgUIL25awWFzeNYfN4nPvEUaLGef3
        MVksvX6RyaJ17xF2iycP+9gcBDzWzFvD6LFz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9FvdN
        ZvU4+G4Pk0ffllWMHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlPDz0lr3guVzF16V7WBsYL4t2MXJwSAiYSHzs0+hi5OIQEljKKDHv
        /irGLkZOoLiYxKR929khbGGJP9e62EBsIYFPjBIfbnqA9LIJ6EnsWFUI0isiMJ9R4uimy2wg
        DrPAGiaJrYfOgw0SFgiV+Hv6NBNIA4uAqsTmNfUgYV4Bb4mVa9dC7ZKTuHmukxnE5gSKz7v8
        lh1il5fE91nr2SYw8i1gZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGDfbjv3cvIPx0sbg
        Q4wCHIxKPLwaOx5GC7EmlhVX5h5ilOBgVhLh7V39KFqINyWxsiq1KD++qDQntfgQoynQTROZ
        pUST84ExnVcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgTGvR/OI
        0R33K9KqPE83d0VM+7HpTP8Mlzd7m3nMXsw/s7/mpuifrZ+63jNsqtxe+WmqvWjnbvNZkzMX
        2T19eLLySbqjwnO5RRuep9zzVrjO/qvsueRfnXO1WWeOenjufKHcrTXVYZf7+44W38c9q/nm
        5EvFp++WEeU2cHKZ8Ujmzee1Ka8E61YosRRnJBpqMRcVJwIAbyrVfLECAAA=
X-CMS-MailID: 20181107171045eucas1p26ec5feb1b2a397971c919592f6d87b40
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171045eucas1p26ec5feb1b2a397971c919592f6d87b40
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171045eucas1p26ec5feb1b2a397971c919592f6d87b40
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171045eucas1p26ec5feb1b2a397971c919592f6d87b40@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for new flag which indicates
that trip point triggers IRQ when temperature is met.
Exynos5422 supports 4 trip points which will trigger IRQ.
Additional trip points should be registered without 'irq-mode' flag.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 40 +++++++++++++++-------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index e522edb..389548f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -59,22 +59,26 @@
 				cpu0_alert0: cpu-alert-0 {
 					temperature = <50000>; /* millicelsius */
 					hysteresis = <5000>; /* millicelsius */
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu0_alert1: cpu-alert-1 {
 					temperature = <60000>; /* millicelsius */
 					hysteresis = <5000>; /* millicelsius */
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu0_alert2: cpu-alert-2 {
 					temperature = <70000>; /* millicelsius */
 					hysteresis = <5000>; /* millicelsius */
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu0_crit0: cpu-crit-0 {
 					temperature = <120000>; /* millicelsius */
 					hysteresis = <0>; /* millicelsius */
 					type = "critical";
+					irq-mode;
 				};
 				/*
 				 * Exynos542x supports only 4 trip-points
@@ -142,22 +146,26 @@
 				cpu1_alert0: cpu-alert-0 {
 					temperature = <50000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu1_alert1: cpu-alert-1 {
 					temperature = <60000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu1_alert2: cpu-alert-2 {
 					temperature = <70000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu1_crit0: cpu-crit-0 {
 					temperature = <120000>;
 					hysteresis = <0>;
 					type = "critical";
+					irq-mode;
 				};
 				cpu1_alert3: cpu-alert-3 {
 					temperature = <70000>;
@@ -209,22 +217,26 @@
 				cpu2_alert0: cpu-alert-0 {
 					temperature = <50000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu2_alert1: cpu-alert-1 {
 					temperature = <60000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu2_alert2: cpu-alert-2 {
 					temperature = <70000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu2_crit0: cpu-crit-0 {
 					temperature = <120000>;
 					hysteresis = <0>;
 					type = "critical";
+					irq-mode;
 				};
 				cpu2_alert3: cpu-alert-3 {
 					temperature = <70000>;
@@ -276,22 +288,26 @@
 				cpu3_alert0: cpu-alert-0 {
 					temperature = <50000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu3_alert1: cpu-alert-1 {
 					temperature = <60000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu3_alert2: cpu-alert-2 {
 					temperature = <70000>;
 					hysteresis = <5000>;
-					type = "active";
+					type = "passive";
+					irq-mode;
 				};
 				cpu3_crit0: cpu-crit-0 {
 					temperature = <120000>;
 					hysteresis = <0>;
 					type = "critical";
+					irq-mode;
 				};
 				cpu3_alert3: cpu-alert-3 {
 					temperature = <70000>;
-- 
2.7.4

