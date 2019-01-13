Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94672C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC75206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 18:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu8DqyCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfAMSS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 13:18:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41828 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfAMSS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 13:18:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so9279326pfi.8;
        Sun, 13 Jan 2019 10:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TB8imBtf4PAjNqPCC8uvdtsm3BgS79eWnXlUKq9cCOM=;
        b=Lu8DqyCUTBNJTP2Zg+KMuvhg78dhNHDuYUrCNqHkIk5Y0lyXE+PP3blssrwJBUrBS2
         f+qFZr7GVdTH66Mn+1KZmvdfS+wngEGvKFAWmQebB2N9dItWOtFoJ5UH0NWZnH+EYFed
         vx3U/luIECC8l37riW1c2jL5q/X3iU2nEsMJp5vAVW236vyOraRK4E5UXbELGVtWZ5O/
         FApS1PevImQJ0LStkptdWirEFrIRu161kcUkfTlcRBQ/jiTqD0UBIbnfMZ3ZA4UuV4NV
         TrPSr6TjvN2tV8duA3jI4z4/ZOn2uYVtHq6fg/rVihCEVQykI8ZHPz/zm2/Gy1bCxHOY
         WpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TB8imBtf4PAjNqPCC8uvdtsm3BgS79eWnXlUKq9cCOM=;
        b=Bx0XRmleqz+HbY5G7Zh8WqPs2vXB7GtRp9iGmv2iA8YmvsnW08d/1mhFEaCFWkmKTz
         HuuzNTPHxg8ZVS+1RZJxiK2d7x5Uz0SKqjKoP4qHpCl6Vzp/J0G25Q9CUh+Heo6WSxW8
         GH9F+fNErOPMVCbj2I5guaMbKG4QQedkcFB1VJwuwLtlCuV94QRvj1a0WBsTSOql2ox+
         tQ3TX++kJzLu2Chu2t8XADsk5j1RUNhBdMwL49fQxeZhYHXkPR6nWseoXbAdRfPtNDuM
         cuV9bzk7FXYLZEr6aj98ukRGZNRptHJ/5YEI/QoC9wF2MPJSKuq7XoyQopYxNC6jyC6v
         aeDg==
X-Gm-Message-State: AJcUukenr5NWfsStkWa/VzH6qfqrUPOSnn3TWdvIM/0ec9ktnejxXRYe
        wnzRwL2q/D8/tcjP7F0YXjQwCjRR
X-Google-Smtp-Source: ALg8bN4a2ZUCLZRINvNgsuR6mrYyrMJJLN5xkgJSj4vVCIJxdpGVcRBD33NTjum/uqUXRiR/2dFIVQ==
X-Received: by 2002:a63:fc05:: with SMTP id j5mr20595026pgi.434.1547403504814;
        Sun, 13 Jan 2019 10:18:24 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.105])
        by smtp.gmail.com with ESMTPSA id i193sm157504416pgc.22.2019.01.13.10.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 10:18:24 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>
Subject: [PATCH 1/2] ARM: dts: meson8b: odroidc1: Enable usb phy node
Date:   Sun, 13 Jan 2019 18:18:07 +0000
Message-Id: <20190113181808.5768-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing vbus-supply link to phy controller for usb_phy0
and usb_phy1 nodes, this changes fixed the power issue
on usb ports usb, changes help fix usb reset warning.

[  821.991470] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  825.243385] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  828.151310] usb 1-1.2: reset high-speed USB device number 3 using dwc2
[  830.991241] usb 1-1.2: reset high-speed USB device number 3 using dwc2

Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board)
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Rebased on Kevin's amlogic/v5.0/fixes branch

[alarm@archl-c1t ~]$ lsusb -t
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
        |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
        |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
        |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
[alarm@archl-c1t ~]$
[alarm@archl-c1t ~]$ lsusb -v|egrep "^Bus|MaxPower"
Couldn't open device, some information will be missing
Bus 001 Device 003: ID 1b71:0056 Fushicai
    MaxPower              500mA
Couldn't open device, some information will be missing
Bus 001 Device 004: ID 152d:0578 JMicron Technology Corp. / JMicron USA Technology Corp. JMS567 SATA 6Gb/s bridge
    MaxPower               30mA
Couldn't open device, some information will be missing
Couldn't open device, some information will be missing
Bus 001 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
    MaxPower              100mA
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
    MaxPower                0mA
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 0f0a46ddf3ff..a49a8509b288 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -83,6 +83,19 @@
 		regulator-max-microvolt = <5000000>;
 	};
 
+	usb_vbus: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+
+		regulator-name = "USB_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+
+		vin-supply = <&p5v0>;
+
+		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	tflash_vdd: regulator-tflash_vdd {
 		/*
 		 * signal name from schematics: TFLASH_VDD_EN
@@ -293,8 +306,18 @@
 	pinctrl-names = "default";
 };
 
+&usb0_phy {
+	status = "okay";
+	vbus-supply = <&usb_vbus>;
+};
+
 &usb1_phy {
 	status = "okay";
+	vbus-supply = <&usb_vbus>;
+};
+
+&usb0 {
+	status = "okay";
 };
 
 &usb1 {
-- 
2.20.1

