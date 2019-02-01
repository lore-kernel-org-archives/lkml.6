Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A7EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBB320870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="yoRlWuOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfBAJtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:49:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54185 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbfBAJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:48:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so5395312wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 01:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LcpQpQ3AxfWeWSRUFYkA1wobTem0k2VnDhGHRGUQrIk=;
        b=yoRlWuOU3A/z1vvFquellN+LlghCapuFP62X9YL5RndtvfHYwQFbsmqQWTkEV4vphP
         vKJa+nYkGfIHY2aeqLHSwFgBBmjiEfS3Ct9ZgDriLHboIjNiI/jW1mVWm9LrTzmGkkLB
         4D9ZkZtihun59dvputpHXEySgjeVsUyjk2OTb9GPhzz+HCSEeowAGP4DwGG64OPg++0r
         2vg47gmmXJBe1Q2ijNu7f7eqpmYxkBMRcKCfWOzPEfEzt7h3yZo6ToWTU/IAIjLZwNv5
         O533A4puDqZqIyzAyUtHby/poarkRI50/MyXxznXVJIRnal7f1nlksvj77sGGtpYaYRQ
         J/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LcpQpQ3AxfWeWSRUFYkA1wobTem0k2VnDhGHRGUQrIk=;
        b=uIMJ2dGIRC7VkMhCueScyjb0uHnvESNLwSylZJrIT0woo9bGe3RHyA1Ij4s+hCRsUj
         yp6MG89GB197oLFESn9zhLUimOzevmHTjF9LlgAAgbPmlnPI5bYH02bbCtR46Ay+VFnB
         SN7+ot3O/5Yw/1j62k3WdATtRpOCx5o2juukOMfDratn80xUeKGr22+IDz9/uCCbU8lZ
         lsO9f/AEQxIxkXD5I0/8TcMEON0UPTivmBbmxA+9adzlR+t7HKu886Tr/+LE8ersxbVy
         fJLl+IXjZxotLr9FViz2p6W9s66BdnqfYtgWPpkfSZgfcD1KCtZVy55XnsWShgfq2L8v
         76qQ==
X-Gm-Message-State: AHQUAuYD88YNKsuNi44kX3tFQgDjPNHda4btFLmzsoz82EpoLXWwFqMN
        46G6LFTP/dHD1WXFZoxDScbM8w==
X-Google-Smtp-Source: AHgI3IZzue2RL5uO2/F9Vz2Ss40sUtjrmvQPaZcb9ndDUmYOKDMzCpd/IeDnyElQcSBUDjVWJ43qpQ==
X-Received: by 2002:a7b:c757:: with SMTP id w23mr1530622wmk.59.1549014483311;
        Fri, 01 Feb 2019 01:48:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id m15sm9648970wrr.95.2019.02.01.01.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 01:48:02 -0800 (PST)
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
Subject: [PATCH v3 01/11] dt-bindings: mfd: add DT bindings for max77650
Date:   Fri,  1 Feb 2019 10:47:26 +0100
Message-Id: <20190201094736.32057-2-brgl@bgdev.pl>
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

Add a DT binding document for max77650 ultra-low power PMIC. This
describes the core mfd device.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/mfd/max77650.txt      | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt

diff --git a/Documentation/devicetree/bindings/mfd/max77650.txt b/Documentation/devicetree/bindings/mfd/max77650.txt
new file mode 100644
index 000000000000..84631d3b1e14
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max77650.txt
@@ -0,0 +1,28 @@
+MAX77650 ultra low-power PMIC from Maxim Integrated.
+
+Required properties:
+-------------------
+- compatible:		Must be "maxim,max77650"
+- reg:			I2C device address.
+- interrupts:		The interrupt on the parent the controller is
+			connected to.
+- interrupt-parent:	phandle of the parent interrupt controller.
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells:	Must be <2>.
+
+For device-tree bindings of sub-modules (regulator, power supply, GPIO, LEDs
+and onkey) refer to the binding documents under the respective sub-system
+directories.
+
+Example:
+--------
+
+	pmic: max77650@48 {
+		compatible = "maxim,max77650";
+		reg = <0x48>;
+
+		interrupt-controller;
+		interrupt-parent = <&gpio2>;
+		#interrupt-cells = <2>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+	};
-- 
2.20.1

