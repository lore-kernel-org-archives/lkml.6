Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ABDC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413AC20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413AC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ltec.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeLACj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:39:57 -0500
Received: from mail.ltec.ch ([95.143.48.181]:39732 "EHLO mail.ltec.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbeLACj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:39:56 -0500
X-Greylist: delayed 2081 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Nov 2018 21:39:55 EST
Received: from nebula.ltec ([172.27.11.2] helo=vm64.ltec)
        by mail.ltec.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <fb@ltec.ch>)
        id 1gSkCf-0001Er-Cp; Fri, 30 Nov 2018 15:55:37 +0100
From:   Felix Brack <fb@ltec.ch>
To:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     tony@atomide.com, bcousson@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        Felix Brack <fb@ltec.ch>
Subject: [PATCH] ARM: dts: am335x-pdu001: Fix polarity of card detection input
Date:   Fri, 30 Nov 2018 15:54:46 +0100
Message-Id: <20181130145446.3819-1-fb@ltec.ch>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a micro SD card is inserted in the PDU001 card cage, the card
detection switch is opened and the corresponding GPIO input is driven
by a pull-up. Hence change the active level of the card detection
input from low to high.

Signed-off-by: Felix Brack <fb@ltec.ch>
---
 arch/arm/boot/dts/am335x-pdu001.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-pdu001.dts b/arch/arm/boot/dts/am335x-pdu001.dts
index 6dd9d487aaeb..ae43d61f4e8b 100644
--- a/arch/arm/boot/dts/am335x-pdu001.dts
+++ b/arch/arm/boot/dts/am335x-pdu001.dts
@@ -585,7 +585,7 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
-	cd-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+	cd-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
 };
 
 &sham {
-- 
2.17.1

