Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0A1C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54AD21A5E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oMKqeJ+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54AD21A5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeHGEdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:33:15 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:32369 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeHGEdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:33:14 -0400
Received: from mail-ua0-f172.google.com (mail-ua0-f172.google.com [209.85.217.172]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w772L2KQ029849;
        Tue, 7 Aug 2018 11:21:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w772L2KQ029849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533608463;
        bh=4zSGsf3r7nysg0Dn3FjsfvM4gdLlFZuWajRfGqdSuvc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=oMKqeJ+tqQofTtZ1N9gWkRTtxz21Q2nS8fZMDUSG7Rw34lscV6IBGItWv3tI7U1P6
         zdfI2yIRoL7+f++IBGfrBOf689WTGLxQZ89cVo5nv0f5ccnVQYeSVy0VNJeI/l2hVm
         CD03W8OcjqIGLIpZi0yRH+ojFGOI0G+mxIRBHSl2HOYWIxPLDvGA4LgIOJjv7js2OY
         d1IIVAFOQ9jteqLTD00jrsYZozHUceAinqCU7uh0ZTs/9OWGynlaAnuSDX3OKQ3FQb
         9T0PNMyr3DlX8uR9czRuITCn8YCLaMwlvGI1cCaiQMs72zWNkbIaK4nJDwr2gk34EA
         6AvBzkv7tz5yQ==
X-Nifty-SrcIP: [209.85.217.172]
Received: by mail-ua0-f172.google.com with SMTP id g18-v6so14472288uam.6;
        Mon, 06 Aug 2018 19:21:03 -0700 (PDT)
X-Gm-Message-State: AOUpUlGa3y9GRDLmZDmjFyODDVnQ+DuGOQB/5I/eGtt4RHSxx7ErLBqr
        +Tc0GF3EYPK4romxmBP7lUelw32JAdh5KHHWHfs=
X-Google-Smtp-Source: AAOMgpcxxoCBdIVzata8JN+HNRrruGXLO3nABVOnSyTSygLYsoQ9uVNhpMMue4YA3gpasvF0sjV7xOtPbyCTb18BVb0=
X-Received: by 2002:a1f:bc06:: with SMTP id m6-v6mr10844783vkf.10.1533608462150;
 Mon, 06 Aug 2018 19:21:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 19:20:21 -0700 (PDT)
In-Reply-To: <20180807105955.06c70fc8@canb.auug.org.au>
References: <20180806103738.794c479d@canb.auug.org.au> <20180806222401.3d68fb28@canb.auug.org.au>
 <20180807105955.06c70fc8@canb.auug.org.au>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 7 Aug 2018 11:20:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFjpxxVje=5vUF88kQVYJxaYzZbPwDzqkC6hKwgscpuw@mail.gmail.com>
Message-ID: <CAK7LNATFjpxxVje=5vUF88kQVYJxaYzZbPwDzqkC6hKwgscpuw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the vfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-07 9:59 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi all,
>
> On Mon, 6 Aug 2018 22:24:01 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> On Mon, 6 Aug 2018 10:37:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> >
>> > After merging the vfs tree, today's linux-next build (x86_64 allmodconfig)
>> > failed like this:
>> >
>> > samples/statx/test-fsinfo.c:26:10: fatal error: linux/fsinfo.h: No such file or directory
>> >  #include <linux/fsinfo.h>
>> >           ^~~~~~~~~~~~~~~~
>> >
>> > Caused by commit
>> >
>> >   90b413cb970a ("vfs: syscall: Add fsinfo() to query filesystem information")
>> >
>> > I guess that headers_install (or whatever its called) has not bee run
>> > before the sample code is built.
>> >
>> > I have applied the following patch for today:
>> >
>> > From: Stephen Rothwell <sfr@canb.auug.org.au>
>> > Date: Mon, 6 Aug 2018 10:29:34 +1000
>> > Subject: [PATCH] vfs: don;t build new sample programs yet
>> >
>> > It seems that headers_install is not done before the samples
>> > are build so some needed include files are not in the right place.
>> >
>> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> > ---
>> >  samples/statx/Makefile | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/samples/statx/Makefile b/samples/statx/Makefile
>> > index 05b4d30cdd3c..0b4d01822eca 100644
>> > --- a/samples/statx/Makefile
>> > +++ b/samples/statx/Makefile
>> > @@ -1,5 +1,5 @@
>> >  # List of programs to build
>> > -hostprogs-$(CONFIG_SAMPLE_STATX) := test-statx test-fsinfo test-fs-query
>> > +hostprogs-$(CONFIG_SAMPLE_STATX) := test-statx
>> >
>> >  # Tell kbuild to always build the programs
>> >  always := $(hostprogs-y)
>>
>> It turns out that commit
>>
>>   ba5214f7f40c ("vfs: Implement parameter value retrieval with fsinfo()")
>>
>> removed the "depends on BROKEN" from CONFIG_SAMPLE_STATX and that
>> breaks other builds (at least allyesconfig on s390).
>
> I have added the following suggested patch (I am sorry I can't
> find/remember who pointed me to this patch) for today (I guess that it
> should be merged via the vfs tree as that is what is causing the build
> failures ... in which case a real patch should be supplied with
> appropriate SOB line).  This seems to fix the current problem.
>
> From: Masahiro Yamada <yamada.masahiro@socionext.com>
> Date: Tue, 7 Aug 2018 10:33:43 +1000
> Subject: [PATCH] Try to get the headers installed before we build the samples
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 9e71826f67d7..d224d94c14be 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1023,6 +1023,7 @@ endif
>  # Build samples along the rest of the kernel
>  ifdef CONFIG_SAMPLES
>  vmlinux-dirs += samples
> +samples: headers_install
>  endif
>
>  # The actual objects are generated when descending,
> --


OK, I will queue this up to my tree.


I suggested this in the discussion:
https://patchwork.kernel.org/patch/10552353/

I did not get response, though.




-- 
Best Regards
Masahiro Yamada
