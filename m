Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B79ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66B12086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CQrCxf3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66B12086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeGQJ6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:58:10 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35220 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbeGQJ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:58:09 -0400
Received: by mail-pl0-f68.google.com with SMTP id w3-v6so219618plq.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L5m5dV8B3PCYn2WTmlF1m2BxJT5h/9rxOdGn08Yj740=;
        b=CQrCxf3Ma8iUY9PDA+OWUcD9E27DylBVWxNDi5WvUXMSMP6UzIC7VsgnnA4p1HCRkM
         tm5E2WZwQ7s/hn26qKt713lm1xfbUwfRSRsXJAX5VcO264DCPDZ27foMKow4TX5ye8Fn
         89CpDzhyaPMVkRHdVfkRaEdQGtyfGjrSNnqMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L5m5dV8B3PCYn2WTmlF1m2BxJT5h/9rxOdGn08Yj740=;
        b=exIapUtRSHkGPBT85lQnQderqjEPNr+ei80j5aqzfc8crgP0dzO1mRqFfVnOvbpA1f
         /SFPx0BpjcjpN2FBdXMbVA1BW8hMERl3DsEU6vBY1SoxC+SXI7cSnzTrtCSHZzAJxEz3
         jwKR1l7AtTPhkHVnOk1r5MZm0uerkmD474ttiKecZNzu0gfbFHz2SVV3Gb8q1eA6hLpt
         27IoVD5YE9vlWGWc3BPa1szj8JSxrJ3DOubMCdBDr4TQf+ssRz2fqh3rMgnCTYo3uaW3
         E4fRKzNcLz1OY8uU/6O5c6b1E5v8tAXwK8P4AJTuZPkcpzzhNyrLwiKsqsxWj4nRonYt
         iIUA==
X-Gm-Message-State: AOUpUlHuuuc/pkX+1UzGKVTn0CkP9wwqWy+oZI2vcwMQFbPUTlR3aIQn
        gmt2+fDG+Dfxi5K8TtUV5KVQjg==
X-Google-Smtp-Source: AAOMgpdI4HhVQBNk+gHwhfhnqoaLzT1WdZZ0DNI+nKgXLFJ1XjblrQnQ67YZpCYYEOjgXslewEwqEg==
X-Received: by 2002:a17:902:900b:: with SMTP id a11-v6mr862013plp.143.1531819588944;
        Tue, 17 Jul 2018 02:26:28 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id l85-v6sm2652869pfk.34.2018.07.17.02.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:26:28 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        Davide Bonfanti <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 3/3] ARM: dts: i.MX6: imx6dl-mamoj: Add usb host and device support
Date:   Tue, 17 Jul 2018 14:55:26 +0530
Message-Id: <20180717092526.32215-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180717092526.32215-1-jagan@amarulasolutions.com>
References: <20180717092526.32215-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add USB host and device support for BTicino i.MX6DL Mamoj board.

Signed-off-by: Simone CIANNI <simone.cianni@bticino.it>
Signed-off-by: Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes for v3:
- usbhost is replace with usbhostgrp on iomux node
Changes for v2:
- collect Fabio r-w-b tag

 arch/arm/boot/dts/imx6dl-mamoj.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index 530cb20ccc86..df8607fe4142 100644
--- a/arch/arm/boot/dts/imx6dl-mamoj.dts
+++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
@@ -134,6 +134,17 @@
 		vin-supply = <&reg_lcd_vgl>;
 	};
 
+	reg_usb_host: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usbhost-vbus";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usbhost>;
+		regulator-min-microvolt = <50000000>;
+		regulator-max-microvolt = <50000000>;
+		gpio = <&gpio6 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_wl18xx_vmmc:  regulator-wl18xx-vmcc {
 		compatible = "regulator-fixed";
 		regulator-name = "vwl1807";
@@ -297,6 +308,16 @@
 	status = "okay";
 };
 
+&usbh1 {
+	vbus-supply = <&reg_usb_host>;
+	status = "okay";
+};
+
+&usbotg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -428,6 +449,12 @@
 		>;
 	};
 
+	pinctrl_usbhost: usbhostgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_A23__GPIO6_IO06		0x4001b0b0
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x17069
-- 
2.17.1

