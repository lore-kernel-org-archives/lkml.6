Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E87C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9790620817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 04:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah4xYA2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9790620817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeKSOpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 09:45:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35699 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeKSOpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 09:45:41 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so13574383wrb.2;
        Sun, 18 Nov 2018 20:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tvZAEJbBrbest8/m8X64nW1BKo0bE1uHGglKvNkfnt8=;
        b=Ah4xYA2/ZHXRCtRyKb7zCwmUUJyDC3l1lYkToflC+wi4AHglXYBmZI+m5bBPMsKIqT
         S+tfAu9I9BTiEtC3IpVM1pMArEODymRxWlsGinr7lVqzky5exJCi7OEa6B30uU4sr9Nh
         pHpeyDG6l+uD577c5bqR3ap9pcmpROOSpRpmddspjN4pqJCeUqhzU4HF7GD2iYmkZieL
         vPXL9W42WMFDJgvZhbGyJwhcNdqUNP0TG3atSegevM2wwsoo3ZJjYp1LjvRa2mm5bPJy
         7NoBrLEizJp4q27+k1+WSFoM9SRh3LdwH/gd8MgGDW5Ntc8K+neVEG7zxDTNSy/KF1lA
         U+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tvZAEJbBrbest8/m8X64nW1BKo0bE1uHGglKvNkfnt8=;
        b=GtLENLWKv5U9BLP2fMU7HL9wMKWNoijtPdKArgnxjVrHGAmGSwYequtzMPQyMHAwfi
         4cU5yjiQsc2mkUqdIxf6AZqxtR/XNv5RG7/iDYbt6fKiDVDndwy7OqHKJEmtWQ5ITnvN
         FmeLqMtoa5JxW6QNJjG22HCKYROmOxi45x/mj/5AgtSCLvDYvyOrSb1DpTGMZhU4ZgTk
         ObibAycj2neT+3wpChJ0H68WZGwSDv7ffl4WED46SYlws+UPlQaiLxFEAg/Xe06wJ51f
         8OV77EgdcAm7RDH71N2efxZvMtaKIYeMRQsrpXoiKLzuT8RFCZjANE+Ol6ErEEAr5Qsd
         kmVw==
X-Gm-Message-State: AGRZ1gKn6hGIpCIJkinU4pP7NRhAkr0SToqi1Ao36yUw2u+inKPduEbm
        OIJ44F3BrwuA+6rpV8KM6io=
X-Google-Smtp-Source: AJdET5dB9dikpWwXQKZFmpa14PHmWDj875YK6lgID/gv0qRcbKqcvG0WcJxE8FKCG5VgLKvvTt0fsQ==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr15823885wru.33.1542601399287;
        Sun, 18 Nov 2018 20:23:19 -0800 (PST)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id h203-v6sm30536817wma.38.2018.11.18.20.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 20:23:18 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
Cc:     christianshewitt@gmail.com, martin.blumenstingl@googlemail.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-gxbb-wetek: fix hwmon temperature sensor output
Date:   Mon, 19 Nov 2018 08:22:28 +0400
Message-Id: <1542601348-3469-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add &saradc and supporting vddio_ao18 nodes to fix hwmon temperature
readings on the WeTek Hub and Play2 devices. Without these nodes the
temp is reported as 4294967295 degrees C.

Thanks to Martin Blumenstingl for assisting debug and the winning
guess at what was missing.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index 70325b2..dd12e02 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -59,6 +59,13 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	vcc_3v3: regulator-vcc_3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC_3V3";
@@ -173,6 +180,11 @@
 	clock-names = "clkin0";
 };
 
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao18>;
+};
+
 /* Wireless SDIO Module */
 &sd_emmc_a {
 	status = "okay";
-- 
2.7.4

