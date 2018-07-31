Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453C9C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8225208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="c6ARED9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8225208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732358AbeGaIwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:52:38 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.121]:25864 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731785AbeGaIum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021108;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=2u47w+tZoMH2IQGLluLNbJ8rwOzWRkZEo86ync1G7h4=;
        b=c6ARED9ZJ/mx7/712IZQ5HLidJOpamUoMxBT68Ov7rO3e4ZMEzhD5xkVLNDZHODyR9
        GBX5dzUb0ZKV5T7O19I4yQSv5ANXnnWfaMmDJRBwc4FvoRQmv8dQ5Zex7NC4Pfr8BUJW
        lMpZFdh8TIUrG+t0wswC0Ro55TqH6Kmtn4qyKCe6z8S+V58UfhKfMe7nl1a0O/yK3Kbj
        p/5XYb+lEqlec+jRFSYBsmWVTABBw5n0Xb8oxF1iZNQaWkFU00z/SDUjbTFrujcXlUsg
        A4Aye6zna1ydAPyly7CBcjYTqr6gXWVmy9gPQHmUzkC8NVCdCMQG3hwTmJh10X4J6kWs
        NDLg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BgwOe
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:42 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     ladis@linux-mips.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Marek Belisko <marek@goldelico.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 13/32] ARM: dts: omap3-gta04: add warning comment to vaux2 regulator
Date:   Tue, 31 Jul 2018 09:11:16 +0200
Message-Id: <6a8a578ac10532e41a9aa1b8daf15c8e1c548491.1533021093.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vaux2 should remain always on since a higher potential at vio
could potentially damage the itg3200 sensor.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 1145cfaa06d6..cdee97f532c5 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -553,7 +553,7 @@
 &vaux2 {
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
-	regulator-always-on;
+	regulator-always-on;	/* we should never switch off while vio is on! */
 };
 
 /* camera */
-- 
2.12.2

