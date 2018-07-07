Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EFDC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84B922ACA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="EnuxoKFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84B922ACA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754186AbeGGA5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 20:57:04 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:31233 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753672AbeGGA5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 20:57:02 -0400
Received: from mail-ua0-f180.google.com (mail-ua0-f180.google.com [209.85.217.180]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w670ud7v031244;
        Sat, 7 Jul 2018 09:56:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w670ud7v031244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530925000;
        bh=5YeltWkY+jsrFrilmCkeSndxHS8enIfJT62ZNMkMtsg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=EnuxoKFmVxu4frRYVChxktUpVQuKfqnqLxahKfdAeumLgncJtcJydSdtxmORFz4su
         zGx1EA8Lphvna3MGeUXGdwiFCwgRgVlLbnt841jqt4PyJ5E0q2sjHB6wVrGRRxmstU
         Vbar0Ad6e8LxC8BpZuLJft05iVedy71OOMSfCtW/gpUGB4dudPAQk4iHs5m09kVvvf
         Et3/x8/zQQj+EH6XUAq0pOR1jJC9n6bdUNFfaO/C7sH8Z8wOcOjaP4qlv69FIZOYnM
         gTYWq7Lh9ZsdKl2sYWrR0piddT0Y2eH8fNBAt56Mx08PS8+hJ3oD3xi3XdC++54V/x
         8doGq76kSdDiA==
X-Nifty-SrcIP: [209.85.217.180]
Received: by mail-ua0-f180.google.com with SMTP id x18-v6so8592845uaj.9;
        Fri, 06 Jul 2018 17:56:40 -0700 (PDT)
X-Gm-Message-State: APt69E1ve9aESIhSepl39jMpjrJeYtI6TW0jW6ZJyYBzJ+w/sldlfV9r
        cXYeTaSvVFKFiFsqs4iqocq/1ET90xKkrWGbvp4=
X-Google-Smtp-Source: AAOMgpc5JNOIqOPeLuIImiI+EuOdHdP/kwBpdlB4VlvAQDzDXZT7hE0eH1yqYCT4QfcwvRNGnquRYnpP6pAOe6rjOu0=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr7408149uaf.199.1530924999114;
 Fri, 06 Jul 2018 17:56:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 17:55:58 -0700 (PDT)
In-Reply-To: <CAEJqkgiSDdu7a6VyhsrA=rnjevyz2VZZdRVRHBgYHkmHjvAULw@mail.gmail.com>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems> <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1> <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1> <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
 <20180706104144.6p2s43o3sqc6d5y3@kshutemo-mobl1> <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
 <CAEJqkgiSDdu7a6VyhsrA=rnjevyz2VZZdRVRHBgYHkmHjvAULw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 7 Jul 2018 09:55:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNASt3E178H8Ho0+bh3mTvE=3UF6Fj9AX=vWCZ=mWX-72jg@mail.gmail.com>
Message-ID: <CAK7LNASt3E178H8Ho0+bh3mTvE=3UF6Fj9AX=vWCZ=mWX-72jg@mail.gmail.com>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Benjamin Gilbert <bgilbert@redhat.com>,
        linux-x86_64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        bero@lindev.ch, Andi Kleen <ak@linux.intel.com>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-06 23:39 GMT+09:00 Gabriel C <nix.or.die@gmail.com>:
> 2018-07-06 16:13 GMT+02:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> Hi.
>>
>> 2018-07-06 19:41 GMT+09:00 Kirill A. Shutemov <kirill@shutemov.name>:
>>> On Fri, Jul 06, 2018 at 03:37:58PM +0900, Masahiro Yamada wrote:
>>>> >> > > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
>>>> >> > >
>>>> >> > > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
>>>> >> > > too with the same symptoms
>>>> >> >
>>>> >> > I tracked it down to -flto in LDFLAGS. I'll look more into this.
>>>> >>
>>>> >> -flto in LDFLAGS screws up this part of paging_prepare():
>>>> >
>>>> > +Masahiro, Michal.
>>>> >
>>>> > I've got it wrong. *Any* LDFLAGS option passed to make this way:
>>>> >
>>>> >   make LDFLAGS="..."
>>>> >
>>>> > would cause a issue. Even empty.
>>>> >
>>>> > It overrides all assignments to the variable in the makefile.
>>>> > As result the image is built without -pie and linker doesn't generate
>>>> > position independed code.
>>>> >
>>>> > Looks like the patch below helps, but my make-fu is poor.
>>>> > I don't see many override directives in kernel makefiles.
>>>> > It makes me think that there's a better way to fix this.
>>>> >
>>>> > Hm?
>>>>
>>>>
>>>> LDFLAGS is for internal-use.
>>>> Please do not override it from the command line.
>>>
>>> Can we generate a build error if a user try to override LDFLAGS, CFLAGS or
>>> other critical internal-use-only variables?
>>
>> Yes, Make can check where variables came from.
>>
>>
>>> This breakage was rather hard to debug. We need to have some kind of
>>> fail-safe for the future.
>>>
>>>> You want to pass your own linker flags
>>>> for building vmlinux and modules,
>>>> but do not want to pass them to
>>>> the decompressor (arch/x86/boot/compressed).
>>>>
>>>> Correct?
>>>
>>> I personally don't think that changing compiler/linker options for kernel
>>> build is good idea in general.
>>>
>>>> Kbuild provides a way for users
>>>> to pass additional linker flags to modules.
>>>> (LDFLAGS_MODULE)
>>>>
>>>>
>>>> But, there is no way to do that for vmlinux.
>>>>
>>>> It is easy to support it, though.
>>>>
>>>> https://patchwork.kernel.org/patch/10510833/
>>>>
>>>> If this is the one you want, I can merge this.
>>>>
>>>>
>>>> make LDFLAGS_KERNEL=...  LDFLAGS_MODULE=...
>>>> will allow you to append linker flags.
>>>
>>> Okay. It makes me wounder if we should taint kernel in such cases?
>>> Custom compiler/linker flags are risky and can lead to weird bugs.
>>
>> OK.
>> So, what problem are we discussing?
>>
>>
>>> I've got it wrong. *Any* LDFLAGS option passed to make this way:
>>>
>>>  make LDFLAGS="..."
>>
>> In your previous mail, I thought you were asking me how to pass
>> custom linker flags.
>>
>> If not, we do not need to think about that case.
>> Just say "Do not do that".
>
> I am sorry but I have a hard time to get your logic here.
>
> You are saying : the *env* variable LDFLAGS as well passing
> LDFLAGS to make , which your build allows should not be use
> because is for 'internal usage' .. ?
>
> Well that logic you have here is wrong and wrong for any project
> not just for the kernel,


Why 'my logic'?

LDFLAGS has been long used internally since the old days,
before I ever worked on the kernel.


I shared my knowledge about the kernel build system.

The current situation is not nice,
but why are you blaming me for the code I did not add ?


Note:
I have never said 'the *env* variable LDFLAGS'


> If you know 'parts' need have particular flags then 'you' have to
> ensure nothing
> overrides these or nothing at all can chage these.
>
> So swap your logic and apped LDFLAGS to your private
> 'call_it_whatever_you_wish_KERNEL_NEED_BE_THERE_ANY_KIND_FLAGS'
> and don't allow these to be changed at all , when you
> *know* they have be there.
>
>
> Teling users to not use LD/C/CXX flags is not really going to work right ?
>
>
> BR



-- 
Best Regards
Masahiro Yamada
