Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2467728-1524400732-2-9197749367322424960
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524400731; b=a3OKdhD9RCi9aLdH6/dWkP/ppioQuLr9xYBzvZS59yjlysD3Qa
    70zziZwgfOkxrwQc5GVHB3Q1gWiQgS9bLk1q5OKcVOqeHds6JPrZn/KD7bJscg8z
    uYMED/aNRtcYVRYUf0NbbPpWc+iNQYJzGvr36II9ghylT3oR/Pcod/Q0LuLsOagQ
    5lW8cz9hLzLFaiyJ4MMqdzFERkq/nenfNfWvirpousKzEl3bOeCBHekcjqbtoIQB
    jyu6lCDVU9YRsdaSKkX3ZkmDnKgptQJGRhqeNZexslyrjcjrcGsb8DXRD0hiWsuB
    OzRZr1Wwk7esJz8itBOOnVcVRbAhW2KQtSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524400731; bh=hDrYZ1Jli9k/fRWy1TXm6wPhsrefp8+LNq21CimVz+
    8=; b=f6tMqRiXv0ckPmaiHMbN4M7fIrzIl5aOlCFTyX7V6b7qSGXYp8QQdsEoy4
    4NvFs8pPmwFID6G5NGjx1uHbvEWACv/R70AcPzOUt7uWy6dK3leHXRmiZQxqOve7
    o5hcU/I7fPcBv1sGa1o/Dj/iDg3E1Y70ToaDU0bSFEhGgEdY7aIIJGRoBQAPGIom
    nkvhgGrXPqYl7jpKb6y6shKBrmO4BkHb7cPX4Kg8Y9z7yKKTFnOYIgOfq7QquWkf
    DL478UUihVcSQdOHmUVHW8/45h08WJJO8yYFT0lEQ6xWHB8QdWZYAiNX7r/KBlJ9
    qZZCyrU9r8y8PNmGMx2xrTJr8/4g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=R1JwNAR1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cuhBVmK6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=R1JwNAR1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cuhBVmK6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO4sCf7wVontaqIfBXw2TziFTMK0G6ESnOcABrKvry0u/cyU80PQxX+san1SczpSzLDkR8k6ryIXgYvUSNF1Fabo5tcfgLdd9pzK1qOjqhx7vQdv2Mf+
    GTUvdwDt79oDLOQJQ+ub4EfacLh8mTNSQ/vagESdLvMuMoEgLZIosFPUbgdr/HgI2eoKgIXxTUyDXcFcNagFToEYTS+Z5+UXg+p2l9hWRRdtE56ucowcTNHf
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=sbkbwEFO-6kA:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=Twlkf-z8AAAA:8
    a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=FCTe_MH5GrjgDZAMCUEA:9 a=QEXdDO2ut3YA:10
    a=Kgqpz72HzxEA:10 a=x8gzFH9gYPwA:10 a=-74SuR6ZdpOK_LpdRCUo:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeDVMiu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 08:38:50 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36115 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeDVMis (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 22 Apr 2018 08:38:48 -0400
X-Google-Smtp-Source: AB8JxZoXamGV+Dj/w2Q6SZOp/EOWIrfp3OZWsQNyT9Xb8MxcmKAIMXFrKpXU4nsGHUBVvFidOCQm9GQGgs05fxAthqE=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0nL4B+t6BMRhr36RrZ_jDgwnY1BviNPD+cFzsUGeppmA@mail.gmail.com>
References: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
 <20180420130346.3178914-1-arnd@arndb.de> <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
 <CAK8P3a0nL4B+t6BMRhr36RrZ_jDgwnY1BviNPD+cFzsUGeppmA@mail.gmail.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Sun, 22 Apr 2018 05:38:45 -0700
Message-ID: <CAMe9rOrTzgDmCF+A7nYdGR6BHZBuK5SMnJxeRxBFQW00VmdXvg@mail.gmail.com>
Subject: Re: [PATCH] x86: ipc: fix x32 version of shmid64_ds and msqid64_ds
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeffrey Walton <noloader@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Daniel Schepler <dschepler@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Thorsten Glaser <tg@mirbsd.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "# 3.4.x" <stable@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 7:38 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Apr 20, 2018 at 3:53 PM, Jeffrey Walton <noloader@gmail.com> wrote:
>>> +#if !defined(__x86_64__) || !defined(__ilp32__)
>>>  #include <asm-generic/msgbuf.h>
>>> +#else
>>
>> I understand there's some progress having Clang compile the kernel.
>> Clang treats __ILP32__ and friends differently than GCC. I believe
>> ILP32 shows up just about everywhere there are 32-bit ints, longs and
>> pointers. You might find it on Aarch64 or you might find it on MIPS64
>> when using Clang.
>>
>> I think that means this may be a little suspicious:
>>
>>     > +#if !defined(__x86_64__) || !defined(__ilp32__)
>>
>> I kind of felt LLVM was wandering away from the x32 ABI, but the LLVM
>> devs insisted they were within their purview. Also see
>> https://lists.llvm.org/pipermail/cfe-dev/2015-December/046300.html.
>>
>> Sorry about the top-post. I just wanted to pick out that one piece.
>
> It seems I made a typo and it needs to be __ILP32__ rather than
> __ilp32__ (corrected that locally, will resend once we have resolved
> this).
>
> Aside from that, the #if check seems to be correct to me: this
> is an x86-specific header, so it won't ever be seen on other
> architectures. On x86-32, __x86_64__ isn't set, so we don't care
> about whether __ilp32__ is set or not, and on x86-64 (lp64),
> __ilp32__ is never set, so we still get the asm-generic header.
>

Glibc has correct header files for system calls.  I have a very old
program to check if Linux kernel header files are correct for user
space:

https://github.com/hjl-tools/linux-header

It needs update to check uapi.

-- 
H.J.
