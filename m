Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C30C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D523126C24
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9WGfBo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D523126C24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeF1Ehk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:37:40 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39944 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753194AbeF1Ehf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:37:35 -0400
Received: by mail-pg0-f65.google.com with SMTP id w8-v6so1894118pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 21:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3cuipTcFRrUJPAjq8mfXM4reAmuN12T/4GSd9IYcs6c=;
        b=l9WGfBo8uSzNBQ4oIO8O7AAN2qBvT/kiS+FaGbao7RPupVxPmBRg+Oq3lV27HmNPIX
         guGfzNzxgn/B5Fo8Kp00GNfT3/FwVdlpoPEpkJ1l/H7szABeGW78peDEJA2BLqavkltX
         0hpjawMYE9hFL5Qb0PH930vRmXauAu9aiu4cGmOudplx8o+/wid/2Hs80jocQXzYitzw
         NmtluRk75kqAAkFKkbOUaGsa1o2HAhcnxOv2fFA0XPn5ZQsaLIzDSfrwcORok6eCrFPz
         djF1GyBZYhrO4gY+SXHzDwFolyWXKxAfgK9uYDUUyXYmYc+KtTEwABVVYNlJrlixtcQR
         tMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3cuipTcFRrUJPAjq8mfXM4reAmuN12T/4GSd9IYcs6c=;
        b=tWNnwB7mwxcHW0mvGPIvVVFGPjI94vTZz1s/ANeSgroea1V55SYCvou9B4se6mZAoZ
         DHq5TeZ0hxrCF3ul0OpYCWcX4sSK7CJ91Q1YJ7rlO/Lt/ZDgILz+vhn1o4SJ1ap8D0AB
         Wh+cvPfpYCnKmI9xZQ9GR6IPAXosbnylbdL3uPgf/0KEoeu9u4YWpgAp6DXVu58JJe9Y
         r3ZZgiPKuTFD0HlW24IODNNZAXUgB8Pn8FN3rJoQyFv6OkjKnonZKRuWPP+DPf4IMoft
         iBCxy3x+cTEpM2RwFhx8RaebVRFVhDAzRY8nd/4ntT1Cto+DzfqxISpxcKTtHkIdXIHe
         ERpQ==
X-Gm-Message-State: APt69E34femVF6+UeaOW/2tYN3P5zvFtY4tqJ1TLtz6OLIoonoCpEoeS
        c5fEpOZsxEsFAW+25buNEs0=
X-Google-Smtp-Source: AAOMgpenjSbgNf7xblaI9ZWuR1OH3UOvFS/bvjis4fpzYUUfOrjoZ7oI8cBYdbnjBFG293kXE1+xrw==
X-Received: by 2002:a62:39cd:: with SMTP id u74-v6mr8632890pfj.95.1530160654439;
        Wed, 27 Jun 2018 21:37:34 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id j23-v6sm8366892pfh.45.2018.06.27.21.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 21:37:33 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Fix reg for usbh1phy
Date:   Wed, 27 Jun 2018 21:37:12 -0700
Message-Id: <20180628043713.14425-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's already a USB PHY with reg of zero on that bus - usbphy0, used
by usbotg (included from imx51.dtsi). Move usbh1phy to @1 avoid
address collision.

Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx51-babbage.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index b8ca73d3d379..541c6e67ad1a 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -175,9 +175,9 @@
 		#size-cells = <0>;
 		compatible = "simple-bus";
 
-		usbh1phy: usbh1phy@0 {
+		usbh1phy: usbh1phy@1 {
 			compatible = "usb-nop-xceiv";
-			reg = <0>;
+			reg = <1>;
 			clocks = <&clk_usb>;
 			clock-names = "main_clk";
 			reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
-- 
2.17.1

