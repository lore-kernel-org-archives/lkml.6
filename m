Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520371778; cv=none;
        d=google.com; s=arc-20160816;
        b=P7Er4uY6G1C+JxYkl4Z8ITe3WEmPq/akHBQ5sCGRqc11d3yh/4HKh0N300rKtN+5LS
         oYfo6WgcLok/3+eQfHM4i4KRlwBf9KdPj3bfDS+DI0Wu+kZOux09VqZlHbTnslUVn8rY
         0KuDnitbHZZgoQg8Gkl5nyKpM97+72/EYrEAq7i/Xil+sGuLdzhcKqsXLaUSS7QI8q+B
         224YopgLIqT9SjXj4OupE58BgWmUjHbdQlx/qr/jjyo5Rv0xd5GDkBZjwpAnCf4M9/WO
         fTC2HvU5SU+svNkwDa+ic4hRunvH3QRhJPo7YqxHurmjaaZM2JVp2Ay8DzoHmBq9g39L
         fLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Vx8pzO0qSkj4e4WqZaFluHtaorTxe28EcSP77FcHQTM=;
        b=0c+wxm1+rrCHKHqgvyK4RJhHSanGwA1BedgDlpXLAEfDaxqqWHYx8QVqbAGckmNr/P
         E+W9FcamL+NRtC/y9Qalpmwk89OfuZHKubL61D9NcradkP3AX2Wr8xVTs4XxiNRwkFAe
         N+SnPH/lP/e3jnKg6fDqY9YtsT8YGl8URZ6nvvXleC+ZSByHRw0syG/+qiN1AQiUCk9D
         ZhRNb3S9jZwkxSutiXfkA7sfqedmQ3PsMEshjwJ+/EG0Zg/YToQU4SC3qqbkiXhP1pXm
         ssDLyLrE5isxlk553JaheUzYc4lB4EBlqoIUSxxwl/1dlNrQphJ9VlvfUxsFRfkWiAoT
         j/Rw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KQU+fJPx;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=eIz9LjU2;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KQU+fJPx;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=eIz9LjU2;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELtZB9wthGC/UVfbNComBUMAR+BOtLICXGjGo881wC0ZYe5UGzHttTnRskiq0KGJcw8eKq6Szh98owpB9DAkJJ8=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAK8P3a3BA2BueHOuOiszEzkBtA80QDdo3wgX+62=KXCdi9wScQ@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
 <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
 <20180306080855.phtgl2bzqm5hnthu@gmail.com> <CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
 <CA+55aFwgmTaaA8QqMGm+VzRNbpKxDXbq2MtKyayyq8f+=PqWqA@mail.gmail.com>
 <CAKv+Gu_VaO39h8trgsNhU4JEVkdgoFWGoovBdmAL_YsHe7Nq1Q@mail.gmail.com>
 <CA+55aFxkzxhGaK=sp2CqM1YFEE=fL33wC1TR4KKqsRqPGto6yA@mail.gmail.com>
 <CAK8P3a0bWWZbFW5AFag=vRKC=PbCbwaLNPNiyk1ziJk=fTe0nQ@mail.gmail.com>
 <CA+55aFxTdT11pxKL7oscN=2bu8wkiZbZgDfQd_Emqk1Z1Qqb7A@mail.gmail.com> <CAK8P3a3BA2BueHOuOiszEzkBtA80QDdo3wgX+62=KXCdi9wScQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Mar 2018 13:29:37 -0800
X-Google-Sender-Auth: YE_M6plm6V96HjKnwoI4wYCvqHw
Message-ID: <CA+55aFxeJ-6JB-DeZavyzeAYrcdjM=5tMM5dMxvNgT5WJLfQMQ@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Arnd Bergmann <arnd@arndb.de>
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
X-GMAIL-MSGID: =?utf-8?q?1594225358104241055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 1:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Right, there are two separate problems: the missing warnings
> and the actual uninitialized use. Allocating the stack slots would
> address both but only at an enormous cost. Assigning a value
> would still have a cost, as it would prevent certain other optimizations,
> and it wouldn't help find the missing initializations,
> but the cost would obviously be much lower.

What possible optimization would it prevent?

I cannot think of a single interesting optimization that would be
invalidated by a trivial initialization of 0 to a scalar.

Yes, it can obviously generate some extra code for the "pass pointer
to uninitialized scalar around to be initialized", where it can now
make that stack slot be initialized to zero - so it can generate extra
code. But disabling an optimization?

What did you have in mind?

                   Linus
