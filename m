Return-Path: <danielmicay@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520350103; cv=none;
        d=google.com; s=arc-20160816;
        b=grMpMzA33uZOEJQbit2YP+jfZZxcOsXR54IlO1MW2xfW14ysZdecyagYrDBJSQGgd6
         KQq497NH1rlJGVabwzkAFSsRsal4alQuoxVGzPZZvuQTszWKAvlNF28wZL4kBW8TyvwB
         dGNah1PEtg2RAN1m+gaPMCkYgbbwyiKamNz52Ji5Zw63muSNihA0woSGqMtmkrD/ymlH
         2IOzNCF2F2SrV8ek2ZXK3+78IuJjePKxkslf0HPepzedjG+7q9/LaOQuvfyWVIeywLJy
         RscSeoumrFSrxwANGAHVDQTwjIb+y7SQOIDVZ2wT0eqjer5Ahogw3vH6Sp23p+lW3X5R
         tfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=eCwyFpdfM6/94pViCxl2Vbb+SzAP1zYKhDmLSpknBlo=;
        b=efqb3UMgiGV29h8oqNWnx/GmyLXaGhaebJobl+cm6WGB2ezxzik0hYnhOzXOJDxb9P
         0MUrT8yJ2XiWiV0QhOdb25vJjxnoIVMwMTHSmBCgQjcDB6z0FH+ij567B+LdjXCxKIhh
         u5gugA0JvWAn7nR5jI5BM7rfhC9ufk9ebQ7OvDWPQ33j7ygXVC0BW0/3pH+jjKlyQS2Z
         Z80AgToOZt7JwaiswC/ho7WtCKToT9RQUlGvQIuXumu0d6i3R+JZC6TwDa4/xb9jNGF9
         yfdsJingmIVcpUbtpPF83nW3JBoOjW+2k6ZgNYPZh6q0pCH1F6zda4vY6yoiEwiuD0et
         HswQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o6MySV8P;
       spf=pass (google.com: domain of danielmicay@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=danielmicay@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o6MySV8P;
       spf=pass (google.com: domain of danielmicay@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=danielmicay@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtcRsJH0E6oWvEKIM1b1wggl51lDqm4ktI3idCJsb0vsq+129q6XshkcBlJNV2euQ37KDfLkBtiB14/wHwQUAc=
MIME-Version: 1.0
In-Reply-To: <CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-5-git-send-email-alex.popov@linux.com> <b52a2cca-cb5c-d47f-131e-7db297f78958@linux.intel.com>
 <CAGXu5jLRpJ7ktij4TpaSG-RZLOou=RWyY_=jTMNE87+E4Xp2Ag@mail.gmail.com>
 <CA+55aFxEAYyrUkApo-dtZvxcYbvWBZJpUytjbm7e2wruTvbYjQ@mail.gmail.com>
 <CAGXu5j+-AjMKxOYDOpbmJ4X357JRGWViAOmqyqd6bu_w47mffw@mail.gmail.com>
 <20180306080855.phtgl2bzqm5hnthu@gmail.com> <CA+DvKQ+uQD0qyMvwqaRd_sMLBHE5q9pcfOQ+VknBW2==q0NJJA@mail.gmail.com>
From: Daniel Micay <danielmicay@gmail.com>
Date: Tue, 6 Mar 2018 10:28:22 -0500
Message-ID: <CA+DvKQJrqk6hBKkN3eObgnAwy6i1QjHOBt-LvfjV7nL4m6aJYw@mail.gmail.com>
Subject: Re: [PATCH RFC v9 4/7] x86/entry: Erase kernel stack in syscall_trace_enter()
To: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, Alexander Popov <alex.popov@linux.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>,
	Brad Spengler <spender@grsecurity.net>, Andy Lutomirski <luto@kernel.org>,
	Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>,
	Richard Sandiford <richard.sandiford@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"Dmitry V . Levin" <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
X-GMAIL-MSGID: =?utf-8?q?1594202629722214818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel could use -Werror=vla-larger-than=2048 as a stop-gap and
work around all the errors by making sure it can't be larger and
reporting an error or adding `BUG_ON(size > limit)` to prove it to the
compiler if necessary. It warns if the VLA *can be* larger than the
limit, unlike the frame size warning the kernel uses only warning when
the frame is *guaranteed* to be larger than the limit. It wouldn't be
a guaranteed to work solution since a function can have other VLAs,
etc. but in practice it could probably be good enough. I've tried it
and I don't think it would be that much work. It might save someone
from a vulnerability that isn't using VMAP_STACK even if the issue
gets fixed for that.

Android kernels are likely mostly going to be compiled with Clang now
for 4.4+ and it doesn't have a similar warning though. I mentioned
last year that there were some real vulnerabilities caused by
unbounded VLAs:
http://openwall.com/lists/kernel-hardening/2017/05/12/33. It's fairly
easy to flip up and accidentally use one especially for people that
work with other languages. Maybe the kernel should already be using
-Werror=vla and overriding it for the few cases that exist to stop
letting people introduce more.
