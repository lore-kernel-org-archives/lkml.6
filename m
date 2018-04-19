Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4107594-1524176057-2-11083096330929654802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524176056; b=jjw4LGF7aFFPuqE2U4n8qDcqkHf6B3XcArDDVB0aDJCaxlNEkZ
    4xbCje7vRt3lsB01lY0iQ9p2flsr4gx3msLHQsKeFNjpzzViJ7aBXO96T6VYtjhm
    SsqCOB2cnWy7cowaIG05gAUrMw8KRXa2DSBLR3Y7BvAl46KrB1abNjrcVbK/OKp9
    GNRXAkT5CHoCwwiFQfe8YGbFA04MqXho+cf568YhW+m1uGZ61vx496Q1gcuLDOlq
    IrsE/a8QBJLlDHABVowHfxiqtf1Pgmx3Z6rG234i6ccwRNTtlQyAWgU9fKAYlMwH
    /P6z20SEc+4fo2qbu1EexIx23NTLFGclvj5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1524176056; bh=peIkgM4MJoounC4vmFzaYrjR5fisP085tf7Bi2C8ux
    I=; b=p3ilsOX3vPwO0RoI/Rhg4XdwI7XvHmEFsSudhYzjqWx4U9Tg/libKovVxU
    IV4qdRAma8NyxKpuxnSXJvWeElO7Tk3gPZHasnZ9pp8kZ81oC1NC879A7Gsm7nQq
    hoQswRw5UkRN0+lqizcGyhRPpC+804X6XGdYRFkHm4yKGBm1gCWN4Wcpuge0/tCb
    NT0CSG2RVYRbIjmlVEqsrjKeom2OVz02/GT5EtOVT8ESKWD6EP5fpdrtTmHo3VCU
    d568XvgYnaIIBTP0UoHKh+tb+k/xW61AaTj7CXjZpOVOIxUouxAxBoPWRwv3L54t
    bZS2rKqe9uptPBxma/Q/V1WPnxfQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDZazHevxZYzhZ0swMAaggfG279KUtWYfYuk+iKQXR/rBP8EbiyoehsUqkfU8EnIv4Oq//uJvGXv32V/YvrSFJ2gsjNHKErddvlZxGYN1w9MVmfERD+u
    c0oRHaKYiChekE3b3ao1/orfJ10XXmBMUKrfVjstx6gdoHuFB6GSH90dUjvMHqFTcipcuRdwbH+xZ6YyVoUix62a8L/VPDxaeNUCeQtmQtw6dqzG1inm76VP
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=PtDNVHqPAAAA:8
    a=VwQbUJbxAAAA:8 a=vXCmvGlJNCxjomOxAAoA:9 a=x8gzFH9gYPwA:10
    a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbeDSWOP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 18:14:15 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:36278 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753505AbeDSWON (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 18:14:13 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arnd Bergmann <arnd@arndb.de>
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
        "the arch\/x86 maintainers" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list\:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>
References: <20180419143737.606138-1-arnd@arndb.de>
        <20180419143737.606138-2-arnd@arndb.de> <87efjbnswr.fsf@xmission.com>
        <CAK8P3a196QYoM1egagMuZw4WhiwRiO83Qpj0CxoCeVQBEaj-gw@mail.gmail.com>
        <CAK8P3a2KR+0ZE5jHSmO6pSuiRPH83p75KetuQuHL1atChcTJGA@mail.gmail.com>
Date: Thu, 19 Apr 2018 17:12:46 -0500
In-Reply-To: <CAK8P3a2KR+0ZE5jHSmO6pSuiRPH83p75KetuQuHL1atChcTJGA@mail.gmail.com>
        (Arnd Bergmann's message of "Thu, 19 Apr 2018 23:24:36 +0200")
Message-ID: <87k1t2n8v5.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f9Hof-0001gj-HG;;;mid=<87k1t2n8v5.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+3IVf4W+hDDI3xzIJJIXsq3cS4c3cNqsg=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa05.xmission.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4010]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ;Arnd Bergmann <arnd@arndb.de>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 337 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.3 (1.0%), b_tie_ro: 2.3 (0.7%), parse: 1.44 (0.4%),
        extract_message_metadata: 28 (8.3%), get_uri_detail_list: 3.2 (1.0%),
        tests_pri_-1000: 14 (4.1%), tests_pri_-950: 1.74 (0.5%), tests_pri_-900: 1.44
        (0.4%), tests_pri_-400: 31 (9.3%), check_bayes: 30 (8.9%), b_tokenize: 13
        (3.8%), b_tok_get_all: 8 (2.4%), b_comp_prob: 3.0 (0.9%), b_tok_touch_all:
        2.9 (0.8%), b_finish: 0.77 (0.2%), tests_pri_0: 241 (71.4%),
        check_dkim_signature: 0.72 (0.2%), check_dkim_adsp: 3.4 (1.0%),
        tests_pri_500: 11 (3.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 01/17] y2038: asm-generic: Extend sysvipc data structures
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> writes:

> On Thu, Apr 19, 2018 at 5:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Apr 19, 2018 at 4:59 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>> I suspect you want to use __kernel_ulong_t here instead of a raw
>>> unsigned long.  If nothing else it seems inconsistent to use typedefs
>>> in one half of the structure and no typedefs in the other half.
>>
>> Good catch, there is definitely something wrong here, but I think using
>> __kernel_ulong_t for all members would also be wrong, as that
>> still changes the layout on x32, which effectively is
>>
>> struct msqid64_ds {
>>      ipc64_perm msg_perm;
>>      u64 msg_stime;
>>      u32 __unused1;
>>      /* 32 bit implict padding */
>>      u64 msg_rtime;
>>      u32 __unused2;
>>      /* 32 bit implict padding */
>>      u64 msg_ctime;
>>      u32 __unused3;
>>      /* 32 bit implict padding */
>>      __kernel_pid_t          shm_cpid;       /* pid of creator */
>>      __kernel_pid_t          shm_lpid;       /* pid of last operator */
>>      ....
>> };
>>
>> The choices here would be to either use a mix of
>> __kernel_ulong_t and unsigned long, or taking the x32
>> version back into arch/x86/include/uapi/asm/ so the
>> generic version at least makes some sense.
>>
>> I can't use __kernel_time_t for the lower half on 32-bit
>> since it really should be unsigned.
>
> After thinking about it some more, I conclude that the structure is simply
> incorrect on x32: The __kernel_ulong_t usage was introduced in 2013
> in commit b9cd5ca22d67 ("uapi: Use __kernel_ulong_t in struct
> msqid64_ds") and apparently was correct initially as __BITS_PER_LONG
> evaluated to 64, but it broke with commit f4b4aae18288 ("x86/headers/uapi:
> Fix __BITS_PER_LONG value for x32 builds") that changed the value
> of __BITS_PER_LONG and introduced the extra padding in 2015.
>
> The same change apparently also broke a lot of other definitions, e.g.
>
> $ echo "#include <linux/types.h>" | gcc -mx32 -E -xc - | grep -A3
> __kernel_size_t
> typedef unsigned int __kernel_size_t;
> typedef int __kernel_ssize_t;
> typedef int __kernel_ptrdiff_t;
>
> Those used to be defined as 'unsigned long long' and 'long long'
> respectively, so now all kernel interfaces using those on x32
> became incompatible!

That seems like a real mess.

Is this just for the uapi header as seen by userspace?  I expect we are
using the a normal kernel interface with 64bit longs and 64bit pointers
when we build the kernel.

If this is just a header as seen from userspace mess it seems
unfortunate but fixable.

Eric
