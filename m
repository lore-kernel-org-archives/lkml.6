Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB16C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FF52175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691528;
	bh=n0xztCY9D2To8MpNbEesoGmBPOodHhRqJpw7V+qokhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xN/0hbZ5Znzow98RLF+7AB2UhZfBEbqmsp3PP2KxPzhaojiPmYb9bD/BPgDeL1s7y
	 pAzYHmq3tP9sLnGOKIRjMdg7eyuWv8TSHn26rUrv4CgZ1Y+Jc2gV9ia55yajWjKuAA
	 8kO2od0hvVBz9gSGWgwVPqMJr5YN7HEmXW/A1lF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfA1QF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731197AbfA1QFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:05:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E342147A;
        Mon, 28 Jan 2019 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691520;
        bh=n0xztCY9D2To8MpNbEesoGmBPOodHhRqJpw7V+qokhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpIxQ/qn+DULwvPu/VO8I/Cag4rTage5fzRVR5Vhz997dDUUBLvsoobfCajjoXl+/
         w11QQdd8XN4YnO/I6YHsWKH0/BJkTujTMAk0BDFjh/WK6dseSgi8L7iYurcBzrV3sI
         jf1lfZ0r3+S+ZweghYK0PDddHc3yJUh1tJB3lr3w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 126/258] ARM: dts: imx51-zii-rdu1: Do not specify "power-gpio" for hpa1
Date:   Mon, 28 Jan 2019 10:57:12 -0500
Message-Id: <20190128155924.51521-126-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

[ Upstream commit 79da07dec740a42c70963ebacbd2bf8866af9e20 ]

TPA6130A2 SD pin on RDU1 is not really controlled by SoC and instead
is only meant to notify the system that audio was "muted" by external
actors. To accommodate that, drop "power-gpio" property of hpa1 node as
well as specify a name for that GPIO so that userspace can access it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Tested-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 469cce2c0357..6e80254c4562 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -477,6 +477,15 @@
 };
 
 &gpio1 {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "", "hp-amp-shutdown-b", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "";
+
 	unused-sd3-wp-gpio {
 		/*
 		 * See pinctrl_esdhc1 below for more details on this
@@ -501,9 +510,6 @@
 	hpa1: amp@60 {
 		compatible = "ti,tpa6130a2";
 		reg = <0x60>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ampgpio>;
-		power-gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
 		Vdd-supply = <&reg_3p3v>;
 	};
 
@@ -677,7 +683,10 @@
 };
 
 &iomuxc {
-	pinctrl_ampgpio: ampgpiogrp {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX51_PAD_GPIO1_9__GPIO1_9		0x5e
 		>;
-- 
2.19.1

