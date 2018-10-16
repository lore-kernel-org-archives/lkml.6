Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C891C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEF320881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WUZz3Jwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEF320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeJPWrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:47:45 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39373 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeJPWro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181016145654euoutp02cb1ca36bbea9e0342d0e26ff98b2b556~eHqSItET40472304723euoutp02H
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:56:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181016145654euoutp02cb1ca36bbea9e0342d0e26ff98b2b556~eHqSItET40472304723euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539701814;
        bh=U2hOpge9VBmw0XxT1DkaNEnI2no8yszC5mdL/pwknms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUZz3JwtzMdxBIuOMWcvT6VaDCkwaPaTpx8lMxG2gtopReyK29jYdIpgmcASE6ysd
         X6pI9IrSCQt6cFFZIQ8Q0TjQETPH/KtUsMvgEhOWmHkkIwPP89DRLZrG0l71+xcg6S
         AW/GBn64uKk7p1NUxmp/7PAe/yU99uyRpRdoVn00=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016145653eucas1p2cdd545dbf80ded7f565759167f084f43~eHqQ-S_vk2134621346eucas1p2_;
        Tue, 16 Oct 2018 14:56:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 50.70.04294.53CF5CB5; Tue, 16
        Oct 2018 15:56:53 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145652eucas1p2939c6aa628ba099c9609a8cbc17db1a4~eHqQRcy8z2133821338eucas1p2W;
        Tue, 16 Oct 2018 14:56:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016145652eusmtrp257236b9fc92a96606b332ab925f474d0~eHqP-x5Gf3061930619eusmtrp2h;
        Tue, 16 Oct 2018 14:56:52 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-e9-5bc5fc359087
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 26.BA.04128.43CF5CB5; Tue, 16
        Oct 2018 15:56:52 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145651eusmtip2d94a58a1b23656f33f3e06b734c11ab2~eHqPazsgO2834828348eusmtip2E;
        Tue, 16 Oct 2018 14:56:51 +0000 (GMT)
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
Subject: [PATCH 10/11] DT: arm: exynos: add support for thermal trip
 irq-mode
Date:   Tue, 16 Oct 2018 16:56:21 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju29m5OJwdp+SLqdEiqUAtMTpgZVLhgX5k/0IpXXmY4jZrR60k
        aFnehmkrynDlDC1tTMo5TGWazalZqa2LmTeQIsjo5grKLubxTOrfc3mf93n5+ChM0YGHUlm6
        XE6vU2mUhEza2vdjOGrzr97Ujddu4Uzzlds486a7BDE13nDG4h7CGcvzEZypfP0eY4aH75DM
        mCGMsb9ekK4X10uZZx1XCcZ7zo2YGy89Eqao000yb6YriB3LWVuNDbHt1ZMkW+d8J2Ht1jKC
        nRhxEmxL/Sm2ruIizt7/6JSwFQ4rYr32iGRZimxrBqfJyuf0MdvTZZlN9ib8yOiq4+7KWdKA
        bCuMyI8COg7aWr4RRiSjFHQjgp5yk0QkXxEUto74iBdB0+NSyVKk0zKNiUYDgjlT4X+RLgNu
        RBRF0NHQZj0q6MG0GYG3q44UCEabJGBqeIsLq4LovTBfWoYELKXXwp05KyFWRMCroTJMwH70
        HhgbrV2sA3qIhM+WRqlgyOl8OGOuwsXALmicPY1EHAQz/Q5SxGEw327x3c3DYOlSwUkoGWjz
        zcRDT79n8WqMXg+3O2JEORHcnzyEIAMdAKMfAgUZW4AXWqswUZZDabFCnF4HjvInvqIV0GC7
        7FvOgmn8LC6+Tw0C15iLOI9WVf8rq0XIikK4PF6r5vhYHXcsmldp+TydOvpwjtaOFn7Uoz/9
        X9tQx69DLkRTSOkv//7SnarAVfn8Ca0LAYUpg+Xqp72pCnmG6kQBp89J0+dpON6FVlJSZYj8
        Zk1zqoJWq3K5bI47wumXXAnlF2pA5qmEgiRdwKZLA1/idhMhKZHhBqj8AOlp+eSlorN9PyMH
        OuH3A3yqaPWaiP3v7h28unV1lT0se/3OeCXcTXdOSgMCs79PJdUmmg7sT5h46NW1/3xR8UU9
        4W/eUh0y2FU7MzIYaza+0LZ4zMnNtnGNNql7Hxa1xt6/zFro6NxmVEr5TNWmDZieV/0FF1SE
        x00DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7omf45GGxw8JGixccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLfofv2a2OH9+A7vFrQYZi02PgUIL25awWFzeNYfN4nPvEUaLpdcv
        Mlm07j3CbvHkYR+bA7/HmnlrGD12zrrL7rF4z0smj02rOtk87lzbw+axeUm9x+K+yaweB9/t
        YfLo27KK0ePzJrkArig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TU
        nMyy1CJ9uwS9jLWb1rIW3JCvONL/ib2BcY1YFyMnh4SAicTe+Q+Zuxi5OIQEljJKdD6exQqR
        EJOYtG87O4QtLPHnWhcbRNEnRome341ADgcHm4CexI5VhSBxEYH5jBJHN10GK2IWmMsksbJh
        ORNIt7CAr8TRxk0sIDaLgKrEhl+r2EBsXgFvieY9e1kgNshJ3DzXyQxicwLFb91YwAyyQEjA
        S+LiYsYJjHwLGBlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbMtmM/t+xg7HoXfIhRgINR
        iYf3x/Uj0UKsiWXFlbmHGCU4mJVEeNMvHY0W4k1JrKxKLcqPLyrNSS0+xGgKdNNEZinR5Hxg
        NOeVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamDcFPk5VW7L7AsK
        u08cF1noJZL3quycc4rii/67O5nCXrvXXpKNS1whf+/u2z6tOfyq9b1W6tPyOYscvqWzCHqv
        eRBdfSjHraZCYXez/OHNmWVnyi+XrnPwWt3ezqTAzvRXo2a7dV297NQTfqx7fZ+J+Sluqqrb
        NbP1vsjVubvVpp1ke8VU+1CJpTgj0VCLuag4EQBG3YLSrgIAAA==
Message-Id: <20181016145652eucas1p2939c6aa628ba099c9609a8cbc17db1a4~eHqQRcy8z2133821338eucas1p2W@eucas1p2.samsung.com>
X-CMS-MailID: 20181016145652eucas1p2939c6aa628ba099c9609a8cbc17db1a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145652eucas1p2939c6aa628ba099c9609a8cbc17db1a4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145652eucas1p2939c6aa628ba099c9609a8cbc17db1a4
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145652eucas1p2939c6aa628ba099c9609a8cbc17db1a4@eucas1p2.samsung.com>
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
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 40 +++++++++++++++-------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 96e281c..dbce706ed 100644
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

