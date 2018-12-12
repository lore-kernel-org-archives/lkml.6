Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D82EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCE820849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCE820849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeLLJFO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:05:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33670 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeLLJFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:05:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id l11so19692759qtp.0;
        Wed, 12 Dec 2018 01:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pe2hX+my2Rep6sFBugNFkpZL8ollwFC2yHQLZVYCr1w=;
        b=Ua0cQNcMbeXzXEL49nycFKRXn1s5vI84CN7oKfBB12oHh01h9BoThcUw7M2PGAFhXz
         9RHH4NPYc1x4FjLGnE3g4ZF/NseVKnFvfbc7usYfzvocl+3aXtvsyiQSLMahaf3b9Zwz
         KJH1DhZK6QklOX0dO6+165Y21EKI7n4cL6UCS/D0dDA41pDKPUDdc9DfSMvb1RkmCwbX
         T3m1ZJyZKKeIuDqk/TN1sC0rU7jEZ+3jgBptOrhGUoVdiwiMvEsCk1cDgehNp9PP/Yyi
         dM8/fQ1DFeh7agN3p+uyfwsvWRuje1p8Pp30+xgh1MP1r4FiT8xntsS87eu0STNHZKw4
         6pIA==
X-Gm-Message-State: AA+aEWZhbMDrsf+b74KQSzrsDpPPbGCRX+T2v+jMFShaMmO2dWV/iTu5
        hJyjdUeV69I2qJ28zAA3xFaPwznoPp6Esp9q8dpSvyUW
X-Google-Smtp-Source: AFSGD/W1p/YrUtvmguy+ptOEDP8NjMzHBwAgMPuT/yiKmybtAkxp8uHu59a4MSbbCg+TQ2MekPSkyUkexr15FPMonBU=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr18850332qte.212.1544605512042;
 Wed, 12 Dec 2018 01:05:12 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
 <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org> <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
 <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org> <CALCETrXf0rmadycxmpGxd41qP9X+PAjyGHTwbGhKyp6oMKMRrA@mail.gmail.com>
 <Pine.BSM.4.64L.1812120231410.21176@herc.mirbsd.org>
In-Reply-To: <Pine.BSM.4.64L.1812120231410.21176@herc.mirbsd.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Dec 2018 10:04:53 +0100
Message-ID: <CAK8P3a3yurujkdic98H02j0YfctSBf9NeXQreLZVhTzsttoc9g@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     tg@mirbsd.de
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>, vapier@gentoo.org,
        "H.J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 3:38 AM Thorsten Glaser <tg@mirbsd.de> wrote:
>
> Andy Lutomirski dixit:
>
> >That’s the thing, though: the whole generic kernel compat
> >infrastructure assumes there are at most two ABIs: native and, if
> >enabled and relevant, compat. x32 breaks this entirely.
>
> MIPS had o32, n32, n64 since like forever.

o32 and n32 are practically the same, the only difference on the
syscall ABI that I can see are the actual syscall numbers, and
the 'struct sigcontext' definition.

> ARM has old ABI, EABI and now 64-bit.

arm64 intentionally did not attempt to support OABI user space
because of this, and as I said the ilp32 ABI follows what MIPS
n32 does using the same data structures as aarch32 (corresponding
to mips o32).

> >How hard would it be to have __attribute__((ilp64)), with an optional
> >warning if any embedded structs are not ilp64?  This plus a wrapper to
>
> You mean LP64. Impossible, because LP64 vs. ILP32 is not the only
> difference between amd64 and x32.

I think the above is what Intel's compiler does, and similar to what they
do for mixing big-endian and little-endian code (!). Generally possible yes,
but a lot of work, as well as error-prone and not particular appealing for
the GNU toolchain IMHO.

        Arnd
