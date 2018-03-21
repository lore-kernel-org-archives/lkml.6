Return-Path: <a13xp0p0v88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521630252; cv=none;
        d=google.com; s=arc-20160816;
        b=tjMYlyeu/t2pBvweOCpLqxH+C1JE6fLw6aLstRkgd0xCrg48c6KRRjZWeC92OwPT6L
         FKv/SYgAfRj3/dOLr4d14cd0kiR8x7PzSqW3juuk+WMe4HoQ832CBTLeSWSunTuUS3mc
         ihZ/fFLqZVmLt62DcjsL435VIh2irzH5iEzQMaPeMenWSt130EmdLkQiR6x39hg6hFhm
         i758ox0DXYoIVlWdtMpqLJdrqupu9d+e8kDJK0Cv2rOPGfW45GNFb+aGctZ7rtLZG/sT
         1gchE/oWdVKJ5LTRrFinjAQ7xX37YIbgjof0/MoASWVkvg/qpevnIQo7TvuJauq4YDG3
         bLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:reply-to
         :arc-authentication-results;
        bh=QncFojneZRa8HX/pcW9CjeKe0cv81TsJuA4BIqUlRIo=;
        b=K+xoCCuTqAJpM7cdJ/q0XyZ7t1eZROOrlcSho5mPSqLaKowpIGb9ipDXE4/RWhLBOi
         5TBsF3ubXYUkWu/IavOH6CWKfy4Fpr6iz6l9JV2OF+j5cKCVgKjAGppR+yDiGD43nsMw
         6pexxQhB87W6RtVe9FqY16LDg3q5vEUawGCIKyDcYAMxy8nHvFuTpmSsCnsCvHsIwkts
         sPf60SAhnVANcTqDE3+81+FG9IDv7Yw7bAvmNoOzHcmRPditiLmriacJ+TmNFlHSTgpF
         59MRB4MXGevfS8W58cZziaiY72QS3XzyR45IZjJCXkY5ZiFm33ohbuF2Kfb/jXzFQBTq
         51cA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
X-Google-Smtp-Source: AG47ELsZlriyKI+szvlQE4a6SWN2NYfld5sldgAPEcXmQBoE0HWdkk9XBhxcYiooykygyusGxZ2EqA==
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH RFC v9 2/7] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
To: Peter Zijlstra <peterz@infradead.org>, Laura Abbott <labbott@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>
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
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-3-git-send-email-alex.popov@linux.com>
 <d968e58a-3abd-8e3c-cee3-00c19c1b6430@linux.intel.com>
 <94f268b2-31a4-620a-86ed-325d5bb33c57@redhat.com>
 <20180305202535.GX25201@hirez.programming.kicks-ass.net>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <e043e0d6-3265-4bc2-ae11-ab430832a8e2@linux.com>
Date: Wed, 21 Mar 2018 14:04:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305202535.GX25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947982901315923?=
X-GMAIL-MSGID: =?utf-8?q?1595544963926729720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05.03.2018 23:25, Peter Zijlstra wrote:
> On Mon, Mar 05, 2018 at 11:43:19AM -0800, Laura Abbott wrote:
>> On 03/05/2018 08:41 AM, Dave Hansen wrote:
>>> On 03/03/2018 12:00 PM, Alexander Popov wrote:
>>>>   Documentation/x86/x86_64/mm.txt  |   2 +
>>>>   arch/Kconfig                     |  27 ++++++++++
>>>>   arch/x86/Kconfig                 |   1 +
>>>>   arch/x86/entry/entry_32.S        |  88 +++++++++++++++++++++++++++++++
>>>>   arch/x86/entry/entry_64.S        | 108 +++++++++++++++++++++++++++++++++++++++
>>>>   arch/x86/entry/entry_64_compat.S |  11 ++++
>>>
>>> This is a *lot* of assembly.  I wonder if you tried at all to get more
>>> of this into C or whether you just inherited the assembly from the
>>> original code?
>>>
>>
>> This came up previously http://www.openwall.com/lists/kernel-hardening/2017/10/23/5
>> there were concerns about trusting C to do the right thing as well as
>> speed.
> 
> And therefore the answer to this obvious question should've been part of
> the Changelog :-)
> 
> Dave is last in a long line of people asking this same question.

Hello! I've decided to share the details (and ask for advice) regardless of the
destiny of this patch series.

I've rewritten the assembly part in C, please see the code below. That is
erase_kstack() function, which is called at the end of syscall just before
returning to the userspace.

The generated asm doesn't look nice (and might be somewhat slower), but I don't
care now.

The main obstacle:
erase_kstack() must save and restore any modified registers, because it is
called from the trampoline stack (introduced by Andy Lutomirski), when all
registers except RDI are live.

Laura had a similar issue with C code on ARM:
http://www.openwall.com/lists/kernel-hardening/2017/10/10/3

I've solved that with no_caller_saved_registers attribute, which makes all
registers callee-saved. But that attribute was introduced only in gcc-7.

Does kernel have a solution for similar issues?
Thanks!

-------- >8 --------

#include <linux/bug.h>
#include <linux/sched.h>
#include <asm/current.h>
#include <asm/linkage.h>
#include <asm/processor.h>

/* This function must save and restore any modified registers */
__attribute__ ((no_caller_saved_registers)) asmlinkage void erase_kstack(void)
{
	register unsigned long p = current->thread.lowest_stack;
	register unsigned long boundary = p & ~(THREAD_SIZE - 1);
	unsigned long poison = 0;
	unsigned long check_depth = STACKLEAK_POISON_CHECK_DEPTH /
						sizeof(unsigned long);

	/*
	 * Two qwords at the bottom of the thread stack are reserved and
	 * should not be poisoned (see CONFIG_SCHED_STACK_END_CHECK).
	 */
	boundary += 2 * sizeof(unsigned long);

	/*
	 * Let's search for the poison value in the stack.
	 * Start from the lowest_stack and go to the bottom.
	 */
	while (p >= boundary && poison <= check_depth) {
		if (*(unsigned long *)p == STACKLEAK_POISON)
			poison++;
		else
			poison = 0;

		p -= sizeof(unsigned long);
	}

#ifdef CONFIG_STACKLEAK_METRICS
	current->thread.prev_lowest_stack = p;
#endif

	/*
	 * So let's write the poison value to the kernel stack. Start from
	 * the address in p and move up till the new boundary.
	 */
	if (on_thread_stack())
		boundary = current_stack_pointer;
	else
		boundary = current_top_of_stack();

	BUG_ON(boundary - p >= THREAD_SIZE);

	while (p < boundary) {
		*(unsigned long *)p = STACKLEAK_POISON;
		p += sizeof(unsigned long);
	}

	/* Reset the lowest_stack value for the next syscall */
	current->thread.lowest_stack = current_top_of_stack() - 256;
}
