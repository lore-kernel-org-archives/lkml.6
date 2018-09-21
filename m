Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6443C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9204C21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of9bS1rY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9204C21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391268AbeIVAU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391102AbeIVAU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:20:26 -0400
Received: from localhost.localdomain (unknown [178.38.103.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5A09206B2;
        Fri, 21 Sep 2018 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537554620;
        bh=q2S1UEsdo9q0N2NsncZDkc3pu5FHDIs/MEEQPaspub4=;
        h=From:To:Cc:Subject:Date:From;
        b=Of9bS1rY43z4dTBM7oWkrBc++voMUChleq13X5YX3wEDm4HBWs65Q6ZmeU4yhsd5h
         svgk6RBEY7CqaKCr9r3rI+eKFTlyILG62/JqjSWOdpoICM5wItEMrJDOFZH6NpMlYk
         sERxrdRDz16bqVZgT11/+nC7n1Q+iauwhgVvKkNc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RFT] arm64: ARM: dts: exynos: Remove double SD card detect pin inversion on TM2
Date:   Fri, 21 Sep 2018 20:30:14 +0200
Message-Id: <20180921183014.20236-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDHCI standard, MMC host controller bindings and MMC core defines
card detect pin as active low.  Therefore there is no point to invert it
twice.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index a1e3194b7483..86d8ddc3288a 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -939,8 +939,7 @@
 	status = "okay";
 	cap-sd-highspeed;
 	disable-wp;
-	cd-gpios = <&gpa2 4 GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpa2 4 GPIO_ACTIVE_LOW>;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <0 4>;
-- 
2.17.1

