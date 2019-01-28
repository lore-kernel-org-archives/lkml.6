Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AE3C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED402148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfA1Kxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:53:41 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45033 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1Kxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:53:40 -0500
Received: by mail-ua1-f65.google.com with SMTP id d19so5418476uaq.11;
        Mon, 28 Jan 2019 02:53:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bOlyTBUEweCe3JuQxgp8MY9eK0G+hUsxl/I9As77z/Y=;
        b=pcD9sCCDV7nEqgv3Xiw/O+OeEizCamxjBFAp8x5EOvtpeqLamhfK8dLlX47aFmCnV3
         RwPwt+S26tSuyvd6W/oQrp2YXFAvyvaTVitzlyuDWRVXwN583OP7AtBj5cY/VnVpEdU0
         jBOLewnUCv7VPT2wnigsjp02c7IdNkL3r5SHW67oEXTztB8TN/JcEoUXbk692wF3YzQw
         BEDCy+KnvZg34WvhXAh1dC9iwMWvG6oTYc1SxQkUDk7QOAVbi70fMtRdj5t88dqnTxHh
         vGa6Gr/rPPMBSvZivcdNhjcEjE2hpxlr8/nSWNGuGgUfeNEDj21RC5zLDpbOx5hVW/Vo
         jUFA==
X-Gm-Message-State: AJcUukcCXLVQJLmcwHpLOE8poxs+48dyNSQD0cSAWPfrskAoQMzz9J1o
        mcHVkkcl0e6WXdm8jT4A2xbPQMrIpwSTziHBqxw=
X-Google-Smtp-Source: AHgI3IZjzCLTebq7xFS15oojNgrpS73pIdQDcU3jk20zJ+EwbwsnJ8WzRuV9nIbipwmLPM6hDd7dbIOtapVzushFpl0=
X-Received: by 2002:a9f:2726:: with SMTP id a35mr5073826uaa.75.1548672819512;
 Mon, 28 Jan 2019 02:53:39 -0800 (PST)
MIME-Version: 1.0
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com> <1548667176-119830-2-git-send-email-zhouyanjie@zoho.com>
In-Reply-To: <1548667176-119830-2-git-send-email-zhouyanjie@zoho.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Jan 2019 11:53:27 +0100
Message-ID: <CAMuHMdWgYgMWD=oE6vCZtb1_-K5y19AHwn1WptLhJ47hc6Ah+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Serial: Ingenic: Add support for the X1000.
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Mark Rutland <mark.rutland@arm.com>, syq@debian.org,
        jiaxun.yang@flygoat.com, 772753199@qq.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

On Mon, Jan 28, 2019 at 10:23 AM Zhou Yanjie <zhouyanjie@zoho.com> wrote:
> Add support for probing the 8250_ingenic driver on the
> X1000 Soc from Ingenic.
>
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>

Thanks for your patch!

> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -145,6 +145,10 @@ EARLYCON_DECLARE(jz4780_uart, ingenic_early_console_setup);
>  OF_EARLYCON_DECLARE(jz4780_uart, "ingenic,jz4780-uart",
>                     ingenic_early_console_setup);
>
> +EARLYCON_DECLARE(x1000_uart, ingenic_early_console_setup);
> +OF_EARLYCON_DECLARE(x1000_uart, "ingenic,x1000-uart",
> +                   ingenic_early_console_setup);

As of commit 2eaa790989e03900 ("earlycon: Use common framework for
earlycon declarations") it is no longer needer to specify both
EARLYCON_DECLARE() and OF_EARLYCON_DECLARE().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
