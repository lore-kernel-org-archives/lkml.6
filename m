Return-Path: <a13xp0p0v88@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526677972; cv=none;
        d=google.com; s=arc-20160816;
        b=icxI03SU459Tabs259xVvGXsF4+oLsIqkPwuPlXFgee/jTAkNmzwHOxRbiRlcJJtKh
         g8FsY3LrtZ6J90xvdpWtWDCspVwn7IFDACQxa189oDHJ/8TtU0IFDdJZHZ71+QY3Xmdt
         YJ2yoF0Ly1v21aiEfYrkDTibwNK0WY384FYQptetaCIe+5aRfSF0ipJfK71+0ku/DWiq
         yYWdXoh+AgzUVnOSV/iwUY/hQtqXr7KbnZFdPcOQIGXZ3mlrcOcNshT9IrshjLe+f0zE
         aZ2zdWEAffrSUKvocAGGScW6o4dk0e4x+W0iRK1IM3hEInxoByBYEXH0R5J3j/MW6KeJ
         4cCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:reply-to
         :arc-authentication-results;
        bh=pMYYeuiwT9No3s+yxjnFgvN49PqNEZ8Qncb/tuY62hQ=;
        b=QbrNfm+qdeNXXEAin+IDOGIAqpgsahNQFUXJ1AU21F7mP7hAWXIve+9JdxQD3++CVU
         gCKukUee+qv1Q3QG+RDwYAPQKlWeVOj6IlwUCFKTwmRqmbT/CMe8BiMCW60phc7HYWGt
         iffQudDR/wB0C3JVxR62zhFC0iKS5X7LU2xvc+OW2nGqxmpvK3pbL2QlJ5mMlWollT/i
         ZQmpHGS5ofoyq/DMj3oL1x3TJorvy2/EJ3xiYPsk5chfhRFi+AdSyLFWPHe7QtNNzLHG
         ozCraFDY8+sixC1ozZAIiQun9DRjJ4sPT7Zg9mx+woMNqoGPy6bEov7qYlvb4KsEbjAF
         aWAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of a13xp0p0v88@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=a13xp0p0v88@gmail.com
X-Google-Smtp-Source: AB8JxZoxXDJ8u6cujIj/+9KUlxK5itKaYCelv/Cs9RDpTRVYF9xnk3AEzriCvnLYx8AeJpOgPYGxIg==
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v12 2/6] x86/entry: Add STACKLEAK erasing the kernel stack
 at the end of syscalls
To: Ingo Molnar <mingo@kernel.org>
Cc: kernel-hardening@lists.openwall.com, Kees Cook <keescook@chromium.org>,
 PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>,
 Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
 Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
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
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Mathias Krause <minipli@googlemail.com>,
 Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kyle Huey
 <me@kylehuey.com>, Dmitry Safonov <dsafonov@virtuozzo.com>,
 Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Florian Weimer <fweimer@redhat.com>,
 Boris Lukashev <blukashev@sempervictus.com>,
 Andrey Konovalov <andreyknvl@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <1526488097-20611-1-git-send-email-alex.popov@linux.com>
 <1526488097-20611-3-git-send-email-alex.popov@linux.com>
 <20180518065349.GA10080@gmail.com>
From: Alexander Popov <alex.popov@linux.com>
Message-ID: <9db6b23e-e2da-8e95-40da-b26951848c8d@linux.com>
Date: Sat, 19 May 2018 00:12:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518065349.GA10080@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600638811678325053?=
X-GMAIL-MSGID: =?utf-8?q?1600837881260438124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Ingo,

Thanks a lot for the review!
I agree with your points. I'll fix the series and return with v13.

There are some comments/questions below.

On 18.05.2018 09:53, Ingo Molnar wrote:
> * Alexander Popov <alex.popov@linux.com> wrote:
>> +	/*
>> +	 * It would be nice not to have p and boundary on the stack.
>> +	 * Setting the register specifier for them is the best we can do.
>> +	 */
>> +	register unsigned long p = current->thread.lowest_stack.val;
>> +	register unsigned long boundary = p & ~(THREAD_SIZE - 1);
> 
> Does the 'register' keyword actually have any effect on the generated code?

No, for gcc it doesn't give any effect for this code. I used it to show the
intention.

However, even if the compiler allocates 'p' and 'boundary' on stack, that will
not break the stack erasing.

Should I drop 'register'?

>> +	unsigned long poison = 0;
>> +	const unsigned long check_depth = STACKLEAK_POISON_CHECK_DEPTH /
>> +							sizeof(unsigned long);
> 
> Please don't break lines in such an ugly fashion!

Ok. I'll make it look like that:

	const unsigned long check_depth =
			STACKLEAK_POISON_CHECK_DEPTH / sizeof(unsigned long);


> Also, 'poison' is a very weird name for something that looks like an index.
> 
> Plus since it's bound by "check_depth" is the 'unsigned long' justified,
> or could it be 32-bit?

Thanks, I can turn both 'check_depth' and 'poison' (which I'll rename) into
'unsigned int'.

>> +	/* Reset the lowest_stack value for the next syscall */
>> +	current->thread.lowest_stack.val = current_top_of_stack() - 256;
> 
> Magic, unexplained '256' literal.

Here I'm choosing the point from which we'll start the poison search on the next
syscall in case 'lowest_stack' is not updated in track_stack().

Would you like if I use "current_top_of_stack() - THREAD_SIZE / 64" ?

Best regards,
Alexander
