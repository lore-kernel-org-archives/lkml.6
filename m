Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B39C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF0E20856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="l+d6r+Pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAXVvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:51:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39083 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfAXVvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:51:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so3681157pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 13:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BsuHOYMTpNiCNnaJqQexc0U4WUKTEPzRuKVmD6VzD8=;
        b=l+d6r+PuUwA8KwnqS3c36Vkf/aqBAXeKUqZNv2E3Kt9JHT8NedTL+78y60w+zkZEj8
         SsYUdbfnp1/FdWVAZGSFhnFKRiYLSfBPg7ChZnq0J//iRgw2mgLJKk6wb5b3H1wR3UdY
         wjWFQWKda9TNOftc9+traC+T/BSPBjrRC8U1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BsuHOYMTpNiCNnaJqQexc0U4WUKTEPzRuKVmD6VzD8=;
        b=hECQpo0l3CdjtTZJSuc3ei71ft6zIiEErEMd0+tpZwlQq2mja0pIcX2h/cwBKNmGBI
         NOcc0u/l72LucA65qUCRHoVL+IRWIQLgYG0RJVsFX6SGMtPs4tkCpAeNXolew3w/hw9B
         F6ts7PSJljC8CXAPXJaLqUodho8WPBG819IuvYYbOFOlY8zmxUFju7A5V/xHNFF/hY79
         gloRYv75+Q9RTl8CmMjFgAg4Q8uhHZ5IRhw2eL4YRY5SThNZ+ilzPJCqvdfoKj1dYyFv
         VfBtCM0eiFIVXsgU4HKlsBFu2VH0GLErLh5CAnn689r6BD36le/kfy5IRGppdZnyXlIx
         b9AA==
X-Gm-Message-State: AJcUukcfHpOxKRbf4ibGcXZqb7g52jYcWegPg2fL8vpvZ6Ux3UZjt9gn
        rtcsOITXRhUmumAz2EPeZtpabg==
X-Google-Smtp-Source: ALg8bN5HeJQqvRCc1TLJPLJdKiIXd6450HzwCPYMN63iqSzy+O8HiRwB3w6k+Z3xHz4IMEMKEgZ+CA==
X-Received: by 2002:a63:ac46:: with SMTP id z6mr7470338pgn.162.1548366703796;
        Thu, 24 Jan 2019 13:51:43 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id e16sm28536067pfn.46.2019.01.24.13.51.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:51:43 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v9 1/2] dt-bindings: panel: Add Sitronix ST7701 panel documentation
Date:   Fri, 25 Jan 2019 03:21:30 +0530
Message-Id: <20190124215131.17452-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI LCD panel
with inbuilt ST7701 chip.

The default regulator names in ST7701 chip is renamed in Techstar TS8550B
so, add specific binding names for them.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v8, v9:
- none
Changes for v7:
- collect Rob Ack
Changes for v6:
- none

 .../display/panel/sitronix,st7701.txt         | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
new file mode 100644
index 000000000000..ccd17597f1f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
@@ -0,0 +1,30 @@
+Sitronix ST7701 based LCD panels
+
+ST7701 designed for small and medium sizes of TFT LCD display, is
+capable of supporting up to 480RGBX864 in resolution. It provides
+several system interfaces like MIPI/RGB/SPI.
+
+Techstar TS8550B is 480x854, 2-lane MIPI DSI LCD panel which has
+inbuilt ST7701 chip.
+
+Required properties:
+- compatible: must be "sitronix,st7701" and one of
+  * "techstar,ts8550b"
+- reset-gpios: a GPIO phandle for the reset pin
+
+Required properties for techstar,ts8550b:
+- reg: DSI virtual channel used by that screen
+- VCC-supply: analog regulator for MIPI circuit
+- IOVCC-supply: I/O system regulator
+
+Optional properties:
+- backlight: phandle for the backlight control.
+
+panel@0 {
+	compatible = "techstar,ts8550b", "sitronix,st7701";
+	reg = <0>;
+	VCC-supply = <&reg_dldo2>;
+	IOVCC-supply = <&reg_dldo2>;
+	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+	backlight = <&backlight>;
+};
-- 
2.18.0.321.gffc6fa0e3

