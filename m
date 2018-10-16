Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BB6C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770C22145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770C22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbeJPWDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:03:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41584 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPWDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:03:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D8CF226093A
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: rockchip: Use default brightness table for gru.
Date:   Tue, 16 Oct 2018 16:13:04 +0200
Message-Id: <20181016141304.21984-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
linearly to human eye") the pwm_bl driver is able to calculate a default
brightness table. The calculated table for this PWM will have more
granularity and will be adjusted to change the brightness linearly to
the human eye. Use that table instead of have a DT-defined table with
less granularity.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Hi Heiko,

Note that the patch was only tested on a Samsung Chromebook Plus
(kevin), will be very interesting if someone can test on other gru-based
devices, like Bob, before apply this patch.

Best regards,
 Enric

 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index ae8bb721005e..8dbe2c58b3ce 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -194,14 +194,6 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		brightness-levels = <0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
-				     17 18 19 20 21 22 23 24 25 26 27 28 29 30
-				     31 32 33 34 35 36 37 38 39 40 41 42 43 44
-				     45 46 47 48 49 50 51 52 53 54 55 56 57 58
-				     59 60 61 62 63 64 65 66 67 68 69 70 71 72
-				     73 74 75 76 77 78 79 80 81 82 83 84 85 86
-				     87 88 89 90 91 92 93 94 95 96 97 98 99 100>;
-		default-brightness-level = <51>;
 		enable-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
 		power-supply = <&pp3300_disp>;
 		pinctrl-names = "default";
-- 
2.19.1

