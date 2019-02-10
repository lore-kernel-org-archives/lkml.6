Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29831C282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAE62145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqhRcuCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfBJUjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:39:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36140 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJUjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:39:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so4020262pgm.3;
        Sun, 10 Feb 2019 12:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnnxHwkDJFIYf3W9dWpRpBGaF42LRM0p/MCcNDxRd+E=;
        b=YqhRcuCPy8J4btNLqf9iF75fpCfisCpYdLcrdjMvjojj/JK7v7zG6kQYkO/j+hManU
         p56zdFBWzQ1L3b8LQGgsOmu9kw3vHApzTWHcs7WRu1yKD1cVT7emycoR8A+CauRH+6My
         rRNi4CfXs0n4UekDcy+0zH3UWj9NiDPm4eUVnKsWMVbcoTdsjxzVf3Qs1jVrGcbSh3Mm
         bKAj+r+fbPByUKrg/afs/+9zx85z0HE0Sclxn44aYlBCkCdQJsuTdruqvmgwuGIOzpgS
         L5AppYeSvEbnMrIFUk1gEJtSeZhC/gHPkSp/dEG4jPypq0qBYH3JtzKJAEwdXpkEeAH0
         lw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KnnxHwkDJFIYf3W9dWpRpBGaF42LRM0p/MCcNDxRd+E=;
        b=hsncBIjfXT9LTo+XTn1FQgvyYsIIF93ooyzonJxmGoMrbpbUzcFo+41A5G2mw4pPAG
         2+/i+dME4aEEeT1oZOZZ2a9xDwMk6ApN1bbn/TZFV87dPL+hzT5VuE2YZ62BCd+mZFv6
         sT5848Fst+hOrqVGVa35v1Oyz3d3wBP/+f4wbc89ewAxnUEcLkIQjTgsiRHJF7eWOPJx
         mLckr8SxU7vrshkDwX3Vy0CmTTurD9SKDBIkde9JubX0TnFveosM52QiobEL40ZjXkVG
         JJgcFXhGaiVMyHkQrDHROPWduJpPPMZW0Wa7FcAYG6H/h/r0EGEeG8OeBKIjNe220UTM
         UnMQ==
X-Gm-Message-State: AHQUAuboz5yuOXoMAgsZZIVpgVg6DMBgnNVbtkCorxGUaoVlhdpjH0ml
        hBGpsrtxU+eSJl1oKAGoJY8=
X-Google-Smtp-Source: AHgI3IYhvbbTjH/RIBSP/hFvGCRjaWNDGG942Qv93NhYc/xN3d4Al82g692OZzsToIJOKrcSw7sy0A==
X-Received: by 2002:a63:eb41:: with SMTP id b1mr30659252pgk.188.1549831185392;
        Sun, 10 Feb 2019 12:39:45 -0800 (PST)
Received: from bobby.hsd1.or.comcast.net ([2601:1c0:5501:37e2::8c])
        by smtp.googlemail.com with ESMTPSA id b24sm12188843pfe.136.2019.02.10.12.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 12:39:44 -0800 (PST)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: iio: light: Add ap3216c
Date:   Sun, 10 Feb 2019 12:39:47 -0800
Message-Id: <f689aae31740bac50a4993ee51d837a93691e6f1.1549828313.git.bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device tree bindings for the ap3216c ambient light and proximity
sensor.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 .../devicetree/bindings/iio/light/ap3216c.txt | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/ap3216c.txt

diff --git a/Documentation/devicetree/bindings/iio/light/ap3216c.txt b/Documentation/devicetree/bindings/iio/light/ap3216c.txt
new file mode 100644
index 000000000000..c5ae80c79dd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ap3216c.txt
@@ -0,0 +1,22 @@
+* AP3216C Ambient Light and Proximity Sensor
+
+Required properties:
+  - compatible: should be "liteon,ap3216c"
+  - reg: the I2C address of the sensor (default is <0x1e>)
+
+Optional properties:
+  - interrupts: interrupt mapping for GPIO IRQ. Should be configured with
+    IRQ_TYPE_EDGE_FALLING.
+
+Refer to interrupt-controller/interrupts.txt for generic interrupt client
+node bindings.
+
+Example:
+
+light-sensor@1e {
+	compatible = "liteon,ap3216c";
+	reg = <0x1e>;
+
+	interrupt-parent = <&gpio1>;
+	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
2.20.1

