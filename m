Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21E2C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720B920684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arm-com.20150623.gappssmtp.com header.i=@arm-com.20150623.gappssmtp.com header.b="k2VyUpe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720B920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeJCOjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:39:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32986 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeJCOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:39:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so1293645pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CbicJzD58fdOtKx7t5bCoEkBGyi3qCYx7bl52AeIWYM=;
        b=k2VyUpe8WNtfvYhALRKu84OULuG5BaURt+O78pv+oqhaRLU+go151Xi+K/LBg8OSmJ
         ta7hdLtVrV948ZzPszJmtla4rNBgSPKsd5h9hlH+QxFVZjY7mtPc75AA0TzeaSYktHUD
         SwCkrgEGjg8TviyYZoDb2XqkjkLcsg2h4VXSxYAo2B+TfvSSlmPqTQu/ZqTmSxhlm3A9
         tg1UGl/Qgb0i8MB/Q9rjk6OngZLqUgep1SIF2+hlCf8lRJ7PIFQ0fQ4oBMoQiNHP+xhK
         hOV0xiOMJ/vHO/sC0Tuls83IPAdps+plrooeeNy9Nt3jP87f8uCBdlOF95azi07Rq1MY
         Zpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CbicJzD58fdOtKx7t5bCoEkBGyi3qCYx7bl52AeIWYM=;
        b=N/xJnDpfN7SpQ+Zdz5v67WXIYjfmVozFQErvLc+TIqkspyJwI47JwyEor4FTzy85RK
         q4ZGoYFXLuKgjCqEtzSwyvglZM25Ea1vdlsIeQJM7tokgmZ3NxGpCw+1g5x+FhiZs9Fq
         B54vShqDb7tZ3abt8ONY48Ycfn3EexUXHYn7pTj0utB+FnaAlANhqQymQpV8637qTJfm
         wu8MVOv0Yu4fIF02lBmFkS/46eGjzphvttxHYBmfLE4c6veYs3kCNuUvD62rfc0cJO57
         LrORMpC9JNysVGycjztOaFJbGJAoVT8jlIw5ZpJGEhzBJBF2a9wNZsHxZ/avc6mEhg7h
         Tq6g==
X-Gm-Message-State: ABuFfoiL93E2nQAHCCQu9WxY9kobm8VrXSEftmErnAFrtp7dzEys9j8O
        kFVCS3vI+17ZB0oIvg3Qu9jZxh7rBhQxfkwPswk=
X-Google-Smtp-Source: ACcGV61/Cho4e9dyzZ1saC0oLaabLEeUe8tN1RbvULUN8SBljGfJ9e03oDviIrloxQglOIRFZ5WaYJh87Jtg1t3Zfms=
X-Received: by 2002:a62:468e:: with SMTP id o14-v6mr297990pfi.180.1538553121544;
 Wed, 03 Oct 2018 00:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180921120226.6xjgr4oiho22ex75@linutronix.de> <20180921122058.GB24124@hirez.programming.kicks-ass.net>
In-Reply-To: <20180921122058.GB24124@hirez.programming.kicks-ass.net>
From:   Catalin Marinas <catalin.marinas@arm.com>
Date:   Wed, 3 Oct 2018 08:51:50 +0100
Message-ID: <CAHkRjk4Vvv5rc+habecu2xPiFGZ37onRzy1kCnFcBH2115U8jQ@mail.gmail.com>
Subject: Re: [Problem] Cache line starvation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bigeasy@linutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        daniel.wagner@siemens.com, Will Deacon <will.deacon@arm.com>,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, boqun.feng@gmail.com,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 at 13:22, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Sep 21, 2018 at 02:02:26PM +0200, Sebastian Andrzej Siewior wrote:
> > We reproducibly observe cache line starvation on a Core2Duo E6850 (2
> > cores), a i5-6400 SKL (4 cores) and on a NXP LS2044A ARM Cortex-A72 (4
> > cores).
> >
> > The problem can be triggered with a v4.9-RT kernel by starting
>
> > Daniel reported that disabling ticket locks on 4.4 makes the problem go
> > away, but he hasn't run a long time test yet and as we saw with 4.14 it can
> > take quite a while.
>
> On 4.4 and 4.9 ARM64 still uses ticket locks. So I'm very interested to
> know if the ticket locks on x86 really fix or just make it harder.
>
> I've been looking at qspinlock in the light of this and there is indeed
> room for improvement. The ticket lock certainly is much simpler.

FWIW, in the qspinlock TLA+ model [1], if I replace the
atomic_fetch_or() model with a try_cmpxchg loop, it violates the
liveness properties with only 2 CPUs as one keeps locking/unlocking,
hence changing the lock value, while the other repeatedly fails the
cmpxchg. Your latest qspinlock patches seem to address this (couldn't
get it to fail but the model is only sequentially consistent). Not
sure that's what Sebastian is seeing but without your proposed
qspinlock changes, ticket spinlocks may be a better bet for RT.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/kernel-tla.git/tree/qspinlock.tla

-- 
Catalin
