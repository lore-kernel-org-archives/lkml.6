Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D154CC65BAB
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941A6208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941A6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeJEX6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:58:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38546 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbeJEX6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:58:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id l1so28775otj.5;
        Fri, 05 Oct 2018 09:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l099Y6jzpfQyO/xPjIXxsAls6PjdHyNSgIgLlrCYeSY=;
        b=M7z/0A5OGzgRhjudBQ2NtcDDDwA1uH3sIRcpNGIYJVrzmnDxnr45QShIkFH4U1meBG
         IHDPvChb+HRfDdZ+2KMOkHk413lQTjXBA/OuVnDYOaobpBlXjUhA5oL9Pw1D2CgSYLrr
         ldKr73SRH+KjD4TCdN88r+2+7Sdewg0rA9W57o3aWSmlXWenULCbn6Xjyxo+p0BmxatE
         eK/FGAdxBXQKvbSWK297WPRLDhPeiJkqPp+y8EDtAxLwv0iKXThBzyWB5Ny0sLe1hRu7
         kWVWvW5iNHUf6obJngLwXeULnTNvAmxX8eMWlv7qx+ZaaZOE+3hd8r2VGkfWzm3xMuZ7
         92Ag==
X-Gm-Message-State: ABuFfohQrVYtnFpNfk/1a88Y6tJ6t/hW38Nn5pwYwjUiZmaZdNJAdh9t
        saowdjg9MTGhb9B+4S2PqD0UM9lqxw==
X-Google-Smtp-Source: ACcGV62l0YQwi7Faf3P5mBf3+3h16qKtXXtISzEKvg5OrzcWIWvyS1qnLs8Yd/D7bQ2L9gRgY7gqog==
X-Received: by 2002:a9d:654a:: with SMTP id q10-v6mr3358223otl.256.1538758735840;
        Fri, 05 Oct 2018 09:58:55 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm2904328ota.75.2018.10.05.09.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 09:58:55 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc:     Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 04/36] dt-bindings: arm: fsl: Move DCFG and SCFG bindings to their own docs
Date:   Fri,  5 Oct 2018 11:58:16 -0500
Message-Id: <20181005165848.3474-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005165848.3474-1-robh@kernel.org>
References: <20181005165848.3474-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to convert board-level bindings to json-schema, move
various misc SoC bindings out to their own file.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../arm/freescale/fsl,layerscape-dcfg.txt     | 19 +++++++++
 .../arm/freescale/fsl,layerscape-scfg.txt     | 19 +++++++++
 Documentation/devicetree/bindings/arm/fsl.txt | 39 -------------------
 3 files changed, 38 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
new file mode 100644
index 000000000000..b5cb374dc47d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcfg.txt
@@ -0,0 +1,19 @@
+Freescale DCFG
+
+DCFG is the device configuration unit, that provides general purpose
+configuration and status for the device. Such as setting the secondary
+core start address and release the secondary core from holdoff and startup.
+
+Required properties:
+  - compatible: Should contain a chip-specific compatible string,
+	Chip-specific strings are of the form "fsl,<chip>-dcfg",
+	The following <chip>s are known to be supported:
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
+
+  - reg : should contain base address and length of DCFG memory-mapped registers
+
+Example:
+	dcfg: dcfg@1ee0000 {
+		compatible = "fsl,ls1021a-dcfg";
+		reg = <0x0 0x1ee0000 0x0 0x10000>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
new file mode 100644
index 000000000000..0ab67b0b216d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
@@ -0,0 +1,19 @@
+Freescale SCFG
+
+SCFG is the supplemental configuration unit, that provides SoC specific
+configuration and status registers for the chip. Such as getting PEX port
+status.
+
+Required properties:
+  - compatible: Should contain a chip-specific compatible string,
+	Chip-specific strings are of the form "fsl,<chip>-scfg",
+	The following <chip>s are known to be supported:
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
+
+  - reg: should contain base address and length of SCFG memory-mapped registers
+
+Example:
+	scfg: scfg@1570000 {
+		compatible = "fsl,ls1021a-scfg";
+		reg = <0x0 0x1570000 0x0 0x10000>;
+	};
diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 8a1baa2b9723..1e775aaa5c5b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -101,45 +101,6 @@ Freescale LS1021A Platform Device Tree Bindings
 Required root node compatible properties:
   - compatible = "fsl,ls1021a";
 
-Freescale SoC-specific Device Tree Bindings
--------------------------------------------
-
-Freescale SCFG
-  SCFG is the supplemental configuration unit, that provides SoC specific
-configuration and status registers for the chip. Such as getting PEX port
-status.
-  Required properties:
-  - compatible: Should contain a chip-specific compatible string,
-	Chip-specific strings are of the form "fsl,<chip>-scfg",
-	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
-
-  - reg: should contain base address and length of SCFG memory-mapped registers
-
-Example:
-	scfg: scfg@1570000 {
-		compatible = "fsl,ls1021a-scfg";
-		reg = <0x0 0x1570000 0x0 0x10000>;
-	};
-
-Freescale DCFG
-  DCFG is the device configuration unit, that provides general purpose
-configuration and status for the device. Such as setting the secondary
-core start address and release the secondary core from holdoff and startup.
-  Required properties:
-  - compatible: Should contain a chip-specific compatible string,
-	Chip-specific strings are of the form "fsl,<chip>-dcfg",
-	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
-
-  - reg : should contain base address and length of DCFG memory-mapped registers
-
-Example:
-	dcfg: dcfg@1ee0000 {
-		compatible = "fsl,ls1021a-dcfg";
-		reg = <0x0 0x1ee0000 0x0 0x10000>;
-	};
-
 Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
 ----------------------------------------------------------------
 
-- 
2.17.1

