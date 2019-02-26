Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481CFC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164642173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jk4s/BkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfBZOlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:41:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35848 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfBZOli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:41:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so6350709pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ORID1v1ozYXyKv1mw/ofFm5kiuOuJ/TBoHbnGpDrQY0=;
        b=Jk4s/BkFrIcxrk4e9Mx5smnm1MMtapGUCpafH868xdIWYkLK7M78NPFfkO1hXlBR3s
         fHSFCSGQY90XYaDQqb63dSKPREtSbEi2GwRgT00jYvnEy0yQetugEzlFqBmtB3qipsAd
         q/rhOJ6CKsqxpXxBDrJDcb0ls8JRx8hPmbNL5pXQCFMY5+3weHhsnBcu5hbxiUG4WqQl
         pBEq1Wji+wh6z+8emU3AosXH6snGNQBpu8akU3FP96jjwWcneLVMTgn776abphESvY54
         iMhXTsCqkSEIu1VQDJchEorqdn4d1RpFfWm51ZaV3ypfOUhUpwNhpwhi50tHIgnGBRqu
         SjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ORID1v1ozYXyKv1mw/ofFm5kiuOuJ/TBoHbnGpDrQY0=;
        b=ExrEMD8pP9CBXgFsH3ljIlh/XL4tUvqHOLBhr8FEP/dKPwX5gezZoKTjO0B7y3aE4E
         pmu1XSYNGOY83V1tUyGI9gkk7HoAstcMYtKLxc3ytWQMzR7uznuiZVIoEhuE8Hg3JgJs
         +Qx6yHQPTQ3sn5NhoFpFPCjFWaF9Wijf53W02aoiauN+fqaInlrEc4Tn9RaC2CEBz4wh
         iAttNBJrRs1H3jYf0ieyMHTpk+7XyHWawLswMd3XGm9BjNv5+HFfJ6+GUouRHA4gXjG4
         CQ2zls40XKLHXWW5ZcIZZe9s1x50HCK7fngJO7kqDwLacgsoGR6NKd8FVuBqDkG2VOnN
         F2Iw==
X-Gm-Message-State: AHQUAuZFynhPehQB6ggo5YAO0TR5Gxh+SH29C0RSO9iyZlGvKyDu7G3j
        PID4GW6Xk/wOwl9DN9xm4DoqtVPIzzgA0D4edYq/lA==
X-Google-Smtp-Source: AHgI3IZRaeChYbi2J79TLZ2OQNrL+zd2lHSInwkIpfXgbjWxpzJly0F0LoxycLTV6qaHuDyyWxELKtQh0Gjyn9jKmaE=
X-Received: by 2002:a62:4299:: with SMTP id h25mr26113838pfd.165.1551192097850;
 Tue, 26 Feb 2019 06:41:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550839937.git.andreyknvl@google.com> <3875fa863b755d8cb43afa7bb0fe543e5fd05a5d.1550839937.git.andreyknvl@google.com>
 <81ea4e77-90a4-4fd9-2bc8-135e0da30044@intel.com>
In-Reply-To: <81ea4e77-90a4-4fd9-2bc8-135e0da30044@intel.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 26 Feb 2019 15:41:26 +0100
Message-ID: <CAAeHK+z2qw__Kpeih2mEyhVJ-gbor1vYsOZddT5E71JDiSg7pg@mail.gmail.com>
Subject: Re: [PATCH v10 04/12] mm, arm64: untag user pointers passed to memory syscalls
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 12:07 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/22/19 4:53 AM, Andrey Konovalov wrote:
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -578,6 +578,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
> >  SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
> >               unsigned long, prot)
> >  {
> > +     start = untagged_addr(start);
> >       return do_mprotect_pkey(start, len, prot, -1);
> >  }
> >
> > @@ -586,6 +587,7 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
> >  SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
> >               unsigned long, prot, int, pkey)
> >  {
> > +     start = untagged_addr(start);
> >       return do_mprotect_pkey(start, len, prot, pkey);
> >  }
>
> This seems to have taken the approach of going as close as possible to
> the syscall boundary and untagging the pointer there.  I guess that's
> OK, but it does lead to more churn than necessary.  For instance, why
> not just do the untagging in do_mprotect_pkey()?

I think that makes more sense, will do in the next version, thanks!

>
> I think that's an overall design question.  I kinda asked the same thing
> about patching call sites vs. VMA lookup functions.

Replied in the other thread.
