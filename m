Return-Path: <a13xp0p0v88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520284866; cv=none;
        d=google.com; s=arc-20160816;
        b=UxAUW9MVBqJ5fDblLjDluy+7ZKWa0PeOxyTiEPR8zkAWLfK2x6vE5swbqf5Cu3I+Rb
         j1ldHPzx5qLZh2U651OtPBXzo0TevcwpysAubp9Xrcj38E++zaLRIkmOqDM2eX6oNtKO
         30qK2134UWRkFLTXqIKkyangW25tZ5R8Bd+yY20J/51VToB7Bji/TStYqEAk66aYGWbI
         kcy8dmiwV8145lxM9q5ZoEdHJ0ZID0bIQTrkIK29Xap62lgtG6UtLGeaVkxEKplrHGdM
         w9A7Rzyl05HInNQgG1tqJ+t8BQrx91yaX8e3buXIKviww4aeEA4589/ae1+wbQInpw34
         A6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:reply-to
         :arc-authentication-results;
        bh=ovbioeu3FJulazaiyFUtq1qmtUqL9+m9g4iE+OKG3IE=;
        b=hQ7dNsXshfyWsB1BE7vS+pirWqlzeS4NTFaO7aoHMc8/WkimXKt85qdmxUnBLxX/1k
         I5EllMN94aW00Du8GatUBYJvCwSGX1w23YBMKPgb7xj9gKndOlB7jHPS/20G3yOPl66o
         +3iki1SCAleMIGuC70dOxW5oXwSRY4zImSYZMAEnUJ7pnLUXOTSBYXbV2dRmNQKxU2xN
         Kz+QcNyjd6/KO/zK8VzV1sSLCOKo+WzroTGOfLMhjJtdki9XEpRz5evStWVXctkAu02h
         LBLrjd3mQSv/7onYxMgQ78zSnXHjmt780XNsTmcnXi4FudFp531tHIfHW0XYX+RljlZQ
         m3hg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
X-Google-Smtp-Source: AG47ELtpPZceA/zp0uJWCWgp5D7HaqckrFviWaTbw5YYBJGMQrJJF1HeguIKYe7ngIBRylFiRdJ8dw==
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH RFC v9 2/7] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
To: Peter Zijlstra <peterz@infradead.org>, Laura Abbott <labbott@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>,
 PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Tycho Andersen <tycho@tycho.ws>, Mark Rutland <mark.rutland@arm.com>,
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
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-3-git-send-email-alex.popov@linux.com>
 <d968e58a-3abd-8e3c-cee3-00c19c1b6430@linux.intel.com>
 <94f268b2-31a4-620a-86ed-325d5bb33c57@redhat.com>
 <20180305202535.GX25201@hirez.programming.kicks-ass.net>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <b6abd009-8f64-c5a2-6496-6affb31ad75e@linux.com>
Date: Tue, 6 Mar 2018 00:21:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305202535.GX25201@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947982901315923?=
X-GMAIL-MSGID: =?utf-8?q?1594134224090940167?=
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

Yes, actually the changelog in the cover letter contains that:

  After some experiments, kept the asm implementation of erase_kstack(),
  because it gives a full control over the stack for clearing it neatly
  and doesn't offend KASAN.

Moreover, later erase_kstack() on x86_64 became different from one on x86_32.

Best regards,
Alexander
