Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C487DC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3786B20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3786B20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeKCVoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 17:44:20 -0400
Received: from hermes.aosc.io ([199.195.250.187]:58360 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeKCVoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 17:44:20 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 647F62160D1;
        Sat,  3 Nov 2018 12:33:02 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 1/3] dt-binding: dwmac-sun8i: add H6 compatible string (w/ A64 fallback)
Date:   Sat,  3 Nov 2018 20:32:36 +0800
Message-Id: <20181103123238.4665-2-icenowy@aosc.io>
In-Reply-To: <20181103123238.4665-1-icenowy@aosc.io>
References: <20181103123238.4665-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner H6 SoC features a Ethernet MAC that is similar to the one
in A64.

Add a compatible string for it with A64 fallback compatible string, in
this case the A64 driver can be used.

The "internal" PHY is not internal from the perspective of the H6 main
die, instead it's on the co-packaged AC200 chip, and connected to the
main die with RMII at the in-package Port A PIO bank. So from the SoC
driver side it needs no special treatment.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v2:
- Added ACK tag by Rob and Review tag by Chen-Yu.

 Documentation/devicetree/bindings/net/dwmac-sun8i.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
index 5bb3a18cc38d..54c66d0611cb 100644
--- a/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
+++ b/Documentation/devicetree/bindings/net/dwmac-sun8i.txt
@@ -10,6 +10,7 @@ Required properties:
 		"allwinner,sun8i-r40-gmac"
 		"allwinner,sun8i-v3s-emac"
 		"allwinner,sun50i-a64-emac"
+		"allwinner,sun50i-h6-emac", "allwinner-sun50i-a64-emac"
 - reg: address and length of the register for the device.
 - interrupts: interrupt for the device
 - interrupt-names: must be "macirq"
-- 
2.18.1

