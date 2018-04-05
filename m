Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522951597; cv=none;
        d=google.com; s=arc-20160816;
        b=NGFgrCwRUpI/B25ea3t+/oydEADj628PRfnJaMLtKA02B2AjvFSVOvgmyaf7oZQ2Rn
         isWBXfhUcqPRLuLt68J8CptKXMfmvvu/RTCOY6Uwu0OtkF1Q9mx2YcjYbjEKrwYLTsrW
         pqhu+jaTw6uMbOD5I5P1UUKViipXhvQPhFCT04NVsKjs9zTOnpMOzSsqj/aPkDJzUXN2
         nZrXtaPDTaP3KbQyokfEoVbyoq7vYnC+8H+Lw+9UlKpTv/uqZF8eOZgVBhNfRGjQZDsY
         AnmRvIdUh1pXojw9RkXJHpEGVl55jkfirtN7cMa1wCcTJD/tZkHArXk1RaLz1x4qQ93C
         J+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=lC7Xki6TujqGYWFCKdRXHxFF2/kps0K+0exPm9/0Dvg=;
        b=VsWT4n9s1QBzbfBPOOxazcpDtJ0pcdEZadif+6ZDiK3DuklLMvpzAu8YoJN2/9flW3
         1PlA6wIx+dtQgbcoTLCMiMAPyBfwTCes/t5M7D/J9mqcmq4UgI/+4GTkiAZM3KueNilt
         +P8HJi1CvdlIGk3QT85HpH6PKZFXFLsywms02epyRfTfDwcX1z6utCPC1EztVvFaRFAH
         /SEx6M5BkK19d2tuQjw+tOibMW9rU1h6qkjRsgoOaZfYBo5GAhKgDo9SJ+GvaBJZXikQ
         agrjT8ry42F+KfBu1c3b6+A2tXPIiB1xW4EIyXdsEOzkQ2IaxURa5cofHvs8mvj1vDWr
         dTgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VdhM7L+J;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=er7ovSY+;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VdhM7L+J;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=er7ovSY+;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx48kvIUEq8N47sxPo7tvSo9CfPzq2plqflscAp2AjsNUTSUCZQyeQ95MK7C2tR0d18LD0g7Y3QXFsyg8m+ZNCYw=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAA2zVHraWtmmW1yFvVH+kUbih5wxiDLuM=wArnQanrWN9NF=Xw@mail.gmail.com>
References: <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com> <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com> <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com> <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com> <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com> <20180405072017.GN4043@hirez.programming.kicks-ass.net>
 <CAA2zVHraWtmmW1yFvVH+kUbih5wxiDLuM=wArnQanrWN9NF=Xw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Apr 2018 11:06:35 -0700
X-Google-Sender-Auth: n3uDBDQQ_ghpoqI4lHdbyGKY01Y
Message-ID: <CA+55aFwrZU-VPa9HShikNDkvuOvFXtO2vw8sDeRRTCU_hV7dWA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: James Y Knight <jyknight@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Matthias Kaehlcke <mka@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, Chandler Carruth <chandlerc@google.com>,
	Stephen Hines <srhines@google.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@google.com>, Guenter Roeck <groeck@chromium.org>,
	Greg Hackmann <ghackmann@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596930494030697107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

()() ha

On Thu, Apr 5, 2018 at 10:46 AM, James Y Knight <jyknight@google.com> wrote:
>
> GCC, however, mixes up the concept of a C "constant expression" with the
> results of running optimization passes such as inlining for its
> definition/implementation of __builtin_constant_p. Clang does not, and quite
> likely will not ever, do that.

Nothing has ever said that "__builtin_constant_p(x)" means "is x an
integer constant expression".

So there is no mix-up - or rather, *you* are the one mixing things up.

The gcc documentation says:

   "You can use the built-in function __builtin_constant_p to
determine if a value is known to be constant at compile time [...]"

Note that this has *nothing* to do with the concept of C "integer
constant expressions".

Yes, integer constant expressions obviously have values that are known
to be constant at compile time. But *other* things have values that
are known to be constant at compile time too.

In fact, we went through a long and painful thing exactly because we
wanted to get that "is this an ICE" value, and it turns out that the
best way to get that value has nothing to do with any gcc builtin at
all, but looks like this:

  /* Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de> *
  #define __is_constexpr(x) \
        (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))

which is actually impressively subtle, and almost entirely standard C
(the only real dependency is "sizeof(void)", and it not being the same
as "sizeof(int)").

So honestly, if your "__builtin_constant_p(x)" is just "is 'x' just a
C integer constant expression", then your __builtin_constant_p() is
not only not compatible with gcc, it isn't really even all that
useful. We can do it by hand without using a builtin at all.

So if any clang person thinks that it's gcc that is mixing up
concepts, you guys need to re-consider. It is simply not true - and
*should* not be true - that __builtin_constant_ps anything to do with
the "C integer constant expression".

It needs to go inside inline functions. That's how we use it, and we
often have reasons why it practically has to. Macro argument
evaluation rules (and lack of type handling) makes it too painful to
use macros everywhere.

And even when the __builtin_constant_p itself is in a macro, the macro
is then often used by inline functions, so..

                  Linus
