Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DA5C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6201205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ERnM70Hm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6201205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeHZVIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 17:08:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46754 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHZVIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 17:08:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so6335846pga.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 10:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7ZBoKEYETszzG+HUbF/glOzLXsQfAkugbP/UocLVlbE=;
        b=ERnM70HmQriHzUGIeN29rAI9aes1bM5CpyGrROrI9HVeX2QC4fvINa0VpUxHOwd2f5
         tkp3RNaFND4xDTJLNc2BSzVu9mQrKL3Boik1AGleEzIRqJOctJyEXYoy5zVyUkykMBsQ
         D/p8gCflG9wsgK6j1xtm4bl8tWiwsmgs6dX9m8xrHaI3nu+/DK5V6pOLXrAykI3q5upS
         OKGvMUKDrS0SX3jVwoMjKM9ND42A9fWkdKApx8PHK16Vz7fpa2qmSPSKCusSTvs3cdGy
         ne6/bCgVsA5MrrEVzhMRKSFyjDMPrvEFGis+Y4f0AL70NKtDZlRgLwjKmxGINhcfZZjm
         t0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7ZBoKEYETszzG+HUbF/glOzLXsQfAkugbP/UocLVlbE=;
        b=P/K8KHeiIlu+RTmPapJBFbqGBPOiM/2U8iAc9s2zBN+W5kwclWYmINqGDZAmSkTNNK
         r5aY5ryBxAGFZ1mzObyk29tX5Kc0zgcUBw3xw3l0RZmq1KZ93ktyDdWmrXDgSh4EIY+a
         aCDHPOg9/AYoWVlaRDT9c8Mde5QKmkagiGjBxMabSNzQ/31JuSBTCzmJXaoCNBjfIA/6
         jkrstjiInHQRWiAe3YRFfrA3h6bCqJuA+nX9UXu7jKxDwMP5TXzMtzVfGytjjLWHvv5m
         nMK4g75H07O8YRNElw16qLdw/cfn/IAWkQ4IhDkFHhJaLHKG/GFLkgutxEEeqKLZ4HVg
         17og==
X-Gm-Message-State: APzg51D678BWUz2+qVgm4yJF1dd3ZV1rnkyz3FC7zhGAuF+XRW8Fwbxz
        Yzao4srdXrvwu0ylX14nlc9LJXZuS1w=
X-Google-Smtp-Source: ANB0VdafsWBsz5/ZK+kNz2YaNkleYUA10Ntelzh5kUiarqkujAPzr7nelyzXwHAVNL7DjQCzy1gKDA==
X-Received: by 2002:a62:c90a:: with SMTP id k10-v6mr10713402pfg.180.1535304313845;
        Sun, 26 Aug 2018 10:25:13 -0700 (PDT)
Received: from ?IPv6:2600:1010:b059:8f54:6d06:2cf1:4a39:d37e? ([2600:1010:b059:8f54:6d06:2cf1:4a39:d37e])
        by smtp.gmail.com with ESMTPSA id v20-v6sm25961750pfk.12.2018.08.26.10.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 10:25:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: TLB flushes on fixmap changes
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAGXu5jKk+ELGsSXC8e3v67oo74BF9rP2HDqMHx1Sb17-0F-xZQ@mail.gmail.com>
Date:   Sun, 26 Aug 2018 10:25:11 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF353FDA-4A57-4F5E-A403-531DDA0DBC25@amacapital.net>
References: <20180822153012.173508681@infradead.org> <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net> <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police> <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com> <20180824180438.GS24124@hirez.programming.kicks-ass.net>
 <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com> <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com> <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
 <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com> <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
 <20180826112341.f77a528763e297cbc36058fa@kernel.org> <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
 <CAGXu5j+xUbq_mu=2jvH2Vu+mviteZJqdPNTrxpaijwsuDdN-sw@mail.gmail.com>
 <952A64F0-90B3-4E2F-B410-7E20BE90D617@amacapital.net> <CAGXu5jKk+ELGsSXC8e3v67oo74BF9rP2HDqMHx1Sb17-0F-xZQ@mail.gmail.com>
To:     Kees Cook <keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 26, 2018, at 9:47 AM, Kees Cook <keescook@chromium.org> wrote:
>=20
>> On Sun, Aug 26, 2018 at 7:20 AM, Andy Lutomirski <luto@amacapital.net> wr=
ote:
>>=20
>>=20
>>>> On Aug 25, 2018, at 9:43 PM, Kees Cook <keescook@chromium.org> wrote:
>>>>=20
>>>>> On Sat, Aug 25, 2018 at 9:21 PM, Andy Lutomirski <luto@kernel.org> wro=
te:
>>>>> On Sat, Aug 25, 2018 at 7:23 PM, Masami Hiramatsu <mhiramat@kernel.org=
> wrote:
>>>>> On Fri, 24 Aug 2018 21:23:26 -0700
>>>>> Andy Lutomirski <luto@kernel.org> wrote:
>>>>>> Couldn't text_poke() use kmap_atomic()?  Or, even better, just change=
 CR3?
>>>>>=20
>>>>> No, since kmap_atomic() is only for x86_32 and highmem support kernel.=

>>>>> In x86-64, it seems that returns just a page address. That is not
>>>>> good for text_poke, since it needs to make a writable alias for RO
>>>>> code page. Hmm, maybe, can we mimic copy_oldmem_page(), it uses iorema=
p_cache?
>>>>>=20
>>>>=20
>>>> I just re-read text_poke().  It's, um, horrible.  Not only is the
>>>> implementation overcomplicated and probably buggy, but it's SLOOOOOW.
>>>> It's totally the wrong API -- poking one instruction at a time
>>>> basically can't be efficient on x86.  The API should either poke lots
>>>> of instructions at once or should be text_poke_begin(); ...;
>>>> text_poke_end();.
>>>>=20
>>>> Anyway, the attached patch seems to boot.  Linus, Kees, etc: is this
>>>> too scary of an approach?  With the patch applied, text_poke() is a
>>>> fantastic exploit target.  On the other hand, even without the patch
>>>> applied, text_poke() is every bit as juicy.
>>>=20
>>> I tried to convince Ingo to use this method for doing "write rarely"
>>> and he soundly rejected it. :) I've always liked this because AFAICT,
>>> it's local to the CPU. I had proposed it in
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=
=3Dkspp/write-rarely&id=3D9ab0cb2618ebbc51f830ceaa06b7d2182fe1a52d
>>=20
>> Ingo, can you clarify why you hate it?  I personally would rather use CR3=
, but CR0 seems like a fine first step, at least for text_poke.
>=20
> Sorry, it looks like it was tglx, not Ingo:
>=20
> https://lkml.kernel.org/r/alpine.DEB.2.20.1704071048360.1716@nanos
>=20
> This thread is long, and one thing that I think went unanswered was
> "why do we want this to be fast?" the answer is: for doing page table
> updates. Page tables are becoming a bigger target for attacks now, and
> it's be nice if they could stay read-only unless they're getting
> updated (with something like this).
>=20
>=20

It kind of sounds like tglx would prefer the CR3 approach. And indeed my pat=
ch has a serious problem wrt the NMI code.

