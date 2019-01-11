Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E646AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67602133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MSrHH00z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbfAKMrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:47:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37975 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbfAKMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:47:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so6731060plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 04:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8sKZFrSyrlRVsPiFTkxkKzSuO+5QiVQo1X4Ymi+tusc=;
        b=MSrHH00z+11p+0s2BDcOeCZcYEDNhQ7fcKpcr++hIPtfpX12xerWOzSvtJontSo8jo
         B2jGb8dgkX5ofHKlrHghqA+S9rn4EyOabLkC/HFvBNFShVb/cYuMVPNFG/Leoq4t+7LM
         JgROHsrCT2uHMHFRl1liYnDibuhekzLgLv3cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8sKZFrSyrlRVsPiFTkxkKzSuO+5QiVQo1X4Ymi+tusc=;
        b=sys5wh07GDNW5iZ1choEriEb3c9jyaIqXUd36p9uC5Asa2lZD4EbiG5mrsiSbkge8T
         4glSgX1wfLj6KyyFnnP/NMeQFRq4akQnCg6yf8c6FXhTKVCMSjxm21apxFDJ3o2LaKs5
         AxXespNf1WbRheqkh+KTIOFLqAcwz8gkY+Ov8J0ZFgvYI0OTcveZcAyqO0+koFhUOOhP
         2icPQOAjqe0NyjUk78FqGB4DdYpkD19I19KcTgkvqBV5j9nRr925Iq4KnHHv/6gPFr8q
         FJ6nbRTDH0ViD9rk0GhFl9zK2z9ORQCPBVfZxA0xrg9+CyNoeizAiuAtGzyQWt3lW688
         L7SQ==
X-Gm-Message-State: AJcUukcilokfsetGHh3eUhND3XzTwb77gaNyHHdUReP+xQd+1sbT89lv
        90N83mMu3Dfi4lUO5w2fyKqFfA==
X-Google-Smtp-Source: ALg8bN6dLlkpvGflRqD3JPm+4pB0/DNjedE1S8YdB3XafF3ngkBzxbgiDyuvabHewjPH7TeqvMkxgQ==
X-Received: by 2002:a17:902:ab92:: with SMTP id f18mr14017276plr.221.1547210850748;
        Fri, 11 Jan 2019 04:47:30 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.55])
        by smtp.gmail.com with ESMTPSA id m19sm247359326pgn.35.2019.01.11.04.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 04:47:30 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH V7 1/2] dt-bindings: panel: Add Sitronix ST7701 panel documentation
Date:   Fri, 11 Jan 2019 18:17:13 +0530
Message-Id: <20190111124714.19566-1-jagan@amarulasolutions.com>
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

