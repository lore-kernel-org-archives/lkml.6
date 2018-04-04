Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522881565; cv=none;
        d=google.com; s=arc-20160816;
        b=qCqFBLIauiI8hGpzIc0JdGATUTmoFtI2hiJQz3V9RFnf6W3rFH+6C4z8BaHudW6cjG
         RqI+LS70CjhRO+GEBqloEmZsafpyfZUsbx2Bx8pHQN9LBXi9O1ZjlZfjDvIWNGBefqG1
         PaF0qrIACv3udX0c2yWQAFsybzdS4xVL2zz3l1POs+rEuQVFykSTK/0TPtgGEVmfc/K0
         HpOehmxQaaj/NIgrsUvsBQLmeIG1OBjwjBSR10uzApZ3sl3wVaRbz1Pn4vC7RXYkDaJJ
         BbhIw56mCrfjVmKGV6GlqzJA8bGxpPN4lrSrxqlqdTtWfyydcEXnU8+QRmmx0fekY3Pn
         AECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=muszaI0ozkhkdqv+TpGh4YzE88H9hnH+B0tBaUVhPeI=;
        b=NY/ciLVVQ04ZKCKCMp2iLg3gJXha0gcjjekqq4b6ZvMjWuJlGu5JGtU2W32s1xTg0i
         d65NNhWecPWmum99VO7g56Z0JcV+bwiAqIrIoSBa0XKCPhy4UBV6Z0oFR0X6Y1HgW2GK
         2oUOgAbURPlsCfoWB2IZYUeo9OucSVnqrelZSxcmBjKSTkv4TkqebPEIm++RYO3TDcLi
         z5O5YBoIojur49cJ1MFndMw5Csoz/+6CFHIf7oPFZ7HYVp7jzRfQou6azPMNJZRdV00C
         BL0S6UTCGwlEeHD9aRK65y5Ui6g14UzcNzlZp1xUaQG3nAMU/1SRMBgOqMFsq8x9aC1k
         DMTA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AaylBK+C;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=THAx61AS;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AaylBK+C;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=THAx61AS;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4/gqICbGZCzFXZhUBIGykKTEPDfRKZiLaTfqNV2UqHfLao8ZD2ayTlgZSoxeefkZ4TJXsi2q+lq/YvSeTVtPDY=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180404221744.GI87376@google.com>
References: <20180403085904.GY4082@hirez.programming.kicks-ass.net>
 <20180403095118.rpf7tj577dppvx7d@gmail.com> <20180403180658.GE87376@google.com>
 <20180404093007.GI4082@hirez.programming.kicks-ass.net> <20180404191724.GF87376@google.com>
 <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com> <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com> <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Apr 2018 15:39:24 -0700
X-Google-Sender-Auth: 6ljjgnJx3mAvca2-vPvzVmt9v5o
Message-ID: <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1596857060378208104?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 3:17 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Getting our compiler team high to look into this might affect a timely
> (and correct ...) implementation of asm-goto and others important
> features. Arnd, do you have another, preferably simple instance to
> keep our compiler folks (halfway) sane?

I don't know if clang actually already gets this right or not, but as
an example of a case where we have a semantic difference between "is
this a constant or not", a much simpler case is in

 - arch/x86/include/asm/uaccess.h:

  /*
   * Test whether a block of memory is a valid user space address.
   * Returns 0 if the range is valid, nonzero otherwise.
   */
  static inline bool __chk_range_not_ok(unsigned long addr, unsigned
long size, unsigned long limit)
  {
        /*
         * If we have used "sizeof()" for the size,
         * we know it won't overflow the limit (but
         * it might overflow the 'addr', so it's
         * important to subtract the size from the
         * limit, not add it to the address).
         */
        if (__builtin_constant_p(size))
                return unlikely(addr > limit - size);

        /* Arbitrary sizes? Be careful about overflow */
        addr += size;
        if (unlikely(addr < size))
                return true;
        return unlikely(addr > limit);
  }

where the actual check itself is simplified for the constant size case
(because we know that constant sizes are never going to have the
overflow issue with the address size limit)

That inline function itself is then wrapped with a couple of macros,
and the usual use-case is through "access_ok()", which then typically
just gets either a sizeof(), or a non-constant length.

Of course, we've been walking away from having people do "access_ok()
+ __copy_from_user()" (the latter does some conceptually similar
optimizations on constant sizes), so those probably simply don't
matter much any more in practice.

But they are certainly a lot simpler to look at than the more exciting
32-bit asm-generic "do_div()" case is ;)

                  Linus
