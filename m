Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA521C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9B3219CA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTzMZVIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9B3219CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeHRA2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 20:28:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37293 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeHRA2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 20:28:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so8486028wmc.2;
        Fri, 17 Aug 2018 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sfWb3jqRe3NudcSY6Gq6qwsSrrJaCFNdrRUWVZgmJLU=;
        b=lTzMZVIk7Nuvv9M8+g1UJyaRcJCelF48atz/zN4jw31QF4ifB0YMUngadhy5v71zTR
         DmqzCrPPqiwP3q9/LBhxosa5n/u2CbCFgoa45TPrHpYXBi/9XZqBC2vwCNELHxcGXy3k
         BjeaO2+UQwOOFLZjpaKTW5OCBqwUgeVEDMiQqkNSKJEnhHl/QXQlm/82Uwe1nniirmWn
         hxGAMCHmCu5kRQAY3QV62bmdHFReXHcj8Q+0u3W9CL+4UzrL4hzpdC6ko8Qn5Ld497kr
         N9MidK0TisPvzwAthle558TaIa129Jqb829EWgOmuAWrT3S2A89byPzETE27Ozlvwah9
         OOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sfWb3jqRe3NudcSY6Gq6qwsSrrJaCFNdrRUWVZgmJLU=;
        b=ieKMTumUvTewZ+YQWrOyl4rBByRCJPaWOfgmMDg7d+WPL9QFxU+G0rbypwe9iPhgca
         2eQj4tKMsCVsjbkhn7KE+wtzGiwmnraTYNiVCwaIGl+wdMPBx5A/nXtsxRGdZkbK84u+
         T5Ha4nbIGHHBpZgvU93So68aZ9BcZZUHuomWlKt1U7ZE5J9stYXEYkiINnEGtKt6uZ7H
         yfYbr+KPizMT8A96PGQKthlEbqdNF1x5eEGvx7GH/S75DLF34vNPxpliBSkD+gxN8MK6
         5nhpr+4C9BPEf15uFb5kU+Qap8iEHX1bjs39LN035zahInRJW5C2JJh2g23cBaXvoKOU
         eMvg==
X-Gm-Message-State: AOUpUlHEje7N6y6OgBn6vtNkqy4d8O4JAYq/wvh/wn8IP3/JsLR/helW
        wOkU99yYH5atF8xEh+rPu8s=
X-Google-Smtp-Source: AA+uWPx/oafz4wJHKGohWyU5yKL6gOIDk6hsygg4e+AKKfBdxMGzi0Y5WuwFJucLBxPxrdwm2TZHrg==
X-Received: by 2002:a1c:c3c4:: with SMTP id t187-v6mr21034557wmf.123.1534541024834;
        Fri, 17 Aug 2018 14:23:44 -0700 (PDT)
Received: from menoah.home ([2a01:cb19:190:c500:69e4:8fe8:bd57:3de2])
        by smtp.gmail.com with ESMTPSA id f17-v6sm2088196wrs.1.2018.08.17.14.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Aug 2018 14:23:43 -0700 (PDT)
From:   Pierre-Jean Texier <texier.pj2@gmail.com>
Cc:     texier.pj2@gmail.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx7s-warp: enable i2c3 device support
Date:   Fri, 17 Aug 2018 23:23:17 +0200
Message-Id: <1534540997-20094-1-git-send-email-texier.pj2@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WaRP7 has one mikroBUS socket on the back to plug click boards.
This patch allows to interact with some of these
i2c modules (EEPROM, RTC and so on).

Signed-off-by: Pierre-Jean Texier <texier.pj2@gmail.com>
---
 arch/arm/boot/dts/imx7s-warp.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index fa390da..b3d0951 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -216,6 +216,13 @@
 	status = "okay";
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+};
+
 &i2c4 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -346,6 +353,13 @@
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX7D_PAD_I2C3_SDA__I2C3_SDA	0x4000007f
+			MX7D_PAD_I2C3_SCL__I2C3_SCL	0x4000007f
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX7D_PAD_I2C4_SCL__I2C4_SCL	0x4000007f
-- 
2.7.4

