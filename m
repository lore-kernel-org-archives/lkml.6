Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C73C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C1320862
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VNYLS/5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C1320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932798AbeGIKin (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:38:43 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:62238 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932431AbeGIKil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:38:41 -0400
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com [209.85.213.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w69AcPtp029104;
        Mon, 9 Jul 2018 19:38:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w69AcPtp029104
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531132706;
        bh=Elmm+64+DvwQQs/z/sDiGkwsstYBZSespdstCwKPLGA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VNYLS/5VcobJGrMmbgOTcUce147tneLgJJEdlEHevw5yH4qGc2mb3HbMADRriSlMM
         uB8IK4H1x8iQY8EVj6F2hlQ9CTvP4LS85/Ch8gfYa4RIPp3PyaREPch7iR2eT4g9cd
         aNLy/bbcuUNOhmNcH+MoDF0G8c7F6znYChy/epta3QV4ZN3J1/NJX/VTZLDaCNz3DZ
         jAh7hCFKI9l3DkTIKVyv9v/5KFgRKSfbHlSlxAklAN+KAKDoaKJfZEEgZs9+onWio6
         3mKbAG7vETpoMfNzhnExnFixFKyFfrByjTrMMRUB+rKyLwQEa75thCcj63jOuqwqcS
         lTi1NlXnduXlA==
X-Nifty-SrcIP: [209.85.213.49]
Received: by mail-vk0-f49.google.com with SMTP id l143-v6so2807569vke.1;
        Mon, 09 Jul 2018 03:38:25 -0700 (PDT)
X-Gm-Message-State: APt69E1LmDhJ2rQRnp7vKVZS3BO4Rmq0JgmNBt753DxKc+FuTIpOvhEH
        u0Q+EzNcFQ7p2rhokXvLNVfTVfz5nUs8Dzc4njI=
X-Google-Smtp-Source: AAOMgpfqGTfCD+9WLRg1GwPsEUxMQDdhphBUVgdIk6oGAzaTDCG/Kda0QsUNPA0j7VFD3V5UQ1bDq4oCSEbsIjiVvYw=
X-Received: by 2002:a1f:9807:: with SMTP id a7-v6mr11104936vke.65.1531132704815;
 Mon, 09 Jul 2018 03:38:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 03:37:44 -0700 (PDT)
In-Reply-To: <20180709101005.43yp6b2g3b4dgg37@kshutemo-mobl1>
References: <20180701213243.GA20180@trogon.sfo.coreos.systems>
 <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1> <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1> <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
 <20180706104144.6p2s43o3sqc6d5y3@kshutemo-mobl1> <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
 <20180706162928.73jfqtdwdcwtagui@kshutemo-mobl1> <CAK7LNAQKT8QnoOaoR4LckaAYpBws5MwBTRYMMQFpmxUCmuMWbg@mail.gmail.com>
 <20180709101005.43yp6b2g3b4dgg37@kshutemo-mobl1>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 9 Jul 2018 19:37:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1G+rziRXewk=kVWg5NNK_NQyvC-y51Xib6-fxqvHtkw@mail.gmail.com>
Message-ID: <CAK7LNAT1G+rziRXewk=kVWg5NNK_NQyvC-y51Xib6-fxqvHtkw@mail.gmail.com>
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

2018-07-09 19:10 GMT+09:00 Kirill A. Shutemov <kirill@shutemov.name>:
> On Sat, Jul 07, 2018 at 10:21:47AM +0900, Masahiro Yamada wrote:
>> 2018-07-07 1:29 GMT+09:00 Kirill A. Shutemov <kirill@shutemov.name>:
>> > On Fri, Jul 06, 2018 at 11:13:02PM +0900, Masahiro Yamada wrote:
>> >> >> LDFLAGS is for internal-use.
>> >> >> Please do not override it from the command line.
>> >> >
>> >> > Can we generate a build error if a user try to override LDFLAGS, CFLAGS or
>> >> > other critical internal-use-only variables?
>> >>
>> >> Yes, Make can check where variables came from.
>> >
>> > I think we should do this.
>> >
>> >> >> make LDFLAGS_KERNEL=...  LDFLAGS_MODULE=...
>> >> >> will allow you to append linker flags.
>> >> >
>> >> > Okay. It makes me wounder if we should taint kernel in such cases?
>> >> > Custom compiler/linker flags are risky and can lead to weird bugs.
>> >>
>> >> OK.
>> >> So, what problem are we discussing?
>> >
>> > Users set custom LDFLAGS/CFLAGS and break kernel. Then report bug that
>> > hard to debug. See
>> >
>> > https://bugzilla.kernel.org/show_bug.cgi?id=200385
>>
>>
>> CFLAGS is only used under tools/.
>> Passing CFLAGS is probably no effect to the kernel.
>>
>> In Linux makefiles,
>> KBUILD_ prefixed variables are used internally.
>>
>> KBUILD_CFLAGS, KBUILD_CPPFLAGS, KBUILD_AFLAGS, etc.
>>
>>
>> LDFLAGS is an exception.  I do not know why.
>> Renaming LDFLAGS to KBUILD_LDFLAGS
>> will make the code consistent.
>>
>> At least, it will avoid overriding flags by accident.
>>
>> Of course, users still can change KBUILD_LDFLAGS
>> if they really want.
>>
>> The build system could add belt and braces checks for that,
>> but it is arguable since
>> there are lots of lots of internal variables.
>
> I think renaming LDFLAGS to KBUILD_LDFLAGS is good idea.
> Would you prepare patch?


Yes, targeting for 4.19-rc1.


-- 
Best Regards
Masahiro Yamada
