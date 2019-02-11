Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D49C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352AA21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899886;
	bh=PkiwelgmGzruBb5zzylvXoy8CMbYr2EWITUDTYBDMY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jSmVVE/B82zDpbLTDEMnR38B/vut4hRuVmkTFImj8si4xYMnDPZm7QIjp0xaGluvt
	 19Q3XohbOcd/crc5weJbXQzreMB+suJJfn8ervhW0AzuLWd8mDGEI+iuA7OljAkQLb
	 78jseJXNEYmLOuXyXad4IJPL0QHsxn/Vw44NRDMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbfBKOoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732109AbfBKOoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:44:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBABA214DA;
        Mon, 11 Feb 2019 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896242;
        bh=PkiwelgmGzruBb5zzylvXoy8CMbYr2EWITUDTYBDMY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tkQfOUtgtHhgjMGF9j+vQXy81g7UDuEzWPTCnPY+PfGkAAK53LxZXIH0cajGjMIiP
         zkGJWPZq4bMyXkVeHyAo70VnnftQn1yHY2fz47qpeUi0iQStLk+qNY3suMLmd/pw/q
         xoZjkTg65/r5y8aIvB6BDmO8gzkcvvk36wsQYV8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 118/313] ARM: dts: imx51-zii-rdu1: Do not specify "power-gpio" for hpa1
Date:   Mon, 11 Feb 2019 15:16:38 +0100
Message-Id: <20190211141901.723896774@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



