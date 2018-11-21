Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B023C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA712151B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e4p69Vr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA712151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbeKVEDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:03:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40610 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbeKVEDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:03:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so5548454lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1OZjFc9B31OlVR1hcTY//0NkFGhyraPowr2P4tOIlo=;
        b=e4p69Vr22GJrFKEDHjZ6qecWaD6iU20sXeGQ3zHjW5eZvZJ7ee4Dfmrnfb9o6HMT3j
         OJ0pqEK9/yQnluwx2gKC25lp1v/dMt3BUpWHFDaCDUjvPojq03kwaYqqPHoVjWPk4Qks
         PQwOcsQDhB03935Ne2H6TtnpDVj/Bvi1hqSO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1OZjFc9B31OlVR1hcTY//0NkFGhyraPowr2P4tOIlo=;
        b=Wmko4n3iizmfvk74JeCYtIaLcAtiqiz67wrqj+Zsi9SgNHCO70hE0QsFdzSpGLII+J
         4ak3bbW72oPo+dj7o3jKCz/vFyBTtLZIUgkccYTKHKXqUzHHQX9O4XMe8pONMwywjut0
         q2516yXkSutt9+s4LGtv3DniOIy+QFdj7Csf2nqJWqIEMG7VgmjSepK9ZFav7NYayStv
         GbIRkGGBQMLgHjpiJTB0qKm092x2HOGmBD9nutq94nsR7koMcFyQV6um5MtBPTnBd+Dz
         OMXj8sBjMIeFmS99v4xOpaFAz6X+a1tLwSgf0ucsN5FAVHPsXuyksoNt3hXL1/qyFuk3
         O/oQ==
X-Gm-Message-State: AA+aEWYIvu+94D8bM9t2slEfBqjWRH0GT+oVupxAiAjmf4fDvMxhBY4c
        vK4PnWdV/C1bIrzkVTfS1eE3utC7bxw=
X-Google-Smtp-Source: AFSGD/V57ZN0b7UeBs8awRdjlhxBcZNA08Hd6eO76ykGVQMdCoQmCSRPZcenL7bo+4zodHX4gd3Q9w==
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr4474305ljz.54.1542821270421;
        Wed, 21 Nov 2018 09:27:50 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id t81sm6808783lfe.84.2018.11.21.09.27.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 09:27:49 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id z13so4565304lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 09:27:49 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr4617623lfc.124.1542821268528;
 Wed, 21 Nov 2018 09:27:48 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
In-Reply-To: <1c22125bb5d22c2dcd686d0d3b390f115894f746.camel@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Nov 2018 09:27:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
Message-ID: <CAHk-=wgnjB+=o0771=J_YkQzabU5aadh6pN3x9Vk4HPs3MHL3g@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     pabeni@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, dvlasenk@redhat.com,
        brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 5:45 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> In my experiments 64 bytes was the break even point for all the CPUs I
> had handy, but I guess that may change with other models.

Note that experiments with memcpy speed are almost invariably broken.
microbenchmarks don't show the impact of I$, but they also don't show
the impact of _behavior_.

For example, there might be things like "repeat strings do cacheline
optimizations" that end up meaning that cachelines stay in L2, for
example, and are never brought into L1. That can be a really good
thing, but it can also mean that now the result isn't as close to the
CPU, and the subsequent use of the cacheline can be costlier.

I say "go for upping the limit to 128 bytes".

That said, if the aio user copy is _so_ critical that it's this
noticeable, there may be other issues. Sometimes _real_ cost of small
user copies is often the STAC/CLAC, more so than the "rep movs".

It would be interesting to know exactly which copy it is that matters
so much...  *inlining* the erms case might show that nicely in
profiles.

               Linus
