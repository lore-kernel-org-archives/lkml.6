Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AH8x224BAk0VznevOij+dEU7GwyHCh9VfjM7VO+vbjsKqu6cbUwEVJnCJfmjrFFsxFofckSRTMRv
ARC-Seal: i=1; a=rsa-sha256; t=1518599344; cv=none;
        d=google.com; s=arc-20160816;
        b=IqYzYlMcG0hjKpdo1lwQhjPj5i7MKrhdLcmqqbbJb/S/1fmD3sHMv1GHUQZyKWumpy
         7im5tWZYq+Ioq9PLwSwJ17s19S3MWM0NBTSaHMzOlf972rF1OuzRiPMOjN7t5Fd4/YBq
         1V4Yo+iAv7fHPgvaiSQMxttZod0lTSg0FIu01cuIu6AbYWOidSffcUVzOQYmZ0sBhH5n
         eNJ+/XnAKxdXXckVrwelDQ+ST83KpRfoqXRUoXss9QYnvmAvQIPIZ2/nMfQ+1saJ+AXw
         7IFHGhKVGBq9Y8kOUvhbiCUNI24R4Hyj/bQaq45gbAVHSsmtXBMplsHjnSNppP3Z9Cuk
         1LBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=pJ7421Wcj5WAjkT3LI8zH7szI1bYyFWAE9REdjfgQaY=;
        b=PthPcSxyeRwSLBNdgaCJFu+Gw2SSDc08tW3lgc5+01BMtPzIYSIgx11Y9H3gH997ag
         qXBGgWhVMklne35IZNvlSlTYr1bH2u7sa+hdSLoZAa68QG0+rwlw0/46XDiezOiQzi7v
         QFolYDgfLLLx73Zk2WNk5SP1pAaMnwNvBG7plE0CYNWOzt13qrj+IuWTFCHxWM6xYdSp
         5I/KhEm0mCQK0Mfoq8p63LKMT0LyZ97XFq81f6hPU3ByJ2FDbT0L3HF++iTqW24lkHEj
         jTMvrp2Wt3W5akWgc1wnClPIppzjf1AVn4zYYfuLSuHuVQbvnkymyXw8Odo8dNMJkS6e
         F2WA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=AqqQys0S;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=AqqQys0S;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Wed, 14 Feb 2018 10:08:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Yatsina, Marina" <marina.yatsina@intel.com>
Cc: Kees Cook <keescook@google.com>, David Woodhouse <dwmw2@infradead.org>,
	Chandler Carruth <chandlerc@google.com>,
	"Kreitzer, David L" <david.l.kreitzer@intel.com>,
	"Grischenko, Andrei L" <andrei.l.grischenko@intel.com>,
	"rnk@google.com" <rnk@google.com>,
	LLVM Developers <llvm-dev@lists.llvm.org>,
	"ehsan@mozilla.com" <ehsan@mozilla.com>,
	"Tayree, Coby" <coby.tayree@intel.com>,
	Matthias Braun <matze@braunis.de>,
	Dean Michael Berris <dean.berris@gmail.com>,
	James Y Knight <jyknight@google.com>,
	Guenter Roeck <linux@roeck-us.net>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Rik van Riel <riel@redhat.com>, Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>,
	Paul Turner <pjt@google.com>, Stephen Hines <srhines@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: clang asm-goto support (Was Re: [PATCH v2] x86/retpoline: Add
 clang support)
Message-ID: <20180214090851.GU25181@hirez.programming.kicks-ass.net>
References: <CAGXu5j+7=61aY_Q4Zd4kRgovb07MYg9uej8B2KmdvZE3zPsbRw@mail.gmail.com>
 <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A3D6595E4CE1DA4A80538CC077C51A2B84771848@hasmsx107.ger.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334105121442328?=
X-GMAIL-MSGID: =?utf-8?q?1592366826827980392?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 08:33:39AM +0000, Yatsina, Marina wrote:
> I hope this will give this issue a push forward and we will find a
> solution that will not prevent llvm from compiling linux kernel.

That solution is asm-goto. We (linux kernel) are not going to support
something like it. It's going to be asm-goto or bust. The feature is
over 7 years old by now, deal with it.

If you ever get to the point where it makes sense to build a kernel with
LLVM, then you can bike-shed with the GCC team on new features, until
then tough luck.
