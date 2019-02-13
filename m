Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3C8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C9A20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GJgFZO1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404811AbfBMSI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:08:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39861 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfBMSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:08:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id g80so2841837ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 10:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+LQWnqULW+l6EMSnspy1Pa7LnelXaU8iBmL+OFW3Oc=;
        b=GJgFZO1QUUbKQ41XirqInswpyPhw8V0Q7enJjpCSXV042beuF5aL8nKpSquwC8PANn
         cmA/rsEK/2YiiDDCXV1wihj2JUXRaxIguoLa8a0UYmK46816Y3utsUVpzrMQAd0bwaPh
         pQ0q7Paz+Cnt+TvDESIeUsKcmn3af1g1janxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+LQWnqULW+l6EMSnspy1Pa7LnelXaU8iBmL+OFW3Oc=;
        b=L1reg8VZ51rw1h1VljWVuySqDwZfo5FxBuMTQuts33aBQQCr1HDwd0coGInw382oJ9
         OEDYKlGPWUfVfjm3cuRlL9PQAgr7tW6dVITGXKMMxW3etHQNLWolIMNQNYvbKwIO8aKu
         djvg6lp1Omqeg99/yor0qdRo99eN/gcfdoto5eBeCmuuuvG0Mv7Dusga3gQFPujIxQ/i
         IF/akpN3VsgpY5ZlFCyk4ppCzrWM5ArWhfbe+oFEU246JrZkgRS37bD3pRMCMZI6wRNT
         AL0awnetcIqPWgrJHtIVHxTmdpydoTewa0w6m/P9wKBH2A5c5T2VEj65mZdyZMdr3giy
         RdCA==
X-Gm-Message-State: AHQUAub/xA+JbkqAZGp5whSmZLxMPwlVKaXW4OsQRMCif1nWbQjqWpYQ
        x0JGndlUnqzIx3I2H+RcFU3u0trbsAs=
X-Google-Smtp-Source: AHgI3IZEW2r8zyXbY1rcr6QitFN2WiUBorjbsPEWqkkxkbO1f+GOFpRCGTm8W/Ujdi51+g/2EpzgKw==
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr981926lja.148.1550081333611;
        Wed, 13 Feb 2019 10:08:53 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 76sm2065589lfb.10.2019.02.13.10.08.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 10:08:52 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id m11so2506252lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 10:08:51 -0800 (PST)
X-Received: by 2002:a19:911c:: with SMTP id t28mr1137087lfd.78.1550081331399;
 Wed, 13 Feb 2019 10:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20190211141827.214852402@linuxfoundation.org> <20190211141841.367111122@linuxfoundation.org>
 <1eb319822aa9f75f423a7790e78315e7672036b9.camel@nokia.com> <20190213131333.GT32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190213131333.GT32494@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Feb 2019 10:08:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgpU+5zAgakcDksXfEdJCtBFRdHm7Hqb_iDc+VWYKiqnA@mail.gmail.com>
Message-ID: <CAHk-=wgpU+5zAgakcDksXfEdJCtBFRdHm7Hqb_iDc+VWYKiqnA@mail.gmail.com>
Subject: Re: [PATCH 4.14 198/205] perf/core: Dont WARN() for impossible
 ring-buffer sizes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "acme@redhat.com" <acme@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 5:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> There is this queued:
>
>   http://lkml.kernel.org/r/tip-528871b456026e6127d95b1b2bd8e3a003dc1614@git.kernel.org

I think it would likely have been better to just remove the test
entirely, and instead just use __GFP_NOWARN.

This is an allocation essentially done for the user (as part of
mmap(), and we handle the failure case fine. So it doesn't matter
whether the warning is due to being out of memory or being a bad size,
we shouldn't cause a kernel warning.

That said, I think we should *indepdendently* have some sane limit for
"nr_pages", simply because we do that

        ...
        for (i = 0; i < nr_pages; i++) {
                rb->data_pages[i] = perf_mmap_alloc_page(cpu);

thing, which is really really expensive when "nr_pages" is in the
thousands (or millions). The fact that we end up almost _accidentally_
limiting nr_pages simply because the kzmalloc() size is limited is I
think a mistake.

So I'd rather see __GFP_NORWARN _and_ some kind of "don't allow crazy
perf ring buffers" check that is separate and independent from any
kmalloc issue..

For example, right now the maximum size you can allocate is (insanely)
tied to the page size. With a bigger page size, not only do you get a
bigger ring buffer anyway, but you also get more 'nr_pages', so it's
basically quadratic behavior. Does that make sense? It doesn't sound
that way to me.

                  Linus
