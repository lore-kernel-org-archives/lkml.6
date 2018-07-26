Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507E9C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A53320673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A53320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeGZJld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:41:33 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:44190 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbeGZJlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:41:32 -0400
Received: by mail-vk0-f65.google.com with SMTP id 125-v6so394514vke.11;
        Thu, 26 Jul 2018 01:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1y5Rp01PfeeHXvOINiDoQQMbvmJbzsYktBZC90b63k=;
        b=fwRWWfeUKsyCqv3GA/DP1u5d9KeH1+0F8tq1bvIS9Ip+6MFGNl+CBw+HfUhpfISAUx
         H/4dzTPjbmV1XRZGzVe3e8ZHQZEmu5ywLfRWqULevPe/JG/AK4tI6t1/gerkae7J3rxr
         kABPTNXnDY6+veeJYDHXO9j4UYHHFDkDwnoX9xnFou90tG9ZerJHoeOr3kfD8OvJiITb
         9y6FSsSAnOnmxetTVzgpR0Qf0A3GinPTveSOa90tS0Lc6xM2/ykj+tDJB011X8fwfPL8
         2ib6p5cfrRZX9gIqnsGQzltW3xvM5DHZeCG05ikgmGkBmy5n0UGbMn1JVHfNo5IFueDR
         pJtg==
X-Gm-Message-State: AOUpUlHg6Mcj05LMg93BxpX6Jq3vtbZhgvEbaRzF6qlzpAgUUy/lOLIo
        EaxHhQmGxcmwilqxUoPy8/azVF9H0OyE85JisUQ=
X-Google-Smtp-Source: AAOMgpe5JnBkALgdLT0+wCiLtlb2PB9bEKHTs9Q61HRV1246QqqwPew8x9i3/+vxvAnp/b6vNqAB1SMmoQ1pNUoC9uY=
X-Received: by 2002:a1f:9cc4:: with SMTP id f187-v6mr534960vke.87.1532593547997;
 Thu, 26 Jul 2018 01:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com> <1532575736-20138-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1532575736-20138-2-git-send-email-yamada.masahiro@socionext.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Jul 2018 10:25:34 +0200
Message-ID: <CAMuHMdUnYiLYO4hX3x6X7EZ8HnnOHXCPEUOXzPVJc=6s7VF+bQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: rename files and CONFIG options to have
 the same prefix
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Thu, Jul 26, 2018 at 5:33 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> As commit b6147490e6aa ("mmc: tmio: split core functionality, DMA and
> MFD glue") said, these MMC controllers use the IP from Panasonic.
>
> TMIO (Toshiba Mobile IO) MMC was the first upstreamed user of this IP.
> The common driver code was split and expanded as 'tmio-mmc-core', then
> it become historical misnomer since 'tmio' is not the name of this IP.
>
> I pointed out this [1], and suggested to re-organize the names in the
> form of:
>
>   <IP-name>.c            (common code for this IP)
>   <IP-name>_tmio.c       (Toshiba Mobile IO)
>   <IP-name>_sdhi.c       (Renesas SDHI)
>   <IP-name>_uniphier.c   (Socionext UniPhier)
>
> The <IP-name> in my mind was 'mnsd' because names of Panasonic chips
> are prefixed with 'MN'.
>
> This is the naming scheme as we see in dw_mmc* and sdhci-*.
>
> In the discussion with Wolfram Sang, my suggestion was rejected
> because it implied drastic function renaming, which is too invasive.
>
> Ulf Hansson was still happy with file renaming to clarify the
> relationship between variants.  So, the accepted solution was:
>
>  - Make 'tmio_mmc' the _right_ core name
>  - Align all variant files with the same prefix.
>  - Do not rename functions
>
> This commit renames files as follows:
>
>   tmio_mmc_core.c              -> tmio_mmc.c
>   tmio_mmc.c                   -> tmio_mmc_original.c
>   renesas_sdhi_core.c          -> tmio_mmc_sdhi.c
>   renesas_sdhi.h               -> tmio_mmc_sdhi.h
>   renesas_sdhi_internal_dmac.c -> tmio_mmc_sdhi_internal_dmac.c
>   renesas_sdhi_sys_dmac.c      -> tmio_mmc_sdhi_sys_dmac.c

I have mixed feelings about the last two renames, especially about the last
one: SYS-DMAC is very Renesas-specific, as it's a separate IP block in
Renesas SoCs.
1. Are there other SoCs using the same internal DMAC?
   If not, perhaps the "renesas" should be kept in the driver name?
2. Are there other SoCs using an external DMAC?
   Is the interface to the external DMAC similar?
   If yes, perhaps it should be renamed to tmio_mmc_sdhi_external_dmac.c?
   If not, perhaps the "renesas" should be kept in the driver name?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
