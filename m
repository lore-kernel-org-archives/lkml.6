Return-Path: <fweimer@redhat.com>
X-Google-Smtp-Source: AG47ELsk312N0FyU4HRHZeAGEWEAei/n3ckqtuBHgWLMAXBuEkgFz5S6Sk52LUzcgxSwc+87HLSV
ARC-Seal: i=1; a=rsa-sha256; t=1521037275; cv=none;
        d=google.com; s=arc-20160816;
        b=UC5nsVl9g08wYoq8PCxhwQpbFoPsEeCQn/9wYuBqnZpEcMnWCWMvJkBqRXY/m8kLPn
         xnxmm4q6XXhLRbkFs8cwL+17MN2RoEetAlnM2tOM2wgXkzI+znzjkZeoJLxNvAoCaM4V
         6g3IoGWJkooA9KrcMf37rAe7hm6HqWV2SGFLN7Uw28HtBWy2amM6GAkXxn5WxDIKg75N
         2a4+Dn48D74zF5d///LeVV6fzrfTDt6FDymh9w7Y66xSR2uFQP5HTGjJtWKNqlfSw80n
         xNYtlGtnRquirNjIM1FNB1Q+Zv9ec8kPpls10ObnqRcH2OFTWbCBpgZ52axxi1fu70h3
         2n9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Te8PcWcA7FOHMqNRYfCzWqpXnIMmQBuRZltGCwGWrzc=;
        b=H3L+M0MnlNyWPnC8ZnsjExvQigUfNpUXL6SCDxGbF+MzDLNrYZJ2mjYc6WnsyzNEYX
         iUzfUx2P6BpcxyUUCbsIWhrNuGiXWHbswFaN7ZKtTanrGTH0G6zs6obMJU0giMc1sY1n
         wKkFs2NJ3LQYb9K6u9xyiw5yftMUUoGP6eYgOETrmuSD4e9kfLbScuzWSKSe8DE/wDhj
         nLK8pr1w4Un1razD9eEqvjrCrxmGY4FS6sXgk072VR+xTDfdemP6LV3sQ3x2fHTXW6wn
         7PMPugIwJy4iThpd8MI6lFj7FMs8TtI/rg0VcAt7KToVs41J/2N4Ewj74tB+h+ZvXPW0
         3lTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fweimer@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=fweimer@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fweimer@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=fweimer@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Subject: Re: Fully initialized stack usage (was Re: [PATCH RFC v9 4/7]
 x86/entry: Erase kernel stack in syscall_trace_enter())
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>, P J P <pjp@fedoraproject.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Arnd Bergmann <arnd@arndb.de>,
 Daniel Micay <danielmicay@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alexander Popov <alex.popov@linux.com>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
 Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Borislav Petkov <bp@alien8.de>, Richard Sandiford
 <richard.sandiford@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
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
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Juergen Gross <jgross@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Mathias Krause <minipli@googlemail.com>,
 Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey
 <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
 Will Deacon <will.deacon@arm.com>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <CAGXu5j+4mEyhE6shkxWqY4AVQGcq2U7nzf4j_n2+CdW2t6CzqQ@mail.gmail.com>
 <CA+55aFykZL+cSBJjBBts7ebEFfyGPdMzTmLSxKnT_29=j942dA@mail.gmail.com>
 <CAGXu5jJVSG7ZuftTRGZjgKqetpmxNpeqwxAzhY8BJ4_H-oUw5w@mail.gmail.com>
 <CA+55aFyfW901QRpdmgEsaY8b4+AOPf2SKKVo7mNs2iRUTHND3w@mail.gmail.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <fe00723e-bdd0-3558-a137-da5f4f3d6127@redhat.com>
Date: Wed, 14 Mar 2018 15:21:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFyfW901QRpdmgEsaY8b4+AOPf2SKKVo7mNs2iRUTHND3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594750868471232540?=
X-GMAIL-MSGID: =?utf-8?q?1594923181864164260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/12/2018 06:45 PM, Linus Torvalds wrote:
> On Mon, Mar 12, 2018 at 10:17 AM, Kees Cook<keescook@chromium.org>  wrote:
>> On Mon, Mar 12, 2018 at 10:09 AM, Linus Torvalds
>> <torvalds@linux-foundation.org>  wrote:
>>>      struct xyz var = { };
>>>
>>> I'm not sure what that will do with padding.
>> AIUI, this does not guarantee padding initialization (yet another
>> "undefined behavior"). This is why we've had to sprinkle memset(&var,
>> 0, sizeof(var)) in places where a structure has padding and got
>> leaked. :(
>>
>> I assume this may be orthogonal to -finit-local-vars, and maybe we'll
>> need some -finit-padding or something. (Though, honestly, is there
>> anyone that wants to get_padding_  correct, but not variable
>> initialization?)

> We would definitely have wanted it over the years, yes. And
> conceptually it's a separate issue, so a separate flag makes sense.

What would be the model for the kernel?  Write zero to the padding 
initially, and on copying structs, make sure that you either copy the 
padding from the source, or clear the target?

Clearing the padding while copying might be somewhat expensive.

Thanks,
Florian
