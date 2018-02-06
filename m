Return-Path: <luto@kernel.org>
X-Google-Smtp-Source: AH8x225B/RxZvkhFhWdgHmbzvg3dFxkEaMZ9gVC+tD5fixi5AeBfoX3i4qsoAoFzltBdT8gtcJRM
ARC-Seal: i=1; a=rsa-sha256; t=1517950912; cv=none;
        d=google.com; s=arc-20160816;
        b=B+sq4Ho9FwVn6ofDVjW0xvTFoLapmByfNU1StO7tgAY/OBbcBQrN2kL7p6LU2HY0WB
         q7Nf2jb/P0/paI+jZJmF7rJAwIALQSGcoI3Blo/1ZPWsHYo8sCILp44WzKBRRPOOhZNm
         Lrla0Y0q/N/BnGNgddgv/8xep8auiG5h1+RipZiBA9lgIGUQaUP171aZkUwMNGmX4NmQ
         lBuvsIhSCMI3x/DIS+7tiWJj2g1hKglhCz2q2UQE1H2UieOIFMSdnZwNzj7mydnRsUUO
         i8+/aMRl0UtVjqQGRz7FmP3YTuNq4cts/P++YWIx29PHvm+aDggFTB5RRX8VV3S1hvCx
         /E0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=ZJh2xp/QJMVGuZ363vvMTa5KPk7z538piLAABVAluZY=;
        b=GuYo4ORjxiWfar5yzzeksUDWO9V5c8XatrG+XPN7m4ixLKDJCa4ItynY1sdN3wdIlm
         xePkiN+Yht5qlSP4154ePLoykkJH40AMBH0qZR2XPIQlU4lMRnGODAzBSDsUPyuAH2z4
         +RoZeRo7hGOQzRw2bb7AEhMjg+WDvJzGHztr3AIFnt4ibyPrl3BpPhTwNYv6r86f/sZs
         yxE36Vy3been7j8T2pyH0z7msbvtJ6JDOZdYNVZDNZbqTFKJUxLPsckkHwUp0+1yfxIc
         JxjmRqY/4bcJRZgSvTB7goQ4uH1VuAY8t3w2vXtV/0/nYik6ZuNDv7eKLPFq+1NKWKle
         qcPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of luto@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=luto@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5203217BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
MIME-Version: 1.0
In-Reply-To: <1517950341.3677.27.camel@woodhou.se>
References: <1517614240-31269-1-git-send-email-linux@roeck-us.net>
 <20180206203218.GA11026@roeck-us.net> <1517950341.3677.27.camel@woodhou.se>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 6 Feb 2018 21:01:30 +0000
X-Gmail-Original-Message-ID: <CALCETrX2m8J9YPm+brBKdFEL3dk+BTVa4Y+b4sx9p3yP5oGxpg@mail.gmail.com>
Message-ID: <CALCETrX2m8J9YPm+brBKdFEL3dk+BTVa4Y+b4sx9p3yP5oGxpg@mail.gmail.com>
Subject: Re: [RFC] x86/retpoline: Add clang support for 64-bit builds
To: David Woodhouse <david@woodhou.se>
Cc: Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>,
	Andi Kleen <ak@linux.intel.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>, Kees Cook <keescook@google.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>, Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591333873946801262?=
X-GMAIL-MSGID: =?utf-8?q?1591686895897516060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 8:52 PM, David Woodhouse <david@woodhou.se> wrote:
> On Tue, 2018-02-06 at 12:32 -0800, Guenter Roeck wrote:
>>
>> >
>> Feedback, anyone ?
>>
>> I understand that there is no love for the ABI differences between clang
>> and gcc, but that doesn't help me. Even if the patch is unacceptable
>> as-is, I would like to have some feedback to get an idea if I am on the
>> right track, and what I would have to change to at least move into the
>> right direction.
>
> I'm going for just a comprehensive NACK. If they fix clang so that at
> least the thunk symbols __x86_indirect_thunk_\reg are compatible, then
> we could tolerate command line differences. Otherwise, just no.
>
> Unless you really fancy trying to do some kind of alias hack in modules
> so that they link to the external thunk by its proper name, even when
> built with clang? I reserve the right to hate that too.

I agree.  Linux already has too much history of bending over backwards
to deal with poor ABIs from compilers rather than asking compilers to
fix their ABI.  For example, stack canaries.  Linux should never have
supported GCC's 32-bit x86 stack canary crap ABI in the first place.

--Andy
