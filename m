Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx49wgf7PfBJHdocyo/G37O41fSYnqwuwXMe97Ygqbc77XcAMnyOFpBJmWhp5tyAc9/Tw7T7K
ARC-Seal: i=1; a=rsa-sha256; t=1522913053; cv=none;
        d=google.com; s=arc-20160816;
        b=ucP8T8Lmrr3D6xRsIXGoYgplOeqHDn0l7e9jYa11wz8wiES+8ZOWL+s/adQ0HQ7pUb
         dHg5/RFuu4YkJHArnhUwe5cEUuj7ur3oXmW4uBRwuinh/XOHZ88nXeP9afAm4l59YLhS
         qZiciXRKGYAiqYJFroDPAFevKfWRP5GiUujiAPGMYsGGeGtlJbrCCHF4Z5Tst6/c5Zko
         DyH8Ro2eWGCzE1QPhQthZZFSBwwjMcIjZM+Iwzor8oiBQZDwnkR99Vw/L1EdV1qSfNxb
         sHxuzbodeZSshaDqEMxhjRGT3iEw+vZc/1OI8HpT8oUwygowfxk6T087Q2TqbeYHFMqB
         yqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=0nS1bpc03p73LePdJVSGPQrI+kZrB3gwqVQHQetcH34=;
        b=CfAMLf8YHQIGaOThkq69teqH3M64ivBzhYAOsggXAA8AvlzqyRfttNn+C6eYCXCLQf
         VyCzyKVaYIBzH29HwZcgjLN5ZwZf/oaSPwnlXdMy7W0Lt6A8JgVUMQdwCxVS1dGdJMAP
         cUKQgi3WhMXVzQIHAOSmqUSSa7zlVXp/0cYH/L+cDf3nMETUvOgayh4EqMFAISpqg6B6
         UP34bVeGohBEOP2gW0ptNiVUV+mllVUaFRJq9WuxRR89vtCpPo4KwiANtzRSz+yYT/R/
         Ym3iF/NglmOJ3VloT9IIhksZUT6clgez0enQsp2RLIJBx6NLsbE+Qwh99I8yog8MjpOT
         Z9Tw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=PCx/1Dyw;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=PCx/1Dyw;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Thu, 5 Apr 2018 09:24:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20180405072401.GO4043@hirez.programming.kicks-ass.net>
References: <20180404191724.GF87376@google.com>
 <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com>
 <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com>
 <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com>
 <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com>
 <CA+55aFyHzKg3GzTdW4Z+xC5u2FZ8HnduNFi3PYVTGoKCqpR6Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyHzKg3GzTdW4Z+xC5u2FZ8HnduNFi3PYVTGoKCqpR6Dg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596890078565811467?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 05:05:25PM -0700, Linus Torvalds wrote:
> for some reason the test_bit() case looks like
> this:
> 
>   #define test_bit(nr, addr)                      \
>         (__builtin_constant_p((nr))             \
>          ? constant_test_bit((nr), (addr))      \
>          : variable_test_bit((nr), (addr)))
> 
> which is much more straightforward anyway. I'm not quite sure why we
> did it that odd way anyway, but I bet it's just "hysterical raisins"
> along with the test_bit() not needing inline asm at all for the
> constant case.

I always assumed BT was a more expensive instruction than AND with
immediate.
