Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40560ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF3721523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZz6/k8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF3721523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbeIUOms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:42:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45620 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388944AbeIUOms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:42:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id x16-v6so4497176ljd.12;
        Fri, 21 Sep 2018 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+xp1tHYgcqmK5vJcXbbULWl6T/5gevxAd+xabl7FRRA=;
        b=PZz6/k8EHKQddAoASSy5hz4AU3w9z0L6clELGKkJX2Kk5RbgEdoytQuAqBDUa5ALwF
         Fy4312KVqi3CuzDNwUdBESsJQ8EA4kBCUKoTgftkrUxLfQgK43LQ+MLremlOMnDP61VH
         3ujEcmT0q5qCmEzHNPzHDo5n7s2YVaK37t1vtZ6UCabjWZrSE3N2JfKSPVSe4wgyNx81
         T7YKhiR8aS1FwFBgbCs2MVMzCC0nTlUmefnyOWe3OmoQTzxhMva37CEhv891hMVIMMqb
         sB3PCN94KeGm5/Ga+awDxJ6bGVtZAgqD+y8Xmd4EyjxZalaCXb1nA/eREbwpiRqD+i5I
         kZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+xp1tHYgcqmK5vJcXbbULWl6T/5gevxAd+xabl7FRRA=;
        b=QSbgMLX3OtxcgOiUINK/yx7OyNfLS2UYFPwe3YVvaM0bEytTTjzs+yL2tdqfIcJ2jF
         WMxXYNtuGQ7hBaUxBKZEkRlW2ODiRYLM3w6xoPqPubOfSoO3BznaZQTnyhwoyERFFzTf
         z0xDyKoek+7Q6dOwvBeshQsheaUSkybeCi6Fo2DMCRqRJ1wLufIpQ/mye0xn4Sq+ATF7
         EWVN+pMdBxTO2GiaunhRZ/+wJjeyRbvmJ40xQlINGZVqWcMYV6wtW4gK0DIX/51IAqMA
         utTQjRIlU0NMB3tomf/VWow5YxCMmK5rms/vkHoH0VbLORZ2/4FAS6phnK5j4XO57Rzm
         KvVQ==
X-Gm-Message-State: ABuFfoiczFFwkD153ia9dz3f5dwkTjjd53D46vgqZ1ZWir9v/Gb5UkMn
        iqqfiJiUeBFn0FEWyk65jFk=
X-Google-Smtp-Source: ACcGV61XhKMXrb7YEYqdAAihLgXtReyWnuLPQ6PXJwgULhA0hepFWga67rDIicADdytRXn233QnFqg==
X-Received: by 2002:a2e:7014:: with SMTP id l20-v6mr1082108ljc.141.1537520094940;
        Fri, 21 Sep 2018 01:54:54 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id w202-v6sm1256355lff.17.2018.09.21.01.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 01:54:53 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] [media] imx214: device tree binding
Date:   Fri, 21 Sep 2018 10:54:50 +0200
Message-Id: <20180921085450.19224-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180921085450.19224-1-ricardo.ribalda@gmail.com>
References: <20180921085450.19224-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for imx214 v4l2 driver.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 .../devicetree/bindings/media/i2c/imx214.txt  | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx214.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/imx214.txt b/Documentation/devicetree/bindings/media/i2c/imx214.txt
new file mode 100644
index 000000000000..4ff76d96332e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/imx214.txt
@@ -0,0 +1,51 @@
+* Sony 1/3.06-Inch 13.13Mp CMOS Digital Image Sensor
+
+The Sony imx214 is a 1/3.06-inch CMOS active pixel digital image sensor with
+an active array size of 4224H x 3176V. It is programmable through I2C
+interface. The I2C address can be configured to to 0x1a or 0x10, depending on
+how is wired.
+Image data is sent through MIPI CSI-2, which is configured as 4 lanes
+at 1440 Mbps.
+
+
+Required Properties:
+- compatible: value should be "sony,imx214" for imx214 sensor
+- reg: I2C bus address of the device
+- enable-gpios: Sensor enable GPIO
+- vdddo-supply: Chip digital IO regulator (1.8V).
+- vdda-supply: Chip analog regulator (2.7V).
+- vddd-supply: Chip digital core regulator (1.12V).
+- clocks = Reference to the xclk clock.
+- clock-names = Should be "xclk".
+- clock-frequency = Frequency of the xclk clock. Should be <24000000>;
+
+Optional Properties:
+- flash-leds: See ../video-interfaces.txt
+- lens-focus: See ../video-interfaces.txt
+
+The imx274 device node should contain one 'port' child node with
+an 'endpoint' subnode. For further reading on port node refer to
+Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Example:
+
+	camera_rear@1a {
+		status = "okay";
+		compatible = "sony,imx214";
+		reg = <0x1a>;
+		vdddo-supply = <&pm8994_lvs1>;
+		vddd-supply = <&camera_vddd_1v12>;
+		vdda-supply = <&pm8994_l17>;
+		lens-focus = <&ad5820>;
+		enable-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
+		clocks = <&mmcc CAMSS_MCLK0_CLK>;
+		clock-names = "xclk";
+		clock-frequency = <24000000>;
+		port {
+				imx214_ep: endpoint {
+				clock-lanes = <1>;
+				data-lanes = <0 2 3 4>;
+				remote-endpoint = <&csiphy0_ep>;
+			};
+		};
+	};
-- 
2.18.0

