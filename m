Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B800C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 05:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB972147D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 05:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2owTXQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB972147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeHZJfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 05:35:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42254 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeHZJfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 05:35:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so6282371pff.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018 22:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FCFtb8j9XOxXsAeacrgs4e41ka3CLAoSbaGqUsmExt8=;
        b=s2owTXQePiW1/A6R1wVoNuSmIus4SHmadKi/AaAtNb6NmR+y3no24jf95RpUWEGpQ6
         lbpBRocwkHUTe+ueXtzhwyPQ6XmrkVTA3jESQmrBPLsCXGvfIT1eEU9WfINR29nW0FMF
         Uj9SXJO5RC7SEzH7tVuVZAKJYFonA7N7+U9kKhhJ2ThMgwtdft5cx57C7rP6W/Eifciu
         WwVSgv1ngm6CDlotIXSdlwi9p0SQdfWhc2egpFFD69i0zwvSMhL196XslwYeX5oH7oTC
         tE0+ONxqcgHGZJH4V3BjGFB2llKB19DpaKu94K6PcOYEToPYLMSlP2QTHDeW62Ib21YY
         of+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FCFtb8j9XOxXsAeacrgs4e41ka3CLAoSbaGqUsmExt8=;
        b=RxTSpRwU3/G4PQvpuUXX6zd4QlWfRiRJa55ERKIqFihG+p0IeYQxfYoFspJg5Ys0Y8
         c9JG7AtXsQ82X8KSLt4op5Cy8nv/BFVhm5AvifetGPB9EYB5/MFFUxuAST4zOmrZYhs3
         vrIhYH0BapSEJs04kfhKVTy2EOMnrzeRwOVwa6EI7CqGYgvPOk9/2dgimSh++iApLnDG
         QSMt/CwjLePIvp9t84gmxxADIqsWhVL6lbaUj3WBffKWMCzjY0lcwJLqO6JjnTjRPxDc
         c+/zHfA4U8ES8OuNMuwyTN/0/9LLO83aBpqI5zgUgWf+R3EveXl7AH0/TeIJWgLeYJC6
         sblg==
X-Gm-Message-State: APzg51D6dUKvS+MMBFB3qKBHIoC7YFQMjE8SHhe/LV+M/WHIWV8BDojg
        IWXHpoaWTTAvs2Pc1c+GJwA=
X-Google-Smtp-Source: ANB0Vdb5tx7tT5884qLAFax8Trk3qwTa+3BszA7hfZYnmffVskU48VzK6uOvqf5KN20LW9M2oAph6A==
X-Received: by 2002:a62:8c8c:: with SMTP id m134-v6mr8743657pfd.130.1535262851123;
        Sat, 25 Aug 2018 22:54:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4580:b719:b5ce:2cca:790b:b1c4? ([2601:647:4580:b719:b5ce:2cca:790b:b1c4])
        by smtp.gmail.com with ESMTPSA id h4-v6sm12985784pgp.13.2018.08.25.22.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Aug 2018 22:54:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: TLB flushes on fixmap changes
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAGXu5j+xUbq_mu=2jvH2Vu+mviteZJqdPNTrxpaijwsuDdN-sw@mail.gmail.com>
Date:   Sat, 25 Aug 2018 22:53:47 -0700
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-Id: <C94B994E-9332-44F4-A01F-36013E5B4054@gmail.com>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net>
 <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
 <20180823133958.GA1496@brain-police>
 <20180824084717.GK24124@hirez.programming.kicks-ass.net>
 <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com>
 <20180824180438.GS24124@hirez.programming.kicks-ass.net>
 <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
 <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com>
 <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
 <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com>
 <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
 <20180826112341.f77a528763e297cbc36058fa@kernel.org>
 <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
 <CAGXu5j+xUbq_mu=2jvH2Vu+mviteZJqdPNTrxpaijwsuDdN-sw@mail.gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 9:43 PM, Kees Cook <keescook@chromium.org> wrote:

> On Sat, Aug 25, 2018 at 9:21 PM, Andy Lutomirski <luto@kernel.org> =
wrote:
>> On Sat, Aug 25, 2018 at 7:23 PM, Masami Hiramatsu =
<mhiramat@kernel.org> wrote:
>>> On Fri, 24 Aug 2018 21:23:26 -0700
>>> Andy Lutomirski <luto@kernel.org> wrote:
>>>> Couldn't text_poke() use kmap_atomic()?  Or, even better, just =
change CR3?
>>>=20
>>> No, since kmap_atomic() is only for x86_32 and highmem support =
kernel.
>>> In x86-64, it seems that returns just a page address. That is not
>>> good for text_poke, since it needs to make a writable alias for RO
>>> code page. Hmm, maybe, can we mimic copy_oldmem_page(), it uses =
ioremap_cache?
>>=20
>> I just re-read text_poke().  It's, um, horrible.  Not only is the
>> implementation overcomplicated and probably buggy, but it's SLOOOOOW.
>> It's totally the wrong API -- poking one instruction at a time
>> basically can't be efficient on x86.  The API should either poke lots
>> of instructions at once or should be text_poke_begin(); ...;
>> text_poke_end();.
>>=20
>> Anyway, the attached patch seems to boot.  Linus, Kees, etc: is this
>> too scary of an approach?  With the patch applied, text_poke() is a
>> fantastic exploit target.  On the other hand, even without the patch
>> applied, text_poke() is every bit as juicy.
>=20
> I tried to convince Ingo to use this method for doing "write rarely"
> and he soundly rejected it. :) I've always liked this because AFAICT,
> it's local to the CPU. I had proposed it in
> =
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=3D=
kspp/write-rarely&id=3D9ab0cb2618ebbc51f830ceaa06b7d2182fe1a52d
>=20
> With that, text_poke() mostly becomes:
>=20
> rare_write_begin()
> memcpy(addr, opcode, len);
> rare_write_end()
>=20
> As for juiciness, if an attacker already has execution control, they
> can do more interesting things than text_poke(). But regardless, yes,
> it's always made me uncomfortable. :)

I think that the key to harden the security of text_poke() against its =
use
as a gadget in a ROP/JOP attack is to add a check/assertion for the old
(expected) value, such as:

rare_write_begin()
if (*addr =3D=3D prev_opcode)
	memcpy(addr, opcode, len);
rare_write_end()

