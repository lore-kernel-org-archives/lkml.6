Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A2720658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPt1NDz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A2720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeICNPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:15:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34320 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeICNPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:15:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so8426721pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RP2dGVi+GSbhLrin1RGeUIkqc6qmpzko54taxrj7LGQ=;
        b=GPt1NDz8GX1mmOkqk/R2MZZz7/G8K9x6yGjldgOGHi1Oxzuyy05ppv0JGCTusil+iI
         bBAx5qEuEtZi1C+eEglRw/HDRoqGW+b0TGrwtbPZcbs6YI4yRcY44PqscaU6enI6rSQG
         66iWtJwmkFZgvzMPM+nt9V2r/5VW1NirZwYAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RP2dGVi+GSbhLrin1RGeUIkqc6qmpzko54taxrj7LGQ=;
        b=IWG0VMenaaW9SsnlwOvvtSTQAlTyK88AKXGMAO6SuAR/kFFP9NM52kjGdd8BF3CcWH
         /a246gID5JGa8vm7ss6Uth3pGCnSpk4oB1P8YD6D93iDv4kFvPyDtSmaMSAB7DZ4/iNO
         ly67w14uqjHiEj4Lc6j5BN5VC3T2kXHl79rzXFzp4Degs0qlw6Ta+DmvkKfBH6YKOEkj
         LwYc5pL8nZ/g1zN+81t5I/KZcfIyMXob/4ns0PB+GWRDAVJ+xxLrTQsJ18Cs7LHU8B7Z
         vsHUUyHpOAC9E+t7Gp+oDDA9LPVyuz+CwsJQuMmLWIiTwxGA9gDWp8b2B5/wVsI/cyNH
         uV6g==
X-Gm-Message-State: APzg51DPQznhu+rG7qtasmO4hVkQFTKFu+0ZS2GquWrY9kxyqZWrLPSj
        cqpjSdjXnrrmUsTaVRO0Pd2TRw==
X-Google-Smtp-Source: ANB0VdbpGulqbnehFFV3/6x7+zuEiGluEPLjIfnulCvVkK2Gmcm1GKXcDcGppcxvofGp/Ja4HYoxTA==
X-Received: by 2002:aa7:86cb:: with SMTP id h11-v6mr28075561pfo.58.1535964964007;
        Mon, 03 Sep 2018 01:56:04 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 87-v6sm30984814pfn.103.2018.09.03.01.56.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 01:56:03 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, krzk@kernel.org
Subject: [PATCH v2 1/2] dt-bindings: power: Add Spreadtrum SC2731 charger documentation
Date:   Mon,  3 Sep 2018 16:55:45 +0800
Message-Id: <a582871f84c4dd588ae1651d1d9192cc80e2b272.1535964281.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for Spreadtrum SC2731 charger
device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Add parent node.
 - Add some battery standard properties.
---
 .../bindings/power/supply/sc2731_charger.txt       |   40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
new file mode 100644
index 0000000..5266fab
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
@@ -0,0 +1,40 @@
+Spreadtrum SC2731 PMIC battery charger binding
+
+Required properties:
+ - compatible: Should be "sprd,sc2731-charger".
+ - reg: Address offset of charger register.
+ - phys: Contains a phandle to the USB phy.
+
+Optional Properties:
+- monitored-battery: phandle of battery characteristics devicetree node.
+  The charger uses the following battery properties:
+- charge-term-current-microamp: current for charge termination phase.
+- constant-charge-voltage-max-microvolt: maximum constant input voltage.
+  See Documentation/devicetree/bindings/power/supply/battery.txt
+
+Example:
+
+	bat: battery {
+		compatible = "simple-battery";
+		charge-term-current-microamp = <120000>;
+		constant-charge-voltage-max-microvolt = <4350000>;
+		......
+	};
+
+	sc2731_pmic: pmic@0 {
+		compatible = "sprd,sc2731";
+		reg = <0>;
+		spi-max-frequency = <26000000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		charger@0 {
+			compatible = "sprd,sc2731-charger";
+			reg = <0x0>;
+			phys = <&ssphy>;
+			monitored-battery = <&bat>;
+		};
+	};
-- 
1.7.9.5

