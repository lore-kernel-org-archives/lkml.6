Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75A2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76C22229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404254AbfBNJfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:35:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46417 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbfBNJfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:35:07 -0500
Received: by mail-lj1-f196.google.com with SMTP id v16so4583710ljg.13;
        Thu, 14 Feb 2019 01:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=upSaN3nlBTeGZDk787X3IXT2TyaTlYf3GON49dsDAFE=;
        b=SFIh4HSAPUME9EYW5Our26XlBAmL/Ggmij+0kYlZFiP6Wz2vbviFPYjs5YXUtM3ktC
         fk2Ezbliua/tCo/ncDqq0fooyX3iziQ5fgS1nmIV0QrKuo4bOmJP/WwzPbZvZCCozv4w
         BV7ZkfpEtlUfIPHhUOXdYJh//MtMKEIYb68YEBblCfzgZrFRDMi7RuoEFXfLbzZHwu1N
         EEeu1AQTUlgtY2n7Lhyizm8oYE0U/olJ9dl5NuPmzh4v2p1wPhbmRh2WNFqapJxLzSnZ
         v7sHN33yZRgjgo2koIPEi3mW1sjAVJjAztI+VZJ4J67N6RBQ1FwW/x9VQuvZa71TNwFj
         m2Ow==
X-Gm-Message-State: AHQUAuaWCP9U7RaNp3Dgixaa6fThlgYDF8OYrsWAsoXgjVpZwpQtk3Ui
        tSQZYL94xh+XhcJ2ECp5g/IT3M42
X-Google-Smtp-Source: AHgI3IaAYh96YhseZW3+FHDckGaZNLue2tFgccdzQlMcRzeHDFwGO0a+d89tiZeO7PG9aySMrYI9/g==
X-Received: by 2002:a2e:2406:: with SMTP id k6-v6mr1735923ljk.147.1550136903961;
        Thu, 14 Feb 2019 01:35:03 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k21sm361870lfg.51.2019.02.14.01.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:35:03 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:34:50 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazzisaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Angus Ainslie <angus.ainslie@puri.sm>
Subject: [PATCH v3 1/3] devicetree: bindings: bd718x7: document HW state
 related ROHM specific properties
Message-ID: <6ed4238fb083f52de0f5f013647b2334bad8ebe4.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ROHM BD71837 / BD71847 specific device tree bindings for
controlling the PMIC shutdown/reset states and voltages for
different HW states. The PMIC was designed to be used with NXP
i.MX8 SoC and it supports SNVS low power state which seems to
be typical for NXP i.MX SoCs. However, when SNVS is used we must
not allow SW to control enabling/disabling those regulators which
are crucial for system to boot as there is a HW limitation which
causes SW controlled regulators to be kept shut down after SNVS
reset.

Allow setting the SNVS to be used as reset target state and allow
marking those regulators which are critical for boot.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 17 ++++++++++
 .../bindings/regulator/rohm,bd71837-regulator.txt  | 38 ++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
index a4b056761eaa..d5f68ac78d15 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
@@ -23,6 +23,20 @@ Required properties:
 
 Optional properties:
 - clock-output-names	: Should contain name for output clock.
+- rohm,reset-snvs-powered : Transfer BD718x7 to SNVS state at reset.
+
+The BD718x7 supports two different HW states as reset target states. States
+are called as SNVS and READY. At READY state all the PMIC power outputs go
+down and OTP is reload. At the SNVS state all other logic and external
+devices apart from the SNVS power domain are shut off. Please refer to NXP
+i.MX8 documentation for further information regarding SNVS state. When a
+reset is done via SNVS state the PMIC OTP data is not reload. This causes
+power outputs that have been under SW control to stay down when reset has
+switched power state to SNVS. If reset is done via READY state the power
+outputs will be returned to HW control by OTP loading. Thus the reset
+target state is set to READY by default. If SNVS state is used the boot
+crucial regulators must have the regulator-always-on and regulator-boot-on
+properties set in regulator node.
 
 Example:
 
@@ -43,6 +57,7 @@ Example:
 		#clock-cells = <0>;
 		clocks = <&osc 0>;
 		clock-output-names = "bd71837-32k-out";
+		rohm,reset-snvs-powered;
 
 		regulators {
 			buck1: BUCK1 {
@@ -50,8 +65,10 @@ Example:
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				regulator-boot-on;
+				regulator-always-on;
 				regulator-ramp-delay = <1250>;
 			};
+			// [...]
 		};
 	};
 
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
index 4b98ca26e61a..cbce62c22b60 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
@@ -27,8 +27,38 @@ BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6
 LDO1, LDO2, LDO3, LDO4, LDO5, LDO6
 
 Optional properties:
+- rohm,dvs-run-voltage		: PMIC default "RUN" state voltage in uV.
+				  See below table for bucks which support this.
+- rohm,dvs-idle-voltage		: PMIC default "IDLE" state voltage in uV.
+				  See below table for bucks which support this.
+- rohm,dvs-suspend-voltage	: PMIC default "SUSPEND" state voltage in uV.
+				  See below table for bucks which support this.
 - Any optional property defined in bindings/regulator/regulator.txt
 
+Supported default DVS states:
+
+BD71837:
+buck	| dvs-run-voltage	| dvs-idle-voltage	| dvs-suspend-voltage
+-----------------------------------------------------------------------------
+1	| supported		| supported		| supported
+----------------------------------------------------------------------------
+2	| supported		| supported		| not supported
+----------------------------------------------------------------------------
+3	| supported		| not supported		| not supported
+----------------------------------------------------------------------------
+4	| supported		| not supported		| not supported
+----------------------------------------------------------------------------
+rest	| not supported		| not supported		| not supported
+
+BD71847:
+buck	| dvs-run-voltage	| dvs-idle-voltage	| dvs-suspend-voltage
+-----------------------------------------------------------------------------
+1	| supported		| supported		| supported
+----------------------------------------------------------------------------
+2	| supported		| supported		| not supported
+----------------------------------------------------------------------------
+rest	| not supported		| not supported		| not supported
+
 Example:
 regulators {
 	buck1: BUCK1 {
@@ -36,7 +66,11 @@ regulators {
 		regulator-min-microvolt = <700000>;
 		regulator-max-microvolt = <1300000>;
 		regulator-boot-on;
+		regulator-always-on;
 		regulator-ramp-delay = <1250>;
+		rohm,dvs-run-voltage = <900000>;
+		rohm,dvs-idle-voltage = <850000>;
+		rohm,dvs-suspend-voltage = <800000>;
 	};
 	buck2: BUCK2 {
 		regulator-name = "buck2";
@@ -45,18 +79,22 @@ regulators {
 		regulator-boot-on;
 		regulator-always-on;
 		regulator-ramp-delay = <1250>;
+		rohm,dvs-run-voltage = <1000000>;
+		rohm,dvs-idle-voltage = <900000>;
 	};
 	buck3: BUCK3 {
 		regulator-name = "buck3";
 		regulator-min-microvolt = <700000>;
 		regulator-max-microvolt = <1300000>;
 		regulator-boot-on;
+		rohm,dvs-run-voltage = <1000000>;
 	};
 	buck4: BUCK4 {
 		regulator-name = "buck4";
 		regulator-min-microvolt = <700000>;
 		regulator-max-microvolt = <1300000>;
 		regulator-boot-on;
+		rohm,dvs-run-voltage = <1000000>;
 	};
 	buck5: BUCK5 {
 		regulator-name = "buck5";
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
