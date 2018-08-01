Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C93C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E4A208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="xMKx5EPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E4A208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407003AbeHATMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:12:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34953 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405547AbeHATMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:12:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so20878355wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LVMKyxjSXamji+D08ji0mpbxh1VhNp+Q1IUmAz9fcjY=;
        b=xMKx5EPJrcEhG7w8GLZc6l7p062M/vpObdn0sR2xRawTfvNrxbiAGZaP6V6rM2hLdp
         6xHrqJnSyi54Z1JKQM5DeCdBRFbdBkPymjRF3c7N8f6OcEjYnDqTZ7O1SHDmMldPL1C9
         7EGUZm131zEmIvrUZDtuqEjRscBwxOIRxEwdy3cIWnHaf+9OTGOfB9jxkCjnXOclfa2i
         3yFGuaUTtnBR1yFN4HIbGgIGXGrnYQyZxkkL4+TlWBLXg8eeSMjZSaatKKYlcoJkOilj
         SlL1BcP/NtdzMInxiKjOKarIsFYutJoO8VpzE+/QgnfYNmUpu1M7IPkiOpAc+7jtb0gl
         iD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LVMKyxjSXamji+D08ji0mpbxh1VhNp+Q1IUmAz9fcjY=;
        b=ckuUe1niG69USbx+QG+6tbOx12UX6TYYLGLkK1AdLlkimcLragf/Td+3L62DaKLDFJ
         EcjjUP8pbvcZij+agXBhw5Whx3gx+3U89SffLcAdx6GkrwC0EAfItpy9Kz7vZVqo/Gvi
         UMJnZXLRaYB56US/8nGLoMFzxjh7YQaYXWfDLAG6BC+e822NesufB6HShHmkki3WZgnn
         /+AtTrJSQNlUL45/ibFCz+f+v2ATvNpsUd2Txl1kogRxUrpBzKdsDVFGKhuaR4DdSXdS
         Ydh1Ues+tUDf7apC0fPakEGpNowsqjbDhKnez9ZKFocRAu78PSMB7Huow0EDEoOW0/lv
         x+Ug==
X-Gm-Message-State: AOUpUlHcpe1FvTPvjnPTpw22GeAny3/HDmwe1Hf9wbBgLmGvUd/w6CVZ
        cxCvRv0jaY4KP0SuEJ2IVwKpczVpToY243Z6K1asjk5yaUowFw==
X-Google-Smtp-Source: AAOMgpeI2fZdNWBsytqfi69IgXb0Vo026y6QdDJ1Ix2xbMsDzp+jdsWxEEXPchxsJpNIpkzwdk7iom+GPRnCDjlYPZs=
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr24454872wrd.67.1533142961932;
 Wed, 01 Aug 2018 10:02:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 10:02:21 -0700 (PDT)
In-Reply-To: <20180801072246.GA15677@sol.localdomain>
References: <20180801072246.GA15677@sol.localdomain>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 1 Aug 2018 10:02:21 -0700
Message-ID: <CALCETrXD_VyoyW5C1U34o-ySJ4nFcO6PQ+ZNBVYxCpJ-f65CHw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] zinc: Introduce minimal cryptography library
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Tanja Lange <tanja@hyperelliptic.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I reordered the snippets below for readability.]

> On Aug 1, 2018, at 12:22 AM, Eric Biggers <ebiggers3@gmail.com> wrote:
> In general this is great work, and I'm very excited for WireGuard to be
> upstreamed!  But for the new crypto code, I think a few things are on
> the wrong track, for example treating it is a special library.  Even the
> name is contradicting itself: Zinc is "not crypto/", yet as you stated
> it's intended that the "Zinc" algorithms will be exposed through the
> crypto API -- just like how most of the existing crypto code in lib/ is
> also exposed through the crypto API.  So, I think that what you're doing
> isn't actually *that* different from what already exists in some cases;
> and pretending that it is very different is just going to cause
> problems.  Rather, the actual truly new thing seems to be that the
> dispatch to architecture specific implementations is done at the lib/
> level instead of handled by the crypto API priority numbers.

...

>
>
> I think the above changes would also naturally lead to a much saner
> patch series where each algorithm is added by its own patch, rather than
> one monster patch that adds many algorithms and 24000 lines of code.
>

Yes, please.


>
> As for doing the architecture-specific dispatch in lib/ rather than
> through the crypto API, there definitely are some arguments in favor of
> it.  The main problem, though, is that your code is a mess due to all
> the #ifdefs, and it will only get worse as people add more
> architectures.  You may think you already added all the architectures
> that matter, but tomorrow people will come and want to add PowerPC,
> RISC-V, etc.  I really think you should consider splitting up
> implementations by architecture; this would *not*, however, preclude the
> implementations from still being accessed through a single top-level
> "glue" function.  For example chacha20() could look like:
>
> void chacha20(struct chacha20_ctx *state, u8 *dst, const u8 *src, u32 len,
>          bool have_simd)
> {
>    if (chacha20_arch(dst, src, len, state->key, state->counter, have_simd))
>        goto out;
>
>    chacha20_generic(dst, src, len, state->key, state->counter);
>
> out:
>    state->counter[0] += (len + 63) / 64;
> }

I like this a *lot*.  (But why are you passing have_simd?  Shouldn't
that check live in chacha20_arch?  If there's some init code needed,
then chacha20_arch() should just return false before the init code
runs.  Once the arch does whatever feature detection it needs, it can
make chacha20_arch() start returning true.)

As I see it, there there are two truly new thing in the zinc patchset:
the direct (in the direct call sense) arch dispatch, and the fact that
the functions can be called directly, without allocating contexts,
using function pointers, etc.

In fact, I had a previous patch set that added such an interface for SHA256.

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=crypto/sha256_bpf&id=8c59a4dd8b7ba4f2e5a6461132bbd16c83ff7c1f

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=crypto/sha256_bpf&id=7e5fbc02972b03727b71bc71f84175c36cbf01f5

>
> Your patch description is also missing any mention of crypto accelerator
> hardware.  Quite a bit of the complexity in the crypto API, such as
> scatterlist support and asynchronous execution, exists because it
> supports crypto accelerators.  AFAICS your new APIs cannot support
> crypto accelerators, as your APIs are synchronous and operate on virtual
> addresses.  I assume your justification is that "djb algorithms" like
> ChaCha and Poly1305 don't need crypto accelerators as they are fast in
> software.  But you never explicitly stated this and discussed the
> tradeoffs.  Since this is basically the foundation for the design you've
> chosen, it really needs to be addressed.

I see this as an advantage, not a disadvantage.  A very large majority
of in-kernel crypto users (by number of call sites under a *very*
brief survey, not by number of CPU cycles) just want to do some
synchronous crypto on a buffer that is addressed by a regular pointer.
Most of these users would be slowed down if they used any form of
async crypto, since the CPU can complete the whole operation faster
than it could plausibly initiate and complete anything asynchronous.
And, right now, they suffer the full overhead of allocating a context
(often with alloca!), looking up (or caching) some crypto API data
structures, dispatching the operation, and cleaning up.

So I think the right way to do it is to have directly callable
functions like zinc uses and to have the fancy crypto API layer on top
of them.  So if you actually want async accelerated crypto with
scatterlists or whatever, you can call into the fancy API, and the
fancy API can dispatch to hardware or it can dispatch to the normal
static API.

In fact, this is exactly what my patch above did.  But Jason's work is
more complete than mine, and mine wasn't really done because it had
some configury issues.

All that being said, for algorithms where the crypto API already has a
reasonable implementation, I think the patch series should first
restructure the code (so the actual software implementation is moved
away from the crypto API wrappers) and then, if needed, replace the
implementation with something better.  The latter should be its own
patch with its own justification.
