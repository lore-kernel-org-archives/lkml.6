Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2061918-1521043972-5-1014446374165058121
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521043972; b=br7p2J+duEURjmxTJ0dG0Fon7xsI0ldFhOMLwtjZXmLt1rR
    2f7JiUBBj25V1O7AwlAKdJwCrNkMO3oomHm4c/PrBgIA2SXa2PFsy5+Y4JpG5VVx
    Vnic4BrGKFO6Wj1EEdX89mT/5NNZoVcJ4jYoFOz0vVlouUVaTH3KqGYQH5JHDs/a
    Umz1uZ+LAggljgypDfQ8C4lQq3tFKS2szdJpcd4sv9Za7hdHTIHGj9tkFviUOCER
    IkfWB2mNwBzk5o0XqVOZs0Akmgqn4KO+BTNUSvfMOX/IJ1mjLay/o/JvHA3tkil9
    LMwD0jQCclwaMgf9JVUklbwUCqGvmTWsInaX+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521043972; bh=w
    tPGcysMbLQle0NFQqG3rceEL2jyc3F2pezvusnpBJ4=; b=Qsmp+RVVa/H3n5y1m
    u50N2hOU8NrsXVMjGIr665Z/0Fyl2/kdQhH0+XBNEVvaQNzz/+iQ9OH+K+w9CpiP
    8WP87CanYOdotJfNqOvW2edXI3lyqUpYbC1jFheWra4dxsPTyzeF8iDyHtXPKVOv
    AbFb2JxIy5vC1BTOwBNXPW85ABYdnvSyF8oOy7yUhlGFxwD5h3OW1tgaKaw24obV
    oJLMQGYoJF1SAlQykQDFVMGLs9sBGGMygxecCwLH8NltAPGUeOw89WzAjeFDmhbn
    ajBS3c9FnaGBAfT4tz5TRJgNz+rxEAa6RG90lBXrVjl2PG6V72dGeXhj687C1fRu
    i3HVQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ppKoJqps x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pml6KVgJ;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ppKoJqps x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pml6KVgJ;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELttrolLvbH6pRWypHIk4oaUmp3fA0Mub2DNQZPCyhlM9dLz1gia3Qw2E7NjjxwliykkMaJzQUrnVxn1Ptp6LQk=
MIME-Version: 1.0
In-Reply-To: <20180314040333.3291-1-deepa.kernel@gmail.com>
References: <20180314040333.3291-1-deepa.kernel@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 17:12:44 +0100
X-Google-Sender-Auth: luhBzRJ6eLFWYRsu7hdv5zZRR4g
Message-ID: <CAK8P3a3hbD=-P1wBwXEOnMdewGsUpZPERBHv6wo+3qqDkZD1qg@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] posix_clocks: Prepare syscalls for 64 bit time_t
 conversion
To: Deepa Dinamani <deepa.kernel@gmail.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stefan Haberland <sth@linux.vnet.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 devel@driverdev.osuosl.org, linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Will Deacon <will.deacon@arm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 oprofile-list@lists.sf.net, Catalin Marinas <catalin.marinas@arm.com>,
 linux-arch <linux-arch@vger.kernel.org>, Robert Richter <rric@kernel.org>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Julian Wiedmann <jwi@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ursula Braun <ubraun@linux.vnet.ibm.com>, gerald.schaefer@de.ibm.com,
 Parisc List <linux-parisc@vger.kernel.org>,
 gregkh <gregkh@linuxfoundation.org>, cohuck@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
 Linux API <linux-api@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 5:03 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> The series is a preparation series for individual architectures
> to use 64 bit time_t syscalls in compat and 32 bit emulation modes.
>
> This is a follow up to the series Arnd Bergmann posted:
> https://sourceware.org/ml/libc-alpha/2015-05/msg00070.html [1]
>
> Thomas, Arnd, this seems ready to be merged now.
> Can you help get this merged?
>
> Big picture is as per the lwn article:
> https://lwn.net/Articles/643234/ [2]
>
> The series is directed at converting posix clock syscalls:
> clock_gettime, clock_settime, clock_getres and clock_nanosleep
> to use a new data structure __kernel_timespec at syscall boundaries.
> __kernel_timespec maintains 64 bit time_t across all execution modes.
>
> vdso will be handled as part of each architecture when they enable
> support for 64 bit time_t.
>
> The compat syscalls are repurposed to provide backward compatibility
> by using them as native syscalls as well for 32 bit architectures.
> They will continue to use timespec at syscall boundaries.
>
> CONFIG_64_BIT_TIME controls whether the syscalls use __kernel_timespec
> or timespec at syscall boundaries.
>
> The series does the following:
> 1. Enable compat syscalls on 32 bit architectures.
> 2. Add a new __kernel_timespec type to be used as the data structure
>    for all the new syscalls.
> 3. Add new config CONFIG_64BIT_TIME(intead of the CONFIG_COMPAT_TIME in
>    [1] and [2] to switch to new definition of __kernel_timespec. It is
>    the same as struct timespec otherwise.
> 4. Add new CONFIG_32BIT_TIME to conditionally compile compat syscalls.

I've applied all 10 patches to my y2038 git branch [1], which is part
of linux-next,
to give it a little wider testing. If everything goes well, I'd send a
pull request to
Thomas next week so he can integrate it into tip from there, or (if he prefers)
send it directly to Linus in the merge window.

Thanks a lot for your persistence and your work on this!

      Arnd

[1] git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git#y2038
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
