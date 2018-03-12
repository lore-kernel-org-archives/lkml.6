Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520846472; cv=none;
        d=google.com; s=arc-20160816;
        b=n+9j8Vaw4+lhE58/ZCd2OhlV0MS0JMmXHWkAZQeB2mq1G4juzzX5xQNOXe9Q7azfz8
         EegS4A/tx4kHNrwyikKfU0pv/TnS0J+VT7nM+YYw6SutZejN5d9UjOgBLB8kIy8mYPwz
         ippKgDgwlPcWXiR4txDeptdcLtvhvu3o4YNUZN9q3NlXRMZr3jwb0vkjohRCq4Mse+M8
         u6iviFHRMJ9Tq96c6W0R7K7UpJRju1PEhEC9GK8SBOiqwdWmakfLv1T7J9TZC9WkdZfU
         eZ1RhgEiwHMpPALwtbW7l9OAP1Go0vYKZyvyDoVZeVjLwkGRZEbqoyU3gUVf9+Jpag6t
         4Seg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=5eDp9N11AbWKW5YLi8Uzq9r3HAE6vvFesVfXfsXMVjM=;
        b=Q9McxKM0hiSxWkAqN+aMGDBFOIp70gUt9NXOLTsR+Fh3EAbXVzZ1HHtNPw1a8HMcr9
         cqdjAftsFpNs4pwW1ObdGPJ5vGvPJr2bCymb8Huu5d2skurwYOh74Uea/FO39RsH5dWZ
         wExLtpKFMC3k2iqEj5M57juPPJJd5d+ElRm9xHb4Sp6FBa5nplZrsZ4mlyVzYYIln7ln
         ZdAZh//ITJ0DC+zSbuT63x3gDDZl1Lj5GWc7BHNU/jcl7Mpy4b7jnFzfMh4iY5rCc+kt
         rA0QR2uEf3Z63lIIutYN24vTBTwhbx/dTIhMwt+WVZE8S/gvfNFm5Gvn6fSLrE9qZpD8
         89eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QBe1ADpJ;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QBe1ADpJ;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AG47ELvAWpwYKVGaexj3sIei8eZ8sE7XwRydZprwTBeSRdErmnT0JtzRqcD5rg0WXJpnudgcoPcqfw==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 12 Mar 2018 10:21:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20180312092108.d4ajuj7dk2jxgkon@gmail.com>
References: <CA+55aFwgmTaaA8QqMGm+VzRNbpKxDXbq2MtKyayyq8f+=PqWqA@mail.gmail.com>
 <CAKv+Gu_VaO39h8trgsNhU4JEVkdgoFWGoovBdmAL_YsHe7Nq1Q@mail.gmail.com>
 <CA+55aFxkzxhGaK=sp2CqM1YFEE=fL33wC1TR4KKqsRqPGto6yA@mail.gmail.com>
 <CAK8P3a0bWWZbFW5AFag=vRKC=PbCbwaLNPNiyk1ziJk=fTe0nQ@mail.gmail.com>
 <CA+55aFxTdT11pxKL7oscN=2bu8wkiZbZgDfQd_Emqk1Z1Qqb7A@mail.gmail.com>
 <20180306163616.7e3b6e0e@vmware.local.home>
 <CA+55aFze-do7sAvg1=z=Yb4p8J2EJ5Eyr6MLdMbgQKwMrO5hxQ@mail.gmail.com>
 <CA+55aFyv4wDxLQDbzB14HgW8ddu-w2VFteh5JQ57Jkw46mCVAw@mail.gmail.com>
 <20180312082226.ciggxv37cgcazs3j@gmail.com>
 <CAKv+Gu-N8mZNu5b4X_+dv37R6gLKn-3EdX+xa40t2bB6fgVTZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-N8mZNu5b4X_+dv37R6gLKn-3EdX+xa40t2bB6fgVTZg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594723111477183367?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> > Is it possible to implement this "safe automatic variable initialization" language
> > feature via a GCC plugin robustly, while still keeping code generation sane? (i.e.
> > no forced allocation of stack slots, etc.) It should be a superset of
> > CONFIG_GCC_PLUGIN_STRUCTLEAK=y.
> 
> I think that should be feasible, yes.
> 
> It would be worth trying whether the current code can be simplified, though: it 
> currently takes care not to add such an initialization if it can already spot 
> one, but I wonder whether just blindly adding one at the start and letting the 
> compiler optimize it away again is safer.

Absolutely - followed by:

 - a good look at the resulting code generation with a reasonably uptodate GCC

 - a look at the resulting code with older GCCs, to make sure there's no 
   pathological code generation

... because IMHO in the end it is the practical effects that will make (or break) 
any such attempt.

( BTW., initializing all automatic variables might even speed up certain
  optimization passes, FWIIW. )

Thanks,

	Ingo
