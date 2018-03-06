Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520323740; cv=none;
        d=google.com; s=arc-20160816;
        b=v6HaWCNlkTGQquDgR2+hQoP2KjcP1AwBJ2YJRhvFBPwXU6Y2l/avegBgsR0Mi+OW8c
         DIaUbEu3Dvvz1O+3l604dLcQqpFhCQ1DQYfnZeiCAOK1U9D2MVI8ABZh+KFHxtyfQjVB
         b1Bd9s3RQGa5qklYOrZpbIKv+UbOc2fRSJjWvsasEwpgOcE5HGDTo3Hiwra3azZfvMTM
         WIDFfzrZDwwAVSzEKFfDJudT7mfKA/66P2h+e9DKikwmjmEYRiNAmcjt66/5BhBRsNgX
         gaE53w97wYDpnIJtrRTOS6/671UPTCWYfXQCSRbkSGbnC6r+rLuiP3G/Ht2NhRI56U/X
         WJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=98wFVxjzQRoANJo8ccApufiXJicmM2wSSNmLDECEcRw=;
        b=t3Q1ZXdH6/z7WBHSCPBL67vwk1pM3EsTfouEgLFmMUYxvHGVRRWs98wfz3DdZopXdQ
         0JCPb9viufZdQXalJkTfwu1gLCC21xlDA8A3GZuoes0fCu1wLX8rox7fvEoArece8McE
         RL049B5CuB4Bz66YPKv93pdYMRn5B5Qks+XcxZWqzfVLC939+xJk3kqqctOZf3EMGYcL
         G6MHnZGVVa+mxpYYccXybhTiHBJ4XqsSbQYSwaYGEOmIHbIsw0QvoBYSKo2HfzyobV7J
         7RVRWp+Gw/vOOOg7uEBWikDammEkY6GI/C46wdWQhpkqv5mSaepEGxb1hhWlPS5MrtVM
         ljQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZnE2hq+K;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZnE2hq+K;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com
X-Google-Smtp-Source: AG47ELueP6dBZ0tPOLQVZRv8+aYVtQKegtYuRQfZn/su9oJPozb8VMDFZ27A22UkDvErz/f/8jBadw==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 6 Mar 2018 09:08:55 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>,
	Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
	Laura Abbott <labbott@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Borislav Petkov <bp@alien8.de>,
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
	Steven Rostedt <rostedt@goodmis.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mathias Krause <minipli@googlemail.com>,
	Vikas Shivappa <vikas.shivappa@linux.intel.com>,
	Kyle Huey <me@kylehuey.com>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in
 syscall_trace_enter()
Message-ID: <20180306080855.phtgl2bzqm5hnthu@gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com>
 <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
 <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947986518331727?=
X-GMAIL-MSGID: =?utf-8?q?1594174986698732662?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Kees Cook <keescook@chromium.org> wrote:

> [...] We've already seen multiple cases of this just with the by-ref 
> initialization plugin, where a stack content leak goes away because we asked the 
> compiler to please initialize the memory for us when we forgot to do it 
> ourselves. Getting the compiler to help us seems like the obviously correct 
> thing to do, since we're using such a memory-safety-unfriendly language. :)

So the question is, are there any known classes of stack content leak that the 
following .config options:

  CONFIG_GCC_PLUGIN_STRUCTLEAK=y
  CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y

... do not handle, and for which leaks the best solution is such runtime stack 
clearing?

Because the GCC plugins clearing automatic local variables are _way_ superior:

- it's probably a heck of a lot cheaper to clear structs than it is to clear the 
  stack in every system call...

- it's probably also safer statistically, because if there _is_ a reference to an 
  uninitialized piece of memory in the kernel it will be to zero, not to a user 
  controlled value...

Thanks,

	Ingo
