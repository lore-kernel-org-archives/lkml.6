Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522915489; cv=none;
        d=google.com; s=arc-20160816;
        b=b579ByPunyPLoFjSIbmV00oh+74Bwm7W7s+Uw363zStC6XTsB2ASIugNr0Q7BpYm0i
         w7eZKBCetZccVBFmDvbj0+GmMj1c6iUz2zXbRLUWtsV2eyoN1af5Jl6on9FluN972dcz
         xu8yEjkHQ3GGza9WlEsiURwEGKE4ZNUn3r7pP37IvbYFrj8L895pRXq20vqv8VrLCqYg
         5v20zyv4fOKsO49viDkv2CdGF+27us0ezYmW2jbLhXWQQu1VCMeAucuMRy6yQGomwFu9
         zdjSPwxm9KljWI6P6qWXPnZW+SH8GCygIUn6AMWHExucssKLGdx8xYNvLeVF75O7v6sP
         R/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=/eeA1BbHJFxT8Mv0wKOh2tvvvLcW6Xj8nti8UDdEqCI=;
        b=xayncpMFfx2N0kffsoKPXH+Nj2FjBMBuvc4Hu3HMy7weaN8AocInGi8HKkqcdVud2F
         kPh0pJzaMYoJE4BxGbF2jmiOg/B3HuObCejM7bWu0KNSZPtb4aSnvpriW+eIHxZsMu6x
         B0sUM/Nj0CbzY43EPevC2DHXXstp2tTiND4pC6k2j3Vma0o8BuHDTqkXXLG/royKTezx
         4zV7MnYgPzrSVJENAXwIspSiNthBrCcH+wGZWIv6zfFErGzm5+LZ7RSJBp3REqqSVErZ
         9nxrpxMqGXc53Mb1omqKi2xzYXfmwRVE+XLdeuzOwXrfOUPvhjQaIipgIGbPJC1t+2Wx
         TrnA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NSHMh/Qi;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NSHMh/Qi;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AIpwx49tMP3zASaQK+W1mEk5L0AO5gv4tbR1XW4yuFNX+5QzvzGGUQ8DnE6125yeAbG4bshcbG3wkQ==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 5 Apr 2018 10:04:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Matthias Kaehlcke <mka@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20180405080446.qomyc6ozug3g57gl@gmail.com>
References: <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com>
 <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com>
 <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com>
 <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com>
 <CA+55aFyHzKg3GzTdW4Z+xC5u2FZ8HnduNFi3PYVTGoKCqpR6Dg@mail.gmail.com>
 <20180405072401.GO4043@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405072401.GO4043@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596892632598206020?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Apr 04, 2018 at 05:05:25PM -0700, Linus Torvalds wrote:
> > for some reason the test_bit() case looks like
> > this:
> > 
> >   #define test_bit(nr, addr)                      \
> >         (__builtin_constant_p((nr))             \
> >          ? constant_test_bit((nr), (addr))      \
> >          : variable_test_bit((nr), (addr)))
> > 
> > which is much more straightforward anyway. I'm not quite sure why we
> > did it that odd way anyway, but I bet it's just "hysterical raisins"
> > along with the test_bit() not needing inline asm at all for the
> > constant case.
> 
> I always assumed BT was a more expensive instruction than AND with
> immediate.

According to:

   http://www.agner.org/optimize/instruction_tables.pdf

The SkyLake costs for 'BT', 'AND' and 'TEST' variants are:

         Instruction        Operands      uops fused    uops unfused       uops port    latency throughput
                  BT           r,r/i               1               1             p06          1        0.5
                  BT             m,r              10              10                                     5
                  BT             m,i               2               2         p06 p23                   0.5
         BTR BTS BTC           r,r/i               1               1             p06          1        0.5
         BTR BTS BTC             m,r              10              11                                     5
         BTR BTS BTC             m,i               3               4      p06 p4 p23                     1
          AND OR XOR           r,r/i               1               1           p0156          1       0.25
          AND OR XOR             r,m               1               2       p0156 p23                   0.5
          AND OR XOR           m,r/i               2               4 2p0156 2p237 p4          5          1
                TEST           r,r/i               1               1           p0156          1       0.25
                TEST           m,r/i               1               2       p0156 p23          1        0.5


So if I'm reading it right, the relevant comparison would be:

                  BT             m,i               2               2         p06 p23                   0.5
          AND OR XOR           m,r/i               2               4 2p0156 2p237 p4          5          1

?

Thanks,

	Ingo
