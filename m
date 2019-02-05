Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17607C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA90320821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TM8tRpwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfBEJNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:13:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34398 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfBEJMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:12:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so692417wrn.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 01:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFkhmaEQUzdaTJR4lhnbhp1irRv/17xUnhxf+z/b5Fo=;
        b=TM8tRpwXr30E+mibHDlAU2noGJNHfIxefjH/b9z0ZalxBmh1tXogU0WnFYWhcN1Grh
         FKR+SGoFTvjbq5jCkPIg78b1QHRwZV+J1Gcr4iLkkUyIHIKzywBQpE46YTFtBDKvSCof
         7AoM30ZxMumKWUFtZsJk9jf/I2nU8fjVDrqjLN56ZKiaS3w2tDo6+LKEs9LVve0fZHui
         jyeXmJly5aTgc6qvhwfzF8v1YMO+LBPUfs43awgo6OGjRu2tYCZhspsfLiM6b3cbA9hh
         GdCUUv0we0s5RuRHL0lCT84ou0bc1WD8nprzibO1+ipL1hbvs70tkxpBXjzxX73/KVOO
         FGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFkhmaEQUzdaTJR4lhnbhp1irRv/17xUnhxf+z/b5Fo=;
        b=D2q9ij043CxO0+zjwAiaLaWeKP4MYydv5U72Q033CsPs5hrhLIyBmuwMArj/YpC5/z
         8gRIi7FDAPfxbHzTfLz50eLw7jCblb+hh4KWZJ7b8evEWk9NJeaLPr9j4FFqqi9ekD4N
         9WnMNa48cfnsTZoTSQ1qHqu7VUOjYWCKQuPXfkScy8KHUfxhNfUO7g5GyEJmKnN39KbO
         0aibnKZWv8RTqG5s5nUmZVA08xuPDgMxXgA4OYoxUdACIoW4JbL8oFBsIt6Ra+FlN29x
         7ZW0/w3fte0Agx6EucReftTwQxrfXstQuyFtJnSjCNNd2wlzPwcKu8d56RXWouVxX9x6
         kGTA==
X-Gm-Message-State: AHQUAuZSGlFdBy7RdaY/t3R7cI42pPea3TTK1LjauuP/+5qbSLanPGvl
        9wO60/PreeoZqzwcYwN5y7ALgg==
X-Google-Smtp-Source: AHgI3IYmUfs4Orz2ilgeyyBW61oe8BMNwn/tArgwGijF6x5dK/Cdj7MRLaSeZq5SceSGlyu4dZSgOA==
X-Received: by 2002:a5d:6549:: with SMTP id z9mr2680750wrv.116.1549357967925;
        Tue, 05 Feb 2019 01:12:47 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s5sm10433657wmh.37.2019.02.05.01.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 01:12:47 -0800 (PST)
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
Subject: [PATCH v4 03/10] dt-bindings: leds: add DT bindings for max77650
Date:   Tue,  5 Feb 2019 10:12:30 +0100
Message-Id: <20190205091237.6448-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205091237.6448-1-brgl@bgdev.pl>
References: <20190205091237.6448-1-brgl@bgdev.pl>
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
index 000000000000..3a67115cc1da
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
+		compatible = "maxim,max77650-led";
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

