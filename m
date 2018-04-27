Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524837977-2-5986181885396214024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524837977; b=W/wlFVJtWOs4XfXr2A2ZeKIlgcsEANHU3cfPZyg1n40NocyvKL
    NfD5KfrSgWDPaSnEpf5Nw/SrrZtNkMBb/SDnFsUhbSkiMdx7MhVkKTiZeSyRmXhb
    F1KcW1dsaa3ZFtCEBwe+8jGIFMNw3iUsXTAHEqASSXUZ+dWPApgRu7aieVTs02hI
    B/26WMpnV0qA+TLOoBdQb5mq6Xf4fdo6BmJJYU1A9mF0kvw0H+BxopGnfEOz5OVV
    aEVk9b2fOKFvbCPgzpcNuwQwSosf9W9079plTNXtKHj1t3p3y2L0OBQx2ZLz+dQz
    375IJ4S8nTEgBszUPBGkjtnDQeJIRPMK1VSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837977; bh=4vYLdSS67PtdjQFwxYYNYtNX8o6ym8
    gMD+cEYhBv21o=; b=Pe66gMn2T/cW0IWkw4j4zKyS6FTJBeed6vEn+kH8SpCuDW
    nBE8GBU8MhUSYhB91x7oG3SRuHVtd5Bk3Enzm6Dg0fIw7B6PFHcjvsjq0IbcIXLU
    cbBaifibApech+n3MQvKCAtetZJWbZ4vgSKfwklwMxeUrQicTxkHU4FY1LJTsK14
    c5Nf86nlXj31ELaUU/WL7REAzs5E+LDw1MvuQLPzuF8J2EIribJ/QpjceVoXd0b7
    FFgGAl7VCdIK2FKn7ISsqOvnkpzj33uqtifzXuBCY/Hyn5NmdgUn9p2u8Qn8kHm8
    NC/l0654l/v+WBBKkWwYB56A+r4Atyktht8fjrOg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHpyNpuAhuOf1wJHEs6KSs91BPMs735u4PI+QnrbcBEiwoFQRa3ZfsYQBKKpNM8IzD1lVPmUlxTiRCm2DD7g4ytUkny+Pc0KtXPC8nPxBB/6roBhtTMP
    94wBKsC5KFsbdKWmDhYFoBA3cyH8vuWO2cOrLbhe9wD8hMa4TsNeOVy5A4Mng+/n6MpSyeNaRhv9OFCgKCuG+xbnWcUI6ip4YopVfRDkYrm4hAZZ3MtCQU6Q
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=EqdPLkY1AAAA:8
    a=KKAkSRfTAAAA:8 a=iABzjTZjk7s6rj3bFy0A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=dfeKg4RqpEhWThG6bP4-:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933556AbeD0OGK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934043AbeD0OGB (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:06:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAAB21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 01/80] Revert "pinctrl: intel: Initialize GPIO properly when used through irqchip"
Date: Fri, 27 Apr 2018 15:57:54 +0200
Message-Id: <20180427135732.999030511@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit f5a26acf0162477af6ee4c11b4fb9cffe5d3e257

Mike writes:
	It seems that commit f5a26acf0162 ("pinctrl: intel: Initialize GPIO
	properly when used through irqchip") can cause problems on some Skylake
	systems with Sunrisepoint PCH-H. Namely on certain systems it may turn
	the backlight PWM pin from native mode to GPIO which makes the screen
	blank during boot.

	There is more information here:

	  https://bugzilla.redhat.com/show_bug.cgi?id=1543769

	The actual reason is that GPIO numbering used in BIOS is using "Windows"
	numbers meaning that they don't match the hardware 1:1 and because of
	this a wrong pin (backlight PWM) is picked and switched to GPIO mode.

	There is a proper fix for this but since it has quite many dependencies
	on commits that cannot be considered stable material, I suggest we
	revert commit f5a26acf0162 from stable trees 4.9, 4.14 and 4.15 to
	prevent the backlight issue.

Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Fixes: f5a26acf0162 ("pinctrl: intel: Initialize GPIO properly when used through irqchip")
Cc: Daniel Drake <drake@endlessm.com>
Cc: Chris Chiu <chiu@endlessm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/intel/pinctrl-intel.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -427,18 +427,6 @@ static void __intel_gpio_set_direction(v
 	writel(value, padcfg0);
 }
 
-static void intel_gpio_set_gpio_mode(void __iomem *padcfg0)
-{
-	u32 value;
-
-	/* Put the pad into GPIO mode */
-	value = readl(padcfg0) & ~PADCFG0_PMODE_MASK;
-	/* Disable SCI/SMI/NMI generation */
-	value &= ~(PADCFG0_GPIROUTIOXAPIC | PADCFG0_GPIROUTSCI);
-	value &= ~(PADCFG0_GPIROUTSMI | PADCFG0_GPIROUTNMI);
-	writel(value, padcfg0);
-}
-
 static int intel_gpio_request_enable(struct pinctrl_dev *pctldev,
 				     struct pinctrl_gpio_range *range,
 				     unsigned pin)
@@ -446,6 +434,7 @@ static int intel_gpio_request_enable(str
 	struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	void __iomem *padcfg0;
 	unsigned long flags;
+	u32 value;
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
@@ -455,7 +444,13 @@ static int intel_gpio_request_enable(str
 	}
 
 	padcfg0 = intel_get_padcfg(pctrl, pin, PADCFG0);
-	intel_gpio_set_gpio_mode(padcfg0);
+	/* Put the pad into GPIO mode */
+	value = readl(padcfg0) & ~PADCFG0_PMODE_MASK;
+	/* Disable SCI/SMI/NMI generation */
+	value &= ~(PADCFG0_GPIROUTIOXAPIC | PADCFG0_GPIROUTSCI);
+	value &= ~(PADCFG0_GPIROUTSMI | PADCFG0_GPIROUTNMI);
+	writel(value, padcfg0);
+
 	/* Disable TX buffer and enable RX (this will be input) */
 	__intel_gpio_set_direction(padcfg0, true);
 
@@ -940,8 +935,6 @@ static int intel_gpio_irq_type(struct ir
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
-	intel_gpio_set_gpio_mode(reg);
-
 	value = readl(reg);
 
 	value &= ~(PADCFG0_RXEVCFG_MASK | PADCFG0_RXINV);
