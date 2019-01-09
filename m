Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7A1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8D920665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="rAInm8F9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfAIRsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:48:24 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:14453 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfAIRsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:48:22 -0500
X-Greylist: delayed 3687 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2019 12:48:20 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547056099;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=Ip5hK3VNNEDTJxAJENmJN37jeu081Kuq8YoroF4+vE4=;
        b=rAInm8F94t+JJ7lJa5zEVnW3XufwUP3jdbqdu/3Rfw6jYqqWNJljXum1BjS7C8iw9P
        1Fih7dBlad+B7deataSrR6pDGSviRtzCVodipLYgJIDoblADya1dWeJdP6yWM0Cf6NhD
        qfZg75M3CuDeXFBqlDgEBgUwZ3x1Am1JuZO6kS+qvNo4lrnMJsTSLFppr9ShlPe6x8RW
        t2XYOdWJIMfoWyRW8YZXLKEh8cKGpm7V27AD7ctHOZX531UHXgCi0Mvm/oBg5LHNbr3x
        tK8ROhdp/SNcXlXfVnfIJ4wx/zGlQBWchGMpO9j5m+wO4lpzk5VKIdpD1kPa60C5nCen
        hNHg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH4GpcRmBzW"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.9 AUTH)
        with ESMTPSA id 608499v09Hm2S6R
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 9 Jan 2019 18:48:02 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>,
        letux-kernel@openphoenux.org,
        Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] arm: dts: gta04: add bluetooth serdev driver flags
Date:   Wed,  9 Jan 2019 18:47:52 +0100
Message-Id: <913cd7034be0d05c01148cbcedbb663454772b03.1547056071.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Kemnade <andreas@kemnade.info>

gta04a[34] have bluetooth chips which simply understand
h4 protocol.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 499e3b0e920b..ec7b1e31c07e 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -722,6 +722,8 @@
 
 	bluetooth: bluetooth {
 		compatible = "wi2wi,w2cbw003-bluetooth";
+		speed = <3000000>;
+		flow;
 		vdd-supply = <&vaux4>;
 	};
 };
-- 
2.19.1

