Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA9C04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34AA2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f82t5bNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34AA2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeINDbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:31:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47058 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeINDbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:31:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so3285790pfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNpZDY++mCeCl7CX2IIt3kDcnLGQUx3a40KbAkA2prE=;
        b=f82t5bNebYgVTg92dBEG5tYS5cMAGaEv2i/IbTjHmKvCePAFqvXj9YIHsUpH8Zz+pb
         XrGuhp47ghFjYPWor90icIOHYSd53eTA0icDFHc8Vtq6xXx8ckGr4j4Q7iN/HvcupVVh
         BoRovx8j+VMePZu0gYvx7mCQOajpjABXN+9UdjXKlsg2io+4weYdp6ejYePsmrVG20PT
         o4pSUJm0hRhjQymi2Q2jxgOY2TL2AO06JU5IZUfpVHLiqQVUkyN/5ntFmtYxbFBzeYDf
         EHyQgEMhK5n+RpKy2PsfKuO9L+esaAI6haUCxy8XzUiP6Yet0YqsdEFl641ZmDoWnKFG
         /3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNpZDY++mCeCl7CX2IIt3kDcnLGQUx3a40KbAkA2prE=;
        b=Q/rrMyhtf2Cr7EI4CuE1e/gG6yr4p7QsZ6pws0ljsjyuXGb5dQ6oHOjX2ifn6xrK7W
         XUrxjbu9VKvOvvBKuUiSlxiOTfcjRIYK1t6LRbF7jb89WScJj6PuSA6nOqmJolDyV5QJ
         4xOxFV7p9SJraa1FyRhByqoY+BW2POXbToxBKEUSDgM3UW03a7NSPF+My17o/r6Y8AFf
         FBGUrzENiOAo0czBPuN3nK6j+rZduDOzeGdDGV+sqiqzthtKnCkxVeIjJB0uPIpbOEGu
         egTjwnbtotEHyiL91Aa+2rNRzwQn2fVgt3bznxbW2g9e8x1ipBNKvRfcDFrdNf2S/itp
         lPFQ==
X-Gm-Message-State: APzg51DwkdZPeHKJWibrCBQP6ly1DPoOEmrb2Sq3PYjivMssrRW1L+pO
        crPtCiiNSa8XCq+XE6cP96NVpVXv+MxpRPWc2f+jHg==
X-Google-Smtp-Source: ANB0VdYJAEG4W1NL3NWgGbY4V8f2Vjb9d705B3liOJWRBE6o5NtBa9XlaDKMZ8/lzkzblS2kGJeDVP5kFue6p1XBArA=
X-Received: by 2002:a63:1363:: with SMTP id 35-v6mr8910022pgt.202.1536877219108;
 Thu, 13 Sep 2018 15:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180910060455.20409-1-stefan@agner.ch> <CAK8P3a2cc741UqFSk+hXpC2s4S+A+0FuiM1yP=Z4rC18sJHq9g@mail.gmail.com>
 <CANiq72mGH3KW+FxVDF0PcAeaTCtnNz_oO=2-u4zZQ9kvbRDCtA@mail.gmail.com> <CANiq72=BE8ygC6r4cJ2TshwOKCEv0C8F2xmpLRhSVMfqq16xUQ@mail.gmail.com>
In-Reply-To: <CANiq72=BE8ygC6r4cJ2TshwOKCEv0C8F2xmpLRhSVMfqq16xUQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Sep 2018 15:20:07 -0700
Message-ID: <CAKwvOdkgdbn76+jGEwUayGriGn+4GQVLtxkzszkBueP6XuOGLw@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler-clang.h: define __naked
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, dwmw@amazon.co.uk,
        Paul Lawrence <paullawrence@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 9:03 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi again,
>
> On Wed, Sep 12, 2018 at 6:19 AM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > I will do a bigger one tomorrow or so and see if there are any
> > important differences. Regardless of what we do, I will send the
> > __naked patches separately as well (requested by Nick on GitHub).
>
> So I did a comparison with a full allyesconfig between -rc2 and -rc2 +
> v4. I find quite a lot binary differences, but not a single objdump -d
> difference (object file by object file) just by fixing UTS_RELEASE to
> the same value, so I guess that is a very good sign in case someone
> wants to pick the entire series sooner than expected. Regardless, I
> will send the separate __naked patches.
>
> I should note that, at some point in one of my allyesconfig builds I got this:
>
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   AR      built-in.a
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> ld: drivers/edac/amd64_edac.o(.text+0x200031d2): reloc against
> `__asan_load4_noabort': error 4
> ld: final link failed: Nonrepresentable section on output
> Makefile:1035: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1

+ Dmitry for the KASAN error (Andrey was already cc'ed)

>
> Running make (without cleaning) didn't reproduce it, and the other
> allyesconfig builds didn't suffer any problem either. Maybe my
> hardware is failing, but I wanted to let you know nevertheless.
>
> Cheers,
> Miguel



-- 
Thanks,
~Nick Desaulniers
