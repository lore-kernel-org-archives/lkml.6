Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9334C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C86723FAC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dlHJw113";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AiMTuGTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C86723FAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeGEVqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:46:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60454 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753363AbeGEVqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:46:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC91860B25; Thu,  5 Jul 2018 21:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530827210;
        bh=4XDknn71TJXEbdJUQWahem0nfth96H3hrm5HRpkV18I=;
        h=From:To:Cc:Subject:Date:From;
        b=dlHJw113cKxhJoXszKnnVwz3ltjBC22KMqWO+wSk6NDBl/Jd7uVuaXTWPy0ib+RKb
         liBd/Tj24k3tiVJih/KS44RgQb9S/ZUKoZ51I+4AO3kC0HcKsW7hhwnYHde2s2ilcW
         eUcUFVivGEh/2Roj+afS0/zdZfwPFpeTN8A321A4=
Received: from girishm-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: girishm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE9CA60251;
        Thu,  5 Jul 2018 21:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530827209;
        bh=4XDknn71TJXEbdJUQWahem0nfth96H3hrm5HRpkV18I=;
        h=From:To:Cc:Subject:Date:From;
        b=AiMTuGTOu6La/MCITJjuauNhOPHblUtN/+wfx+7+X+541+/8fEyHYqj7VCXCqGPJn
         vJlGkeKxD+WMTl1wGwasdSUWEeBjRCDsk14B04QbTwqFg9mi9Ht9uxAFs2w6JJoaFo
         c1+5/1ZurVYK0xc714L+ZGcJr9yGXgn377h1oP/U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE9CA60251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=girishm@codeaurora.org
From:   Girish Mahadevan <girishm@codeaurora.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Girish Mahadevan <girishm@codeaurora.org>, dianders@chromium.org,
        swboyd@chromium.org, sdharia@codeaurora.org,
        kramasub@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date:   Thu,  5 Jul 2018 15:46:41 -0600
Message-Id: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
---
 .../devicetree/bindings/spi/qcom,spi-qcom-qspi.txt | 36 ++++++++++++++++++++++
 err.txt                                            | 27 ----------------
 2 files changed, 36 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
 delete mode 100644 err.txt

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
new file mode 100644
index 0000000..3baa893
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
@@ -0,0 +1,36 @@
+QTI [Qualcomm Technologies Inc] Quad Serial Peripheral Interface (QSPI)
+
+QSPI [Quad Serial Peripheral Interface] allows single dual and quad read/write
+access to slaves. QTI's QSPI controller implements the QSPI protocol to interface
+with slaves like NOR Flash devices.
+
+Required properties:
+- compatible:	Should contain:
+		"qcom,qspi-v1"
+- reg:		Contains the base register location and length
+- interrupts:	Interrupt number used by the controller.
+- clocks:	Contains the core and AHB clock names.
+- clock-names:	"core" for core clock and "iface" for AHB clock.
+- spi-max-frequency:	Maximum SPI core clock frequency in Hz.
+
+SPI slave nodes must be children of the SPI master node and can contain
+properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+
+	qspi: qspi@7418000 {
+		compatible = "qcom,qspi-v1";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x7418000 0x600>;
+		interrupts = <0 459 0>;
+		clock-names = "iface", "core";
+		clocks = <&clock_gcc clk_gcc_qspi_ahb_clk>,
+			 <&clock_gcc clk_gcc_qspi_ser_clk>;
+
+		device@0 {
+			compatible = "dummy_device";
+			reg = <x>; /* CS for the device */
+			spi-max-frequency = <f>; /* Max supported frequency of the slave (Hz) */
+		};
+	};
diff --git a/err.txt b/err.txt
deleted file mode 100644
index 09000e4..0000000
--- a/err.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Skipping hidl generation
-arch/arm64/Makefile:23: ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum
-arch/arm64/Makefile:44: Detected assembler with broken .inst; disassembly will be unreliable
-  CHK     include/config/kernel.release
-  CHK     include/generated/uapi/linux/version.h
-  CHK     include/generated/utsrelease.h
-  CHK     include/generated/bounds.h
-  CHK     include/generated/timeconst.h
-  CHK     include/generated/asm-offsets.h
-  CALL    scripts/checksyscalls.sh
-  CHK     scripts/mod/devicetable-offsets.h
-  CHK     include/generated/compile.h
-  CHK     kernel/config_data.h
-  CC      drivers/mtd/devices/m25p80.o
-  AR      drivers/mtd/devices/built-in.o
-  AR      drivers/mtd/built-in.o
-  CC      drivers/spi/spi-mem.o
-drivers/spi/spi-mem.c:12:23: fatal error: internals.h: No such file or directory
- #include "internals.h"
-                       ^
-compilation terminated.
-make[2]: *** [drivers/spi/spi-mem.o] Error 1
-make[1]: *** [drivers/spi] Error 2
-make: *** [drivers] Error 2
-
-[0;31m#### failed to build some targets (12 seconds) ####[00m
-
-- 
1.9.1

