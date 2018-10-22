Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD3AC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3688820645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 16:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="pMpiebq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3688820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=megous.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeJWBML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:12:11 -0400
Received: from vps.xff.cz ([195.181.215.36]:50028 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbeJWBML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:12:11 -0400
X-Greylist: delayed 519 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Oct 2018 21:12:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1540226656; bh=nYPMK5zqJ/cgHYX2QkudnVkV+k5xMYy4lXrvePKtyRY=;
        h=From:To:Cc:Subject:Date:From;
        b=pMpiebq+SIYmZWmBVnSd90atc6CGBOlcgUN9GrXbvPTWcsNs299LYJY6O6UXVM6ul
         GlOt3C7RlCXkEnCmZkul+QjEMBqK0Z2ZXm14tqtuxvoUOolWjFNd/AQ1iI7XfLtuQn
         s4RVMXQZdD2d2smirycJIAdr3i9foxHg7K6wytJA=
From:   megous@megous.com
To:     dev@linux-sunxi.org
Cc:     Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: sun8i-a83t-tbs-a711: Change MMC0 bus-width to 4
Date:   Mon, 22 Oct 2018 18:43:51 +0200
Message-Id: <20181022164352.8804-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

The actual hardware has 4 data lines. Use them.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 7a1b6154cda9..f320f915b413 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -402,6 +402,7 @@
 	vmmc-supply = <&reg_dcdc1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
+	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
-- 
2.19.1

