Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4067627-1524173851-2-14542185402499029892
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='ch',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524173850; b=aa8HcsizOVTB/7qMdjbFdBgBQz7e8cn6c6cAj7XHGSWcWydiqn
    HSI/o3ZrOipXAfnB/h0QENiNpfR+3IVKwmOgx5yMCPNTwzIr9RgzJSTpeIgFkvar
    gJ9nkdtxzwk/t9ysVIYRtLCOy4UUB7dE2J6rTSYiXAStl/YtLHWL/9wqamSAUiHM
    qbYSCY252/iRNaEr/q7rgA6y38guKjWYIU8qybsqNvXhBxK4f4RpKIL/+BVDIbRD
    ughCcyE4D/60jhuBsZyz7P79pavwFNxpVL6AW3cgM/LSuA4BbZC9866JF1bunmXQ
    iiXIRGtqZLKeO4yJ7QEz3h0vEjxMcbOpMVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-type
    :content-transfer-encoding:date:from:to:cc:subject:in-reply-to
    :references:message-id:sender:list-id; s=fm2; t=1524173850; bh=P
    e6xY4y5hdOKgI7VlpCbGloI4xVod/7o1IEi3si2YEE=; b=BiXCoUCDn7caqylNG
    cwwRTQb+NiiZPGEjE7W5Fmx6nxqVjJ44apxfNeh8BPaJ9LfARxJVPLPgEYlS0yVr
    A97FsFxhFJU90p6upZLzCve39+ghcWhXXCO5Ibhe/Thpxnz7SwFSkFbNURPwufN2
    7xW+T/CdRlvLqLdWN/VjmPZEOSM38rAHCWjBN2qlGDXUTVC4a8BlimZFGJyXZdy1
    7iZKFe3p87QffmExx0qasg1DvyRMuRoTE+D9IJKmxwGeOzJV9N8rl/JY5uv6as4P
    Aeb5d9khYxHMXcSZP0dCNOzaDbmxjZ5mr7M2NNMUulMjg51pUyWoKSwPY6jAfq/N
    8Wv5Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=agner.ch header.i=@agner.ch header.b=VMIyefpR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=dkim;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=agner.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=agner.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=agner.ch header.i=@agner.ch header.b=VMIyefpR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=dkim;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=agner.ch;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=agner.ch header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOsB7hlsLRHsd7qU9LM/Hq84Ca0m9X5dbI9HwdFvP5GRSA7jg33AD1HygM3GNDLsYIXWD53giw0B6SKR/NXyvMWwzt3mwpRCw6kj0smSWHDYpMEeiNFJ
    G10M/+YoiqwbgC3V9MHPusu5Bui17YYqj6W1BOI0+i1wUnG/Tu6K01mjQvXOdVwuNaqOG2eFfwtgtckRPf8hoNFGbvXMuHtuyT9BcPhXWqVNW8ZOU0QE58Cc
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=tafdBIQG8V84kiX7VsYA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbeDSVh2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 17:37:28 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54100 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeDSVh1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Apr 2018 17:37:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Apr 2018 23:37:23 +0200
From: Stefan Agner <stefan@agner.ch>
To: u.kleine-koenig@pengutronix.de
Cc: gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: imx: fix cached UCR2 read on software reset
In-Reply-To: <20180416153502.11814-1-stefan@agner.ch>
References: <20180416153502.11814-1-stefan@agner.ch>
Message-ID: <581f0f26d7191aa3355a6c63b531f876@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Remote-Spamd-Result: default: False [-2.88 / 15.00];
         RCVD_TLS_ALL(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCPT_COUNT_FIVE(0.00)[5];
         TO_DN_NONE(0.00)[];
         FROM_HAS_DN(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-2.78)[99.05%];
         ARC_NA(0.00)[];
         DKIM_SIGNED(0.00)[]
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Uwe,

On 16.04.2018 17:35, Stefan Agner wrote:
> To reset the UART the SRST needs be cleared (low active). According
> to the documentation the bit will remain active for 4 module clocks
> until it is cleared (set to 1).
> 
> Hence the real register need to be read in case the cached register
> indcates that the SRST bit is zero.
> 
> This bug lead to wrong baudrate because the baud rate register got
> restored before reset completed in imx_flush_buffer.

Given that you reviewed my other patch rather quickly, you might have
overlooked this one?

Since it is a regression, this should go into v4.17 still...

--
Stefan

> 
> Fixes: 3a0ab62f43de ("serial: imx: implement shadow registers for UCRx
> and UFCR")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/tty/serial/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 91f3a1a5cb7f..4ff6bd6eb9ab 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -316,7 +316,7 @@ static u32 imx_uart_readl(struct imx_port *sport,
> u32 offset)
>  		 * differ from the value that was last written. As it only
>  		 * clears after being set, reread conditionally.
>  		 */
> -		if (sport->ucr2 & UCR2_SRST)
> +		if (!(sport->ucr2 & UCR2_SRST))
>  			sport->ucr2 = readl(sport->port.membase + offset);
>  		return sport->ucr2;
>  		break;
