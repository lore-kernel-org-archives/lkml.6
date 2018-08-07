Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C5BC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C28215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 23:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C28215F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxera.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeHHBmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 21:42:52 -0400
Received: from mx1.mpynet.fi ([82.197.21.84]:31116 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbeHHBmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 21:42:52 -0400
From:   Tuomas Tynkkynen <tuomas@tuxera.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tuomas Tynkkynen <tuomas@tuxera.com>
Subject: [PATCH 1/2] ARM: dts: sunxi: Don't use cd-inverted in sun8i-r40-bananapi-m2-ultra
Date:   Wed, 8 Aug 2018 02:25:53 +0300
Message-ID: <20180807232554.16825-1-tuomas@tuxera.com>
X-Mailer: git-send-email 2.16.3
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
Received-SPF: none
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another user of cd-inverted seems to have crept in. Switch it away from
cd-inverted to be consistent with other sunxi boards.

Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index c39b9169ea64..a891a387e8f1 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -159,8 +159,7 @@
 &mmc0 {
 	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
-	cd-gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>; /* PH13 */
-	cd-inverted;
+	cd-gpios = <&pio 7 13 GPIO_ACTIVE_LOW>; /* PH13 */
 	status = "okay";
 };
 
-- 
2.16.3

