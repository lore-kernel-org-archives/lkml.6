Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EA1ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ED020856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0ED020856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=digi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeJYXnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:43:09 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.3]:21912 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727454AbeJYXnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:43:08 -0400
Received: from [67.219.250.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.us-west-2.aws.symcld.net id 2F/0C-08863-3CCD1DB5; Thu, 25 Oct 2018 15:09:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRWlGSWpSXmKPExsXi5LtOQPfwnYv
  RBgs6xS16z51ksph/5ByrxZWv79ksNm6+zWKxaupOFotNj6+xWnT9WslscXnXHDaLpdcvMlm0
  7j3CbvF3+yYWixdbxC1+7prH4sDrsWbeGkaPnbPusntsWtXJ5rH92wNWj/vdx5k8Ni+p99j4b
  geTR/9fA4/Pm+QCOKNYM/OS8isSWDOefF3CXvCEs+Lw6z9sDYyrOLoYuTiEBFYxSrzo+8YK4W
  xhlOi7/xDI4eRgE9CRmLL/MAuILSKQK7H78Q6wImaBKUwSp7/tYgNJCAtESpw+sxvMZhFQlVg
  67SQTiM0r4CYx7dlpsGYJATmJm+c6mUFsTgF3iStT54MtEAKqWXDpHztEvaDEyZlPwOqZBSQk
  Dr54wQxRoyyxZcUFRog5ChJrD5xnmsDIPwtJyywkLQsYmVYxWiQVZaZnlOQmZuboGhoY6BoaG
  ukaGlkAsYFeYpVuol5psW55anGJrpFeYnmxXnFlbnJOil5easkmRmBMpRQ0VOxgPLUo/RCjJA
  eTkihvYsrFaCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvEm3gXKCRanpqRVpmTnA6IZJS3DwKIn
  wngNJ8xYXJOYWZ6ZDpE4x6nIsafg/nVmIJS8/L1VKnLcdpEgApCijNA9uBCzRXGKUlRLmZWRg
  YBDiKUgtys0sQZV/xSjOwagkzLsEZApPZl4J3KZXQEcwAR0xQ+ECyBEliQgpqQbGE4cvBj6YG
  coREuc1N61jm4/WR36JJ6y6svflEwI0eqwfJsuXabKrMovMeztn5uKzn1qcH3T6Vui3tYlIzp
  Ve0mH19A7vwiSv7/KbGyxW2p3sYnunc7ItdbPwtxKmNfGz+uIE9q4MSrV+L7rx8DwPSaFXBkb
  Rc5Zw3Aza8sr579OY0NK2H4eUWIozEg21mIuKEwHe9t5ALwMAAA==
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-13.tower-325.messagelabs.com!1540480194!1345379!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19215 invoked from network); 25 Oct 2018 15:09:55 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-13.tower-325.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Oct 2018 15:09:55 -0000
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 25 Oct 2018
 10:09:53 -0500
Received: from log-linux-hp-agonzal.digi.com (10.101.2.214) by
 dor-sms-xch01.digi.com (10.49.8.99) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 25 Oct 2018 17:09:51 +0200
From:   Alex Gonzalez <alex.gonzalez@digi.com>
To:     <thierry.reding@gmail.com>, <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <shawnguo@kernel.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux-imx@nxp.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <alex.gonzalez@digi.com>
Subject: [PATCH v1 4/4] ARM: dts: ccimx6ulsbcpro: Add support for Goodix touch controller
Date:   Thu, 25 Oct 2018 17:09:33 +0200
Message-ID: <1540480173-12009-5-git-send-email-alex.gonzalez@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.214]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ConnectCore 6UL SBC Pro has an AUO/Goodix LCD accessory kit that is
connected on the LVDS interface through an on-board LVDS transceiver.

This change adds support for the touch interface.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
index f6e6b2cf780b..3749fdda3611 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
@@ -117,6 +117,19 @@
 	};
 };
 
+&i2c1 {
+	touchscreen@14 {
+		compatible = "goodix,gt911";
+		reg = <0x14>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_goodix_touch>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
+		irq-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+};
+
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat0_17
@@ -290,6 +303,12 @@
 		>;
 	};
 
+	pinctrl_goodix_touch: goodixgrp{
+		fsl,pins = <
+			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1020
+		>;
+	};
+
 	pinctrl_lcdif_dat0_17: lcdifdatgrp0-17 {
 		fsl,pins = <
 			MX6UL_PAD_LCD_DATA00__LCDIF_DATA00	0x79
