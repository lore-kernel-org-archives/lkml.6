Return-Path: <SRS0=toL7=F4=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AG47ELvaLbfsVLAMRKmmTImE+oQwpucUR/B5Nct4xUM908aKGdUEFKm5xvszJLXACm46GqEM9b42
ARC-Seal: i=1; a=rsa-sha256; t=1520376734; cv=none;
        d=google.com; s=arc-20160816;
        b=g/8s3wpfaE2OcIxxD3qI1RMaHEtHWHu8srdFR56x7chs5KZzuKH3O0VjQan1Mu1dT6
         xqG83YR85g10zeBrsrDNr0tcNhDCM6KmIeJPvvSqsK1aWEqOy2Uwv65VgTM/SI6CKvP0
         5N3mUCfltE6FztuvDRUR5K4cj5hnAnTP2kCSeFhSb+gmO96uEJ5d6CIupSrTz9A1w9Uz
         pTl9COyCZW7aQOA8mRW2TrnzfQTqlFdLkd8LtznldDyt0mrVSc9Xq2CLk0seqwjmZ9Dw
         aGuKA1hYnK23GFSOwGax8E9D6XKxyhMuXcqSXxNkC+dsaeRtddMpVyTszZgi9k23Q7VX
         2BCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=DjWBG+DL3FVAyA+zCkJmLui8C0L7f6rxNF4bFy99coE=;
        b=zJIMd8x53MTuED4HPWyNoROXEssqK85DOoPb922+SBvF2Dlu/2rGHhJoPiNlNINcjm
         GjRAiY6BCVYZC9Fbuf9hNvDUodOa1PxKpaDHPPcgDjOwY0rin9vD0sD8C2Eb+DJzKHNI
         qz5SLdW7wqXvel5R97o1qDqS3lahKMemSScl6OStGBCK8T6RvZXnhxeqvPPktecTrbQT
         wOnk/eegdsrsFV/mspffjQbYC6GzGDnSSzjOXVT9tgLP3u/PfEghZtHtJxzJmDUo2KR5
         CD9VwT+Ui62SbhIX/SZc5uJx9m9dj96S8vXeRqBoHG99UQrnVtu80j/1EOqQAywMsHDe
         wNaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=tol7=f4=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=toL7=F4=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=tol7=f4=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=toL7=F4=goodmis.org=rostedt@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C6F2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 6 Mar 2018 17:52:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel
 <ard.biesheuvel@linaro.org>, Daniel Micay <danielmicay@gmail.com>, Ingo
 Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Alexander Popov <alex.popov@linux.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team
 <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Andy
 Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>, Laura Abbott
 <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Borislav Petkov
 <bp@alien8.de>, Richard Sandiford <richard.sandiford@arm.com>, Thomas
 Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <a.p.zijlstra@chello.nl>, "Dmitry V . Levin" <ldv@altlinux.org>,
 Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andrey
 Ryabinin <aryabinin@virtuozzo.com>, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>, Thomas Garnier <thgarnie@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov
 <ast@kernel.org>, Josef Bacik <jbacik@fb.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Al Viro
 <viro@zeniv.linux.org.uk>, "David S . Miller" <davem@davemloft.net>, Ding
 Tianhong <dingtianhong@huawei.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Dominik Brodowski
 <linux@dominikbrodowski.net>, Juergen Gross <jgross@suse.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams
 <dan.j.williams@intel.com>, Mathias Krause <minipli@googlemail.com>, Vikas
 Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey <me@kylehuey.com>,
 Dmitry Safonov <dsafonov@virtuozzo.com>, Will Deacon <will.deacon@arm.com>,
 X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in
 syscall_trace_enter()
Message-ID: <20180306175211.5584cc28@vmware.local.home>
In-Reply-To: <CA+55aFyuQZ-cYxPeGF2VJu2GjzznQTua6sVBi4+CFdUi+=+Ajw@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
	<CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
	<CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
	<20180306080855.phtgl2bzqm5hnthu@gmail.com>
	<CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
	<CA+55aFwgmTaaA8QqMGm+VzRNbpKxDXbq2MtKyayyq8f+=PqWqA@mail.gmail.com>
	<CAKv+Gu_VaO39h8trgsNhU4JEVkdgoFWGoovBdmAL_YsHe7Nq1Q@mail.gmail.com>
	<CA+55aFxkzxhGaK=sp2CqM1YFEE=fL33wC1TR4KKqsRqPGto6yA@mail.gmail.com>
	<CAK8P3a0bWWZbFW5AFag=vRKC=PbCbwaLNPNiyk1ziJk=fTe0nQ@mail.gmail.com>
	<CA+55aFxTdT11pxKL7oscN=2bu8wkiZbZgDfQd_Emqk1Z1Qqb7A@mail.gmail.com>
	<20180306163616.7e3b6e0e@vmware.local.home>
	<CA+55aFze-do7sAvg1=z=Yb4p8J2EJ5Eyr6MLdMbgQKwMrO5hxQ@mail.gmail.com>
	<CA+55aFyv4wDxLQDbzB14HgW8ddu-w2VFteh5JQ57Jkw46mCVAw@mail.gmail.com>
	<20180306172927.7a975cee@vmware.local.home>
	<CA+55aFyuQZ-cYxPeGF2VJu2GjzznQTua6sVBi4+CFdUi+=+Ajw@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594230554973847407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 6 Mar 2018 14:41:55 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I'm literally telling you that lack of variable initialization is
> almost purely a bad thing. C would be a safer language, with less
> undefined behavior, if it just made the initialization of automatic
> variables be something you cannot avoid.

I get your point. Basically you are saying that the language should
have forced all local variables to be initialized to zero in the spec,
and the compiler is free to optimize that initialization out if the
variable is always initialized first.

Just like it would optimize the below.

int g(int c)
{
	int i = 0;

	if (c < 10)
		i = 1;
	else
		i = 2;
	return i;
};

There's no reason to initialize i to zero because it will never return
zero. But what you are saying is to make that implicit by just
declaring 'i'.

Other languages do this, and you are right, I don't expect warnings to
appear in  those. I guess I've grown so accustomed to this "undefined
behavior" it's part of what I just expect.

-- Steve
