Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1818344-1524235115-2-2290684831508210809
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
    1524235115; b=gOw/iORmIsAs5PwoYdr+fDoZHpdndjJoGVZZRnQYm7Q+9STsBQ
    3mANOTBbQKeE/TKmL2vmQ+niD6LMliih7vz+5w89wafj+0HIGo5RmOhksMxCT0Pr
    W4aN2Kho9+SHEvpewE6gFc2ARTlwrdCIEg9lpTS31fc54DEVBEgFV4Lxh7/9433U
    OnTIfU6ns+wgnug48sOjfj7/5tMe5c74/7hvXez77h5oI9u3Gr8ElWtpFatIdFVw
    pO8EHL5cheYEI0VD0qsHPR1sXT0Na9u7WkboTjZj2hXSNWhe6dAg8WqZAvOll5Fv
    e9Qsi2FBv7gvs/hKyoeL5DME3P8U/zOt6fCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524235115; bh=NJEk58FMwx/weUyxDdag9ApXBzo3/oc1gHfX4OMJh7
    I=; b=VZlesTc8x9FQSVvDQhk8PFtD+Q9E5RUBxCBNW3WMPvxB4/1BNHLxRZ+OsI
    3dUkXGrjhKIxDTryivXsgN7ovC7G8nmjqaP2wmfunmDBjHBg5GIE5leQOGODy94m
    fkMDY8y0JEtQtct3mDlv31NvPIZHN1ydRFZ/Q5xHMpdjjjLnlLyFGZRYhQzXCLLY
    Uiwooc9qY4IP3vhvlQze1YPYCYjnFisguNT7aZvJaKFiD0kO+nC8GsxU6xIn67jP
    kxGNaeYuEgX0c2xLcwPPXGlGyh02Zf1UDM5np0sRNPpyScXDTHKCFRaz03POZnEs
    J+uS1gA1GwTn9ejYhJzSB9SVdxOw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jsDjPzCN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=R78cBVG/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jsDjPzCN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=R78cBVG/;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJDEvMoZ+PKoxvXMwPJgkGQKGebqpk0AMN50yfJ1ydyC7Ixp9sJLC1bAWW0zov7ZOCkXHxl40qO3c0AoyhBRVkuQ0pphGKuNuGoT+bXFy20Q1Bf98eDc
    pH49YCEQ0YMkEhbMX2hbu4F7RhzoAGK3CNx1ejRL3vnYJXi1E08VZN1WrcQZEomzAOWXLvGYtOSjdq3r7u+/T6SSDuNnLDMa9jd+xXHAB5LsuYIHEXOnJl4R
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=Twlkf-z8AAAA:8 a=VwQbUJbxAAAA:8 a=E0QwUZ4RaUixXRYFx6YA:9
    a=QEXdDO2ut3YA:10 a=Kgqpz72HzxEA:10 a=x8gzFH9gYPwA:10
    a=-74SuR6ZdpOK_LpdRCUo:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755295AbeDTOid (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 10:38:33 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34651 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755071AbeDTOib (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Apr 2018 10:38:31 -0400
X-Google-Smtp-Source: AIpwx4/7TBwTVjIOe5IqMxQe3h3pFx3pXqcdGLqT5XTu3uywcswchrGOHDONgbkDy8+mck1Xqs5Eymfa1gY2aZ+X2uM=
MIME-Version: 1.0
In-Reply-To: <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
References: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
 <20180420130346.3178914-1-arnd@arndb.de> <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2018 16:38:29 +0200
X-Google-Sender-Auth: J-Jrsq7jwkqvvWVW0-6W9coGyEE
Message-ID: <CAK8P3a0nL4B+t6BMRhr36RrZ_jDgwnY1BviNPD+cFzsUGeppmA@mail.gmail.com>
Subject: Re: [PATCH] x86: ipc: fix x32 version of shmid64_ds and msqid64_ds
To: Jeffrey Walton <noloader@gmail.com>
Cc: "the arch/x86 maintainers" <x86@kernel.org>,
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
        "H . J . Lu" <hjl.tools@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>, tg@mirbsd.de,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "# 3.4.x" <stable@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 3:53 PM, Jeffrey Walton <noloader@gmail.com> wrote:
>> +#if !defined(__x86_64__) || !defined(__ilp32__)
>>  #include <asm-generic/msgbuf.h>
>> +#else
>
> I understand there's some progress having Clang compile the kernel.
> Clang treats __ILP32__ and friends differently than GCC. I believe
> ILP32 shows up just about everywhere there are 32-bit ints, longs and
> pointers. You might find it on Aarch64 or you might find it on MIPS64
> when using Clang.
>
> I think that means this may be a little suspicious:
>
>     > +#if !defined(__x86_64__) || !defined(__ilp32__)
>
> I kind of felt LLVM was wandering away from the x32 ABI, but the LLVM
> devs insisted they were within their purview. Also see
> https://lists.llvm.org/pipermail/cfe-dev/2015-December/046300.html.
>
> Sorry about the top-post. I just wanted to pick out that one piece.

It seems I made a typo and it needs to be __ILP32__ rather than
__ilp32__ (corrected that locally, will resend once we have resolved
this).

Aside from that, the #if check seems to be correct to me: this
is an x86-specific header, so it won't ever be seen on other
architectures. On x86-32, __x86_64__ isn't set, so we don't care
about whether __ilp32__ is set or not, and on x86-64 (lp64),
__ilp32__ is never set, so we still get the asm-generic header.

      Arnd
