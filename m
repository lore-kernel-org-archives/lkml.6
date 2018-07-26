Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159B7C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF1C2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF1C2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeGZKoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:44:15 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41874 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeGZKoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:44:15 -0400
Received: by mail-ua0-f195.google.com with SMTP id t14-v6so638783uao.8;
        Thu, 26 Jul 2018 02:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hcen07q/AogxYhU47MbvqScCxdALLBWJ1zIesvZ2+M=;
        b=YqIdJiOdAXiD0JhkAtTKhkWFa4IvSm5UC5wIucjgr0PuCmlcyd3XOz6RQ+BaZY5zyT
         HiLYxlLel8C58FHyfGstBjkYWQPubxMmInr3a3IhFlsicdjNIg/y8PACfHidvb3ohXsl
         /zzl7xe7indmXbL8nAtrybzy7nveDChgrsfLZ4Pd48Hc2dUoSagcTEx0V44yyx+degml
         oA+ojl3F2gR0bIUmxkw13KfsIRH5kkUXMPBWXshs8bMJvlQmCDWHuA5rqcSxX4rqcU7R
         iEabDtd9DkOWJ3fIE57C3sTbV5H1Q0vXUunJs7AW/I50VRv6O5PMKEib2Lzk3MbqYru0
         m/KA==
X-Gm-Message-State: AOUpUlG+n/YvDy9phAA57S01wmaVL5ZBWI/n/IS0JDXaBr1zhGFZszJm
        u0hVu4q3vzJh2iXy+VgbQWRIPoJukqzmgRR8gEs=
X-Google-Smtp-Source: AAOMgpfxlc3DfLwe8BY0ZutAVz5yteLtHtWQITQSoGJmp7U/aDuIqrU07uh1+XClg/0XhV6OcUacp6DW/b8FIzeIVnk=
X-Received: by 2002:ab0:5b57:: with SMTP id v23-v6mr769356uae.72.1532597296074;
 Thu, 26 Jul 2018 02:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
 <1532575736-20138-2-git-send-email-yamada.masahiro@socionext.com>
 <CAMuHMdUnYiLYO4hX3x6X7EZ8HnnOHXCPEUOXzPVJc=6s7VF+bQ@mail.gmail.com> <CAK7LNAT9nHCnq90tgomDnwF6RwSa9BGTnxqzgvVwqy-QBy+qxQ@mail.gmail.com>
In-Reply-To: <CAK7LNAT9nHCnq90tgomDnwF6RwSa9BGTnxqzgvVwqy-QBy+qxQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Jul 2018 11:28:04 +0200
Message-ID: <CAMuHMdX3zaeXsw799xnWKcZdVjP3r_n=NM-ihXzuSbnU5xF5jw@mail.gmail.com>
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

On Thu, Jul 26, 2018 at 11:15 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-07-26 17:25 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> > On Thu, Jul 26, 2018 at 5:33 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> >> This commit renames files as follows:
> >>
> >>   tmio_mmc_core.c              -> tmio_mmc.c
> >>   tmio_mmc.c                   -> tmio_mmc_original.c
> >>   renesas_sdhi_core.c          -> tmio_mmc_sdhi.c
> >>   renesas_sdhi.h               -> tmio_mmc_sdhi.h
> >>   renesas_sdhi_internal_dmac.c -> tmio_mmc_sdhi_internal_dmac.c
> >>   renesas_sdhi_sys_dmac.c      -> tmio_mmc_sdhi_sys_dmac.c
> >
> > I have mixed feelings about the last two renames, especially about the last
> > one: SYS-DMAC is very Renesas-specific, as it's a separate IP block in
> > Renesas SoCs.

> > 2. Are there other SoCs using an external DMAC?
>
> Yes.  Some old SoCs in UniPhier SoC family rely on
> the external DMAC, like renesas_sdhi_sys_dmac.c
>
> >    Is the interface to the external DMAC similar?
> >    If yes, perhaps it should be renamed to tmio_mmc_sdhi_external_dmac.c?
>
> "sdhi" is already Renesas-specific name, isn't it?

Right, I'm mixing up SDHI and SDHC.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
