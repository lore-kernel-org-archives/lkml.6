Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD07C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DB22183F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551287885;
	bh=ZvI4qUi5q2IjGfYqR8OYQwM4rsR3Q1MG+nJmz0tNwKk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wHxKLHqcH4H/KjdPJxcT3GyHH7+wv2FGFHPdCBFHETDdHhz8cptvUhZREOIX4/DiE
	 THHhaCOeWkC3e1CJWYLQynnZ4o4fJ4am36PupgAO1d5VsZalX9oPht3Fd08BBOOqFJ
	 7VEf/IdWCIRI8g7R3Lrb3cq2AQe5pHfrgRTnkEXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfB0RSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:18:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46818 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfB0RSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:18:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id v16so14628195ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H60UoctTfrVTwseB9DbPRRi9aUfzLXxDvttuU56rYTo=;
        b=NBGqm2gbE5Sxe0yBMbEiFWs3iq+u1sALMexAXT5CtbAJZ3hJ4cp2GbTCcYJz/Q3I/y
         4gh50bxvstb6G3C3WmIaae8Nm9/Wt4LXT9eey7ubzPupHx0etwIRs9caxlzGmhygXl40
         iCDBpzlgfRpzZJaEOpoMiU5aAEnmDEp+FKGcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H60UoctTfrVTwseB9DbPRRi9aUfzLXxDvttuU56rYTo=;
        b=cKl2EoHa8lodGPdBE6Mucu/nO40eYjD8XPvGk/tchLnALpw3HthqAJolFF0/L7a78i
         qBQxVWYk2ArfgfoKzZuGEBKRRCpEFTGzeI1l46lZcGpo4CSg2AOz0iVy/QzX/mNHFjSV
         ujIyg4GinGXDsJjaqEdG18z+W5s+yL4/z07aLrPxnf2JILOazDpquD48cJ5OHr4atvhM
         EG6euyg0JZU/ctf23KPsDBPEA8zde470rLwNGzT1yGWdpJ0hTcl8bQFI3fvX1RX+F2jO
         02TTxVTHoBRIjVBULIPH26ENEhSCU6SJKS3p33r/LMYSgMzZojXS1s36Y3lBumgGKSP1
         Q3Sw==
X-Gm-Message-State: APjAAAUdU8ANhiqiPXIdnEOwuoyn6rLR1K1lX4+Fbfp4ncr29tCcwMUY
        0t1VnLzXM/e7byzag4vlAJcy96jtyfs=
X-Google-Smtp-Source: AHgI3Ib8VTEGQGgcXyDr4m75c0yejWXixHCToXefN8UFYTi9/ryyK+Ou6lCmQLxJ799spP99WFhO1Q==
X-Received: by 2002:a2e:9d85:: with SMTP id c5mr2293000ljj.70.1551287880456;
        Wed, 27 Feb 2019 09:18:00 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e21sm925013lfc.90.2019.02.27.09.17.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 09:17:59 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id x206so5073020lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:17:58 -0800 (PST)
X-Received: by 2002:ac2:415a:: with SMTP id c26mr1662037lfi.62.1551287878449;
 Wed, 27 Feb 2019 09:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20190227101252.413192716@infradead.org> <20190227101544.210748832@infradead.org>
 <CAHk-=wiv6dgJDj81wukpJCJBVhAVn-CYJdhj+o8JGN1LfRwb0g@mail.gmail.com> <20190227164806.GS32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190227164806.GS32494@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Feb 2019 09:17:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_0GUBgi3guWqUzT3gZOAC+iEyZcSLdw0=_9xWJEwHZg@mail.gmail.com>
Message-ID: <CAHk-=wi_0GUBgi3guWqUzT3gZOAC+iEyZcSLdw0=_9xWJEwHZg@mail.gmail.com>
Subject: Re: [PATCH 1/5] x86/percpu: Differentiate this_cpu_{}() and __this_cpu_{}()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 8:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 27, 2019 at 08:14:09AM -0800, Linus Torvalds wrote:
> > In particular, making it "asm volatile" really is a big hammer
> > approach. It's worth noting that the *other* this_cpu_xyz ops don't
> > even do that.
>
> Right, this patch 'fixes' that :-)

Yeah, but I do hate seeing these patches that randomly add double
underscore versions just because the regular one is so bad.

So I'd much rather improve the regular this_cpu_read() instead, and
hope that we don't need to have this kind of big difference between
that and the double-underscore version.

I'm not convinced that the "asm volatile" is right on the _other_ ops
either. You added them to cmpxchg and xadd too, and it's not obvious
that they should have them. They have the "memory" clobber to order
them wrt actual memory ops, why are they now "asm volatile"?

So I don't really like this patch that randomly adds volatile to
things, and then removes it from one special case that I don't think
should have had it in the first place.

It all seems pretty ad-hoc, and we already _know_ that "asm volatile" is bad.

                      Linus
