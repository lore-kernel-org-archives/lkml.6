Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1952EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B9720645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hE8ipfH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B9720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbeJICIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:08:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57566 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeJICIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0+uY4A+bkERXCxGRROCz2txr/tRKOvtYOBV+aXfjgMU=; b=hE8ipfH9xWSm
        2RbFiSmuABE70xAGkL/3ZLUqmtqueoRdltWKBaZmxxWpjYY6Hzbn1B5eydSYuN/6QrDbBdSLUqjco
        que7idh9B7o5JfaQOwUe9jYVE2lVn/JjFZ0ZqVFfUBpAkWFTx8cYAVbo2C4x07sUWivpQLDN31OkH
        EcO8k=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9agI-000347-Sm; Mon, 08 Oct 2018 18:55:02 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6BDAC440078; Mon,  8 Oct 2018 19:55:02 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     pascal paillet <p.paillet@st.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "dt-bindings: regulator: document stpmic1 pmic regulators" to the regulator tree
In-Reply-To: 
Message-Id: <20181008185502.6BDAC440078@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Oct 2018 19:55:02 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: document stpmic1 pmic regulators

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

From dbd1709f7697932c8e24883dbf6025adc9fe6ff9 Mon Sep 17 00:00:00 2001
From: pascal paillet <p.paillet@st.com>
Date: Mon, 8 Oct 2018 16:29:40 +0000
Subject: [PATCH] dt-bindings: regulator: document stpmic1 pmic regulators

The STPMIC1 regulators supply power to the application processor as well as
to the external system peripherals such as DDR, Flash memories and system
devices.

Signed-off-by: pascal paillet <p.paillet@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../regulator/st,stpmic1-regulator.txt        | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
new file mode 100644
index 000000000000..a3f476240565
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
@@ -0,0 +1,68 @@
+STMicroelectronics STPMIC1 Voltage regulators
+
+Regulator Nodes are optional depending on needs.
+
+Available Regulators in STPMIC1 device are:
+  - buck1 for Buck BUCK1
+  - buck2 for Buck BUCK2
+  - buck3 for Buck BUCK3
+  - buck4 for Buck BUCK4
+  - ldo1 for LDO LDO1
+  - ldo2 for LDO LDO2
+  - ldo3 for LDO LDO3
+  - ldo4 for LDO LDO4
+  - ldo5 for LDO LDO5
+  - ldo6 for LDO LDO6
+  - vref_ddr for LDO Vref DDR
+  - boost for Buck BOOST
+  - pwr_sw1 for VBUS_OTG switch
+  - pwr_sw2 for SW_OUT switch
+
+Switches are fixed voltage regulators with only enable/disable capability.
+
+Optional properties:
+- st,mask-reset: mask reset for this regulator: the regulator configuration
+  is maintained during pmic reset.
+- regulator-pull-down: enable high pull down
+  if not specified light pull down is used
+- regulator-over-current-protection:
+    if set, all regulators are switched off in case of over-current detection
+    on this regulator,
+    if not set, the driver only sends an over-current event.
+- interrupt-parent: phandle to the parent interrupt controller
+- interrupts: index of current limit detection interrupt
+- <regulator>-supply: phandle to the parent supply/regulator node
+	each regulator supply can be described except vref_ddr.
+
+Example:
+regulators {
+	compatible = "st,stpmic1-regulators";
+
+	ldo6-supply = <&v3v3>;
+
+	vdd_core: buck1 {
+		regulator-name = "vdd_core";
+		interrupts = <IT_CURLIM_BUCK1 0>;
+		interrupt-parent = <&pmic>;
+		st,mask-reset;
+		regulator-pull-down;
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <1200000>;
+	};
+
+	v3v3: buck4 {
+		regulator-name = "v3v3";
+		interrupts = <IT_CURLIM_BUCK4 0>;
+		interrupt-parent = <&mypmic>;
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	v1v8: ldo6 {
+		regulator-name = "v1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-over-current-protection;
+	};
+};
-- 
2.19.0

