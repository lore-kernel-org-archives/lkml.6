Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B7FC282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01592077B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EDuX1bOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfBAJtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:49:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43469 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbfBAJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:48:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so6304701wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88EGuRhmZ5Mi0OmBRzcZ/azoI1Z+qLZaZYAJ4dxXFVk=;
        b=EDuX1bOsg9LHvn5fwa77omyicg9yciloYvu9RBq33tcJ4hn9D5lLRKL6l3FXMvXTdu
         PeQVzf5icSdMrdji9xHulYgGk3J5tAWCb/aSTf/nhRHL6cT8rPnEfIcc533F095fwRup
         WQsy1UWJShSodmDMbWT2FlQ0d1NtrpMT/4iWqQ7GgqUr4mEY32zULgyvC5SBaXL4bJEp
         1ly10wRISuFC4RYSbBIf82YUWSdh2JzR5toO/bMQcwlwIKGswWPgfYNw1bD0qtXTVUdq
         P8t+RpZZEDbuHBoK8bpI6pzWyMmG7DeM/0C/XwORJBtNknCcFaG5pqdjFLIal6h+Pmz4
         6G0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88EGuRhmZ5Mi0OmBRzcZ/azoI1Z+qLZaZYAJ4dxXFVk=;
        b=tXOW0HDLHM94/3zgG8OX8Apwbi0x4OgpE58dQ8ONvzd3N8FsLUuvA9GwLaWgOj5rLl
         MjzjAOHpWwJN8L31Tp4O7Yxfm+XGN98of1jZuyZe0tLqJfVUH4UQcgNRNiWEVnSAF+A7
         G+ZaMkpQazdXb/wZYOw8B5+uXXiZr+JvttiYG2tbkmOW8GLKI4cTDU6zvkTS2SAgkxq6
         qPD8dVG9YyqW7hbbP6ZTNKNQtocBo935+HNkAKVkcmlOR4HdeEqtSL3RAHFEWARGJ7NV
         QcosXBGj7ADc1BGe9TQinzfoTEHL3OiZcQ9hA0bgM+7QI/95yaKgt8+xj/y4WKqsPEZX
         YQYw==
X-Gm-Message-State: AJcUukeZVn+ed2Uf8ECVVtivBHoU1tlHebWM1ZMjIWNJcO8vVTF4uAy3
        t3z5RaBvYBcUA0XFhX4o3J3xwg==
X-Google-Smtp-Source: ALg8bN5ekp087E9MNEbp1xUNwLJNosQ7/74EKiedZCjQnrEqpRi74F9gzqWnm9WR4QOa+sRn3QITFA==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr38788041wrs.272.1549014484670;
        Fri, 01 Feb 2019 01:48:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m15sm9648970wrr.95.2019.02.01.01.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 01:48:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date:   Fri,  1 Feb 2019 10:47:27 +0100
Message-Id: <20190201094736.32057-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201094736.32057-1-brgl@bgdev.pl>
References: <20190201094736.32057-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add the DT binding document for the battery charger module of max77650.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/max77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
new file mode 100644
index 000000000000..f3e00d41e299
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.txt
@@ -0,0 +1,27 @@
+Battery charger driver for MAX77650 PMIC from Maxim Integrated.
+
+This module is part of the MAX77650 MFD device. For more details
+see Documentation/devicetree/bindings/mfd/max77650.txt.
+
+The charger is represented as a sub-node of the PMIC node on the device tree.
+
+Required properties:
+--------------------
+- compatible:		Must be "maxim,max77650-charger"
+
+Optional properties:
+--------------------
+- maxim,vchgin-min:	Minimum CHGIN regulation voltage (in microvolts). Must be
+			one of: 4000000, 4100000, 4200000, 4300000, 4400000,
+			4500000, 4600000, 4700000.
+- maxim,ichgin-lim:	CHGIN input current limit (in microamps). Must be one of:
+			95000, 190000, 285000, 380000, 475000.
+
+Example:
+--------
+
+	charger {
+		compatible = "maxim,max77650-charger";
+		maxim,vchgin-min = <4200000>;
+		maxim,ichgin-lim = <285000>;
+	};
-- 
2.20.1

