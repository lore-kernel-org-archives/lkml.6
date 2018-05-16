Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3657551-1526438689-2-12573287966142882671
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526438688; b=Y/cgXHIqetidijn0Gff8rb1YXb7hLuzi8MLVuYAA5eoEMfH8LA
    KAfuAtRZOlbrILItUlpwx4HhEkhIZ8ovKsAwOvq4hy/tZmMY2O2s6wAIcbqShrq/
    CUfj+8KU5n+A7VN+YN8u3zdPWH4oEHTkNguR5bql2tVa69OKZN6GiwMDjUVVB7gV
    67hG7mSBxlOSzGOXDL4IF/e65PWhaSuSyKTTn83GHPBVt6w05U7atxbGXQBUHpe0
    Vq0mcWRmeYk+ZhJjOa/nYe3nR9mWU71RroAU6JQRKLfc0DBB4LRBF0yGFR+VBZc7
    p8YhQaQaw47fdwSDSS/qXURswmifGKUsB3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526438688; bh=
    pk56xbuSeCXQXBKRPxwb0mYLy21Hti8/mYkuN0yrQS4=; b=Kkd/6RYFSCY/uNVr
    2/P1iAb09o9W1bhW5Fsd5/s0ZUrrwKXovu18RorWKptFtQC06dzxEIs4P2BqVYfw
    Rtcbhw/vSVmjcjyrzMc5XU/Lbcs8VMy+h8+2scagnzcnOX680vGV+MfhuhlP5/+n
    DmY4JymK+IaiNtk/4ZB4FR5QgbqqvvL6YoCVbJniA70hS5DkYoptyOw2v4diFlZ4
    aD+qwtnQhHMPo365MLtG2+ixL2ewyWTBbcxYzOzM1zZ7EWVwz4vx6bQH/lEeIDHN
    BaIPZufA2nIEV1EDDpxK1xYFOU0WxN3/+PfDg6/CkmbkMoFyIHIHVVJQU9QRoRbC
    tlJKog==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=nifty.com header.i=@nifty.com header.b=1jBNvEH8 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=socionext.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=nifty.com header.i=@nifty.com header.b=1jBNvEH8 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=socionext.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGsqXnAvEgsznTVKKJhfl+0MNjvZ7PmNLwEgm2FBkg+pu4VZvtBlIm7YvrT7vhAZIajp+gv5SmjuTNtdo4apx35ZFLc7rd6nNH70osawMgEUsHU4+V5H
    oM+vr9UbVh0odRTD5VaNBeMSyI/gFgL6yZFFth3APROLJqTCDqDyNYe00XElRUVbW5QYOxNkSBQAvE6Enli3a8jYMgGCouLkfPpaUZsiF/hf5apCa33k3N6n
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=c-n4J4-pAAAA:8 a=TSdrFi7nXcyS8vPrvVQA:9 a=BwHGZC6rLwwXHa9P:21
    a=FmXrqFTY4mVUHiXF:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeEPCoq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 22:44:46 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:39374 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeEPCoT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 22:44:19 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w4G2h6cB023234
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 2/2] usb: dwc3: support clocks and resets for DWC3 core
Date: Wed, 16 May 2018 11:41:07 +0900
Message-Id: <1526438467-12470-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526438467-12470-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526438467-12470-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Historically, the clocks and resets are handled on the glue layer
side instead of the DWC3 core.  For simple cases, dwc3-of-simple.c
takes care of arbitrary number of clocks and resets.  The DT node
structure typically looks like as follows:

  dwc3-glue {
          compatible = "foo,dwc3";
          clocks = ...;
          resets = ...;
          ...

          dwc3 {
                  compatible = "snps,dwc3";
                  ...
          };
  }

By supporting the clocks and the reset in the dwc3/core.c, it will
be turned into a single node:

  dwc3 {
          compatible = "foo,dwc3", "snps,dwc3";
          clocks = ...;
          resets = ...;
          ...
  }

This commit adds the binding of clocks and resets specific to this IP.
The number of clocks should generally be the same across SoCs, it is
just some SoCs either tie clocks together or do not provide software
control of some of the clocks.

I took the clock names from the Synopsys datasheet: "ref" (ref_clk),
"bus_early" (bus_clk_early), and "suspend" (suspend_clk).

I found only one reset line in the datasheet, hence the reset-names
property is omitted.

Those clocks are required for new platforms.  Enforcing the new
binding breaks existing platforms since they specify clocks (and
resets) in their glue layer node, but nothing in the core node.
I listed such exceptional cases in the DT binding.  The driver
code has been relaxed to accept no clock.  This change is based
on the discussion [1].

I inserted reset_control_deassert() and clk_bulk_enable() before the
first register access, i.e. dwc3_cache_hwparams().

[1] https://patchwork.kernel.org/patch/10284265/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3:
  - Change 'resets' DT property to optional.

Changes in v2:
  - Make clocks specific to this IP based on Synopsys datasheet
  - Use clk_bulk API
  - Add description to struct header

 Documentation/devicetree/bindings/usb/dwc3.txt | 21 ++++++
 drivers/usb/dwc3/core.c                        | 88 +++++++++++++++++++++++++-
 drivers/usb/dwc3/core.h                        |  8 +++
 3 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 0dbd308..7f13ebe 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -7,6 +7,26 @@ Required properties:
  - compatible: must be "snps,dwc3"
  - reg : Address and length of the register set for the device
  - interrupts: Interrupts used by the dwc3 controller.
+ - clock-names: should contain "ref", "bus_early", "suspend"
+ - clocks: list of phandle and clock specifier pairs corresponding to
+           entries in the clock-names property.
+
+Exception for clocks:
+  clocks are optional if the parent node (i.e. glue-layer) is compatible to
+  one of the following:
+    "amlogic,meson-axg-dwc3"
+    "amlogic,meson-gxl-dwc3"
+    "cavium,octeon-7130-usb-uctl"
+    "qcom,dwc3"
+    "samsung,exynos5250-dwusb3"
+    "samsung,exynos7-dwusb3"
+    "sprd,sc9860-dwc3"
+    "st,stih407-dwc3"
+    "ti,am437x-dwc3"
+    "ti,dwc3"
+    "ti,keystone-dwc3"
+    "rockchip,rk3399-dwc3"
+    "xlnx,zynqmp-dwc3"
 
 Optional properties:
  - usb-phy : array of phandle for the PHY device.  The first element
@@ -15,6 +35,7 @@ Optional properties:
  - phys: from the *Generic PHY* bindings
  - phy-names: from the *Generic PHY* bindings; supported names are "usb2-phy"
 	or "usb3-phy".
+ - resets: a single pair of phandle and reset specifier
  - snps,usb3_lpm_capable: determines if platform is USB3 LPM capable
  - snps,disable_scramble_quirk: true when SW should disable data scrambling.
 	Only really useful for FPGA builds.
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8e66edd..0380a85 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -8,6 +8,7 @@
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
+#include <linux/clk.h>
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -24,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/reset.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -266,6 +268,12 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	return 0;
 }
 
+static const struct clk_bulk_data dwc3_core_clks[] = {
+	{ .id = "ref" },
+	{ .id = "bus_early" },
+	{ .id = "suspend" },
+};
+
 /*
  * dwc3_frame_length_adjustment - Adjusts frame length if required
  * @dwc3: Pointer to our controller context structure
@@ -667,6 +675,9 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
+	clk_bulk_disable(dwc->num_clks, dwc->clks);
+	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+	reset_control_assert(dwc->reset);
 }
 
 static bool dwc3_core_is_valid(struct dwc3 *dwc)
@@ -1256,6 +1267,12 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (!dwc)
 		return -ENOMEM;
 
+	dwc->clks = devm_kmemdup(dev, dwc3_core_clks, sizeof(dwc3_core_clks),
+				 GFP_KERNEL);
+	if (!dwc->clks)
+		return -ENOMEM;
+
+	dwc->num_clks = ARRAY_SIZE(dwc3_core_clks);
 	dwc->dev = dev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1286,6 +1303,32 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	dwc->reset = devm_reset_control_get_optional_shared(dev, NULL);
+	if (IS_ERR(dwc->reset))
+		return PTR_ERR(dwc->reset);
+
+	ret = clk_bulk_get(dev, dwc->num_clks, dwc->clks);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	/*
+	 * Clocks are optional, but new DT platforms should support all clocks
+	 * as required by the DT-binding.
+	 */
+	if (ret)
+		dwc->num_clks = 0;
+
+	ret = reset_control_deassert(dwc->reset);
+	if (ret)
+		goto put_clks;
+
+	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
+	if (ret)
+		goto assert_reset;
+
+	ret = clk_bulk_enable(dwc->num_clks, dwc->clks);
+	if (ret)
+		goto unprepare_clks;
+
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
 
@@ -1349,6 +1392,14 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	clk_bulk_disable(dwc->num_clks, dwc->clks);
+unprepare_clks:
+	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+assert_reset:
+	reset_control_assert(dwc->reset);
+put_clks:
+	clk_bulk_put(dwc->num_clks, dwc->clks);
+
 	return ret;
 }
 
@@ -1370,11 +1421,44 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	dwc3_free_event_buffers(dwc);
 	dwc3_free_scratch_buffers(dwc);
+	clk_bulk_put(dwc->num_clks, dwc->clks);
 
 	return 0;
 }
 
 #ifdef CONFIG_PM
+static int dwc3_core_init_for_resume(struct dwc3 *dwc)
+{
+	int ret;
+
+	ret = reset_control_deassert(dwc->reset);
+	if (ret)
+		return ret;
+
+	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
+	if (ret)
+		goto assert_reset;
+
+	ret = clk_bulk_enable(dwc->num_clks, dwc->clks);
+	if (ret)
+		goto unprepare_clks;
+
+	ret = dwc3_core_init(dwc);
+	if (ret)
+		goto disable_clks;
+
+	return 0;
+
+disable_clks:
+	clk_bulk_disable(dwc->num_clks, dwc->clks);
+unprepare_clks:
+	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+assert_reset:
+	reset_control_assert(dwc->reset);
+
+	return ret;
+}
+
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
@@ -1420,7 +1504,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
-		ret = dwc3_core_init(dwc);
+		ret = dwc3_core_init_for_resume(dwc);
 		if (ret)
 			return ret;
 
@@ -1432,7 +1516,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_HOST:
 		/* nothing to do on host runtime_resume */
 		if (!PMSG_IS_AUTO(msg)) {
-			ret = dwc3_core_init(dwc);
+			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
 			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4f3b438..1765e01 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -891,6 +891,9 @@ struct dwc3_scratchpad_array {
  * @eps: endpoint array
  * @gadget: device side representation of the peripheral controller
  * @gadget_driver: pointer to the gadget driver
+ * @clks: array of clocks
+ * @num_clks: number of clocks
+ * @reset: reset control
  * @regs: base address for our registers
  * @regs_size: address space size
  * @fladj: frame length adjustment
@@ -1013,6 +1016,11 @@ struct dwc3 {
 	struct usb_gadget	gadget;
 	struct usb_gadget_driver *gadget_driver;
 
+	struct clk_bulk_data	*clks;
+	int			num_clks;
+
+	struct reset_control	*reset;
+
 	struct usb_phy		*usb2_phy;
 	struct usb_phy		*usb3_phy;
 
-- 
2.7.4

