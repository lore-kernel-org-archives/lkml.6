Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3323945-1523348668-2-13070207533321983889
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
    1523348667; b=kapL3LXjaBVA2WDtQEIkXi1Wt0eDNWjgPjkwMDSAJICg13Tm6C
    8Q/ZiEvBi8nzSkI/Otl8Y18r1Q641tfVl+GIWKHbOXguCMw1oJirgweoQoKTYM9c
    Hpi5HIsRUKSTG+pjaczVYsrfgOd/T+JLe6V3i6DApMOmyUV378PmfZHGFO1s71Zw
    qs5DWOaXBHhcqS2rGt5QIFFs/t51SnSlXzMzH5xzhtJFZw15zLeentCjpHLpbO9A
    QQwmel5oXXZ25zqT/DL29Ds35j8Gmhb0xhVzc0xlYj/rNk6qdyfjd9MMBynWD/ee
    TPG5HQi7ofOtHMxFeAca8fo/oL4CCu9Qje/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523348667;
    bh=/oEDM4+rM7bb2473R9Suh7mNY9v5vLRIjFN0KpeEB28=; b=YUaso8AOGp9S
    QedOFvGSmHt3p3vIzytM5MsmSOkzqjlcECbCY/JxzJwTkxcUjy6Ky5TaB+ePym10
    yDa+xEj6GRpjcW+ZdXSrT8EeFpT/2wgmhSb6/d5DE58gxyVdciFhL26KXujRjRNL
    jZkAgH7ej3cyU8JlyQNIkg26GUAGNkcxiz+HXpzzck+zc3y0ro1iokIv1LTlz+zg
    lSOtNCQzBkYqcZFj4A0J1m/GleAxQH9/eWZOSVkwH+RnWT62E3aS0sAWBcE3c6OS
    H3oAzTLnPHd/nAGCxSYMn/7t/rFNbgE/43HVdNoYrCkIDKFim4O1vcDs8MtvWnhk
    omSTH7A/BQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfJsQ5vubzjX90ME/cmJG8PrBymjNlGE4Aql8Z1l2SdRzVliDqBJ1g8BGWsxl1uVUZwttoTWIQcsDpmix42iEeCH3T1d85FzLQq9LIpb86BwBVDJcqPsx
    H7a7HvLejsxaJJcUV3HYygrEm+PVrcRhn9/aLzSDIDtuGzwFiSXz8yS7Hgf20JbZcJt4E2nJaycnS3HWBSSxsHODZ/PRuKJ8iIMQZ1ipvI5Y/T48GGeNt8r/
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=b5HTAggMAAAA:8 a=VwQbUJbxAAAA:8 a=BUibiugT3WWOKzPe_lwA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=zfgeMz1PSwFLVvhDL7gT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeDJIYL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 04:24:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39157 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751393AbeDJIYK (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 10 Apr 2018 04:24:10 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Tue, 10 Apr 2018 10:24:07 +0200
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
Subject: Re: [PATCH v2 1/2] clk: at91: Added more information logging.
Message-ID: <20180410102407.46e7d416@bbrezillon>
In-Reply-To: <20180410001621.GA62230@hak8or>
References: <20180410001621.GA62230@hak8or>
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

On Mon, 9 Apr 2018 20:16:21 -0400
Marcin Ziemianowicz <marcin@ziemianowicz.com> wrote:

> I noticed that when debugging some USB clocking issue that there weren't
> many ways to tell what the state of the USB clocking system was. This
> adds a few logging statements to see what the relevant code is trying to
> do.
> 
> Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>
> ---
>  drivers/clk/at91/clk-pll.c   |  6 +++++-
>  drivers/clk/at91/clk-usb.c   | 10 ++++++++--
>  drivers/usb/host/ohci-at91.c | 16 ++++++++++------

This should be split in 2 patches (one adding traces to clk drivers and
another doing it for the USB host driver), so that those patches can be
merged independently by the clk and usb maintainers.

>  3 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-pll.c b/drivers/clk/at91/clk-pll.c
> index 7d3223fc7161..534961766ae5 100644
> --- a/drivers/clk/at91/clk-pll.c
> +++ b/drivers/clk/at91/clk-pll.c
> @@ -133,6 +133,7 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
>  {
>  	struct clk_pll *pll = to_clk_pll(hw);
>  	unsigned int pllr;
> +	unsigned long recalcedrate;

Just name it 'rate' or 'realrate'.

>  	u16 mul;
>  	u8 div;
>  
> @@ -144,7 +145,10 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
>  	if (!div || !mul)
>  		return 0;
>  
> -	return (parent_rate / div) * (mul + 1);
> +	recalcedrate = (parent_rate / div) * (mul + 1);
> +	pr_debug("clk-pll: calculating new rate, (%lu hz / %u) * %u = %lu hz\n",

If the prefix is alway "clk-pll: " you could define pr_fmt() to add it
to all your pr_xxx() messages.

BTW, it's not about calculating the new rate, but retrieving the
actual rate.

> +		parent_rate, div, mul, recalcedrate);

Add an empty line here.

> +	return recalcedrate;
>  }
>  
>  static long clk_pll_get_best_div_mul(struct clk_pll *pll, unsigned long rate,
> diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
> index 791770a563fc..2fa877e99bac 100644
> --- a/drivers/clk/at91/clk-usb.c
> +++ b/drivers/clk/at91/clk-usb.c
> @@ -48,11 +48,15 @@ static unsigned long at91sam9x5_clk_usb_recalc_rate(struct clk_hw *hw,
>  	struct at91sam9x5_clk_usb *usb = to_at91sam9x5_clk_usb(hw);
>  	unsigned int usbr;
>  	u8 usbdiv;
> +	unsigned int calcdclock;

Ditto: s/calcdclock/realrate/, and make it unsigned long.

>  
>  	regmap_read(usb->regmap, AT91_PMC_USB, &usbr);
>  	usbdiv = (usbr & AT91_PMC_OHCIUSBDIV) >> SAM9X5_USB_DIV_SHIFT;
>  
> -	return DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
> +	calcdclock = DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
> +	pr_debug("clk-usb: calculating new rate, %lu hz / %u = %u hz\n",
> +		parent_rate, usbdiv + 1, calcdclock);

Empty line here too.

> +	return calcdclock;
>  }
>  
>  static int at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
> @@ -98,7 +102,6 @@ static int at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
>  		if (!best_diff)
>  			break;
>  	}
> -
>  	if (best_rate < 0)
>  		return best_rate;
>  
> @@ -142,6 +145,9 @@ static int at91sam9x5_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
>  	if (div > SAM9X5_USB_MAX_DIV + 1 || !div)
>  		return -EINVAL;
>  
> +	pr_debug("clk-usb: setting USB clock divider to %lu hz / %lu = %lu hz\n",

The formulation is weird. Maybe you should just remove 'divider' here:

		"setting USB clock to %lu hz / %lu = %lu hz"

> +		parent_rate, div, rate);
> +
>  	regmap_update_bits(usb->regmap, AT91_PMC_USB, AT91_PMC_OHCIUSBDIV,
>  			   (div - 1) << SAM9X5_USB_DIV_SHIFT);
>  
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index 5ad9e9bdc8ee..c57a239918f9 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -70,11 +70,13 @@ static const struct ohci_driver_overrides ohci_at91_drv_overrides __initconst =
>  
>  /*-------------------------------------------------------------------------*/
>  
> -static void at91_start_clock(struct ohci_at91_priv *ohci_at91)
> +static void at91_start_clock(struct ohci_at91_priv *ohci_at91,
> +				struct device *dev)

Maybe you could just pass a pdev or dev pointer and let the function
extract the ohci_at91 object with:

	struct usb_hcd *hcd = platform_get_drvdata(pdev);
	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);

>  {
>  	if (ohci_at91->clocked)
>  		return;
>  
> +	dev_dbg(dev, "Enabling hclk, iclk, and setting fclk to 48 Mhz\n");

Add an empty line here.

>  	clk_set_rate(ohci_at91->fclk, 48000000);
>  	clk_prepare_enable(ohci_at91->hclk);
>  	clk_prepare_enable(ohci_at91->iclk);
> @@ -82,11 +84,13 @@ static void at91_start_clock(struct ohci_at91_priv *ohci_at91)
>  	ohci_at91->clocked = true;
>  }
>  
> -static void at91_stop_clock(struct ohci_at91_priv *ohci_at91)
> +static void at91_stop_clock(struct ohci_at91_priv *ohci_at91,
> +				struct device *dev)
>  {
>  	if (!ohci_at91->clocked)
>  		return;
>  
> +	dev_dbg(dev, "Disabling hclk, iclk, and fclk\n");
>  	clk_disable_unprepare(ohci_at91->fclk);
>  	clk_disable_unprepare(ohci_at91->iclk);
>  	clk_disable_unprepare(ohci_at91->hclk);
> @@ -104,7 +108,7 @@ static void at91_start_hc(struct platform_device *pdev)
>  	/*
>  	 * Start the USB clocks.
>  	 */
> -	at91_start_clock(ohci_at91);
> +	at91_start_clock(ohci_at91, &pdev->dev);
>  
>  	/*
>  	 * The USB host controller must remain in reset.
> @@ -128,7 +132,7 @@ static void at91_stop_hc(struct platform_device *pdev)
>  	/*
>  	 * Stop the USB clocks.
>  	 */
> -	at91_stop_clock(ohci_at91);
> +	at91_stop_clock(ohci_at91, &pdev->dev);
>  }
>  
>  
> @@ -623,7 +627,7 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
>  
>  		/* flush the writes */
>  		(void) ohci_readl (ohci, &ohci->regs->control);
> -		at91_stop_clock(ohci_at91);
> +		at91_stop_clock(ohci_at91, dev);
>  	}
>  
>  	return ret;
> @@ -638,7 +642,7 @@ ohci_hcd_at91_drv_resume(struct device *dev)
>  	if (ohci_at91->wakeup)
>  		disable_irq_wake(hcd->irq);
>  
> -	at91_start_clock(ohci_at91);
> +	at91_start_clock(ohci_at91, dev);
>  
>  	ohci_resume(hcd, false);
>  

Regards,

Boris
