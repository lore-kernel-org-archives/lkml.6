Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B2FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED08208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9nOauIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED08208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbeJFFUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:20:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38678 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJFFUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:20:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id g89-v6so10381293lfl.5;
        Fri, 05 Oct 2018 15:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LIDui9YIXhN5h3E+UV/Mh7/0QNNu9LzWjR3GXQ4amo=;
        b=T9nOauIxjoK+qkqFpq5e0MPo4DZU9/XaH8dAZaLpZUGCxxG7jqA0+7YI4KLUq2lbta
         jGvZl4o8jU9Et/do/UXEJ01dUiomzzOHuIqZN1edSkzm8K14zHMFeD6ibWAs1U/deqGz
         Q3YE9Cij2BkDFhrwPsgTMQyYqNjEO4nYyVpzU8A8zwYkH/IDVIi+44DbORILRh4OfeI7
         Ms05R9OI+plLcJqyP8t/bOrgr2Ke9qyRkpKisRSgtEMyExEORbgL35CpMFll2j3A0Ho0
         glRdAxyN/3jNnirA0TzxVMI/Ry0k2fSz/3ZdTWUp7/WBnw6mVIK4yAnYfYv9Wss7Hcfv
         w1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LIDui9YIXhN5h3E+UV/Mh7/0QNNu9LzWjR3GXQ4amo=;
        b=mqKh0ir6164Leu12MCdidS9eQoY5+5h7JlKqBKkeE6SnYY20ZYaR86arz9oqZF5ztb
         xvAm0AQDpKDi0vNXQ082UBYc+MXY0jQH28Y800EurqCnRSrKRnd00jctJVfjMUdnOYcb
         yxh4pI6f6Ehd+8xm87Vq8JWl2WieGPnr+/zDJVzxTZlSv7cgUCPNpW7qT1E1ZyWHkpB2
         l+8nqhgGGASK/d7ceiSRLuT12XL8MXHVQbTsAxJEQdg1qhTVAfiAZzoQO/gpQ89Owp+g
         ygadS+ulsubYw/kYWz+Ae59Mmga6wAnl2f/mjaFQDOqeM4zT3/sURp6JUwFjMZiR24eY
         73nA==
X-Gm-Message-State: ABuFfojVqhU7eO5bJ6uwnM5tLSP1wf54PiFSvt7BDcLu3e1qPX/qPM+y
        VTYRKK8jrZDLK/S5ue+TYWU=
X-Google-Smtp-Source: ACcGV63Pbm4A961hYZR0FQKlFE3aH9IiSOM+dZIN4S/U0f3JPBwPtV1i11lenYcwH+kPA12HN5pRlQ==
X-Received: by 2002:a19:428f:: with SMTP id p137-v6mr8122215lfa.2.1538777969708;
        Fri, 05 Oct 2018 15:19:29 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h71-v6sm2061222lfi.11.2018.10.05.15.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 15:19:28 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v10 1/3] [media] imx214: device tree binding
Date:   Sat,  6 Oct 2018 00:19:26 +0200
Message-Id: <20181005221926.8939-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for imx214 camera sensor

Cc: devicetree@vger.kernel.org
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
Changelog from v10:

Sakari Ailus:
-remove clock name

 .../bindings/media/i2c/sony,imx214.txt        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx214.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt b/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
new file mode 100644
index 000000000000..8739ec871fb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
@@ -0,0 +1,51 @@
+* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
+
+The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor with
+an active array size of 4224H x 3200V. It is programmable through an I2C
+interface.
+Image data is sent through MIPI CSI-2, through 2 or 4 lanes at a maximum
+throughput of 1.2Gbps/lane.
+
+
+Required Properties:
+- compatible: Shall be "sony,imx214".
+- reg: I2C bus address of the device. Depending on how the sensor is wired,
+       it shall be <0x10> or <0x1a>;
+- enable-gpios: GPIO descriptor for the enable pin.
+- vdddo-supply: Chip digital IO regulator (1.8V).
+- vdda-supply: Chip analog regulator (2.7V).
+- vddd-supply: Chip digital core regulator (1.12V).
+- clocks: Reference to the xclk clock.
+
+Optional Properties:
+- flash-leds: See ../video-interfaces.txt
+- lens-focus: See ../video-interfaces.txt
+
+The imx214 device node shall contain one 'port' child node with
+an 'endpoint' subnode. For further reading on port node refer to
+Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Required Properties on endpoint:
+- data-lanes: check ../video-interfaces.txt
+- link-frequencies: check ../video-interfaces.txt
+- remote-endpoint: check ../video-interfaces.txt
+
+Example:
+
+	camera-sensor@1a {
+		compatible = "sony,imx214";
+		reg = <0x1a>;
+		vdddo-supply = <&pm8994_lvs1>;
+		vddd-supply = <&camera_vddd_1v12>;
+		vdda-supply = <&pm8994_l17>;
+		lens-focus = <&ad5820>;
+		enable-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
+		clocks = <&mmcc CAMSS_MCLK0_CLK>;
+		port {
+			imx214_ep: endpoint {
+				data-lanes = <1 2 3 4>;
+				link-frequencies = /bits/ 64 <480000000>;
+				remote-endpoint = <&csiphy0_ep>;
+			};
+		};
+	};
-- 
2.19.0

