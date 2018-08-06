Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0782C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A409C21A56
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNPnqGV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A409C21A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbeHFSTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733096AbeHFSTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:19:32 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D9A21A53;
        Mon,  6 Aug 2018 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533571785;
        bh=zbl8p2nURaGWLhsMIaSlPLZUh2gtD6QJ9DtgCl2V2+g=;
        h=From:To:Cc:Subject:Date:From;
        b=qNPnqGV4CKKyNva4uDYU0/qtfBHy48MDCVL6qiV+MU7LpKem+buyO7lIdoOJtXNK2
         ecmhVcjQjzD8xT0/QzzILAu8dCa6mCgBM4V/rmnj6SyeJWD7QYwaiG4rHDS6yRyAaq
         xdORMV+h4VBTPaAJDSgObZTkUR32h2jCdzoiLFKo=
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
Subject: [PATCH 1/4] ARM: dts: exynos: Add missing used PMIC regulators on Exynos5422 Odroid boards
Date:   Mon,  6 Aug 2018 18:09:30 +0200
Message-Id: <20180806160933.6578-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define LDO2, LDO23 and LDO27 critical board regulators to describe the
hardware.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2f4f40882dab..d0218a82c93a 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -154,6 +154,13 @@
 				regulator-always-on;
 			};
 
+			ldo2_reg: LDO2 {
+				regulator-name = "vdd_ldo2";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
 			ldo3_reg: LDO3 {
 				regulator-name = "vddq_mmc0";
 				regulator-min-microvolt = <1800000>;
@@ -261,6 +268,13 @@
 				regulator-max-microvolt = <2800000>;
 			};
 
+			ldo23_reg: LDO23 {
+				regulator-name = "vdd_mifs";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-always-on;
+			};
+
 			ldo24_reg: LDO24 {
 				regulator-name = "tsp_io";
 				regulator-min-microvolt = <2800000>;
@@ -275,6 +289,13 @@
 				regulator-always-on;
 			};
 
+			ldo27_reg: LDO27 {
+				regulator-name = "vdd_g3ds";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-always-on;
+			};
+
 			buck1_reg: BUCK1 {
 				regulator-name = "vdd_mif";
 				regulator-min-microvolt = <800000>;
-- 
2.14.1

