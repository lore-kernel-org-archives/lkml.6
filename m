Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELtVToic+01KtQFkxfl4KGzjwxhX5nWY69t5prkVFVrzAQ1jFt8b/2zaqblFBu6Hi3WahpLe
ARC-Seal: i=1; a=rsa-sha256; t=1521646412; cv=none;
        d=google.com; s=arc-20160816;
        b=QdrM+8G5BfjAYAIjOjwEN6ElsCxCvQL4AdveNXSgP1NhCfa7NmWHsPv8Ohb3Kbk6X/
         UqWnNUitD9cseEyIH4Ux+TT0WDmHA4rGAwEsXob1SuxDhInAdX28EbRl9QlOvveGN+Tl
         DEmgLll8wwdEkrW1U8XQMQkUF55fLuiRfNdQOxHVARLU0CeMawjjHBQ7ZHcSzHe9ZBdO
         ors2H0Waj55PIJ0Enh21NeIzJySFiTR6BOfBp1tgvQzjwjJ9Il8oVlFHy2WWQwKJMogm
         eEUuM+PkrJP2fxmDvnJGs1MtqGRQV7lBWv3ZxZjSvEtBXpExpDs5RXIQmljxjR7wRFvg
         qNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :arc-authentication-results;
        bh=03fqh+NeZg8d3ov5Bk+FfUjZJSIIpb9wumj6Ij5t03M=;
        b=f/YW10km8u5ZsbYt2ivVKTIkRNaISQ05K9omSIMZ89RcTS6VWTpoG1gwSjJQkxu2gx
         Zs3AV/qwKcpOA3riDqVn0M1ydhRxeHKOAIKbs9PMfhIph47NP6TEgzxAGWyqtXdXuwTC
         WfDHFIivVEnpiVuUs/Cz8Xq8GjUjtd8MwBuXUOlGDwPgfiG52TGqZSg0snyuXqYtI0jv
         KAafwvdp8Agmhjzn+POzIhq2tY+bJCQR1DExO31E5Sc5MbbV34Eco/tdqAQfwbG2LOp5
         6rpEIKY0gxWo6B/O8dnMglHQCrCKSJDX5/LNe1xbnfAZ+3RB1Dj8t+WBLbe8+6aiiwxT
         dYMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,340,1517904000";
   d="scan'208";a="27232812"
Subject: Re: [PATCH RFC v9 2/7] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
To: alex.popov@linux.com, Peter Zijlstra <peterz@infradead.org>,
 Laura Abbott <labbott@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-3-git-send-email-alex.popov@linux.com>
 <d968e58a-3abd-8e3c-cee3-00c19c1b6430@linux.intel.com>
 <94f268b2-31a4-620a-86ed-325d5bb33c57@redhat.com>
 <20180305202535.GX25201@hirez.programming.kicks-ass.net>
 <e043e0d6-3265-4bc2-ae11-ab430832a8e2@linux.com>
Cc: PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Ingo Molnar <mingo@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
 Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>,
 Richard Sandiford <richard.sandiford@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>,
 "Dmitry V . Levin" <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Garnier <thgarnie@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Josef Bacik <jbacik@fb.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>, "David S . Miller" <davem@davemloft.net>,
 Ding Tianhong <dingtianhong@huawei.com>, David Woodhouse
 <dwmw@amazon.co.uk>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Juergen Gross <jgross@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Mathias Krause <minipli@googlemail.com>,
 Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey
 <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
 Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <295a6830-fce9-ee00-f45d-7dafd74d11a1@linux.intel.com>
Date: Wed, 21 Mar 2018 08:33:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e043e0d6-3265-4bc2-ae11-ab430832a8e2@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947982901315923?=
X-GMAIL-MSGID: =?utf-8?q?1595561907986157922?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/21/2018 04:04 AM, Alexander Popov wrote:
> The main obstacle:
> erase_kstack() must save and restore any modified registers, because it is
> called from the trampoline stack (introduced by Andy Lutomirski), when all
> registers except RDI are live.

Wow, cool, thanks for doing this!

PTI might also cause you some problems here because it probably won't
map your function.  Did you have to put it in one of the sections that
gets mapped by the user page tables?
