Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E80C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4858222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391345AbfBMJuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:50:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42881 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfBMJuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:50:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so1257407lfh.9;
        Wed, 13 Feb 2019 01:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OEMMOvm9oLQXStCUJJqngG7nJK2c50uE2GSZE4ln3PI=;
        b=ngNhc0TwXXqNk2mGQeC+p8oAt/XNo6E67krAFHojaTG38yWcsCs4qg/NReUa56G5Os
         q6T666ygIJBt7vGCO4ONdJZVOa8c95pTHg9a8wghnPKoC1RUn26RIEnuoJrceqkk641x
         G1K5FEKefEUF+0pQ4Q9kftfkJOeEHoT4I2KiVPNLFoakHFHXQw/JR3yVuVxF5VhfaX6I
         TR1cqP2rXPq0d1BPq14VBLoxfKg1nM/2B8+DUob0AEsT8UWFRgJfLdDKMUNKAlU3+5By
         JZNkCR8hZaTvRhOgkwN1F8HNJLuuMPVH6XESPMJZdcKw0FsG95aN54PHRhgEgn667hWp
         lklQ==
X-Gm-Message-State: AHQUAub8sbmDWLSrxRzXKHKHSBCVmv97hCRbXVX0BgbYjS7uLr/hfekF
        fAwM94uKIx3f8qaVopms0bM=
X-Google-Smtp-Source: AHgI3IYjOxbHw1kA2CXWctGyoToDsykjV8Ij23nZZ/5/5Q0Qw/xdPQ2YW/GrZykuSeloJdNDylMoOw==
X-Received: by 2002:a19:9c54:: with SMTP id f81mr5394106lfe.135.1550051415079;
        Wed, 13 Feb 2019 01:50:15 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id t12-v6sm3326981ljd.47.2019.02.13.01.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 01:50:14 -0800 (PST)
Date:   Wed, 13 Feb 2019 11:50:02 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com,
        Robin Gong =?utf-8?B?4oCO?= <yibin.gong@nxp.com>,
        Elven Wang =?utf-8?B?4oCO?= <elven.wang@nxp.com>,
        Anson Huang =?utf-8?B?4oCO?= <anson.huang@nxp.com>
Subject: [PATCH v2 1/3] devicetree: bindings: bd718x7: document HW state
 related ROHM specific properties
Message-ID: <501fe1a68a9ad0987ddc0d3f559b2bdd1f65a5b7.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
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
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 15 +++++++++++
 .../bindings/regulator/rohm,bd71837-regulator.txt  | 30 ++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
index a4b056761eaa..f07c32975315 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
@@ -23,6 +23,21 @@ Required properties:
 
 Optional properties:
 - clock-output-names	: Should contain name for output clock.
+- rohm,reset-snvs-powered : Transfer BD718x7 to SNVS state at reset.
+
+The BD718x7 supports two different HW states as reset target states. States
+are called as SNVS and READY. At READY state all the PMIC power outputs go
+down and OTP is reload. At the SNVS state all other logic and external
+devices apart from the SNVS power domain are shut off. Please refer to NXP
+i.MX8 documentation for further information regarding SNVS state. When a
+reset is done via SNVS state the PMIC OTP data is not reload. This cause
+
+There is a HW quirk in BD718x7 which causes power outputs that have been
+under SW control to stay down when reset has switched power state to SNVS.
+If reset is done via READY state the power outputs will be set to HW control
+by OTP loading. Thus the reset target state is set to READY by default. If
+SNVS state is used the boot crucial regulators must have the
+regulator-always-on and regulator-boot-on properties set in regulator node.
 
 Example:
 
diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
index 4b98ca26e61a..4a05cbf915ee 100644
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
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
