Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520842950; cv=none;
        d=google.com; s=arc-20160816;
        b=Hpty3qckcEQDNHtjQMLHdfaTblSgM4qd2HM3YiNpiUrm7DAy3trC0LbU0qJF04Z3iH
         9Dlt32t9oLeIR9j9opldLobVwPm0t7GFJU89wIjVWGTnYFSKeGs+gEgXiRlB9t/OmgRq
         cVtZ6BXtdWxeCkGaj36ZH2SsJwlACtuVRQ8GyR4A9uNmHzBTeNgGbNdGaqw+omgcQ6Ux
         EmoTMmSAxlyTSs3kWlL/vLlqDbWEMt/2RLJOgr7OLF9I7vOlPTEayNmEPzCeLGmk2Ucy
         ++AvEHP/0hg0+WW559tp9A/oJJK0hUolRq1aWmYRewbPkwB9eg3lz5lxvf+2xx/bdK6i
         3tZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=ChrSk79yj12AnuF/rBGvLj44LUIWr7p8dIBGs2JSvP4=;
        b=b9maXpWxKAEdPLGFa5CZwikJRZlE7ZmKKPHLEKSrMwiXpaQFuKJ6eaJSMOH3uNvt+3
         PIWmacUiaUl2pm5bfRBHCpZzHwznuvJX7J5f1tZBr4gAAdt/CldKXbp9GYqUgafrjf/E
         fgEgKv/Uk7Zp8aUNriL/iiOsV8qcWPyL0zRzLLlOtlrUny0x4PkIoDhlKvL0l1IspuWb
         GWVyiUU4pabqi62297g3ckBC5MO9b5haq0Ytj37uwSHxnXvrJKGTFVYrXauqo2BKxZeu
         lGHIpENfeyFFE+DzGmzIHgjcVUiPiI3+iuHdbO7KM0CAlJR/GyKFNQMc7+k0QUFdA4yt
         kTiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=crpwcj9y;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=crpwcj9y;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AG47ELsvtmD7MgupZvlkuUF9IsyNPizAQA28IF5bx66EahRMmQDb8LNX1L/ad6p8ZJUWowzzclFshA==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 12 Mar 2018 09:22:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Daniel Micay <danielmicay@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>,
	Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
	Laura Abbott <labbott@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Dmitry V . Levin" <ldv@altlinux.org>,
	Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Garnier <thgarnie@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Ding Tianhong <dingtianhong@huawei.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in
 syscall_trace_enter()
Message-ID: <20180312082226.ciggxv37cgcazs3j@gmail.com>
References: <20180306080855.phtgl2bzqm5hnthu@gmail.com>
 <CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
 <CA+55aFwgmTaaA8QqMGm+VzRNbpKxDXbq2MtKyayyq8f+=PqWqA@mail.gmail.com>
 <CAKv+Gu_VaO39h8trgsNhU4JEVkdgoFWGoovBdmAL_YsHe7Nq1Q@mail.gmail.com>
 <CA+55aFxkzxhGaK=sp2CqM1YFEE=fL33wC1TR4KKqsRqPGto6yA@mail.gmail.com>
 <CAK8P3a0bWWZbFW5AFag=vRKC=PbCbwaLNPNiyk1ziJk=fTe0nQ@mail.gmail.com>
 <CA+55aFxTdT11pxKL7oscN=2bu8wkiZbZgDfQd_Emqk1Z1Qqb7A@mail.gmail.com>
 <20180306163616.7e3b6e0e@vmware.local.home>
 <CA+55aFze-do7sAvg1=z=Yb4p8J2EJ5Eyr6MLdMbgQKwMrO5hxQ@mail.gmail.com>
 <CA+55aFyv4wDxLQDbzB14HgW8ddu-w2VFteh5JQ57Jkw46mCVAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyv4wDxLQDbzB14HgW8ddu-w2VFteh5JQ57Jkw46mCVAw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594719418310411853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Mar 6, 2018 at 1:41 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The warning would remain for the case where you don't enable this
> > hardening feature, so it wouldn't go away.
> 
> Side note: if in ten years we'd have a minimum gcc version that we
> could  just unconditionally say "auto (scalars) initialize to zero",
> then we'd just make that be the *semantics*, and the warning would
> obviously simply not ever be an issue.

Btw., I'd suggest we initialize aggregate types to zero as well, and then work 
from there by marking exceptions via attributes.

>From what I've seen over 90% of 'tricky' initialization sequences either don't 
matter to performance, or are unnecessarily complicated.

I.e. let's eliminate VLAs and let's also make the object initialization aspect of 
the C language reliably and broadly safe by default (via a GCC plugin) with no 
exceptions, and allow an opt-in mechanism for more fragile (but faster if coded 
correctly) constructs.

Is it possible to implement this "safe automatic variable initialization" language 
feature via a GCC plugin robustly, while still keeping code generation sane? (i.e. 
no forced allocation of stack slots, etc.) It should be a superset of 
CONFIG_GCC_PLUGIN_STRUCTLEAK=y.

Plugin support is present in GCC version 4.5 and higher, correct? So if such a 
plugin is possible we could raise the minimum GCC version to support it 
unconditionally.

I suspect a fair chunk of all kernel CVEs would go away if we fixed the C language 
this way.

Thanks,

	Ingo
