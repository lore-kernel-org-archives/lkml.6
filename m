Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DF9C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D752242A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hVuJvIbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D752242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeHJTBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:01:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45986 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbeHJTBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4nAFm1aAlrIh656/Hq8OQJhb2Ht9yto0MTzpaPMnLLE=; b=hVuJvIbBYUjm
        hL8uo10auutySgrSGDmhUNuCZincL/KRm+NO1dwyVolYlHphdmLWyFy91Vej6bSMOh/O7UvwWlKxn
        KSED9p+QHa/M+ChsEPOoSUdd7gzGo3Y1J2V3ffcSB3O4Juq288+Zqa2cAcwNT74ApzN1zDk+FdS8n
        qX3ys=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1foAJg-0004sB-Sy; Fri, 10 Aug 2018 16:31:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9AB1C112435F; Fri, 10 Aug 2018 17:31:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     David Collins <collinsd@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: dt-bindings: add QCOM RPMh regulator bindings" to the regulator tree
In-Reply-To: 
Message-Id: <20180810163108.9AB1C112435F@debutante.sirena.org.uk>
Date:   Fri, 10 Aug 2018 17:31:08 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: dt-bindings: add QCOM RPMh regulator bindings

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 0db021f7a2731cc559f0c5beb19ff3f677ff8626 Mon Sep 17 00:00:00 2001
From: David Collins <collinsd@codeaurora.org>
Date: Fri, 13 Jul 2018 18:50:58 -0700
Subject: [PATCH] regulator: dt-bindings: add QCOM RPMh regulator bindings

Introduce bindings for RPMh regulator devices found on some
Qualcomm Technlogies, Inc. SoCs.  These devices allow a given
processor within the SoC to make PMIC regulator requests which
are aggregated within the RPMh hardware block along with requests
from other processors in the SoC to determine the final PMIC
regulator hardware state.

Signed-off-by: David Collins <collinsd@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../regulator/qcom,rpmh-regulator.txt         | 160 ++++++++++++++++++
 .../regulator/qcom,rpmh-regulator.h           |  36 ++++
 2 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
 create mode 100644 include/dt-bindings/regulator/qcom,rpmh-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
new file mode 100644
index 000000000000..7ef2dbe48e8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.txt
@@ -0,0 +1,160 @@
+Qualcomm Technologies, Inc. RPMh Regulators
+
+rpmh-regulator devices support PMIC regulator management via the Voltage
+Regulator Manager (VRM) and Oscillator Buffer (XOB) RPMh accelerators.  The APPS
+processor communicates with these hardware blocks via a Resource State
+Coordinator (RSC) using command packets.  The VRM allows changing three
+parameters for a given regulator: enable state, output voltage, and operating
+mode.  The XOB allows changing only a single parameter for a given regulator:
+its enable state.  Despite its name, the XOB is capable of controlling the
+enable state of any PMIC peripheral.  It is used for clock buffers, low-voltage
+switches, and LDO/SMPS regulators which have a fixed voltage and mode.
+
+=======================
+Required Node Structure
+=======================
+
+RPMh regulators must be described in two levels of device nodes.  The first
+level describes the PMIC containing the regulators and must reside within an
+RPMh device node.  The second level describes each regulator within the PMIC
+which is to be used on the board.  Each of these regulators maps to a single
+RPMh resource.
+
+The names used for regulator nodes must match those supported by a given PMIC.
+Supported regulator node names:
+	PM8998:		smps1 - smps13, ldo1 - ldo28, lvs1 - lvs2
+	PMI8998:	bob
+	PM8005:		smps1 - smps4
+
+========================
+First Level Nodes - PMIC
+========================
+
+- compatible
+	Usage:      required
+	Value type: <string>
+	Definition: Must be one of: "qcom,pm8998-rpmh-regulators",
+		    "qcom,pmi8998-rpmh-regulators" or
+		    "qcom,pm8005-rpmh-regulators".
+
+- qcom,pmic-id
+	Usage:      required
+	Value type: <string>
+	Definition: RPMh resource name suffix used for the regulators found on
+		    this PMIC.  Typical values: "a", "b", "c", "d", "e", "f".
+
+- vdd-s1-supply
+- vdd-s2-supply
+- vdd-s3-supply
+- vdd-s4-supply
+	Usage:      optional (PM8998 and PM8005 only)
+	Value type: <phandle>
+	Definition: phandle of the parent supply regulator of one or more of the
+		    regulators for this PMIC.
+
+- vdd-s5-supply
+- vdd-s6-supply
+- vdd-s7-supply
+- vdd-s8-supply
+- vdd-s9-supply
+- vdd-s10-supply
+- vdd-s11-supply
+- vdd-s12-supply
+- vdd-s13-supply
+- vdd-l1-l27-supply
+- vdd-l2-l8-l17-supply
+- vdd-l3-l11-supply
+- vdd-l4-l5-supply
+- vdd-l6-supply
+- vdd-l7-l12-l14-l15-supply
+- vdd-l9-supply
+- vdd-l10-l23-l25-supply
+- vdd-l13-l19-l21-supply
+- vdd-l16-l28-supply
+- vdd-l18-l22-supply
+- vdd-l20-l24-supply
+- vdd-l26-supply
+- vin-lvs-1-2-supply
+	Usage:      optional (PM8998 only)
+	Value type: <phandle>
+	Definition: phandle of the parent supply regulator of one or more of the
+		    regulators for this PMIC.
+
+- vdd-bob-supply
+	Usage:      optional (PMI8998 only)
+	Value type: <phandle>
+	Definition: BOB regulator parent supply phandle
+
+===============================
+Second Level Nodes - Regulators
+===============================
+
+- qcom,always-wait-for-ack
+	Usage:      optional
+	Value type: <empty>
+	Definition: Boolean flag which indicates that the application processor
+		    must wait for an ACK or a NACK from RPMh for every request
+		    sent for this regulator including those which are for a
+		    strictly lower power state.
+
+Other properties defined in Documentation/devicetree/bindings/regulator.txt
+may also be used.  regulator-initial-mode and regulator-allowed-modes may be
+specified for VRM regulators using mode values from
+include/dt-bindings/regulator/qcom,rpmh-regulator.h.  regulator-allow-bypass
+may be specified for BOB type regulators managed via VRM.
+regulator-allow-set-load may be specified for LDO type regulators managed via
+VRM.
+
+========
+Examples
+========
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+&apps_rsc {
+	pm8998-rpmh-regulators {
+		compatible = "qcom,pm8998-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-l7-l12-l14-l15-supply = <&pm8998_s5>;
+
+		smps2 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1100000>;
+		};
+
+		pm8998_s5: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allowed-modes =
+				<RPMH_REGULATOR_MODE_LPM
+				 RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+		};
+
+		lvs1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+	};
+
+	pmi8998-rpmh-regulators {
+		compatible = "qcom,pmi8998-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		bob {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3600000>;
+			regulator-allowed-modes =
+				<RPMH_REGULATOR_MODE_AUTO
+				 RPMH_REGULATOR_MODE_HPM>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+	};
+};
diff --git a/include/dt-bindings/regulator/qcom,rpmh-regulator.h b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
new file mode 100644
index 000000000000..86713dcf9e02
--- /dev/null
+++ b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+#ifndef __QCOM_RPMH_REGULATOR_H
+#define __QCOM_RPMH_REGULATOR_H
+
+/*
+ * These mode constants may be used to specify modes for various RPMh regulator
+ * device tree properties (e.g. regulator-initial-mode).  Each type of regulator
+ * supports a subset of the possible modes.
+ *
+ * %RPMH_REGULATOR_MODE_RET:	Retention mode in which only an extremely small
+ *				load current is allowed.  This mode is supported
+ *				by LDO and SMPS type regulators.
+ * %RPMH_REGULATOR_MODE_LPM:	Low power mode in which a small load current is
+ *				allowed.  This mode corresponds to PFM for SMPS
+ *				and BOB type regulators.  This mode is supported
+ *				by LDO, HFSMPS, BOB, and PMIC4 FTSMPS type
+ *				regulators.
+ * %RPMH_REGULATOR_MODE_AUTO:	Auto mode in which the regulator hardware
+ *				automatically switches between LPM and HPM based
+ *				upon the real-time load current.  This mode is
+ *				supported by HFSMPS, BOB, and PMIC4 FTSMPS type
+ *				regulators.
+ * %RPMH_REGULATOR_MODE_HPM:	High power mode in which the full rated current
+ *				of the regulator is allowed.  This mode
+ *				corresponds to PWM for SMPS and BOB type
+ *				regulators.  This mode is supported by all types
+ *				of regulators.
+ */
+#define RPMH_REGULATOR_MODE_RET		0
+#define RPMH_REGULATOR_MODE_LPM		1
+#define RPMH_REGULATOR_MODE_AUTO	2
+#define RPMH_REGULATOR_MODE_HPM		3
+
+#endif
-- 
2.18.0

