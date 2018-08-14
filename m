Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA39C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD00A215FA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD00A215FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbeHNVT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:19:28 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:52404 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728693AbeHNVT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:19:27 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w7EHxDZA016038;
        Tue, 14 Aug 2018 20:59:13 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20088)
        id 70A1963171; Tue, 14 Aug 2018 21:29:12 +0300 (IDT)
From:   Tali Perry <tali.perry1@gmail.com>
To:     tali.perry1@gmail.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        venture@google.com, yuenn@google.com, brendanhiggins@google.com,
        robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, arnd@arndb.de, wsa@the-dreams.de,
        andriy.shevchenko@linux.intel.com, pierre-yves.mordret@st.com,
        cedric.madianga@gmail.com, baolin.wang@spreadtrum.com,
        jarkko.nikula@linux.intel.com, hdegoede@redhat.com,
        rmk+kernel@armlinux.org.uk, ard.biesheuvel@linaro.org,
        thor.thayer@linux.intel.com, geert@linux-m68k.org,
        heikki.krogerus@linux.intel.com, tglx@linutronix.de
Cc:     linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: i2c: npcm7xx: add binding for i2c controller
Date:   Tue, 14 Aug 2018 21:29:06 +0300
Message-Id: <20180814182907.182139-2-tali.perry1@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180814182907.182139-1-tali.perry1@gmail.com>
References: <20180814182907.182139-1-tali.perry1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nuvoton NPCM7XX I2C Controller
NPCM7xx includes 16 I2C contollers. This driver operates the controller.
This module also includes a slave mode, which will be submitted later on.

Any feedback would be appreciated.  

v3 -> v2:
	- fix dt binding: compatible name: ommit "bus"

v2 -> v1:
	- run check patch in strict mode.
	- use linux crc.
	- define regs in constant offset without base.
	- remove debug prints.
	- no declerations for local functions.
	
v1: initial version

Signed-off-by: Tali Perry <tali.perry1@gmail.com>

---
 .../devicetree/bindings/i2c/i2c-npcm7xx.txt        | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
new file mode 100644
index 000000000000..2a474a2a5b3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
@@ -0,0 +1,29 @@
+Nuvoton NPCM7XX I2C bus
+
+The NPCM750x includes sixteen I2C bus controllers. All Conterollers support
+both master and slave mode. Each controller has two 16 byte HW FIFO for TX and
+RX.
+
+Required properties:
+- compatible      : must be "nuvoton,npcm750-i2c"
+- reg             : Offset and length of the register set for the device.
+- interrupts      : Contain the I2C interrupt with flags for falling edge.
+- clocks          : phandle of I2C reference clock.
+
+Optional:
+- bus-frequency   : Contain the I2C bus frequency,
+			the default I2C bus frequency is 100000.
+- pinctrl-0       : must be <&smbX_pins>, X is module number
+			(on NPCM7XX it's 0 to 15)
+- pinctrl-names   : should be set to "default"
+Example:
+
+	i2c0: i2c@80000 {
+		compatible = "nuvoton,npcm750-i2c";
+		reg = <0x80000 0x1000>;
+		clocks = <&clk NPCM7XX_CLK_APB2>;
+		bus-frequency = <100000>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&smb0_pins>;
+	};
-- 
2.14.1

