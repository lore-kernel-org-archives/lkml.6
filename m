Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D794C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A98A2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A98A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeLBV0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:26:09 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45184 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeLBV0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:26:09 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so11624024qtr.12;
        Sun, 02 Dec 2018 13:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:organization:content-transfer-encoding;
        bh=oOtyVZYPYhVv1dTbriat0rjkh3usuIjl8Abih+y5lwA=;
        b=aX90D67zVmwK1AvOBQOPHWXau71b5bbN3PaSWd+QpxH1UYXm2lBCS1RLA0bp8Z9L/C
         hD+f0oLhYPfPxErMSjAiojH1iwI1STYWKZAoHj4U7I74i8Mjn6JfCGMmOMwbQayBexsg
         ntB7CbwwPJ146LsuaaJ9twrVa5CJBtt/PhMjtZskN6nwsTTKYRnm/ebOY98ijDbhucFD
         Zs1gtjfVJ/fcTb7xVaJCCWGB+CLkhD1YAlo2+cTw/5t+aYolVT94Es/tkUJanmObvmoY
         GmGDtx95V3wET3G7V1GGj/Z/UjUHSyAtpTdnRLwtVLu33sTH1DUhv74CEYAtedsbijb9
         71+w==
X-Gm-Message-State: AA+aEWYnWcsMg3902AWp8MHHGQXkmYO3+PxRQN+UCSaN1zkZIlvAuRTa
        RwxWyOhwsEi854NwfxJy1wY=
X-Google-Smtp-Source: AFSGD/XOPV73f+FYO/Jxt9YfndoQbo9x4BDGAQs3Sd2ABn7y+FY4lbufVCrVLC7fZkF5jDiM0tKEpQ==
X-Received: by 2002:ac8:4454:: with SMTP id m20mr12774285qtn.381.1543785965805;
        Sun, 02 Dec 2018 13:26:05 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
        by smtp.gmail.com with ESMTPSA id o48sm7583933qtb.87.2018.12.02.13.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 13:26:05 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation); Sun, 02 Dec 2018 19:25:58 -0200
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
Subject: [PATCH 5/9] ARM: dts: imx7d-pico: Pass the Ethernet PHY reset GPIO
Date:   Sun,  2 Dec 2018 19:25:16 -0200
Message-Id: <20181202212520.16650-6-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
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

