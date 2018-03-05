Return-Path: <labbott@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520279004; cv=none;
        d=google.com; s=arc-20160816;
        b=oPvX2aHDcoVR/bfLT1cRlOhVVKr9d6SxOfro9+PlQdnVUxkP6oy4pnP2iMY0d+hGmv
         wUlUBnSCo+uwwoD3MloeTFc62W9vaFG28+NFvUk0iKI/u1hJnkY5yNN6Is3ZLLqnzYwT
         x19je9EO9ECC4fqYZxIkBBakpaVnKcPTwRGYGy3XdTSueel6m+MJ4ciefzidls7zySiO
         fusmVMMOKGtPQPr0PjqZgzHHqRMKg5UhO8fEyAgU2zLqigKX1ZxOmvZGzmg3ckFZUC9y
         37ZUIHU75TzwltU1F1yAve7vedHxuJsbgaimzuLTS/om1KXDnufY6aWhyIXxTwDaieNv
         DCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=04Ctnp8qnSc/wv8kTmGOaNYMW19rQ1oTNrUMpr/WQMo=;
        b=cP8nnLRtaZkgolGSXizJG0PbI3zHLmnOUC+zY7czU8bWv/HznxDmutmp32wO/KKZXi
         2ESmWvgIEv5NIA1MHgA9a1hOezRyJM6Eo0K0i87YczyIdN0PFfHZ/yYtPNk4/zUrxl7G
         uouKmBni9P2Y3OX7x5RXzm4RX6qAdBmkTf+H7+L2atrXbkEsCW8fJ7WU0qJ6Xsy1cQfl
         UFuS0+j+IPiHjvfAKs5yiIkfhOWV0KBeqEZTLxizUx8EoUzVj5J/aJq1wEjqyVpQBb4F
         MUTrRqhhMg+vhWY93nHL8XXXK5VAJYbTo/2oZwpR78Muqyb+CFP7mq1F+d8oPx9GpcCm
         1VBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of labbott@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=labbott@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AG47ELtNiDIKupXPmpXnsWg9zljzk+I8pbJwEb0QQV1x/P6oN3xxRWCCCJbit6RAco5ou0Qu7qgxow==
Subject: Re: [PATCH RFC v9 2/7] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
To: Dave Hansen <dave.hansen@linux.intel.com>,
 Alexander Popov <alex.popov@linux.com>, kernel-hardening@lists.openwall.com,
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
From: Laura Abbott <labbott@redhat.com>
Message-ID: <94f268b2-31a4-620a-86ed-325d5bb33c57@redhat.com>
Date: Mon, 5 Mar 2018 11:43:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <d968e58a-3abd-8e3c-cee3-00c19c1b6430@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947982901315923?=
X-GMAIL-MSGID: =?utf-8?q?1594128077298743305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/2018 08:41 AM, Dave Hansen wrote:
> On 03/03/2018 12:00 PM, Alexander Popov wrote:
>>   Documentation/x86/x86_64/mm.txt  |   2 +
>>   arch/Kconfig                     |  27 ++++++++++
>>   arch/x86/Kconfig                 |   1 +
>>   arch/x86/entry/entry_32.S        |  88 +++++++++++++++++++++++++++++++
>>   arch/x86/entry/entry_64.S        | 108 +++++++++++++++++++++++++++++++++++++++
>>   arch/x86/entry/entry_64_compat.S |  11 ++++
> 
> This is a *lot* of assembly.  I wonder if you tried at all to get more
> of this into C or whether you just inherited the assembly from the
> original code?
> 

This came up previously http://www.openwall.com/lists/kernel-hardening/2017/10/23/5
there were concerns about trusting C to do the right thing as well as
speed.

Thanks,
Laura
