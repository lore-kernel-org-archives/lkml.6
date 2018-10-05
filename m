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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC1DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF5A208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRCwwYQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF5A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeJFE6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:58:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38722 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJFE6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:58:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id g89-v6so10354103lfl.5;
        Fri, 05 Oct 2018 14:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmDnrjX/gjdwhWCzYUEQjArXFy+yJckph99391iS1dA=;
        b=GRCwwYQiUW05LsGCiV38M0eXt5iEj15wHEvDqkUX0T8JCQ4nWi5ZIEb3TsQAyoDo+D
         ALO+MdcSzwOEkFk3S6kCC12NWmNvVCLDvFfg3YpMEUOsnFJlnMrY5AMcayRQyQWQGV18
         dKFQH/Ev/Xivko15boisIaCISVNl3Kuh19fCqUKfpwae5KH/NpDh39SXMWSvKJQeLjHJ
         ETeJEo/F0DW9G/vN2SETi7mxkUEVH6SjsF7OpIWqRrTsRgHsLGSa/oxzDcKSdT4qcytl
         06XGFIfjbZ28TuGL2WQldFfhKn0vn4dOmXzq7MMfuHYStG9wX9vRGESoMaDahhfxGYZn
         iDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmDnrjX/gjdwhWCzYUEQjArXFy+yJckph99391iS1dA=;
        b=JF1r6mf9Zb8e3/XVN9UVdWP53k5QC/chO/Pic1+VcuMEr8HuB8YLB0PmBQIfQqkJiY
         7xx4ugKHmgd89ARB+JiE2OyRPtuSrR22oqRhr1sx5XsPtE9HR7f6NXUF7gYXjm+R0Jjo
         Gt8erv+YzSIMbMZGpSftzX8ERQpxpU6Cd7Y+Nj1LKYjRhUJ4acCtwqv8SGkuoGrC9MGM
         K8MPVYNuxV5xIjBaHoER6i2xrj4BSvz/lPGVcqMIQpoiaXY0Vb6ubZXpSRSb0oIehSqP
         5eaxKLM6CFlu6ZrbNedyuAQSpo6lHnmx/ZEnlplnbQSxvpHGTCWTwdIAIDTSVlzd6GYW
         jT1Q==
X-Gm-Message-State: ABuFfoj1fRepxWWDv5ihcXoSTQPH2GRPpUK8XNN2WlI9G3sZf09bT7Zg
        53ggSiPc+cR5M9IQ/jfxPRU=
X-Google-Smtp-Source: ACcGV608khgOm58VPLY9QgbbRnbx1ZzyyVyoaUVuL8vjTGngXTxQi6qtaVHm/tK+oz2HiHaXWdDprQ==
X-Received: by 2002:a19:1b14:: with SMTP id b20-v6mr7466793lfb.12.1538776675198;
        Fri, 05 Oct 2018 14:57:55 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id j73-v6sm2059853lfg.16.2018.10.05.14.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 14:57:53 -0700 (PDT)
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
Subject: [PATCH v9 1/3] [media] imx214: device tree binding
Date:   Fri,  5 Oct 2018 23:57:50 +0200
Message-Id: <20181005215750.6047-1-ricardo.ribalda@gmail.com>
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
Changelog from v8:

Rob Herring:
-rename file
-Move address to reg
-rename name on example
-Patch author

Sakari Ailus:
-should->shall

 .../bindings/media/i2c/sony,imx214.txt        | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx214.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt b/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
new file mode 100644
index 000000000000..2744773070c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx214.txt
@@ -0,0 +1,53 @@
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
+- clock-names:  Shall be "xclk".
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
+		clock-names = "xclk";
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

