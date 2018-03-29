Return-Path: <a13xp0p0v88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522356998; cv=none;
        d=google.com; s=arc-20160816;
        b=wWXnzEFg6fIbJ3X/HqaDf3MyWVLzOZOLlH9yeni/QUZcWeCea8N8kci7CHCK+P7EUM
         6PdbC6+tgAVpIkliU+GWH0T0wUKa8DFRlHIxZjJWlRALu9DI/rVLYIhG35gZspqVcpkq
         WbPIHpyjRPmwDt1//MEHxPJaFaUMif6np43PQlJqG5Qgl/Z2r7anMNeYRj4OcPBH5FzC
         tCzqi3lhSsWvHYXbMvQiKCaP6ZVdC05dcZzTRDLduGGRVhpfKpGcIuyvunVvCQpUyawC
         UPs63AZjcdDILBbIJ0ICEz+QWPX4kr1pffll2gldNS/PKGTfyS5s+J9yA+GaOx2UknhW
         qVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:reply-to
         :arc-authentication-results;
        bh=bp0ZmSX9M6idaQ4BcrB6MmpEbO/1KMhUVF1ybDL+LBs=;
        b=0odS/HY+CMvzfOYKc38vkI/p9fKrp3Kcb9c3HUwiUD9CWjBCT4RhL/JYDH7+D/WuY9
         9kgUH1XCkkyq2E3RLjq5VN/3la4xUEzfCUm4lAHYYsgcsLpUWIrdQejquCZNbDBM6TpX
         5oCrjaQ5j+eH/Y+f9l2nFPan215FyWaVLUCd+6beQVHtunRfPZanV4FC6yabRO7dv3/6
         2xR6G3vbVeqa6dKP25Om1BPD4EHa1OTcu1SMtaoyOf/45sxRR25rnRJI4xzOyXZk7LsZ
         +eCjMSzZDeGfq4dhf5G/RZ2T60TNY/WFnjXGiOBaelpE6+m4/K7+tl2rlBmbASDA2vK1
         51Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
X-Google-Smtp-Source: AIpwx4/0USHMHA3Rn5TMpl577H6hIT+2geqBK/zLYfnQFRmH2dnchVLb40NJuk9Uc+mYKQVOb3oY6w==
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH RFC v10 2/6] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
To: Boris Lukashev <blukashev@sempervictus.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>,
 PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Tycho Andersen <tycho@tycho.ws>, Laura Abbott <labbott@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Borislav Petkov <bp@alien8.de>,
 Richard Sandiford <richard.sandiford@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, "Dmitry V . Levin"
 <ldv@altlinux.org>, Emese Revfy <re.emese@gmail.com>,
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
 Florian Weimer <fweimer@redhat.com>,
 Boris Lukashev <blukashev@sempervictus.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <1522267032-6603-1-git-send-email-alex.popov@linux.com>
 <1522267032-6603-3-git-send-email-alex.popov@linux.com>
 <77fab6ea-0bbf-d68b-a38e-3e22d1ae6093@linux.intel.com>
 <16a56461-6501-7eb9-e1a4-761c9eff9386@linux.com>
 <ad614e86-7e39-e9b7-4a8f-3ea1f5a7b61d@linux.intel.com>
 <CAFUG7Cd7cSqSHCrqxKUFwBBQLuix0Mi5-=V6pq_U7KtFh20Kqg@mail.gmail.com>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <ccb76413-0740-0f20-89fc-7a1c9053b06c@linux.com>
Date: Thu, 29 Mar 2018 23:56:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAFUG7Cd7cSqSHCrqxKUFwBBQLuix0Mi5-=V6pq_U7KtFh20Kqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596212693741401562?=
X-GMAIL-MSGID: =?utf-8?q?1596307011818921021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Dave and Boris,

Thanks for your replies!

On 29.03.2018 18:09, Boris Lukashev wrote:
> On Thu, Mar 29, 2018 at 9:51 AM, Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
>> On 03/28/2018 11:58 PM, Alexander Popov wrote:
>>>> I noticed the 64-bit version saves/restores registers while
>>>> the 32-bit version doesn't.  What's the reasoning there?
>>> When erase_kstack() is called from the trampoline stack, it must save and
>>> restore any modified registers, since all registers except RDI are live
>>> (prepared for the userspace).
>>>
>>> When erase_kstack() is called from the thread stack, it can clobber registers
>>> according the function call convention without any harm.
>>
>> Oh, and since there's no 32-bit trampoline stack, we don't need it on
>> 32-bit?
>>
>> If end up reposting this set again,

Hope so. Let's see...

>> could you add a few comments about
>> this around the ERASE_KSTACK macro definitions, or perhaps the call
>> sites?  You might even want to call them ERASE_KSTACK_CLOBBER (for
>> 32-bit) and ERASE_KSTACK_NOCLOBBER (for 64-bit) to make this more clear.
> 
> Not sure if the macro name differentiation is such a good idea, might
> entice improper use attempts.
> A more detailed explanation of this should probably go into the
> headers and doc/commit log for future implementation on architectures
> which may have their own weird semantics around the trampoline
> stack/not have one.

Ok, I see. Let me give the overview and propose the solution.

The current version has 3 separate ERASE_KSTACK definitions:

1. a simple one in entry_32.S, used only in that file:

+.macro ERASE_KSTACK
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	call erase_kstack
+#endif
+.endm


2. another one saving registers in entry_64.S, used only in that file for
erasing from the trampoline stack:

+.macro ERASE_KSTACK
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	PUSH_AND_CLEAR_REGS
+	call erase_kstack
+	POP_REGS
+#endif
+.endm

The call sights are already prepared and documented by Andy Lutomirski:

	/*
 	 * We are on the trampoline stack.  All regs except RDI are live.
 	 * We can do future final exit work right here.
 	 */
+	ERASE_KSTACK


3. a simple one in entry_64_compat.S (similar to case 1), used only in that file:

+	.macro ERASE_KSTACK
+#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+	call erase_kstack
+#endif
+	.endm
+

The call sight is documented as well:

 sysret32_from_system_call:
+	/*
+	 * We are not going to return to the userspace from the trampoline
+	 * stack. So let's erase the thread stack right now.
+	 */
+	ERASE_KSTACK


If STACKLEAK is not banned, would you like me to introduce ERASE_KSTACK (for
cases 1 and 3) and ERASE_KSTACK_NOCLOBBER (for case 2) in
arch/x86/entry/calling.h?

Best regards,
Alexander
