Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-738169-1525067936-2-12707096538847395544
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525067936; b=O4+1D/uRAo7dZ5SSGhV7u7sdGTiZ+tg4ja+CIjNWZj63KlE/7u
    5O9xBBvF8dak+3suSD0PUXD/zf/T3pt+i61wCW6GnnQ0HW7d8jMAXCIryehi4nHp
    1nYhqQY6ogcfdcZreSCZhJFCv86hHzD+DEDJxPDoCBhX+hoGKtvmE0MWE6GxiloA
    aXpbjRxlqcxn+ZKP8gvLboMV3GpC7asCmtto6rqWnGNORfEVygLES3s1niYIYnAM
    2uK8QZhrK694RRBAm6+AjmTpmvgxph0ws5nOcf/9UXhcEZyy+R3ctM2yS8hZXaJz
    /IGScuDypWYLYuHcZWfHpN40YP4l+Pzz5oLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525067936;
    bh=7/jTZ6O+Sz7EY1tWwENVaNbfmAfyBLt0R811opPMk2A=; b=G0jJNt+dSEEE
    nsTrBu0B1RDlGrVF1JlrJNcvGccuJHmObdI3jblgNbvm31174nEM1ei4jZTh/l5P
    mgRzYDHe+PLPPza0WL2iJ541q69MFPjJVpbpemrKvf//BFrSSWXv2Kgm5bSGQV3L
    aDYWWi7XJpZoYie1bleQo3tT4U35pdFN4zeqgg1erpefU8ANEUTcDHXkLeyHy2kf
    87OEn8BbWW66yb7SofYpnxVsKy+HYW/1irgvYorF68BS9vkXhgvw/jyunho12jY3
    LvO3PJYSnM0vmhB+F3a/njXnhzzD2f5KJspQLbcuhADwtQNOuY2Zo0zLq5fj8Ynz
    87M+PN/3kg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKPqGm71K7SkaLmLXoPgO/KhA87+mgvDLvClBz/suozZLk+9BsG/pkw3gfUy2/FcSEkPFbfU95LWRPpiUm18MUTOciJDf4V/H2xD6ALrK0xAwIYvJ9Qg
    Ce3sbmDT7GWXmWLSmSRe37FSdX4fZpuypk3StSd7yjBi0Ws6zs3sEL2EII7lSdMLUAKVJE3pqUHdEUZ/n3zytQsZ5GE6Vu++R+RSdDEdi/ZRheX4KM7Ks4+7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=b5HTAggMAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=rm4rEiujcRuMHd9GJUMA:9
    a=CjuIK1q_8ugA:10 a=zfgeMz1PSwFLVvhDL7gT:22 a=AjGcO6oz07-iQ99wixmX:22
    a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751621AbeD3F6x (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 01:58:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50942 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbeD3F6w (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 01:58:52 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_RED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Mon, 30 Apr 2018 07:58:47 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Marcin Ziemianowicz <marcin@ziemianowicz.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] clk: at91: PLL recalc_rate() now using cached MUL
 and DIV values
Message-ID: <20180430075847.29706679@bbrezillon>
In-Reply-To: <20180429190111.14247-1-marcin@ziemianowicz.com>
References: <20180429190111.14247-1-marcin@ziemianowicz.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 29 Apr 2018 15:01:11 -0400
Marcin Ziemianowicz <marcin@ziemianowicz.com> wrote:

> When a USB device is connected to the USB host port on the SAM9N12 then
> you get "-62" error which seems to indicate USB replies from the device
> are timing out. Based on a logic sniffer, I saw the USB bus was running
> at half speed.
> 
> The PLL code uses cached MUL and DIV values which get set in set_rate()
> and applied in prepare(), but the recalc_rate() function instead
> queries the hardware instead of using these cached values. Therefore,
> if recalc_rate() is called between a set_rate() and prepare(), the
> wrong frequency is calculated and later the USB clock divider for the
> SAM9N12 SOC will be configured for an incorrect clock.
> 
> In my case, the PLL hardware was set to 96 Mhz before the OHCI
> driver loads, and therefore the usb clock divider was being set
> to /2 even though the OHCI driver set the PLL to 48 Mhz.
> 
> As an alternative explanation, I noticed this was fixed in the past by
> 87e2ed338f1b ("clk: at91: fix recalc_rate implementation of PLL
> driver") but the bug was later re-introduced by 1bdf02326b71 ("clk:
> at91: make use of syscon/regmap internally").
> 
> Fixes: 1bdf02326b71 ("clk: at91: make use of syscon/regmap internally)
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>

Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
> Thank you for bearing with me about this Boris.
> 
> Changes since V3:
>   Fix for double returns found by kbluild test robot
>   > Comments by Boris Brezillon about email formatting issues  
> Changes since V2:
>   Removed all logging/debug messages I added
>   > Comment by Boris Brezillon about my fix being wrong addressed  
> Changes since V1:
>   Added patch set cover letter
>   Shortened lines which were over >80 characters long
>   > Comment by Greg Kroah-Hartman about "from" field in email addressed
>   > Comment by Alan Stern about redundant debug lines addressed  
> 
>  drivers/clk/at91/clk-pll.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
> index 7d3223fc..72b6091e 100644
> --- a/drivers/clk/at91/clk-pll.c
> +++ b/drivers/clk/at91/clk-pll.c
> @@ -132,19 +132,8 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
>  					 unsigned long parent_rate)
>  {
>  	struct clk_pll *pll = to_clk_pll(hw);
> -	unsigned int pllr;
> -	u16 mul;
> -	u8 div;
> -
> -	regmap_read(pll->regmap, PLL_REG(pll->id), &pllr);
> -
> -	div = PLL_DIV(pllr);
> -	mul = PLL_MUL(pllr, pll->layout);
> -
> -	if (!div || !mul)
> -		return 0;
>  
> -	return (parent_rate / div) * (mul + 1);
> +	return (parent_rate / pll->div) * (pll->mul + 1);
>  }
>  
>  static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
