Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B086C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E962D2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="YAQOUkdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E962D2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeGIPtY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:49:24 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:49748 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933287AbeGIPtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:49:18 -0400
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id DEA795C1BE2;
        Mon,  9 Jul 2018 17:49:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531151357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xrsm88JKhgqDh+jyUJf/MJovZX1YjjjVj/d1c1VlS0=;
        b=YAQOUkdEFF70ZfpC0aDSPae3o1tAmzJZIWUmXd3aEm5RToIyrPgmWmqJo5bnNur33i85C+
        ErfLLmmjKS7llPv0Z5PBFj/ftAH3sCdo9hcjbBbPMCFcNBvOmZYeIeIGZUKu0bdA75gGjM
        hvWzZYR3Sdssqs+eV5Wz0SxSoglzYKs=
From:   Stefan Agner <stefan@agner.ch>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, fabio.estevam@nxp.com, linux-imx@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        maitysanchayan@gmail.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/8] ARM: dts: imx6qdl-apalis/-colibri: prevent 1.8V modes
Date:   Mon,  9 Jul 2018 17:48:43 +0200
Message-Id: <20180709154848.5401-3-stefan@agner.ch>
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

Use no-1-8-v device tree property to indicate that the board does
not support 1.8V signaling. The property voltage-ranges seems not
appropriate in our case since we do not have level shifters in
place.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 6 +++---
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 64fbee61de44..55bcea245df6 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -457,7 +457,7 @@
 	pinctrl-0 = <&pinctrl_usdhc1_4bit &pinctrl_usdhc1_8bit>;
 	vqmmc-supply = <&reg_3p3v>;
 	bus-width = <8>;
-	voltage-ranges = <3300 3300>;
+	no-1-8-v;
 	status = "disabled";
 };
 
@@ -467,7 +467,7 @@
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	vqmmc-supply = <&reg_3p3v>;
 	bus-width = <4>;
-	voltage-ranges = <3300 3300>;
+	no-1-8-v;
 	status = "disabled";
 };
 
@@ -477,7 +477,7 @@
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	vqmmc-supply = <&reg_3p3v>;
 	bus-width = <8>;
-	voltage-ranges = <3300 3300>;
+	no-1-8-v;
 	non-removable;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 6e937ca20869..bb44829dacbe 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -389,7 +389,7 @@
 	cd-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>; /* MMCD */
 	vqmmc-supply = <&reg_3p3v>;
 	bus-width = <4>;
-	voltage-ranges = <3300 3300>;
+	no-1-8-v;
 	status = "disabled";
 };
 
@@ -399,7 +399,7 @@
 	pinctrl-0 = <&pinctrl_usdhc3>;
 	vqmmc-supply = <&reg_3p3v>;
 	bus-width = <8>;
-	voltage-ranges = <3300 3300>;
+	no-1-8-v;
 	non-removable;
 	status = "okay";
 };
-- 
2.18.0

