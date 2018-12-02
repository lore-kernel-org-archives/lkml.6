Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F99C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9E020834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j6WiuGt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9E020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbeLBWJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 17:09:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37056 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeLBWJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 17:09:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so10189862wru.4;
        Sun, 02 Dec 2018 14:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgleaoAa3YaOEy0n3Wi4meO9b+MluJgrwKrKNoAz80U=;
        b=j6WiuGt7UJEfVr0F0CcmJkQzzXhbXwy92Gni16/No+Xd5juIIKW52nXM1AVqgtpnAB
         VKWckHNApMGHJwOdGVYqI0X2rs+VdSwiO3kopG4PKZpzDg8rZERc/+oghc6pI1I/D+CZ
         DPWCkQQ3aFsXV/KqHegcexxFbvwjWZFQ7eQm3+sxv+jWanCpvmZSnHes7g9eZWcv6fYL
         hficnqjBw+EwMpOQgLxuPK1jjRSMMnbw0f3f1ZaZhkEPJymFQRQ9iN1NuVOCxczOL/9f
         GGWEykorEfDvYTK34TPyOpdr63hMf4L7SZQHFnh6aWgYHBv6D1LSnVYsW53uhoD1mvxk
         Q7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgleaoAa3YaOEy0n3Wi4meO9b+MluJgrwKrKNoAz80U=;
        b=l228XOV7q0Ajc4q2+MqL1h8essGrhB8k5hrDsgk3qQx+S0+csO8i1bP0C7GTzHpBll
         k0GUCMvEEEg99nBqteEMJq4dAuMZV4Te/E/sw8Dy3B5eOftZMPMAtK7hqgk+pz8QOBW3
         EPzq2ZEkkpUFWjmD4bf7xcJEPTfgzwMG3Fdz989osQ0Xk3rwHmRxXTwS55oA/Gxgznay
         S5L9W4s3b1dKnh/BD/92GxjobzlbOcktoSrkDr5qhAl0VHZI7zvjcRPHXIN9oDCrI8VJ
         iI3BK/sYo1bCkSGrfkgYExtpngKeo3qp3Z9lIBZ7zBq/uxiBhtoPu1aapQb4yIB2aDH0
         3Z5Q==
X-Gm-Message-State: AA+aEWZD3rSkxoO+88Jmu0UygkH289v6lNx7zrMTB8drReTnGHcPWy5B
        hlpzJicTkxdPmaNxaVuFlbbbPm8y
X-Google-Smtp-Source: AFSGD/WI8kC7T5/dbZ8Ha3XPd5GusAFcDl1/ZlOeh7lrWul+4j8CVCJFq16Z6dMEqa83V0/a6TV4yg==
X-Received: by 2002:a5d:4512:: with SMTP id s18mr12514443wrq.182.1543788537891;
        Sun, 02 Dec 2018 14:08:57 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00B1CC0EB38CD20A4E.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:b1cc:eb3:8cd2:a4e])
        by smtp.googlemail.com with ESMTPSA id m15sm8503351wrr.95.2018.12.02.14.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 14:08:57 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ben.dooks@codethink.co.uk, ccaione@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v5 1/2] dt-bindings: rtc: add device-tree bindings for the Amlogic Meson RTC
Date:   Sun,  2 Dec 2018 23:08:46 +0100
Message-Id: <20181202220847.24364-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
References: <20181202220847.24364-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32-bit Amlogic Meson SoCs (Meson6, Meson8, Meson8b and Meson8m2)
have a built-in RTC block.
It has the following inputs:
- an 32.768kHz crystal oscillator
- an interrupt line
- a reset line
- 0.9V voltage input

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[resurrected patches from Ben after 2 years]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/rtc/rtc-meson.txt     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-meson.txt b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
new file mode 100644
index 000000000000..23df3cf2dd73
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
@@ -0,0 +1,32 @@
+* Amlogic Meson6, Meson8, Meson8b and Meson8m2 RTC
+
+Required properties:
+- compatible: should be one of the following describing the hardware:
+	* "amlogic,meson6-rtc"
+	* "amlogic,meson8-rtc"
+	* "amlogic,meson8b-rtc"
+	* "amlogic,meson8m2-rtc"
+
+- reg: physical register space for the controller's memory mapped registers.
+- interrupts: the interrupt line of the RTC block.
+- clocks: reference to the external 32.768kHz crystal oscillator.
+- vdd-supply: reference to the power supply of the RTC block.
+- resets: reset controller reference to allow reset of the controller
+
+Optional properties:
+- #address-cells: should be 1 to address the internal non-volatile memory
+- #address-cells: should be 1 to reference the internal non-volatile memory
+
+Optional child nodes:
+- see ../nvmem/nvmem.txt
+
+Example:
+
+	rtc: rtc@740 {
+		compatible = "amlogic,meson6-rtc";
+		reg = <0x740 0x14>;
+		interrupts = <GIC_SPI 72 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&rtc32k_xtal>;
+		vdd-supply = <&rtc_vdd>;
+		resets = <&reset RESET_RTC>;
+	};
-- 
2.19.2

