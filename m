Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELutpmo0X9uNxy/cNP8zS1erMIQR5A7tAj0u7jqUocVuWG4blozsQvbNOqUfww8hYPfUroaX
ARC-Seal: i=1; a=rsa-sha256; t=1520279456; cv=none;
        d=google.com; s=arc-20160816;
        b=1AtzQD29/VhNVge3yiQYkW8OTLAprrCoPzHRGOagZR7R5DgOpsiAKH/JlRVVylXovr
         Hc2IOOZzD2vL1Hn5YJAPDl11ajEI5SiaFnxjKssJWl3TONYAHGg5PkuZxgsyT5713KzV
         +MDW1zvA7SUyuIkyMQfMD/83oRiIZGpUzCSD3vro/8YBI8p9yjH1AiNSiYzPVnNKAUbI
         utWQjDC+/Y906lojMBbWTphBfCkkduwcaEY5xETJL+o0LBYC3j/t7pL2pA2IC3RqNbP1
         OMayR/xJ1pjWNwTxT9gvYkL2UaHgT+OGEh9vofxX5HJR1bCKXYXfBmE9Fv4L+14kI1T9
         K9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=Di+zbEDQJR8lHPQB1Cw2qHek/GTAgnCg41efYjfNk90=;
        b=zA7jiXaU54Qsg2DRFIjy7oopIjh/Iioph2WBEsNEWWxOVb0UYl/qAvuieoN7CVZkLx
         H+yDjy3kZzS42qaHlHcTBvl4idBWJGzuf3aPV8Qinf9gIlz8x0Tuc9SloBD1ovg+wxAn
         ylx/ijXC7VHWXtEe0NzclVCpyU7idBgw2uB0kf4UT6HUGs5CM4xOBM75TFVz8wVG4H8k
         Yne7v/lDloymGPL/7K8g52Y7GC7yvRwOgVFs3TcSwVBPULDQFTlfGwGD65qRqiH+J6gG
         WJAA3jQZB/9P2mG1/xgiycfzbubqXPacjp8B0d/AOfGRJI+alOMY4DGUEA8pgAmqktjt
         RUlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.93 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32585013"
Subject: Re: [PATCH RFC v9 2/7] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
To: Laura Abbott <labbott@redhat.com>, Alexander Popov
 <alex.popov@linux.com>, kernel-hardening@lists.openwall.com,
 Kees Cook <keescook@chromium.org>, PaX Team <pageexec@freemail.hu>,
 Brad Spengler <spender@grsecurity.net>, Ingo Molnar <mingo@kernel.org>,
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
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-3-git-send-email-alex.popov@linux.com>
 <d968e58a-3abd-8e3c-cee3-00c19c1b6430@linux.intel.com>
 <94f268b2-31a4-620a-86ed-325d5bb33c57@redhat.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <da695ba4-57d1-4a77-a96c-ad38ea370cdc@linux.intel.com>
Date: Mon, 5 Mar 2018 11:50:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <94f268b2-31a4-620a-86ed-325d5bb33c57@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947982901315923?=
X-GMAIL-MSGID: =?utf-8?q?1594128550988846584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 11:43 AM, Laura Abbott wrote:
> On 03/05/2018 08:41 AM, Dave Hansen wrote:
>> On 03/03/2018 12:00 PM, Alexander Popov wrote:
>>>   Documentation/x86/x86_64/mm.txt  |   2 +
>>>   arch/Kconfig                     |  27 ++++++++++
>>>   arch/x86/Kconfig                 |   1 +
>>>   arch/x86/entry/entry_32.S        |  88 +++++++++++++++++++++++++++++++
>>>   arch/x86/entry/entry_64.S        | 108
>>> +++++++++++++++++++++++++++++++++++++++
>>>   arch/x86/entry/entry_64_compat.S |  11 ++++
>>
>> This is a *lot* of assembly.  I wonder if you tried at all to get more
>> of this into C or whether you just inherited the assembly from the
>> original code?
> 
> This came up previously
> http://www.openwall.com/lists/kernel-hardening/2017/10/23/5
> there were concerns about trusting C to do the right thing as well as
> speed.

I'm really just curious if anyone tried it and what tradeoffs were made.
