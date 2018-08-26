Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04DFC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 04:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E85B20C10
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 04:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEvv4rxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E85B20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeHZIC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 04:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbeHZIC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 04:02:57 -0400
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B3222147E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 04:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535257304;
        bh=cV1NyIUo5DJq0d8i1KBHx6+lK3xKm4cWAoLN0X9qLUU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=QEvv4rxnZases3Ur1qo+iaaKZWe+EEQsz4dPbJzXsa70zB+xaWMNXX9YlfvWTd5lW
         69+Rd5NmYV4jbFdNxEUEGJ6DS7/9qsWOvAjreF4sBH889oaJjY93pjqnYqT5bpAbTO
         pK13/TLGdAanp9+FER3GETaptgXBGmeDExF0sWAg=
Received: by mail-wm0-f47.google.com with SMTP id n11-v6so5132147wmc.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018 21:21:44 -0700 (PDT)
X-Gm-Message-State: APzg51ApPnDw2WFMHOTbiXZkKw18pdr8kgfjQyLipvPAoG06ncRgymkC
        15X3dwNC+8yE4GFyewNxKwsPNTrtmffJPs7NVVa+Fw==
X-Google-Smtp-Source: ANB0VdblYAqOB3LiY7c+GnFZH3kV1rXSFmPen1Y0YGnyj2mHpk8xeFqqaFGOj0VpwSranTownWPUm0RlMf4BNJWu+Z0=
X-Received: by 2002:a1c:ef0f:: with SMTP id n15-v6mr2228604wmh.116.1535257302564;
 Sat, 25 Aug 2018 21:21:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Sat, 25 Aug 2018 21:21:22 -0700 (PDT)
In-Reply-To: <20180826112341.f77a528763e297cbc36058fa@kernel.org>
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
 <20180826112341.f77a528763e297cbc36058fa@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 25 Aug 2018 21:21:22 -0700
X-Gmail-Original-Message-ID: <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
Message-ID: <CALCETrXPaX-+R6Z9LqZp0uOVmq-TUX_ksPbUL7mnfbdqo6z2AA@mail.gmail.com>
Subject: Re: TLB flushes on fixmap changes
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: multipart/mixed; boundary="00000000000028b5cb05744ef28c"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000028b5cb05744ef28c
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 25, 2018 at 7:23 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Fri, 24 Aug 2018 21:23:26 -0700
> Andy Lutomirski <luto@kernel.org> wrote:
>> Couldn't text_poke() use kmap_atomic()?  Or, even better, just change CR3?
>
> No, since kmap_atomic() is only for x86_32 and highmem support kernel.
> In x86-64, it seems that returns just a page address. That is not
> good for text_poke, since it needs to make a writable alias for RO
> code page. Hmm, maybe, can we mimic copy_oldmem_page(), it uses ioremap_cache?
>

I just re-read text_poke().  It's, um, horrible.  Not only is the
implementation overcomplicated and probably buggy, but it's SLOOOOOW.
It's totally the wrong API -- poking one instruction at a time
basically can't be efficient on x86.  The API should either poke lots
of instructions at once or should be text_poke_begin(); ...;
text_poke_end();.

Anyway, the attached patch seems to boot.  Linus, Kees, etc: is this
too scary of an approach?  With the patch applied, text_poke() is a
fantastic exploit target.  On the other hand, even without the patch
applied, text_poke() is every bit as juicy.

--Andy

--00000000000028b5cb05744ef28c
Content-Type: text/x-patch; charset="US-ASCII"; name="text_poke.patch"
Content-Disposition: attachment; filename="text_poke.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jlacjmnk0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jIGIvYXJjaC94ODYva2Vy
bmVsL2FsdGVybmF0aXZlLmMKaW5kZXggMDE0ZjIxNGRhNTgxLi44MTFjODczNWIxMjkgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jCisrKyBiL2FyY2gveDg2L2tlcm5l
bC9hbHRlcm5hdGl2ZS5jCkBAIC02OTAsNDAgKzY5MCwxNSBAQCB2b2lkICpfX2luaXRfb3JfbW9k
dWxlIHRleHRfcG9rZV9lYXJseSh2b2lkICphZGRyLCBjb25zdCB2b2lkICpvcGNvZGUsCiB2b2lk
ICp0ZXh0X3Bva2Uodm9pZCAqYWRkciwgY29uc3Qgdm9pZCAqb3Bjb2RlLCBzaXplX3QgbGVuKQog
ewogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Ci0JY2hhciAqdmFkZHI7Ci0Jc3RydWN0IHBhZ2UgKnBh
Z2VzWzJdOwotCWludCBpOwotCi0JLyoKLQkgKiBXaGlsZSBib290IG1lbW9yeSBhbGxvY2F0b3Ig
aXMgcnVubmlnIHdlIGNhbm5vdCB1c2Ugc3RydWN0Ci0JICogcGFnZXMgYXMgdGhleSBhcmUgbm90
IHlldCBpbml0aWFsaXplZC4KLQkgKi8KLQlCVUdfT04oIWFmdGVyX2Jvb3RtZW0pOworCXVuc2ln
bmVkIGxvbmcgb2xkX2NyMDsKIAotCWlmICghY29yZV9rZXJuZWxfdGV4dCgodW5zaWduZWQgbG9u
ZylhZGRyKSkgewotCQlwYWdlc1swXSA9IHZtYWxsb2NfdG9fcGFnZShhZGRyKTsKLQkJcGFnZXNb
MV0gPSB2bWFsbG9jX3RvX3BhZ2UoYWRkciArIFBBR0VfU0laRSk7Ci0JfSBlbHNlIHsKLQkJcGFn
ZXNbMF0gPSB2aXJ0X3RvX3BhZ2UoYWRkcik7Ci0JCVdBUk5fT04oIVBhZ2VSZXNlcnZlZChwYWdl
c1swXSkpOwotCQlwYWdlc1sxXSA9IHZpcnRfdG9fcGFnZShhZGRyICsgUEFHRV9TSVpFKTsKLQl9
Ci0JQlVHX09OKCFwYWdlc1swXSk7CiAJbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOwotCXNldF9maXht
YXAoRklYX1RFWFRfUE9LRTAsIHBhZ2VfdG9fcGh5cyhwYWdlc1swXSkpOwotCWlmIChwYWdlc1sx
XSkKLQkJc2V0X2ZpeG1hcChGSVhfVEVYVF9QT0tFMSwgcGFnZV90b19waHlzKHBhZ2VzWzFdKSk7
Ci0JdmFkZHIgPSAoY2hhciAqKWZpeF90b192aXJ0KEZJWF9URVhUX1BPS0UwKTsKLQltZW1jcHko
JnZhZGRyWyh1bnNpZ25lZCBsb25nKWFkZHIgJiB+UEFHRV9NQVNLXSwgb3Bjb2RlLCBsZW4pOwot
CWNsZWFyX2ZpeG1hcChGSVhfVEVYVF9QT0tFMCk7Ci0JaWYgKHBhZ2VzWzFdKQotCQljbGVhcl9m
aXhtYXAoRklYX1RFWFRfUE9LRTEpOwotCWxvY2FsX2ZsdXNoX3RsYigpOwotCXN5bmNfY29yZSgp
OwotCS8qIENvdWxkIGFsc28gZG8gYSBDTEZMVVNIIGhlcmUgdG8gc3BlZWQgdXAgQ1BVIHJlY292
ZXJ5OyBidXQKLQkgICB0aGF0IGNhdXNlcyBoYW5ncyBvbiBzb21lIFZJQSBDUFVzLiAqLwotCWZv
ciAoaSA9IDA7IGkgPCBsZW47IGkrKykKLQkJQlVHX09OKCgoY2hhciAqKWFkZHIpW2ldICE9ICgo
Y2hhciAqKW9wY29kZSlbaV0pOworCW9sZF9jcjAgPSByZWFkX2NyMCgpOworCXdyaXRlX2NyMChv
bGRfY3IwICYgflg4Nl9DUjBfV1ApOworCisJbWVtY3B5KGFkZHIsIG9wY29kZSwgbGVuKTsKKwor
CXdyaXRlX2NyMChvbGRfY3IwKTsJLyogYWxzbyBzZXJpYWxpemVzICovCiAJbG9jYWxfaXJxX3Jl
c3RvcmUoZmxhZ3MpOwogCXJldHVybiBhZGRyOwogfQo=
--00000000000028b5cb05744ef28c--
