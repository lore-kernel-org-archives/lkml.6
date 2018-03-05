Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AG47ELvw0ykfkzY2awu5VwRAIMvC2I9z2HMFsCxH15seh8xvK5G2Vc+fRUsAp15J3MVzJhcZ3FaF
ARC-Seal: i=1; a=rsa-sha256; t=1520268105; cv=none;
        d=google.com; s=arc-20160816;
        b=yR0gDEQ2zKM0UNzrUSIG4wZagHULobhiwQEGbnr9BhXEE073YdHSPtvz7mNZDg9RAq
         NGKvpayl7Fj9D7XHdy4EeF27jk1cHDyiVPbtNhF1XkV4zpXLuR5jjyAEJO2Y8evBlh88
         CfkoW8EeD61RxnzZDl5Tk0xIIZM8lqfVmncz7m+fTWUh6m+MAYjNQygAheI1a9KXaERu
         V9pvjjNdc9s9q4hv9igbm8JXv0b5TSAu2FRXqKI+MCn9b98O3ea9Gb0dHcAn3WRYPzqE
         OMBQ5TaeEOCBWpnNEavpuZzoHaqKH3bUd6p06iK2jnAAYtJvE5JIe37868ReYLrJZIO7
         dLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=FNHerrBGcTPmQLIAZpZAwVRf4vaMtjJKJ5wIMZNuzKo=;
        b=H5tz9mxYbetyVXc59zwE4J3+24s3q4kfPUeNlsPbtGj3/Gf4wQF01d+BZxibesCn8M
         nnJgPauFHhZYovHVwtR7l9zQyLcxjNwjvwSPx/+IOPouK0Bn3FwV3t52VU7GTYZ98UUa
         rGjHlBuiV7ARi6KVYdy3o4PCpY2ZG/WGcsFLSNn3atrSSBpF5QFt9L1AxCODt1S0yjqA
         00gtBfdiyaMCJjnMHYY78bQjmpdn8TZg4P/6FwHAKFyvB6kylM5Hc2CRShWFIKm0HwAa
         9VcUMF8DEaBeeDd5A9liE7kKuPQvxCdlYYmQabZq1R/MIfJykU5ke9yGOiTEw2sAnDB5
         4YbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="23069651"
Subject: Re: [PATCH RFC v9 2/7] x86/entry: Add STACKLEAK erasing the kernel
 stack at the end of syscalls
To: Alexander Popov <alex.popov@linux.com>,
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
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <1520107232-14111-1-git-send-email-alex.popov@linux.com>
 <1520107232-14111-3-git-send-email-alex.popov@linux.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <d968e58a-3abd-8e3c-cee3-00c19c1b6430@linux.intel.com>
Date: Mon, 5 Mar 2018 08:41:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520107232-14111-3-git-send-email-alex.popov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593947982901315923?=
X-GMAIL-MSGID: =?utf-8?q?1594116648899717873?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/03/2018 12:00 PM, Alexander Popov wrote:
>  Documentation/x86/x86_64/mm.txt  |   2 +
>  arch/Kconfig                     |  27 ++++++++++
>  arch/x86/Kconfig                 |   1 +
>  arch/x86/entry/entry_32.S        |  88 +++++++++++++++++++++++++++++++
>  arch/x86/entry/entry_64.S        | 108 +++++++++++++++++++++++++++++++++++++++
>  arch/x86/entry/entry_64_compat.S |  11 ++++

This is a *lot* of assembly.  I wonder if you tried at all to get more
of this into C or whether you just inherited the assembly from the
original code?
