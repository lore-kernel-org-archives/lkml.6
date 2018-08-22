Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167C4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B59214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Mu6/S0hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B59214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbeHVRoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:44:05 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:24483 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbeHVRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:44:05 -0400
Received: from mail-vk0-f42.google.com (mail-vk0-f42.google.com [209.85.213.42]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w7MEIpTc008009;
        Wed, 22 Aug 2018 23:18:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w7MEIpTc008009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534947532;
        bh=7Ux2G8t1mSt1jBZdiuQpIAJ/L+qe++ZLe9mcSDxpE7c=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Mu6/S0hdHUS8MiefqeKFlu6+1hPxgULDR8hidkB7kFwdEcSJerUuUxXvNj7VgkBEO
         qS66LJu29TCH+5zvgMvmUP0ooL0MAKQJJOrPGldnuxX7ufPyh6T2Kli9akmvbNnmeo
         nSg9y0SEyeqdGn2nNTZC9QAh7bF575yH2ygMpPVQGXer+DPak+vR4VcwWUTskoHnOI
         AAEU/PElIalCaTJQ4HOCiz87ByzGP6nr667bO8BRi2FZGPnqdV2N1kyTJtTMlhH9Gf
         u4spxeQVOnbDbNnzPtOO5dL3xuVXrRLrCrNz+ZmpmTh5qfGkKgoZzHNZZqw8OekMR2
         4E4TXSJ0aTkNg==
X-Nifty-SrcIP: [209.85.213.42]
Received: by mail-vk0-f42.google.com with SMTP id 125-v6so941354vke.11;
        Wed, 22 Aug 2018 07:18:51 -0700 (PDT)
X-Gm-Message-State: AOUpUlHV+dMKPbvjY7m11AAMjYk7ln8cbO5PpmJ95yxiqYY8i1U31jTP
        rkmDAkbr06CO/N6hiNv9jhkPku+7Vxsej408y6Q=
X-Google-Smtp-Source: AA+uWPw96YdnuLpwiOhWCUWlqh5k5IiszbPLFaOMfIQ2XzasVKukokC5sQUezxFxmBawP6b0xya9Ny6HYC5//yipl6E=
X-Received: by 2002:a1f:2cce:: with SMTP id s197-v6mr33795139vks.106.1534947530485;
 Wed, 22 Aug 2018 07:18:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 07:18:10
 -0700 (PDT)
In-Reply-To: <7c81314d-2c57-375d-d037-872faa70b227@gmail.com>
References: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com>
 <cfb66b67-f423-0c26-0b22-0d57a581b44a@gmail.com> <CAL_Jsq+iAxmKvZ+RAD-VSOWirYOxc52mJHU5f5gybhWwQn2w_g@mail.gmail.com>
 <7fba348e-9fd3-9661-248d-82917f8f6676@gmail.com> <CAK7LNATFbykSHcDZqovTZ0aN9kHvZw3Q4Mamb1gwMwRhg7_s-A@mail.gmail.com>
 <78d8984c-211a-65c3-ab43-b3c02373ef0a@gmail.com> <CAK7LNAR5aHQ9Vo=-KTg8fzmk-1Nxu8WaXUT9wHM2n9Wr4wHFYw@mail.gmail.com>
 <7c81314d-2c57-375d-d037-872faa70b227@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 22 Aug 2018 23:18:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQMBVZaQxbGAz-_9hU-NemmHU25GQ=OEvz9i+hr4KVs0w@mail.gmail.com>
Message-ID: <CAK7LNAQMBVZaQxbGAz-_9hU-NemmHU25GQ=OEvz9i+hr4KVs0w@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: consolidate include path options in Makefile
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank

2018-08-22 3:02 GMT+09:00 Frank Rowand <frowand.list@gmail.com>:
> On 08/21/18 00:18, Masahiro Yamada wrote:
>> Hi Frank,
>>
>>
>> 2018-08-21 14:37 GMT+09:00 Frank Rowand <frowand.list@gmail.com>:
>>> On 08/20/18 19:08, Masahiro Yamada wrote:
>>>> Hi Frank,
>>>>
>>>> 2018-08-21 10:31 GMT+09:00 Frank Rowand <frowand.list@gmail.com>:
>>>>> On 08/20/18 14:32, Rob Herring wrote:
>>>>>> On Mon, Aug 20, 2018 at 1:55 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>>
>>>>>>> On 07/03/18 18:59, Masahiro Yamada wrote:
>>>>>>>> It is tedious to specify extra compiler options for every file.
>>>>>>>> HOST_EXTRACFLAGS is useful to add options to all files in a
>>>>>>>> directory.
>>>>>>>>
>>>>>>>> -I$(src)/libfdt is needed for all the files in this directory
>>>>>>>> to include libfdt_env.h etc. from scripts/dtc/libfdt/.
>>>>>>>>
>>>>>>>> On the other hand, -I$(src) is used to include check-in headers
>>>>>>>> from generated C files.  Thus, I added it only to dtc-lexer.lex.o
>>>>>>>> and dtc-parser.tab.o .
>>>>>>>>
>>>>>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>>  scripts/dtc/Makefile | 18 ++++--------------
>>>>>>>>  1 file changed, 4 insertions(+), 14 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
>>>>>>>> index 9cac65b..1c943e0 100644
>>>>>>>> --- a/scripts/dtc/Makefile
>>>>>>>> +++ b/scripts/dtc/Makefile
>>>>>>>> @@ -9,21 +9,11 @@ dtc-objs    := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>>>>>>>>  dtc-objs     += dtc-lexer.lex.o dtc-parser.tab.o
>>>>>>>>
>>>>>>>>  # Source files need to get at the userspace version of libfdt_env.h to compile
>>>>>>>> +HOST_EXTRACFLAGS := -I$(src)/libfdt
>>>>>>>
>>>>>>> Shouldn't that be += instead of :=?
>>>>>>
>>>>>> I don't think so. The definition is local to the file (and reset
>>>>>> before each makefile is included).
>>>>>>
>>>>>> Rob
>>>>>>
>>>>>
>>>>> Every other place where HOST_EXTRACFLAGS is assigned a value, += is used
>>>>> instead of :=, including the example in Documentation/kbuild/makefiles.txt
>>>>>
>>>>> What makes scripts/dtc/Makefile different than the other makefiles?
>>>>>
>>>>> -Frank
>>>>>
>>>>
>>>>
>>>> := and += work in the same way in here.
>>>
>>> Unless I do: HOST_EXTRACFLAGS=xxx make
>>> where "xxx" is some random flag I feel like adding in a particular build.
>>
>>
>>
>> This is not the intended usage of HOST_EXTRACFLAGS.
>
> I seem to have found a useful feature for making a specific object in a
> development context with additional compiler flags.  But a feature that
> you say is not intended.
>
> I do understand that there is an intended difference between HOSTCFLAGS
> and HOST_EXTRACFLAGS.  But I do not agree that using HOST_EXTRACFLAGS
> on the make commandline when building a single object in a development
> context is abuse.
>
>
>> HOST_EXTRACFLAGS is supposed to be set by Makefile in the kernel tree.
>
> But it is not set, thus it is currently available (and has been for many
> years) for the usage that I specified above.



Right.  People often find something that happens to work.



HOST_EXTRACFLAGS=xxx make

works, but

make HOST_EXTRACFLAGS=xxx

does not because it really overrides += in makefiles.



>
>> Documentation/kbuild/makefiles.txt explains this:
>>
>>        To set flags that will take effect for all host programs created
>>        in that Makefile, use the variable HOST_EXTRACFLAGS.
>>
>>
>>
>> If you want to pass additional host compiler flags,
>> please use HOSTCFLAGS instead.
>
> That will not work because the top level Makefile has:
>
>    HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \
>
>
>> Documentation/kbuild/kbuild.txt lists officially supported
>> environment variables / command line variables.>
>>     HOSTCFLAGS
>>     --------------------------------------------------
>>     Additional flags to be passed to $(HOSTCC) when building host programs.
>
> HOSTCFLAGS is not in my 4.18.0 Documentation/kbuild/kbuild.txt.  What version are
> you looking at?
>
>   $ git log -n1
>   commit 94710cac0ef4ee177a63b5227664b38c95bbf703
>   Author: Linus Torvalds <torvalds@linux-foundation.org>
>   Date:   Sun Aug 12 13:41:04 2018 -0700
>
>       Linux 4.18
>   $ git grep HOSTCFLAGS Documentation/kbuild/kbuild.txt
>   $

Please check the latest Linus tree.

Commit f92d19e0ef9bbbb2984845682e740934ad45473b
was merged in this MW.



>
> But this is where I concede that HOST_EXTRACFLAGS is also not listed as
> an officially supported environment variable or command line variable.  I
> had not checked here for that limitation.
>
>
>>
>>
>> Maybe I should add
>>
>> HOST_EXTRACFLAGS   :=
>> HOST_EXTRACXXFLAGS :=
>>
>> to the top of scripts/Makefile.build
>> to reset the variables explicitly
>> in case people try to abuse them.
>
> Yes, if you intend that it not be possible to initialize them in the make
> command then you should initialize them.  If you do that, it is easy
> enough for me to patch the initialization out in cases where I want the
> extra functionality.






-- 
Best Regards
Masahiro Yamada
