Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A05C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 14:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C4A20883
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 14:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Nnh2Lig1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfASOoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 09:44:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33843 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfASOoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 09:44:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so18477443wrw.1;
        Sat, 19 Jan 2019 06:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v965bY0D36Opd3mmqvUPGRdQyL0pvZT1CqXXJhq8UPU=;
        b=Nnh2Lig13pFj8Ny2O40YfyIdjj/sMZNluZJASfgUi7/eDPECLPnl4uasJp3XgAjRRH
         gEhoQPqgFNisGiCccW63BjvScSTze/iygxvy9xwhpjF7tM2431ccGQuoqc8jkvvPCRhy
         DhR1u3SdySfaGUPsrCpmAWvEljoUGsCzNX/4sbkMaxNMe/79y5yl9rRBTj/KMON1YmDF
         8swRqVG8zh3IF8YXyRSQAWsPpNKvi/z32JxOP4y+knb8xGCvNS7MN2Fu09frCrR+PpRh
         umnhkNzOuWWfUBAQvY+EFEPIy+GZlwYxQZrgD2J5Po+XBe9slLKcj7NNL+c18e0sLql1
         TSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v965bY0D36Opd3mmqvUPGRdQyL0pvZT1CqXXJhq8UPU=;
        b=q8F+J3bzQjbOcDXty03VSv8JGEgHqDBfIYP1OyoecawH6eqolMo96SNwog98Ec0BID
         czsbNe6zOI/wWB/NGVV28AuisKVVIcuQHiArds255SPnjNHOigNMmhCB23KdktEllasO
         GaTgbJ+3+K1sleAFBW2oYMPkM97W/kxZo09o7aDXiw+65//KDUXHMwB93Q+rFSXPVfEF
         4CKs6I0VjkV/FU6SBkBx5iEC8J2fRJLsJaUyyzU+I3bRGl1fdnJyT0LtYqCo/nehkK1m
         +64QgQq/AVzVFSGdZIFL9m9Vxra2i13DqmHeDXxkOKkc/ipLaM3gCJ+D1aVw6U8/kPhu
         EUBA==
X-Gm-Message-State: AJcUukf4Rvsib+hkAAjKJTzRb6yJGJLwqV0iGRVQHq7V+RXSDxrDgD2C
        VcE5pvPpXFh8XymLo2pL9Cs=
X-Google-Smtp-Source: ALg8bN6aCCfzVYjp9rxAyKEpe41ounh8KxiHhOnxCgbhDHRIG+Zy04RCFLj+lOz2RvEnPDn06oyVqQ==
X-Received: by 2002:adf:d112:: with SMTP id a18mr21615284wri.17.1547909047111;
        Sat, 19 Jan 2019 06:44:07 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73A8100FDA9BD4E9DEACC2C.dip0.t-ipconnect.de. [2003:dc:d73a:8100:fda9:bd4e:9dea:cc2c])
        by smtp.googlemail.com with ESMTPSA id b7sm80452772wrs.47.2019.01.19.06.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 06:44:06 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ben.dooks@codethink.co.uk, ccaione@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v6 1/2] dt-bindings: rtc: add device-tree bindings for the Amlogic Meson RTC
Date:   Sat, 19 Jan 2019 15:43:31 +0100
Message-Id: <20190119144332.11984-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190119144332.11984-1-martin.blumenstingl@googlemail.com>
References: <20190119144332.11984-1-martin.blumenstingl@googlemail.com>
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
2.20.1

