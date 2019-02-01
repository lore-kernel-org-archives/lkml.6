Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D1DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9103E21872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTbMwTpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfBAKLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:11:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56184 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfBAKLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:11:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so5422470wmc.5;
        Fri, 01 Feb 2019 02:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tQss5XY1in0Ch/QSiFhhlFeW8ftdKCddtzhbVyHetU0=;
        b=LTbMwTpNJLvXx/kUQ2ixglM++Tghi/f5C4rp0sXDrPdYubeRsnIsfXICQnd3WdExtK
         jWO8gO4h/HviPrwG6EoSCgHaH95mJgG3y9yx4FVXM2RwSVmEp5DoW0CX2dFvWz6/1Q6D
         FJT5Mj13JqveiDN5193vuZ/qfCdqYuAUbi0WJXPxf8NPR5HPkkj/pc6pbFfJLp0BzPIf
         9i6WGZW6GuqaItTZH8s3QA00fbQA69sggtcX/aWNMR2mG87G+YnO4FULMvXmHXZ90bP/
         qcWgQNu6guUsLhH/cl63QtllAbtu7nbjf05HYTu7IEXzdPYmTUWyetsCp4wxjLnvdDrh
         T/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tQss5XY1in0Ch/QSiFhhlFeW8ftdKCddtzhbVyHetU0=;
        b=JXtWFQqqn1YrDnVD1d1gaDAFIQyfgSoEI38w8wvCuq6RKlVrzdGs6RjjY07Vd+OBdg
         xX7IFRsCTecKTiHvyyLdbowj2uMiMQn7CdfSvE6yxgMl8OY0U70QgPp8TvoduHLVNxBU
         eEn7pa33Qe4okvwZBw4Mp8K82jhUf/2qd05cgq7WdlHD/jM7jFYPLEIxADbVbfIUZZYF
         ildScwRHykOh9HQwWpf72B4JR23DSE1/akzjntoagcTQ9OXsL31kyWUgVxUuSniKjrqw
         BVJmbKLpSwdlX6+FWvvJvz9J4OieLkvRQeUkiOpC6yVElluf6oJmFxdAX7x1QDrO6+VU
         tC5w==
X-Gm-Message-State: AHQUAuZ1tveW17Oid+OpXtV5MjHGq8J+9/wU4jxTR3Rm0/yMQU+Q2+qR
        +spMg+BZzEiJgqlJ2enTp41Y+Uqo
X-Google-Smtp-Source: AHgI3IbvCrZ4NBeOKvJJ40HFzb9DFFcEuxv7ALtQ8RFl9Pdmum1itt+Ujoi9Yx6NFhcl1YRtDuuSuQ==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr1763632wmu.52.1549015859665;
        Fri, 01 Feb 2019 02:10:59 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id a14sm711892wrr.13.2019.02.01.02.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 02:10:58 -0800 (PST)
Date:   Fri, 1 Feb 2019 11:10:56 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Julien Masson <jmasson@baylibre.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: meson_uart: Add support for kernel debugger
Message-ID: <20190201101056.GA10039@Red>
References: <1549015162-17418-1-git-send-email-jmasson@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549015162-17418-1-git-send-email-jmasson@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 10:59:22AM +0100, Julien Masson wrote:
> The kgdb invokes the poll_put_char and poll_get_char when communicating
> with the host. This patch implement the serial polling hooks for the
> meson_uart to be used for KGDB debugging over serial line.
> 
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> ---
> It has been tested on "Le Potato" board:
> https://libre.computer/products/boards/aml-s905x-cc/
> 
> Kernel command line arguments:
> kgdboc=ttyAML0,115200 kgdbretry=4 nokaslr kgdbcon
> 
> Kernel modules:
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_FRAME_POINTER=y
> CONFIG_KGDB=y
> CONFIG_KGDB_SERIAL_CONSOLE=y
> 
> Warning: for single step instruction I had to apply this patch:
> https://lore.kernel.org/patchwork/patch/562423/
> 
>  drivers/tty/serial/meson_uart.c | 46 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 8a84259..49b20da 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -426,6 +426,48 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
>  	}
>  }
>  
> +#ifdef CONFIG_CONSOLE_POLL
> +/*
> + * Console polling routines for writing and reading from the uart while
> + * in an interrupt or debug context (i.e. kgdb).
> + */
> +
> +static int meson_uart_poll_get_char(struct uart_port *port)
> +{
> +	u32 c;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	if (readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY)
> +		c = NO_POLL_CHAR;
> +	else
> +		c = readl(port->membase + AML_UART_RFIFO);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	return c;
> +}
> +
> +static void meson_uart_poll_put_char(struct uart_port *port, unsigned char c)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
> +		cpu_relax();

Hello

Perhaps you could use read_poll_timeout() ?
This will also permit to handle the timeout case.

Regards

