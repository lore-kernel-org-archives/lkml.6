Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520372875; cv=none;
        d=google.com; s=arc-20160816;
        b=AoqxmTTp2c6nnazSLz+zfPV/P30MFEtROaJe0q5VLIUxU7s7PlmpncgMS5gI0Gtyhh
         rkvr8YIRlPFaIdV9mxeVj9KrwZRz32T/V6E68cPYKnsb1UvKk1RkkPcxrIo4J8RulY9p
         CbNlBuuQeCou3umql1VZ2dZ2+mjippX9LskqbuxU8Y4o1K4pR7nkfBGAyLDqQSw4hDBg
         uJx1uHCr/ZIoPPiO9JkW5zZQaB3Mm9+6xIV6wD+PygXeZcCdCqJvRJRNuXUqsLy2VKIR
         kyyFxDCJV5sIIhp4kBsQAIm14ev0PrQH26zRIP3pSan+Jc9dbsNgeJdKT+feSXUts2+8
         8Y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=XiuKBqhzR11z8Z38f5IO64TTl9WKPpK2Quwz6HGyON4=;
        b=rOOemubgil/e6uzvznxBcqo+TbXXzWnew7EwNw2JvPDf/Sf74qKKRhd+SG/FwbUhx7
         1DnruzBd9YbamKHNrjmgazjF3Kzoie4J7B4ztNC17UmAs0fzSSRr07S30g9e5NEt8fyd
         R9W8Vu5SCpmjrP8362Aqg70iqAcPhKQKInLbQvzYvUue27vQXoZFnSInbD9bBw01rblV
         6aFagXsUCN0S+8nSeM+QxJpty0AgL0vhXZKJbyEzdH6ZL+LkkueoJiNG4u18/jrKKsAl
         La9FDh6QgzIRhy89Idhmjb7arnMiz2h+JX13IhMX6r10jrQZCef9NMraWpZ9Jhi6m6ln
         QoIA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iM+Ew1TW;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=iM+Ew1TW;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AG47ELumigQ91SsD89DxBEeRsm5SlFDmiQTcAwGAG6+ZoEZ4TeUTNEdVGfQ2KvpAUVsXGrjWqvo8b9sVSzKdZtYs9xM=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
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
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Mar 2018 22:47:54 +0100
X-Google-Sender-Auth: BjR23Fm9Dqr_5PHdCdtP4P7Hkks
Message-ID: <CAK8P3a0ko9E91jok0fSnwQ__vO8nzBpmki768t_-Z9MhZ_f-JQ@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Daniel Micay <danielmicay@gmail.com>,
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
	Josh Poimboeuf <jpoimboe@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>, Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>, Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594226508228080073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 10:36 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 6 Mar 2018 13:01:20 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> Then the optimization passes will just remove the initialization in
>> 99.9% of all cases. Only very occasionally - when gcc cannot see it
>> being overwritten - would it remain. And those are exactly the cases
>> where you *want* it to remain.
>
> You mean have gcc fill in the variables that it thinks is used
> uninitialized with zeros? As long as it still warns about it, because
> that usually catches some real bugs where zeroing the variable doesn't
> actually fix the bug.
>
> I also tried the example Arnd posted with:
>
>
> int g(int c)
> {
>         int i;
>         if (c)  /* gcc optimizes out the condition as nothing else sets i */
>                 i = 1;
>         return i;
> }
>
> And he's right. -O2 doesn't warn :-(  I think that it should.

See this bug that has been open since 2004 and the 31 bugs
that have been marked as duplicates since then:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=18501

I don't really understand it myself, but I do understand that
the gcc developers think this is a hard problem to solve.

      Arnd
