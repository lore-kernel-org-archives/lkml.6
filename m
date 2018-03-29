Return-Path: <a13xp0p0v88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522306715; cv=none;
        d=google.com; s=arc-20160816;
        b=p5Po+yhTvPlWumC6P1bcAgm6o9g8NgNbwewh79LrloqiRwaprjotpQvQsgNRC2m3gj
         MU6O+pGlIP635YjckfAd9CCCAREMHoKhr4x5pX3OMcsNctaqm3Qz8Sd4NDnQKCL2WM5g
         lCthxwkEJ5BVK6AkbDZfWB+SvhpsPuC58OyiW0qY8f6PaaEs1/F/PqwwoFxEvmSCY6oN
         iGC/4HMHnt9NvZ+E8rNT0iVq7UVqpTUueZShQ/Ej+T5WsVd82dBknIFxcaTGnopHveLN
         8xupMJGYNwPpVkGF6o2tTlosYFEJC86PHqLF7NQ2+eldhj22vdZrpWTdwhIEsYFNYr4C
         FIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:reply-to
         :arc-authentication-results;
        bh=ri1xETBcwWWE2wRvKzY/yorhFVuCpbxIHi2eKc18tkI=;
        b=UwIHDLODXRIcmVfYMJO9Pn//+AGIg39dj+XyE15eckzrSJ5M6TNLD8pozggd7gcUf+
         xg9+ATV+aPS8mzzEQ1WUsN2OH0ZxG3bnQuwQGs31rsp2k5NY6ySoRJe8FmqH9YFrP0Wj
         sjlgtWI6tWLDOGYSo27FI9nJNapDOOWMWhzbepxQ6AMn/D4JoVaX+pQBHc2/O4l1iStb
         EhRXn14zyxUUogcHD/NPvFaEBwJaQ5gisaBB9bBlhJcK9kFLAHAaStgT8C0+F05Q9SSf
         oexXl+o0gHlWlV0KSBL/+gD+EDRgT1QU3aJ8ovA72Hom2GLT1DLpDEx+QLaBWSe9BG+k
         xnmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
X-Google-Smtp-Source: AIpwx49LofDCGwMuqSCcevD04ZX+15bWbKZsJ7WPafygp+8oY4jv8rTMPTUgOncj+G3v6LI54mKrLA==
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH RFC v10 2/6] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
To: Dave Hansen <dave.hansen@linux.intel.com>,
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
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <16a56461-6501-7eb9-e1a4-761c9eff9386@linux.com>
Date: Thu, 29 Mar 2018 09:58:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <77fab6ea-0bbf-d68b-a38e-3e22d1ae6093@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596212693741401562?=
X-GMAIL-MSGID: =?utf-8?q?1596254287176950802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 29.03.2018 01:55, Dave Hansen wrote:
> On 03/28/2018 12:57 PM, Alexander Popov wrote:
>> +.macro ERASE_KSTACK
>> +#ifdef CONFIG_GCC_PLUGIN_STACKLEAK
>> +	PUSH_AND_CLEAR_REGS
>> +	call erase_kstack
>> +	POP_REGS
>> +#endif
>> +.endm
> 
> Thanks again for the hard work to trim down the complexity of the
> assembly. 

Hello Dave, thanks!

> I noticed the 64-bit version saves/restores registers while
> the 32-bit version doesn't.  What's the reasoning there?

When erase_kstack() is called from the trampoline stack, it must save and
restore any modified registers, since all registers except RDI are live
(prepared for the userspace).

When erase_kstack() is called from the thread stack, it can clobber registers
according the function call convention without any harm.

Best regards,
Alexander
