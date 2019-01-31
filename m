Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC55CC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8973B20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPiPlB3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfAaUn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:43:58 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:33432 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbfAaUn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:43:56 -0500
Received: by mail-pg1-f171.google.com with SMTP id z11so1876077pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 12:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pe73Lkv9Hk1MIlu+vYdLxJuU5C6xW3dASTYFyCiskD4=;
        b=jPiPlB3p/Oqrg47KjEhCFhXAG8TiR6N886MNsavLSEzUXvSYOnGRtOSzbitWg1KWln
         VFm4fKp3yU5z/fG9mcgtdfY3zIOY1oBkBKO7SmCZBcGV0BkUrM6rhwUSAxcyuELh6VpQ
         1c/gVs5s/z0LJbqOgyJCko5/nC6h/UZvpGzSlBt12abu0vQtlv4CnoYZYGy9/5Une2Sf
         BWcxDGClguJZyJNm0ZP6nMyFDOE6dWUuOQxRdvZx19iQAVpxcCrElDlTmuNkBktFx6et
         g9sRKXQuYKorXiPbgJMNgMWc4dJNwWqd/cLsofJGiGBHWQ+iDnqlPcZ2YIsfOJx6zpYb
         wkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pe73Lkv9Hk1MIlu+vYdLxJuU5C6xW3dASTYFyCiskD4=;
        b=t8+8jp33YO7Tjv/VBjA2RMDvEj/5/NNzxWHmJNu4N+xZinmzx/66za5Ok7X1cwbny9
         GsgFjvKA3aRStNAHni5Vkx4oZqYzYmWs7GEytB88iY1DjM1CoviHZgXDBDM0Bts2EohU
         f1VCX4ICuHZIgIQ8Bu2CslsiosQYfbc7ff1s1YRMPpdo39evLTIJG2i0v992h3FJWz02
         8fiKOaKbSHX003syvWrHio/XtGWMNcHTXXPZoHhTZHB4T+XUi6yBLyT1n/ZXZiOCJVw2
         vQGu60mtUk7Lz5IrmXEmujCkUT8p6TcMRUb8oyyMYF8bqMDZUhmsu04x3lcoqkDuz89O
         gvWw==
X-Gm-Message-State: AJcUuke6GhpPmcWq9+n+HJLos3SDaS9hB03EVGRqaSxs3eRUI0MlUpqt
        gEL4QxTqDnT3wdCkoKMz/e4=
X-Google-Smtp-Source: ALg8bN7Jk+/LzgF96bF0YT/T4azzt9XYAoB+stjNRKBvew00nwglQCtd5BejlQqGz9xblLRNrJYdnQ==
X-Received: by 2002:a62:8096:: with SMTP id j144mr36830521pfd.140.1548967435145;
        Thu, 31 Jan 2019 12:43:55 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id s190sm7272034pfb.103.2019.01.31.12.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 12:43:54 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 5/5] arm64: dts: imx8mq-evk: Enable PCIE0 interface
Date:   Thu, 31 Jan 2019 12:43:33 -0800
Message-Id: <20190131204333.31846-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131204333.31846-1-andrew.smirnov@gmail.com>
References: <20190131204333.31846-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PCIE0 interface connected to BCM4356 WiFi/Bluetooth module.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 23 ++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 64acccc4bfcb..6c7af6c0c9a6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -40,6 +40,14 @@
 	status = "okay";
 };
 
+&gpio5 {
+ 	wl-reg-on {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -131,6 +139,13 @@
 	};
 };
 
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -195,6 +210,14 @@
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_I2C4_SCL_PCIE1_CLKREQ_B		0x76
+			MX8MQ_IOMUXC_UART4_TXD_GPIO5_IO29		0x16
+			MX8MQ_IOMUXC_UART4_RXD_GPIO5_IO28		0x16
+		>;
+	};
+
 	pinctrl_reg_usdhc2: regusdhc2grpgpio {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
-- 
2.20.1

