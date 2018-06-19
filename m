Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7275C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1B22083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TREapHxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1B22083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755844AbeFSFGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:06:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53854 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755731AbeFSFGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:06:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id x6-v6so17547752wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BeFRdLJfkOgIyMXuO8SSPtp2MukV0/4fIXr6/4Qcgf4=;
        b=TREapHxqxjRzvz+T/bWI/MQTCi9gRaAM2VvJQ+DV+YP3EVPdZVjXqg4Z72SawGT83t
         6slCVvpca5YSXDYKqF38NkmD0Ywjq/CPCMcvHfWPsrYZ0v9PwEqFJSv7z96jSfhyaYUx
         sVZ9lGrHB5p6yAm000RzJPQGq3upp+qjlL6BBVQRnpna95qC9FMkXhzw6Jgc9Uvp5NJE
         5oMDRexEJ3sHRBWRq0wx9jtr9FzOq3H+zFuonFttRZWiKSHc34AHkoZsTcSZtLuiRvht
         dbleWN3vpng7B3ZgGbQ+MD980tcSqs3+EFdpHJ+oepOx4liTqif8ni992xEKbIYUyRC7
         oluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BeFRdLJfkOgIyMXuO8SSPtp2MukV0/4fIXr6/4Qcgf4=;
        b=VFiITAsHY6NNx2AtX+FOfaw98P2EXNIU5txIZdgpRj19ImdA1mYb3xcouRcRjpnI8N
         Eq7y9trcic1/3LBKYL+fWIT3RLv9S5hqmyCvE1drzFzchPTyCN4adMN7AqqYIy8WXhhZ
         9EBqtJztEi+wO5YAymcbI0YGAE/PhBWngHMt+8H15g68RHAUaKJwnU7QG87MzV+YHwv8
         kvTI8QJadFJbtwJOFVCBKam2RkCM9VyD/E7msrVd7tODYhr0M2GOANeo3BU6LHKKRfCf
         iy6mgaIqgo1GYzRmTcVu/d4OL8Yz6tw/iRREgk1+OdPuBFy1aQZjefo8xN7lpttnXo9R
         1p/g==
X-Gm-Message-State: APt69E0IfTsSSAFzU6c6DREMGNlXEPDUEyzJZUnWS0DTxy0oWGsGaaeb
        VZbmfwmPOOoBs7W+Okmxwt+dstxQexWAsaU1CjVr+w==
X-Google-Smtp-Source: ADUXVKKU4ABW38ZZTe/2lo9UI8oc2srXPrbJaiE3DwKGEQrfQQLVLuWA08GwE9OzqxVVmv6LgSvwpAo0BKzljJSewfs=
X-Received: by 2002:a1c:20c7:: with SMTP id g190-v6mr11115107wmg.2.1529384809986;
 Mon, 18 Jun 2018 22:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rtoPwxUSnktxzKso14iuVCWT7BE_-_8PAC=pGw1iJnQg@mail.gmail.com>
 <CALvZod6Dxx79ztxzHsDVe6pj7Fa7ydJAjMf_EHV9H15+AsVwdA@mail.gmail.com> <CAHmME9qvRDQOJYdSPaAf-hg5raacu4TBgStLy7NzFL+j+dXheQ@mail.gmail.com>
In-Reply-To: <CAHmME9qvRDQOJYdSPaAf-hg5raacu4TBgStLy7NzFL+j+dXheQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 18 Jun 2018 22:06:38 -0700
Message-ID: <CALvZod5ZrxjZjJjAV_iH6hgq9pY2QEuFjNi+qvPSzob5Vighjg@mail.gmail.com>
Subject: Re: Possible regression in "slab, slub: skip unnecessary kasan_cache_shutdown()"
To:     Jason@zx2c4.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 9:08 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Tue, Jun 19, 2018 at 5:59 AM Shakeel Butt <shakeelb@google.com> wrote:
> > Hi Jason, yes please do send me the test suite with the kernel config.
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

I will try to repro with your test suite sometime later this week.
However from high level code inspection, I see that the code is
creating a 'entry_cache' kmem_cache which is destroyed by
ratelimiter_uninit on last reference drop. Currently refcnt in your
code can underflow, through it does not seem like the selftest will
cause the underflow but still you should fix it.

From high level your code seems fine. Does the issue occur on first
try of selftest? Basically I wanted to ask if kmem_cache_destroy of
your entry_cache was ever executed and have you tried to run this
selftest multiple time while the system was up.

As Dmitry already asked, are you using SLAB or SLUB?

> I realize it's disappointing that the test case here is in WireGuard,
> which isn't (yet!) upstream. That's why in my original message I
> wrote:
>
> > Rather, it looks like this
> > commit introduces a performance optimization, rather than a
> > correctness fix, so it seems that whatever test case is failing is
> > likely an incorrect failure. Does that seem like an accurate
> > possibility to you?
>
> I was hoping to only point you toward my own code after establishing
> the possibility that the bug is not my own. If you still think there's
> a chance this is due to my own correctness issue, and your commit has
> simply unearthed it, let me know and I'll happily keep debugging on my
> own before pinging you further.
>

Sorry, I can not really give a definitive answer.

Shakeel
