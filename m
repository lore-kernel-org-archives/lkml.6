Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3886247-1525840356-2-191585676285612308
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525840356; b=mHrSWZ6MuoUSaBiVTC7sp77vyFGFzrLt4dlZA+sXGX7XWqyEQL
    gt8Np7LOAcOQFFofPIzB2L1zWKejMhU9ZwDmX1wWRUv3BGXh97UKdW7HAqhKbj/M
    kIV2Ekp5CZpGKVxBwtTM2hnvx1ppFL/1Q/lom26fa6YmdlQhgc0iiozNoIXe3CaH
    PCwxsxR/ye4zdUwqb2/7XRHfYL9u6DZPFCXPwhEZLy1SMofard5EUCvgEUe0d6fY
    lyH2DzA2UZt7DbDn5ZdxPn2qm4RANRksP384zrFEG+KhU3xVAmJhV9A5tg8nO08J
    yjyQ2MFJ28E2+iGjFWIF5k74tgG1vz8yg/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525840356; bh=fQZE2qNO0TrbzmuSGJud0IgGNO+dVk
    T6lqsLQlN1u2M=; b=JzL9qs/42BdIuypHImGI5VeIDwokSYTrcnoVmvNnHewWVV
    8Ac8dkDfg0HUhJUneroO4cnUjXe7ro+tA1yaSqB/U+xUUNv0R4IahBWUI5UuZ8m1
    iqVjUj4tpUJA8ow0m57YkA3bPUdl+AYoZ+/1VYZxNN+3D7mz53/9DJW3FcVa99ie
    Ql5XD03pmD5PnPVEIR4EHBjjN+2hxOEzHkcksgJ6Kb9wUmk3jSAyhrsR8xfzM+vy
    1VrdQ9lQTdfWiWWwgxr5+AEdlup4hGqBgtqLYyXNAOGHDg543yFM8VXVnhwzpQNl
    U8YMTEy85B/IPi/k/BxJAxbEia3o9TSW0qz3r3cQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ziemianowicz.com
    header.i=marcin@ziemianowicz.com header.b=Y5GJVEqd x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=somekey;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziemianowicz.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ziemianowicz.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ziemianowicz.com
      header.i=marcin@ziemianowicz.com header.b=Y5GJVEqd x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=somekey;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ziemianowicz.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ziemianowicz.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGmynKMeSl4cTzUtBLYHGiCZM0F8IhIc2aBYsPrxDlTECig3awmGCs17v+CzCDKFMgAProPhhcVkbvaT7vvlMHhL9C/m/lBXn8yKlcgtOpICqLHLFCLA
    ofAYyW9YbJBh1wV8gtTEyyhDKO8PTyDMPch4+4/x1Y34z/McKdYex1nT+iM1pQRtyt0WPQIgzlzWIFTTX0CczFDrhvYTCZllBfxwiAkWhA718D86Ci3wS/8x
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=0AA9OZvs-ncA:10 a=b5HTAggMAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8
    a=vdfq-tZ3X0fnjGr3MoMA:9 a=CjuIK1q_8ugA:10 a=zfgeMz1PSwFLVvhDL7gT:22
    a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750784AbeEIEcc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 00:32:32 -0400
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21387 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbeEIEcb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 May 2018 00:32:31 -0400
Date: Wed, 9 May 2018 00:32:05 -0400
From: Marcin Ziemianowicz <marcin@ziemianowicz.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] clk: at91: PLL recalc_rate() now using cached MUL and
 DIV values
Message-ID: <20180509043205.GA57916@hak8or>
References: <20180429190111.14247-1-marcin@ziemianowicz.com>
 <20180430075847.29706679@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430075847.29706679@bbrezillon>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-ZohoMailClient: External
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 07:58:47AM +0200, Boris Brezillon wrote:
> On Sun, 29 Apr 2018 15:01:11 -0400
> Marcin Ziemianowicz <marcin@ziemianowicz.com> wrote:
> 
> > When a USB device is connected to the USB host port on the SAM9N12 then
> > you get "-62" error which seems to indicate USB replies from the device
> > are timing out. Based on a logic sniffer, I saw the USB bus was running
> > at half speed.
> > 
> > The PLL code uses cached MUL and DIV values which get set in set_rate()
> > and applied in prepare(), but the recalc_rate() function instead
> > queries the hardware instead of using these cached values. Therefore,
> > if recalc_rate() is called between a set_rate() and prepare(), the
> > wrong frequency is calculated and later the USB clock divider for the
> > SAM9N12 SOC will be configured for an incorrect clock.
> > 
> > In my case, the PLL hardware was set to 96 Mhz before the OHCI
> > driver loads, and therefore the usb clock divider was being set
> > to /2 even though the OHCI driver set the PLL to 48 Mhz.
> > 
> > As an alternative explanation, I noticed this was fixed in the past by
> > 87e2ed338f1b ("clk: at91: fix recalc_rate implementation of PLL
> > driver") but the bug was later re-introduced by 1bdf02326b71 ("clk:
> > at91: make use of syscon/regmap internally").
> > 
> > Fixes: 1bdf02326b71 ("clk: at91: make use of syscon/regmap internally)
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
> 
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

Apologies for being a bother, but since it's been a bit over a week,
should I do something with this now that it has been ACK'd? I was thinking
I would see it somewhere on the git group repo but am not seeing it there
yet. Googling says that there is a "review cycle" for some maintainers, but
I am not clear on if I need to initiate it manually or anything of the sort.

https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/ 

> 
> > ---
> > Thank you for bearing with me about this Boris.
> > 
> > Changes since V3:
> >   Fix for double returns found by kbluild test robot
> >   > Comments by Boris Brezillon about email formatting issues  
> > Changes since V2:
> >   Removed all logging/debug messages I added
> >   > Comment by Boris Brezillon about my fix being wrong addressed  
> > Changes since V1:
> >   Added patch set cover letter
> >   Shortened lines which were over >80 characters long
> >   > Comment by Greg Kroah-Hartman about "from" field in email addressed
> >   > Comment by Alan Stern about redundant debug lines addressed  
> > 
> >  drivers/clk/at91/clk-pll.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> > 
> > diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
> > index 7d3223fc..72b6091e 100644
> > --- a/drivers/clk/at91/clk-pll.c
> > +++ b/drivers/clk/at91/clk-pll.c
> > @@ -132,19 +132,8 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
> >  					 unsigned long parent_rate)
> >  {
> >  	struct clk_pll *pll = to_clk_pll(hw);
> > -	unsigned int pllr;
> > -	u16 mul;
> > -	u8 div;
> > -
> > -	regmap_read(pll->regmap, PLL_REG(pll->id), &pllr);
> > -
> > -	div = PLL_DIV(pllr);
> > -	mul = PLL_MUL(pllr, pll->layout);
> > -
> > -	if (!div || !mul)
> > -		return 0;
> >  
> > -	return (parent_rate / div) * (mul + 1);
> > +	return (parent_rate / pll->div) * (pll->mul + 1);
> >  }
> >  
> >  static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
> 
