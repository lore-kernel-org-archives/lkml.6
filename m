Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1575980-1520377132-2-7604737507912179282
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520377132; b=iM1jGGG1wPrjR882jqxSQ7Y2xOKL2JoeyH7+R7V24sJMThf
    mICnKd8Lq9Aoed08X489e5UYd08eG39g6PPtqgQoI540/Ud1fOFNcTJxdGMgGc2V
    Scfee9zslumVbxYhhoLjyemaCNnqBYOhL3JcauzZ7YRDYyD9p9dw8QU67v/pt0N8
    BGiKw3xUMvAkzq2cWN91iIvKutJ2TlVrJnS/c8p959kNGrRODWmCSOiSoCbgGUnk
    UTrXFHQnzN8hFfoXxcwLJJ6B32slQi6rI1xKX0cY1f+kOyAGZbPgciXfzUNmHnjn
    DbpujBtMgiKBhtaeb57a4hojxjAeKyJkIDqHZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520377132; bh=m
    CFRVIdGROkgGGYNG6Jp+kamSaMJTEEKY80OGiu4OlQ=; b=dHN/eMANAjZc/73Xi
    X6hLNikTRMixD4eLyd1sKKhefuO6YbOGMmzS0PsaAWGg+Q7o1XDTWPlBueGX6Fkc
    Zc2GIC1vzJR+sSrbDU6gcmhkx/Wqibi9sD9LYB1AfDzmZfY+88O0v6xqN3NCRzS/
    n0bBLvRd+KEf3vC24IbRYOpwXTFywaB0leKRbdlaU8hfVbL8+pcDpg/Y/tT51F7F
    lmKPXxBEtSWTkc6S8676KSfvS0drOznejcJky4k7Oor1Qya+WSSR5DKVGQlUEMz2
    wR6r+LWmEQY5BAHaNbzKOWFtwzuHcFIF/W9NPAMY+DswQW3L26mVNYQhs8f3Q0ZZ
    4nMuA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gUraEbqP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CoMnpdsD;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=gUraEbqP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CoMnpdsD;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsmJN8yNz+BRsMefbs2x+SMW+reVHYxfQ7BxSZZVCKfWHNsSj5DcwWeXuw8MQFANCbTd4ex6/oC1+DGwK0bSt0=
MIME-Version: 1.0
In-Reply-To: <d8480da9-afe9-8a43-9c47-50919215a2de@de.ibm.com>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
 <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
 <CAK8P3a0Gm1L70EaFzJBk0drRNKtX0FE22BHOSrXBgH1wNfKZ5A@mail.gmail.com>
 <d8480da9-afe9-8a43-9c47-50919215a2de@de.ibm.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Tue, 6 Mar 2018 14:58:45 -0800
Message-ID: <CABeXuvrdPV0q4ufuxEnqT6T3b8pCT5RLUfuAZ_cwXr0it8gj0Q@mail.gmail.com>
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
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>,
 devel@driverdev.osuosl.org, linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>,
 oprofile-list@lists.sf.net, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
 Robert Richter <rric@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>,
 Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Tue, Mar 6, 2018 at 4:48 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
> On 03/06/2018 01:46 PM, Arnd Bergmann wrote:
>> On Mon, Mar 5, 2018 at 10:30 AM, Christian Borntraeger
>> <borntraeger@de.ibm.com> wrote:
>>> On 01/16/2018 03:18 AM, Deepa Dinamani wrote:
>>>> All the current architecture specific defines for these
>>>> are the same. Refactor these common defines to a common
>>>> header file.
>>>>
>>>> The new common linux/compat_time.h is also useful as it
>>>> will eventually be used to hold all the defines that
>>>> are needed for compat time types that support non y2038
>>>> safe types. New architectures need not have to define these
>>>> new types as they will only use new y2038 safe syscalls.
>>>> This file can be deleted after y2038 when we stop supporting
>>>> non y2038 safe syscalls.
>>>
>>> You are now include a <linux/*.h> from several asm files
>>> (
>>>  arch/arm64/include/asm/stat.h
>>>  arch/s390/include/asm/elf.h
>>>  arch/x86/include/asm/ftrace.h
>>>  arch/x86/include/asm/sys_ia32.h
>>> )
>>> It works, and it is done in many places, but it looks somewhat weird.
>>> Would it make sense to have an asm-generic/compate-time.h instead? Asking for
>>> opinions here.
>>
>> I don't think we have such a rule. If a header file is common to all
>> architectures (i.e. no architecture uses a different implementation),
>> it should be in include/linux rather than include/asm-generic, regardless
>> of whether it can be used by assembler files or not.
>>
>>>> --- a/drivers/s390/net/qeth_core_main.c
>>>> +++ b/drivers/s390/net/qeth_core_main.c
>>>> @@ -32,7 +32,7 @@
>>>>  #include <asm/chpid.h>
>>>>  #include <asm/io.h>
>>>>  #include <asm/sysinfo.h>
>>>> -#include <asm/compat.h>
>>>> +#include <linux/compat.h>
>>>>  #include <asm/diag.h>
>>>>  #include <asm/cio.h>
>>>>  #include <asm/ccwdev.h>
>>>
>>> Can you move that into the other includes (where all the other <linux/*> includes are.
>>
>> Good catch, this is definitely a rule we have ;-)
>
> FWIW, this was also broken for
> arch/x86/include/asm/sys_ia32.h

The reason that this was done this way is because of the sed script
mentioned in the commit text.
I was trying to make minimal change apart from the script so that we
don't have other changes like moving the lines to keep the patch
simpler.
I will fix this by hand since this is preferred.
I will post an update.

-Deepa
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
