Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0CCC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239DC23E0B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LB2Yr5kW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239DC23E0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933280AbeGFOOL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:14:11 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:55745 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932692AbeGFOOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:14:09 -0400
X-Greylist: delayed 27317 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2018 10:14:08 EDT
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com [209.85.213.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w66EDhRV019437;
        Fri, 6 Jul 2018 23:13:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w66EDhRV019437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530886424;
        bh=iyfgSUo+kVZvahGK1BP7fzgNCCLIrycBBysdPwDvwiU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=LB2Yr5kW2dYE0pje7U4LwQt2Ipk1wIkwKh/CFz7P669kNXWkPVPNSu61hy3NjE1fV
         o34oiindefgfV1U+ePRYTDP/1xQ2dgBzZsI2woYwGPAbp4Xy39wzmaZXLKl4ZYwypQ
         hLFT0BmGo8+Rh/b93Chd9RixwONPYJJVjjhcYI5d5aKngxeRqzD5lv4EMmnxCna+BC
         3j2ARWXLvL7h6djyTYRnAk6NInY5DjQTm4EJ6NFI+HXlfJ2M46BhrgSKCAaOgVJiHb
         FCzWQkFMHiQcZ3RU9qdwKHv8k6CQ8RpWVydaxAW4I2hvMfYuWVauGCKMmVRurlF8I1
         8RDFLaos9gVAA==
X-Nifty-SrcIP: [209.85.213.50]
Received: by mail-vk0-f50.google.com with SMTP id j11-v6so6887112vke.8;
        Fri, 06 Jul 2018 07:13:44 -0700 (PDT)
X-Gm-Message-State: APt69E0B6m/YaLnQmdXLyokcq5U/mmwUpE/IzQ/v/0llKO+DH/Y7qrWK
        rhDYPaly0/ghxLGkyxbYb63mZgM6QT0fyTrtu00=
X-Google-Smtp-Source: AAOMgpc9dpX9NKRhQVKXUIu7nac09gUomIXCf/FEyykXoAnx5HXTRJTyEudFMJto3Fg0o2oGmIJ9qa2FZ4uNxEy9lGw=
X-Received: by 2002:a1f:8c4a:: with SMTP id o71-v6mr3918302vkd.11.1530886422858;
 Fri, 06 Jul 2018 07:13:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 07:13:02 -0700 (PDT)
In-Reply-To: <20180706104144.6p2s43o3sqc6d5y3@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems> <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1> <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1> <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
 <20180706104144.6p2s43o3sqc6d5y3@kshutemo-mobl1>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 6 Jul 2018 23:13:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
Message-ID: <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Gabriel C <nix.or.die@gmail.com>,
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

Hi.

2018-07-06 19:41 GMT+09:00 Kirill A. Shutemov <kirill@shutemov.name>:
> On Fri, Jul 06, 2018 at 03:37:58PM +0900, Masahiro Yamada wrote:
>> >> > > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
>> >> > >
>> >> > > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
>> >> > > too with the same symptoms
>> >> >
>> >> > I tracked it down to -flto in LDFLAGS. I'll look more into this.
>> >>
>> >> -flto in LDFLAGS screws up this part of paging_prepare():
>> >
>> > +Masahiro, Michal.
>> >
>> > I've got it wrong. *Any* LDFLAGS option passed to make this way:
>> >
>> >   make LDFLAGS="..."
>> >
>> > would cause a issue. Even empty.
>> >
>> > It overrides all assignments to the variable in the makefile.
>> > As result the image is built without -pie and linker doesn't generate
>> > position independed code.
>> >
>> > Looks like the patch below helps, but my make-fu is poor.
>> > I don't see many override directives in kernel makefiles.
>> > It makes me think that there's a better way to fix this.
>> >
>> > Hm?
>>
>>
>> LDFLAGS is for internal-use.
>> Please do not override it from the command line.
>
> Can we generate a build error if a user try to override LDFLAGS, CFLAGS or
> other critical internal-use-only variables?

Yes, Make can check where variables came from.


> This breakage was rather hard to debug. We need to have some kind of
> fail-safe for the future.
>
>> You want to pass your own linker flags
>> for building vmlinux and modules,
>> but do not want to pass them to
>> the decompressor (arch/x86/boot/compressed).
>>
>> Correct?
>
> I personally don't think that changing compiler/linker options for kernel
> build is good idea in general.
>
>> Kbuild provides a way for users
>> to pass additional linker flags to modules.
>> (LDFLAGS_MODULE)
>>
>>
>> But, there is no way to do that for vmlinux.
>>
>> It is easy to support it, though.
>>
>> https://patchwork.kernel.org/patch/10510833/
>>
>> If this is the one you want, I can merge this.
>>
>>
>> make LDFLAGS_KERNEL=...  LDFLAGS_MODULE=...
>> will allow you to append linker flags.
>
> Okay. It makes me wounder if we should taint kernel in such cases?
> Custom compiler/linker flags are risky and can lead to weird bugs.

OK.
So, what problem are we discussing?


> I've got it wrong. *Any* LDFLAGS option passed to make this way:
>
>  make LDFLAGS="..."

In your previous mail, I thought you were asking me how to pass
custom linker flags.

If not, we do not need to think about that case.
Just say "Do not do that".



-- 
Best Regards
Masahiro Yamada
