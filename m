Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2290092-1523319420-2-139855589299730397
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523319419; b=SBoqEF8udrrR0xUMOPiIPTz7DZbIBhq+t2WGpkYThpJEkTgAHy
    oPraxERWUSSY+2rHgZCXHVNoWy7LuBGQ15jRmlcK/95FF4xyMO6reseNdBhCeGSF
    y2bRYxY0PuxqaQH+/SmOe9fK+4gUBqLejKGekoASvyfJIgPI2lbH/lcLetDg+RF1
    Lj06RIWF7jNJ85brVQ0occluBjMx2y0Fv87yc/dEvCex3tcRcbKTJurhcVA5A03T
    V1UdoC43fXfy4+oy1yAD5S0v7CFnyuJQ5GdF/gTLeRoMI+dfjF6lV/PjDIxJhcjy
    puI4fAoiF8PjYglBaiF835S8Ho5SuZN/1ONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1523319419;
    bh=yFu/TsOey/q86fnaNskqzuMjGGZyl8jh22cHbty0YQA=; b=mFaBeXBDAyGz
    dOw4km3Mc6OVPgApQeCFzyW88rDC70jKYOoxKBwIfTPxDcgo8w+bHi8qYD60kQRy
    YqwfjIf0Vhw3MncPZALoMDLDWDTuCgY1RsLFEoMvH2xk1apFXn3S+FUAWjDb90N4
    OiXtuV7rFfIzp+nYQ0gvVZVuGSWl1v4VWObZa6FBRL6sfhgEEE1cNoiAbDb7hA6s
    VCwmLkuq+MJPDJavS0L99osgT+vwf357fVuNXNuD6J/TGrj3z+yD5nHlEHQjtamt
    qGwdPiidxNQ/n/Bvah1zZU0xPEjuZ0kqIS+ecrwhlYnyI49YeKTziD9Nx9KSNsxz
    rKihuuxrOA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ziemianowicz.com header.i=marcin@ziemianowicz.com header.b=e5cw6ZZC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=somekey;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziemianowicz.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ziemianowicz.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ziemianowicz.com header.i=marcin@ziemianowicz.com header.b=e5cw6ZZC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=somekey;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziemianowicz.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ziemianowicz.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEepVhLxxdbinS8SeTZhI8B8WWpZDNW+nhj/J02JDEvVFw81l8m0YBy6jy7dmp3QZcyokjfFflJTaKdet5IoCQQRS5s97HT/DO8Ash3tXuaM1h9ZeDBp
    5oCu+hYupNEuOVAktGtrz3Nc63vRWBJqrjE4LFjZFE3grmqCJjahZYcYxU3uY/r8Vwov2+e5lQtQtAVQjngGf3u7kV5X+1aPSuE00lrHvt7x5ZMIX5D3Nn0h
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=0AA9OZvs-ncA:10 a=b5HTAggMAAAA:8 a=VwQbUJbxAAAA:8 a=XN969sRQUV09gaMv_-gA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=zfgeMz1PSwFLVvhDL7gT:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeDJAQp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 20:16:45 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21342 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeDJAQo (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 9 Apr 2018 20:16:44 -0400
Date: Mon, 9 Apr 2018 20:16:21 -0400
From: Marcin Ziemianowicz <marcin@ziemianowicz.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 1/2] clk: at91: Added more information logging.
Message-ID: <20180410001621.GA62230@hak8or>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ZohoMailClient: External
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I noticed that when debugging some USB clocking issue that there weren't
many ways to tell what the state of the USB clocking system was. This
adds a few logging statements to see what the relevant code is trying to
do.

Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
---
 drivers/clk/at91/clk-pll.c   |  6 +++++-
 drivers/clk/at91/clk-usb.c   | 10 ++++++++--
 drivers/usb/host/ohci-at91.c | 16 ++++++++++------
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 7d3223fc7161..534961766ae5 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -133,6 +133,7 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_pll *pll = to_clk_pll(hw);
 	unsigned int pllr;
+	unsigned long recalcedrate;
 	u16 mul;
 	u8 div;
 
@@ -144,7 +145,10 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
 	if (!div || !mul)
 		return 0;
 
-	return (parent_rate / div) * (mul + 1);
+	recalcedrate = (parent_rate / div) * (mul + 1);
+	pr_debug("clk-pll: calculating new rate, (%lu hz / %u) * %u = %lu hz\n",
+		parent_rate, div, mul, recalcedrate);
+	return recalcedrate;
 }
 
 static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 791770a563fc..2fa877e99bac 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -48,11 +48,15 @@ static unsigned long at91sam9x5_clk_usb_recalc_rate(struct clk_hw *hw,
 	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
 	unsigned int usbr;
 	u8 usbdiv;
+	unsigned int calcdclock;
 
 	regmap_read(usb->regmap, AT91_PMC_USB, &usbr);
 	usbdiv = (usbr & AT91_PMC_OHCIUSBDIV) >> SAM9X5_USB_DIV_SHIFT;
 
-	return DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
+	calcdclock = DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
+	pr_debug("clk-usb: calculating new rate, %lu hz / %u = %u hz\n",
+		parent_rate, usbdiv + 1, calcdclock);
+	return calcdclock;
 }
 
 static int at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
@@ -98,7 +102,6 @@ static int at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
 		if (!best_diff)
 			break;
 	}
-
 	if (best_rate < 0)
 		return best_rate;
 
@@ -142,6 +145,9 @@ static int at91sam9x5_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (div > SAM9X5_USB_MAX_DIV + 1 || !div)
 		return -EINVAL;
 
+	pr_debug("clk-usb: setting USB clock divider to %lu hz / %lu = %lu hz\n",
+		parent_rate, div, rate);
+
 	regmap_update_bits(usb->regmap, AT91_PMC_USB, AT91_PMC_OHCIUSBDIV,
 			   (div - 1) << SAM9X5_USB_DIV_SHIFT);
 
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 5ad9e9bdc8ee..c57a239918f9 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -70,11 +70,13 @@ static const struct ohci_driver_overrides ohci_at91_drv_overrides __initconst =
 
 /*-------------------------------------------------------------------------*/
 
-static void at91_start_clock(struct ohci_at91_priv *ohci_at91)
+static void at91_start_clock(struct ohci_at91_priv *ohci_at91,
+				struct device *dev)
 {
 	if (ohci_at91->clocked)
 		return;
 
+	dev_dbg(dev, "Enabling hclk, iclk, and setting fclk to 48 Mhz\n");
 	clk_set_rate(ohci_at91->fclk, 48000000);
 	clk_prepare_enable(ohci_at91->hclk);
 	clk_prepare_enable(ohci_at91->iclk);
@@ -82,11 +84,13 @@ static void at91_start_clock(struct ohci_at91_priv *ohci_at91)
 	ohci_at91->clocked = true;
 }
 
-static void at91_stop_clock(struct ohci_at91_priv *ohci_at91)
+static void at91_stop_clock(struct ohci_at91_priv *ohci_at91,
+				struct device *dev)
 {
 	if (!ohci_at91->clocked)
 		return;
 
+	dev_dbg(dev, "Disabling hclk, iclk, and fclk\n");
 	clk_disable_unprepare(ohci_at91->fclk);
 	clk_disable_unprepare(ohci_at91->iclk);
 	clk_disable_unprepare(ohci_at91->hclk);
@@ -104,7 +108,7 @@ static void at91_start_hc(struct platform_device *pdev)
 	/*
 	 * Start the USB clocks.
 	 */
-	at91_start_clock(ohci_at91);
+	at91_start_clock(ohci_at91, &pdev->dev);
 
 	/*
 	 * The USB host controller must remain in reset.
@@ -128,7 +132,7 @@ static void at91_stop_hc(struct platform_device *pdev)
 	/*
 	 * Stop the USB clocks.
 	 */
-	at91_stop_clock(ohci_at91);
+	at91_stop_clock(ohci_at91, &pdev->dev);
 }
 
 
@@ -623,7 +627,7 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
 
 		/* flush the writes */
 		(void) ohci_readl (ohci, &ohci->regs->control);
-		at91_stop_clock(ohci_at91);
+		at91_stop_clock(ohci_at91, dev);
 	}
 
 	return ret;
@@ -638,7 +642,7 @@ ohci_hcd_at91_drv_resume(struct device *dev)
 	if (ohci_at91->wakeup)
 		disable_irq_wake(hcd->irq);
 
-	at91_start_clock(ohci_at91);
+	at91_start_clock(ohci_at91, dev);
 
 	ohci_resume(hcd, false);
 
-- 
2.17.0


