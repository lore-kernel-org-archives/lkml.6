Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD48EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA482084D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZquVS+/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA482084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeH2A0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:26:52 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38382 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeH2A0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:26:50 -0400
Received: by mail-qk0-f193.google.com with SMTP id g197-v6so1934354qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KVglm/7RrnF1zMs3Awdaxp7YI4R/EGlFbfAACEtaaDY=;
        b=ZquVS+/T2ti7xGivXoNveNwgBpX8/wzwEuB6Q8VEQwmf/0/bMw0AaMUiGzTs8UeUIA
         4KBBWS7WYDPx/09eT3nyotLgrkvJIGBaRj5li+HIu8WjfTf3OhYXcxMst4h6/OWz8z6X
         DzaofkDguHoMyZ38UWcnK1PrTQGFz4xaq6a0hqmelAUAJcY+qakOApGrHqbdmKYlpgXS
         Y3L04EkeRVJmEK3EUMUZzZ7jpHh9tVLpuSiAzbqKBtBwsSkUC1rSCLUe+xFHfdo5Hroz
         PR3fqnzraDA/RaTGDs3LjeXtsyGemeVZF6B0nXtk8NGie852S4OnUxJjgR85M4Qu4EKz
         aLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KVglm/7RrnF1zMs3Awdaxp7YI4R/EGlFbfAACEtaaDY=;
        b=LWuxx6uS8+StATLfMsrerStcb75ZYZ1MBwMgLXQGqbZ5MbP34fYLYTUHUmEsyDbnvs
         0wi32VBqv1tSaHrr/bp2lMy4hiJ544+1UFG/XmVZC3ElcIQ3WXNhiwibTpETb8JiU/Qa
         vltqhiT0IK4NBr7y6tcGb0PNkxja3X3IJV1xeq42KkHzWEZTCVCeSLfvZTh0T6/e9eBd
         Ou2N5eQmmkt6TkCf8xnb9pxHHwXu3J+r01Tbtjtca8cgXFhtM3KUiSzKUBiR8oeD4eKD
         g4Mep+maFyevtxR2CT6jeOb8c4QnIIgW3JhCvhTNn8gsc6/xVaY1LIEt8/owxjGbafns
         gHbQ==
X-Gm-Message-State: APzg51BuJsS83TjVd9iVdornmg4YoUUp4rOQdw3ENoHdZyPCR2I5fceK
        5yMbOeEAGWA6bVm5i0gO6aYvdixOj2+7yAkv9K4=
X-Google-Smtp-Source: ANB0VdY7P4piXW40yzFAB2BmmmLaXQ2V5a0nluzRhIxj+oLVbchI4rlmGBZIUhcLexzX1uDhAqI/ZHPFScKC7+Pn8PY=
X-Received: by 2002:a37:1204:: with SMTP id c4-v6mr3298287qkh.63.1535488410890;
 Tue, 28 Aug 2018 13:33:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 13:33:10
 -0700 (PDT)
In-Reply-To: <CAKwvOdmSOGRDaCUgsEnEd=uyf83FzrRhJt-E3VnzX4FzDwPFWw@mail.gmail.com>
References: <20180826175748.GA29525@gmail.com> <CAKwvOdnyHctAYRBOdrkX15MBPX68pOSiKc2P2S_JnDdffdY+OA@mail.gmail.com>
 <CAKwvOdk3PjNtjMcsXxRVvKLNcT+O_=5D1B7DXNWcwxwcMqdV2w@mail.gmail.com>
 <CANiq72nV_sVGgQuZra2gqOXHnbtCYWZDBMRW=EeeLK3qTL99ew@mail.gmail.com> <CAKwvOdmSOGRDaCUgsEnEd=uyf83FzrRhJt-E3VnzX4FzDwPFWw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 28 Aug 2018 22:33:10 +0200
Message-ID: <CANiq72=0SPHyjQjKXyv1wojFG7R54Y3k7eqbk_66cOqrc-R0bw@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: Use feature checking instead
 of version checks for attributes
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Aug 28, 2018 at 7:05 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> On Tue, Aug 28, 2018 at 8:10 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> I addressed that in the email I sent afterwards:
>>
>> """
>> Note that:
>>   - assume_aligned came with gcc 4.9
>>   - no_sanitize_address came with gcc 4.8
>>
>> So if we feel it is important to have them there (before gcc 5), we
>> would need here a quick version check here.
>> """
>>
>> The idea is that, in the future, whenever gcc 5 or later is the
>> minimum version, we just get rid of the #ifdef block without touching
>> the rest of the code :-)
>
> So if __has_attribute came with gcc 5, then that means that this patch
> will break assume_aligned for gcc-4.9 users and no_sanitize_address
> for gcc-4.8 and gcc-4.9 users?  The slab allocator uses
> assume_aligned, and no_sanitize_address for CONFIG_KASAN.  Should this
> patch ever come back through stable, Android and ChromeOS
> gcc-4.9/KASAN builds will break.
>

Indeed, KASAN requires it:

          This is strictly a debugging feature and it requires a gcc version
          of 4.9.2 or later. Detection of out of bounds accesses to stack or
          global variables requires gcc 5.0 or later.

So we should just support it. However, __no_sanitize_address is only
used when CONFIG_KASAN is enabled (to define __no_kasan_or_inline). So
I would say it is an attribute for a particular CONFIG (like those of
sparse). Therefore, I think we should simply remove
__no_sanitize_address for general use (let's see how it looks).

For __assume_aligned, it is "only" an optimization, but I think it is
a general one, so we should keep it in attributes.h; I will simply add
the gcc 4.9 support knowledge.

On that topic: actually, some of the attributes that we have that are
"required" are not really "required" in the strict sense: we could
test for them; but I wanted to minimize the amount of noise for gcc <
5 since we have to manually write the support table (and anyway most
compilers support them). Whenever we are past gcc 5 in a few years, we
could actually test for the non-strictly-required attribute if we want
to be extra nice to new compilers :-)

> I don't think we should leave that for a follow up; I would like to
> see it as part of this patch.  It's ok to have explicit version checks
> for those 2 attributes since it's not possible to feature detect them
> for the versions of gcc that we support in this code base.  I think
> you should add them in a v2 of this patch.  Then we can point to this
> commit as the *shining example* of how to do proper feature detection,
> falling back to version checks only as a last resort.

Thanks for the kind words!

I also read your other comments in the previous email -- no comments
on those. I will prepare v2.

Cheers,
Miguel
