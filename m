Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA13C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858B5214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knbflOPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858B5214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJQMBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:01:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45992 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeJQMBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:01:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id y15-v6so12007282plr.12;
        Tue, 16 Oct 2018 21:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vAkNqQ+6r0Ic4PTSqAzcRLoVd11Nwrn0dV1l7sCU1gc=;
        b=knbflOPnUR7sTz3RmhM+qTBpHalFeCywgZVNuWP2uKaFoBoT6jxqvlAzhUMXRgxQVV
         +OzqNBIvJVXW5V2PuCBXMBlPkxGZPDx8EJaNuont3+phqQb5VOeY5ParGMg808RqMT9/
         0OBUAtDett3n9U6vLalQlwndGl7Q8jRJXbgRJpmJ4B/LDDbaRZzJzdVnL8duTQAduMBd
         g57mzFnBYBieIZAo6n/1CkepUfPzVfx8XyrmtF8Z4qAbkNppw+26F1jvY/lNzkQXFOxm
         01LUQyLZqu22/MmAO1oHq7Y01LUqfSLOkTo/jwk1fyd9IYiijk7pigMzs/AK9yXvqQBq
         lM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vAkNqQ+6r0Ic4PTSqAzcRLoVd11Nwrn0dV1l7sCU1gc=;
        b=dnHLWF4568kwBZV0q1LIItC3rlY6nPtW3mGoGu2fQsA3/sPwYxentS8WambNyzDF3B
         5Iu3Q2G4+l6sl3tkhRRIbrE4Z8oUX1GzYD38curEZTsiE9BVZdnpI8XJLWQrA9GhhUJP
         luPPGGgCQj/OBeermmUTIPoFtl4TEhq2JG+RN3ibvZrSptN6B1BMI8pcqhXlhjxPs+tS
         UqrbxMCuLpr7h6XuVNY1O0StmeqWjrKpEqXzhcW7n5IRara2nM7VJCtXL3KzU1sVjg9/
         Fmb6xqNVi5li9aGKECQea7XOkGfYhQW3bq05b7sfh1I0dxJV2RZFeMlnQ8wl4g0t1hOh
         JStw==
X-Gm-Message-State: ABuFfoifDT2aX7oT4v0HtCTVwY+TfyVONzPSX0+3hYM4boJQa0KZHAdq
        +TcNsr5e21C1f5y1IJVVb5Y=
X-Google-Smtp-Source: ACcGV631Kq1PQGRoYjj95V3UNTsADtaTqYf364lVK7YPkRClHMxa7qCJtZZWqgahzFr8JK2youeoiw==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20-v6mr12066429plp.115.1539749279026;
        Tue, 16 Oct 2018 21:07:59 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id i21-v6sm20998554pgj.55.2018.10.16.21.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Oct 2018 21:07:58 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Moese <mmoese@suse.de>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     "sudheer.v" <open.sudheer@gmail.com>,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>
Subject: [[PATCH] 1/9] DT-changes-for-DMA-UART-of-AST2500
Date:   Wed, 17 Oct 2018 09:40:58 +0530
Message-Id: <1539749466-3912-2-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: sudheer.v <open.sudheer@gmail.com>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 20 ++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi         | 85 ++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 5dbb33c..f98d55b 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -64,6 +64,26 @@
 	status = "okay";
 };
 
+&ast_uart_sdma{
+	status = "okay";
+};
+
+&dma_uart0 {
+	status = "disabled";
+};
+
+&dma_uart1 {
+	status = "disabled";
+};
+
+&dma_uart2 {
+	status = "okay";
+};
+
+&dma_uart3 {
+	status = "okay";
+};
+
 &mac0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d92f047..ba8edd1 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -436,6 +436,91 @@
 				status = "disabled";
 			};
 
+			ast_uart_sdma: uart_sdma@1e79e000 {
+				compatible = "aspeed,ast-uart-sdma";
+				reg = <0x1e79e000 0x400>;
+				interrupts = <50>;
+				#dma-cells = <1>;
+				dma-channels = <8>;
+				status = "disabled";
+			};
+
+			dma_uart0: dma_uart0@1e783000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e783000 0x1000>;
+				interrupts = <9>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART1CLK>;
+				reg-shift = <2>;
+				dma-channel = <0>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd1_default
+				&pinctrl_rxd1_default &pinctrl_ncts1_default
+				&pinctrl_ndcd1_default &pinctrl_ndsr1_default
+				&pinctrl_ndtr1_default &pinctrl_nri1_default
+				&pinctrl_nrts1_default>;
+				dma-names = "rx", "tx";
+				dmas = <&ast_uart_sdma 1>, <&ast_uart_sdma 0>;
+				status = "disabled";
+			};
+
+			dma_uart1: dma_uart1@1e78d000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e78d000 0x1000>;
+				interrupts = <32>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART2CLK>;
+				reg-shift = <2>;
+				dma-channel = <1>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd2_default
+				&pinctrl_rxd2_default &pinctrl_ncts2_default
+				&pinctrl_ndcd2_default &pinctrl_ndsr2_default
+				&pinctrl_ndtr2_default &pinctrl_nri2_default
+				&pinctrl_nrts2_default>;
+				dma-names = "rx", "tx";
+				dmas = <&ast_uart_sdma 3>, <&ast_uart_sdma 2>;
+				status = "disabled";
+};
+
+			dma_uart2: dma_uart2@1e78e000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e78e000 0x1000>;
+				interrupts = <33>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART3CLK>;
+				reg-shift = <2>;
+				dma-channel = <2>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd3_default
+				&pinctrl_rxd3_default &pinctrl_ncts3_default
+				&pinctrl_ndcd3_default &pinctrl_ndsr3_default
+				&pinctrl_ndtr3_default &pinctrl_nri3_default
+				&pinctrl_nrts3_default>;
+				dma-names = "rx", "tx";
+				dmas = <&ast_uart_sdma 5>, <&ast_uart_sdma 4>;
+				status = "disabled";
+};
+
+			dma_uart3: dma_uart3@1e78f000{
+				compatible = "aspeed,ast-sdma-uart";
+				reg = <0x1e78f000 0x1000>;
+				interrupts = <34>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART4CLK>;
+				reg-shift = <2>;
+				dma-channel = <3>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_txd4_default
+				&pinctrl_rxd4_default &pinctrl_ncts4_default
+				&pinctrl_ndcd4_default &pinctrl_ndsr4_default
+				&pinctrl_ndtr4_default &pinctrl_nri4_default
+				&pinctrl_nrts4_default>;
+				dma-names = "rx", "tx";
+				dmas = <&ast_uart_sdma 7>, <&ast_uart_sdma 6>;
+				status = "disabled";
+};
+
 			i2c: i2c@1e78a000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
-- 
1.9.1

