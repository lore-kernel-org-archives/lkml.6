Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-826942-1524470811-2-11792456930526981484
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524470811; b=mTowJkzbX1PKSjAE8TvEX+kns3Fk0wt0GnKfH1SJI7SvUtOWsf
    zuLi3ufwdVqAOVzUOxPXuddJvqWm7nnDqM7TbH3Xa2GTgvq3A8hqtchmmCbCEf8Z
    56hFhvHt0KKNAX4JIcmBE65nFuPswpg0JgOPInIJ25K7DGh7edZ3gZ3AULa6do46
    CV9thCLLz7WMPlKNA5hwDXiCNbHKWtYichEE+vmh2CDtJZilR02yrwVrPWhdtvm4
    Nuivheen5Za5w+Km9zmUM2oxArYwc6Bm/G5lmWi7Kag/UggW10xppY1RSr0wuEQI
    PkmQlAtwjvB9QMFDKvlYm1UPtqk1EdT+AWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524470811; bh=Ig09f1Pnb6M2uVngL/WKaQtl/qlqd+
    33GBxY4C/FNPg=; b=WUCulwu1USLTjohYIhpJ88wV7ehNjoseUCez1/JwIK257L
    A8ulPqDuD3qGOWfTWEJTuu5AZw20hnOqduQJbe4Fmq92DrPOGfqQbRXKCUGVtuvn
    OUzgZZNhkORt5ebYcIY+1LLdO+PcYC/zd/PrsaOlrY2JTa+GspO1WdXxlJzuYmAb
    GlUyvqUxH/myiwoWTFxbYXo2SG2swrFk6nI4nBtFngq6xTFff+EWYYbN7C4IXLXl
    0mDZJN0n2Qp2KbMBjSae9SmNe5dqeHRnKRtI+k7RIq9uTpuATf53hyTCBCB/roW0
    p5VKlRqqyEHnu+pMN4OeIrEuYJhOtNMKjHGv8zYA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIeciRKUHl6Myv+ARQap7AdnHLLbFzyY6QJ8NxzUAhm/L1NCfTws4Z4Jrw2T6kAxZIYJTG6gBrHVm2WNLHQBhGlwlt7Zg7wLUKPpArxBPi6owElL6uaW
    rDMjek0sDlynnug0bR4J8hr9/SCjvPgpV8RsC1A17jGhCk+amUuoG2ZE20hKSD80HjNyY8bxtJop1fA9GVSwieOMmMV3qq91la21jt0I7a518A7MpSc8jWcw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=Am4ss40yAAAA:8 a=VwQbUJbxAAAA:8 a=iSTSvJ5DvQXD3s9BySQA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=lf-hbUz_c89dky27wAWH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeDWIGs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 04:06:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754029AbeDWIGr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Apr 2018 04:06:47 -0400
Date: Mon, 23 Apr 2018 10:06:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: xuartps: Setup early console when uartclk
 is also passed
Message-ID: <20180423080641.GA20149@kroah.com>
References: <2ef5ac478f8d32bc807ead758eb5d60744a44515.1523367208.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ef5ac478f8d32bc807ead758eb5d60744a44515.1523367208.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 03:33:30PM +0200, Michal Simek wrote:
> Baudrate calculation depends on requested baudrate and uart clock.
> This patch is checking that uartclk is also passed.
> 
> The same logic is used 8250_early.c/init_port function.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/tty/serial/xilinx_uartps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> index b9b2bc76bcac..a654cda203c7 100644
> --- a/drivers/tty/serial/xilinx_uartps.c
> +++ b/drivers/tty/serial/xilinx_uartps.c
> @@ -1181,7 +1181,7 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
>  	/* only set baud if specified on command line - otherwise
>  	 * assume it has been initialized by a boot loader.
>  	 */
> -	if (device->baud) {
> +	if (port->uartclk && device->baud) {
>  		u32 cd = 0, bdiv = 0;
>  		u32 mr;
>  		int div8;
> -- 
> 1.9.1

This patch conflicts with the previous patch you sent: Subject: [PATCH]
serial: xuartps: Fix the early_console junk character issue

So, which one should I apply?

I've dropped both from my review queue now, please resend the one(s) you
want applied, in a patch series if needed.

thanks,

greg k-h
