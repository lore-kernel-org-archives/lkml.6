Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98398C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC2720873
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmBk2hii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC2720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbeH0HK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 03:10:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42433 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeH0HK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 03:10:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so3500094plq.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 20:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XJAHdXnBJMJAI4N1dc7nhQMxbmZk4djGRzYosmTiN2o=;
        b=dmBk2hiiS85R3mpGCshG7+C0ZQ/L2RBQ0mJL6Zg9DLoYRoV3XJ672ulhjXTlCFGSAb
         3ODVDdPQuBaVuiNZ+toQUpizZNjEERaaph/K5LZFxELzcqqt5JrA3b/5K+nBLxa79gC4
         QLrMO0OlO/tlVYDBu4M+vQgBq/XJGSg7bDCcdyJ0feitgytUrU+Xtt2Wrw5qtUUD7J9f
         hNgfDay1kAoEjj7dbOxXnrQZUfnqSBwyAEnhVRPb00WrnZ0BJ0BPne++lem+9qRlLBBc
         3LWFjgXpAxWqHvA375ZYnwrJcS5vB1Q34ITzGam8SQBovKK/KuilYcnsNx5tvHTwl87i
         oTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XJAHdXnBJMJAI4N1dc7nhQMxbmZk4djGRzYosmTiN2o=;
        b=sm4XTDwR/3zYW9XcdenPXiA4rUbdOMTRkBdW2/ED9oeKqsV3H5NNtpJs9Ktu49pglK
         iBH/nYROoOrXNmH7KhSLWwtH+KPRRe4zvHw9Pq/Pts/5xRC2ZsZ5ZDDtMVXCVjbrjWoU
         tgyQb249n2wAsRjHkLfjYA3xeg9bx4AugwaTpDfaibb+3uWEGmcB70cvBd+okR6QvQfs
         a87t5uO5OvnffCMgkM3KLYArFqtNUiuWt/7GgFj4JjLY0NeBMKyS0vtThp8TZCZcdAdI
         MDxhZu6dIz3yapGVHvdqf/IU9NQ+3xwc+moBg83HwxD4MTmVvDwWrJUOTDsItdCJ0HRk
         LDYA==
X-Gm-Message-State: APzg51AEIqc5DYYk5cZuHUbjthG9bqD3NTY9VpRiBvxUMpJcDNVfqH6O
        DD5Nf3NVShL6l4B3zexgOew=
X-Google-Smtp-Source: ANB0VdYvo8yJttWNNtZaB0o/Imy7QOGjEn33lzUy09U7BxoI4jPN1rChH9zUmS+X1HIRnlv9o6HYXg==
X-Received: by 2002:a17:902:8481:: with SMTP id c1-v6mr11330712plo.177.1535340374218;
        Sun, 26 Aug 2018 20:26:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4580:b719:95a3:75b3:796a:8fc5? ([2601:647:4580:b719:95a3:75b3:796a:8fc5])
        by smtp.gmail.com with ESMTPSA id g6-v6sm16290995pgg.7.2018.08.26.20.26.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 20:26:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: TLB flushes on fixmap changes
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20180827120305.01a6f26267c64610cadec5d8@kernel.org>
Date:   Sun, 26 Aug 2018 20:26:09 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Message-Id: <4BF82052-4738-441C-8763-26C85003F2C9@gmail.com>
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
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 8:03 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Sun, 26 Aug 2018 11:09:58 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Sat, Aug 25, 2018 at 09:21:22PM -0700, Andy Lutomirski wrote:
>>> I just re-read text_poke().  It's, um, horrible.  Not only is the
>>> implementation overcomplicated and probably buggy, but it's =
SLOOOOOW.
>>> It's totally the wrong API -- poking one instruction at a time
>>> basically can't be efficient on x86.  The API should either poke =
lots
>>> of instructions at once or should be text_poke_begin(); ...;
>>> text_poke_end();.
>>=20
>> I don't think anybody ever cared about performance here. Only
>> correctness. That whole text_poke_bp() thing is entirely tricky.
>=20
> Agreed. Self modification is a special event.
>=20
>> FWIW, before text_poke_bp(), text_poke() would only be used from
>> stop_machine, so all the other CPUs would be stuck busy-waiting with
>> IRQs disabled. These days, yeah, that's lots more dodgy, but yes
>> text_mutex should be serializing all that.
>=20
> I'm still not sure that speculative page-table walk can be done
> over the mutex. Also, if the fixmap area is for aliasing
> pages (which always mapped to memory), what kind of
> security issue can happen?

The PTE is accessible from other cores, so just as we assume for L1TF =
that
the every addressable memory might be cached in L1, we should assume and
PTE might be cached in the TLB when it is present.

Although the mapping is for an alias, there are a couple of issues here.
First, this alias mapping is writable, so it might an attacker to change =
the
kernel code (following another initial attack). Second, the alias =
mapping is
never explicitly flushed. We may assume that once the original mapping =
is
removed/changed, a full TLB flush would take place, but there is no
guarantee it actually takes place.

> Anyway, from the viewpoint of kprobes, either per-cpu fixmap or
> changing CR3 sounds good to me. I think we don't even need per-cpu,
> it can call a thread/function on a dedicated core (like the first
> boot processor) and wait :) This may prevent leakage of pte change
> to other cores.

I implemented per-cpu fixmap, but I think that it makes more sense to =
take
peterz approach and set an entry in the PGD level. Per-CPU fixmap either
requires to pre-populate various levels in the page-table hierarchy, or
conditionally synchronize whenever module memory is allocated, since =
they
can share the same PGD, PUD & PMD. While usually the synchronization is =
not
needed, the possibility that synchronization is needed complicates =
locking.

Anyhow, having fixed addresses for the fixmap can be used to circumvent
KASLR.

I don=E2=80=99t think a dedicated core is needed. Anyhow there is a lock
(text_mutex), so use_mm() can be used after acquiring the mutex.

