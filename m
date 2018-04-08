Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2451319-1523198619-2-7091084195604165349
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_RED 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523198618; b=YdeTlB9pBBuSMLjFSBXLdGp/TPHuX3fyc1MmS2pKdjShmeZ0qa
    SZ0QYUpFxCvFXjqLjK2+hPPvzsmYhd3POOgeFY2f0lWAT2Z62p0MuvMTiog48jMM
    Sv0q1WCwGaQzYxQj6M+IiSiGVkro2B7GPskn1nqW5H7z80kZQshj+UfA04hhX68C
    UehxKOSGfecoTfTKXUtMXDn6PAUDx1SHFqzn5GGPYj2hgERx/U0UrNsA7xt44mfU
    vtY5zKYBDE06PqPmQYOUZV/dcgOOwctGPGhtQ2KtsI9X1ZvR+dQqbI24bDfNZ0dY
    raG3tCQMFTGnZzWAcMyRLasfspCK9UQEI2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1523198618; bh=519gXPCuTnLiJptBpl0xrVQYb6/i3y2yIlx0zUEuCOI=; b=i
    Ejyrm9PyA5p3vXZ9TwaKpK3VHdtjWQ36WOtUh7O+khglijj5zHpnXMZBRTleFgHY
    QVZNnXl7Gv8I/7fs/jImufaUOdivMkNaJcezxIKPTLB6BahJeghft+OyHJKkwzgc
    39cK3Kj+Yjy3/lPoYWFr38zt7qpquMeDju15mjdcZgROSqTKJ3mI8rrgYnU5kUZy
    A2mU+rmY4RD+gaempFUjd0Bt0bJ2IZiuGbajK0hF2NFo755dd+d3rcj9DkW/b1yo
    kIxXLhdfAgfTLiiVO3+SsWF8rqK3j9qL1LKHbBfUBx0i58xTjQAlX9/63BzAmLNb
    B6Csd8xNI/z/tumzq5abQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKwve6SLHMkFFCrsJpfl86shtkUckjcqgxbbuusVNcgMvI+E/rrEtZM+fRResEsD7BEUBuJ2THvHm3XRKJ26YNyPZ9FCM0ggLSNmaaqt7vTC6U9wzPcj
    3WfBLEd+Hf8ZHI8/CsV2zMquR0tpb6B6lycmmDfotfA9X4UzUYLIHHTlOrmV/CB1hJbWlbbcWqdkopnrBhceTJ+o81e8WBlijfcRMcL+iJxkBmOzqPQ2bmvX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=b5HTAggMAAAA:8 a=VwQbUJbxAAAA:8 a=UY3zOByjWlUALTw-rZUA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=zfgeMz1PSwFLVvhDL7gT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeDHOnX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 10:43:23 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36607 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1751526AbeDHOnW (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 8 Apr 2018 10:43:22 -0400
Date: Sun, 8 Apr 2018 10:43:21 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Marcin <marcin@ziemianowicz.com>
cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/2] clk: at91: Added more information logging.
In-Reply-To: <20180408094330.GA51669@hak8or>
Message-ID: <Pine.LNX.4.44L0.1804081038420.20429-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 8 Apr 2018, Marcin wrote:

> I noticed that when debugging some USB clocking issue that there weren't
> many ways to tell what the state of the USB clocking system was. This
> adds a few logging statements to see what the relevant code is trying to
> do.
> 
> Signed-off-by: Marcin Ziemianowicz <marcin@ziemianowicz.com>

It seems like you have added more debugging lines than necessary.

> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -70,11 +70,12 @@ static const struct ohci_driver_overrides ohci_at91_drv_overrides __initconst =
>  
>  /*-------------------------------------------------------------------------*/
>  
> -static void at91_start_clock(struct ohci_at91_priv *ohci_at91)
> +static void at91_start_clock(struct ohci_at91_priv *ohci_at91, struct device *dev)
>  {
>  	if (ohci_at91->clocked)
>  		return;
>  
> +	dev_dbg(dev, "Enabling hclk, iclk, and setting fclk to 48 Mhz\n");

Here you list all the clocks and give one frequency.

>  	clk_set_rate(ohci_at91->fclk, 48000000);
>  	clk_prepare_enable(ohci_at91->hclk);
>  	clk_prepare_enable(ohci_at91->iclk);

> @@ -104,12 +106,19 @@ static void at91_start_hc(struct platform_device *pdev)
>  	/*
>  	 * Start the USB clocks.
>  	 */
> -	at91_start_clock(ohci_at91);
> +	at91_start_clock(ohci_at91, &pdev->dev);
>  
>  	/*
>  	 * The USB host controller must remain in reset.
>  	 */
>  	writel(0, &regs->control);
> +
> +	/*
> +	 * Say what the clocks are set to.
> +	 */
> +	dev_dbg(&pdev->dev, "hclk set to: %lu hz\n", clk_get_rate(ohci_at91->hclk));
> +	dev_dbg(&pdev->dev, "iclk set to: %lu hz\n", clk_get_rate(ohci_at91->iclk));
> +	dev_dbg(&pdev->dev, "fclk set to: %lu hz\n", clk_get_rate(ohci_at91->fclk));

Here you list all the clocks a second time and give all the 
frequencies.

>  }
>  
>  static void at91_stop_hc(struct platform_device *pdev)

Alan Stern

