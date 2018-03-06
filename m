Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-347975-1520340400-2-1803333237824690528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520340399; b=q8HxLXbK7m5xNzojSoG6NzKdlcRiQPavtYeDV+scmu/w2gR
    lfxqKjbdKBXLgC0TBvXkG3Pqvw2bdsjRbFODJFEOeiqrnS22k+6+D12MJlONo4Pi
    0EqYdBKiM9r0HriDhZCO+7UG8JbjoJCdX7dLIyq+6DQulQGlcAoULQR4v5VQt0sk
    JekAGnSxt9bwIAo7FEHsOKBclu6zO+OwbvHq2oTNjEwGBsjsgZTuZpCHdkkmdLOF
    m58nGN6eNIFFN8Wo9/JfKloy0o608vrOFyXIzF/a+QPA7rp6R3SBJuRls2SBPmxO
    8KQ+3w5Ab7Nv2lyjxqVFY3iZQR7OMAujts+YuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520340399; bh=Y
    8xJq4lcH1XGoDe/vZDBRJHhHeVC11fuCdYHQ+2/dTw=; b=JR1riL9TtsR/wReri
    uKSguW8WRha4UBOHfJCp/+Hjv9E4ADc/65kHP07fYYJ1Us/dC1VulDqpQuzjaFmx
    bhcDPGrSNJrzlD2p942AS9AESOeKDwvm7qXMdrUlbqKIqhiHKz3yCubqbXZzWbv7
    CrkVv5Fb/78hwfr/EowIhKv92UWRbkHa2zk5E+Qz5fUvRKBY1kxC6jkH0dtMa4uM
    Av/AdnQUcAWqxJ2cO3r3gXIrZmoOjHv5Tj99O04TL0+mG0GsbCCbT60KjhYDDjsO
    dkCoUm0CdbblEx5U4NBX97BoIshaFiUCn8rEKGITLnKFnZUNPFdl2rS43A6avM/z
    7pyEQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eFOHlHtt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OR/Ae2yI;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=eFOHlHtt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=OR/Ae2yI;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELubcUMV/+p/AxAmTMPOWF9PblRAuLVhHE+k8ZdW1lB3Qhh5h6OFTi2hSjDKV9ynu+IUnH/10AD6Di9PnFGMwqU=
MIME-Version: 1.0
In-Reply-To: <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
 <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Mar 2018 13:46:30 +0100
X-Google-Sender-Auth: Di7AbiJq9u7xkF2XLlEyCPy3GA0
Message-ID: <CAK8P3a0Gm1L70EaFzJBk0drRNKtX0FE22BHOSrXBgH1wNfKZ5A@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
To: Christian Borntraeger <borntraeger@de.ibm.com>
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
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>, devel@driverdev.osuosl.org,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>,
 oprofile-list@lists.sf.net, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
 Robert Richter <rric@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>,
 Will Deacon <will.deacon@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Julian Wiedmann <jwi@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 gerald.schaefer@de.ibm.com, Parisc List <linux-parisc@vger.kernel.org>,
 gregkh <gregkh@linuxfoundation.org>, cohuck@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, David Miller <davem@davemloft.net>,
 Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
 Stefan Haberland <sth@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ursula Braun <ubraun@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 10:30 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
> On 01/16/2018 03:18 AM, Deepa Dinamani wrote:
>> All the current architecture specific defines for these
>> are the same. Refactor these common defines to a common
>> header file.
>>
>> The new common linux/compat_time.h is also useful as it
>> will eventually be used to hold all the defines that
>> are needed for compat time types that support non y2038
>> safe types. New architectures need not have to define these
>> new types as they will only use new y2038 safe syscalls.
>> This file can be deleted after y2038 when we stop supporting
>> non y2038 safe syscalls.
>
> You are now include a <linux/*.h> from several asm files
> (
>  arch/arm64/include/asm/stat.h
>  arch/s390/include/asm/elf.h
>  arch/x86/include/asm/ftrace.h
>  arch/x86/include/asm/sys_ia32.h
> )
> It works, and it is done in many places, but it looks somewhat weird.
> Would it make sense to have an asm-generic/compate-time.h instead? Asking for
> opinions here.

I don't think we have such a rule. If a header file is common to all
architectures (i.e. no architecture uses a different implementation),
it should be in include/linux rather than include/asm-generic, regardless
of whether it can be used by assembler files or not.

>> --- a/drivers/s390/net/qeth_core_main.c
>> +++ b/drivers/s390/net/qeth_core_main.c
>> @@ -32,7 +32,7 @@
>>  #include <asm/chpid.h>
>>  #include <asm/io.h>
>>  #include <asm/sysinfo.h>
>> -#include <asm/compat.h>
>> +#include <linux/compat.h>
>>  #include <asm/diag.h>
>>  #include <asm/cio.h>
>>  #include <asm/ccwdev.h>
>
> Can you move that into the other includes (where all the other <linux/*> includes are.

Good catch, this is definitely a rule we have ;-)

       Arnd
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
