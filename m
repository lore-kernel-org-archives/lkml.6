Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29800C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D6A21473
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9hEbgPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D6A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeHUVYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:24:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32799 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeHUVYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:24:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so8876138pfn.0;
        Tue, 21 Aug 2018 11:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KQSNA/dgkqUdHxfL1vRemZhfIM+eN7qyha3PH13qFT8=;
        b=h9hEbgPsAYYOGMjIoMkNeVxP3OmbBFslvZ8MFvlh9jpC0xrpFbdha506vN9m3FTDWG
         kuRuN6YDqBsOr6w4cFBZbTbiE8LJVrqzsHAbdO+8rrJsZpv7FRNNzXSBjBKsukdiBMq0
         /SqT5/9RCkkRwHo2tzD0TI2WVBIfooobR8dsuu0mKV9teiLm1Qs58Agms/6/SW+AXQPO
         24kekhEaNva+N/EmvvZWT2vDqpThz3wf21E/iySCwS88G5vr3izNjQf3Jlu0dWzm0ib0
         Nbd3tb29Gwf84Y5LYGb/NcOc8mfm+fDvb6HoExTHSrEeuYdxTAmkEMsHSTjb5vMZNpIg
         hnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KQSNA/dgkqUdHxfL1vRemZhfIM+eN7qyha3PH13qFT8=;
        b=YKPpFMArYnJNgB4ewQNvbpBLnkcmUwwhOwrpUpiW68i7QEPbhPL3CmXcE1nGoU7eK/
         kJa/5+Rby2YSpx+FV6FhoUrRfq+odl/iZEN8u8kStKKXI4ftw1I+BRVCQ0hIlQyM6uge
         uQvK1o1JCbfqwWWuWU9WUkqnEDToGfR1h03+b/nLznkbVTNQr6+WiXvie/z8rVDdbHR5
         BRd1FHziCu7KISbp03eT6vaL3GAorNRCAg/tkK3hzFNY5JHLBTSiDVboYIR5vtXiJsG2
         AXbKomv1r7y1fLNTqwSCnu/8Nr0D43y4G01GSbKQ9PRNSdoNGpkrWlzOKYzSNsJy6LeI
         pDqQ==
X-Gm-Message-State: AOUpUlGld21OnOp+exo1Bcs/mWXqfuYjF03gihdrovQOpybrEEL9Q+z+
        z/THUC2QfcFQD0Qmb2SSzu4=
X-Google-Smtp-Source: AA+uWPzCI8Do1TDcqmcA6+msdaSuil+dd+zHhIW7MkaiEMUuStI7dxLw9XvfX82YTzG9VFzm16I7tw==
X-Received: by 2002:a63:549:: with SMTP id 70-v6mr21438797pgf.385.1534874573140;
        Tue, 21 Aug 2018 11:02:53 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id i20-v6sm19357309pfj.82.2018.08.21.11.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 11:02:52 -0700 (PDT)
Subject: Re: [PATCH] scripts/dtc: consolidate include path options in Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com>
 <cfb66b67-f423-0c26-0b22-0d57a581b44a@gmail.com>
 <CAL_Jsq+iAxmKvZ+RAD-VSOWirYOxc52mJHU5f5gybhWwQn2w_g@mail.gmail.com>
 <7fba348e-9fd3-9661-248d-82917f8f6676@gmail.com>
 <CAK7LNATFbykSHcDZqovTZ0aN9kHvZw3Q4Mamb1gwMwRhg7_s-A@mail.gmail.com>
 <78d8984c-211a-65c3-ab43-b3c02373ef0a@gmail.com>
 <CAK7LNAR5aHQ9Vo=-KTg8fzmk-1Nxu8WaXUT9wHM2n9Wr4wHFYw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <7c81314d-2c57-375d-d037-872faa70b227@gmail.com>
Date:   Tue, 21 Aug 2018 11:02:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAR5aHQ9Vo=-KTg8fzmk-1Nxu8WaXUT9wHM2n9Wr4wHFYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/18 00:18, Masahiro Yamada wrote:
> Hi Frank,
> 
> 
> 2018-08-21 14:37 GMT+09:00 Frank Rowand <frowand.list@gmail.com>:
>> On 08/20/18 19:08, Masahiro Yamada wrote:
>>> Hi Frank,
>>>
>>> 2018-08-21 10:31 GMT+09:00 Frank Rowand <frowand.list@gmail.com>:
>>>> On 08/20/18 14:32, Rob Herring wrote:
>>>>> On Mon, Aug 20, 2018 at 1:55 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>
>>>>>> On 07/03/18 18:59, Masahiro Yamada wrote:
>>>>>>> It is tedious to specify extra compiler options for every file.
>>>>>>> HOST_EXTRACFLAGS is useful to add options to all files in a
>>>>>>> directory.
>>>>>>>
>>>>>>> -I$(src)/libfdt is needed for all the files in this directory
>>>>>>> to include libfdt_env.h etc. from scripts/dtc/libfdt/.
>>>>>>>
>>>>>>> On the other hand, -I$(src) is used to include check-in headers
>>>>>>> from generated C files.  Thus, I added it only to dtc-lexer.lex.o
>>>>>>> and dtc-parser.tab.o .
>>>>>>>
>>>>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>>>>> ---
>>>>>>>
>>>>>>>  scripts/dtc/Makefile | 18 ++++--------------
>>>>>>>  1 file changed, 4 insertions(+), 14 deletions(-)
>>>>>>>
>>>>>>> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
>>>>>>> index 9cac65b..1c943e0 100644
>>>>>>> --- a/scripts/dtc/Makefile
>>>>>>> +++ b/scripts/dtc/Makefile
>>>>>>> @@ -9,21 +9,11 @@ dtc-objs    := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>>>>>>>  dtc-objs     += dtc-lexer.lex.o dtc-parser.tab.o
>>>>>>>
>>>>>>>  # Source files need to get at the userspace version of libfdt_env.h to compile
>>>>>>> +HOST_EXTRACFLAGS := -I$(src)/libfdt
>>>>>>
>>>>>> Shouldn't that be += instead of :=?
>>>>>
>>>>> I don't think so. The definition is local to the file (and reset
>>>>> before each makefile is included).
>>>>>
>>>>> Rob
>>>>>
>>>>
>>>> Every other place where HOST_EXTRACFLAGS is assigned a value, += is used
>>>> instead of :=, including the example in Documentation/kbuild/makefiles.txt
>>>>
>>>> What makes scripts/dtc/Makefile different than the other makefiles?
>>>>
>>>> -Frank
>>>>
>>>
>>>
>>> := and += work in the same way in here.
>>
>> Unless I do: HOST_EXTRACFLAGS=xxx make
>> where "xxx" is some random flag I feel like adding in a particular build.
> 
> 
> 
> This is not the intended usage of HOST_EXTRACFLAGS.

I seem to have found a useful feature for making a specific object in a
development context with additional compiler flags.  But a feature that
you say is not intended.

I do understand that there is an intended difference between HOSTCFLAGS
and HOST_EXTRACFLAGS.  But I do not agree that using HOST_EXTRACFLAGS
on the make commandline when building a single object in a development
context is abuse.


> HOST_EXTRACFLAGS is supposed to be set by Makefile in the kernel tree.

But it is not set, thus it is currently available (and has been for many
years) for the usage that I specified above.


> Documentation/kbuild/makefiles.txt explains this:
> 
>        To set flags that will take effect for all host programs created
>        in that Makefile, use the variable HOST_EXTRACFLAGS.
> 
> 
> 
> If you want to pass additional host compiler flags,
> please use HOSTCFLAGS instead.

That will not work because the top level Makefile has:

   HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \


> Documentation/kbuild/kbuild.txt lists officially supported
> environment variables / command line variables.> 
>     HOSTCFLAGS
>     --------------------------------------------------
>     Additional flags to be passed to $(HOSTCC) when building host programs.

HOSTCFLAGS is not in my 4.18.0 Documentation/kbuild/kbuild.txt.  What version are
you looking at?

  $ git log -n1
  commit 94710cac0ef4ee177a63b5227664b38c95bbf703
  Author: Linus Torvalds <torvalds@linux-foundation.org>
  Date:   Sun Aug 12 13:41:04 2018 -0700

      Linux 4.18
  $ git grep HOSTCFLAGS Documentation/kbuild/kbuild.txt
  $


But this is where I concede that HOST_EXTRACFLAGS is also not listed as
an officially supported environment variable or command line variable.  I
had not checked here for that limitation.


> 
> 
> Maybe I should add
> 
> HOST_EXTRACFLAGS   :=
> HOST_EXTRACXXFLAGS :=
> 
> to the top of scripts/Makefile.build
> to reset the variables explicitly
> in case people try to abuse them.

Yes, if you intend that it not be possible to initialize them in the make
command then you should initialize them.  If you do that, it is easy
enough for me to patch the initialization out in cases where I want the
extra functionality.


