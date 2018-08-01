Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06B9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E53520894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiR3ydm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E53520894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbeHALUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:20:05 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39254 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388755AbeHALUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:20:05 -0400
Received: by mail-it0-f68.google.com with SMTP id g141-v6so8442403ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=10Q/mwMLMGA9oZEfe1egaNvTdQXsOV5LfMCi9OfQ6T8=;
        b=MiR3ydm0yael2v4sLqxLLo/Bgqvaph44iomIcUrj3xpWcuuaL9XgleG2krHTFHtk64
         fkPoNTbOHLgtjpR/pkgp7GdhcEee7KVN1AOJlFofgTa9haLGqL25RVWU/cRkk5cCVLDG
         4KndO7Mqew4qrrhO+i1AWpvOCw8BoMZ/8XdFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=10Q/mwMLMGA9oZEfe1egaNvTdQXsOV5LfMCi9OfQ6T8=;
        b=Ud4t/T/TBU0gTqx6RYv9C4I4sKUJSKQ4t3JpYx7pSlvIU90C6ZX+22z3WJXADbxNqD
         sWyF3vGz3ccvZo3ckMyzRebCGfvIoxD21kSWQeSoIupcePHv4yRlcdxnFUIxLBSe9jNy
         oadssyY8VmcBaIXot+D8PNmlDOuRn4W10GaVaeEkARjWy6jVrjnh+U1xiK2btqHNwXvw
         nVtw4J5K9jTTWZzmhQVYvz55+GEwTBWyTI+bmTXqZlRl0V+d2vhzQWKhgDgNN2IQ8AWQ
         JEjbHmLSHvdApxPvr0DwTo1ljuT9tiPlaJc/H4+YghRCmYBZ6BZMd5NRyO67kNZca+qY
         J61Q==
X-Gm-Message-State: AOUpUlGjyTxtYC8FWFobWKDeqzrOk5uuFSTv3Yzd7cYxeBV5ulgkqnkQ
        zxofDYtp5q4+FiFkzP38Nl2dTm7QdqofCQ0YRCev0w==
X-Google-Smtp-Source: AAOMgpdkJYor2+uOQLEfxqTgrfAvhoypxPfw0IRkjTUVWZkY0T0qh8+iN6pFGAWoUdfE3/Bh1LBuiC4/sDgsx6qVhLA=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr2956491itc.102.1533116112687;
 Wed, 01 Aug 2018 02:35:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 02:35:12 -0700 (PDT)
In-Reply-To: <CAK7LNAScJFUPK=mMmNWYw-yJ9iaxaibituYRDU2x5kGpbsEd5A@mail.gmail.com>
References: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
 <1532575736-20138-2-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFpK=UnwdNtb3XcgcRBJZeE0X5osM-tk8E85TCs3CeDq7Q@mail.gmail.com> <CAK7LNAScJFUPK=mMmNWYw-yJ9iaxaibituYRDU2x5kGpbsEd5A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Aug 2018 11:35:12 +0200
Message-ID: <CAPDyKFph7X=SvG4=DhRf0eiLcKcX=tD42QAO96q9S+Ebecn20w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: rename files and CONFIG options to have
 the same prefix
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 July 2018 at 14:12, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 2018-07-31 0:07 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>> On 26 July 2018 at 05:28, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>>> As commit b6147490e6aa ("mmc: tmio: split core functionality, DMA and
>>> MFD glue") said, these MMC controllers use the IP from Panasonic.
>>>
>>> TMIO (Toshiba Mobile IO) MMC was the first upstreamed user of this IP.
>>> The common driver code was split and expanded as 'tmio-mmc-core', then
>>> it become historical misnomer since 'tmio' is not the name of this IP.
>>>
>>> I pointed out this [1], and suggested to re-organize the names in the
>>> form of:
>>>
>>>   <IP-name>.c            (common code for this IP)
>>>   <IP-name>_tmio.c       (Toshiba Mobile IO)
>>>   <IP-name>_sdhi.c       (Renesas SDHI)
>>>   <IP-name>_uniphier.c   (Socionext UniPhier)
>>>
>>> The <IP-name> in my mind was 'mnsd' because names of Panasonic chips
>>> are prefixed with 'MN'.
>>>
>>> This is the naming scheme as we see in dw_mmc* and sdhci-*.
>>>
>>> In the discussion with Wolfram Sang, my suggestion was rejected
>>> because it implied drastic function renaming, which is too invasive.
>>>
>>> Ulf Hansson was still happy with file renaming to clarify the
>>> relationship between variants.  So, the accepted solution was:
>>>
>>>  - Make 'tmio_mmc' the _right_ core name
>>>  - Align all variant files with the same prefix.
>>>  - Do not rename functions
>>>
>>> This commit renames files as follows:
>>>
>>>   tmio_mmc_core.c              -> tmio_mmc.c
>>>   tmio_mmc.c                   -> tmio_mmc_original.c
>>>   renesas_sdhi_core.c          -> tmio_mmc_sdhi.c
>>>   renesas_sdhi.h               -> tmio_mmc_sdhi.h
>>>   renesas_sdhi_internal_dmac.c -> tmio_mmc_sdhi_internal_dmac.c
>>>   renesas_sdhi_sys_dmac.c      -> tmio_mmc_sdhi_sys_dmac.c
>>>
>>> Also rename CONFIG options to match to the file names:
>>>
>>>   MMC_TMIO_CORE          -> MMC_TMIO
>>>   MMC_TMIO               -> MMC_TMIO_ORIGINAL
>>>   MMC_SDHI               -> MMC_TMIO_SDHI
>>>   MMC_SDHI_SYS_DMAC      -> MMC_TMIO_SDHI_SYS_DMAC
>>>   MMC_SDHI_INTERNAL_DMAC -> MMC_TMIO_SDHI_INTERNAL_DMAC
>>>
>>> I touched eseries_pxa_defconfig and pxa_defconfig in this commit
>>> because they are inactive, but renaming of CONFIG options generally
>>> takes some development cycles.  Old names will be kept until the
>>> migration is completed, like Renesas folks did when they renamed
>>> ARCH_SHMOBILE_MULTI to ARCH_RENESAS.
>>>
>>> [1] https://www.spinics.net/lists/linux-mmc/msg46952.html
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>
>> I am awaiting some feedback from Wolfram before applying.
>
>
>
> If this is not welcome, please feel free to throw away.
> (then, I will name my driver 'uniphier-sd.c')
>
> I am neutral about this renaming because it
> is trying to make the wrong thing correct.
>
>
> It will also produce a different inconsistency.
> Even if we rename renesas_sdhi_core.c to tmio_mmc_sdhi.c ,
> functions in it will be kept renesas_sdhi_*
> I understand they want to keep the file name and function names consistent.

Yes, we have discussed this, back an forth.

I have no strong opinions, but instead rely on you reaching an
agreement with Wolfram on the way forward.

[...]

Kind regards
Uffe
