Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520368976; cv=none;
        d=google.com; s=arc-20160816;
        b=v2yyBy5vPEF5DoFNz1MiLby9ZT5rYfTDGQtw4Yp0GktMkbVI5gtRY23ybpFq3DIqZM
         BJW4NUNpfCrGYhjOynSpWh9n0mIfpFIXw1w4JMgJPYGZ09EhjQ6jMC1U+PkyAvbvMh/j
         ahwHn0SAYh1gcTOEwXNO4LA4YmfWI9QdbKi12K6j0RAfXVrqfXFLFUROMhkmIbVGEoi1
         KcSZZAW4yedkk17mFASxHIDKEy7GMkFdlAYXWhA8NuTJSGZ5nX85WrL7tmST+MTsbq5i
         K6vi7yx2tiLRTNU23q/uih6b7D+AB0wVz0FpE4PyXy3jasnIrNb236K4onsfzkNrETjV
         LArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=cEEECcQNtgkbor0G85i7LUnSIKdDrDioQv0alPQdzk4=;
        b=wxf7jm7Z1wzjDq81LhJ1FJ87nTuit9i0Y+sHYhchdXJOWm5DxWoNgFeQWnAcaCcXOY
         zdFVSCv4Szro6/AsHr9bYJ+84OcOiB9LGtykFcbOXe4UAqxEmfkXjl8WQc3MHfZKMI+4
         KEqTDSlubtHFFWAKrBt9hHVhaa/jemwuOD9/E6bmhvYE8NNTlcNpYh/N/tF+yKLMTosj
         Y080LZhG8EZdvOwJpRLLaYtlKrDq62ZIUlD/1fChck+1vQ3Hm6+X5IM0t0A7YhIeY+Y6
         TgOVhcB2yuPs+KFP0kte7sfBEBXRbWzAfKje2sgRIofLQSYfAe0RnDTShdL/TsxAl3ht
         taBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g1jCPxM2;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g1jCPxM2;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELvxXEf7nVW99EFTa7hx8ZOJwaUESD4J8Fk6P1I7SXiWwa1+Gg71hghhAeNHOaPUETJ/GT7Itnb5ACz/Xa595VA=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CA+55aFxkzxhGaK=sp2CqM1YFEE=fL33wC1TR4KKqsRqPGto6yA@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
 <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
 <20180306080855.phtgl2bzqm5hnthu@gmail.com> <CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
 <CA+55aFwgmTaaA8QqMGm+VzRNbpKxDXbq2MtKyayyq8f+=PqWqA@mail.gmail.com>
 <CAKv+Gu_VaO39h8trgsNhU4JEVkdgoFWGoovBdmAL_YsHe7Nq1Q@mail.gmail.com> <CA+55aFxkzxhGaK=sp2CqM1YFEE=fL33wC1TR4KKqsRqPGto6yA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Mar 2018 21:42:54 +0100
X-Google-Sender-Auth: NridBCSwwoTVet27j41JqkXxSaY
Message-ID: <CAK8P3a0bWWZbFW5AFag=vRKC=PbCbwaLNPNiyk1ziJk=fTe0nQ@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Micay <danielmicay@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Borislav Petkov <bp@alien8.de>, Richard Sandiford <richard.sandiford@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, "Dmitry V . Levin" <ldv@altlinux.org>,
	Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, "David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Mathias Krause <minipli@googlemail.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594222419857944671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 8:16 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Mar 6, 2018 at 11:07 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>>
>> The compiler usually does a pretty good job of detecting which scalar
>> variables are never initialized by regular assignment.
>
> Sure, but "usually" is not really the same as always. Sometimes scalar
> types are initialized by passing a reference to them too.
>
>> We could easily extend this to scalar and array types, but we'd first
>> need to see what the performance impact is, because I don't think it
>> will be negligible.
>
> For scalar types, I suspect it will be entirely unnoticeable, because
> they are not only small, but it's rare that this kind of "initialize
> by passing a reference" happens in the first place.

A lot of the scalar variables with actual bugs are missed by the gcc
warnings, because it never allocates a stack slot for examples
like

int f(int c)
{
        int i;
        if (c)
                return i; /* uninitialized return */
        asm volatile("" : "=r" (i)); /* gcc sees that 'i' escapes here */
        return 0;
}

int g(int c)
{
        int i;
        if (c)  /* gcc optimizes out the condition as nothing else sets i */
                i = 1;
        return i;
}

At -O2 optimization level, these fail to produce a warning, and
they won't ever leak stack data, but they are still undefined behavior
and don't do what the author intended.

Forcing gcc to allocate a stack slot and zero-initialize it should
find many bugs by adding valid warnings, but also add lots of
false positives as well as prevent important optimizations in other
places that are actually well-defined.

> For arrays, I agree. We very well may have arrays that we really want
> to do magic things about. But even then I'd rather have a "don't
> initialize this" flag for critical stuff that really *does* get
> initialized some other way. Then we can grep for those things and be
> more careful.
>
> If somebody has big arrays on the stack, that's often a problem
> anyway. It may be common in non-kernel code, but kernel code is very
> special.

I can think of a few cases that are important, this one is well-known:

int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
                           fd_set __user *exp, struct timespec64 *end_time)
{
        ....
        /* Allocate small arguments on the stack to save memory and be faster */
        long stack_fds[SELECT_STACK_ALLOC/sizeof(long)];

Another case I came across very recently with a similar optimization is:

 int ib_process_cq_direct(struct ib_cq *cq, int budget)
 {
       struct ib_wc wcs[IB_POLL_BATCH];

In both cases, the stack variables are chosen to be just under
the CONFIG_FRAME_WARN limit to avoid a memory allocation
in the fast path. If we add an explicit zero initialization,
that optimization may turn out counterproductive, but a
"don't initialize" flag would be sufficient to deal with them
one at a time.

There is also the really scary code like:

#define SKCIPHER_REQUEST_ON_STACK(name, tfm) \
        char __##name##_desc[sizeof(struct skcipher_request) + \
                crypto_skcipher_reqsize(tfm)] CRYPTO_MINALIGN_ATTR; \
        struct skcipher_request *name = (void *)__##name##_desc

that implements an alloca() through a dynamic array for storing
a variable-sized structure on the stack. These are usually small,
but the size is driver specific and some can be surprisingly
big, e.g. struct ccp_aes_req_ctx, struct hifn_request_context, or
struct iproc_reqctx_s. If we can come up with a way to avoid those,
we could actually enable -Wstack-usage=${CONFIG_FRAME_WARN}
to warn for any functions with dynamic stack allocation.

      Arnd
