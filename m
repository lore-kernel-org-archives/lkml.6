Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DEDC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361A62083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mEV5KL0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361A62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeHaX0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:26:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36144 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHaX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:26:41 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJHYbb108537;
        Fri, 31 Aug 2018 14:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535743054;
        bh=BTSZPMtoJfz30MeSZ25qVA4RemaThho6uBRpL0+pxZg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mEV5KL0DINi4xyU2XWe0Z41BKVjPz5K0JR6B0Z4BiT1uNC1AQzv/vNKkvWgQSZ8n2
         Yjv2zPe36lmfQw/L14t1bkgu6H8Ts2a2YX4nl3Jtp1N4nxHagjksG5lS9LOgeDXhGc
         sNbYdCO8z1fPkLrAgDJQ169m8GvqYBOlETXWzaac=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJHYZ5020247;
        Fri, 31 Aug 2018 14:17:34 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:17:34 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:17:34 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJHXuq012259;
        Fri, 31 Aug 2018 14:17:33 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VJHXx13641;
        Fri, 31 Aug 2018 14:17:33 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 2/2] ARM: dts: imx: Fix the audio CODEC's reset pin
Date:   Fri, 31 Aug 2018 14:17:32 -0500
Message-ID: <20180831191732.25504-2-afd@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831191732.25504-1-afd@ti.com>
References: <20180831191732.25504-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", fix this here.

Fixes: 50bffb78e2ee ("ARM: dts: imx: add Gateworks Ventana GW5903 support")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index 368132274a91..ddabab168a8a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -310,7 +310,7 @@
 	tlv320aic3105: codec@18 {
 		compatible = "ti,tlv320aic3x";
 		reg = <0x18>;
-		gpio-reset = <&gpio5 17 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio5 17 GPIO_ACTIVE_LOW>;
 		clocks = <&clks IMX6QDL_CLK_CKO>;
 		ai3x-micbias-vg = <2>; /* MICBIAS_2_5V */
 		/* Regulators */
-- 
2.18.0

