Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E11C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B372171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pr+/CdvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfA1Syl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:54:41 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34398 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1Syk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:54:40 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so8163570plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wTpaoqsAZ0JEeKY7R5g5I1i8FW+aQvU2AGbAR2oTbf8=;
        b=pr+/CdvSadslqKLJ5iOUDKSVmo7bQvX6M72tWQcFBsUPTiSijGfsdoVPZ8/+zlBjxB
         5g7TYTZT+PaT/WV6trFot2XNrGf3p6SJZFh8qKzkiLjROWMI29RcMGpjG0mfSJBUxYQs
         rDk6c1gr1Y/4uDtzIRL/mnHo8g6yRHCh5AZ+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wTpaoqsAZ0JEeKY7R5g5I1i8FW+aQvU2AGbAR2oTbf8=;
        b=KR8V3LSE+VPQGqoubeWHC5SDLq5FMQx6VtBcAeXJ6jjn11QkBZKgjX5BjCusFUzmGl
         Pz3eYrZT8zvawEp/hJqUZV97nRwG9ytYOihVUTN4Y/bOxYNiY8L2kQeS55ekQu87ryUZ
         jC8GOAbAWaSkKSdH1eV9yoTz8PwHxAl3YOdP4kC/F8xApQmppqLiYxBQxAuNWcebjW0t
         bZsLUypMv0hv9nS8665oAy9zfb1x0o83P0bdVKChoNhOcRiSklcsccTz4nW7faL/ipDN
         0QY4W/+oE1w/gezGzFT2wd56CrU60KkR1mmdXYpj5d6StshIrHSJ9R2Z06F4YYsL7dYC
         tG5A==
X-Gm-Message-State: AJcUukfb7e/+evjD3qFsAV/6v9q7GvQg3f4Av+vsU/+DZ7OJd+r1Hl2L
        QllAzU+ppkBw4ObdB70uwFJjqg==
X-Google-Smtp-Source: ALg8bN4gHPaO7FXGeznRb9yQyaEbfxeOswNP27K+5/oUgWwwZuD9chhR4iab0FcSJ7T6BRMQpFYfuw==
X-Received: by 2002:a17:902:6683:: with SMTP id e3mr21862322plk.93.1548701679924;
        Mon, 28 Jan 2019 10:54:39 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id r66sm54088441pfk.157.2019.01.28.10.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 10:54:39 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 1/2] dt-bindings: panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
Date:   Tue, 29 Jan 2019 00:24:27 +0530
Message-Id: <20190128185428.25129-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.

Add dt-bingings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v6, v5, v4, v3:
- none
Changes for v2:
- new patch, derived from another dsi series 

 .../display/panel/feiyang,fy07024di26a30d.txt | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt

diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
new file mode 100644
index 000000000000..82caa7b65ae8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
@@ -0,0 +1,20 @@
+Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
+
+Required properties:
+- compatible: must be "feiyang,fy07024di26a30d"
+- reg: DSI virtual channel used by that screen
+- avdd-supply: analog regulator dc1 switch
+- dvdd-supply: 3v3 digital regulator
+- reset-gpios: a GPIO phandle for the reset pin
+
+Optional properties:
+- backlight: phandle for the backlight control.
+
+panel@0 {
+	compatible = "feiyang,fy07024di26a30d";
+	reg = <0>;
+	avdd-supply = <&reg_dc1sw>;
+	dvdd-supply = <&reg_dldo2>;
+	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+	backlight = <&backlight>;
+};
-- 
2.18.0.321.gffc6fa0e3

