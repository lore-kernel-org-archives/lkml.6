Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22FEC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BC22152D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="A+hmr9l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BC22152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeHUKiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:38:20 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:26401 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeHUKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:38:20 -0400
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com [209.85.213.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w7L7JF00015219;
        Tue, 21 Aug 2018 16:19:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w7L7JF00015219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534835956;
        bh=piJ4YOaLew6AimOarTAtHPOhz4LT6LYRd/szMnWMqDM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=A+hmr9l95rH/GP1fIgpwfjh40Xa3eiqhUOoTbuWxL5qllG+7Ibnod3dWJtsdkH76p
         cOUYp00zqY12lpq5Wm4KUs4rfBa+WftST4pYmpmHEB0R5u4/0fRTZV9K3CkJ58Wp8a
         rNiaOQzbjp0dVGrZIXbZCwzDRi3x0ofHOdE2D8r9AmYrlgWBe/r6U2CAG3G9ETp3qo
         p77hlsBxUx8YCMdXt1oeC+vZJFA24b8vbjA7C8JYm3uzC27nOrz9+r3Z7zlZzNebVs
         90f5htuSndTCuMizv//MWWvlKSQ/TlZdnKGnElYjpXmWG0u8WiYoeqF125y5qlSk+G
         jfDSQ4RChoVEQ==
X-Nifty-SrcIP: [209.85.213.44]
Received: by mail-vk0-f44.google.com with SMTP id l143-v6so7750201vke.1;
        Tue, 21 Aug 2018 00:19:15 -0700 (PDT)
X-Gm-Message-State: APzg51DshCBOl4BM9pvq6Kn5FF0P+vhHihbwCpGtV7B6nAIa9TiDuPDM
        OVc/gLmss5nfVK3UsyarB+z7nqQzWXCsG6Sh1w0=
X-Google-Smtp-Source: ANB0VdYfSJwl3/LGlDWz2CLuw/ece++R9ijZqsxi2V6ZxFN8x4LzebmI2Ksl1THn1WbiBJ0rJGxY/zUBpW6Q3/ApMv0=
X-Received: by 2002:a1f:f8c2:: with SMTP id w185-v6mr1557278vkh.135.1534835954647;
 Tue, 21 Aug 2018 00:19:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 21 Aug 2018 00:18:34
 -0700 (PDT)
In-Reply-To: <78d8984c-211a-65c3-ab43-b3c02373ef0a@gmail.com>
References: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com>
 <cfb66b67-f423-0c26-0b22-0d57a581b44a@gmail.com> <CAL_Jsq+iAxmKvZ+RAD-VSOWirYOxc52mJHU5f5gybhWwQn2w_g@mail.gmail.com>
 <7fba348e-9fd3-9661-248d-82917f8f6676@gmail.com> <CAK7LNATFbykSHcDZqovTZ0aN9kHvZw3Q4Mamb1gwMwRhg7_s-A@mail.gmail.com>
 <78d8984c-211a-65c3-ab43-b3c02373ef0a@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 Aug 2018 16:18:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR5aHQ9Vo=-KTg8fzmk-1Nxu8WaXUT9wHM2n9Wr4wHFYw@mail.gmail.com>
Message-ID: <CAK7LNAR5aHQ9Vo=-KTg8fzmk-1Nxu8WaXUT9wHM2n9Wr4wHFYw@mail.gmail.com>
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

Hi Frank,


2018-08-21 14:37 GMT+09:00 Frank Rowand <frowand.list@gmail.com>:
> On 08/20/18 19:08, Masahiro Yamada wrote:
>> Hi Frank,
>>
>> 2018-08-21 10:31 GMT+09:00 Frank Rowand <frowand.list@gmail.com>:
>>> On 08/20/18 14:32, Rob Herring wrote:
>>>> On Mon, Aug 20, 2018 at 1:55 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>
>>>>> On 07/03/18 18:59, Masahiro Yamada wrote:
>>>>>> It is tedious to specify extra compiler options for every file.
>>>>>> HOST_EXTRACFLAGS is useful to add options to all files in a
>>>>>> directory.
>>>>>>
>>>>>> -I$(src)/libfdt is needed for all the files in this directory
>>>>>> to include libfdt_env.h etc. from scripts/dtc/libfdt/.
>>>>>>
>>>>>> On the other hand, -I$(src) is used to include check-in headers
>>>>>> from generated C files.  Thus, I added it only to dtc-lexer.lex.o
>>>>>> and dtc-parser.tab.o .
>>>>>>
>>>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>>>> ---
>>>>>>
>>>>>>  scripts/dtc/Makefile | 18 ++++--------------
>>>>>>  1 file changed, 4 insertions(+), 14 deletions(-)
>>>>>>
>>>>>> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
>>>>>> index 9cac65b..1c943e0 100644
>>>>>> --- a/scripts/dtc/Makefile
>>>>>> +++ b/scripts/dtc/Makefile
>>>>>> @@ -9,21 +9,11 @@ dtc-objs    := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>>>>>>  dtc-objs     += dtc-lexer.lex.o dtc-parser.tab.o
>>>>>>
>>>>>>  # Source files need to get at the userspace version of libfdt_env.h to compile
>>>>>> +HOST_EXTRACFLAGS := -I$(src)/libfdt
>>>>>
>>>>> Shouldn't that be += instead of :=?
>>>>
>>>> I don't think so. The definition is local to the file (and reset
>>>> before each makefile is included).
>>>>
>>>> Rob
>>>>
>>>
>>> Every other place where HOST_EXTRACFLAGS is assigned a value, += is used
>>> instead of :=, including the example in Documentation/kbuild/makefiles.txt
>>>
>>> What makes scripts/dtc/Makefile different than the other makefiles?
>>>
>>> -Frank
>>>
>>
>>
>> := and += work in the same way in here.
>
> Unless I do: HOST_EXTRACFLAGS=xxx make
> where "xxx" is some random flag I feel like adding in a particular build.



This is not the intended usage of HOST_EXTRACFLAGS.

HOST_EXTRACFLAGS is supposed to be set by Makefile in the kernel tree.


Documentation/kbuild/makefiles.txt explains this:

       To set flags that will take effect for all host programs created
       in that Makefile, use the variable HOST_EXTRACFLAGS.



If you want to pass additional host compiler flags,
please use HOSTCFLAGS instead.


Documentation/kbuild/kbuild.txt lists officially supported
environment variables / command line variables.

    HOSTCFLAGS
    --------------------------------------------------
    Additional flags to be passed to $(HOSTCC) when building host programs.




Maybe I should add

HOST_EXTRACFLAGS   :=
HOST_EXTRACXXFLAGS :=

to the top of scripts/Makefile.build
to reset the variables explicitly
in case people try to abuse them.





-- 
Best Regards
Masahiro Yamada
