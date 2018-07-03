Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07F5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CF8208B1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="c5W5Ez42"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CF8208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934460AbeGCRuv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:50:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35702 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934222AbeGCRut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:50:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id i125-v6so2230331lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=my2aTcc0tDHMbOeZhHg5hVGAVQaNoJ8DpDyMqgq3xYk=;
        b=c5W5Ez42H4msTNwlxG8qfA5QPng1d8uvhLsjWt0hhNo9KdD3XU+d5XjEys7y8dt7cY
         2JtXqDVPQi4VMTy/kg8KNshyWiprbHf4H0bPcvwMT99GwIMk6ahwACTOQhXqzwjU+hxJ
         aV4TOm0vuF0mlbh2FI4s+k5JLsCLj+3rhT/uFPvMy7d7kyoWvLC5SrDRfT3Yx4tdG9Kp
         sbfjCC8MV0m/IHGLs91AikPBNk76Jd9gsScFLrWbGFwSV9NjCPUy2kdcvr3uUs225Ij+
         /ZkFTHCdglgjFiZywHHtPfPbqtYcohRZEvT0BavUt8myrid4BXS14iuwQgoBx0sUUZmQ
         GYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=my2aTcc0tDHMbOeZhHg5hVGAVQaNoJ8DpDyMqgq3xYk=;
        b=IYG8zH/sva6Qj/X5a9WuNts3xcMdzbHwFglsTXYtVUDVq6DFO1uy03gmAr0YnnEC4v
         o39tlW+fvQ7crWEXM10yyhldquikgvA4t4rk0ifYgLjx0MoiEwxVyYWC3jMrMBYef35x
         LwFwAnjzo+AmIh8dFskuhjvW2CIghzDQmi3UwJHHMS+pYVFUl7XFSXC7DEAQzTrGwpNt
         9DLs//8RP29tof4pK86ZSE2exPpg/4oFf9W3XGhCSb9DIUGvcnYi+wJ/YO+nYz7hPKfV
         S7qWVOoq9AeRKMek4yn7IJMLeZ6bUE65LzRRk9UC2BSwXMc6j7MiUYZ9Ai3qRuWEKrU5
         aI6g==
X-Gm-Message-State: APt69E1yxjSksqXa4Seh5BJgROFtrv/NDvhoz5Uf5A1j19KvKWgkOJEH
        y4oCFA8/mCaZipphCXp1d1cWl2sabElddMcA9sCJ4w==
X-Google-Smtp-Source: AAOMgpfLOEQlEHgZYmeM+M0KaxsC330RxZTXalFJHYwJOGFELxwx9Ob2h8JkP8kMHozZoi2ZvwkV+kJVsECi3wd5Ags=
X-Received: by 2002:a2e:4055:: with SMTP id n82-v6mr9576023lja.99.1530640248257;
 Tue, 03 Jul 2018 10:50:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:fc1c:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 10:50:46 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::6:181c]
In-Reply-To: <CAOesGMh6yVYKQ+dJbAsJWU=7wrfwW1cBwVbGoKNiG96_Mh6ebA@mail.gmail.com>
References: <201806301538.bewm1wka%fengguang.wu@intel.com> <CACT4Y+b+7T3M=5EbHSpJmMAkRQnXih2+JZqeAvxht2zzKyjD2A@mail.gmail.com>
 <20180630110720.c80f060abe6d163eef78e9a6@linux-foundation.org>
 <20180630111210.ec9de2c2923a0c58b1357965@linux-foundation.org> <CAOesGMh6yVYKQ+dJbAsJWU=7wrfwW1cBwVbGoKNiG96_Mh6ebA@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 3 Jul 2018 10:50:46 -0700
Message-ID: <CAOesGMgGmr4o92subyJMGGbv7CxFYH_zKV01aWK4TwnEgzHTUQ@mail.gmail.com>
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

Hi Andrew,

On Sat, Jun 30, 2018 at 1:30 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Jun 30, 2018 at 11:12 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
>> On Sat, 30 Jun 2018 11:07:20 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>>> On Sat, 30 Jun 2018 12:27:09 +0200 Dmitry Vyukov <dvyukov@google.com> wrote:
>>>
>>> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> > > head:   1904148a361a07fb2d7cba1261d1d2c2f33c8d2e
>>> > > commit: 758517202bd2e427664857c9f2aa59da36848aca arm: port KCOV to arm
>>> > > date:   2 weeks ago
>>> > > config: arm-allmodconfig (attached as .config)
>>> > > compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
>>> > > reproduce:
>>> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>> > >         chmod +x ~/bin/make.cross
>>> > >         git checkout 758517202bd2e427664857c9f2aa59da36848aca
>>> > >         # save the attached .config to linux build tree
>>> > >         GCC_VERSION=7.2.0 make.cross ARCH=arm
>>> > >
>>> > > All errors (new ones prefixed by >>):
>>> > >
>>> > >    /tmp/cctnQ1CM.s: Assembler messages:
>>> > >>> /tmp/cctnQ1CM.s:35: Error: .err encountered
>>> > >    /tmp/cctnQ1CM.s:36: Error: .err encountered
>>> > >    /tmp/cctnQ1CM.s:37: Error: .err encountered
>>> >
>>> > Hi kbuild test robot,
>>> >
>>> > The fix was mailed more than a month ago, but still not merged into
>>> > the tree. That's linux...
>>>
>>> That was a rather unhelpful email.
>>>
>>> I've just scanned all your lkml emails since the start of May and
>>> cannot find anything which looks like a fix for this issue.
>>>
>>> Please resend.   About three weks ago :(
>>
>> OK, with a bi of amazing sleuthing I found this from Arnd, which is what
>> I presume you're referring to?
>>
>>
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>> Subject: ARM: disable KCOV for trusted foundations code
>>
>> The ARM trusted foundations code is currently broken in linux-next when
>> CONFIG_KCOV_INSTRUMENT_ALL is set:
>>
>> /tmp/ccHdQsCI.s: Assembler messages:
>> /tmp/ccHdQsCI.s:37: Error: .err encountered
>> /tmp/ccHdQsCI.s:38: Error: .err encountered
>> /tmp/ccHdQsCI.s:39: Error: .err encountered
>> scripts/Makefile.build:311: recipe for target 'arch/arm/firmware/trusted_foundations.o' failed
>>
>> I could not find a function attribute that lets me disable
>> -fsanitize-coverage=trace-pc for just one function, so this turns it off
>> for the entire file instead.
>>
>> Link: http://lkml.kernel.org/r/20180529103636.1535457-1-arnd@arndb.de
>> Fixes: 758517202bd2e4 ("arm: port KCOV to arm")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> Solves it on my builder at least. Would be good to get this in.
>
> Acked-by: Olof Johansson <olof@lixom.net>

Since this doesn't seem to be in your queue at the moment, I've
applied it to our set of fixes for 4.18 in arm-soc, I'll send to Linus
at end of week and it'll be in -next as of now through there.


Thanks,

-Olof
