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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0638C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E8B20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0F2BPXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E8B20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeJETsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:48:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40481 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbeJETsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:48:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id j62-v6so11534948edd.7;
        Fri, 05 Oct 2018 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMiFs80WGL7FYszn8HmB48zmVI6ZztE2YpOlWr6Jwa8=;
        b=b0F2BPXoHo1Tqr5kAzniUlWZWeeMuQjDwQayF4MYGLUD191Zoe3dPqccUW0LpyjWfE
         rkBk8o6haGgjfLIDR+EYKdSCgt+W/U1Wn+OmyUHnTDJVZVnCRhq3KU69Tp+jrLb/DL0o
         M/cWxmgNhSwu6Zi4Mu2q3TRh3scIbGdWRa8aRaLmDBBJolnQv9cephUViWV3nhEDoQ8S
         IwKkTEGn/L9Fp6KxuYpnezkDO/rWANztMSRdh0Grxs4XMDYV6QVO8mi0zVYGbokwurDf
         btakvnzVibqoCAC5RtGW1ei4vkxMpLSFyS4AETyo5TIjemO7iX1LaFr1VapDmTUgNBM8
         rrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PMiFs80WGL7FYszn8HmB48zmVI6ZztE2YpOlWr6Jwa8=;
        b=Q2pxwPwSIIk76AiouZ1g4xXqgei4PDOaIGQSzST0bquiDaKf9r6IL18URQEvrTsa9C
         qHKMJk5tluzrwQPxVjLGu0bGjdr9OaRtrLJzQiZCp41K0/astR+2lfEGWh100C+rocRK
         At1n0gtlycIWZiKU0yKSmKr/DX/TG2rS01BB4VVAbMbd0wIT7UfXX/5BDAmY5mY5UnGS
         r8N/m7AYXe2Y3lsurbIypzYVWvwlg8aQEWifaWts+igmfo/xt6uQcnj3x6o/WMtMMwya
         6Ftj0R6LMP6SpV52hl9RpF+T2VB9nWFp3NfwnIAyTng28vVE6IdHI8IQ9ZdF9BNgpDqX
         /N4w==
X-Gm-Message-State: ABuFfoiNdPx/JRhHp7F8LP2VBbszQrrMtKOh5zFMj4aoaF7BLwrGdTlu
        RODS9TduX7p8bsbYZfYSq2I=
X-Google-Smtp-Source: ACcGV62ah7wk+ZgdnSOm3H7uwwiNnPbzpKGFyk+RqvTao+JY0SVsuAgM9nnffSK/+sfQ2VaDrWUQaA==
X-Received: by 2002:a17:906:1992:: with SMTP id g18-v6mr11158603ejd.166.1538743783005;
        Fri, 05 Oct 2018 05:49:43 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id b14-v6sm2360512edc.17.2018.10.05.05.49.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 05:49:41 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        jacopo@jmondi.org
Cc:     Ricardo Ribalda <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v8 1/3] [media] imx214: device tree binding
Date:   Fri,  5 Oct 2018 14:49:37 +0200
Message-Id: <20181005124940.15539-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Ribalda <ricardo.ribalda@gmail.com>

Document bindings for imx214 camera sensor

Cc: devicetree@vger.kernel.org
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 .../devicetree/bindings/media/i2c/imx214.txt  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx214.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/imx214.txt b/Documentation/devicetree/bindings/media/i2c/imx214.txt
new file mode 100644
index 000000000000..421a019ab7f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/imx214.txt
@@ -0,0 +1,53 @@
+* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
+
+The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor with
+an active array size of 4224H x 3200V. It is programmable through an I2C
+interface. The I2C address can be configured to 0x1a or 0x10, depending on
+how the hardware is wired.
+Image data is sent through MIPI CSI-2, through 2 or 4 lanes at a maximum
+throughput of 1.2Gbps/lane.
+
+
+Required Properties:
+- compatible: value should be "sony,imx214" for imx214 sensor
+- reg: I2C bus address of the device
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
+	camera_rear@1a {
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

