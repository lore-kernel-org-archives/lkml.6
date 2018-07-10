Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8CCC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6118920936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6118920936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbeGJS1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:27:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44756 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732400AbeGJS1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:27:19 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A074DB4;
        Tue, 10 Jul 2018 18:27:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 4.4 14/47] ARM: dts: imx6q: Use correct SDMA script for SPI5 core
Date:   Tue, 10 Jul 2018 20:24:38 +0200
Message-Id: <20180710182337.738673855@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>

commit df07101e1c4a29e820df02f9989a066988b160e6 upstream.

According to the reference manual the shp_2_mcu / mcu_2_shp
scripts must be used for devices connected through the SPBA.

This fixes an issue we saw with DMA transfers.
Sometimes the SPI controller RX FIFO was not empty after a DMA
transfer and the driver got stuck in the next PIO transfer when
it read one word more than expected.

commit dd4b487b32a35 ("ARM: dts: imx6: Use correct SDMA script
for SPI cores") is fixing the same issue but only for SPI1 - 4.

Fixes: 677940258dd8e ("ARM: dts: imx6q: enable dma for ecspi5")
Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6q.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -95,7 +95,7 @@
 					clocks = <&clks IMX6Q_CLK_ECSPI5>,
 						 <&clks IMX6Q_CLK_ECSPI5>;
 					clock-names = "ipg", "per";
-					dmas = <&sdma 11 7 1>, <&sdma 12 7 2>;
+					dmas = <&sdma 11 8 1>, <&sdma 12 8 2>;
 					dma-names = "rx", "tx";
 					status = "disabled";
 				};


