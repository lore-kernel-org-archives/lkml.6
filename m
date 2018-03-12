Return-Path: <deepa.kernel@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520877594; cv=none;
        d=google.com; s=arc-20160816;
        b=UDa4D4L259V0x1ace9NUZDR9HdKFfSm1rATBmBm6f5qjFxhzCzr5qKOncp3+NKQAoz
         Byr29CUgk5qHqYO0VAaangzwicAGpMHkEhjXhbfG3Qqfcen5/iEdmY4pAs0fypX5DPSQ
         cHpG2FtjWSgfynrv6tSxDKfziDgfd3KUqzLj/cliM5BkVDyDc5xWrT3UYkm3ASjEa7Lk
         0LqZT7VcjclBtA16MJpYxSqJY3f19ikM173A6uXF54HHggjitzeqDai1RTyalgX8WQGc
         8v7OYFn344I6hYgcUOHajzvVVA0rEJ6DVL3oNNfy1z+jDrsbciohskHhn/4hYYyrb5Me
         owcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ElH4sAgG6jjT48s9ldSGD+nZ3K41SP2AmoM037n1vOw=;
        b=tNvs9PBtzOOyYp6RESTjur397p8/1+NqTClesHwvmTy5QNuOGkWyOm3Yb5VFQLUOIN
         Oe+uidiX6b8O1K0VnU/9xSeoYGD2yt1rjvIWwXa46KS0ZsNh+dW3glUHep2iI3al6aiF
         jOGt1Nodb3CnJABGcyW3f44fPV620X2LQ3zgUnUFvgcdozNTfP11pNEJZDDCkv1zH/Hq
         58c0KXXVsPcR0me6iD9mFFjI2MNc2JB0OK44CBE8H13PCavIXQMXwkH4hm7g+v+Fisx4
         QqGyriRplqmshCB7ZKvuohzUhmPd9UJZjbLHDTWG6pn2RTrmY4bO67UrcPxDnwNPjFby
         1nDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QWcECNJd;
       spf=pass (google.com: domain of deepa.kernel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=deepa.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QWcECNJd;
       spf=pass (google.com: domain of deepa.kernel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=deepa.kernel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvmYN1hT/qOba3lBdwigY6vg+LKomiWu6QbCBMhypSff9Bx4nlBmH66GQ1f55tgf+gdhqbkq3EB3knhZ5dtY48=
MIME-Version: 1.0
In-Reply-To: <CABeXuvrdPV0q4ufuxEnqT6T3b8pCT5RLUfuAZ_cwXr0it8gj0Q@mail.gmail.com>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com> <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
 <CAK8P3a0Gm1L70EaFzJBk0drRNKtX0FE22BHOSrXBgH1wNfKZ5A@mail.gmail.com>
 <d8480da9-afe9-8a43-9c47-50919215a2de@de.ibm.com> <CABeXuvrdPV0q4ufuxEnqT6T3b8pCT5RLUfuAZ_cwXr0it8gj0Q@mail.gmail.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Mon, 12 Mar 2018 10:59:53 -0700
Message-ID: <CABeXuvo-D-NFhhx9KXDFy6bYjp0-XZvoky6ugQGdBZr8DjUzxw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to compat_time.h
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <john.stultz@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
	"open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, devel@driverdev.osuosl.org,
	linux-s390 <linux-s390@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>,
	Helge Deller <deller@gmx.de>, "the arch/x86 maintainers" <x86@kernel.org>, sebott@linux.vnet.ibm.com,
	"James E.J. Bottomley" <jejb@parisc-linux.org>, Will Deacon <will.deacon@arm.com>,
	Ingo Molnar <mingo@redhat.com>, oprofile-list@lists.sf.net,
	Catalin Marinas <catalin.marinas@arm.com>, Robert Richter <rric@kernel.org>,
	Chris Metcalf <cmetcalf@mellanox.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ursula Braun <ubraun@linux.vnet.ibm.com>,
	gerald.schaefer@de.ibm.com, Parisc List <linux-parisc@vger.kernel.org>,
	gregkh <gregkh@linuxfoundation.org>, cohuck@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
	Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Stefan Haberland <sth@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589713718016333322?=
X-GMAIL-MSGID: =?utf-8?q?1594755744809737813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I posted the updated series. I fixed up the order of include files
where I could find some order.
There have been other commits that used scripts to do such
replacements and have already stomped on the order.
For example:

commit 7c0f6ba682b9c7632072ffbedf8d328c8f3c42ba
Author: Linus Torvalds <torvalds@linux-foundation.org>
Replace <asm/uaccess.h> with <linux/uaccess.h> globally

-Deepa


On Tue, Mar 6, 2018 at 2:58 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> On Tue, Mar 6, 2018 at 4:48 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>>
>>
>> On 03/06/2018 01:46 PM, Arnd Bergmann wrote:
>>> On Mon, Mar 5, 2018 at 10:30 AM, Christian Borntraeger
>>> <borntraeger@de.ibm.com> wrote:
>>>> On 01/16/2018 03:18 AM, Deepa Dinamani wrote:
>>>>> All the current architecture specific defines for these
>>>>> are the same. Refactor these common defines to a common
>>>>> header file.
>>>>>
>>>>> The new common linux/compat_time.h is also useful as it
>>>>> will eventually be used to hold all the defines that
>>>>> are needed for compat time types that support non y2038
>>>>> safe types. New architectures need not have to define these
>>>>> new types as they will only use new y2038 safe syscalls.
>>>>> This file can be deleted after y2038 when we stop supporting
>>>>> non y2038 safe syscalls.
>>>>
>>>> You are now include a <linux/*.h> from several asm files
>>>> (
>>>>  arch/arm64/include/asm/stat.h
>>>>  arch/s390/include/asm/elf.h
>>>>  arch/x86/include/asm/ftrace.h
>>>>  arch/x86/include/asm/sys_ia32.h
>>>> )
>>>> It works, and it is done in many places, but it looks somewhat weird.
>>>> Would it make sense to have an asm-generic/compate-time.h instead? Asking for
>>>> opinions here.
>>>
>>> I don't think we have such a rule. If a header file is common to all
>>> architectures (i.e. no architecture uses a different implementation),
>>> it should be in include/linux rather than include/asm-generic, regardless
>>> of whether it can be used by assembler files or not.
>>>
>>>>> --- a/drivers/s390/net/qeth_core_main.c
>>>>> +++ b/drivers/s390/net/qeth_core_main.c
>>>>> @@ -32,7 +32,7 @@
>>>>>  #include <asm/chpid.h>
>>>>>  #include <asm/io.h>
>>>>>  #include <asm/sysinfo.h>
>>>>> -#include <asm/compat.h>
>>>>> +#include <linux/compat.h>
>>>>>  #include <asm/diag.h>
>>>>>  #include <asm/cio.h>
>>>>>  #include <asm/ccwdev.h>
>>>>
>>>> Can you move that into the other includes (where all the other <linux/*> includes are.
>>>
>>> Good catch, this is definitely a rule we have ;-)
>>
>> FWIW, this was also broken for
>> arch/x86/include/asm/sys_ia32.h
>
> The reason that this was done this way is because of the sed script
> mentioned in the commit text.
> I was trying to make minimal change apart from the script so that we
> don't have other changes like moving the lines to keep the patch
> simpler.
> I will fix this by hand since this is preferred.
> I will post an update.
>
> -Deepa
