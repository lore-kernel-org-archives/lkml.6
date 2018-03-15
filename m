Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-124355-1521114072-2-7407978693565134006
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521114071; b=EpxdMO9Xsl3f3SdXwOVIxddkHHpKYPvSfw8jJe3SqUI3aFk
    DxSKupCNhc/AsepLLTNKkVIfwdJ7U8fRIMeE/JY9h3OIh5klgsZ/JMaNo2wBOZV1
    9ckUuhPDSiyFFM/BORsWi9hvdgydNEE0d201hGzAia4bVGXrihkj+5fPGMhZimP7
    CH5cCk6r6TL4+yYNSy2FhJHhU7Actn/HrWkyCT5ZAk5r7gFuNuexf6V64XqE5uN4
    D6eWqaPW+EACPHRgXr8uhmVqEzdfsvakBZZugk/t7mxzScpGBXs+XglT//cuP4N/
    6RoTTAjmvdCQjvj1mxzGWdIbbbBKcZoeUE5iS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521114071;
    bh=nvOzI6ENwyGcTb5Q4xjvIfYbrRuxevuG019PsuXpjKc=; b=A0U02F0jHwt2
    A3Ix2JyFlequ/LweynsiJyczwX91XcjEVyWmFp91OkG5U9Kt96d9VOwyNCOa1yPc
    bqGry9/Z+v6ZXssTbL5BhOFNjMEms1oCKmbcuY+SJpilT6NwkOG5dRNjQDHQmizN
    KLKUfI2xpbypJr1Ez7VV4+15U4nWqS6lGBG3OUD2OGF9j7G/+Lfze2CNpnNYU1rr
    py8GYR1Acpy7jknyVQGOHMj0Bvdpvgj0VriRoJoJuX+lGkxFRdpuPa3Me8MYkL3K
    EnPFdThNmgMDZ1nrNBbIx3vWa3ec5zgZwLNS3el2kfxAt6br51tjVDmwqL9a5bqa
    inBmZ133/A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=oxnQ0VWu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=oxnQ0VWu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeCOLky (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 07:40:54 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:32521 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbeCOLku (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 07:40:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w2FBe0AV027015
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] usb: dwc3: add clock and resets
Date: Thu, 15 Mar 2018 20:39:58 +0900
Message-Id: <1521113998-25052-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521113998-25052-1-git-send-email-yamada.masahiro@socionext.com>
References: <1521113998-25052-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

dwc3-of-simple.c only handles arbitrary number of clocks and resets.
They are both generic enough to be put into the dwc3 core.  For simple
cases, a nested node structure like follows:

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

would be turned into a single node:

  dwc3 {
          compatible = "foo,dwc3", "snps,dwc3";
          clocks = ...;
          resets = ...;
          ...
  }

I inserted reset_control_deassert() and clk_enable() before the first
register access, i.e. dwc3_cache_hwparams().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Documentation/devicetree/bindings/usb/dwc3.txt |   2 +
 drivers/usb/dwc3/core.c                        | 127 ++++++++++++++++++++++++-
 drivers/usb/dwc3/core.h                        |   5 +
 3 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 44e8bab..67e9cfb 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -9,12 +9,14 @@ Required properties:
  - interrupts: Interrupts used by the dwc3 controller.
 
 Optional properties:
+ - clocks: list of phandle and clock specifier pairs
  - usb-phy : array of phandle for the PHY device.  The first element
    in the array is expected to be a handle to the USB2/HS PHY and
    the second element is expected to be a handle to the USB3/SS PHY
  - phys: from the *Generic PHY* bindings
  - phy-names: from the *Generic PHY* bindings; supported names are "usb2-phy"
 	or "usb3-phy".
+ - resets: list of phandle and reset specifier pairs
  - snps,usb3_lpm_capable: determines if platform is USB3 LPM capable
  - snps,disable_scramble_quirk: true when SW should disable data scrambling.
 	Only really useful for FPGA builds.
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e9083a3..f17e4a9 100644
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
@@ -240,6 +242,74 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	return -ETIMEDOUT;
 }
 
+static int dwc3_core_get_clks(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	struct device_node *node = dev->of_node;
+	struct clk *clk;
+	int num_clks, i;
+
+	num_clks = of_count_phandle_with_args(node, "clocks", "#clock-cells");
+	if (num_clks <= 0)
+		return 0;
+
+	dwc->num_clks = num_clks;
+
+	dwc->clks = devm_kcalloc(dev, num_clks, sizeof(*dwc->clks), GFP_KERNEL);
+	if (!dwc->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < num_clks; i++) {
+		clk = of_clk_get(node, i);
+		if (IS_ERR(clk))
+			goto put_clks;
+		dwc->clks[i] = clk;
+	}
+
+	return 0;
+
+put_clks:
+	while (--i >= 0)
+		clk_put(dwc->clks[i]);
+
+	return PTR_ERR(clk);
+}
+
+static void dwc3_core_put_clks(struct dwc3 *dwc)
+{
+	int i;
+
+	for (i = dwc->num_clks - 1; i >= 0; i--)
+		clk_put(dwc->clks[i]);
+}
+
+static int dwc3_core_enable_clks(struct dwc3 *dwc)
+{
+	int ret, i;
+
+	for (i = 0; i < dwc->num_clks; i++) {
+		ret = clk_prepare_enable(dwc->clks[i]);
+		if (ret)
+			goto disable_clks;
+	}
+
+	return 0;
+
+disable_clks:
+	while (--i >= 0)
+		clk_disable_unprepare(dwc->clks[i]);
+
+	return ret;
+}
+
+static void dwc3_core_disable_clks(struct dwc3 *dwc)
+{
+	int i;
+
+	for (i = dwc->num_clks - 1; i >= 0; i--)
+		clk_disable_unprepare(dwc->clks[i]);
+}
+
 /*
  * dwc3_frame_length_adjustment - Adjusts frame length if required
  * @dwc3: Pointer to our controller context structure
@@ -641,6 +711,8 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
+	dwc3_core_disable_clks(dwc);
+	reset_control_assert(dwc->resets);
 }
 
 static bool dwc3_core_is_valid(struct dwc3 *dwc)
@@ -1205,6 +1277,22 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	dwc->resets = devm_reset_control_array_get_optional_shared(dev);
+	if (IS_ERR(dwc->resets))
+		return PTR_ERR(dwc->resets);
+
+	ret = dwc3_core_get_clks(dwc);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(dwc->resets);
+	if (ret)
+		goto put_clks;
+
+	ret = dwc3_core_enable_clks(dwc);
+	if (ret)
+		goto assert_resets;
+
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
 
@@ -1268,6 +1356,14 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	dwc3_core_disable_clks(dwc);
+
+assert_resets:
+	reset_control_assert(dwc->resets);
+
+put_clks:
+	dwc3_core_put_clks(dwc);
+
 	return ret;
 }
 
@@ -1289,11 +1385,38 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	dwc3_free_event_buffers(dwc);
 	dwc3_free_scratch_buffers(dwc);
+	dwc3_core_put_clks(dwc);
 
 	return 0;
 }
 
 #ifdef CONFIG_PM
+static int dwc3_core_init_for_resume(struct dwc3 *dwc)
+{
+	int ret;
+
+	ret = reset_control_deassert(dwc->resets);
+	if (ret)
+		return ret;
+
+	ret = dwc3_core_enable_clks(dwc);
+	if (ret)
+		goto assert_resets;
+
+	ret = dwc3_core_init(dwc);
+	if (ret)
+		goto disable_clks;
+
+	return 0;
+
+disable_clks:
+	dwc3_core_disable_clks(dwc);
+assert_resets:
+	reset_control_assert(dwc->resets);
+
+	return ret;
+}
+
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
@@ -1325,7 +1448,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
-		ret = dwc3_core_init(dwc);
+		ret = dwc3_core_init_for_resume(dwc);
 		if (ret)
 			return ret;
 
@@ -1336,7 +1459,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 	case DWC3_GCTL_PRTCAP_HOST:
 		/* nothing to do on host runtime_resume */
 		if (!PMSG_IS_AUTO(msg)) {
-			ret = dwc3_core_init(dwc);
+			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 860d2bc..14cd335 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -891,6 +891,11 @@ struct dwc3 {
 	struct usb_gadget	gadget;
 	struct usb_gadget_driver *gadget_driver;
 
+	struct clk		**clks;
+	int			num_clks;
+
+	struct reset_control	*resets;
+
 	struct usb_phy		*usb2_phy;
 	struct usb_phy		*usb3_phy;
 
-- 
2.7.4

