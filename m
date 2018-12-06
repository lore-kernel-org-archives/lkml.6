Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5571FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2256621479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2256621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbeLFKJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:09:56 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40931 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:09:54 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so13680070qki.7;
        Thu, 06 Dec 2018 02:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=B1Ek6CSKUKobmAWbvbtfseZEVwX/TEbsIxU/ItCuEZE=;
        b=aH1wt5ToKcdg63I8EMWpPsgZTTTTUjgBgb74ThHe5IYsnNmo/CblQJsQdFA+cyjd71
         HK4Pu9YRhfkG/Ool9rdul310jZbVET4/TKzCppnbcrxkT1lCSMyY2/efxLgUse0lJBzn
         pAJdvfQfIei/wRC6ubW1SZ39n8XVbQP5fYe0k1GpfbUkDRTtHh0xwDa9YkQkKHsoSUBv
         PcH0t1JFegvyXyjNkgLE3XwNRFocr0CMp/3SdPFxT1tOou2hVbtgwLSvXpmLBswreSyZ
         Yd6Vq4Vuz2bH85kQEE9OYsccbKC3IxeXaTUk/IEtkuiy1IZLALSGu6npzzjxddcqcZXC
         e9/Q==
X-Gm-Message-State: AA+aEWak+UWgBJo60W5CqlX6NWveHoFGxMfwQjDuZbvBwGG/HxbmpSR8
        4rgBc7oHvbJiQ+oYs3mIyrU=
X-Google-Smtp-Source: AFSGD/UTLydvHnKZsQ4/tc8fGloaj43fdcjDsK9TbY+EkKM8wgv6y/B2rRjlZLIFaMdRMJv9R4GkNQ==
X-Received: by 2002:ae9:ee02:: with SMTP id i2mr25155380qkg.179.1544090993242;
        Thu, 06 Dec 2018 02:09:53 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id x127sm17458704qkx.43.2018.12.06.02.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 02:09:52 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Thu, 06 Dec 2018 08:09:46 -0200
From:   Otavio Salvador <otavio@ossystems.com.br>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 5/9] ARM: dts: imx7d-pico: Pass the Ethernet PHY reset GPIO
Date:   Thu,  6 Dec 2018 08:09:01 -0200
Message-Id: <20181206100905.15053-6-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

Pass the "phy-reset-gpios" property in order to describe the GPIO
that performs the Ethernet PHY reset.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/boot/dts/imx7d-pico.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index cb30bded1e4a..35791a1adabf 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -88,6 +88,7 @@
 	phy-mode = "rgmii";
 	phy-handle = <&ethphy0>;
 	fsl,magic-packet;
+	phy-reset-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	mdio {
@@ -290,6 +291,7 @@
 			MX7D_PAD_ENET1_RGMII_RD2__ENET1_RGMII_RD2	0x1
 			MX7D_PAD_ENET1_RGMII_RD3__ENET1_RGMII_RD3	0x1
 			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x1
+			MX7D_PAD_SD3_RESET_B__GPIO6_IO11                0x1  /* Ethernet reset */
 		>;
 	};
 
-- 
2.19.2

