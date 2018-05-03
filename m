Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2309188-1525342716-2-11729483091353967972
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525342715; b=Lfg8Gyv8vKzxGNIVo4Bu9zNIDujVFbrABI3VdBmw6Voca+M/re
    eRPHNSTWZ7W1dmERR4mUd08N+XCWcA9cTOrWHtGtr/jbBjdXGay79dI+kECNtjwn
    /0R0B6VFjbGE1gbQLaXNRjaxRPZey3biOi3iun6nnvuYYyMAtWy+gRAiXWv1FoOx
    Tl0TjAdxbwr6CbDMwiJRm43Y8+TF+OgeihyemFwiYVhv65k2SDcZMlCKZdRISQeR
    viqLec4hi5La9+khqX2QbhIwrguwodGQ4OL2N8FWNf1bOAjvJysCZf+AomLAHJtq
    6mWcE1xXL9QDNEfRuLGw1GPQAkyLLeuuPI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525342715;
    bh=IDL3SoZNaBzXygOIeeQA3JF4Sc9EWQkqiiuMoDzmiqY=; b=Cwg00MutbnCS
    7iBDWdsn/whnGzrusyqnGX/qu2aEFL6mRTQoj7wlOx7oU/Qze4SCe5eKrptlDKD0
    z4VTw+l7nJ9FEOcN3ww42N/FnAoTpJSa3OKtKoTmPhZl4d4SGUktRL8ApVVk0HLh
    Hkm+RK/UCokdeW7D/aoqjTbVu9NCPFbpRsgyVRNaKRSX2MeZBO/LDsU03Yco2vPY
    TEEypivjXPISpluikRZ1Yyuyv4knRS8lCYnUFSZWRm0bhubeQ0rTJQK9gChHCMOB
    AF3whGIfnhDZwQa9MH1yL/ld+CeRGMblcB3VBVmlqyQtLKvV8nHAzZJ/XSPJM8+f
    b3QULYYDyA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=ti.com header.i=@ti.com header.b=QK3oF9DT x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
    header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=ti.com header.i=@ti.com header.b=QK3oF9DT x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
      header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ti.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAwnIYfemO8pv5NawCS86GbGKu2YbIhwmmmreoRddIN79fn+D3BkcZ3LzJNOg59cmLNdCtQe5/lIu+wCVL2E94KZQbAX++m1hVFY6svrWg3PuGtApgO5
    wyAIabGn+4p0/0Fk9BR8Eu7s2q0/6YynqkRcCoqZb6g/J5AQA0WS2YKtMFSo07pbWaLK9VkRtixsiWsjPe+2VJtrPBo8PU1y1zqpT+DRaucXblOfVFp+cNl2
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=sozttTNsAAAA:8 a=pGLkceISAAAA:8 a=2KMo9-giAAAA:8 a=VwQbUJbxAAAA:8
    a=tQNvSMz1BaIxeOHBs4cA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=aeg5Gbbo78KNqacMgKqU:22 a=UeCTMeHK7YUBiLmz_SX7:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeECKSb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 06:18:31 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:51351 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbeECKSR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 06:18:17 -0400
Subject: Re: [PATCH] serial: 8250: omap: Fix idling of clocks for unused uarts
To: Tony Lindgren <tony@atomide.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-serial@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Keerthy <j-keerthy@ti.com>,
        Matthijs van Duin <matthijsvanduin@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
References: <20180502171500.60462-1-tony@atomide.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <58bcba76-d63b-212e-4baf-d40a28c549d3@ti.com>
Date: Thu, 3 May 2018 15:48:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502171500.60462-1-tony@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Wednesday 02 May 2018 10:45 PM, Tony Lindgren wrote:
> I noticed that unused UARTs won't necessarily idle properly always
> unless at least one byte tx transfer is done first.
> 
> After some debugging I narrowed down the problem to the scr register
> dma configuration bits that need to be set before softreset for the
> clocks to idle. Unless we do this, the module clkctrl idlest bits
> may be set to 1 instead of 3 meaning the clock will never idle and
> is blocking deeper idle states for the whole domain.
> 
> This might be related to the configuration done by the bootloader
> or kexec booting where certain configurations cause the 8250 or
> the clkctrl clock to jam in a way where setting of the scr bits
> and reset is needed to clear it. I've tried diffing the 8250
> registers for the various modes, but did not see anything specific.
> So far I've only seen this on omap4 but I'm suspecting this might
> also happen on the other clkctrl using SoCs considering they
> already have a quirk enabled for UART_ERRATA_CLOCK_DISABLE.
> 

That's interesting! We do have AM437x suspend/resume working without
this workaround (UARTs on AM437x does not use DMA) and UART IPs clkctrl
do go to idle state. Seems like a OMAP4 specific issue.

> Let's fix the issue by configuring scr before reset for basic dma
> even if we don't use it. The scr register will be reset when we do
> softreset few lines after, and we restore scr on resume. We should
> do this for all the SoCs with UART_ERRATA_CLOCK_DISABLE quirk flag
> set since the ones with UART_ERRATA_CLOCK_DISABLE are all based
> using clkctrl similar to omap4.
> 
> Looks like both OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL
> bits are needed for the clkctrl to idle after a softreset.
> 
> And we need to add omap4 to also use the UART_ERRATA_CLOCK_DISABLE
> for the related workaround to be enabled. This same compatible
> value will also be used for omap5.
> 
> Fixes: cdb929e4452a ("serial: 8250_omap: workaround errata around
> idling UART after using DMA")
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1110,13 +1110,14 @@ static int omap8250_no_handle_irq(struct uart_port *port)
>  	return 0;
>  }
>  
> +static const u8 omap4_habit = UART_ERRATA_CLOCK_DISABLE;
>  static const u8 am3352_habit = OMAP_DMA_TX_KICK | UART_ERRATA_CLOCK_DISABLE;
>  static const u8 dra742_habit = UART_ERRATA_CLOCK_DISABLE;
>  
>  static const struct of_device_id omap8250_dt_ids[] = {
>  	{ .compatible = "ti,omap2-uart" },
>  	{ .compatible = "ti,omap3-uart" },
> -	{ .compatible = "ti,omap4-uart" },
> +	{ .compatible = "ti,omap4-uart", .data = &omap4_habit, },
>  	{ .compatible = "ti,am3352-uart", .data = &am3352_habit, },
>  	{ .compatible = "ti,am4372-uart", .data = &am3352_habit, },
>  	{ .compatible = "ti,dra742-uart", .data = &dra742_habit, },
> @@ -1362,6 +1363,16 @@ static int omap8250_soft_reset(struct device *dev)
>  	int sysc;
>  	int syss;
>  
> +	/*
> +	 * At least on omap4, unused uarts may not idle after reset without
> +	 * a basic scr dma configuration even with no dma in use. The
> +	 * module clkctrl status bit will stay set blocking idle for the
> +	 * whole clockdomain. The softreset below will clear scr, and we
> +	 * restore it on resume so this is safe to do on all SoCs needing
> +	 * omap8250_soft_reset() quirk.
> +	 */
> +	serial_out(up, UART_OMAP_SCR,
> +		   OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL);

Comment in omap8250_update_scr() warns not to set these two bits in a
single register write because this may lead to malfunction. I would
recommend to split this into two writes.

>  	sysc = serial_in(up, UART_OMAP_SYSC);
>  
>  	/* softreset the UART */
> 

-- 
Regards
Vignesh
