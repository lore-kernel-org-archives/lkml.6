Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE38FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A038721727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A038721727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeHNUWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:22:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56864 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeHNUW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:22:29 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5B1BDE41;
        Tue, 14 Aug 2018 17:34:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.14 021/104] ARM: dts: imx6sx: fix irq for pcie bridge
Date:   Tue, 14 Aug 2018 19:16:35 +0200
Message-Id: <20180814171516.576101177@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

commit 1bcfe0564044be578841744faea1c2f46adc8178 upstream.

Use the correct IRQ line for the MSI controller in the PCIe host
controller. Apparently a different IRQ line is used compared to other
i.MX6 variants. Without this change MSI IRQs aren't properly propagated
to the upstream interrupt controller.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Fixes: b1d17f68e5c5 ("ARM: dts: imx: add initial imx6sx device tree source")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6sx.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1305,7 +1305,7 @@
 				  0x82000000 0 0x08000000 0x08000000 0 0x00f00000>;
 			bus-range = <0x00 0xff>;
 			num-lanes = <1>;
-			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clks IMX6SX_CLK_PCIE_REF_125M>,
 				 <&clks IMX6SX_CLK_PCIE_AXI>,
 				 <&clks IMX6SX_CLK_LVDS1_OUT>,


