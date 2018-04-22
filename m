Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3359506-1524428246-2-4694396352006124219
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
    1524428245; b=WeDrB+hDUgMyiQBgkb57wj3mlBkZfn0EBKYj0w8fWE8SwX59Yg
    LY7uL4YnYi5pm9GMGmvfolyWiEcgHctbwh9+igSWa7pSNy2oyrEQbCS4PJeQfuqb
    8T/MwqZwXjwy8YIBK3IhjbbGBM9NEl7nQiGwIzWrSuii4ZGCq1mKOdkyALLHAiaP
    995Cbn2MA03VXOu6yDmgD1IEaVJL88rN8a7uLNjqr0GC6XVwIBSIEz/f/eHBGgrC
    kzsX8Fn7GFe/APkwv2p7sSqC3w+uMtY04uZ7sBRxhA3jh+M7eEdVonDuGOX1RLzJ
    +2RCdnwOngqwVOtwazO2CWozIeuwNquluQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524428245; bh=1uQSN5J/E6RwJCxLiesnw+bQ6Q4SCElfOBmNk8Q3sc
    8=; b=ZTeywdQ9+FOpjqSxE5SKcEFS76wuEim4DHn0LKA3AhWcQeu4mAB98fX2NU
    tpO7Si2+Oc+/tXwJAG34ofo+jyuSRiy1fseP1zhwGOTKiutf7IWM560hz8g+/4rf
    WpEbtCn8LWm8vYvANEdN8e1f6EKpX+M65xn9cL8J2Qda41/EThTDCLfNc5+blwnh
    E5lZ7KoQLFRnCcCWSLMJy24d6EK/aA6YqhS3p3xSGBjQaxjTA4VEvY8hJSw2TTFA
    7pi6/4IXXNaX92oNeY4UXXGpA2lgBt0eBUN/Sc5ZSsnICvADPQ0lim3le75pT5zt
    9ufmqeB31XQVs+72/1dH76xhkApw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Z34Q7+Xx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Jc7y46Yq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Z34Q7+Xx x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Jc7y46Yq;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDbfABO0UzYtrN+FSXaR2W6usskVmSq7ue+88Fy9DVA9AxtGAS+We5rbHmPpWr2veR3kJeFU1xOic6VJMVa1Sdnq9WKg4jDUIcD1Q6EG9orETvd+AsHP
    U9N+xlefUvEdnvNSyUbWxm9G+y9hwEto1XnlSkSswMM2bbx9VzZEIxqywzqCpLFVtAtCD4ty8pT9v/NwhMNMnRb+PZ7RvoPZgTn5XS1S9YOW9wxki56z3+/F
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=RaM1bK_GUlijsoETdyAA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbeDVURW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 16:17:22 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33476 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbeDVURU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 22 Apr 2018 16:17:20 -0400
X-Google-Smtp-Source: AB8JxZrMTSFoS+FuhqmEh/VcyJJZbgHPDVmpcebPUO/P3VyspvSKJEv6Mzy+PvKFatkiB1La3sRynJf36WmMc4TxEfo=
MIME-Version: 1.0
In-Reply-To: <CAMe9rOrTzgDmCF+A7nYdGR6BHZBuK5SMnJxeRxBFQW00VmdXvg@mail.gmail.com>
References: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
 <20180420130346.3178914-1-arnd@arndb.de> <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
 <CAK8P3a0nL4B+t6BMRhr36RrZ_jDgwnY1BviNPD+cFzsUGeppmA@mail.gmail.com> <CAMe9rOrTzgDmCF+A7nYdGR6BHZBuK5SMnJxeRxBFQW00VmdXvg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 22 Apr 2018 22:17:18 +0200
X-Google-Sender-Auth: B6d4cgFTHaZiRsNw6qgLg5lSQCk
Message-ID: <CAK8P3a2=nfW1YSJoTf_cj5DVSMVfzWYaYqG486FHD3vPw3YZfQ@mail.gmail.com>
Subject: Re: [PATCH] x86: ipc: fix x32 version of shmid64_ds and msqid64_ds
To: "H.J. Lu" <hjl.tools@gmail.com>
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
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "# 3.4.x" <stable@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 2:38 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
> On Fri, Apr 20, 2018 at 7:38 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Apr 20, 2018 at 3:53 PM, Jeffrey Walton <noloader@gmail.com> wrote:
>
> Glibc has correct header files for system calls.  I have a very old
> program to check if Linux kernel header files are correct for user
> space:
>
> https://github.com/hjl-tools/linux-header
>
> It needs update to check uapi.

Simply running 'make' on a regular distro shows this output:

--- kernel.x32.out 2018-04-22 22:10:16.053432423 +0200
+++ glibc.x32.out 2018-04-22 22:10:16.073432838 +0200
@@ -10,9 +10,9 @@ size of daddr_t: 4
 size of __ipc_pid_t: 4
 size of struct ipc_perm: 48
 size of mqd_t: 4
-size of struct msqid_ds: 144
+size of struct msqid_ds: 120
 size of struct semid_ds: 104
-size of struct shmid_ds: 136
+size of struct shmid_ds: 112
 size of struct shminfo: 72
 size of struct timeval: 16
 size of struct timespec: 16
@@ -22,8 +22,8 @@ size of struct mq_attr: 64
 size of struct rlimit: 16
 size of struct rusage: 144
 size of struct stat: 144
-size of struct statfs: 64
-size of struct statfs64: 88
+size of struct statfs: 120
+size of struct statfs64: 120
 size of struct timex: 208
 size of struct msginfo: 32
 size of struct msgbuf: 16

This seems plausible, the statfs structure clearly has the same problem
as msqid_ds/shmid_ds based on its usage of '__statfs_word' which is
now defined as '__u32' rather than '__kernel_long_t'.

It should be trivial to override __statfs_word from
arch/x86/include/uapi/asm/statfs.h

I've checked the other uses of __BITS_PER_LONG in the uapi
headers now, and all the others are either not relevant for x32
(either definition is fine) or it has to be __BITS_PER_LONG=32.

        Arnd
