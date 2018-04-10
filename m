Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3296075-1523349138-2-5988176420631457486
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, URIBL_RED 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523349137; b=ub36dMdEdDceA955ga9EXX5zjYfzQ7gIv7R9aEbckD6fibyF93
    FMub+5D8uK7afvUBQom4hjQLEx5GnH70yVv7ys5lz2QmVRwn/aY8HDhBYHG+VLni
    puCF24TOMO//e0Iv6KZKFbkkldWR4bnuLuQn8QKMUeE/c+Ce21XkqUUqlbaFgX+U
    FtEBMqLXpIAtuwyrcw7ArGD1q+YZsXxbL8pHG+P5afzq23rnKn4VNbJN30WMUoV/
    JomS0eM4cpHB72s6TP6sZNjhodMlCPR3mHeP8usX2pATl4N74lXJEitfUOZmuB4t
    TTOFTK53dRoDu6JmkNX8zdz2b6zGo1B85KZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523349137;
    bh=8W/puQ8I5V1HO0aJu/tI67EXLW1PKRJm7hqPwWtf700=; b=GfIjqlljTNX4
    qgSr2S4pjj52KePXGwNqgANOm7VhQB70rQN6bYF5VTLkKm5OhtKiG0G4QPXz0Bs0
    FBKNkk49TK8+9UONT1wxAIjxVfTqF8LHT9xbNUs+/xrULzpPhlFK3Q1ghU8l2gse
    wh6QILzC3lylo2DuuCD4FChZ3k6jVfHzsAmRikQPykWi+VTd3F6sCUyh2H+RWE20
    FGXFYeXL4/NsR+Ooa7UMUqTvAYNvlExUtmbSHMkGH2u5u5CrnCR9JWByFYJiihro
    x7jEMc5eQWkFyl0L6pYWz+9qM5CK0HQcdUvAKjxzcNq8WZ6W+zdXvpLNqODqJD9g
    oZ2ZyZebEg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKNnnVbkXozs38iV1qy5vUixjg/QGd21A34L3d4bepVsfhu5SLdZCzNPyvDwwJf2cmjBMmh8OHBgC/zgcCI933jq99FJPDhpdtmci9QpBEf2uwozaCDj
    KN3NInZka6sdG/KJPwo7wBfwXGJwOhrBz0ib1P0LOH23R0HnPZP6vFwIivGoGGPM3wP14933W8sgGU3fAzes8++bp5n4PYb9mtuQJmUUfcizU6RTZytbtY5M
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=b5HTAggMAAAA:8 a=VwQbUJbxAAAA:8 a=D1XcT6xkufGVhkOxDtQA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=zfgeMz1PSwFLVvhDL7gT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeDJIcP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 04:32:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39293 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751849AbeDJIcO (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 10 Apr 2018 04:32:14 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Tue, 10 Apr 2018 10:32:12 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Marcin Ziemianowicz <marcin@ziemianowicz.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: at91: Fix for PLL set_rate changes not
 being actually written to PLL peripheral bits
Message-ID: <20180410103212.7bb1d48c@bbrezillon>
In-Reply-To: <20180410001649.GA62245@hak8or>
References: <20180410001649.GA62245@hak8or>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Marcin,

On Mon, 9 Apr 2018 20:16:49 -0400
Marcin Ziemianowicz <marcin@ziemianowicz.com> wrote:

> When a USB device is connected to the USB host port on the SAM9N12 then
> you get "-62" error which seems to indicate USB replies from the device
> are timing out. Looking around, I saw the USB bus was running at half
> speed. Going further, it seems that in ..._set_rate() the PLL wasn't
> actually being adjusted. Writing the multiplier and divider values to
> the peripheral fixes the bus running at half speed.
> 
> Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
> ---
>  drivers/clk/at91/clk-pll.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
> index 534961766ae5..db7155fe9346 100644
> --- a/drivers/clk/at91/clk-pll.c
> +++ b/drivers/clk/at91/clk-pll.c
> @@ -288,6 +288,14 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	pll->div = div;
>  	pll->mul = mul;
>  
> +	// Set the PLL as per above div and mil values.
					    ^ mul

Please do not use C++-style comments, use /* comment */ instead.

> +	regmap_update_bits(pll->regmap, AT91_CKGR_PLLBR,

You hardcode the PLL ID here. What if this function if called for PLLA?

> +		AT91_PMC_DIV | AT91_PMC_MUL,

You should use PLL_MUL_MASK(layout) and PLL_DIV_MASK to do that.

> +		(div << 0) | (mul << 16));

This is wrong. The clk has the CLK_SET_RATE_GATE set, which means the
rate cannot be updated if the PLL is not gated, and if you look at
clk_pll_prepare(), you'll see that div and mul fields are updated
there. Now, maybe there's a bug in clk_pll_prepare(), but
clk_pll_set_rate() is definitely not the place where we want ->div and
->mul to be written to the register.

> +
> +	pr_debug("clk-pll: setting new rate, (%lu hz / %u) * %u = %lu hz\n",
> +		parent_rate, div, mul, rate);
> +
>  	return 0;
>  }
>  

Regards,

Boris
