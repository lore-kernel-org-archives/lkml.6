Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFBEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3D32173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3D32173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeHCNFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:05:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40657 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeHCNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:05:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id y200-v6so3771223lfd.7;
        Fri, 03 Aug 2018 04:09:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9msh/sUMmBfjN3v+w61oDS3q1DpWTifVmR6uNOLYVgI=;
        b=mCEITFADYnH0+Nt16njNB1AVNsMEevCoRY60HWYHowKdZ9ckeG0QpKnVRr1pE24BNG
         QDXdP1ct7B9n2IkipmQvBH1wbkxWDe1p8D/TIydrV0iiwlBtt49QSD7g7sVipK4oKl9L
         ysZQlrMhNo7zfvHLo0c7NyZYpLDR0U4CvaohGYxRfIw0atTirSK4Ff+/ddYKTP7ySXDj
         p9ph/WcVFhLG8+ZU+CanUrRJWSm/LhtjGmBHlM8noN8FOCN4l2NeFMRUGDGOEFfSyO94
         7g4tWoIRhjGcasRypXemPRB8vC5lV0MtrUniB+fBsL/ynCyoub4F8ZdyR3T8ynSGS+Mw
         y+LA==
X-Gm-Message-State: AOUpUlHcSQG3oX0Nf7cgbfqBe4EB1UC5ccHASQ5QtkEB6CGAZWr3vosU
        GyIYsoEd1w/D1WJ+5JDi0Ks=
X-Google-Smtp-Source: AAOMgpdEx28EB3ytRrpz0DwRn2Sy2N2Pd2W8k7dwVdj9nRWlaKICvHxrqXvzp7tXI/QdUorM7CBeuw==
X-Received: by 2002:a19:6b03:: with SMTP id d3-v6mr4240277lfa.81.1533294564715;
        Fri, 03 Aug 2018 04:09:24 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b24-v6sm870809lji.13.2018.08.03.04.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 04:09:24 -0700 (PDT)
Date:   Fri, 3 Aug 2018 14:09:12 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        eballetbo@gmail.com, linus.walleij@linaro.org,
        mazziesaccount@gmail.com, dmitry.torokhov@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, broonie@kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v12 2/2] mfd: bd71837: Devicetree bindings for ROHM BD71837
 PMIC
Message-ID: <d053f54e5ce726ffaa95fbd9c20962a49dd1ee07.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for ROHM BD71837 PMIC MFD.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
new file mode 100644
index 000000000000..3ca56fdb5ffe
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
@@ -0,0 +1,62 @@
+* ROHM BD71837 Power Management Integrated Circuit bindings
+
+BD71837MWV is a programmable Power Management IC for powering single-core,
+dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is optimized for
+low BOM cost and compact solution footprint. It integrates 8 Buck
+egulators and 7 LDOs to provide all the power rails required by the SoC and
+the commonly used peripherals.
+
+Datasheet for PMIC is available at:
+https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
+
+Required properties:
+ - compatible		: Should be "rohm,bd71837".
+ - reg			: I2C slave address.
+ - interrupt-parent	: Phandle to the parent interrupt controller.
+ - interrupts		: The interrupt line the device is connected to.
+ - clocks		: The parent clock connected to PMIC. If this is missing
+			  32768 KHz clock is assumed.
+ - #clock-cells		: Should be 0.
+ - regulators:		: List of child nodes that specify the regulators.
+			  Please see ../regulator/rohm,bd71837-regulator.txt
+
+Optional properties:
+- clock-output-names	: Should contain name for output clock.
+
+Example:
+
+	/* external oscillator node */
+	osc: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <1>;
+		clock-frequency  = <32768>;
+		clock-output-names = "osc";
+	};
+
+	pmic: pmic@4b {
+		compatible = "rohm,bd71837";
+		reg = <0x4b>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <29 GPIO_ACTIVE_LOW>;
+		interrupt-names = "irq";
+		#clock-cells = <0>;
+		clocks = <&osc 0>;
+		clock-output-names = "bd71837-32k-out";
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "buck1";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-ramp-delay = <1250>;
+			};
+		};
+	};
+
+	/* Clock consumer node */
+	rtc@0 {
+		compatible = "company,my-rtc";
+		clock-names = "my-clock";
+		clocks = <&pmic>;
+	};
-- 
2.14.3

