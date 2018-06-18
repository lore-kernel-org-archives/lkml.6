Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967B9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468E520864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig1/ejJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468E520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933659AbeFRQV5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:21:57 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34836 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754492AbeFRQVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:21:53 -0400
Received: by mail-lf0-f65.google.com with SMTP id i15-v6so25583875lfc.2;
        Mon, 18 Jun 2018 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lX4KnTKr6jSqjmn+LcUfYhSgjAjLPVO37JBjm0O0smI=;
        b=ig1/ejJRqTi47CMlXMQthdru09mto6Tg+JuZjHfF/soYINjW9b61Sw58TBOc7nUKJS
         8L0q61Ry0Yq7JLjGQlakZVmFun8fsRf3nRinaCMtVU8kA3wKnwYXiQdgZbS0WdQNCUpT
         cG3MZ4HlAVkDF9lYIZGWAr2DcrY26JRKV728JnzGJX8npqEpxCLFffIo4ua6TUBASjb1
         W+rlBE7AWht6cNx443EQfGVIHa5uHS55lT1mpNCazNsT1g406uRmHxqPfXW/86r7fURI
         3UAtdZtm3zUqR2A3E0SsPvyrfvXuNT0Z7DaFHK4Lnty9Vgk6BGjtuHNGywLjRfvuQ48r
         HrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lX4KnTKr6jSqjmn+LcUfYhSgjAjLPVO37JBjm0O0smI=;
        b=iSxRzjWHivdd0QdwQV2qEg1P834wxSTUmoEbdihkv2fyHSCWin1ToEBvuPVRGADtIw
         mR1BrytQFiG0CCARKDjVVdNEx5Q8SAa8Stb48yE9sIJj1PA9C/BXBGAhvfjVV8OSqgPl
         LtAS2aiScP6UaVWegppwOrZuZ7+mMzQ3KUbN0pwR6bQU4tiAWfUA61a0NuJJN5Pc7qW7
         X9LsgVmmTLzteTzchsroxfwYVGG1Jl4Pz9QrIY66PmEL2qWdZXj6gk1vkMHHaZIztiyO
         4FrOSh6f0zuO6d2Udz3YQLX5HjlLH1HWFkBvmlg4m/RdrWN3TRXD5CclX7IygLDrxd3n
         1TQg==
X-Gm-Message-State: APt69E0LkpzYrmgczk8XXiSApqXCueZg4vc4sOmi0zAvCHFrKFLfWNdw
        TeT8GHMh39eUGNSIYj4kUQ==
X-Google-Smtp-Source: ADUXVKLYVraclhqtNnU7Nanc22aAVTXyXO+mVy1d0PKi4v51uyagFpZjSaH1+fzJ/nPSwJ3/nzmC2g==
X-Received: by 2002:a2e:804c:: with SMTP id p12-v6mr8562470ljg.22.1529338911423;
        Mon, 18 Jun 2018 09:21:51 -0700 (PDT)
Received: from localhost.localdomain (89-64-25-103.dynamic.chello.pl. [89.64.25.103])
        by smtp.gmail.com with ESMTPSA id h90-v6sm2761220ljf.65.2018.06.18.09.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 09:21:50 -0700 (PDT)
From:   Piotr Bugalski <bugalski.piotr@gmail.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: [RFC PATCH 2/2] dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2 documentation
Date:   Mon, 18 Jun 2018 18:21:24 +0200
Message-Id: <20180618162124.21749-3-bugalski.piotr@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180618162124.21749-1-bugalski.piotr@gmail.com>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for DT-binding change.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <pbu@cryptera.com>

---
 .../devicetree/bindings/spi/spi_atmel-qspi.txt     | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt b/Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt
new file mode 100644
index 000000000000..d52b534c9c2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi_atmel-qspi.txt
@@ -0,0 +1,41 @@
+* Atmel Quad Serial Peripheral Interface (QSPI)
+
+Required properties:
+- compatible:     Should be "atmel,sama5d2-spi-qspi".
+- reg:            Should contain the locations and lengths of the base registers
+                  and the mapped memory.
+- reg-names:      Should contain the resource reg names:
+                  - qspi_base: configuration register address space
+                  - qspi_mmap: memory mapped address space
+- interrupts:     Should contain the interrupt for the device.
+- clocks:         The phandle of the clock needed by the QSPI controller.
+- #address-cells: Should be <1>.
+- #size-cells:    Should be <0>.
+
+Example:
+
+qspi1: spi@f0024000 {
+	compatible = "atmel,sama5d2-spi-qspi";
+	reg = <0xf0024000 0x100>, <0xd8000000 0x08000000>;
+	reg-names = "qspi_base", "qspi_mmap";
+	interrupts = <53 IRQ_TYPE_LEVEL_HIGH 7>;
+	clocks = <&qspi1_clk>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi1_default>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25m02gv", "spi-nand";
+		reg = <0>;
+		spi-max-frequency = <83000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+
+		...
+	};
+};
+
-- 
2.11.0

