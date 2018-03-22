Return-Path: <a13xp0p0v88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521752216; cv=none;
        d=google.com; s=arc-20160816;
        b=ABTSSKGwnx+ZS0G2xZ4nHZM1JxT5WCG2WacOj6Uqm0JUXUAnD7mjEWmWEpTIqfnLyF
         2UL/g4aTHDSKlzgDmBtGWCimRIFz36neL/SAyaxDUBkV222apH4gOLtCtDTv+tkrNOPL
         Z6asLcAXK0TPlEO7CPRwenyWpBglFSU/uE5U9bsyLUt7J+2admgjRdRLCmhAvEmmz+2l
         tbaRq26NRgo7JZ/opBsS9e2juswNRWqfGoLXfNFTtlXxl9zT4bvimPNta0ZtzVzuFmtU
         iXRD79CD7dN74L3XdczTEzt/r6VNF7sTlzW1dGRSdpNgCPKV/3Mu/Yk8gqGETKx7MCMV
         NqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:reply-to
         :arc-authentication-results;
        bh=03GJZPxOwjQAOUQeGhUUuN1qEQPQ7syL1e0DJe8H9N0=;
        b=yoaRxHflyI31MBh63nOpZXgrYw/Zab+ZOCK8ZDcNJMjsaWJu/0kb69+8Cop/X541eh
         C7nc9W+9zo4tDweY/1x7l6tNpw4dl6SUf7H8V8xSmTQL6FqfqfxhM3VcI3+MMeK0BPjp
         5az7VxMjbOda/HKXuYXdEvCN8xJ/WkSRv/9ATN9Xppsw6YEA6X5zmI7ex16Cw2zdD0oP
         yc6bNxO2bKVL9S8dUreK2IJbapjVM1EHoVVofMFh1d5FLiER7eGaGFSumX6yaQcKoMtI
         hE+JdEugpxPdi+IONdRs99I9H0tyhQn9eS0FRVOZjdRZszaeBeD63+dhN9hZeyRfySgr
         khzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
X-Google-Smtp-Source: AG47ELsu2Vyu7AG06qTAYruZSXKPvm1FV6xidOh9BHwCAd0Ba4m136hueklnKrxl56oyG4pXpDiI6Q==
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH RFC v9 2/7] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
To: Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Laura Abbott <labbott@redhat.com>,
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
 <e043e0d6-3265-4bc2-ae11-ab430832a8e2@linux.com>
 <295a6830-fce9-ee00-f45d-7dafd74d11a1@linux.intel.com>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <ac1a2090-e120-d202-35b4-b158d4787ab5@linux.com>
Date: Thu, 22 Mar 2018 23:56:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <295a6830-fce9-ee00-f45d-7dafd74d11a1@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947982901315923?=
X-GMAIL-MSGID: =?utf-8?q?1595672852528906962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21.03.2018 18:33, Dave Hansen wrote:
> On 03/21/2018 04:04 AM, Alexander Popov wrote:
>> The main obstacle:
>> erase_kstack() must save and restore any modified registers, because it is
>> called from the trampoline stack (introduced by Andy Lutomirski), when all
>> registers except RDI are live.
> 
> Wow, cool, thanks for doing this!
> 
> PTI might also cause you some problems here because it probably won't
> map your function.  Did you have to put it in one of the sections that
> gets mapped by the user page tables?

No, I didn't have to do that: erase_kstack() works fine, it is called just
before SWITCH_TO_USER_CR3_STACK.

There is also a way not to offend KASAN. erase_kstack() C code can be put in a
separate source file and compiled with "KASAN_SANITIZE_erase.o := n".

So, as I wrote, the only critical drawback of the C implementation is that it
needs no_caller_saved_registers attribute, which is provided by gcc since version 7.

Can you recommend any solution?


By the way, during my work on STACKLEAK, I've found one case when we get to the
userspace directly from the thread stack. Please see sysret32_from_system_call
in entry_64_compat.S. I checked that.

IMO it seems odd, can the adversary use that to bypass PTI?

Best regards,
Alexander
