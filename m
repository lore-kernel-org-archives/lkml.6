Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91427C5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C86720836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rqqX9AAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C86720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030704AbeFSTpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:45:03 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:43187 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967155AbeFSTpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:45:00 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5JJipRf014314;
        Tue, 19 Jun 2018 14:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437491;
        bh=4LXr0DVRCDkKLUyBSgG4DH5jxrflB26EN2tpItlLUU0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rqqX9AAfDxohKD440pkYM2mlh/j2ABQ7Io/mMQxCONMsg7LXFIuQNLi2wqIfbOcud
         gAmxwvPekucGfvnWAPcgcBA6ju+0/L2vkqQh8B9HdaSX8Xe+GBaf7hkebsRhi3o8Y1
         9PwyTM7CaZR/YxZsXuhbW5zYrLp5ndq9K05mb6Pw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJiovK010689;
        Tue, 19 Jun 2018 14:44:50 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:44:50 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:44:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJio8G027308;
        Tue, 19 Jun 2018 14:44:50 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, Vignesh R <vigneshr@ti.com>,
        Jiri Slaby <jslaby@suse.com>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 1/2] dt-bindings: serial: 8250_omap: Add compatible for AM654 UART controller
Date:   Tue, 19 Jun 2018 14:44:49 -0500
Message-ID: <20180619194450.6353-2-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180619194450.6353-1-nm@ti.com>
References: <20180619194450.6353-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654 uses a UART controller that is only partially compatible with
existing 8250 UART. UART DMA integration is substantially different
and even a match against standard 8250 or omap4 would result in
non-working UART once DMA is enabled by default.

Introduce a specific compatible to help build up the differences in
follow on patches.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Vignesh R <vigneshr@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since RFC:
* DT binding has been split out as it's own patch and commit message elaborated

RFC: https://patchwork.kernel.org/patch/10447641/

 Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 4b0f05adb228..c35d5ece1156 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -1,6 +1,7 @@
 OMAP UART controller
 
 Required properties:
+- compatible : should be "ti,am654-uart" for AM654 controllers
 - compatible : should be "ti,omap2-uart" for OMAP2 controllers
 - compatible : should be "ti,omap3-uart" for OMAP3 controllers
 - compatible : should be "ti,omap4-uart" for OMAP4 controllers
-- 
2.15.1

