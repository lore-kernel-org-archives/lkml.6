Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD7EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C18B2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Yvz3pVK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C18B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933574AbeGIPtX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:49:23 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49732 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932800AbeGIPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:49:18 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id A45455C1B99;
        Mon,  9 Jul 2018 17:49:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531151356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3qO3uzI2O17I5uQKg3QTP0GSJI7YLe1McLx5ejbk2o=;
        b=Yvz3pVK7TeZyTSV7CjdYovILJxdPUQUhWufY21rmrzabw4JjSZLmD9ldWtRQsAn3Ccst3X
        a85HiGIyUJLPfDLwH+bVt7SS/qplwo1r5A+9w/V03IMSggqh5NVX3PmRKbuxbET8h/rx9H
        1gVK5gZx8LqEfoStKxUy8vqcgM60V+c=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        maitysanchayan@gmail.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/8] ARM: dts: imx6q-apalis-eval: add carrier board 3.3V supply
Date:   Mon,  9 Jul 2018 17:48:42 +0200
Message-Id: <20180709154848.5401-2-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709154848.5401-1-stefan@agner.ch>
References: <20180709154848.5401-1-stefan@agner.ch>
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:6830, ipnet:46.140.0.0/17, country:AT];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 3.3V main supply on the carrier board. Currently as a fixed
supply since not all consumer are modeled yet. This gets also rid of
some missing supply warnings.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6q-apalis-eval.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index 621d9709effa..707ac9a46115 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -113,6 +113,7 @@
 		 */
 		compatible = "edt,et057090dhu";
 		backlight = <&backlight>;
+		power-supply = <&reg_3v3_sw>;
 
 		port {
 			lcd_panel_in: endpoint {
@@ -131,19 +132,30 @@
 		enable-active-high;
 		status = "okay";
 	};
+
+	reg_3v3_sw: regulator-3v3-sw {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V_SW";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &backlight {
 	brightness-levels = <0 127 191 223 239 247 251 255>;
 	default-brightness-level = <1>;
+	power-supply = <&reg_3v3_sw>;
 	status = "okay";
 };
 
 &can1 {
+	xceiver-supply = <&reg_3v3_sw>;
 	status = "okay";
 };
 
 &can2 {
+	xceiver-supply = <&reg_3v3_sw>;
 	status = "okay";
 };
 
-- 
2.18.0

