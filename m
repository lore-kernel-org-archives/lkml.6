Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0E9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A272077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A272077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbeICVr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:47:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45878 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbeICVrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:47:25 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3D5F0D30;
        Mon,  3 Sep 2018 17:26:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huibin Hong <huibin.hong@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.14 099/165] arm64: dts: rockchip: corrected uart1 clock-names for rk3328
Date:   Mon,  3 Sep 2018 18:56:25 +0200
Message-Id: <20180903165700.484798147@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
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

From: Huibin Hong <huibin.hong@rock-chips.com>

commit d0414fdd58eb51ffd6528280fd66705123663964 upstream.

Corrected the uart clock-names or the uart driver might fail.

Fixes: 52e02d377a72 ("arm64: dts: rockchip: add core dtsi file for RK3328 SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -331,7 +331,7 @@
 		reg = <0x0 0xff120000 0x0 0x100>;
 		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
-		clock-names = "sclk_uart", "pclk_uart";
+		clock-names = "baudclk", "apb_pclk";
 		dmas = <&dmac 4>, <&dmac 5>;
 		#dma-cells = <2>;
 		pinctrl-names = "default";


