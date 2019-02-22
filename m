Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D732C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F91206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 21:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IP644xE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfBVVtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 16:49:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39467 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVVtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 16:49:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id g80so2839905ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyRpje+KoQLYyLyQXMhb65fdvLwilaDajX26NujqhmA=;
        b=IP644xE/xBx8kzLg8wGlXPRWfqLEZUlrFNyMjCktFXN2iksHJKvBaf4iS9SIa0bSf/
         gVbfbGHTKRiaMaao8vgszDDF0H+Ze0Vb0IfDY4rnO0JTf9zIqRWuYh/jTul2tJQzVXNb
         2TA5cUnQZR+Xc+AtwwM4wUciemZWBV+plgZK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyRpje+KoQLYyLyQXMhb65fdvLwilaDajX26NujqhmA=;
        b=qNtrrI3S40uOQpOM+eWCT69WnFQz2I/w6oAL23v722uVyM8Ej/iPDdwDFn4hRPHsmf
         DtS1JUeIxh1K90ix4/F0TPz2GmJ4/RLbfAokAZ8Dwnuv3IQwi8NejSLo1sgyXqs1rZ/g
         Hor5Sa94k44F41BNM+J3UbpTysJ3HgcyEH1I9i8nRELqDcokLDf/FAhXBQDtY6i/Ms0K
         3o01zoqpyF7aPKCEk18rGYw4nfzJunD0NHcB3IEr4rvOt3waZ05DM6M3c7siSTuKRj9e
         LhynYzS4aAZBbuMOqb7jko4mD1EF7D4/kc05CwDHX/RHtc8V88WmxGLpI6XYqKiLu3yT
         J8/Q==
X-Gm-Message-State: AHQUAuaO9BNZwT3UkZewclkYVB5r1E8UO0oe5pTFbq2GqNOrjZVbD8cI
        /H10HUFHTV4y6gCHgExqrIMcMHJ/c38=
X-Google-Smtp-Source: AHgI3IYfmPCaW6cQJltbC57QuporcS0YawmwQ7fkROWao16NHuEDDGaPGEsH9CEQhu2oIUi2bFbTBQ==
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr3623624ljc.97.1550872190468;
        Fri, 22 Feb 2019 13:49:50 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id o17sm883192lfd.21.2019.02.22.13.49.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 13:49:49 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id z196so2140303lff.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 13:49:49 -0800 (PST)
X-Received: by 2002:ac2:4316:: with SMTP id l22mr3674574lfh.11.1550872188625;
 Fri, 22 Feb 2019 13:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20190222185026.10973-1-will.deacon@arm.com> <20190222185026.10973-2-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-2-will.deacon@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Feb 2019 13:49:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
Message-ID: <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I love removing mmiowb(), but..

On Fri, Feb 22, 2019 at 10:50 AM Will Deacon <will.deacon@arm.com> wrote:
>
> +#ifndef mmiowb_set_pending
> +static inline void mmiowb_set_pending(void)
> +{
> +       __this_cpu_write(__mmiowb_state.mmiowb_pending, 1);
> +}
> +#endif
> +
> +#ifndef mmiowb_spin_lock
> +static inline void mmiowb_spin_lock(void)
> +{
> +       if (__this_cpu_inc_return(__mmiowb_state.nesting_count) == 1)
> +               __this_cpu_write(__mmiowb_state.mmiowb_pending, 0);
> +}
> +#endif

The case we want to go fast is the spin-lock and unlock case, not the
"set pending" case.

And the way you implemented this, it's exactly the wrong way around.

So I'd suggest instead doing

  static inline void mmiowb_set_pending(void)
  {
      __this_cpu_write(__mmiowb_state.mmiowb_pending,
__mmiowb_state.nesting_count);
  }

and

  static inline void mmiowb_spin_lock(void)
  {
      __this_cpu_inc(__mmiowb_state.nesting_count);
  }

which makes that spin-lock code much simpler and avoids the conditional there.

Then the unlock case could be something like

  static inline void mmiowb_spin_unlock(void)
  {
      if (unlikely(__this_cpu_read(__mmiowb_state.mmiowb_pending))) {
          __this_cpu_write(__mmiowb_state.mmiowb_pending, 0);
          mmiowb();
      }
      __this_cpu_dec(__mmiowb_state.nesting_count);
  }

or something (xchg is generally much more expensive than read, and the
common case for spinlocks is that nobody did IO inside of it).

And we don't need atomicity, since even if there's an interrupt that
does more IO while we're in the spinlock, _those_ IO's don't need to
be serialized by that spinlock.

Hmm? Entirely untested, and maybe I have a thinko somewhere, but the
above would seem to be better for the common case that really matters.
No?

             Linus
