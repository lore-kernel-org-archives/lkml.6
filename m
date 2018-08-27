Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E93AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B57208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWudvpGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B57208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeH0VWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:22:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43823 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbeH0VWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:22:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id v66-v6so7737423pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 10:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JrLhqF1ehZxrvsIEoFtfDR1uxk/uFuVr3I6zUIDteRw=;
        b=iWudvpGNdq93RY63E0zSDc2EeBFvAVPo1J2xt8Ypwe9fR8y+hO3YEsT/sMSmSdYzvg
         AgzRyGDWmENLtQWtE1nqPpYaRq7trl6kJhejKjF8xN4yoILZ7rwlVgPt1zkw4Dns1sBv
         d6JTNwk44qI/lCR2EYW+HeR07Srr1PNXF8eAj5i54gS28HNsDdI2KG+4LklLyswGauwW
         TKzTq31w2Jj7Byv8mZ+2hF3sAcyVyeUZoYfhQ4vnrwXEX23zZpGlvgqnkz5nmP6hEHD6
         eL2AIPqdmcwoHPRiylU4NVS3X1Eu7xHOLqIQOsqOAkX7gkQtyma8nOtHfiizVhxTK91h
         Py3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JrLhqF1ehZxrvsIEoFtfDR1uxk/uFuVr3I6zUIDteRw=;
        b=MVPGEmRxSpHzV9kxX7vcLUj02nLQRAi0rvqqvn1vn23lvCz6xf2Of+OznsyIetCC2r
         GE6DIkficToyX+zgzJY7c6c8IOD0v0kct/2gmdEtsw40KOYfr1S5BEmLaGtxyGP/+/Xz
         kChSR3tr5GepIo+HTkLpcky1RZBdqlS9QSMtihMw0mgYhQUXQQui8o0RQDuaiwF+wUDX
         iZ0yVDzhmneaCyEaiRdob1EmIIBTEjPHge9CFvmgURq0DkMzyEtfQ0EdMwmUaeIzvfmL
         eQo8Dp2EUTLWaseluLKSVI4bB6MRdYjWaS4yrrkrFLKKvUYOHPDijqA7TvJ81Db/iEoR
         JOrw==
X-Gm-Message-State: APzg51Dqlv6JMNuhL7ucVh4G7/maaPOwdguO9CfriYYXp1fgJaK6V0P1
        DFMrE5RF3FwZRSI+LUpFMDU=
X-Google-Smtp-Source: ANB0VdaBw7BGWM+787GrjL+O792IW9ekooY/81Uik9z3br/AMbrvfwzuCxnKfJoq9nyWCahEsG7Log==
X-Received: by 2002:a63:6385:: with SMTP id x127-v6mr13314524pgb.413.1535391280366;
        Mon, 27 Aug 2018 10:34:40 -0700 (PDT)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j16-v6sm47782725pfk.125.2018.08.27.10.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 10:34:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: TLB flushes on fixmap changes
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20180827170511.6bafa15cbc102ae135366e86@kernel.org>
Date:   Mon, 27 Aug 2018 10:34:36 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
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
Message-Id: <01DA0BDD-7504-4209-8A8F-20B27CF6A1C7@gmail.com>
References: <D74A89DF-0D89-4AB6-8A6B-93BEC9A83595@gmail.com>
 <20180824180438.GS24124@hirez.programming.kicks-ass.net>
 <56A9902F-44BE-4520-A17C-26650FCC3A11@gmail.com>
 <CA+55aFzerzTPm94jugheVmWg8dJre94yu+GyZGT9NNZanNx_qw@mail.gmail.com>
 <9A38D3F4-2F75-401D-8B4D-83A844C9061B@gmail.com>
 <CA+55aFz1KYT7fRRG98wei24spiVg7u1Ec66piWY5359ykFmezw@mail.gmail.com>
 <8E0D8C66-6F21-4890-8984-B6B3082D4CC5@gmail.com>
 <CALCETrWdeKBcEs7zAbpEM1YdYiT2UBXwPtF0mMTvcDX_KRpz1A@mail.gmail.com>
 <20180826112341.f77a528763e297cbc36058fa@kernel.org>
 <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
 <20180826090958.GT24124@hirez.programming.kicks-ass.net>
 <20180827120305.01a6f26267c64610cadec5d8@kernel.org>
 <4BF82052-4738-441C-8763-26C85003F2C9@gmail.com>
 <20180827170511.6bafa15cbc102ae135366e86@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 1:05 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Sun, 26 Aug 2018 20:26:09 -0700
> Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>> at 8:03 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>=20
>>> On Sun, 26 Aug 2018 11:09:58 +0200
>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>>=20
>>>> On Sat, Aug 25, 2018 at 09:21:22PM -0700, Andy Lutomirski wrote:
>>>>> I just re-read text_poke().  It's, um, horrible.  Not only is the
>>>>> implementation overcomplicated and probably buggy, but it's =
SLOOOOOW.
>>>>> It's totally the wrong API -- poking one instruction at a time
>>>>> basically can't be efficient on x86.  The API should either poke =
lots
>>>>> of instructions at once or should be text_poke_begin(); ...;
>>>>> text_poke_end();.
>>>>=20
>>>> I don't think anybody ever cared about performance here. Only
>>>> correctness. That whole text_poke_bp() thing is entirely tricky.
>>>=20
>>> Agreed. Self modification is a special event.
>>>=20
>>>> FWIW, before text_poke_bp(), text_poke() would only be used from
>>>> stop_machine, so all the other CPUs would be stuck busy-waiting =
with
>>>> IRQs disabled. These days, yeah, that's lots more dodgy, but yes
>>>> text_mutex should be serializing all that.
>>>=20
>>> I'm still not sure that speculative page-table walk can be done
>>> over the mutex. Also, if the fixmap area is for aliasing
>>> pages (which always mapped to memory), what kind of
>>> security issue can happen?
>>=20
>> The PTE is accessible from other cores, so just as we assume for L1TF =
that
>> the every addressable memory might be cached in L1, we should assume =
and
>> PTE might be cached in the TLB when it is present.
>=20
> Ok, so other cores can accidentally cache the PTE in TLB, (and no way
> to shoot down explicitly?)

There is way (although current it does not). But it seems that the =
consensus
is that it is better to avoid it being mapped at all in remote cores.

>> Although the mapping is for an alias, there are a couple of issues =
here.
>> First, this alias mapping is writable, so it might an attacker to =
change the
>> kernel code (following another initial attack).
>=20
> Combined with some buffer overflow, correct? If the attacker already =
can
> write a kernel data directly, he is in the kernel mode.

Right.

>=20
>> Second, the alias mapping is
>> never explicitly flushed. We may assume that once the original =
mapping is
>> removed/changed, a full TLB flush would take place, but there is no
>> guarantee it actually takes place.
>=20
> Hmm, would this means a full TLB flush will not flush alias mapping?
> (or, the full TLB flush just doesn't work?)

It will flush the alias mapping, but currently there is no such explicit
flush.

>>> Anyway, from the viewpoint of kprobes, either per-cpu fixmap or
>>> changing CR3 sounds good to me. I think we don't even need per-cpu,
>>> it can call a thread/function on a dedicated core (like the first
>>> boot processor) and wait :) This may prevent leakage of pte change
>>> to other cores.
>>=20
>> I implemented per-cpu fixmap, but I think that it makes more sense to =
take
>> peterz approach and set an entry in the PGD level. Per-CPU fixmap =
either
>> requires to pre-populate various levels in the page-table hierarchy, =
or
>> conditionally synchronize whenever module memory is allocated, since =
they
>> can share the same PGD, PUD & PMD. While usually the synchronization =
is not
>> needed, the possibility that synchronization is needed complicates =
locking.
>=20
> Could you point which PeterZ approach you said? I guess it will be
> make a clone of PGD and use it for local page mapping (as new mm).
> If so, yes it sounds perfectly fine to me.

The thread is too long. What I think is best is having a mapping in the =
PGD
level. I=E2=80=99ll try to give it a shot, and see what I get.

>> Anyhow, having fixed addresses for the fixmap can be used to =
circumvent
>> KASLR.
>=20
> I think text_poke doesn't mind using random address :)
>=20
>> I don=E2=80=99t think a dedicated core is needed. Anyhow there is a =
lock
>> (text_mutex), so use_mm() can be used after acquiring the mutex.
>=20
> Hmm, use_mm() said;
>=20
> /*
> * use_mm
> *      Makes the calling kernel thread take on the specified
> *      mm context.
> *      (Note: this routine is intended to be called only
> *      from a kernel thread context)
> */
>=20
> So maybe we need a dedicated kernel thread for safeness?

Yes, it says so. But I am not sure it cannot be changed, at least for =
this
specific use-case. Switching kernel threads just for patching seems to =
me as
an overkill.

Let me see if I can get something half-reasonable doing so...

