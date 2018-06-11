Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0024BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E0820869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYxJloE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E0820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934206AbeFKVDE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:03:04 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34091 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933394AbeFKVDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:03:02 -0400
Received: by mail-vk0-f68.google.com with SMTP id q135-v6so13140721vkh.1;
        Mon, 11 Jun 2018 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TBsKDxQNgcErenXGavhLA/H0ypc17pbOJM8i3gQ768U=;
        b=pYxJloE9SFGCB8zTW+RkJTjiBUoHoonvtRmc0L/Iwr6HdLD37lKVUvhH56j/DVg1c6
         lLfAqupdSxFVDM6qZ6RN7JLjShDF8DIQT07w952uJ0E3vRbUuF/ElMeCyr2nmZ9pBjDm
         LQcVraZfSmh3AC1vhBmdo0W4xPzICgbp4nj7DJPiQR0fEsQ5AIaMiuHgVs6pchhTHa3K
         cesqNbB7EH3vEiS7BpoMeKs01moUPKrCvxOJ3xklFFH1Yff5naEi+N31l/PyfM5OKNkJ
         H2PQY6L5B6VrCTQVOXeB/hq1ecxI7Eo/yOi6XfmIFFZuqh5ON+HumSJbh0u3JF/CXN3C
         zQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TBsKDxQNgcErenXGavhLA/H0ypc17pbOJM8i3gQ768U=;
        b=Lm6Oo7oSMEtONU3pPslndM7XGuwWyxSz23B1os4v44cG3FQ9BBLQwX8JIgpIAXU2fI
         HWRSLa7MTebvBjoyrECi3AQE9zUPwE9AuKAi91FA6/VVAQzJCJyfRUuNlnkGPyfCWVs1
         53Lw/zF0uH/4hXP2TqXs7T66UfVEfFRyKieXEdy83G1fuIyf6Yo8Z4r1a8QmHMfq88M2
         3LeoA6XQQyweiTOnYEW55/orB7Cx5A7utSSK5iNADyH7MI1EQlBRPkHtAHKwFYr2b90/
         zyH6YP869dVXRuCUYj9ZOy3UM2LX0etitMoBgYNT/7ZhJ5cH5N0MfZs/VhPBrn3KcA96
         YEZA==
X-Gm-Message-State: APt69E27V2YSR155mgv1C/hO5eiO1N4vg2QG9tkuJiKFT/frwMcwOy5G
        8otZspgOeEuhZLI9zg+qHz9Ssrd9/xhaLgn314U=
X-Google-Smtp-Source: ADUXVKKMOz2k3rxZx5wOyerOMT+iPoN82t2knj1nr9zgOPKznn6UPrjY5RlExtm72E7naazxQDW5g0cfQjtXnMTA6g4=
X-Received: by 2002:a1f:d1c5:: with SMTP id i188-v6mr479260vkg.131.1528750981660;
 Mon, 11 Jun 2018 14:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <1528310824-12706-1-git-send-email-clabbe@baylibre.com>
In-Reply-To: <1528310824-12706-1-git-send-email-clabbe@baylibre.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jun 2018 00:02:50 +0300
Message-ID: <CAHp75Ve3nDsoEh0dL=xF3oei_GM9tPn_72=je+FESO=hJFm4uA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: 8250_dw need to depend on COMMON_CLK
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 10:27 PM Corentin Labbe <clabbe@baylibre.com> wrote:
>
> This patch fix the following build error on M68K:
> drivers/tty/serial/8250/8250_dw.o: In function `dw8250_set_termios':
> 8250_dw.c:(.text+0x50c): undefined reference to `clk_round_rate'
> 8250_dw.c:(.text+0x594): undefined reference to `clk_set_rate'
>
> So 8250_dw need to depend on COMMON_CLK.
>

Makes sense.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/tty/serial/8250/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index f005eaf8bc57..37d4ec5f3cc9 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -351,7 +351,7 @@ config SERIAL_8250_FSL
>
>  config SERIAL_8250_DW
>         tristate "Support for Synopsys DesignWare 8250 quirks"
> -       depends on SERIAL_8250
> +       depends on SERIAL_8250 && COMMON_CLK
>         help
>           Selecting this option will enable handling of the extra features
>           present in the Synopsys DesignWare APB UART.
> --
> 2.16.4
>


-- 
With Best Regards,
Andy Shevchenko
