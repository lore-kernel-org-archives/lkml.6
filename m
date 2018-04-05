Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522887616; cv=none;
        d=google.com; s=arc-20160816;
        b=JrIcwpKmLkY2O/7awYSfuDk/BAoWvnRjINvdKbKZ8QURwLvTnIAgrc3vZWx2gRIqod
         J911Xb+0UOuqo5xL3OpTuq32XLJd3L0T6FNOCOb4fcN/qu/oZEgvL7r85k5KZOJ25FF3
         l4gC2YyuEcbS5l134xMQrxl0tbn05o1a12lkoyeNmBIn0q6V1+F0Dt6xcOuDrKpzFE0V
         fcBPT/zrxxWhLiyVR5F5/e5FGLGialCbhNNZxzz+r8FsoxtfGYIU2wsz02XthziMYvK3
         SjkoZzk97+xCQGygUC994ETbC37B7wBmJxtMZfLxsxRb0ShSQ0OH0MU3L0HsNtAQ+y38
         TkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Ta2lO9P/qzCVDqGo9u/k42El/il8nl9efVWbu6modPQ=;
        b=RfANBZWiP0ePTUQtKKUp2X4JJ7E20VEs+UybVAxeRy+8QZC3i+vaya79LdPWakAS6f
         8wjXcfTcvcizR4wDSkeSDn1tYV7t4qp2OYK1rpuiEn8Et0bFYWe4Kwkwc980sIQu1Ouu
         YjOuYNbPNX1R85peYrfk53u1s9IwxfT0rutGjZf8o5nUtHssM/6lRUEOkZQtvp51KtIc
         oQXerLhmEJAqIQOqdFBAQhgHATazt6gQ+7cm/WCav463Gt29tL05llZWrz6xYvJgZqGl
         6wm3bwbOYxdStuQrjJJe3FwbTZ6XyOuDabu8KkTGLCNv/qC5/6ZNeUuLpDO5eTJ2Udvg
         cYIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ON7B5FAc;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ON7B5FAc;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+4vZw1lR03ILum4ZyV1OkFY26GqWvwdAmXRKLjVPQVYRdkarU3Mku9oZ3RuY7AwOCiAiugAzQVn9DBXHRdS94=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyHzKg3GzTdW4Z+xC5u2FZ8HnduNFi3PYVTGoKCqpR6Dg@mail.gmail.com>
References: <20180403180658.GE87376@google.com> <20180404093007.GI4082@hirez.programming.kicks-ass.net>
 <20180404191724.GF87376@google.com> <CAK8P3a1VFWYBymd3AeG1DwW++tCGsP9+vw6t8XSGHby2jmQPqA@mail.gmail.com>
 <20180404205848.GG87376@google.com> <CAK8P3a2tf3v6seq=OeyBakZ1ZXYzzL=tY=aHvKYv-GtD7sWeTA@mail.gmail.com>
 <20180404214639.GH87376@google.com> <CA+55aFwp8vRmf5p09nbunp6DfO+YvvWLj=FsU8KSW0ZwF6u80w@mail.gmail.com>
 <20180404221744.GI87376@google.com> <CA+55aFz+RcyPOTs3WM-FcwoQtgaotcBVqswma7qZ-3O2Fv__9Q@mail.gmail.com>
 <20180404233111.GJ87376@google.com> <CA+55aFyHzKg3GzTdW4Z+xC5u2FZ8HnduNFi3PYVTGoKCqpR6Dg@mail.gmail.com>
From: Kees Cook <keescook@google.com>
Date: Wed, 4 Apr 2018 17:20:14 -0700
Message-ID: <CAGXu5jLebFAFTmu0r4jZLUvWi_6ki2JL598M-tCXeTnWo5vWPQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/build changes for v4.17
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, James Y Knight <jyknight@google.com>,
	Chandler Carruth <chandlerc@google.com>, Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>, Guenter Roeck <groeck@chromium.org>,
	Greg Hackmann <ghackmann@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1596675801568391777?=
X-GMAIL-MSGID: =?utf-8?q?1596863405042998917?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 5:05 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Apr 4, 2018 at 4:31 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>>
>> From some experiments it looks like clang, in difference to gcc, does
>> not treat constant values passed as parameters to inline function as
>> constants.
>
> Yeah, I think gcc used to have those semantics a long time ago too.
>
> Many of our __builtin_constant_p() uses are indeed just in macros, but
> certainly not all.
>
> Other examples are found in our "fortified" string functions.
>
> There a clang build will likely simply miss some of the build-time
> fortification checks, and trigger them at runtime instead.
>
> Of course, we hopefully don't *have* any build-time failures, because
> gcc will have caught them, so you won't care as long as clang is a
> secondary compiler, but long-term they'd be good.

Yeah, it's used in inline functions in a lot of places. Some quickly
jump out: kmalloc, crypto, bitmaps, networking, uaccess, kvm, etc from
doing a dumb grep as:

git grep -B5 __builtin_constant_p | grep -A5 inline

FWIW, I prefer inline functions over macros just to keep type checking
a some level of sanity when reading build warnings/errors. ;)

-Kees

-- 
Kees Cook
Pixel Security
