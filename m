Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B0BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADC820883
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9/jl8D1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADC820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937308AbeFSEzx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:55:53 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39394 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937085AbeFSEzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:55:51 -0400
Received: by mail-pl0-f67.google.com with SMTP id f1-v6so10249473plt.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 21:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R7irBImTqCkOBrsyGMtxzy2Tzmvcav7HcMiUyGpgiVI=;
        b=L9/jl8D1DSkWGpeLiqDsYk0xxq98Ig9S0PZgYYnsmA/RxkzM68DC8SvcPIgNeyWVHm
         bE7p93DNWk/t2FrcwrlPmCWpxhuLyIK+0D6X2j9WWMJhp0L1vMhM409Sn7K7UuNKsKbf
         ZA5c8CbNa/tb2oSJK36AKP3pLPlQLl87LaNLq4C80113V0OoMEb41JGPMtfbBYr04Bjd
         XarLS+XYhjwgSm1q6IchR1RdCvKgcr5LvN5Ry2fMfI25M+HoCLKb7iRKX/nGNoNWK7Aj
         f15wQaMFRbullseZyeA60SWjU9VLaKTidYeQZ88i3MrnoeAXAN9LX4fFKAy1Noa+HhwW
         VebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R7irBImTqCkOBrsyGMtxzy2Tzmvcav7HcMiUyGpgiVI=;
        b=PBKt+4PM4xYRwawWuFuKGjJD8PfZWDgXmpXzJMHm+LDv3rvLcfGk38y8VmlqP8ec/l
         zR3g+EvXNmcantGctWC2H1eQO1spk6PIAhyjF68x9ssBl6NRFW0gy4ZUwJO4fUcI9mHe
         ueUY8RAW+O2Wb5gk1dqh2QfI2iyS58wx1yPwox14vybduzHfVD/uEufTn4IDol+wvyAW
         IuDmH5E46FcugEIlOxtBccc6tltiX8hE2WQbvrfu4XFWw0QssN1e+mWyOwOn5yJ+NWNb
         flMI7NS4coFLP8D0jQUd1rNwM30Vh7Ps+dCR5u8By80JYkTJwQYq7VLxY4MQKorlK2Tf
         cxUg==
X-Gm-Message-State: APt69E2EuoRLU9vb6hgOJnWUKA02pNuTRHnO+Zn4T0Pw9JewAna99fhi
        xAlzCpvsx6uHRrF/gk9sXfiYNmSCjvUqAmblsmMHtA==
X-Google-Smtp-Source: ADUXVKLRudR4rKFN6A5fVDizPDukihkbdaM+zlCuU071eKgB0r8M2iloMyeuwFWvKx+ARnCEeLQlVyptY0uVClarJmU=
X-Received: by 2002:a17:902:bb81:: with SMTP id m1-v6mr17092545pls.117.1529384150844;
 Mon, 18 Jun 2018 21:55:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:de2:0:0:0:0 with HTTP; Mon, 18 Jun 2018 21:55:30
 -0700 (PDT)
In-Reply-To: <CAHmME9qvRDQOJYdSPaAf-hg5raacu4TBgStLy7NzFL+j+dXheQ@mail.gmail.com>
References: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
 <CALvZod6Dxx79ztxzHsDVe6pj7Fa7ydJAjMf_EHV9H15+AsVwdA@mail.gmail.com> <CAHmME9qvRDQOJYdSPaAf-hg5raacu4TBgStLy7NzFL+j+dXheQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 19 Jun 2018 06:55:30 +0200
Message-ID: <CACT4Y+YLySJMfG4kCJ2FiPpPtN6sgU6k2FoZUYMFrJGLj+vDjw@mail.gmail.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 6:08 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Tue, Jun 19, 2018 at 5:59 AM Shakeel Butt <shakeelb@google.com> wrote:
>> Hi Jason, yes please do send me the test suite with the kernel config.
>
> $ git clone https://git.zx2c4.com/WireGuard
> $ cd WireGuard/src
> $ [[ $(gcc -v 2>&1) =~ gcc\ version\ 8\.1\.0 ]] || echo crash needs 8.1
> $ export DEBUG_KERNEL=yes
> $ export KERNEL_VERSION=4.18-rc1
> $ make test-qemu -j$(nproc)
>
> This will build a kernel and a minimal userland and load it in qemu,
> which must be installed.
>
> This code is what causes the crash:
> The self test that's executed:
> https://git.zx2c4.com/WireGuard/tree/src/selftest/ratelimiter.h
> Which exercises this code:
> https://git.zx2c4.com/WireGuard/tree/src/ratelimiter.c
>
> The problem occurs after gc_entries(NULL) frees things (line 124 in
> ratelimiter.h above), and then line 133 reallocates those objects.
> Sometime after that happens, elsewhere in the kernel invokes this
> kasan issue in the kasan cache cleanup.
>
> I realize it's disappointing that the test case here is in WireGuard,
> which isn't (yet!) upstream. That's why in my original message I
> wrote:
>
>> Rather, it looks like this
>> commit introduces a performance optimization, rather than a
>> correctness fix, so it seems that whatever test case is failing is
>> likely an incorrect failure. Does that seem like an accurate
>> possibility to you?
>
> I was hoping to only point you toward my own code after establishing
> the possibility that the bug is not my own. If you still think there's
> a chance this is due to my own correctness issue, and your commit has
> simply unearthed it, let me know and I'll happily keep debugging on my
> own before pinging you further.


Hi Jason,

Your code frees all entries before freeing the cache, right? If you
add total_entries check before freeing the cache, it does not fire,
right?
Are you using SLAB or SLUB? We stress kernel pretty heavily, but with
SLAB, and I suspect Shakeel may also be using SLAB. So if you are
using SLUB, there is significant chance that it's a bug in the SLUB
part of the change.
