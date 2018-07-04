Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B60C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6E220847
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JuZRrdFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6E220847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933801AbeGDMJa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:09:30 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:51726 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933214AbeGDMJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:09:28 -0400
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com [209.85.213.42]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w64C9OvC031551;
        Wed, 4 Jul 2018 21:09:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w64C9OvC031551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530706165;
        bh=ft6KmH9q5092SmBIQPnLvczfLS9SsAeqrjljgsZIkbE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=JuZRrdFcEzIhqMSp4KE2dYsbdDB1Gz78GWmqzRKn1YL2exg+2qdX5vROmL0wW/A1M
         sXMYqEOa5R/dj3703xywmOSWcq7CC0ofYNnQJyijtiyG/uHTzd4kvRhPWm7PIR2IMg
         qaJ2DwmP3mVPdL3kZjubEsbAKQQGQBkcIZosq0XBecJNjD6e2WXbLPd/SqjOIxvMXG
         Da5Gxeu3BWlfXNev8/me7NdeLOkthE94hmf3HFHe4IV0wfAtFCO2GwQLYnM4ogifhb
         NznQcmnRQOUxjGiJJxl8wOZb5pkat7CRI/SLsl9nBkx6GbPNoZzsJRGohA7vFC8jip
         x9EDOx+1QIyGA==
X-Nifty-SrcIP: [209.85.213.42]
Received: by mail-vk0-f42.google.com with SMTP id h22-v6so2961559vke.4;
        Wed, 04 Jul 2018 05:09:25 -0700 (PDT)
X-Gm-Message-State: APt69E04lf9vFrGt89yIuHwhoAeTJ1mn7hCNYtOrStUO5VJyaJlWU/Ud
        FTiCj6bI/M+uWc0vERxjRVwLE/Su5kEDaKMMfw8=
X-Google-Smtp-Source: AAOMgpecIS6gb4vXI0Q1IpIGTU2iyTA74GIsuRvxoQjR0XCEvRiyDcMiYRKjWkVngMBFTWVt8QQLlyIT3PUc28db/t8=
X-Received: by 2002:a1f:c944:: with SMTP id z65-v6mr910901vkf.11.1530706164478;
 Wed, 04 Jul 2018 05:09:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 05:08:43 -0700 (PDT)
In-Reply-To: <87efgk0xx7.fsf@notabene.neil.brown.name>
References: <152929708853.17463.17302660556961083137.stgit@noble>
 <152929772052.17463.10728056000221362647.stgit@noble> <CAK7LNAR2n_Kf7HEwWgLwH8sjyVAiJUWkvV7ZAbkNn0KgVTUx1Q@mail.gmail.com>
 <87efgk0xx7.fsf@notabene.neil.brown.name>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 4 Jul 2018 21:08:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS22VUQytcX=BQt48qeAn9Rq00Sb555Gu98J+=8R_3OVA@mail.gmail.com>
Message-ID: <CAK7LNAS22VUQytcX=BQt48qeAn9Rq00Sb555Gu98J+=8R_3OVA@mail.gmail.com>
Subject: Re: [PATCH 4/5] kbuild: disable KBUILD_MODNAME when building for mod.a
To:     NeilBrown <neilb@suse.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-04 7:14 GMT+09:00 NeilBrown <neilb@suse.com>:
> On Wed, Jun 27 2018, Masahiro Yamada wrote:
>
>> 2018-06-18 13:55 GMT+09:00 NeilBrown <neilb@suse.com>:
>>> When building an object to be included in mod.a we
>>> cannot know the name of the module.  So don't define
>>> KBUILD_MODNAME.  This will ensure attempt to use
>>> that macro when the module name isn't know will
>>> trigger an error.
>>
>> Honestly, I hate KBUILD_MODNAME.
>>
>> If KBUILD_MODNAME is undefined,
>> you cannot call pr_debug() in the sub-directory for example.
>
> I think this is only true if you have something like
>
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> in your .c files.  Developers who use modobj-m could be advised not to
> do this.
>
>>
>> CONFIG_DYNAMIC_DEBUG requires KBUILD_MODNAME,
>> but people often miss to notice that, then cause build errors.
>
> Yes, I can see that.
> We could change it to use a default ("no-name") if KBUILD_MODNAME isn't
> defined.  Or we could require that KBUILD_MODNAME always be defined.
>
> Where I've been using these patches I've sometimes been adding
>
>   ccflags-y += -DKBUILD_MODNAME='"FOO"'
>
> to Makefiles so that modules_params get handled correctly on non-module
> builds.  I've thought about instead allowing "modobj-name" to be defined
> and requiring that it be set if either modobj-[yn] is set.  Then it gets
> used for the KBUILD_MODNAME when building modobj modules.
>
> Would you prefer to always require KBUILD_MODNAME, or to use a default
> name for dynamic-debug?
>
> Thanks,
> NeilBrown


I prefer flat directory structure for modules.
Most of modules fit in a single directory.


-- 
Best Regards
Masahiro Yamada
