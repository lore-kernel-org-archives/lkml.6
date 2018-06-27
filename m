Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DBCC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4897A26983
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Q21XrLW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4897A26983
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeF0Fx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:53:26 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:26389 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751909AbeF0FxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:53:24 -0400
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com [209.85.217.182]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w5R5rFw9008153;
        Wed, 27 Jun 2018 14:53:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w5R5rFw9008153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530078796;
        bh=yFHIIteyquzKu2r7Fzxo0AUnrIxGzboRjed1eZ4jo7o=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Q21XrLW2bBx3YlYJi9d+FpRq1ir6BgghhI+MM2U0sB8RKyY4szUhf4ykncipI29y/
         EEK6wKoMmWoMiit1dOMjiYQL7e3xnrKLE/bFvi6MWWP4QqQkxf5GE8vRQvA+hGvdwf
         MCe0pZNjhepskVHEs4DWPPweh+g3hKZHN2NNvPTiLctkBlTNFi6e3TtT9lvJRbp35e
         QZDceTgisjFDf6zHLNyuU1n1E6IOTuBLcp2Q+Z//wHazSN38z5EAMPONAnizHBwDM+
         X0WjTWwnwwY4Ev3c0hL7IfGZjtJrLlYQWofVoiWa1H6J2Cfo++tVwDtmBDGNtskG4O
         FXYVpI3Jp19NQ==
X-Nifty-SrcIP: [209.85.217.182]
Received: by mail-ua0-f182.google.com with SMTP id z16-v6so502788uaz.10;
        Tue, 26 Jun 2018 22:53:15 -0700 (PDT)
X-Gm-Message-State: APt69E1fDKhPq2DldFr/24Ivzb1jikgzZI2jdsXYyAv+2MYbDa097fom
        due+ylTzuRf4jxI0/7JGjhRWjmvDn8lSySFDiE4=
X-Google-Smtp-Source: AAOMgpetgsR24ot2Ngvi30EyVQ4N/6J4DSJvkpMQOqYnX4riFCKDR7pQ00ltyYcgSi3kOFF6iQfh3jyKalmp0F47Jho=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr2813414uae.199.1530078794462;
 Tue, 26 Jun 2018 22:53:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 22:52:33
 -0700 (PDT)
In-Reply-To: <152929772052.17463.10728056000221362647.stgit@noble>
References: <152929708853.17463.17302660556961083137.stgit@noble> <152929772052.17463.10728056000221362647.stgit@noble>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 27 Jun 2018 14:52:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2n_Kf7HEwWgLwH8sjyVAiJUWkvV7ZAbkNn0KgVTUx1Q@mail.gmail.com>
Message-ID: <CAK7LNAR2n_Kf7HEwWgLwH8sjyVAiJUWkvV7ZAbkNn0KgVTUx1Q@mail.gmail.com>
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

2018-06-18 13:55 GMT+09:00 NeilBrown <neilb@suse.com>:
> When building an object to be included in mod.a we
> cannot know the name of the module.  So don't define
> KBUILD_MODNAME.  This will ensure attempt to use
> that macro when the module name isn't know will
> trigger an error.

Honestly, I hate KBUILD_MODNAME.

If KBUILD_MODNAME is undefined,
you cannot call pr_debug() in the sub-directory for example.

CONFIG_DYNAMIC_DEBUG requires KBUILD_MODNAME,
but people often miss to notice that, then cause build errors.





> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  scripts/Makefile.lib |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index c84167169a59..d09246474f2e 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -96,7 +96,7 @@ subdir-ym     := $(addprefix $(obj)/,$(subdir-ym))
>  # Finds the multi-part object the current object will be linked into.
>  # If the object belongs to two or more multi-part objects, all of them are
>  # concatenated with a colon separator.
> -modname-multi = $(subst $(space),:,$(sort $(foreach m,$(multi-used),\
> +modname-multi = $(subst $(space),:,$(sort $(foreach m,$(multi-used) modobj.o,\
>                 $(if $(filter $*.o, $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))),$(m:.o=)))))
>
>  modname = $(if $(modname-multi),$(modname-multi),$(basetarget))
> @@ -106,7 +106,7 @@ modname = $(if $(modname-multi),$(modname-multi),$(basetarget))
>  # end up in (or would, if it gets compiled in)
>  name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
>  basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
> -modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname))
> +modname_flags  = $(if $(filter-out modobj,$(modname)),-DKBUILD_MODNAME=$(call name-fix,$(modname)))
>
>  orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) \
>                   $(ccflags-y) $(CFLAGS_$(basetarget).o)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
