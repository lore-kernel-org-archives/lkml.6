Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C04C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FFE222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C0GBbedA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfBLUlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:41:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45439 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfBLUlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:41:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so3623pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZYLpQnar+GXFmKBtNq35ipxEjtJaEiSxX3LPIoCRWQ=;
        b=C0GBbedAP+2iTd7TIHz45QyXNTa1Pks65yPnIfolB0daamCfvwdSKL66yWX2BWV+bO
         FXkzO3ig6vY31nfrIjlEyVa78YiGzsGYA4Ulianp9swOUXda/Kj3nwWbqi9jqXJW6CN+
         zUxGs3XTbNji/kEMcN2DpLLB9DN3Z20SBHxb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZYLpQnar+GXFmKBtNq35ipxEjtJaEiSxX3LPIoCRWQ=;
        b=jqlfxIqABJyVWyqh0bf5IsC3shGNiKyGTe1uweYsSiV7FBYMy47cJ4vF8SKJwwieNp
         ZiCKTrRXNwGCO0gs82HmnGkpZAe71M8Hdj+kkwYPpTTYvLKUgcl+tbPi13Ke0ozon/1K
         90zLNPrOiY7JfyogBrrp5yz9u4guIZAHI3Kp8eXG1Ox1VRxoJLYX6efJbWeC5AsubMjE
         iYEtga1X6PDhxtPdH7jWsy5qu6+yZXHDLV+FVLAv3PMP2hIiveZI29F1FYg0/mlDxxJ1
         ULnQdUhJW5oOp+RyMdYoegRcjEBKBguUcjbPiLOUF1m/kNWqCmHYUz46VNBX6JuWNZty
         oC5w==
X-Gm-Message-State: AHQUAua3BuYqupQAvmUlJP5VIqt2HsARlT/MYVvrrgiGxHLmsYY+/SDz
        NcKTLQVr+uMtjNlKI27kRrATfSJnUrilhw==
X-Google-Smtp-Source: AHgI3IZ3xoCRL9qs4bvCseMispcvdaAbovpdgFeZEpP/anWP1YzuY6wnu6dKYQ+6cpPKIFGT0hDOGQ==
X-Received: by 2002:a63:df09:: with SMTP id u9mr5271299pgg.299.1550004081838;
        Tue, 12 Feb 2019 12:41:21 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id e24sm19892031pfi.153.2019.02.12.12.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:41:21 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 1/2] dt-bindings: panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
Date:   Wed, 13 Feb 2019 02:11:08 +0530
Message-Id: <20190212204109.3528-1-jagan@amarulasolutions.com>
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
Changes for v7, v6, v5, v4, v3:
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

