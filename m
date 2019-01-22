Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4824DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B5720870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfAVF1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:27:01 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:45322 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfAVF1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:27:00 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43kH3R2YFZz1qvTy;
        Tue, 22 Jan 2019 06:26:59 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43kH3R2R8qz1qqkg;
        Tue, 22 Jan 2019 06:26:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id iMEDMsFCz54I; Tue, 22 Jan 2019 06:26:58 +0100 (CET)
X-Auth-Info: uWdUUPNXHBrxQzk9puR8sBxYMuODA//UX6REnnTcqZE=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 22 Jan 2019 06:26:58 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id C83C8182372;
        Tue, 22 Jan 2019 06:26:26 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id B444C37A6; Tue, 22 Jan 2019 06:26:26 +0100 (CET)
From:   Heiko Schocher <hs@denx.de>
To:     devicetree@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/2] ARM: dts: am335x-shc.dts: fix wrong cd pin level
Date:   Tue, 22 Jan 2019 06:26:23 +0100
Message-Id: <20190122052623.1779840-3-hs@denx.de>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190122052623.1779840-1-hs@denx.de>
References: <20190122052623.1779840-1-hs@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cd pin on mmc1 is GPIO_ACTIVE_LOW not GPIO_ACTIVE_HIGH

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 arch/arm/boot/dts/am335x-shc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index 5cdaf0cd9401..bfbe27a80006 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -213,7 +213,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	bus-width = <0x4>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 	cd-inverted;
 	max-frequency = <26000000>;
 	vmmc-supply = <&vmmcsd_fixed>;
-- 
2.17.2

