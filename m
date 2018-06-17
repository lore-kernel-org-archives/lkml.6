Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0718CC5CFC3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B437E208D5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 20:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="F1+iGn9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B437E208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934573AbeFQUqT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 16:46:19 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:50308 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754217AbeFQUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 16:46:08 -0400
Received: from trochilidae.lan (unknown [37.17.239.3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id C1E0E5C1514;
        Sun, 17 Jun 2018 22:46:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529268366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bt9OXWD9awlzOzrT4ScG14b67Yoi4Jiyx30D5CWU1CQ=;
        b=F1+iGn9LkneCZK6WcC2gcEnZ6X+dB8XSAn4Y4noV/feiS84mR6P3R7k9ldsYY7blLCZhVq
        UcG/iQb0Xla2gyL35GkZLkLxZoOL1AU4wnWdFiyb+rDw/dZNQ9VU4dofJZkerM0PELaHLr
        5q0Xek5205av3dCjBurLL/CsyMJjqno=
From:   Stefan Agner <stefan@agner.ch>
To:     boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com
Cc:     dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        gaireg@gaireg.de, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v5 3/6] mtd: rawnand: tegra: add devicetree binding
Date:   Sun, 17 Jun 2018 22:46:02 +0200
Message-Id: <20180617204605.4648-4-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180617204605.4648-1-stefan@agner.ch>
References: <20180617204605.4648-1-stefan@agner.ch>
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[24];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the devicetree binding for the Tegra 2 NAND flash
controller.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mtd/nvidia-tegra20-nand.txt      | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
new file mode 100644
index 0000000000000..1c351362f3a96
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/nvidia-tegra20-nand.txt
@@ -0,0 +1,64 @@
+NVIDIA Tegra NAND Flash controller
+
+Required properties:
+- compatible: Must be one of:
+  - "nvidia,tegra20-nand"
+- reg: MMIO address range
+- interrupts: interrupt output of the NFC controller
+- clocks: Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: Must include the following entries:
+  - nand
+- resets: Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names: Must include the following entries:
+  - nand
+
+Optional children nodes:
+Individual NAND chips are children of the NAND controller node. Currently
+only one NAND chip supported.
+
+Required children node properties:
+- reg: An integer ranging from 1 to 6 representing the CS line to use.
+
+Optional children node properties:
+- nand-ecc-mode: String, operation mode of the NAND ecc mode. Currently only
+		 "hw" is supported.
+- nand-ecc-algo: string, algorithm of NAND ECC.
+		 Supported values with "hw" ECC mode are: "rs", "bch".
+- nand-bus-width : See nand.txt
+- nand-on-flash-bbt: See nand.txt
+- nand-ecc-strength: integer representing the number of bits to correct
+		     per ECC step (always 512). Supported strength using HW ECC
+		     modes are:
+		     - RS: 4, 6, 8
+		     - BCH: 4, 8, 14, 16
+- nand-ecc-maximize: See nand.txt
+- nand-is-boot-medium: Makes sure only ECC strengths supported by the boot ROM
+		       are choosen.
+- wp-gpios: GPIO specifier for the write protect pin.
+
+Optional child node of NAND chip nodes:
+Partitions: see partition.txt
+
+  Example:
+	nand-controller@70008000 {
+		compatible = "nvidia,tegra20-nand";
+		reg = <0x70008000 0x100>;
+		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA20_CLK_NDFLASH>;
+		clock-names = "nand";
+		resets = <&tegra_car 13>;
+		reset-names = "nand";
+
+		nand@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			nand-bus-width = <8>;
+			nand-on-flash-bbt;
+			nand-ecc-algo = "bch";
+			nand-ecc-strength = <8>;
+			wp-gpios = <&gpio TEGRA_GPIO(S, 0) GPIO_ACTIVE_LOW>;
+		};
+	};
-- 
2.17.1

