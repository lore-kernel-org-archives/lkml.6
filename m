Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC79C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4920621473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="1Pmxr66h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfA2NhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:37:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38600 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbfA2NgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:36:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so22054764wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MNYYvvkKBIEcw9pDAq0Wchh7avl/bPzon5t/F6CHSo4=;
        b=1Pmxr66hGhnJ5XQGuDAOcnp0GYwwA43rb6lrGDda8C/fdu6gP8xsv8mWWabJ9DMy4M
         7vVD9BlwDAFhuEMYyJmrl04b7MHcB1wi8TRIpti/pN7UoVEJO0jtDLBcnziTZ9I5LRRE
         JNH5ZqvSsOoP1TIXo5dq8MmUdEtyTCKd/jHYIz+8LDmsttm9aiZ+XaSyrSDIW2pSdja0
         kQep5Fzt2+y94Bi0Yo8KKEpnEMllHa9uoGKjazG+laU0v+FlBqqHd0h3NDbrCmt3bmsL
         KWDTr50yDs4de5CXcerTVZdEECiqTSp9MLqCxAJ21slMe8ANDiCRVZ8xIpT+EQLPQjA0
         zr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNYYvvkKBIEcw9pDAq0Wchh7avl/bPzon5t/F6CHSo4=;
        b=TJI3zojwmnD+oc4IdMAU79hP1UE7up72GGLWOhhbQfynQOm/sjAeJjSU9Pz1jMYtBO
         PWXmibaHeoHBRkygkbKnFsK4jdd8cIIRV2HEQzzr6dPJIYUteUkfA7nkLHcvuAI7s+F8
         qCK8EhEjniqWeP3jAeig1NEOJWsPanOv1wUEgrWHmXocXRWMw7E9RM/2L/6SAD3FKldi
         52+mQMVh6s6UAGoOo6ojJ3L49eMtBXH2bJoLH5OAVuAd181AJ9AaOeTIvy9HH4l9sFjM
         RB7mhCSgb6W61/DxghviRaoJpwUTnSXMJnz0emF6ExQ6HTaEUF6c4TYnl13yY7s58lHI
         Izdw==
X-Gm-Message-State: AJcUukf/0/1ugrkkKRc4iCb/kB3Fx6dxvPEonsIv6R58tKA1Pa7lCqkU
        dzvdbMV2tOy2ng5/X8jvk+9gIw==
X-Google-Smtp-Source: ALg8bN5uUL4UK02JAsMM6og0jTe2ZheL+ocSQDmPJa9+Xwr6V34GQbyau+j5v8Q0xAyQ1DX1qhwfmA==
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr26512444wrx.146.1548768959338;
        Tue, 29 Jan 2019 05:35:59 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k128sm4367891wmd.37.2019.01.29.05.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:35:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 05/13] dt-bindings: leds: add DT bindings for max77650
Date:   Tue, 29 Jan 2019 14:35:37 +0100
Message-Id: <20190129133545.1931-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129133545.1931-1-brgl@bgdev.pl>
References: <20190129133545.1931-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the LEDs module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../bindings/leds/leds-max77650.txt           | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt

diff --git a/Documentation/devicetree/bindings/leds/leds-max77650.txt b/Documentation/devicetree/bindings/leds/leds-max77650.txt
new file mode 100644
index 000000000000..b2fac8e719a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-max77650.txt
@@ -0,0 +1,57 @@
+LED driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The LED controller is represented as a sub-node of the PMIC node on
+the device tree.
+
+This device has three current sinks.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-led"
+- #address-cells:	Must be <1>.
+- #size-cells:		Must be <0>.
+
+Each LED is represented as a sub-node of the LED-controller node. Up to
+three sub-nodes can be defined.
+
+Required properties of the sub-node:
+------------------------------------
+
+- reg:			Must be <0>, <1> or <2>.
+
+Optional properties of the sub-node:
+------------------------------------
+
+- label:		See Documentation/devicetree/bindings/leds/common.txt
+- linux,default-trigger: See Documentation/devicetree/bindings/leds/common.txt
+
+For more details, please refer to the generic GPIO DT binding document
+<devicetree/bindings/gpio/gpio.txt>.
+
+Example:
+--------
+
+	leds {
+		compatible = "maxim,max77650-leds";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			label = "blue:usr0";
+		};
+
+		led@1 {
+			reg = <1>;
+			label = "red:usr1";
+			linux,default-trigger = "heartbeat";
+		};
+
+		led@2 {
+			reg = <2>;
+			label = "green:usr2";
+		};
+	};
-- 
2.20.1

