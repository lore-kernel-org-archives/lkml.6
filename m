Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39A4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11D42083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKvkRWjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11D42083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935688AbeFRRmt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934957AbeFRRmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:42:47 -0400
Received: from localhost.localdomain (adsl-84-227-236-43.adslplus.ch [84.227.236.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D48BF20836;
        Mon, 18 Jun 2018 17:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529343766;
        bh=hKoOLgK6ssMH74l6yISUhlocFEO/c/hv+Ux9OZlvXj8=;
        h=From:To:Cc:Subject:Date:From;
        b=qKvkRWjdV6zZUZewWxBL5WVmq/Bdz9ObEvRfumcGidFgpDgIfL6exxFA6f1jusjeU
         s/wUH6tJp1uGqGa4MwFbGmDJQomx6tQ6HFV30ZFcQtBbYFWUK436KLjh52Xz506Miw
         cMOlSrInXl/vwiQKiBkIOU/5lHuGdkepDqY7H2nk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] arm64: dts: exynos: Remove leading 0x from unit addresses in Exynos5433
Date:   Mon, 18 Jun 2018 19:42:15 +0200
Message-Id: <20180618174216.24801-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading 0x from recently introduced unit addresses to fix DTC
warnings:

    Warning (unit_address_format): /soc/sysmmu@0x15040000: unit name should not have leading "0x"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 038c99792ccb..3a9b4c4b9c63 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1171,7 +1171,7 @@
 			power-domains = <&pd_gscl>;
 		};
 
-		sysmmu_scaler_0: sysmmu@0x15040000 {
+		sysmmu_scaler_0: sysmmu@15040000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x15040000 0x1000>;
 			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>;
@@ -1182,7 +1182,7 @@
 			power-domains = <&pd_mscl>;
 		};
 
-		sysmmu_scaler_1: sysmmu@0x15050000 {
+		sysmmu_scaler_1: sysmmu@15050000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x15050000 0x1000>;
 			interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.14.1

