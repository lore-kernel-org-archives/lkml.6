Return-Path: <mka@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522778820; cv=none;
        d=google.com; s=arc-20160816;
        b=MVe8HmV2zQQyJyKU3eFyjF3kOL34PxRUOd8/RbGOdignZ2YBe7M0T6RCM8B8DSj2gH
         UF1WF6sV5rKJ7VoLtPHZ7FMtCJU0cOiPglCR881NaJg6iANfmQcXIRks/UytrKcTThO9
         Il3GwSfjkjHqzonZiVU+Pg6MeNj4VcP5IzapbMx/Jm01Hbd1NT/7sY0Off/ax4u/4Sks
         J61jMEzvKKACwLTI89NHvBXykMX19+uob3X5JqMy21OP8u4FSHPXAuMZqOAaM3ci3BUj
         ji1apYsp40CzY+Mmp+9HQa+vMOCOysjKsZpt/6m18pG2Q19MB6rF+sjfI3oZH8hkXzDv
         F3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=nXBF7XPvvNG9fFVu1lBa11bdvW1glghqgojoOrnJKO4=;
        b=QZ79OGWyabo1UuR5lMNC6j2Ef0MrJBLgjKsbl2xQbesL+n1MH2qqufg5yKuHpoh6jP
         mEkgaIJAAGtAaTTLF1kxPHTzNflxIG4YZN51E/9upFtzXGYhFWaiGxyVa0Ph28w5VftK
         CX8c3dNIElxdJF1U3qVBIObt4q/xztUWraoNddqPIDohTg6TTCUOCh1XC8QU9+JKnlAn
         JLB1zYYqiQlfX3zL62kNwiiT0f/4EO6hYPaI+479udyc6YQAKmhZn/y0QteMJM8DwoDj
         89Hro9F17Sje8zcXRyTN1J2rzNRggGuEh1cq65d2OnPUkPqb9/6MXuODRBLAp1Ittjvh
         oteg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Xwz/4clA;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Xwz/4clA;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4+FhPdT0JxCN6tM9lk6ohrD74CoHw/N6BSSW0WoI+2w99FmY3U+gjJqT4D9XptCIt9EzuX1og==
Date: Tue, 3 Apr 2018 11:06:58 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>,
	Guenter Roeck <groeck@chromium.org>,
	Greg Hackmann <ghackmann@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] x86/build changes for v4.17
Message-ID: <20180403180658.GE87376@google.com>
References: <20180402095033.nfzcrmxvpm46dhbl@gmail.com>
 <CA+55aFzV8L-uv9706ryJ2mP9VGBuzqFVPu1cgYY+sZAtDAroqg@mail.gmail.com>
 <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180403095118.rpf7tj577dppvx7d@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596749324289409108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

El Tue, Apr 03, 2018 at 11:51:18AM +0200 Ingo Molnar ha dit:

> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Apr 02, 2018 at 02:44:48PM -0700, Linus Torvalds wrote:
> > > On Mon, Apr 2, 2018 at 2:50 AM, Ingo Molnar <mingo@kernel.org> wrote:
> > > >
> > > > The biggest change is the forcing of asm-goto support on x86, which effectively
> > > > increases the GCC minimum supported version to gcc-4.5 (on x86).
> > > 
> > > So my biggest worry isn't gcc-4.5 (anybody who hasn't updated deserves
> > > to be forced, or can stay with old kernels).
> > > 
> > > No, my biggest worry is clang. What's the status there?
> > > 
> > > I've pulled this, and honestly, the disaster with
> > > -fmerge-all-constants makes me think that clang isn't that good a
> > > compiler choice anyway, but it's sad if this undoes a lot of clang
> > > work just because of the worries about Spectre and mis-speculated
> > > branches.
> > 
> > It's not just spectre, I believe you yourself wanted to use asm-goto
> > somewhere in the x86 code:
> > 
> >   http://lkml.kernel.org/r/CA+55aFyCp-9Qqjcn9wp=VDp2KO7tfYuUMJxVKC75Xxu0wEB5Cw@mail.gmail.com
> > 
> > There was some KVM talk of relying on it here:
> > 
> >   http://lkml.kernel.org/r/6a5f2453-cf51-d491-db54-5f239caa29bc@redhat.com
> > 
> > And there's the comment here:
> > 
> >   https://elixir.bootlin.com/linux/v4.16-rc7/source/arch/x86/kvm/emulate.c#L457
> > 
> > As to the suitablility of using clang, there's also this unresolved
> > issue:
> > 
> >   http://lkml.kernel.org/r/20180321211931.GA111711@google.com
> > 
> > The fact that even without asm-goto they cannot correctly compile a
> > kernel and have sat on their hands regarding asm-goto for the past 7 odd
> > years makes me care very little.
> > 
> > And since they need to spin a new version of the compiler with all the
> > various bugs fixed, they might as well include asm-goto in that and be
> > done with it.
> 
> So there's really two questions here:
> 
>  - This asm-goto change only impacts x86, is there any production x86 kernel being
>    built with Clang? I think the Pixel kernel is built with Clang, but that's ARM.

Yes, Chrome OS R67 (currently dev, soon beta) will ship a kernel built
with Clang for multiple x86 Chromebooks.

IIRC the kernel of the Android emulator is also built with Clang.

>  - Is there anyone on the Clang side _actually_ bending metal and working on 
>    asm-goto support, with something like very early alpha test patches available, 
>    etc.? Last I saw the communicated Clang POV was still that they wanted to do 
>    something "better" (and incompatible to ...) asm-goto. Has this changed?
> 
> If it's being relied on, or if there's actually something firmly planned,
> which we could track, then I'd have no problem with reverting this change
> and waiting one more kernel cycle or so.

It is actively been worked on, but AFAIK there are no public patches
available at this point.

>From Chandler Carruth who is involved in this effort:

  A number of folks from both Kernel and LLVM communities are looking at
  how to implement asm-goto in Clang in a way that should both work for
  the compiler and for the Kernel. So there is progress here, it isn't
  just everyone sitting around and waiting. Having more time to finish
  it would be appreciated as it isn't easy to implement.

Both Chrome OS and Android are interested in an upstream kernel that
builds with Clang, and we have compiler folks supporting us on the
Clang side. We ship devices with Clang built kernels and plan to do so
for future devices, so I think I can say we are committed to make this
work.

Given that it takes time for distributions to roll out new compiler
versions I would like to ask for a longer period of 'exemption' from
asm-goto for Clang, at least if it isn't an actual burden for the
kernel, like preventing important features from being added. An ideal
time would be after the next-next LTS version, if this is considered
too far out, after the next LTS version would be the second best time
IMO. Let me be clear, this is *not* to delay the implementation of
asm-goto, but to facilitate the use of Clang-built kernels by other
projects and distributions, as well as automated builds of upstream
kernels with Clang, without requiring necessarily the very latest
version of Clang or extra patches.

Thanks

Matthias
