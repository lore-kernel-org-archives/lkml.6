Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3387646-1524151246-2-5375153082793864948
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524151245; b=oZTVUaE1Gwg20Lu/CPVLfE1p99OrJ2umzQ3JW6/oppnsTEk34b
    oRMErT+tZCUORsbXjfQp05NShYnvC6bHXNUCKhC2uDX7OWTyvwqaVbto17D9XZAr
    MDFo/j7c7YFBJoPSzG1QvU7bN170jzfzKaQ6sefq0dr1IhuO9iw2RQC1PgfXp+di
    P62A341MhTwoaiBGCg/R96HIy5vNmrSsX2afjEddZL3wB40yPm7775Q33HhyHowj
    cJVa+rRu4ZGiUZgkVzohF6KhIdz9GAxmL+b29jevw5qdK69SBOB68VPChCsHBzAF
    An0cfgMGI/ZiHOqy7FgGXvCGV14FqSYylYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524151245; bh=bpYzPNBC+T2fCqTee228ULUCyjT5zSqOk5zghDvNbR
    8=; b=QYxj05/6DPb3bJDOze3uUYmjAd5IbTWF06TA0d1tOQaniDhIjscNfJsgVs
    8QVpsOsOUJgbp0ZdV/wVTIQ0ASx6FC71qMxnc5FD58YgeH8/geN6rW+Obgqhdxd1
    f4t5EWbZzFEeRmIYFrwRLVcWsSfswNc9PvjXWWn1n9LhV3mXAKe/FD5xXtvzJIvq
    IA98KNSGYCYrLHKUlz2qYBRlt4vDCa1ae0JMBNOLm02ZrZyeukcmMQ/RbnZfHrlf
    rCoLR7cZiyp8zVanu9MjKd/2lW3rTufcC9dWONhQu4GquosqMrxNSeqbZ4mACJTl
    K6B2bqZVUEeqWWiJABOgEaD2ShDA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TazQzDct x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UK23ZjCk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TazQzDct x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UK23ZjCk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEa12kbcHBaHEhqcUfsdcxC0OLvYLMOrHRUMJcWfGCzA+UOFzTQv2ixc+dNQZp2TOQriCoZX5HmxKAaleEK9+hW2eAeZCLXPtRi9bvpbrYgjv1Z4mtWy
    O2VnJzKYtrh98RdWen4nKOrF2w9P5pmLIXTSEuBJgCCcCx6bBOQMDZeZqKW9L8VKJt1K9H5wB26WlBWiMSeP3JpuAjrUwoohoYOyA4WZpLqJeJG91/BcSj2O
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=OvE_N-_SyrjeL8scQ0YA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbeDSPUa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:20:30 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:37520 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbeDSPU2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 11:20:28 -0400
X-Google-Smtp-Source: AB8JxZrrZngmnrtPSk6mU3jvw75Zmlsqb9D0zZU0PNL7l1XQAxqeJp51o+E7zonRlr/9b9Gf4W/xtxh+42p/hno0yCA=
MIME-Version: 1.0
In-Reply-To: <87efjbnswr.fsf@xmission.com>
References: <20180419143737.606138-1-arnd@arndb.de> <20180419143737.606138-2-arnd@arndb.de>
 <87efjbnswr.fsf@xmission.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 17:20:26 +0200
X-Google-Sender-Auth: IR-EMjEf3Q0OPA5FsBjeRvhowTg
Message-ID: <CAK8P3a196QYoM1egagMuZw4WhiwRiO83Qpj0CxoCeVQBEaj-gw@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] y2038: asm-generic: Extend sysvipc data structures
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 4:59 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>>
>>  struct msqid64_ds {
>>       struct ipc64_perm msg_perm;
>> +#if __BITS_PER_LONG == 64
>>       __kernel_time_t msg_stime;      /* last msgsnd time */
>> -#if __BITS_PER_LONG != 64
>> -     unsigned long   __unused1;
>> -#endif
>>       __kernel_time_t msg_rtime;      /* last msgrcv time */
>> -#if __BITS_PER_LONG != 64
>> -     unsigned long   __unused2;
>> -#endif
>>       __kernel_time_t msg_ctime;      /* last change time */
>> -#if __BITS_PER_LONG != 64
>> -     unsigned long   __unused3;
>> +#else
>> +     unsigned long   msg_stime;      /* last msgsnd time */
>> +     unsigned long   msg_stime_high;
>> +     unsigned long   msg_rtime;      /* last msgrcv time */
>> +     unsigned long   msg_rtime_high;
>> +     unsigned long   msg_ctime;      /* last change time */
>> +     unsigned long   msg_ctime_high;
>>  #endif
>
> I suspect you want to use __kernel_ulong_t here instead of a raw
> unsigned long.  If nothing else it seems inconsistent to use typedefs
> in one half of the structure and no typedefs in the other half.

Good catch, there is definitely something wrong here, but I think using
__kernel_ulong_t for all members would also be wrong, as that
still changes the layout on x32, which effectively is

struct msqid64_ds {
     ipc64_perm msg_perm;
     u64 msg_stime;
     u32 __unused1;
     /* 32 bit implict padding */
     u64 msg_rtime;
     u32 __unused2;
     /* 32 bit implict padding */
     u64 msg_ctime;
     u32 __unused3;
     /* 32 bit implict padding */
     __kernel_pid_t          shm_cpid;       /* pid of creator */
     __kernel_pid_t          shm_lpid;       /* pid of last operator */
     ....
};

The choices here would be to either use a mix of
__kernel_ulong_t and unsigned long, or taking the x32
version back into arch/x86/include/uapi/asm/ so the
generic version at least makes some sense.

I can't use __kernel_time_t for the lower half on 32-bit
since it really should be unsigned.

        Arnd
