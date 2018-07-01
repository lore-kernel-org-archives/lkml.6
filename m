Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52C1C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2F625372
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2F625372
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031283AbeGAQjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:39:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36926 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031714AbeGAQj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:39:29 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A4642A73;
        Sun,  1 Jul 2018 16:39:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.17 063/220] ARM: dts: sun8i: h3: fix ALL-H3-CC H3 ver VCC-1V2 regulator voltage
Date:   Sun,  1 Jul 2018 18:21:27 +0200
Message-Id: <20180701160911.021798498@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@csie.org>

commit bceb1f25b8614e529cc74c5f2339e84f4d4a88ae upstream.

The voltage of the VCC-1V2 regulator on the ALL-H3-CC H3 ver. should be
1.2V, not the 3.3V currently defined in the device tree.

Fix the voltage in the device tree.

Fixes: 6ca358645d4d ("ARM: dts: sun8i: h3: Add dts file for Libre
		      Computer Board ALL-H3-CC H3 ver.")
Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
@@ -62,8 +62,8 @@
 	reg_vcc1v2: vcc1v2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v2";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
 		regulator-always-on;
 		regulator-boot-on;
 		vin-supply = <&reg_vcc5v0>;


