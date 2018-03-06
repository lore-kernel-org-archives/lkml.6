Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3033004-1520297447-2-5535946063236763657
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520297446; b=RZa23ErcCnqbOohLl9iQUHorpVk5v4xzK1xwZXX9+FLpPtK
    p4r8kDXfh41gRdpUeKEOyDQ4RI+hrtSZAkidWIcjftAb1gJOy6yRNGTGEXUHONx6
    yAjSPHXRpH3B0vJgGWTOedu1OfS9sNRTCVwURouENQBU7QmKWeO02qkdmXaWJdQa
    3qoAoKJJgL0WtIRLMl2AwsOQZwinXwN1dSSr1AX/D9Nsu/5SAubzXgUG2cvESosH
    p6AI88fUlaMFeYQ3h+0SYrSkmlEeIVVJedlh2Nca5RQ7uYKUynOA9BbqwSA09qWZ
    HJihuY+Wx60H4eAYP804xo5U3r/5nX2Opu+r4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520297446; bh=YpNwsWhgNLAJuDssea1zAiChkZ
    VELHYdR4gZTfG8XVA=; b=rbVJfp3MCaFCsMOHGtCSdtHlLbLwQh2XOABNiugqgU
    2ttzB8QFrI7Lokkeixt+n3TYhGzusPdEFfIWlF7nJsNbJQ1fJJkUyl7Q2B8G8HKx
    tnV9K5W7Kwjxle2PQH2lh5zaPV9R0RFQSjYH6DY17uCeTakiIsACU0VZ11CR1aH4
    NF8fPNqcIgbux6YkQvlg5gnIRTEWY8cRlw403vExpfmHjJZBnyW4y1qe5mTl4Ezt
    CtvjdlGSRa7lJMNtHFx2VW+5FkoDJ+Rp++U0mxJESJ45hn6AO8pA84BEA8ILIKf9
    +AWj0HyUKXSR28PXk4l8+JQ++aeckpwRJujYBxgbLmpg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CY6haDWs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CY6haDWs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932706AbeCFAue (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 19:50:34 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42823 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbeCFAud (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Mar 2018 19:50:33 -0500
X-Google-Smtp-Source: AG47ELt1qdtf5AGYUl5goCW03r1c5RxVnmwGs4aBhDREl8K686aWt7fzs+mNoxGCM5ZcSv1hb9NO/g==
Date: Mon, 5 Mar 2018 18:50:31 -0600
From: Rob Herring <robh@kernel.org>
To: Bich HEMON <bich.hemon@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] serial: stm32: update interrupt initialization
Message-ID: <20180306005031.fqwlwd2yodly4i7k@rob-hp-laptop>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
 <1519815044-22669-3-git-send-email-bich.hemon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519815044-22669-3-git-send-email-bich.hemon@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:51:17AM +0000, Bich HEMON wrote:
> For each port, get each IRQ using its specific name instead of its index.
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  drivers/tty/serial/stm32-usart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 0fa735b..5c85cbc 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -680,8 +680,8 @@ static int stm32_init_port(struct stm32_port *stm32port,
>  	port->flags	= UPF_BOOT_AUTOCONF;
>  	port->ops	= &stm32_uart_ops;
>  	port->dev	= &pdev->dev;
> -	port->irq	= platform_get_irq(pdev, 0);
> -	stm32port->wakeirq = platform_get_irq(pdev, 1);
> +	port->irq	= platform_get_irq_byname(pdev, "event");
> +	stm32port->wakeirq = platform_get_irq_byname(pdev, "wakeup");

This change is not necessary. The interrupts should be at fixed indices.

>  	stm32port->fifoen = stm32port->info->cfg.has_fifo;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -- 
> 1.9.1
