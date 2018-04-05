Return-Path: <jyknight@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522950474; cv=none;
        d=google.com; s=arc-20160816;
        b=JSVUr90UDx8sVqcPsO9yb4yWf8B0wKWalI+Pe2ujnzD+gSwC4paG9Y7trBP7UBZsGf
         HOAjR3YhxfIU54eIa7UiDU8+F8CVxJxwD4yb799dTXW7byye2kwIB+2JeC5fTiHhrxtQ
         XJKNQbLpTW4RngX88RN/skb6ryLLxAUZv4Q2QUf94VJl2ekBdrLij0GN8QxBPWufI04u
         gE6/4swBLufijo5JiDHoexf6o7XJw1ORlvrJubtYXp8fzqK0A4RrlQcMy8UB1qxzr8Gq
         kvarJCGd6y5tFWThyXoukO5hBuDRlJEznLI/6wE6zSM2696VGgO6bocE/jKUw19BBEk5
         fztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=AEsIpEyHuhGS3QX1B+hM+uvrVAaKxk+I/gTdmzqUsEc=;
        b=TqDiXP9Bv1ch8RUoY8eX90g65jRdzjBh2UHv9Tgmd8nthNzRnzVpq/lOZbigfsuO6x
         OBNtQqi7noxnz5GK6a62asVl1lzs2er4E/MJluZOK+Nx65x68ZW3pqPtc6xROhfihUty
         mF9PNbXYjjM9uqTc0XF11kCzeYVUgmtHeWAKFeylBtijs5shE/VeoJAe7kdjs44Kf6kX
         JvoQVd7ubIkEsKvBiK+nkUPApUFpJXFMry5/RJnekkh+Qzg7FiCzzXGBIxkgmFNn/TFD
         zWLbnFWF4qnK4WO6DKI4Bk9eS9QWOrUpkqLYz9eixCV0EgUqyo/Ni/o4Svi/xhFn8Pyj
         HtXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=l9GpiT07;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=l9GpiT07;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+8VERL/c0aCzDUEwdkBz/XHcXE7fwt/KdgK+lsJ7ijOdDf+r6eSNZF68g6d5w0jHmAC0MJorYdN6wDIcQyfbU=
MIME-Version: 1.0
References: <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com> <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com> <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com> <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com> <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com> <20180405072017.GN4043@hirez.programming.kicks-ass.net>
In-Reply-To: <20180405072017.GN4043@hirez.programming.kicks-ass.net>
From: James Y Knight <jyknight@google.com>
Date: Thu, 05 Apr 2018 17:47:42 +0000
Message-ID: <CAA2zVHocx8PNKk=Uxuh=nv6hO-w+u2hkWhsTPeWxLB_sNQ+bRg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Peter Zijlstra <peterz@infradead.org>
Cc: mka@chromium.org, Linus Torvalds <torvalds@linux-foundation.org>, arnd@arndb.de,
	Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
	Andrew Morton <akpm@linux-foundation.org>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596929316138920643?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I think maybe you're confused; those functions do not appear to use
__builtin_constant_p, which is the issue at hand. Clang's optimizer is of
course not a complete joke...it can perfectly well optimize functions after
inlining in order to not generate "shit code gen".

GCC, however, mixes up the concept of a C "constant expression" with the
results of running optimization passes such as inlining for its
definition/implementation of __builtin_constant_p. Clang does not, and
quite likely will not ever, do that.

That said, I do believe there are ongoing discussions as to how to best
provide a useful alternative which is less semantically strange, and not
too difficult for to conditionally adopt for a gcc/clang-compatible
codebase such as the kernel.

On Thu, Apr 5, 2018 at 3:20 AM Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Apr 04, 2018 at 04:31:11PM -0700, Matthias Kaehlcke wrote:

> > From some experiments it looks like clang, in difference to gcc, does
> > not treat constant values passed as parameters to inline function as
> > constants.

> Then you're also missing a heap of optimizations in code like
> rb_erase_augmented() which is specifically constructed to take advantage
> of constant propagation like that.

> Other sites where we expect that to happen is __mutex_lock_common(),
> __update_load_sum() and a bunch of others. There isn't strictly a bug
> here, but not doing that constant propagation will still result in shit
> code gen.
