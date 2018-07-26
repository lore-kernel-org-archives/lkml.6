Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D8AC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84B820891
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gk9Pu4wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84B820891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeGZKbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:31:15 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:53084 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeGZKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:31:14 -0400
X-Greylist: delayed 20685 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2018 06:31:13 EDT
Received: from mail-vk0-f53.google.com (mail-vk0-f53.google.com [209.85.213.53]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w6Q9FDrf019385;
        Thu, 26 Jul 2018 18:15:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w6Q9FDrf019385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532596514;
        bh=pv175VuLlus08+eA3yavVzHXVXo+9O0kn1waT0Utwpg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=gk9Pu4wjL7Xhqmk+jCa8rO4ccR9i4FEcI9DCey92FbYjmRWhbcyb124nAToTLHifN
         6sji8gXiH+AmAFjsbOUfk98/fA0zceSL0W8oIfa0ZO/fntrZwhi2qtwxYMGg64ZxTQ
         XX/NLN7dFByW6aw97RCD7GQnjrkNKAmXHBzGBJkpwpkhyn36esLx4mpaPS9lszYmD8
         Rbb81Xc5X5cGbAcrobicmT0Fs7tdqYMsMfsKSLW9mn7PuRsR7FMhFe2t9G5c30HxBh
         5ZtaSagGD2/5nKfCT2aDCg8mnFlI5Ee+Dm9ky0UyLDYAi6DM0wZBl0mOL5rzAI4KZu
         fAmtUDpaDMbog==
X-Nifty-SrcIP: [209.85.213.53]
Received: by mail-vk0-f53.google.com with SMTP id s17-v6so451595vke.10;
        Thu, 26 Jul 2018 02:15:13 -0700 (PDT)
X-Gm-Message-State: AOUpUlGsvF22DfvAbmo/gk/2g1wSqGPrEeHf6PnO4KmKBi8pVWw1Yy5e
        v4VTHJr/5b+lx9TQd5HXKJ03bkF3kAteQZJRYgY=
X-Google-Smtp-Source: AAOMgpdlyA5zXcYeA0lUeTimaYYyl24jDRMUF++m4FBc4sCmdk2Qpbn4++wUxQmmt0w5Cz1giMRUi2fvtKZW2HQhVP0=
X-Received: by 2002:a1f:5347:: with SMTP id h68-v6mr662954vkb.141.1532596512729;
 Thu, 26 Jul 2018 02:15:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7289:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 02:14:32
 -0700 (PDT)
In-Reply-To: <CAMuHMdUnYiLYO4hX3x6X7EZ8HnnOHXCPEUOXzPVJc=6s7VF+bQ@mail.gmail.com>
References: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
 <1532575736-20138-2-git-send-email-yamada.masahiro@socionext.com> <CAMuHMdUnYiLYO4hX3x6X7EZ8HnnOHXCPEUOXzPVJc=6s7VF+bQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 26 Jul 2018 18:14:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9nHCnq90tgomDnwF6RwSa9BGTnxqzgvVwqy-QBy+qxQ@mail.gmail.com>
Message-ID: <CAK7LNAT9nHCnq90tgomDnwF6RwSa9BGTnxqzgvVwqy-QBy+qxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: rename files and CONFIG options to have
 the same prefix
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geert,


2018-07-26 17:25 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Yamada-san,
>
> On Thu, Jul 26, 2018 at 5:33 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> As commit b6147490e6aa ("mmc: tmio: split core functionality, DMA and
>> MFD glue") said, these MMC controllers use the IP from Panasonic.
>>
>> TMIO (Toshiba Mobile IO) MMC was the first upstreamed user of this IP.
>> The common driver code was split and expanded as 'tmio-mmc-core', then
>> it become historical misnomer since 'tmio' is not the name of this IP.
>>
>> I pointed out this [1], and suggested to re-organize the names in the
>> form of:
>>
>>   <IP-name>.c            (common code for this IP)
>>   <IP-name>_tmio.c       (Toshiba Mobile IO)
>>   <IP-name>_sdhi.c       (Renesas SDHI)
>>   <IP-name>_uniphier.c   (Socionext UniPhier)
>>
>> The <IP-name> in my mind was 'mnsd' because names of Panasonic chips
>> are prefixed with 'MN'.
>>
>> This is the naming scheme as we see in dw_mmc* and sdhci-*.
>>
>> In the discussion with Wolfram Sang, my suggestion was rejected
>> because it implied drastic function renaming, which is too invasive.
>>
>> Ulf Hansson was still happy with file renaming to clarify the
>> relationship between variants.  So, the accepted solution was:
>>
>>  - Make 'tmio_mmc' the _right_ core name
>>  - Align all variant files with the same prefix.
>>  - Do not rename functions
>>
>> This commit renames files as follows:
>>
>>   tmio_mmc_core.c              -> tmio_mmc.c
>>   tmio_mmc.c                   -> tmio_mmc_original.c
>>   renesas_sdhi_core.c          -> tmio_mmc_sdhi.c
>>   renesas_sdhi.h               -> tmio_mmc_sdhi.h
>>   renesas_sdhi_internal_dmac.c -> tmio_mmc_sdhi_internal_dmac.c
>>   renesas_sdhi_sys_dmac.c      -> tmio_mmc_sdhi_sys_dmac.c
>
> I have mixed feelings about the last two renames, especially about the last
> one: SYS-DMAC is very Renesas-specific, as it's a separate IP block in
> Renesas SoCs.
> 1. Are there other SoCs using the same internal DMAC?

Probably no.

The original IP from Panasonic did not contain any internal DMA engine.

renesas_sdhi_internal_dmac.c is probably
the Resansas' own extension.


Panasonic also implemented a different internal DMA engine
(Socionext inherited the RTL from Panasonic).

This is completely different from the Renesas' implementation.



>    If not, perhaps the "renesas" should be kept in the driver name?


I do not mind that, but the file name would be very long
"tmio_mmc_renesas_sdhi_internal_dmac.c"

Or, do you mean "tmio_mmc_renesas_internal_dmac.c" ?



> 2. Are there other SoCs using an external DMAC?


Yes.  Some old SoCs in UniPhier SoC family rely on
the external DMAC, like renesas_sdhi_sys_dmac.c


>    Is the interface to the external DMAC similar?
>    If yes, perhaps it should be renamed to tmio_mmc_sdhi_external_dmac.c?


"sdhi" is already Renesas-specific name, isn't it?

I really do not care, "sys" or "external"
It is up to renesas folks .


>    If not, perhaps the "renesas" should be kept in the driver name?


I am not quite sure, but this is less Renesas-specific
since renesas_sdhi_sys_dmac.c is just a software abstraction layer.
The real driver code is under drivers/dma/.

The difference is, in my case, TX and RX share a single DMA channel.


Thanks.



> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
