Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78993C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BADC208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BADC208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966188AbeFOQbb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:31:31 -0400
Received: from osg.samsung.com ([64.30.133.232]:33199 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966169AbeFOQbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:31:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id EF79822C30;
        Fri, 15 Jun 2018 09:31:24 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8hlQYy3ypJEM; Fri, 15 Jun 2018 09:31:12 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.114.220.dynamic.adsl.gvt.net.br [177.41.114.220])
        by osg.samsung.com (Postfix) with ESMTPSA id B441B22B5C;
        Fri, 15 Jun 2018 09:30:58 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fTrcm-00084o-Ld; Fri, 15 Jun 2018 13:30:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH v4 23/26] devicetree: fix a series of wrong file references
Date:   Fri, 15 Jun 2018 13:30:51 -0300
Message-Id: <266e5f874b36aa83f3327879d85921fab52d5461.1529079120.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1529079119.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As files got renamed, their references broke.

Manually fix a series of broken refs at the DT bindings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../devicetree/bindings/input/rmi4/rmi_2d_sensor.txt |  2 +-
 Documentation/devicetree/bindings/mfd/sun6i-prcm.txt |  2 +-
 .../devicetree/bindings/pci/hisilicon-pcie.txt       |  2 +-
 Documentation/devicetree/bindings/pci/kirin-pcie.txt |  2 +-
 .../devicetree/bindings/pci/pci-keystone.txt         |  4 ++--
 .../devicetree/bindings/sound/st,stm32-i2s.txt       |  2 +-
 .../devicetree/bindings/sound/st,stm32-sai.txt       |  2 +-
 MAINTAINERS                                          | 12 ++++++------
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
index f2c30c8b725d..9afffbdf6e28 100644
--- a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
@@ -12,7 +12,7 @@ Additional documentation for F11 can be found at:
 http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
 
 Optional Touch Properties:
-Description in Documentation/devicetree/bindings/input/touch
+Description in Documentation/devicetree/bindings/input/touchscreen
 - touchscreen-inverted-x
 - touchscreen-inverted-y
 - touchscreen-swapped-x-y
diff --git a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
index 4d21ffdb0fc1..daa091c2e67b 100644
--- a/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
+++ b/Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
@@ -8,7 +8,7 @@ Required properties:
  - reg: The PRCM registers range
 
 The prcm node may contain several subdevices definitions:
- - see Documentation/devicetree/clk/sunxi.txt for clock devices
+ - see Documentation/devicetree/bindings/clock/sunxi.txt for clock devices
  - see Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt for reset
    controller devices
 
diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
index 7bf9df047a1e..0dcb87d6554f 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -3,7 +3,7 @@ HiSilicon Hip05 and Hip06 PCIe host bridge DT description
 HiSilicon PCIe host controller is based on the Synopsys DesignWare PCI core.
 It shares common functions with the PCIe DesignWare core driver and inherits
 common properties defined in
-Documentation/devicetree/bindings/pci/designware-pci.txt.
+Documentation/devicetree/bindings/pci/designware-pcie.txt.
 
 Additional properties are described here:
 
diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
index 6e217c63123d..6bbe43818ad5 100644
--- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
@@ -3,7 +3,7 @@ HiSilicon Kirin SoCs PCIe host DT description
 Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
 It shares common functions with the PCIe DesignWare core driver and
 inherits common properties defined in
-Documentation/devicetree/bindings/pci/designware-pci.txt.
+Documentation/devicetree/bindings/pci/designware-pcie.txt.
 
 Additional properties are described here:
 
diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 7e05487544ed..3d4a209b0fd0 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -3,9 +3,9 @@ TI Keystone PCIe interface
 Keystone PCI host Controller is based on the Synopsys DesignWare PCI
 hardware version 3.65.  It shares common functions with the PCIe DesignWare
 core driver and inherits common properties defined in
-Documentation/devicetree/bindings/pci/designware-pci.txt
+Documentation/devicetree/bindings/pci/designware-pcie.txt
 
-Please refer to Documentation/devicetree/bindings/pci/designware-pci.txt
+Please refer to Documentation/devicetree/bindings/pci/designware-pcie.txt
 for the details of DesignWare DT bindings.  Additional properties are
 described here as well as properties that are not applicable.
 
diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt b/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
index 4bda52042402..58c341300552 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.txt
@@ -18,7 +18,7 @@ Required properties:
     See Documentation/devicetree/bindings/dma/stm32-dma.txt.
   - dma-names: Identifier for each DMA request line. Must be "tx" and "rx".
   - pinctrl-names: should contain only value "default"
-  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
+  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
 
 Optional properties:
   - resets: Reference to a reset controller asserting the reset controller
diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index f301cdf0b7e6..3a3fc506e43a 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -37,7 +37,7 @@ SAI subnodes required properties:
 	"tx": if sai sub-block is configured as playback DAI
 	"rx": if sai sub-block is configured as capture DAI
   - pinctrl-names: should contain only value "default"
-  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
+  - pinctrl-0: see Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
 
 SAI subnodes Optional properties:
   - st,sync: specify synchronization mode.
diff --git a/MAINTAINERS b/MAINTAINERS
index 783ce44b3e7a..fd3fc63f2759 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6966,7 +6966,7 @@ IIO MULTIPLEXER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
+F:	Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
 F:	drivers/iio/multiplexer/iio-mux.c
 
 IIO SUBSYSTEM AND DRIVERS
@@ -9696,7 +9696,7 @@ MXSFB DRM DRIVER
 M:	Marek Vasut <marex@denx.de>
 S:	Supported
 F:	drivers/gpu/drm/mxsfb/
-F:	Documentation/devicetree/bindings/display/mxsfb-drm.txt
+F:	Documentation/devicetree/bindings/display/mxsfb.txt
 
 MYRICOM MYRI-10G 10GbE DRIVER (MYRI10GE)
 M:	Chris Lee <christopher.lee@cspi.com>
@@ -10885,7 +10885,7 @@ M:	Will Deacon <will.deacon@arm.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/controller-generic-pci.txt
+F:	Documentation/devicetree/bindings/pci/host-generic-pci.txt
 F:	drivers/pci/controller/pci-host-common.c
 F:	drivers/pci/controller/pci-host-generic.c
 
@@ -11066,7 +11066,7 @@ M:	Xiaowei Song <songxiaowei@hisilicon.com>
 M:	Binghui Wang <wangbinghui@hisilicon.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/pcie-kirin.txt
+F:	Documentation/devicetree/bindings/pci/kirin-pcie.txt
 F:	drivers/pci/controller/dwc/pcie-kirin.c
 
 PCIE DRIVER FOR HISILICON STB
@@ -12457,7 +12457,7 @@ L:	linux-crypto@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/exynos-rng.c
-F:	Documentation/devicetree/bindings/crypto/samsung,exynos-rng4.txt
+F:	Documentation/devicetree/bindings/rng/samsung,exynos4-rng.txt
 
 SAMSUNG EXYNOS TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
 M:	Łukasz Stelmach <l.stelmach@samsung.com>
@@ -13571,7 +13571,7 @@ F:	drivers/*/stm32-*timer*
 F:	drivers/pwm/pwm-stm32*
 F:	include/linux/*/stm32-*tim*
 F:	Documentation/ABI/testing/*timer-stm32
-F:	Documentation/devicetree/bindings/*/stm32-*timer
+F:	Documentation/devicetree/bindings/*/stm32-*timer*
 F:	Documentation/devicetree/bindings/pwm/pwm-stm32*
 
 STMMAC ETHERNET DRIVER
-- 
2.17.1

