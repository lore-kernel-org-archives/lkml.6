Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D6BC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDBB2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDBB2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeKEUHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:07:19 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.113]:18108 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbeKEUHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:07:19 -0500
Received: from [67.219.250.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-west-2.aws.symcld.net id 2D/D7-11706-CEF10EB5; Mon, 05 Nov 2018 10:48:12 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRWlGSWpSXmKPExsXi5LtOQPeN/IN
  ogyPbtSzmHznHarFx820Wi1VTd7JYbHp8jdWi69dKZovLu+awWSy9fpHJonXvEXaLv9s3sVi8
  2CLuwOWxZt4aRo9NqzrZPDYvqffY+G4Hk0f/XwOPz5vkAtiiWDPzkvIrElgzPh24xVTwia3i0
  vljjA2MX1i7GDk5hARWMko0bZbsYuQCsjczSky4/w8swSagIzFl/2EWEFtEQFJi7cpFzCBFzA
  JTmCROf9vFBpIQFvCX2LZ8EVARBweLgIrE7onaIGFeATeJuRMmsIPYEgJyEjfPdTJDxAUlTs5
  8AjaTWUBC4uCLF8wQRyhLbFlxgRGiXkFi7YHzTBMYeWchaZmFpGUBI9MqRoukosz0jJLcxMwc
  XUMDA11DQyNdQ2MTXSNDI73EKt0kvdJi3fLU4hJdILe8WK+4Mjc5J0UvL7VkEyMwxFMK2q7sY
  Py1PP0QoyQHk5Iob/ql+9FCfEn5KZUZicUZ8UWlOanFhxhlODiUJHiXyz2IFhIsSk1PrUjLzA
  FGG0xagoNHSYSXAxhxQrzFBYm5xZnpEKlTjIpS4rzzQPoEQBIZpXlwbbAIv8QoKyXMy8jAwCD
  EU5BalJtZgir/ilGcg1FJmHchyBSezLwSuOmvgBYzAS2+Jwu2uCQRISXVwNgTlL7x2P0C9p9S
  VlYXHqtYvFizxYOjqqyiJdH+bdVjkx93vaLfW8x/kfIveNXl9jePhaaUq/5UX9s4h1F1QaXq0
  z6j1ESxE37Muo9Tvvp+Dpt96IFsWG9mdoR20GHpD/dTE4VyPKbsOHfP8+C1wjXmV+KTJ81aIT
  DpSMO6ed2pXBcjxfsurFNiKc5INNRiLipOBACkEi7J6wIAAA==
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-3.tower-345.messagelabs.com!1541414891!2062871!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28092 invoked from network); 5 Nov 2018 10:48:12 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-3.tower-345.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Nov 2018 10:48:12 -0000
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 5 Nov 2018
 04:48:11 -0600
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 5 Nov 2018 11:48:09 +0100
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH] ARM: dts: imx6ul: ccimx6ulsom: Fix indentation on iomuxc nodes
Date:   Mon, 5 Nov 2018 11:48:04 +0100
Message-ID: <1541414884-19619-1-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects indentation problems in the gpmigrp and i2c1grp nodes.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
index ef26b2389c8f..c41ecee68ad9 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi
@@ -198,15 +198,15 @@
 			MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
 			MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
 			MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb0b1
-			>;
-		};
+		>;
+	};
 
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX6UL_PAD_UART4_TX_DATA__I2C1_SCL 0x4001b8b0
 			MX6UL_PAD_UART4_RX_DATA__I2C1_SDA 0x4001b8b0
-			>;
-		};
+		>;
+	};
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
