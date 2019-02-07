Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C5C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F4421872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E1cC3KC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfBGREl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:04:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39850 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGREk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:04:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so628410wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 09:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=bfb6XdLQBuwV8OQUhWtqHzyKLHZ6Wl3/PspPxQktHO4=;
        b=E1cC3KC5QRuzfMjm1loXWevDg4KYVtgl3C0NpApKqGDrPpTX+j6U8q4W2Gru3QJgMi
         KbWkVGm25qOxJkitEwOi2Adso7QZat2OA4xqSR66ywHFhgAxKVYi340a56QJiS6Mh5oK
         7OCp+o77YsLTMqyv8/p3/eU8XHoBm3Nbb9jsFGnhg+z0a6mpU5dMP0V4ZkDRdVHLMdxr
         0s5CnDv6H+TPcYldNp3dcHf8DX0rsyvfvSn6fDTh6rFzb5UVAuhNY7pvQAJPNOB6azz4
         +ulsoy72uQhm+MW7BRqD169R2LzOcM2/ERBAo54dPVjmpk/iNoT9XAkSTAmArloFUd6I
         MOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=bfb6XdLQBuwV8OQUhWtqHzyKLHZ6Wl3/PspPxQktHO4=;
        b=cTBM4mEThgWXLzLrlbPQTvvOlzg+pfwTmZbLmuq5Ls649opzxYIlbFGTFCsnH35Kw5
         9UDApArTnIC4NibtBTvILqrbeoDUGOnckmJutHJsQPtvE8iTTBbyEnjQNP9knvMxOEfo
         kD6oTsqIVbNRsoxrEvQWpRSoMr9ssR++YkOldSLTao2chS3agkVk/UP4a6LjYyow4t72
         XirTnGWKRP47apOUJ2hX1EhmSqL/RU74qZlLy+U/Tc5lM0KrChK5hcVZPzVUOAvBWBRD
         24JL/KfYLBZorXditJAj+QSpd/5Ng7ARXrd+xf7Ghf9eIx0gt0jl4pEvGGUgB7mcZ3nY
         FJ9w==
X-Gm-Message-State: AHQUAuajlrwVxpqCyQboTbL9NpnlKjvw5Ndx+ZyyhBc8+cdk49yoc6//
        0wuFb+wF3UIzYPVw1xj43h/rhg==
X-Google-Smtp-Source: AHgI3Ia5ui10ccrWbMmNQ/NJuuZmQ4YiNUr8ipyoy9mGTvpoCHQmNJubTEfhMAbo16y4L3UcRANGiQ==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr12577380wrv.287.1549559079224;
        Thu, 07 Feb 2019 09:04:39 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:a0f9])
        by smtp.gmail.com with ESMTPSA id g67sm38726172wmd.38.2019.02.07.09.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 09:04:38 -0800 (PST)
References: <1549015162-17418-1-git-send-email-jmasson@baylibre.com> <20190201101056.GA10039@Red>
User-agent: mu4e 1.1.0; emacs 26.1.50
From:   "Masson\, Julien" <jmasson@baylibre.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Julien Masson <jmasson@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: meson_uart: Add support for kernel debugger
In-reply-to: <20190201101056.GA10039@Red>
Date:   Thu, 07 Feb 2019 18:04:36 +0100
Message-ID: <86lg2rv8bf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 01 Feb 2019 at 11:10, Corentin Labbe <clabbe.montjoie@gmail.com> wrote:

> On Fri, Feb 01, 2019 at 10:59:22AM +0100, Julien Masson wrote:
>> The kgdb invokes the poll_put_char and poll_get_char when communicating
>> with the host. This patch implement the serial polling hooks for the
>> meson_uart to be used for KGDB debugging over serial line.
>> 
>> Signed-off-by: Julien Masson <jmasson@baylibre.com>
>> ---
>> It has been tested on "Le Potato" board:
>> https://libre.computer/products/boards/aml-s905x-cc/
>> 
>> Kernel command line arguments:
>> kgdboc=ttyAML0,115200 kgdbretry=4 nokaslr kgdbcon
>> 
>> Kernel modules:
>> CONFIG_DEBUG_INFO=y
>> CONFIG_DEBUG_KERNEL=y
>> CONFIG_FRAME_POINTER=y
>> CONFIG_KGDB=y
>> CONFIG_KGDB_SERIAL_CONSOLE=y
>> 
>> Warning: for single step instruction I had to apply this patch:
>> https://lore.kernel.org/patchwork/patch/562423/
>> 
>>  drivers/tty/serial/meson_uart.c | 46 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>> 
>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>> index 8a84259..49b20da 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -426,6 +426,48 @@ static void meson_uart_config_port(struct uart_port *port, int flags)
>>  	}
>>  }
>>  
>> +#ifdef CONFIG_CONSOLE_POLL
>> +/*
>> + * Console polling routines for writing and reading from the uart while
>> + * in an interrupt or debug context (i.e. kgdb).
>> + */
>> +
>> +static int meson_uart_poll_get_char(struct uart_port *port)
>> +{
>> +	u32 c;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&port->lock, flags);
>> +
>> +	if (readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY)
>> +		c = NO_POLL_CHAR;
>> +	else
>> +		c = readl(port->membase + AML_UART_RFIFO);
>> +
>> +	spin_unlock_irqrestore(&port->lock, flags);
>> +
>> +	return c;
>> +}
>> +
>> +static void meson_uart_poll_put_char(struct uart_port *port, unsigned char c)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&port->lock, flags);
>> +
>> +	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
>> +		cpu_relax();
>
> Hello
>
> Perhaps you could use read_poll_timeout() ?
> This will also permit to handle the timeout case.
>
> Regards

Thanks for the tips Corentin.

I tested with a poll of 5 usec and 1 msec of timeout.
I had to use readl_poll_timeout_atomic(...) since I'm in atomic context
(spinlock).

I'll send a v2 of this patch.

Regards
