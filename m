Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020CFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0403208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="U98U5rzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0403208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbeGaIxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:53:42 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.102]:16865 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbeGaIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1533021107;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=1yEB419X6s35m8jwVJ1b6BK3DtIG1YrfZNqj31y0PO8=;
        b=U98U5rzM3um1eZ4eBnkfLVYQguXDFesKd5gTEtJqmcnKsYxtiwh4F20deSXdxIcpd0
        5Gb9j6Zt5PpugpsPBP+xq6WK6anHbzaUTF6t2qFFfeJYbDhe4mMcDyMKsNrhQtBQbctw
        snWvKcihLNfzwwXtUcVpAISpMyhOTX9Vlzhv9EE1ROrdri3RehSOfPIZ1OOegU1OU0qs
        oDB6dTsIw6F2GJfDvvsIeA+jFwfcuGcrcAeROelpwmnSe2fpoGxbTessowvOEgG8UaQS
        /2W+UjS/AEe5JusbE65TY1nB/s1TDgZpKi0Gu1s/coTmwwmn0Y6JN8PXB+suqHQJvB5t
        5IuA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLM9PJBRQ"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.13 DYNA|AUTH)
        with ESMTPSA id 6047f4u6V7BfwOb
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 31 Jul 2018 09:11:41 +0200 (CEST)
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
Subject: [PATCH v2 10/32] ARM: dts: omap3-gta04: update gpmc NAND setup
Date:   Tue, 31 Jul 2018 09:11:13 +0200
Message-Id: <39dafcd863ec03a531ac86c602f96450ba3dd71b.1533021093.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
In-Reply-To: <cover.1533021093.git.hns@goldelico.com>
References: <cover.1533021093.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to better match omap3-beagle.dts (which was the basis
of designing the GTA04).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 34e9a3c05cb5..8e785cff539d 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -616,27 +616,27 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		ti,nand-ecc-opt = "ham1";
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		nand-bus-width = <16>;
-		ti,nand-ecc-opt = "bch8";
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-		gpmc,sync-clk-ps = <0>;
+		gpmc,device-width = <2>;
 		gpmc,cs-on-ns = <0>;
 		gpmc,cs-rd-off-ns = <44>;
 		gpmc,cs-wr-off-ns = <44>;
 		gpmc,adv-on-ns = <6>;
 		gpmc,adv-rd-off-ns = <34>;
 		gpmc,adv-wr-off-ns = <44>;
-		gpmc,we-off-ns = <40>;
 		gpmc,oe-off-ns = <54>;
+		gpmc,we-off-ns = <40>;
 		gpmc,access-ns = <64>;
 		gpmc,rd-cycle-ns = <82>;
 		gpmc,wr-cycle-ns = <82>;
 		gpmc,wr-access-ns = <40>;
 		gpmc,wr-data-mux-bus-ns = <0>;
-		gpmc,device-width = <2>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
+		gpmc,sync-clk-ps = <0>;
 
 		x-loader@0 {
 			label = "X-Loader";
-- 
2.12.2

