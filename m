Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2325483-1523319438-2-13687241400670507745
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
    1523319437; b=bT+J3LALJ+ATf3nOL4aqKiEfEzsJpNGXE2pTvBLhOxaFUr7fpU
    w11DxXVyz9TKaXROWzLa/e6HLtVhTgU03QNgWEOeqnGsuXy88qZB5n+IjtwBfDMo
    CRPqdNdyHCjTnaZmjI8TaYHwEaPwt0lIYLZHTF1koZUD3gDxJKZBs8w55NYCykU1
    l+61nNyrySVBkBa+eT0wSAoZ7BpDOSbXbVM3MP1bDJiI0/5Mks7+xIO1DVzqBHY8
    LUUvKEmsltjlSFqKLmADxJcc3/BAxHbKXpTV0QUvx+4bZWqA7xYTuVYXiHAZivLU
    fmT1XsJYWsMPDoYt6bNX6do9cLmRpxf0wHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1523319437;
    bh=2q7l/3UNDnpNHO88tLDzKHXmT5mxTQBPSaX6D0xIzzM=; b=BXMvdqVLaa8z
    ND6r2GVx53UiN/9can3itoo0W4+wMPvNnkBP6K+8XvnHSfVNz7VSsw/soeRTihNo
    mpwiv0+PkzXl7rs94rK7rlOM6OsOmcrILjg1nhR9Z2ZPft8NcxLY46zByPAmFium
    VUvqih50FLSHxJppDVnQtJyLJdcImrnE9Ap/YF7GOvWV2BUWBUNBB/r0i0lwlT4g
    LBlupoj/tpFNKUTKzHynqQ+h3TttXUahOV8OqPS0+y3wvI6TBtPXOzKaFGppYAHE
    UdwAnVS0NC+9+9iJ2nSPP64PpT630reYkfCxVYAVIkmCcAmCYDoRlFXlzwj3NmQp
    aquA9CSW+Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ziemianowicz.com header.i=marcin@ziemianowicz.com header.b=Z/Kt2Cwa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=somekey;
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
    dkim=pass (1024-bit rsa key sha256) header.d=ziemianowicz.com header.i=marcin@ziemianowicz.com header.b=Z/Kt2Cwa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=somekey;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziemianowicz.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ziemianowicz.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCAsNOD7J6DPcRfGtmKoGstHrLI1uMLuIqMMkRbN6pBE8xTBj1Ebo2ERgzfxYhJTBi3dS7Jgx2PFypOwZsj3e30Bxgnmqg8cqpJrmFzFZLRQVWtMtCIz
    aBjzHmi5VKioHWVCoAkn+lRDQ84QkmslE4YcAORwpvJriMp6gI/Wk2Pg5rB0lHTHHy6cOruONoOjugnMUej5iJmiIXpXSbZLERjcFEHoVLoAzckljNMFEEaJ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=0AA9OZvs-ncA:10 a=b5HTAggMAAAA:8 a=VwQbUJbxAAAA:8 a=6MGWG7kTq6TUDMUkA0kA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=zfgeMz1PSwFLVvhDL7gT:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751919AbeDJARP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 20:17:15 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21357 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbeDJARO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 9 Apr 2018 20:17:14 -0400
Date: Mon, 9 Apr 2018 20:16:49 -0400
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
Subject: [PATCH v2 2/2] clk: at91: Fix for PLL set_rate changes not being
 actually written to PLL peripheral bits
Message-ID: <20180410001649.GA62245@hak8or>
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

When a USB device is connected to the USB host port on the SAM9N12 then
you get "-62" error which seems to indicate USB replies from the device
are timing out. Looking around, I saw the USB bus was running at half
speed. Going further, it seems that in ..._set_rate() the PLL wasn't
actually being adjusted. Writing the multiplier and divider values to
the peripheral fixes the bus running at half speed.

Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
---
 drivers/clk/at91/clk-pll.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
index 534961766ae5..db7155fe9346 100644
--- a/drivers/clk/at91/clk-pll.c
+++ b/drivers/clk/at91/clk-pll.c
@@ -288,6 +288,14 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	pll->div = div;
 	pll->mul = mul;
 
+	// Set the PLL as per above div and mil values.
+	regmap_update_bits(pll->regmap, AT91_CKGR_PLLBR,
+		AT91_PMC_DIV | AT91_PMC_MUL,
+		(div << 0) | (mul << 16));
+
+	pr_debug("clk-pll: setting new rate, (%lu hz / %u) * %u = %lu hz\n",
+		parent_rate, div, mul, rate);
+
 	return 0;
 }
 
-- 
2.17.0


