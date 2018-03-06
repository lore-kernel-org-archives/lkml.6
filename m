Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520372832; cv=none;
        d=google.com; s=arc-20160816;
        b=XCapY5JVNL1x7lpw6pcrKatlxzm+rU05W1N5LVeQaAzmai99ovF1zEcWQh4wf3UTvx
         x8WMI6boORe/QjcxtFz3tqeU3lNaAmURNvEAFtKs/suIyguagL1EaeUd1mDV35bPUt7z
         HFdmapXmOoi4iwjtxkltpHoAYFTyldrJyZSaJn/+oQdaAtHPDnHslkrSvBD1hPywi2Mt
         CDwHajy8Bx+cjBAdEkzot1HwOWZZworJ48yMSAYMIepdasXrl+vcrnQuVewfhZWevpzF
         KNVrGZd/ibtHY21m6soSQmCkU8CR4Xb9Vwcg0l5kBWKxhSC6REstVV5bPJB/2tnJToyx
         VYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=SQK5txUxhheUu3cbmvRNTWhJ55z55jhQz/qqqE+rSgU=;
        b=gR6i0ogyI4mtkbjNC9gsSi0Tl6M/wuAC+qnB1ItUijqArGlvtQ1/JjXJ9uKHo173xo
         jukkJN1/yUHiCszvDyPyKVa+0A4wSvUw6V1cuWbK1dFcjdcxNOhZp+S6E73TcecRTIZC
         ZJQohrud+0Fd/igeNvqG5zpOn8GJ5nmF+2FiYqXZfo6VMYC6Wg1cTqKMlUvgIatJeSlp
         DloKZuldUrrzbNJ9cXtsmcjalatWqJZ4F5uBfo4AnXqnnp+n7ylSItpw7Ar1A7zlAswt
         MVKVfNWf6fTrYshQ9567M6zBJCn0bOjRx7htKZHqRCd+N4RKr/uxmcPSriZGghruUXiP
         T7jw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BTPmPoEN;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=UwMh6+ko;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BTPmPoEN;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=UwMh6+ko;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELvW33hK3O2XEHDPji3A7odnwStaYJhAQBShvtO8HJtTH7nnCDQtJw/ufOXMdOiRmryrbvUUdtVj466mQCJ+DKY=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFze-do7sAvg1=z=Yb4p8J2EJ5Eyr6MLdMbgQKwMrO5hxQ@mail.gmail.com>
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
 <CA+55aFxTdT11pxKL7oscN=2bu8wkiZbZgDfQd_Emqk1Z1Qqb7A@mail.gmail.com>
 <20180306163616.7e3b6e0e@vmware.local.home> <CA+55aFze-do7sAvg1=z=Yb4p8J2EJ5Eyr6MLdMbgQKwMrO5hxQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Mar 2018 13:47:11 -0800
X-Google-Sender-Auth: Dh0EKEe9g53BdiBbdpVV1UIx0og
Message-ID: <CA+55aFyv4wDxLQDbzB14HgW8ddu-w2VFteh5JQ57Jkw46mCVAw@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Daniel Micay <danielmicay@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Popov <alex.popov@linux.com>,
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
	Josh Poimboeuf <jpoimboe@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>, Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594226463420597590?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 1:41 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The warning would remain for the case where you don't enable this
> hardening feature, so it wouldn't go away.

Side note: if in ten years we'd have a minimum gcc version that we
could  just unconditionally say "auto (scalars) initialize to zero",
then we'd just make that be the *semantics*, and the warning would
obviously simply not ever be an issue.

But that's no different from "static variables initialize to zero" and
nobody sane expects a warning from that. It's just what it is.

But that's at least ten years away. We tend to support disgustingly
old compiler versions.

               Linus
