Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20D9C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8DD253DC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 20:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="UmK2W6Xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8DD253DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeF3UaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 16:30:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46125 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeF3UaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 16:30:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so9792815lju.13
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XApls+yFiRcSRoODByZDSavN1B0ZmkhrbekUFj5X4MQ=;
        b=UmK2W6XwsUfLDJgrv7qfYgflxPaPHKCdNFjI4kU347v1iOJGVyX0GO4B2S5Cqix4RS
         iIjcjb3Nx8vVt37K35OuIMCcSpTzRCfKv8E9aOHM5MMZ2MGEoiaEsKtWFAl9DF76VL4c
         uinFCMkbKwM2U+1x+rD1CQuRGtJ67EJjYhG1mhw+70t40mGi5ZE+OJoF67c7w2oPgqNf
         QUmFv3YuchtR2W6L768sr7Olt0NHNg/0anTssi1A6So7ircLsYG2jlh7LDfIjgn3IRzd
         HsbBZPUnGAhTKXGVRV+0bHhUDnDNtqWy5AjAF8bSE7UYobBnvhkr7Qlrhb7CDAitRtIj
         DvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XApls+yFiRcSRoODByZDSavN1B0ZmkhrbekUFj5X4MQ=;
        b=TB4UNDpweVl5yV8x7SU7EyaqikoAka7Z+yTVbPZmikZORVzn5LE8ybWGezJe5fDYTl
         ho2FMFPOVvw1zcT9CIolHMlNLMNp+DEPDX2cKXmlwjUA/80vYVRKrWptA2EZ6yFoMOyZ
         utdbIkduHtcYYskum+8Xnmf4nCYzc/S+Tt5IGzqo4Kpg+VL+lzuBMGoWbzr3Q2UmZEjZ
         CgCvA2TQ8gj05u1lZ+iZLNCOVoCbYt2b5Ri5cFQILrFzZx/FZvTm3mg5W632sleeFInM
         Z8B6nF/mtmbEiP+oHLAL241wmntVKcb/yWxO/hDx4/oqddLiEwP58OBVuqVXKCdZWKK9
         tUUg==
X-Gm-Message-State: APt69E3HR7otFiCz9ttVVnaU66CIAQBHTDjl6OglO8R+k/Sz2nt0DT7t
        4pJcp1UQeyw+/63ayPOO3S86S22+OFF9+5fDyzUy/w==
X-Google-Smtp-Source: AAOMgpfb1abkzy65XoG39wcbCj5Nw4GcaoaDCYWaJK3+rqGyQfLKv/J4j4Wm3T26lLkROhHviL4nOIpUNy45RZZCSQ8=
X-Received: by 2002:a2e:4055:: with SMTP id n82-v6mr2138498lja.99.1530390612400;
 Sat, 30 Jun 2018 13:30:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 13:30:11
 -0700 (PDT)
X-Originating-IP: [99.152.116.91]
In-Reply-To: <20180630111210.ec9de2c2923a0c58b1357965@linux-foundation.org>
References: <201806301538.bewm1wka%fengguang.wu@intel.com> <CACT4Y+b+7T3M=5EbHSpJmMAkRQnXih2+JZqeAvxht2zzKyjD2A@mail.gmail.com>
 <20180630110720.c80f060abe6d163eef78e9a6@linux-foundation.org> <20180630111210.ec9de2c2923a0c58b1357965@linux-foundation.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 30 Jun 2018 13:30:11 -0700
Message-ID: <CAOesGMh6yVYKQ+dJbAsJWU=7wrfwW1cBwVbGoKNiG96_Mh6ebA@mail.gmail.com>
Subject: Re: /tmp/cctnQ1CM.s:35: Error: .err encountered
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 11:12 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 30 Jun 2018 11:07:20 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>
>> On Sat, 30 Jun 2018 12:27:09 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> > > head:   1904148a361a07fb2d7cba1261d1d2c2f33c8d2e
>> > > commit: 758517202bd2e427664857c9f2aa59da36848aca arm: port KCOV to arm
>> > > date:   2 weeks ago
>> > > config: arm-allmodconfig (attached as .config)
>> > > compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
>> > > reproduce:
>> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>> > >         chmod +x ~/bin/make.cross
>> > >         git checkout 758517202bd2e427664857c9f2aa59da36848aca
>> > >         # save the attached .config to linux build tree
>> > >         GCC_VERSION=7.2.0 make.cross ARCH=arm
>> > >
>> > > All errors (new ones prefixed by >>):
>> > >
>> > >    /tmp/cctnQ1CM.s: Assembler messages:
>> > >>> /tmp/cctnQ1CM.s:35: Error: .err encountered
>> > >    /tmp/cctnQ1CM.s:36: Error: .err encountered
>> > >    /tmp/cctnQ1CM.s:37: Error: .err encountered
>> >
>> > Hi kbuild test robot,
>> >
>> > The fix was mailed more than a month ago, but still not merged into
>> > the tree. That's linux...
>>
>> That was a rather unhelpful email.
>>
>> I've just scanned all your lkml emails since the start of May and
>> cannot find anything which looks like a fix for this issue.
>>
>> Please resend.   About three weks ago :(
>
> OK, with a bi of amazing sleuthing I found this from Arnd, which is what
> I presume you're referring to?
>
>
>
> From: Arnd Bergmann <arnd@arndb.de>
> Subject: ARM: disable KCOV for trusted foundations code
>
> The ARM trusted foundations code is currently broken in linux-next when
> CONFIG_KCOV_INSTRUMENT_ALL is set:
>
> /tmp/ccHdQsCI.s: Assembler messages:
> /tmp/ccHdQsCI.s:37: Error: .err encountered
> /tmp/ccHdQsCI.s:38: Error: .err encountered
> /tmp/ccHdQsCI.s:39: Error: .err encountered
> scripts/Makefile.build:311: recipe for target 'arch/arm/firmware/trusted_foundations.o' failed
>
> I could not find a function attribute that lets me disable
> -fsanitize-coverage=trace-pc for just one function, so this turns it off
> for the entire file instead.
>
> Link: http://lkml.kernel.org/r/20180529103636.1535457-1-arnd@arndb.de
> Fixes: 758517202bd2e4 ("arm: port KCOV to arm")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Solves it on my builder at least. Would be good to get this in.

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
