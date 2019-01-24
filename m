Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C573BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64478218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dsb9rcnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfAXS3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:29:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42612 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAXS3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:29:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so3010489pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9DU8U467Azc8NhODbOHC7Pcr961WNWCYdIkODh9QfjI=;
        b=dsb9rcnJZdAxOzhjs+vV4uqr8LJ9VZ7RYlqvga3k9j8fKlbdTHcAPg6WNCcpolvDYc
         sl+v+XuR/qrfF9hUOwbtVqKTz8Ncc2JQKPTx2zFz3C/zqMRG5xKJDOAcAgBtvlagkJl8
         D86OPYCyujB4ySflRAXoGZFJxQAzcBsgOm+Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9DU8U467Azc8NhODbOHC7Pcr961WNWCYdIkODh9QfjI=;
        b=unxgeuAnZ7soxB4GWJXREh2UhJiiqNw72j1dsYZE0w3SKaV6c4wzBYrhVhuaIc4n9d
         BE54QupWuJHICsp2kQ3++DoFapGWbbeK2g1gFsYU68UbejO26JpBSzbilLgZ96L++nP2
         eAvafTaizkZOqa7+wzUjg2gK0B2BRD5TaK9LUXMy4RND20FaIcwWoof+m1cwgHRNx4ZH
         ITZAGmMag4GfvIhuVM00lgL5PSuQN+brJCLivOKBxa+d+LOJRVGwTS84rZADL5PaJkBl
         QOTw7bvyLjgmuzrzAU80lllhjE2ZIjD8+R85Rg5cWf9fksqvyOWgOz1TCUd4Ml6d34gs
         0b2A==
X-Gm-Message-State: AJcUukfEvH/o8ImI+Jq9MHRBa0Q7uRbERBLGjowUPeDnj9j6q4cC2tx2
        G5epSWasAOO7MpYGMkP26yZHKmEYMVM=
X-Google-Smtp-Source: ALg8bN7yB7JU+BewfKgrsaOJFdksuYngvHh0oJJ+unc6LMu/bzFMxeGQ3KrZirvv8dHE5DH9otbKxA==
X-Received: by 2002:a62:4886:: with SMTP id q6mr7806004pfi.182.1548354545413;
        Thu, 24 Jan 2019 10:29:05 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id d25sm31803995pfe.40.2019.01.24.10.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:29:04 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v8 1/2] dt-bindings: panel: Add Sitronix ST7701 panel documentation
Date:   Thu, 24 Jan 2019 23:58:43 +0530
Message-Id: <20190124182844.28961-1-jagan@amarulasolutions.com>
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
Changes for v8, v7:
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

