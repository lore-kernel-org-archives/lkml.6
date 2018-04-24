Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3120174-1524577400-2-2021511486526019989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524577399; b=UtVvzRhBMs1KLGGEFyrNZrPacS44CPwYT+TKgWyJ6Ret1L0fDe
    l4ZLcfvrNdGGU2W+M+r7/uqfO5/RHnTHdUKdDVHLFAxtXLPQAFGsACVEUaNdgaf0
    xwjoqxvH3MZ17qSaM5Vm01rrdIo1vBDUvOZjfvBW8DuUkRGj1KW8TDmKNaqsnxfY
    q5XOAi9GWKjNNzLNP8+wXnDyVT4+M5+e7sZPcodX/Ydp88m/TCC2bTnV1bmcMNcd
    SDwkV5CIfoQFQ2yvhhoocxn9c75g5I16uTl0NeNjGN+OqWJfp8nkwZ49yPjm8Fch
    vnbY4RedltdhpcNqK8UZGnPatg0HLcAYqjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:cc:content-type:sender:list-id; s=fm2; t=1524577399; bh=PfUB
    YHj8zPhjlyPNcWoCRZpMls5g7jjk/+HUKAe4EeQ=; b=U6aTjlfowt48XNNY85PR
    Cf1q5fUeB+PwVCEHj28SykElIE+bMClkUIakE3B4z/vfTlzxKCPkQxpVMMbt6x3g
    vmAk8Ma3gVUWHL+FRmB2JLRb9s+K/c2WyecrMGZjotWEbcD73Qpu/gD6Efgc+M4N
    DcAwI2RmbGxUsCdFw1ibRDKyw9Yzzden8o058+hyv1JQSO8iwY+m1USMtOba1+3h
    NwGuI2dJVqq6a6oAEBnDhmnCFTr2fLgOwjdkpb5paIyGgGnpdYDUu8pQoItfQaG1
    KosbF0G4rhzmyrmWPaqx17V1ta/+TUKeOc4Lqdjm0NoJe+bc7EzFpzrWLcrw2VRG
    3g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha1) header.d=zx2c4.com header.i=@zx2c4.com header.b=D/1igYsG x-bits=2048 x-keytype=rsa x-algorithm=sha1 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=zx2c4.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zx2c4.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha1) header.d=zx2c4.com header.i=@zx2c4.com header.b=D/1igYsG x-bits=2048 x-keytype=rsa x-algorithm=sha1 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=zx2c4.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zx2c4.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNcgY2ycYBDT9knN6M+Q9DbPv9USzmTIk2QKmrJYQRR/mPcvAn67WCxMamhQkBnUaZTcPtSR6Gxc5Ag7xSJm8o3Od8I2dUa5fvZagWxvZPsSwJju7/Vs
    wzBJsqfD60Z/9x7KoGlMNqVzpWyHuj8Opx9ppXiAqTm0FDu7nW1vLNHqrpVjOJof7yXFXjhCiTnYHRJ4ROmHGKZAZ99khWcdDceuvVOHQfJHyc5mbtnJbTv8
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=2Lwgj4gv75OPMQALsuYA:9 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933385AbeDXNnM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 09:43:12 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:36959 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933512AbeDXNnJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 24 Apr 2018 09:43:09 -0400
X-Google-Smtp-Source: AIpwx4+7C2jTCi34zIfmTK7fvYBSp0+bXk7Jmld/n2JMpAFrGzc1iAw2Rz3VFBTYqUe/B/u4rskKlFHzpfae1lUgF/I=
MIME-Version: 1.0
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 24 Apr 2018 15:43:04 +0200
X-Gmail-Original-Message-ID: <CAHmME9oO_5X6M3NLe2tWp=ZY5EQY17GQ6BUomHLBscMejiXTvw@mail.gmail.com>
Message-ID: <CAHmME9oO_5X6M3NLe2tWp=ZY5EQY17GQ6BUomHLBscMejiXTvw@mail.gmail.com>
Subject: Re: [PATCH] arm64: export tishift functions to modules
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        PaX Team <pageexec@freemail.hu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 3:34 PM, Will Deacon <will.deacon@arm.com> wrote:
> I've not run into any build issues here -- is this specifically with some
> out-of-tree module?

I received a bug report email about this. I'm not sure which specific
module, and I assumed from the email that it was actually a result of
in-tree configuration options rather than an out-of-tree module, but
I'm not sure exactly. Either way, I was able to reproduce the problem
by coding up a little PoC out-of-tree module, so it is certainly a
real problem.

> It would be better not to introduce a new header file just for this, I
> think. How about compiler.h instead?

I could, but actually after I wrote this email I noticed that this is
a widespread convention:

zx2c4@thinkpad ~/Projects/linux $ subfind asm-prototypes
./arch/s390/include/asm/asm-prototypes.h
./arch/alpha/include/asm/asm-prototypes.h
./arch/powerpc/include/asm/asm-prototypes.h
./arch/m68k/include/asm/asm-prototypes.h
./arch/mips/include/asm/asm-prototypes.h
./arch/x86/include/asm/asm-prototypes.h
./arch/sparc/include/asm/asm-prototypes.h
./arch/ia64/include/asm/asm-prototypes.h
./arch/um/include/asm/asm-prototypes.h
./include/asm-generic/asm-prototypes.h

>
> We normally export asm symbols via arm64ksyms.c. In fact, would doing that
> remove the need for the explicit declarations completely?

I'm pretty sure it still needs the declaration; otherwise the module
hashing will get confused. Also, the EXPORT_SYMBOL macro is a
different one when called from assembly versus from C, though not sure
that makes a substantive difference. It seems like this is what other
architectures are doing:

zx2c4@thinkpad ~/Projects/linux $ rg 'EXPORT_SYMBOL.*__.*[std]i[0-9]' -g '*.S'
arch/m68k/lib/modsi3.S
111:    EXPORT_SYMBOL(__modsi3)

arch/m68k/lib/umodsi3.S
108:    EXPORT_SYMBOL(__umodsi3)

arch/m68k/lib/udivsi3.S
157:    EXPORT_SYMBOL(__udivsi3)

arch/m68k/lib/divsi3.S
123:    EXPORT_SYMBOL(__divsi3)

arch/m68k/lib/mulsi3.S
105:    EXPORT_SYMBOL(__mulsi3)

arch/powerpc/kernel/misc_32.S
529:EXPORT_SYMBOL(__ashrdi3)
541:EXPORT_SYMBOL(__ashldi3)
553:EXPORT_SYMBOL(__lshrdi3)
569:EXPORT_SYMBOL(__cmpdi2)
584:EXPORT_SYMBOL(__ucmpdi2)
596:EXPORT_SYMBOL(__bswapdi2)

arch/powerpc/kernel/misc_64.S
211:EXPORT_SYMBOL(__bswapdi2)

arch/sparc/lib/lshrdi3.S
30:EXPORT_SYMBOL(__lshrdi3)

arch/sparc/lib/muldi3.S
78:EXPORT_SYMBOL(__muldi3)

arch/sparc/lib/divdi3.S
283:EXPORT_SYMBOL(__divdi3)

arch/sparc/lib/ashrdi3.S
40:EXPORT_SYMBOL(__ashrdi3)

arch/sparc/lib/multi3.S
36:EXPORT_SYMBOL(__multi3)

arch/sparc/lib/ashldi3.S
38:EXPORT_SYMBOL(__ashldi3)
