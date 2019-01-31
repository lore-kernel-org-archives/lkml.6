Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CEAC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5684920B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cMUomSxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfAaSVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:21:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32976 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfAaSVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:21:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so1712505pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 10:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UIv7GZVd6Iq4DP1nNjOoNKOEOGE89AtKkvrJYpzQidU=;
        b=cMUomSxI9BN0AZ12R6NATTEiVWcuoxg0O+T6SxaIEKMMTPmJOjEkyA1mK9Pb9LN5RN
         LYFhg3buy6KzL1LJUz/q090F+FuTV0ctG8548apgsxYGjd9wdX5221MqR+ppIBwl9qQ7
         QuEgSQgHt9XuPK8ClcM3l4yrHCK28oN6kpXgAX4rv5UyWRPELsG5LjQ/IpJEBX+p4PXe
         ex8AFhBzR+Ji8yn1fjMvfzZU1bQ8V98t+4Lt8eGi3ypBKFbJkQ/nr/Wvicr6L8SWGkLN
         GTcscroVyfGxXqd53AeCin7AgJ6gL7/akIJOHBGZytqHQ99ULQwg6LINI4Os7LZzNCp7
         S5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UIv7GZVd6Iq4DP1nNjOoNKOEOGE89AtKkvrJYpzQidU=;
        b=VJoVziL7FTYp9F+2PvYT5lB62KqiQCE2RNY3ZHQBnRfI6TcyISFdl9oQgwrktaqcZn
         4xeT4zbeqCuxhoIwrqa3Fo2Lus0BX0s6Eu8RGOzd9VDeY/QrIlh6dzcblaR7z0mNf43h
         hL7LwIaD9bftJWnXnTaC7AsXbSLi/dRzqW7oCYfJoNQcjoNMeBzz1c4J5f1038VoPA33
         wZDYZ/YH3yBlE8WPIXqvp3Oy1oK9b9EACMSB4y5k6MGgp+MRIh5IzI1VtOH6n6rvoQFD
         tnZr783MaLV75S2DdytJGjHK2q3Y64dPAmu7M6FKGm/rbmSmzWtNoqHqG9ngrkKLCHcG
         SHsA==
X-Gm-Message-State: AJcUukfbKUMFI//rUWGEVzD3EPhgwfg6ZEiJMl4kbq1rnB8Dim+vhssw
        qWqbjuol/2Ua6KwLzcn5oI4UqRqMJx5smB4pZorSkQ==
X-Google-Smtp-Source: ALg8bN6fu/Hb7In2TvKsI9Z6tPx1iYdfuYXCq/N6S81InB0ETR9475EVKusvoQX+NBUcDjztEFW7c/TydUfXoDComPA=
X-Received: by 2002:a62:b80a:: with SMTP id p10mr35632082pfe.32.1548958876430;
 Thu, 31 Jan 2019 10:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20190131180627.19944-1-natechancellor@gmail.com>
In-Reply-To: <20190131180627.19944-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 31 Jan 2019 10:21:05 -0800
Message-ID: <CAKwvOdkHyfUOSNYD22adGtBfPeHA=HMGk5oM5R-9QP2u6uK1Rw@mail.gmail.com>
Subject: Re: [PATCH] serial: mps2-uart: Add parentheses around conditional in mps2_uart_shutdown
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jiri Slaby <jslaby@suse.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-serial@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 10:06 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/tty/serial/mps2-uart.c:351:6: warning: logical not is only
> applied to the left hand side of this bitwise operator
> [-Wlogical-not-parentheses]
>         if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
>             ^                ~
> drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses after the
> '!' to evaluate the bitwise operator first
>         if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
>             ^
>              (                                       )
> drivers/tty/serial/mps2-uart.c:351:6: note: add parentheses around left
> hand side expression to silence this warning
>         if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
>             ^
>             (               )
> 1 warning generated.
>
> As it was intended for this check to be the inverse of the one at the
> bottom of mps2_init_port, add parentheses around the whole conditional.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/tty/serial/mps2-uart.c
That function currently has the code:

if (mps_port->flags & UART_PORT_COMBINED_IRQ) {
  mps_port->port.irq = platform_get_irq(pdev, 0);
} else {
  mps_port->rx_irq = platform_get_irq(pdev, 0);
  mps_port->tx_irq = platform_get_irq(pdev, 1);
  mps_port->port.irq = platform_get_irq(pdev, 2);
}

while shutdown has:

if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
  free_irq(mps_port->rx_irq, mps_port);
  free_irq(mps_port->tx_irq, mps_port);
}

free_irq(port->irq, mps_port);

So port->irq is always assigned an irq, and rx_irq & tx_irq are
assigned only if !(mps_port->flags & UART_PORT_COMBINED_IRQ).

Yep, patch looks good. Thanks for fixing a real bug here, Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/344


>
> Fixes: 775ea4ea2fd9 ("serial: mps2-uart: support combined irq")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/tty/serial/mps2-uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
> index 4404eb7d118f..587b42f754cb 100644
> --- a/drivers/tty/serial/mps2-uart.c
> +++ b/drivers/tty/serial/mps2-uart.c
> @@ -348,7 +348,7 @@ static void mps2_uart_shutdown(struct uart_port *port)
>
>         mps2_uart_write8(port, control, UARTn_CTRL);
>
> -       if (!mps_port->flags & UART_PORT_COMBINED_IRQ) {
> +       if (!(mps_port->flags & UART_PORT_COMBINED_IRQ)) {
>                 free_irq(mps_port->rx_irq, mps_port);
>                 free_irq(mps_port->tx_irq, mps_port);
>         }
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
