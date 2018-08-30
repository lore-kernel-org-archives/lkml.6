Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE8FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C452720834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C452720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeH3Qtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:49:31 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:35261 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbeH3Qtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:49:31 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 421Mhf72Njz1r8T7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:47:30 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 421Mhf6wQTz1tLP5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:47:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id roPIsKnF0gh3 for <linux-kernel@vger.kernel.org>;
        Thu, 30 Aug 2018 14:47:30 +0200 (CEST)
X-Auth-Info: Z8QRGr0n2+CW94rzptyu/knVgI681BPKGch08OAqimg=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:47:30 +0200 (CEST)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id D765718082A;
        Thu, 30 Aug 2018 14:47:10 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
        id A990A23B3; Thu, 30 Aug 2018 14:47:07 +0200 (CEST)
From:   Heiko Schocher <hs@denx.de>
To:     linux-kernel@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] ARM: dts: imx6ull: fix pinmux input_val for uart5 rx pin
Date:   Thu, 30 Aug 2018 14:47:02 +0200
Message-Id: <20180830124702.12572-1-hs@denx.de>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on the imx6ull the input_val for uart5 rx function
of pin MX6UL_PAD_UART5_RX_DATA__UART5_DCE_RX
is 7 and not 5 as on the imx6ul. With this
patch, console on an imx6ull based board works
with uart5.

Signed-off-by: Heiko Schocher <hs@denx.de>

---

 arch/arm/boot/dts/imx6ull-pinfunc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6ull-pinfunc.h b/arch/arm/boot/dts/imx6ull-pinfunc.h
index fdc46bb09cc1a..d835aeae5485b 100644
--- a/arch/arm/boot/dts/imx6ull-pinfunc.h
+++ b/arch/arm/boot/dts/imx6ull-pinfunc.h
@@ -61,5 +61,6 @@
 #define MX6ULL_PAD_CSI_DATA05__ESAI_TX_CLK                        0x01F8 0x0484 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_DATA06__ESAI_TX5_RX0                       0x01FC 0x0488 0x0000 0x9 0x0
 #define MX6ULL_PAD_CSI_DATA07__ESAI_T0                            0x0200 0x048C 0x0000 0x9 0x0
+#define MX6ULL_PAD_UART5_RX_DATA__UART5_DCE_RX		0x00C0 0x034C 0x0644 0 7
 
 #endif /* __DTS_IMX6ULL_PINFUNC_H */
-- 
2.14.4

