Return-Path: <labbott@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524076391; cv=none;
        d=google.com; s=arc-20160816;
        b=mA85gheX9c04JUe3GZ3LKot/sWKBtyeW+hfWd7h3IT2JwKEOTysCoeKtHzYcAwY1+A
         K7jrC2D7wiaJCxZ5RPK5rZ6KzNvEjdLJmL8BAiNZwZOQ90/26yITi71BfVPg8KqgTckb
         p/mN8PUpXXQwfxIptKwUpHSCWzJIe+qXEDH8bHeikYUK5o8wk4ttBYpESKhpi7Kl2aD2
         69J5ql+7lMDsSsmFEYnFSao7Fxm0RXDhFhwGQSuokBgApLHg7fkD+6yN2hgA/4IVYtzH
         Drqlu8HNa9v0t8/j0NcaRB+e8qgNcGlvRsSYAq4UMTeYTzmi2RR7Lg5JkFri1zs/Wq15
         wGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=il6Xwwax5MfGJdKMVYr3k+tEN68ZUXCHx3wYaT31yEs=;
        b=MBsqJT6B9tBJjhF201eZj9BEWZUd4Fiknym/Nr1xGkTEFri544CYatrLYNZvn+BLRt
         oo5s+wa2mUxe9yHjeLdY5ouX9wwCRr0SWfgdiUmIW4IF9fodw4tcc/M7iGWydCFcpf1w
         1eiBdAJ7r34nT+ELw9RRMDunVFkybdr/ZQ8W7YH19aKXkWNFGve75u7fM9aEx1WUKUo8
         e5YesDWcqF6HxMyS4lbxP/bw1ZBHGiBOaeC6r1hhLycBRHbWTuk56Bm8N4NLJkMjQjD7
         n7J6V2l7zUEWGWwY2RkuJyHxkVdUj+LK7nCAXN1QG//gngEjQus6pfJwTbvskvuJmljZ
         SUSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx4+fEbGE3vQHTuhVtFdO+VkQlZSMKm8erKn6IY3ctd0N3HekzpaxEBdZUfDG5vUAQ/XHuqwOpA==
Subject: Re: [PATCH v11 2/6] x86/entry: Add STACKLEAK erasing the kernel stack
 at the end of syscalls
To: Kees Cook <keescook@chromium.org>, Alexander Popov
 <alex.popov@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
 PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
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
 Boris Lukashev <blukashev@sempervictus.com>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <1523024546-6150-1-git-send-email-alex.popov@linux.com>
 <1523024546-6150-3-git-send-email-alex.popov@linux.com>
 <CAGXu5jKm218fpxyV3vOM+2SO-ERG3tWPUV0x8+-S0MJAReFz+A@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <b63d4f30-4473-3487-20d6-6d590c12d51c@redhat.com>
Date: Wed, 18 Apr 2018 11:33:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKm218fpxyV3vOM+2SO-ERG3tWPUV0x8+-S0MJAReFz+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597007022879408472?=
X-GMAIL-MSGID: =?utf-8?q?1598109926059577943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/16/2018 11:29 AM, Kees Cook wrote:
> On Fri, Apr 6, 2018 at 7:22 AM, Alexander Popov <alex.popov@linux.com> wrote:
>> This commit introduces the architecture-specific code filling the used
>> part of the kernel stack with a poison value before returning to the
>> userspace. Full STACKLEAK feature also contains the gcc plugin which
>> comes in a separate commit.
> 
> Thanks for sending this again! And thanks for the updated reasoning
> for why this remains a valuable addition:
> 
> https://lkml.kernel.org/r/1523024546-6150-1-git-send-email-alex.popov@linux.com
> 
> I, too, remain convinced this is a good protection to have, even as we
> slowly remove VLAs and try to improve the compiler's initialization of
> stack variables.
> 
> Dave, Ingo, Linus: how does this look? With the assembly rewritten
> into C, the entry changes are very small:
> 
>>   arch/x86/entry/entry_32.S        |  7 ++++++
>>   arch/x86/entry/entry_64.S        |  3 +++
>>   arch/x86/entry/entry_64_compat.S |  5 ++++
>>   arch/x86/entry/erase.c           | 54 ++++++++++++++++++++++++++++++++++++++++
> 
> I'd really like to get people's Ack/Review. :)
> 
> Laura, can this C version work for arm64 as well?
> 
> Thanks,
> 
> -Kees
> 

I did a quick port and it seems to work on a minimal system
(passes LKDTM tests). I'll clean it up and do a few more
tests to send out and see about give this series another
review.

Thanks,
Laura
