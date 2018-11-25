Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF51BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCE42084E
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 21:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCE42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeKZILy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 03:11:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46632 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 03:11:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id q1so11111208qkf.13;
        Sun, 25 Nov 2018 13:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=jgBOqcDQ+ti+oJHZVWI90YV76F+Wfz4KPjje9/9ZJ4s=;
        b=FLK0v9j/UbRph5P1GUr3O8G6ZpnYAblx5Ia6KFXsEC4+U1nFOvAJd+6CEa0ZOPWvxt
         MGI52bZYYk4H+sAK2PZ26QUDFrgh+u5vqaNHpYUkvQYwu7lxgaebC2IT5dC8QofKrH6e
         DiljzXTCZvbdZwYvZnSQhDtFz8DqV1iJAU9d0NbDK+bvEdJpI3uaEOKq2SXmFtGdWIA/
         HD/FvAJDkfEawCRPz94VE/NtGwt3tKTT175txUbFX6/IbvLEVOZGu0xzqVblxAvQkWgF
         iQG5DZ1fmq2jv0eiPH5/8D0zZVLbKt72Td0uAtz/QVXIcnA0UIIeM9IgcGu9C8ZlheRw
         2ORA==
X-Gm-Message-State: AA+aEWb/5ErfjS0UTDILLAf5XBj3yITJ8Hyrmp6tZ3bLjwSh9FsdRsPO
        nKqyVT/AVVzri+GFbisUFBLIc98s
X-Google-Smtp-Source: AFSGD/XsxB/ItfUXL9rRCVOg+QZKCBOouMRYfFgHRxTLjaAYTmiIgtiCBtuEaJAYxQ+VTO0f5CNy1w==
X-Received: by 2002:a37:1909:: with SMTP id k9mr22285856qkh.61.1543180793502;
        Sun, 25 Nov 2018 13:19:53 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id i33sm28453478qtb.97.2018.11.25.13.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 13:19:52 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 25 Nov 2018 19:19:47 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 06/13] ARM: dts: rv1108: Add GMAC support
Date:   Sun, 25 Nov 2018 19:19:00 -0200
Message-Id: <20181125211907.9895-6-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GMAC support for RV1108.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 4f4275599f7a..c7a26f82655b 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -516,6 +516,27 @@
 		status = "disabled";
 	};
 
+	gmac: eth@30200000 {
+		compatible = "rockchip,rv1108-gmac";
+		reg = <0x30200000 0x10000>;
+		rockchip,grf = <&grf>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq", "eth_wake_irq";
+		clocks = <&cru SCLK_MAC>,
+			<&cru SCLK_MAC_RX>, <&cru SCLK_MAC_RX>,
+			<&cru SCLK_MAC_REF>, <&cru SCLK_MAC_REFOUT>,
+			<&cru ACLK_GMAC>, <&cru PCLK_GMAC>;
+		clock-names = "stmmaceth",
+			"mac_clk_rx", "mac_clk_tx",
+			"clk_mac_ref", "clk_mac_refout",
+			"aclk_mac", "pclk_mac";
+		phy-mode = "rmii";
+		pinctrl-names = "default";
+		pinctrl-0 = <&rmii_pins>;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@32010000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
@@ -641,6 +662,21 @@
 			input-enable;
 		};
 
+		gmac {
+			rmii_pins: rmii-pins {
+				rockchip,pins =	<1 RK_PC5 RK_FUNC_2 &pcfg_pull_none>,
+						<1 RK_PC3 RK_FUNC_2 &pcfg_pull_none>,
+						<1 RK_PC4 RK_FUNC_2 &pcfg_pull_none>,
+						<1 RK_PB2 RK_FUNC_3 &pcfg_pull_none_drv_12ma>,
+						<1 RK_PB3 RK_FUNC_3 &pcfg_pull_none_drv_12ma>,
+						<1 RK_PB4 RK_FUNC_3 &pcfg_pull_none_drv_12ma>,
+						<1 RK_PB5 RK_FUNC_3 &pcfg_pull_none>,
+						<1 RK_PB6 RK_FUNC_3 &pcfg_pull_none>,
+						<1 RK_PB7 RK_FUNC_3 &pcfg_pull_none>,
+						<1 RK_PC2 RK_FUNC_3 &pcfg_pull_none>;
+			};
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins = <0 RK_PB1 RK_FUNC_1 &pcfg_pull_none_smt>,
-- 
2.19.1

