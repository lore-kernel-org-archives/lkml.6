Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B373C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C7D214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C7D214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbeJIWnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:43:12 -0400
Received: from mout.perfora.net ([74.208.4.196]:39591 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbeJIWnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:43:10 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LzIud-1ffDwP3usL-014TBq; Tue, 09 Oct 2018 17:25:37 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LzIud-1ffDwP3usL-014TBq; Tue, 09 Oct 2018 17:25:37 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 4/8] ARM: tegra: colibri_t20: reorder pmic properties
Date:   Tue,  9 Oct 2018 17:25:19 +0200
Message-Id: <20181009152523.3771-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009152523.3771-1-marcel@ziswiler.com>
References: <20181009152523.3771-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:zohQsLqrd3QNzsjgamLGeFJG9VLjVFYCbGyTGdKWh+RSrgpUaPy
 wqo3Ka3pE+7seZN6q1cigQwifSGi+5b2ikhOOqwFHpvTYXws2OgtbdMs7oS/XN0cTrRbYXI
 BLXAFWk9aGDQ5K2xf/ra+0uxjhpRBFnIHpreOEwSNnZtUp8g0epTmR1Wp+ocGh1K31IhNoI
 b0vhyuL9AlKaxrlN6v8wQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DK2QkN0AtJo=:nhgh0XDIlikeefGjYvWqwX
 HU7aZco7L+8vz+ss56zHE0dB2yyk7kraC1ukcPD+qMMuFv7XVWY6RaSF537oiRJMGzKMvUxQI
 0JMZObppY9X3kJ9OgiajkXSjtv/RFINA2Le5LHyTQ0t11f4B2CNbO94Nd0K+fRkmuKslpWAVr
 fp1ctr9JqrwU2n13ZDHZS+XQcKO9PRmmhvx7Crvuuv8xMyMAZcBRz4Onr4iAWfBfTlbRSSKyb
 cpM4l0DIg/KRaUXP0OBqNOrb9Preslv7mjWGevm+oXKsnBb54YJsoUZKA9v941ZETnWYNwWG0
 uy32IhbC5C6iJcBO0v4iB9wQKeh8KonuJG4GmTPnUgNKxoNVegczCq8p1pyKN9+WVI9LQnGUt
 kNMeH/EyRjnMDDJH8Ea5xGpaP78559F44RiEwPxKvtQFlBubFwnjsdSJYU1zqYazGC+ou9Hjr
 r6xSTuUXTlMmLcjCfrSlQkDAqefzEF7+4l9yvgRbiYjEDZ1QwndbxCYlTc4Ta7uJKX6d8kiwd
 NaODvH3T65cwaGq5MhEFCz2AGFFoqJuIqYytM9FmDuip86qKkIDPShSzmLf8F+eh1/6lmDkmB
 q3VshzbDApdHxaTIga2YPb6Toc91TS8RyJV3zFOeuVcG/0+F2LJZIWwqDL3S8CIbXZdWUtmkk
 SHtEumRv686sE9JwDQK2RCE5ZfRKanOQRiPvh6/L/xC68PkIRCxE0Ilk1+ABKLzyHU6o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reorder PMIC properties to be more in-line with any of our other device
trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v1: None

 arch/arm/boot/dts/tegra20-colibri.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 6162d193e12c..d3aba6501510 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -475,11 +475,11 @@
 		pmic@34 {
 			compatible = "ti,tps6586x";
 			reg = <0x34>;
-			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-			ti,system-power-controller;
 			#gpio-cells = <2>;
 			gpio-controller;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			sys-supply = <&reg_module_3v3>;
+			ti,system-power-controller;
 			vin-sm0-supply = <&reg_3v3_vsys>;
 			vin-sm1-supply = <&reg_3v3_vsys>;
 			vin-sm2-supply = <&reg_3v3_vsys>;
-- 
2.14.4

