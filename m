Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520372483; cv=none;
        d=google.com; s=arc-20160816;
        b=z7oHAm/HY9oC/jV4PwSeCTlcf9mY76PSMyuSDPULw4yg1Aite3LKAZAqQbR3WP6ByO
         /+7KLJXIHVaL5oUxYekAOTtm+03yCBtFkO2iQud4iyPuUet6i1h1NYZePKDBQ/YZKvGe
         2VShp8sNl2oFiie/DEYqlE+GZVYJMtg8s9a6UVa7z5Mw0nHrc9/P/G51+BzmXokkWN1w
         5WRYYymt5oRsw0+T2t44rWzoXsBV85U3ZuHD8ej8bW5T60mP2eeCR/5HIAAnih7FCYc2
         gT4dcrRRCGGam4e+8o4SS7LW1jcd0KeSPJcZHvQmWLimV4lOnXccpMFuRP2WAvu0JwT1
         NLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ElAshBtn0M52Gj6SxJE41lv5TibK3iSu3LnW+M3hufs=;
        b=brvIM4vt2XKwHYzVCgwxpqaM8W6Wyu5MHS5vMHlzZGXTRnHIhe6g9bh3pr1ek0T27o
         RzzjEw1IWAiHG0byYFFoyRcy3+0G/rgLOp4xn/KTmOBbMCpv8uYShes/6lDECQQeGzd/
         wEZmNXWNfsUy607QoXtiI0XuZWep+ORXCYxJfjrZ/nRNKfJvabnRKIqEzjJf7pql3BQF
         DEk3Kp4/r9K5OhhZQSJJIhlqVpoyAN7UOmkNq05eCTaO28Erh1wHhC75Yf4tiFSo8eJa
         tjY95Y19A9R4X5OGF31tWlgtQlFHGe4A4tefK0uaG7QOYQYDkTa6c/dyANmeVST9QBnY
         u0Jg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WxNSO5zs;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=LqOGbrhE;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WxNSO5zs;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=LqOGbrhE;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AG47ELtNoGtw6RmBl7WZvP+PkfEB3IPIRCU+VL5Px7MIQVglMsQx25cwaGhQPDIjs9B6v2rwV4MojMEziUVbZ52crbE=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180306163616.7e3b6e0e@vmware.local.home>
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
 <CA+55aFxTdT11pxKL7oscN=2bu8wkiZbZgDfQd_Emqk1Z1Qqb7A@mail.gmail.com> <20180306163616.7e3b6e0e@vmware.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Mar 2018 13:41:22 -0800
X-Google-Sender-Auth: wD7_CwcI6xpaMloMNUzKaDv2AjI
Message-ID: <CA+55aFze-do7sAvg1=z=Yb4p8J2EJ5Eyr6MLdMbgQKwMrO5hxQ@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1594226097727694116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 1:36 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> You mean have gcc fill in the variables that it thinks is used
> uninitialized with zeros?

No.

It should do it unconditionally.

Because "gcc thinks is used uninitialized" is simply not good enough.

The warning would remain for the case where you don't enable this
hardening feature, so it wouldn't go away.

The warning also wouldn't be *improved*. The warning is simply a
completely a separate thing, and as your example shows is *entirely*
independent of the "make all locals be initialized to zero".

                  Linus
