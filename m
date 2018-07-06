Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DB3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D1F23FEF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paPZwqeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D1F23FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932725AbeGFOkC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:40:02 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39946 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeGFOkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:40:00 -0400
Received: by mail-lf0-f67.google.com with SMTP id y200-v6so9998901lfd.7;
        Fri, 06 Jul 2018 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gsLJDkBoxEtQvnw8Bdja6n2RwfFeR3QFMAb3DJWlRF0=;
        b=paPZwqeb/lVkUV3HAA9Uz1k6MixIpr0hBwCKkcEnWRyo0i/7CJHaPNdgnUUhf/+sVb
         Fw5zqR47mJFl/MtHxL7+vweLqfQ8fTAeNIxYAEbyFWl40Wkdw7mQPJWZrMH4ax/f+iOb
         Y9BJ4/0+qMLVeLJhRN3BO0pPvHV5wPfDCW7DR8e0sWiWk7//0sSK7AXFTijJ6ZNT8PHU
         DhkPTPfeH1/STV4ZDtpzuJa2sI6+HakWbBk13rJcNwWhNnrHV4HM0DErrp+J+8A2uxZi
         mncsffptayFcgf1antW+nvY+uoXdhmkf6QuMXxSaRLmJxfrCtxOtrsIJ3EW1wvtz8PWv
         Q+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gsLJDkBoxEtQvnw8Bdja6n2RwfFeR3QFMAb3DJWlRF0=;
        b=EaXaDXGADFvTd12a4f5sZg1zUPr3a2dhXdvak33QEKAiZ/Bdz12+KVdCh/WfTRMGud
         +ihG3g0PCZimbL7rHe24QnCHSSHdUjiw0UnhUTqcFkfL4HAh5/svad77ZEi/CbZJNcLm
         6OyzfJI/6nhCdyhFGZ0nOAGXFyWTFrpDN8YPdwU22M7bQ7NJx/7ef52oGXsBAo2wZQO9
         DzkBYESXoDgY1nnxZQA5bs55+qrRDGcXu//fYlyRV076xjhOkvYvJN0auBA1iP78DUYY
         S9pcrwk9EKfTt92EBXZL1M+7gQ98RYOa6g4UzI+MJdPGBpsmntsrfgE6/nKbVZcjyUhN
         Nv3Q==
X-Gm-Message-State: APt69E0LQr4kzJ/suPAF0F994NrtKs1MXQttZFGAqcnTIld4LFWS7aYp
        N6JdNJdtIRWOu1Z2DDmiYpW+a0X5D1K6C6MxzQ==
X-Google-Smtp-Source: AAOMgpfLmUFGjc/o7nA479z3AP3AzWhI2PQG+CiNYslLQWZmfFp0FrviDjpb4C0QYk/2M2KElbxF8NArQyi5bduVK0w=
X-Received: by 2002:a19:4a03:: with SMTP id x3-v6mr8110892lfa.136.1530887998809;
 Fri, 06 Jul 2018 07:39:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ef16:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 07:39:28 -0700 (PDT)
In-Reply-To: <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
References: <CAF=P+=5c-baQp-CK1ViG8h=mMRv6d3EgEsN_U4rbBx-Pwv_Krw@mail.gmail.com>
 <20180701213243.GA20180@trogon.sfo.coreos.systems> <CAEJqkghSELJRq7r_OrKvixxnT-rUncV==Ej1+jfYZvkMHz=o_w@mail.gmail.com>
 <20180703124403.veiak4vnbxtmwhv2@kshutemo-mobl1> <20180703142150.tqckl7miou3wf33q@kshutemo-mobl1>
 <20180704150857.szamkvy6jx3fqxlf@kshutemo-mobl1> <CAK7LNARMbt0h4WVdzPzKhMQD-M4ABjffjo4TdtK40RV-NGzTLw@mail.gmail.com>
 <20180706104144.6p2s43o3sqc6d5y3@kshutemo-mobl1> <CAK7LNAS9VuoUakpYEfdo5Bki4eic1QuruvNOfra8oUWUn0embA@mail.gmail.com>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Fri, 6 Jul 2018 16:39:28 +0200
Message-ID: <CAEJqkgiSDdu7a6VyhsrA=rnjevyz2VZZdRVRHBgYHkmHjvAULw@mail.gmail.com>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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

2018-07-06 16:13 GMT+02:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi.
>
> 2018-07-06 19:41 GMT+09:00 Kirill A. Shutemov <kirill@shutemov.name>:
>> On Fri, Jul 06, 2018 at 03:37:58PM +0900, Masahiro Yamada wrote:
>>> >> > > Also see https://bugzilla.kernel.org/show_bug.cgi?id=200385 ,
>>> >> > >
>>> >> > > 0a1756bd2897951c03c1cb671bdfd40729ac2177 is acting up
>>> >> > > too with the same symptoms
>>> >> >
>>> >> > I tracked it down to -flto in LDFLAGS. I'll look more into this.
>>> >>
>>> >> -flto in LDFLAGS screws up this part of paging_prepare():
>>> >
>>> > +Masahiro, Michal.
>>> >
>>> > I've got it wrong. *Any* LDFLAGS option passed to make this way:
>>> >
>>> >   make LDFLAGS="..."
>>> >
>>> > would cause a issue. Even empty.
>>> >
>>> > It overrides all assignments to the variable in the makefile.
>>> > As result the image is built without -pie and linker doesn't generate
>>> > position independed code.
>>> >
>>> > Looks like the patch below helps, but my make-fu is poor.
>>> > I don't see many override directives in kernel makefiles.
>>> > It makes me think that there's a better way to fix this.
>>> >
>>> > Hm?
>>>
>>>
>>> LDFLAGS is for internal-use.
>>> Please do not override it from the command line.
>>
>> Can we generate a build error if a user try to override LDFLAGS, CFLAGS or
>> other critical internal-use-only variables?
>
> Yes, Make can check where variables came from.
>
>
>> This breakage was rather hard to debug. We need to have some kind of
>> fail-safe for the future.
>>
>>> You want to pass your own linker flags
>>> for building vmlinux and modules,
>>> but do not want to pass them to
>>> the decompressor (arch/x86/boot/compressed).
>>>
>>> Correct?
>>
>> I personally don't think that changing compiler/linker options for kernel
>> build is good idea in general.
>>
>>> Kbuild provides a way for users
>>> to pass additional linker flags to modules.
>>> (LDFLAGS_MODULE)
>>>
>>>
>>> But, there is no way to do that for vmlinux.
>>>
>>> It is easy to support it, though.
>>>
>>> https://patchwork.kernel.org/patch/10510833/
>>>
>>> If this is the one you want, I can merge this.
>>>
>>>
>>> make LDFLAGS_KERNEL=...  LDFLAGS_MODULE=...
>>> will allow you to append linker flags.
>>
>> Okay. It makes me wounder if we should taint kernel in such cases?
>> Custom compiler/linker flags are risky and can lead to weird bugs.
>
> OK.
> So, what problem are we discussing?
>
>
>> I've got it wrong. *Any* LDFLAGS option passed to make this way:
>>
>>  make LDFLAGS="..."
>
> In your previous mail, I thought you were asking me how to pass
> custom linker flags.
>
> If not, we do not need to think about that case.
> Just say "Do not do that".

I am sorry but I have a hard time to get your logic here.

You are saying : the *env* variable LDFLAGS as well passing
LDFLAGS to make , which your build allows should not be use
because is for 'internal usage' .. ?

Well that logic you have here is wrong and wrong for any project
not just for the kernel,

If you know 'parts' need have particular flags then 'you' have to
ensure nothing
overrides these or nothing at all can chage these.

So swap your logic and apped LDFLAGS to your private
'call_it_whatever_you_wish_KERNEL_NEED_BE_THERE_ANY_KIND_FLAGS'
and don't allow these to be changed at all , when you
*know* they have be there.


Teling users to not use LD/C/CXX flags is not really going to work right ?


BR
