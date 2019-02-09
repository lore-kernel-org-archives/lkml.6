Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE147C169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCD4205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="T4Td5UR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBIASt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:18:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50651 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBIASr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:18:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id z5so6305065wmf.0;
        Fri, 08 Feb 2019 16:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qeQ6qFBBecGkUUWa0nrJm3Kg+BaUyaQ2/4jZF4BLOtU=;
        b=T4Td5UR0+GaEeWW1nnS6Unhh73PMGEs12YdcDlbbs+9Fcq5jj9wHkkpjSPHGk9VmxV
         BiTg0snuLvmmYc0tikXfEzZJb1gT+D5pzk4jkYPuntNDYoArfwm/QX0thCeKLcO9wblJ
         mwQrtWja6XKRtfAe7X9/YA0vAuDzQpxQd3D/GQWiVczOnssFJ8mlRsGjtJczmQ9+Y710
         +3kFGlcsK+JkLlISkSkKweAZUpVjRUsbhdg0nC3oxi4dhzCwC9hCthRuEnWOqjCbobaB
         FFknK2JSWjPc3AqWIszE+4QbTEQJ1vNmACTjiXq6q0ly80ndhd1M0I4570JXwuQ/xcIP
         ExMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qeQ6qFBBecGkUUWa0nrJm3Kg+BaUyaQ2/4jZF4BLOtU=;
        b=QrSZP159t3LKZ7MVwqT863MyD2/+Ic0s0iotj4exT6XQJHU5X80U6mE1ehQ6yvd8R8
         V8O0AOyoQAs6O3kI8rXFu73KcHRVJlatLe+3vX3w01WwAYbioMJNGndfcRlPqhc8CwGX
         bST167QO6EpURpU9XNwJ8xiaIz4FzNH4y2hKh7DGqlzRe5k5YxxlP/DyuTF2i4ZgnTQx
         k8BA4KL+ZsrrFq8B6fhyFF1TNYu4JAc+PrmGGCM98mZ9MBMJL2NTr9IupVrpvESB7zS+
         WMB9aZJRgdLzmxIA84mkauqhVAArmI1JjdrOCpxCTwM6kKlcnNKVqJISgBxnpczPv/fp
         fR3Q==
X-Gm-Message-State: AHQUAuafjcwoX7b81Ns5e69vavly5D/7i4NlbyGPqcEWLH2nR5yZYSuL
        G5iF4YWi23+zEgvnG9enyqqZq6y0
X-Google-Smtp-Source: AHgI3IYUcSNAlybaGXTRUz+mJ9/8hxVON182aTFHSXwPOvWNZKbXZGq6d+fe6lmC60vpgAH3C1oONQ==
X-Received: by 2002:a5d:4dc8:: with SMTP id f8mr19174849wru.45.1549671525604;
        Fri, 08 Feb 2019 16:18:45 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD70B4600C545FEF64E1C6C81.dip0.t-ipconnect.de. [2003:dc:d70b:4600:c545:fef6:4e1c:6c81])
        by smtp.googlemail.com with ESMTPSA id b12sm2168162wmj.3.2019.02.08.16.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:18:44 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ben.dooks@codethink.co.uk, ccaione@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v7 1/2] dt-bindings: rtc: add device-tree bindings for the Amlogic Meson RTC
Date:   Sat,  9 Feb 2019 01:18:12 +0100
Message-Id: <20190209001813.6792-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190209001813.6792-1-martin.blumenstingl@googlemail.com>
References: <20190209001813.6792-1-martin.blumenstingl@googlemail.com>
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
 .../devicetree/bindings/rtc/rtc-meson.txt     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson.txt

diff --git a/Documentation/devicetree/bindings/rtc/rtc-meson.txt b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
new file mode 100644
index 000000000000..e921fe66a362
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/rtc-meson.txt
@@ -0,0 +1,35 @@
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
+Optional properties for the battery-backed non-volatile memory:
+- #address-cells: should be 1 to address the battery-backed non-volatile memory
+- #size-cells: should be 1 to reference the battery-backed non-volatile memory
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
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
-- 
2.20.1

