Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522886726; cv=none;
        d=google.com; s=arc-20160816;
        b=h5IHTOBiLWw787DE2A6ZDE1eN0z0t9gYsZU3h1HasluzQjltH5P2aWNg08vNQqHCCo
         HAMfaK8NX40OPagTZSURNOp241KVmHBG/U2NhuJMrSY1vV4RtxPJYAp419veu0/8uiqd
         nILtCa9cK7tM1Enid8C0+ezc3I62nD0btHbhF2EpLqqDMldpmYEf4YCEn52Cv57yXSzZ
         M85wXC+pnIhi1vl0VCYZKZoGpN4aYMRcqkXvuBdbCKu6L34iGJs+yrFdPjwLNYPICjJR
         yqtRW6nfIgA6rKRIzQ1HMTAfhmyYsAJxlAPH2FV4bip8d1Y46EB5q3CkfD0gRnDoLCB3
         ragw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ECTNhd7sZ4CWcFLuntGNv6lsyBDmqQ6Er/L83dC+SPc=;
        b=s8UYaHyrFDuYyGeImKTsfbtqL5QQEh26T7/wW9RIjrh00mP1lY5F7GlrN3wDYGw3hU
         /DsfIjfDq44Htbw7Fcya5fEkDT8u20eM0umvNgoM4IuPGSHPmrUirUX/2Ig1t2b9EkNG
         27PYjBTJL6MXMByYE9cchv4WrlQLZ6n/dy9Q4U9pY7qPUXOtW9z+HYS97lw0POlE7Fln
         r2mKGLWpToQBD14Pq+ISENCGjcfpXKUVJnwe24crB7a6cba+4e+8foStftDso13P0Jrx
         3TDooO6moU68Y/ofZUMgGwXX5fCneCgfnrJakx/ILSOY5VRijOwv9IBR1Fn9ago+6nBX
         MAZg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GruHUrVC;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=SBfWyZte;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GruHUrVC;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=SBfWyZte;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx48EOntVdJgPYYdXvJCZJf3cDLpqFQEZH9tN6QSuGGR8Lxcwo8uAl8YndZMHHyTiIB1H1MmMjyEDVOPLNzTQFc4=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180404233111.GJ87376@google.com>
References: <20180403180658.GE87376@google.com> <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com> <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com> <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com> <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com> <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Apr 2018 17:05:25 -0700
X-Google-Sender-Auth: vvA8Fb8YYDnj95s0eLd5C8-9-b4
Message-ID: <CA+55aFyHzKg3GzTdW4Z+xC5u2FZ8HnduNFi3PYVTGoKCqpR6Dg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>, Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@google.com>,
	Guenter Roeck <groeck@chromium.org>, Greg Hackmann <ghackmann@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596862472197829112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 4:31 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> From some experiments it looks like clang, in difference to gcc, does
> not treat constant values passed as parameters to inline function as
> constants.

Yeah, I think gcc used to have those semantics a long time ago too.

Many of our __builtin_constant_p() uses are indeed just in macros, but
certainly not all.

Other examples are found in our "fortified" string functions.

There a clang build will likely simply miss some of the build-time
fortification checks, and trigger them at runtime instead.

Of course, we hopefully don't *have* any build-time failures, because
gcc will have caught them, so you won't care as long as clang is a
secondary compiler, but long-term they'd be good.

> I'll ask our compiler folks to take a look, with lower priority than
> other issues in this thread though.

Ack. "asm goto" is way more important. The __builtin_constant_p()
stuff tends to be for various peephole optimizations.

Another example of that can be found in our x86 bit operations macros:

  static __always_inline void
  set_bit(long nr, volatile unsigned long *addr)
  {
        if (IS_IMMEDIATE(nr)) {
                asm volatile(LOCK_PREFIX "orb %1,%0"
                        : CONST_MASK_ADDR(nr, addr)
                        : "iq" ((u8)CONST_MASK(nr))
                        : "memory");
        } else {
                asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
                        : BITOP_ADDR(addr) : "Ir" (nr) : "memory");
        }
  }

where that IS_IMMEDIATE() hides a __builtin_constant_p(). But we could
actually change that - for some reason the test_bit() case looks like
this:

  #define test_bit(nr, addr)                      \
        (__builtin_constant_p((nr))             \
         ? constant_test_bit((nr), (addr))      \
         : variable_test_bit((nr), (addr)))

which is much more straightforward anyway. I'm not quite sure why we
did it that odd way anyway, but I bet it's just "hysterical raisins"
along with the test_bit() not needing inline asm at all for the
constant case.

             Linus
