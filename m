Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932469AbeCKWve (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:51:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44892 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932224AbeCKWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:51:33 -0400
Date: Sun, 11 Mar 2018 15:51:21 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jason Vas Dias <jason.vas.dias@gmail.com>
cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        andi <andi@firstfloor.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4.16-rc4 1/1] x86/vdso: on Intel, VDSO should handle
 CLOCK_MONOTONIC_RAW
In-Reply-To: <CALyZvKwDARXJaf3-Z5U_9mwK0oYpJorS3NzPB0P3UriYM8Gn4w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1803111513110.1625@nanos.tec.linutronix.de>
References: <d10bglsa.fsf@gmail.com> <alpine.DEB.2.21.1803111048360.3841@nanos.tec.linutronix.de> <CALyZvKwDARXJaf3-Z5U_9mwK0oYpJorS3NzPB0P3UriYM8Gn4w@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Mar 2018, Jason Vas Dias wrote:
> On 11/03/2018, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Sun, 11 Mar 2018, Jason Vas Dias wrote:
> >
> > This looks better now. Though running that patch through checkpatch.pl
> > results in:
> >
> > total: 28 errors, 20 warnings, 139 lines checked
> >
> 
> Hmm, I was unaware of that script, I'll run and find out why -

Documentation/process/* which I recommended for reading before definitely
mentions it.

> probably because whitespace is not visible in emacs with
> my monospace font and it is very difficult to see if tabs
> are used if somehow a '\t\ ' or ' \t' has slipped in .

It's not only about whitespace ....

> >> +notrace static u64 vread_tsc_raw(void)
> >
> > Why do you need a separate function? I asked you to use vread_tsc(). So you
> > might have reasons for doing that, but please then explain WHY and not just
> > throw the stuff in my direction w/o any comment.
> >
> 
> mainly, because vread_tsc() makes its comparison against gtod->cycles_last ,
> a copy of tk->tkr_mono.cycle_last, while vread_tsc_raw() uses
> gtod->raw_cycle_last, a copy of tk->tkr_raw.cycle_last .

Well, if you look at the timekeeping core then you'll notice that it's
actually the same value. It's updated in both tkr_mono and tkr_raw so its
available when either of the tkr_* structs is handed to the relevant
functions.

> A complete patch , against 4.15.9, is attached , that I am using ,
> including a suggested '__vdso_linux_tsc_calibration()'
> function and arch/x86/include/uapi/asm/vdso_tsc_calibration.h file
> that does not return any pointers into the VDSO .

I'm not going to look at attached complete patches. The development process
is well defined for a reason and it's not optional.

Thanks,

	tglx
