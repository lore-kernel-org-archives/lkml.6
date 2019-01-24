Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3A5C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54E9218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="axhb3Xfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfAXSnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:43:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35351 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfAXSnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:43:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so3043859pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 10:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PsduUDpmPIWCDIJ7caKYTueqgTQjbOMBWrOANFC1P64=;
        b=axhb3XfpdsvlSINEhALLiMQln2W+Ht5nqL0Pp/JqOlqaX0Nos7RY/EdybJ0mAyoSkI
         54JpRPuY9WMyKVPDQbcvoAdphPzijG4a+fsAZA5jNTNJAVuPQ+nZeuNc+RrB77Cm87QW
         rwv++DoT9/VtlANNbaf6YMv00oezR6m97v4dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PsduUDpmPIWCDIJ7caKYTueqgTQjbOMBWrOANFC1P64=;
        b=rarD/S0DjrYEYf7OvncTY/DeJ7XvXfq/l1I+JXs/D+qEDONMv8Hz/r8//EZfCMdm0y
         xd2HqSr8RU9GKk66OgvbiITRHC7x//noewbU4yJ/MHmPoN6cDRs6edc+hOK5gesH9a33
         hiIxDMUavpTAKS38gD+YnbUlJDt7QeWnBmXHKUYRPey/QIuwEnp7OSJ3Py7r3qh2V3qA
         A8hV/Q/KzNWc7XVZiaWIfhH6todhjS2fLSVwr/Wtg5sLD7iy8CITNGwXeDligKEF+ypK
         TLrYATKFdqgRlQol7BNb9Rasg3kvWbNPyMI3yZjj+GaQKM0c2NHkDnAbzTjzah45C7Cx
         kYeQ==
X-Gm-Message-State: AJcUukeItaGAkzT+HSszHaF0fW21m3aAR41Hfuzy9K7unGo8n3RxA/4L
        Nn7tKQPG+N9senrBv65ikRJCRw==
X-Google-Smtp-Source: ALg8bN5rP4AA7rls1kJJB2GdGzZTtv9x24J5Av3ADSGGf8Up6Z791638LbzMntytVnCz4m38ifslqA==
X-Received: by 2002:a63:8f45:: with SMTP id r5mr6921843pgn.222.1548355421617;
        Thu, 24 Jan 2019 10:43:41 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id p2sm28404907pfb.28.2019.01.24.10.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:43:40 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 1/2] dt-bindings: panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
Date:   Fri, 25 Jan 2019 00:13:12 +0530
Message-Id: <20190124184313.30193-1-jagan@amarulasolutions.com>
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
Changes for v4, v3:
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

