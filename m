Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259A5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D7E206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZT1teP6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbeLNUqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:46:51 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40647 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbeLNUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:46:51 -0500
Received: by mail-yw1-f68.google.com with SMTP id r130so2837478ywg.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 12:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfuIbKfYXLeSMyVQXkpoPXxNgNbgjPxWgbF6UQTE2Kw=;
        b=ZT1teP6O03u0Ot3l3HN5jKVttCwkmQ+L9bMa5U20ydMI/b0Uo0JwWlWl5XsFXYpnH2
         13Mmj2J2P//9CxAF7arUlQK9Mm/cJvFOXNG/2Vnj2TzN6w3Y/QOESYez0pI9xDrcN8zC
         BgY/QxWJf5kmKIG/9VaZTJpa0VS9lIieHky94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YfuIbKfYXLeSMyVQXkpoPXxNgNbgjPxWgbF6UQTE2Kw=;
        b=KsmgPAIUaTHK3bzzHaDtHfgbPmeHhbV22doNmaj+jBmt8R8KJu/26Y5caLHy2O5S8q
         POSMdIWg8BGNpPfOuTJqHJCtR1bsw6CrMddPBNNb2L0OzEqA9UYMjmKUavJLR0xvGof+
         g0meR1KDdcQFu/ISaCh7mylbusNOS96rj1/A0AqKUXxOcjhkZK7NkL3T0yBz3LMfAzLm
         MlB9HO65P3nEJd+Mj4d8jiF4yOgALwKn1BY/3HSpwNKLnd9B7F0iBmt8IY59i0uPojcU
         97sMU1p4L8e4PKe5bY5FvE/pt99lCyP4ExFQFQQBv8mJ7AlCEHVgC6DVcjgF4SnuQln2
         CdTA==
X-Gm-Message-State: AA+aEWazXQ7uE9W5CZgsR7G6PkyfSt7QevWkJz44oVt6BsSjpQTENIPn
        QTZHY5sNYLzlrBRP87hAebjbcw==
X-Google-Smtp-Source: AFSGD/Uq/OzpdjkRSzGl08lTyGphSevUI9HFHNXSPdTeGnnei6VRCHHjW9N541dY7gdtWjxXgt0JQA==
X-Received: by 2002:a0d:dcc5:: with SMTP id f188mr4610569ywe.210.1544820410182;
        Fri, 14 Dec 2018 12:46:50 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it (host211-95-static.0-79-b.business.telecomitalia.it. [79.0.95.211])
        by smtp.gmail.com with ESMTPSA id f10sm3754614ywb.26.2018.12.14.12.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 12:46:49 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 1/2] dt-bindings: panel: Add Sitronix ST7701 panel documentation
Date:   Sat, 15 Dec 2018 02:16:39 +0530
Message-Id: <20181214204640.9789-1-jagan@amarulasolutions.com>
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
---
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

