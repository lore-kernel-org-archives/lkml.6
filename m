Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3940792-1525028572-2-11187792817798673070
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, URIBL_RED 0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525028571; b=KOENaZsTzO//9ZrCSeTPz4uDUIWCFq5zs3BIJNgxrw9YlJKj7M
    wx/RaB/4qjEiI67yd2iBh21ZLjxdXBM9xDRvr8S5lA7i04A37Xsd8rqcEoKqI8T/
    M/GEHXaddaOIUhoELONGGhfODA4bgoNkvI6zUXzJYfvhIDWcLB7m/+WP6R4pEnnJ
    dEs4NP/c9WqWYaAydzFN06OrEtTFbabRNxCiqnZtVPw5iKc2/MnAmjjqpFRtN5U1
    TpX4KqjlmyUNeZ3umixmKWemczixbs0c4Sa6SEx/Gd/N1dGnipoDT+HoKw0FJU4t
    2Ljx813wAFfjpU0jjwiIVg1PXcMbw2Qz0YeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525028571; bh=IPRsbujQfwKZAzLC0P8KRyq8f5X7j2
    UKwqTOjBKcMQo=; b=WejydamQD1ZLo/f8pcN2Cn5B5xPysPKcNT3nRKEloy5CCE
    dmkWx85/KkxgMiUYQmcMd7Ws/mKAhMfhODX8GtcOJq/AUAo46OcXAt7i39S5pbrX
    7j0H5IZ/o7FDu3zclN352X/kMerdr1FpUXdnuxyyfBajvx9och+KaG/jI0oy61DV
    6dStV9/QbR8eqwctiXugKWCNXGNXHkQb4lQsmVrBD+ogJuAvcN1nwZwTwMCzasrZ
    pKfIKOPMeohPNV84gnJroq1mrnuhzt8aviomdujSu4S9sZw+c7FP1lFcGso4j75h
    IAIOFIp6Iz86G1/+jfKNOB6Uw3eCUG1FnI4Btyew==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ziemianowicz.com header.i=marcin@ziemianowicz.com header.b=UOeKnaEs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=somekey;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziemianowicz.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ziemianowicz.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ziemianowicz.com header.i=marcin@ziemianowicz.com header.b=UOeKnaEs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=somekey;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziemianowicz.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ziemianowicz.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKU8ktN6XG1A3IutoX6N9K2EHHh8gmn9GBDLZMduNJyrg6ziMNmzdSoKdDEvDvQmnnAPhJJ2m3DN1mwx3qZ5b5IDHQbTuo23Lb6UwXjwA9dx/FlnWBzl
    ReTjwRbPjjQN4vsz2GoQiQdsIQSuoj/1q/dbpL3DqcWEQwmSwyzLEHiq/EoZojzFlGtPOMWERy9GRLKDZfiAC78nIjrrD8fDMjksiIUCxSkBwzWyISJ3yDry
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=0AA9OZvs-ncA:10
    a=VwQbUJbxAAAA:8 a=b5HTAggMAAAA:8 a=v8ABPxu3pFR2WDZMx44A:9
    a=AjGcO6oz07-iQ99wixmX:22 a=zfgeMz1PSwFLVvhDL7gT:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753985AbeD2TCg (ORCPT <rfc822;greg@kroah.com>);
        Sun, 29 Apr 2018 15:02:36 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21359 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeD2TCf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 29 Apr 2018 15:02:35 -0400
From: Marcin Ziemianowicz <marcin@ziemianowicz.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcin Ziemianowicz <marcin@ziemianowicz.com>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4] clk: at91: PLL recalc_rate() now using cached MUL and DIV values
Date: Sun, 29 Apr 2018 15:01:11 -0400
Message-Id: <20180429190111.14247-1-marcin@ziemianowicz.com>
X-Mailer: git-send-email 2.17.0
X-ZohoMailClient: External
X-ZohoMail: Z_636351567 SPT_1 Z_636351566 SPT_1 SLF_D S_163
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When a USB device is connected to the USB host port on the SAM9N12 then
you get "-62" error which seems to indicate USB replies from the device
are timing out. Based on a logic sniffer, I saw the USB bus was running
at half speed.

The PLL code uses cached MUL and DIV values which get set in set_rate()
and applied in prepare(), but the recalc_rate() function instead
queries the hardware instead of using these cached values. Therefore,
if recalc_rate() is called between a set_rate() and prepare(), the
wrong frequency is calculated and later the USB clock divider for the
SAM9N12 SOC will be configured for an incorrect clock.

In my case, the PLL hardware was set to 96 Mhz before the OHCI
driver loads, and therefore the usb clock divider was being set
to /2 even though the OHCI driver set the PLL to 48 Mhz.

As an alternative explanation, I noticed this was fixed in the past by
87e2ed338f1b ("clk: at91: fix recalc_rate implementation of PLL
driver") but the bug was later re-introduced by 1bdf02326b71 ("clk:
at91: make use of syscon/regmap internally").

Fixes: 1bdf02326b71 ("clk: at91: make use of syscon/regmap internally)
Cc: <stable@vger.kernel.org>
Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
---
Thank you for bearing with me about this Boris.

Changes since V3:
  Fix for double returns found by kbluild test robot
  > Comments by Boris Brezillon about email formatting issues
Changes since V2:
  Removed all logging/debug messages I added
  > Comment by Boris Brezillon about my fix being wrong addressed
Changes since V1:
  Added patch set cover letter
  Shortened lines which were over >80 characters long
  > Comment by Greg Kroah-Hartman about "from" field in email addressed
  > Comment by Alan Stern about redundant debug lines addressed

 drivers/clk/at91/clk-pll.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 7d3223fc..72b6091e 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -132,19 +132,8 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
 					 unsigned long parent_rate)
 {
 	struct clk_pll *pll = to_clk_pll(hw);
-	unsigned int pllr;
-	u16 mul;
-	u8 div;
-
-	regmap_read(pll->regmap, PLL_REG(pll->id), &pllr);
-
-	div = PLL_DIV(pllr);
-	mul = PLL_MUL(pllr, pll->layout);
-
-	if (!div || !mul)
-		return 0;
 
-	return (parent_rate / div) * (mul + 1);
+	return (parent_rate / pll->div) * (pll->mul + 1);
 }
 
 static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
-- 
2.17.0
