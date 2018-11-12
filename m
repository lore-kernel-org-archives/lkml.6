Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3694DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CC6223C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CC6223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeKLSxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:53:19 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35629 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbeKLSxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:53:19 -0500
Received: by mail-vk1-f195.google.com with SMTP id b18so1789404vke.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIcfOyckyNp3JeUKe8m5MkW7sVHyTMhePIypgyfRcqI=;
        b=G/rPIkSODZ/At98/t/1lgDe82FsKVylXkJcJxgnXjs/WGe31NT24XHTYQOKcmEyPj5
         A2gtHlW1upDuLdxx0kT+DhDTQ2AEvBax+841A6+50UjaySok1CQ3+q+2so7UnGnlwiMp
         RDrl5CRgPb5XJyndbw7KihHb+riFKE0DwpZ6W05LzvW6BJSg8O2dS/mSCCd/DMbQkjfL
         vwMRrp2ZzTtWKCKOfLeLXoyD9VJKaO+ZcFsiPWZ6QAetyMUoHJ+AUSyuomxV32exm/2T
         xLd3MGMBbii8ypC8GM7HHoI4kd3E6I0WPitwlAVlbnftkAdRqmX9O/Zy0vEiF0jTxZTB
         pLiw==
X-Gm-Message-State: AGRZ1gJoxdZ3k/Kuqip5L3zxV6X4A+K36LGTgf5kzcg/5Kt0CSocPZMd
        jx6gHslj3nEsn2pD+atXyts5hIQzEOntBcHZ+sE=
X-Google-Smtp-Source: AJdET5fzvBlgCjrz+qGmfIJJc10ducwHhfG8725ijGi0ADavX+tD9ViqFFS9t//c/LnmvAQxmZC5710Fk6FrBpM/C64=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr39439vkh.65.1542013248636;
 Mon, 12 Nov 2018 01:00:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541995959.git.fthain@telegraphics.com.au> <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au>
In-Reply-To: <74edaee07800f91eb416ab3e72c4670b8ef4bd4e.1541995959.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Nov 2018 10:00:36 +0100
Message-ID: <CAMuHMdXdo+L-Ta04zUsL62RSt1HOvmPJs7HFu_zEnc38R0FPjA@mail.gmail.com>
Subject: Re: [RFC PATCH 06/13] m68k: Drop ARCH_USES_GETTIMEOFFSET
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philip Blundell <philb@gnu.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Joshua Thompson <funaho@jurai.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

Thanks for your patch!

On Mon, Nov 12, 2018 at 5:46 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> The functions that implement arch_gettimeoffset are re-used by
> new clocksource drivers in subsequent patches.

Disabling this first affects functionality during bisection, right?

> --- a/arch/m68k/amiga/config.c
> +++ b/arch/m68k/amiga/config.c
> @@ -95,8 +95,6 @@ static char amiga_model_name[13] = "Amiga ";
>  static void amiga_sched_init(irq_handler_t handler);
>  static void amiga_get_model(char *model);
>  static void amiga_get_hardware_list(struct seq_file *m);
> -/* amiga specific timer functions */
> -static u32 amiga_gettimeoffset(void);
>  extern void amiga_mksound(unsigned int count, unsigned int ticks);
>  static void amiga_reset(void);
>  extern void amiga_init_sound(void);
> @@ -386,7 +384,6 @@ void __init config_amiga(void)
>         mach_init_IRQ        = amiga_init_IRQ;
>         mach_get_model       = amiga_get_model;
>         mach_get_hardware_list = amiga_get_hardware_list;
> -       arch_gettimeoffset   = amiga_gettimeoffset;

In addition, won't this lead to "function defined statically but not called'
warnings?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
