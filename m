Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076D9C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BAC21A5A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlgJMfoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BAC21A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbeHFSTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:19:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733096AbeHFSTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:19:40 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CDB21A56;
        Mon,  6 Aug 2018 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533571793;
        bh=DFtTP0GtzTAqhIfYrt1usRii5L30aJY+sJBlYqF6xhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AlgJMfoHuoWrzSlDnNdfG7QQXUIWZEAMptMbxqT91ALtmbef6Dq1r2h1CwKaywzet
         xmNw2VT1xqNRPzOSgrWuWpwVkaioMQ68H+j1nQGvzbg4oo2jFFqrXxpJ8mnooFN+wi
         caz0bV+L62ORk5yQBHcaEO2PcqwowgCmT2FCuyxo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RFT 4/4] ARM: dts: exynos: Add LDO28 regulator on Exynos5422 Odroid boards
Date:   Mon,  6 Aug 2018 18:09:33 +0200
Message-Id: <20180806160933.6578-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180806160933.6578-1-krzk@kernel.org>
References: <20180806160933.6578-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LDO28 is used only on Odroid XU3 for Display Port.  Define it so DTS
will describe entire hardware.

Depending on bootloader behavior this might affect the Display Port
because none of drivers are enabling it. By default it is off in S2MPS11
PMIC reset values.  However it could be enabled by bootloader so in such
case kernel will later disable it as unused regulator.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on Odroid XU3 with Display Port.
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 7 +++++++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts    | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index b0dc9cc81b94..178e1064cfc7 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -331,6 +331,13 @@
 				regulator-always-on;
 			};
 
+			ldo28_reg: LDO28 {
+				/* Used on XU3 */
+				regulator-name = "vdd_ldo26";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo29_reg: LDO29 {
 				/* Unused */
 				regulator-name = "vdd_ldo29";
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 0322f281912c..db0bc17a667b 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -49,6 +49,12 @@
 	};
 };
 
+&ldo28_reg {
+	regulator-name = "dp_p3v3";
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+};
+
 &pwm {
 	/*
 	 * PWM 0 -- fan
-- 
2.14.1

