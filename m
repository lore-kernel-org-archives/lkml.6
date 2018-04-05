Return-Path: <jyknight@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522961518; cv=none;
        d=google.com; s=arc-20160816;
        b=FlsXhDW2M/QcQwnQxmy7oGWbWeVJz1p2oGKvHb++YiVnmcYynLs6gZxwgVIDiXVVLR
         aK/aGLNxy/jCuByPOSn3P/K8sgvTwPaJwMIOh781ZuiAkFp0w5dQuRlKj+zWtg2HQdLE
         4b+Bx60a0yrwq9/hNk1ifTy/poSsKW4pK/CYQecLMIPKXWKfasvK8k+YNa/uzMIAibt/
         zA2JA2MvcqkJNfuQ8n8g/hhrfSflozrlWh4iUdDhzcOgQZqQi4YWuTjLabtalXfjTaij
         htLklloqDNt/4VCSkgwK/LO66GufnsR+6wekmGR3DYLrWRlYc5Obv08iq3h2FSGSOT5T
         v3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=LhjugTnBiCG4ICRGbdDBl1X0QrCsmhDlOmNjYdL6/ao=;
        b=I0NDVBLfA8L59f948k7MEMxMAvCEyvFJOdSs6+tqQNUk4hQpkElc5+xEp67AFdSM2M
         dPWwhqW10yW56VK3dKtkKQiD8f7pSAb7qRH3G0vBOsnR7W+MxoPstw4nOVzJIzQVEc1O
         she9wdU4VvlFNz2EHEbJ+ZpZbRVCWJfYaugxgRt+gMxug8hyZiUzy3fP8t7NCRfzQBhN
         LDn55+0LwN1uODhzZQt4Qz0sHEg27VgD4T9avlwNrtuXxvh7EwgQZsi4KM49Qs9GQqu1
         1fPkS5CAASBYbToW8nEOgRjFvnN75cM2zla055JFu4GVBm2UdGNBDUhvMnLiVfWTE26+
         6Rxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=QRwtJtP+;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=QRwtJtP+;
       spf=pass (google.com: domain of jyknight@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jyknight@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+CO/YeStLRFAS8D+bJaZZGMYAstwMcoqnuJ3pIt+M1xHv1PO+i/JrPlLDSSvOmaxqnI0OEXNok6wb/nYnhk6o=
MIME-Version: 1.0
References: <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com> <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com> <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com> <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com> <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com> <20180405072017.GN4043@hirez.programming.kicks-ass.net>
 <CAA2zVHraWtmmW1yFvVH+kUbih5wxiDLuM=wArnQanrWN9NF=Xw@mail.gmail.com> <CA+55aFwrZU-VPa9HShikNDkvuOvFXtO2vw8sDeRRTCU_hV7dWA@mail.gmail.com>
In-Reply-To: <CA+55aFwrZU-VPa9HShikNDkvuOvFXtO2vw8sDeRRTCU_hV7dWA@mail.gmail.com>
From: James Y Knight <jyknight@google.com>
Date: Thu, 05 Apr 2018 20:51:31 +0000
Message-ID: <CAA2zVHrF+teb3SwigH_sDqkWfKDg4itq4TkefYXUXw2RF9+4qw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mka@chromium.org, arnd@arndb.de,
	Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
	Andrew Morton <akpm@linux-foundation.org>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>, groeck@chromium.org,
	Greg Hackmann <ghackmann@google.com>, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596940897226174148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 5, 2018 at 2:06 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:
> On Thu, Apr 5, 2018 at 10:46 AM, James Y Knight <jyknight@google.com>
wrote:
> >
> > GCC, however, mixes up the concept of a C "constant expression" with the
> > results of running optimization passes such as inlining for its
> > definition/implementation of __builtin_constant_p. Clang does not, and
quite
> > likely will not ever, do that.

> Nothing has ever said that "__builtin_constant_p(x)" means "is x an
> integer constant expression"

I had actually meant that the __builtin_constant_p **itself** had to be a
constant expression, not that its *argument* must be an I-C-E for
__builtin_constant_p to return true.

But after spending some time on further investigating in order to show an
example of how this matters, I must take back my words. I was mistaken
about GCC's semantics.

Take this example:
===
int function(void);
void useval(int*);

int f() {
     int v = 1 + 2;
     int array[2][__builtin_constant_p(v) ? 1 : 100];
     useval(array[0]);
     return sizeof(array[function()]) / sizeof(array[0]);
}
===

Build with "gcc -O -std=c99":
===
f:
         subq    $24, %rsp
         leaq    8(%rsp), %rdi
         call    useval
         call    function
         movl    $4, %eax
         addq    $24, %rsp
         ret
===

Note the fact that "function" is actually *called* indicates that 'array'
is a VLA (...and that C99's sizeof(VLA) semantics are bonkers, but that's
another story...).

Which means that __builtin_constant_p(v) was _not_ evaluated as an integer
constant expression by GCC. Instead, it was left as an expression. And, the
stack frame being only 24 bytes indicates that the __bcp eventually
evaluated to true.

I actually think this actually _is_ something clang can implement. Thanks
for making me try to prove myself. :)
