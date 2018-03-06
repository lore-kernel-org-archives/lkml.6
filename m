Return-Path: <ard.biesheuvel@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520363261; cv=none;
        d=google.com; s=arc-20160816;
        b=mAezUwvJckgm8cAWU9MsvlVtb8hzObJMap3olPm9OdjdRppAld6LqsOMpd4E/kboJ/
         b7CyykPs6xQvcgXKxEuj9KydsZiBD7LNpWvuOGFemfY+1dtK3otfLC8+dyhkgzetrekn
         h/l5czjUUpgaL0c2ziNEudeMlg0H/AX+LnRtDfPpQp1tlfGe6kEHRqdPThaRfrNZoQj9
         0izBaPx1nJSWYi0qs/t1vqzcyfgGXeCFDX/Ewtd+Gg8oWv079ZLHCQ1J+st4ik2qpP6z
         7NUlC7p/5XlebkMOHUqUfnlHeOpIQzVxYFkDHGn6M4Z71JTh1h5Dby2izQaoZHSV4UEL
         5a5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=b+cocFvYG+16FLXD1EzchZugSzHlURhE+W9d+hez1lA=;
        b=WKZFTBOgZ9t987dfBBRJW6TB2YAz2tE6WPn+jafkRnVVdBBxBl9y80I042Tz5d2By2
         2ZTaM/yfUZ2xgd5yDKVb2xMtQkkRi9xVShphQ8HbWfPusBlo1Py9qN5Z4gH0Q0xs6hul
         kj65tpGc7ICA7LgfIZLvBqTDdLxYta7C0Gv9wYQffz0TcxrGJZ4Q1ddRl1bi+nuM1F2z
         MVdZSgRfwpl+OFmbMSOSoklZcO7VVMBR6fHweHBfxhhP7fRvWXXQDjCO48hH6iwGxfJr
         7Ev/zyxz5NA5lEaOk39F7M4Bkk6JNbWb745ZjO0wkcyUZh+Z3moEh3dgIiEuZAvoIbSN
         8dkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GArLQJ9j;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GArLQJ9j;
       spf=pass (google.com: domain of ard.biesheuvel@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=ard.biesheuvel@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtpBg3iRy6t446Lrvit3x350xJCicbJSRftbG0dhwFDWHC7A57LaP8b025Ls3WCWaOlhRFQaC70rOdCe8n9Bl4=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwgmTaaA8QqMGm+VzRNbpKxDXbq2MtKyayyq8f+=PqWqA@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
 <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
 <20180306080855.phtgl2bzqm5hnthu@gmail.com> <CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
 <CA+55aFwgmTaaA8QqMGm+VzRNbpKxDXbq2MtKyayyq8f+=PqWqA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 6 Mar 2018 19:07:39 +0000
Message-ID: <CAKv+Gu_VaO39h8trgsNhU4JEVkdgoFWGoovBdmAL_YsHe7Nq1Q@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Micay <danielmicay@gmail.com>, Ingo Molnar <mingo@kernel.org>,
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
	Josh Poimboeuf <jpoimboe@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Mathias Krause <minipli@googlemail.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594216426928795489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 6 March 2018 at 18:56, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, Mar 6, 2018 at 7:16 AM, Daniel Micay <danielmicay@gmail.com> wrote:
>>
>> Zeroing locals isn't very expensive because the compiler has a chance
>> to optimize it out when it can figure out it isn't needed and they're
>> almost always used.
>
> I thought I saw Kees with some stats, and it wasn't even noticeable.
> But maybe I mis-remember.
>
> I definitely like the "zero local variables", and would actually
> prefer something even stronger than GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
> (although I can't actually read gcc plugins, so I'm just going by
> name).
>
> It's not necessarily just struct, it can very much be arrays and
> regular automatic variables too.
>

The compiler usually does a pretty good job of detecting which scalar
variables are never initialized by regular assignment. The reason that
this is different for struct type variables is that we often
initialize them by passing a reference to a function, and if this
function is in another compilation unit, the compiler doesn't know
whether such a call amounts to an initialization or not.

We could easily extend this to scalar and array types, but we'd first
need to see what the performance impact is, because I don't think it
will be negligible.
