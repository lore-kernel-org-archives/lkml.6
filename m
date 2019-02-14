Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFF3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278C62080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PGshS3Ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438008AbfBNR7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:59:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33303 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfBNR7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:59:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id f24-v6so6068353ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOAxNfp/u2AjpSAe9gJ1DkLd8kcSaDRiWtEtJaBSEcs=;
        b=PGshS3MaeGeltwuyVtFmT0V6YZQZmxLLNBrf107mvwKlqUhZwGpD70GnjqQJh+4V2q
         3J6Xvbgr/CiWsk6q6rJVeglsaiLbeVTkiovB8o6FTpvJF+udviHo9Zs+xhaucNb0e3LD
         IXDiqt1MsmZkkBaKR5AXhS5/XMcdP66J22GNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOAxNfp/u2AjpSAe9gJ1DkLd8kcSaDRiWtEtJaBSEcs=;
        b=KnwljzmcSiLets1MlP6rPdUuVBUSC+bqh1FZU4jyd6FDlLCUdbU9xf8m4bPWhacXOo
         g7U0iuKQj/sMNGfKtdwjXALqZlLYkXpVPWEdz2/FVUIPozH8AB76StireDbjq+anOpcn
         9fDiGu5wXBwr5NwmkmigFTrEcN9Dd5EvE1807AfNdIYlFaCkmGwYVn5vKS1Z31Ps8gnV
         yhdo91k97FlWCMWzG01x2/N2/u3CiEkXM3roVjoSi+6eqqjyH8uBIwe3fL0QUewbj2Hg
         PV3Kquc0U2N3aVfp/fsyvH3gRM5RHiWj6daz3dPsoqZn2ak1G7k7PumBm5Zf4Z4DEVFt
         nwbQ==
X-Gm-Message-State: AHQUAuZfQYK6i+qmuG7X8LIb+vuvIEOq4zlkJKFyHDlIKs6vFqhi/tLo
        c1jmZt43r1DGvCOGCNP+Zz5VJl5JmCo=
X-Google-Smtp-Source: AHgI3Ib8W74kgzX4H7STerPcksdnAXyqkhd2FkhWmv+KgRnlMIuS0xWVIaVhWeHt+FrZF9lkASHz/A==
X-Received: by 2002:a2e:9a8b:: with SMTP id p11mr3182717lji.66.1550167141429;
        Thu, 14 Feb 2019 09:59:01 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id b17sm594059lff.62.2019.02.14.09.59.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 09:59:01 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id t14so5222538lfk.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 09:59:01 -0800 (PST)
X-Received: by 2002:a19:2794:: with SMTP id n142mr3048400lfn.77.1550166697920;
 Thu, 14 Feb 2019 09:51:37 -0800 (PST)
MIME-Version: 1.0
References: <1550089932-6888-1-git-send-email-longman@redhat.com>
 <1550089932-6888-3-git-send-email-longman@redhat.com> <20190214103333.GH32494@hirez.programming.kicks-ass.net>
 <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com>
In-Reply-To: <9e01d4ef-56df-7af8-a0f5-b49644e298bf@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Feb 2019 09:51:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
Message-ID: <CAHk-=whKmuranma_HUOKBbDJHGmdWZr9MYW-+cmGzsOiJ2N1Sg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] locking/rwsem: Optimize down_read_trylock()
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 6:53 AM Waiman Long <longman@redhat.com> wrote:
>
> The ARM64 result is what I would have expected given that the change was
> to optimize for the uncontended case. The x86-64 result is kind of an
> anomaly to me, but I haven't bothered to dig into that.

I would say that the ARM result is what I'd expect from something that
scales badly to begin with.

The x86-64 result is the expected one: yes, the cmpxchg is done one
extra time, but it results in fewer cache transitions (the cacheline
never goes into "shared" state), and cache transitions are what
matter.

The cost of re-doing the instruction should be low. The cacheline
ping-pong and the cache coherency messages is what hurts.

So I actually think both are very easily explained.

The x86-64 number improves, because there is less cache coherency traffic.

The arm64 numbers scaled horribly even before, and that's because
there is too much ping-pong, and it's probably because there is no
"stickiness" to the cacheline to the core, and thus adding the extra
loop can make the ping-pong issue even worse because now there is more
of it.

The cachelines not sticking at all to a core probably is good for
fairness issues (in particular, sticking *too* much can cause horrible
issues), but it's absolutely horrible if it means that you lose the
cacheline even before you get to complete the second cmpxchg.

                  Linus
