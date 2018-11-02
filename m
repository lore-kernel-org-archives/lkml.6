Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2556C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3F72081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZZ5UCdf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3F72081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeKBUAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:00:48 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:35140 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKBUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:00:48 -0400
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wA2ArqMu027911;
        Fri, 2 Nov 2018 19:53:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wA2ArqMu027911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541156033;
        bh=bxcCeJk1bRXPwF1Rdb4SnBAsgEoyLFdGp+7crn78eFo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZZ5UCdf+5cK6UTNg3ny+qnNba3rL/tyw9GidSoxx2+c4PDaUs5k2cQmXlYY9lPmf8
         2AYLdeOjzykEe51zvI++8nM6pzFyjIgKk0GvGaF2UG6Xh8tsqGoca99fGm2nxeWv9B
         lTtc4vwv6ch10LCJqCA8BRMNTZWWxYrqP54ederVYjhUscV9y5oW6TAQl67zgvHl6x
         gIESoSEGJyPhpp5MWlx2WZ84jRS8U+9omyx3VoZ8+baLJUAB+GOYr345hREywfWrF3
         MPKvZsUCl7l7jYWx8kUNHsQ/ukgrpCjMRBLED2/fYQSsXLzUhe38yFK19aoyYJLTIf
         uQURfzupgEOLw==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id 197so329007vkf.4;
        Fri, 02 Nov 2018 03:53:52 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLTikKE/uarrG4LOFv+YVV3ZpPHjAVuG3ushSV4U/cgNGs3weH8
        mWmoj7KXfFCsLSSX5mEnZAzj/OXlo7sXN+nLq8I=
X-Google-Smtp-Source: AJdET5cOldqjcBcMutKxrlXxaUxebNSuf/d2R6+/2e0sEdYLRWHVI7HH1wEtFJOISb/PON5svaXmKVRgzVahhl7kUgE=
X-Received: by 2002:a1f:bd5:: with SMTP id 204mr661018vkl.84.1541156031755;
 Fri, 02 Nov 2018 03:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <1540873965-31342-1-git-send-email-yamada.masahiro@socionext.com> <945484cd-50b4-74df-f091-d796264e5643@nvidia.com>
In-Reply-To: <945484cd-50b4-74df-f091-d796264e5643@nvidia.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 2 Nov 2018 19:53:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNATZnacTqmA9=K5kvQAmHmAw5Qg3SEAtAx0SQxBGFBKKZQ@mail.gmail.com>
Message-ID: <CAK7LNATZnacTqmA9=K5kvQAmHmAw5Qg3SEAtAx0SQxBGFBKKZQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: consolidate single targets
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Fri, Nov 2, 2018 at 6:44 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 30/10/2018 04:32, Masahiro Yamada wrote:
> > Instead of specifying target/source pairs, let's list patterns that we
> > want to handle as single targets. This slightly changes the behavior;
> > the top Makefile previously checked the presence of a source file,
> > now Kbuild will descend into a subdirectory anyway to find out what to
> > do there.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  Makefile | 16 +---------------
> >  1 file changed, 1 insertion(+), 15 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index be76e6e..7d13add 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1713,21 +1713,7 @@ else
> >          target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
> >  endif
> >
> > -%.s: %.c prepare scripts FORCE
> > -     $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> > -%.i: %.c prepare scripts FORCE
> > -     $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> > -%.o: %.c prepare scripts FORCE
> > -     $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> > -%.lst: %.c prepare scripts FORCE
> > -     $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> > -%.s: %.S prepare scripts FORCE
> > -     $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> > -%.o: %.S prepare scripts FORCE
> > -     $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> > -%.symtypes: %.c prepare scripts FORCE
> > -     $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> > -%.ll: %.c prepare scripts FORCE
> > +%.i %.ll %.lst %.o %.s %.symtypes: prepare scripts FORCE
> >       $(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
> >
> >  # Modules
>
> On one of my build machines (an older ubuntu 14.04 machine), this is
> commit is causing 'make mrproper' or 'make distclean' to fail. Reverting
> this commit fixes the problem.
>
> $ make mrproper
> Error: kernelrelease not valid - run 'make prepare' to update it
>   CC      kernel/bounds.s
> In file included from <command-line>:0:0:
> ././include/linux/kconfig.h:5:32: fatal error: generated/autoconf.h: No
> such file or directory
>  #include <generated/autoconf.h>
>                                 ^
> compilation terminated.
> make[1]: *** [kernel/bounds.s] Error 1
> make: *** [prepare0] Error 2
>
> FWIW, this machine has ...
>
> $ make --version
> GNU Make 3.81


Confirmed.

For make 3.81 or 3.82, 'make clean' will fail,
but it will work by passing -r option.


masahiro@pug:~/ref/linux-next$ make-3.81   clean
make-3.81: Circular checkbin.o <- prepare dependency dropped.
  HOSTCC  scripts/basic/fixdep
  CC      scripts/mod/empty.o
In file included from <command-line>:0:0:
././include/linux/kconfig.h:5:32: fatal error: generated/autoconf.h:
No such file or directory
compilation terminated.
make-3.81[2]: *** [scripts/mod/empty.o] Error 1
make-3.81[1]: *** [scripts/mod] Error 2
make-3.81: *** [scripts] Error 2
masahiro@pug:~/ref/linux-next$ make-3.81  -r clean



I know how to fix it, but
I will drop the problematic commit for now.


Thanks.


-- 
Best Regards
Masahiro Yamada
