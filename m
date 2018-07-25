Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D78FC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E337E20894
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="os2RBXQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E337E20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbeGYRIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbeGYRII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:08:08 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34AEA20882;
        Wed, 25 Jul 2018 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532534151;
        bh=HF8YDBvyiH7tjRHWo5W79v8MlQQMncshYf/VxzkPYKw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=os2RBXQguER22F9WrQK9BLKykKMTuivG30aYJsTr5lCmZ9RqDuSAvN8o55et1d+jh
         DEt071m7gLxSQYyNONFAur1rgzh8WsL8U41zmm/QJv6jOAwpCzZO9Ew8z8ofMwI8JQ
         4nEIl3NiL63q8fMSSobO+9bZdTjkCyIgTTRPIXWg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: exynos: Add compatible for s2mps11 clocks node on Exynos542x
Date:   Wed, 25 Jul 2018 17:55:16 +0200
Message-Id: <20180725155517.4872-3-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180725155517.4872-1-krzk@kernel.org>
References: <20180725155517.4872-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings for s2mps11/s5m8767 clocks driver require a compatible for
clocks node.  Parent MFD sec-core driver will also use it when
instantiating children.

The compatible is not needed for proper working because device will be
anyway created by parent MFD device.  Add it for correctness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 1 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts     | 1 +
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index cdda614e417e..3447160e1fbf 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -89,6 +89,7 @@
 		pinctrl-0 = <&s2mps11_irq>;
 
 		s2mps11_osc: clocks {
+			compatible = "samsung,s2mps11-clk";
 			#clock-cells = <1>;
 			clock-output-names = "s2mps11_ap",
 					"s2mps11_cp", "s2mps11_bt";
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 831c7336f237..3cf905047893 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -141,6 +141,7 @@
 		reg = <0x66>;
 
 		s2mps11_osc: clocks {
+			compatible = "samsung,s2mps11-clk";
 			#clock-cells = <1>;
 			clock-output-names = "s2mps11_ap",
 					"s2mps11_cp", "s2mps11_bt";
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2f4f40882dab..a368c73a1e48 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -141,6 +141,7 @@
 		pinctrl-0 = <&s2mps11_irq>;
 
 		s2mps11_osc: clocks {
+			compatible = "samsung,s2mps11-clk";
 			#clock-cells = <1>;
 			clock-output-names = "s2mps11_ap",
 					"s2mps11_cp", "s2mps11_bt";
-- 
2.14.1

