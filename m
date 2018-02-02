Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2844860-1517588946-2-8156885782989594778
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517588946; b=RPHYRI4PVmoQGELqyySSSKaXxy6auopJppj/ZToDv1GcOBS
    kABsX3RkqM5W12Jf+T6AfaIRU4hFSPyMWgT6wtXd7w8XCAs06MCm6z+JfOQlZBzD
    caAeykrsQrSyLHXYRHs3cBSVGKTqc0gg0TFYKobSZ/u0SHGorn+Hphc2nolPI6Rm
    ZvTOdn2kb5o5DK2SBPy6XJAcKAElw5/CsYMwbJKG5smXH6pF2LiDiCEDVTJazpYY
    QMKIc3VGsUwbA8BgBZjibCdex8KiCXAD0p5A6OStUOSaeBvIfBkhArdNY2gJT7YK
    X2kvSnyW9qVbAsoQO2ENdyBOipzAywCaTmNwHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517588946; bh=D2zSMZni64kJHBctjjc3E97UfIpNBn1XQwBuLp
    8QXbA=; b=Jgmc/ibZ5I/lcb9SAbW4Gwy4wtdsqXHczod6IxunW3k0tS3xQi0oXt
    8kUIHqSXplMySmxIsHShPszBJ548hGL6JwDyeLsIr1OnBhXOEUNak79QzpWIiVy8
    EPsl9D4T+so1uuVODFI8IsGVkcxrm3U9dR820ncWXpIoLMgKjSoBwhdBh6lFAztS
    fr5Pvm5IH140AgT90SohM1ANv2QUes2Dj4PtADeOzINGmiC2+oUsjS4VAO8ASOxB
    NMs4uyBSyfTqQ6btbOmr3Jml/9hzykOel4xVR8CuyLbIXg99lOs2ojlUuK7Rz8Xo
    KtFBtNNfUMku53ZR+9Z+HVG1g7yPhvSA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=N8foRH4S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=d01ZHnCl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=N8foRH4S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=d01ZHnCl;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbeBBQ3D (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 11:29:03 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33235 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbeBBQ3C (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 11:29:02 -0500
X-Google-Smtp-Source: AH8x226cV1EiY1pqIYN1ntdV1c7cuJTYI4u/p3JwXGPlI6zBdMPc8ao5S/COV7iL41ldnuP64gThJskfTnDl/ho1LBs=
MIME-Version: 1.0
In-Reply-To: <e5afa875-56a5-fca4-1fdd-2c0968b35790@arm.com>
References: <20180202150756.420422-1-arnd@arndb.de> <2cff070a-357d-c5f5-9ec6-036d93112ce4@arm.com>
 <e5afa875-56a5-fca4-1fdd-2c0968b35790@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 17:29:01 +0100
X-Google-Sender-Auth: dpO-_TGyUozMGtkgF0PP9xOV7vs
Message-ID: <CAK8P3a0s_muecNBYTn5EvOPrg11Kuc9NKn0Hiqu4PAE2mTQ+-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: kvm: fix building with gcc-8
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Richard Earnshaw <rearnsha@gcc.gnu.org>,
        Tamar Christina <tnfchris@gcc.gnu.org>,
        kvmarm@lists.cs.columbia.edu,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 2, 2018 at 5:23 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 02/02/18 15:55, Robin Murphy wrote:
>>
>> On 02/02/18 15:07, Arnd Bergmann wrote:
>>>
>>> In banked-sr.c, we use a top-level '__asm__(".arch_extension virt")'
>>> statement to allow compilation of a multi-CPU kernel for ARMv6
>>> and older ARMv7-A that don't normally support access to the banked
>>> registers.
>>>
>>> This is considered to be a programming error by the gcc developers
>>> and will no longer work in gcc-8, where we now get a build error:
>>>
>>> /tmp/cc4Qy7GR.s:34: Error: Banked registers are not available with this
>>> architecture. -- `mrs r3,SP_usr'
>>> /tmp/cc4Qy7GR.s:41: Error: Banked registers are not available with this
>>> architecture. -- `mrs r3,ELR_hyp'
>>> /tmp/cc4Qy7GR.s:55: Error: Banked registers are not available with this
>>> architecture. -- `mrs r3,SP_svc'
>>> /tmp/cc4Qy7GR.s:62: Error: Banked registers are not available with this
>>> architecture. -- `mrs r3,LR_svc'
>>> /tmp/cc4Qy7GR.s:69: Error: Banked registers are not available with this
>>> architecture. -- `mrs r3,SPSR_svc'
>>> /tmp/cc4Qy7GR.s:76: Error: Banked registers are not available with this
>>> architecture. -- `mrs r3,SP_abt'
>>>
>>> Passign the '-march-armv7ve' flag to gcc works, and is ok here, because
>>> we know the functions won't ever be called on pre-ARMv7VE machines.
>>> Unfortunately, older compiler versions (4.8 and earlier) do not
>>> understand
>>> that flag, so we still need to keep the asm around.
>>>
>>> Backporting to stable kernels (4.6+) is needed to allow those to be built
>>> with future compilers as well.
>>
>>
>> Is "-Wa,arch=armv7-a+virt" (as we appear to do for a couple of files
>> already) viable as a possibly cleaner alternative, or is GCC itself now
>> policing the contents of inline asms?
>
>
> In fact, looking at the binutils history, any version capable of assembling
> this file should understand that (modulo my typo), so hopefully it ought to
> be feasible to replace these global asms with assembler flags entirely.

No, this only works for .S files, not .c, since gcc starts the output with
an explicit .arch setting that overrides the command line. I think this
was done intentionally to prevent such a hack from working, and have
more reliable checks on the validity of the assembler instruction in
inline asm statements (which we try to circumvent here).

      Arnd
