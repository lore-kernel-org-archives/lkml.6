Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150D8C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33A822562
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 01:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tKL0tuOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33A822562
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeGGBWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 21:22:55 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:30317 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752739AbeGGBWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 21:22:53 -0400
Received: from mail-ua0-f182.google.com (mail-ua0-f182.google.com [209.85.217.182]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w671MS5Z026766;
        Sat, 7 Jul 2018 10:22:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w671MS5Z026766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530926549;
        bh=dl1dFVzCumWDy4HdevcC4Z0zgPkWqS+r6UaVq6ke2dE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=tKL0tuOPX6cKgVsI7ll8v9FEczRVqkrEy6Ewj/DdhDblDZrKIbt59ujVIYw2N4EbG
         5+OQPqME2O5gJE2LvVZOCaXJlM4bTGE++PFWlQy9QHxRx51KZi5w5rUwRN9Pd4Lr48
         ShrtyUCmpwwGS1p6BbUa88aaBzXQx4/hybSzMH8bBYbwPVXxTrKYlaieMgN9K/WVfE
         uoKB5PY+r5775Cf3HuA/8fikXfy0V1cEJhraFqZuL7LqHRaRmM3nuFqP8hD6j0vwJB
         K8OkbKSnw1bjDc3ttwrK5fF9oTSgkIzlVi5xfIB6PpYxMwxZfiZQktP4sMpht7pZ7y
         2rR5EjXdv1bgA==
X-Nifty-SrcIP: [209.85.217.182]
Received: by mail-ua0-f182.google.com with SMTP id r18-v6so8605501ual.13;
        Fri, 06 Jul 2018 18:22:28 -0700 (PDT)
X-Gm-Message-State: APt69E1EnHYuMIC2wdAe3wSs4tQbgsJvRV5kBCMKkmS7IOCHAUvTh5sM
        jSJLV6u3HoFf0zNw2iwZHfwFK6sTvKyIk2FhjNU=
X-Google-Smtp-Source: AAOMgpeex/+OPf3fvIUckm8Y0ZCjiF3ea8F+rJqht7I2rFlp3DASyK4fwwD9cIsQ3uKh55wRj9mQAiXXrvOJyU9wUv0=
X-Received: by 2002:ab0:13c8:: with SMTP id n8-v6mr7662611uae.140.1530926547902;
 Fri, 06 Jul 2018 18:22:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 18:21:47 -0700 (PDT)
In-Reply-To: <20180706162928.73jfqtdwdcwtagui@kshutemo-mobl1>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems> <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1> <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1> <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
 <20180706104144.6p2s43o3sqc6d5y3@kshutemo-mobl1> <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
 <20180706162928.73jfqtdwdcwtagui@kshutemo-mobl1>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 7 Jul 2018 10:21:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKT8QnoOaoR4LckaAYpBws5MwBTRYMMQFpmxUCmuMWbg@mail.gmail.com>
Message-ID: <CAK7LNAQKT8QnoOaoR4LckaAYpBws5MwBTRYMMQFpmxUCmuMWbg@mail.gmail.com>
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

2018-07-07 1:29 GMT+09:00 Kirill A. Shutemov <kirill@shutemov.name>:
> On Fri, Jul 06, 2018 at 11:13:02PM +0900, Masahiro Yamada wrote:
>> >> LDFLAGS is for internal-use.
>> >> Please do not override it from the command line.
>> >
>> > Can we generate a build error if a user try to override LDFLAGS, CFLAGS or
>> > other critical internal-use-only variables?
>>
>> Yes, Make can check where variables came from.
>
> I think we should do this.
>
>> >> make LDFLAGS_KERNEL=...  LDFLAGS_MODULE=...
>> >> will allow you to append linker flags.
>> >
>> > Okay. It makes me wounder if we should taint kernel in such cases?
>> > Custom compiler/linker flags are risky and can lead to weird bugs.
>>
>> OK.
>> So, what problem are we discussing?
>
> Users set custom LDFLAGS/CFLAGS and break kernel. Then report bug that
> hard to debug. See
>
> https://bugzilla.kernel.org/show_bug.cgi?id=200385


CFLAGS is only used under tools/.
Passing CFLAGS is probably no effect to the kernel.

In Linux makefiles,
KBUILD_ prefixed variables are used internally.

KBUILD_CFLAGS, KBUILD_CPPFLAGS, KBUILD_AFLAGS, etc.


LDFLAGS is an exception.  I do not know why.
Renaming LDFLAGS to KBUILD_LDFLAGS
will make the code consistent.

At least, it will avoid overriding flags by accident.

Of course, users still can change KBUILD_LDFLAGS
if they really want.

The build system could add belt and braces checks for that,
but it is arguable since
there are lots of lots of internal variables.




> and start of this thread:
>
> https://lore.kernel.org/lkml/20180701213243.GA20180@trogon.sfo.coreos.systems/
>
> It took me a while to track down the issue. I blamed linker for a while.
>
>> > I've got it wrong. *Any* LDFLAGS option passed to make this way:
>> >
>> >  make LDFLAGS="..."
>>
>> In your previous mail, I thought you were asking me how to pass
>> custom linker flags.
>>
>> If not, we do not need to think about that case.
>> Just say "Do not do that".
>
> At least we need to make user aware about risk of setting custom flags.
>
> --
>  Kirill A. Shutemov



-- 
Best Regards
Masahiro Yamada
