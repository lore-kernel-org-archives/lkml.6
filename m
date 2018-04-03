Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2751240-1522798992-2-11799110970480013926
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522798992; b=q3pGGYJMZL315CD+sxBhRoXS7hp/VY1MlqVaislMmvx2jP1NnY
    RjHzfFXGbck545dq9zjJZGH7hUSrze8nRSRiY1/4PCOyESR9mGEt1WlecTBUfaUm
    vdB8YmYYDsevwoAehdgboMzfCKOQRWUiEoKddQuzczAQFoGlRzPJeV9W7SE5y1Sq
    OnyjrWe84VIsa7Qp+1zDnTe3V04UPPrpg7Bd8InbmQoxQ47LKWohgTbyz/vmRB7P
    +SyOZh/T4hi4OmsFHAOUcMm9k7BwwJH/O9Njma/jcAkiK6rjRaDc7lQsTKXoLnGp
    Tq17hXvWqMYgfhxOq0oHZmYEYRS5/wPIeNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522798992; bh=rmuZ5Kbap4aDkfPE0G7KxMoUD93Xo9B+hSfKPWqO6v
    0=; b=VH9P4+sxWByZNT8OaRJa7OhKPENuEc+HL5FmgfH/cV+fyBGJjCWEdqKOu+
    mCkp5RpDWIuJ2pdllgqygfJohzDqcqCGA0+zxx9XO9Jm2S7sAqq2B4qq2OBojOcO
    8SBn5ATW8yLWMWNFfEac/2SYhS7btS5sxC0xBBMUSLC2lFFv9x3n3x4nfyybGzla
    MskBU5ZQtFpWOzvMkftCNKelxzOoOFk19O3oqUBRLpKLtNNpJ+KIbdTIp+KUbnbu
    Nbd9imxANRi7CQliDmn+J7Rk2X1LQXsa9mMvDpqqJmkvjQvXNT3XzelHaGccEMOk
    HV6PH8rtC2dzwtRIe+8zj9kwXUVg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJHvrQjBiFhjzNLtjzWKmGNNBX+SvBI9J6AYs7mMJptEEIrK5RGjzx+lzcafkvnDdaHC2hr6/04TUT9CDUt/oEMPuRBW82I5gDiaucD0WFTd4DYSVrQQ
    HbBQdth+ndhalTDzqJJnM+nhKxHSiYSe13eJ7MgQ109hv1UfPD3OEYvpmWmYUifNjWl/GPuUx8wYegxiD6iFtAtdPVsJGoo6zwFn60PvtnZKnWQCj3/ou86c
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=FwQw-k4DleNXT8Fyj70A:9
    a=M38OURcyst1hynUs:21 a=RYt_kXUFO3tfPbWe:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbeDCXnJ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 19:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753693AbeDCXnI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Apr 2018 19:43:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95DA2183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx49rURbWlj2tNtBBTxB5L0bdpb0RcidQ+URAq8QgbDyrb5i/V4/ly7za/rkLcDZTNeWTLzE26oAkMBkbl/avBhA=
MIME-Version: 1.0
In-Reply-To: <10232.1522797179@warthog.procyon.org.uk>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <10232.1522797179@warthog.procyon.org.uk>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 3 Apr 2018 16:42:46 -0700
X-Gmail-Original-Message-ID: <CALCETrXThwok-koDREAP-0ycjphjpc_o0mSBB3zoNXb9rWGLCQ@mail.gmail.com>
Message-ID: <CALCETrXThwok-koDREAP-0ycjphjpc_o0mSBB3zoNXb9rWGLCQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 4:12 PM, David Howells <dhowells@redhat.com> wrote:
> Andy Lutomirski <luto@kernel.org> wrote:
>
>> I'm having a very, very hard time coming up with a scenario where I
>> can "trust" something if an attacker can get root but can't modify the
>> running kernel image but I can't "trust" something if the attacker
>> can [modify the running kernel image].
>
> (I think the above is what you meant)
>
> Let's go at this a different way.  How do you decide you can trust something
> in this context?  You compare it to something.  Signing it, keeping a hash
> whitelist, IMA - these are all ways of comparing something.  Do you agree with
> that?

I trust or distrust a system as a whole.  I don't make that decision
by comparing it to anything.  I make it by evaluating how the system
works and deciding whether it's trustworthy.

>
> What use is secure boot if processes run as root can subvert your kernel?
>

Secure boot serves several purposes:

1. Anti-competitive purposes.  It's intentionally difficult to run
non-Windows OSes on Windows ARM machines, for example.

2. Allowing me to use a stock UEFI machine to have a verified boot chain.

The latter has nothing whatsoever to do with CPL0.  The former,
however, does.  If I could easily write some Windows program to run
CPL0 code, then I could chainload Linux using the Windows image, and
I've subverted the purpose.

Cynical?  Yes.

>> > There's no point bothering with UID/GID checking either.
>>
>> Give me a break.  There's a *huge* difference between a system where
>> only root can load unsigned modules and a system where anyone can load
>> unsigned modules.
>
> I don't think we've ever advocated letting just anyone load a module.
>
> But my point is that if you can modify the running kernel, you can nullify all
> security checks, including UID/GID checks.
>
>> > However, if /dev/mem can be read, any root process can extract the session
>> > key for your disk.
>>
>> Any root process can read /dev/mapper/plaintext_disk, lockdown or otherwise.
>
> True - for now - and they can also access the mounted filesystem.  But if they
> get their hands on your powered-off computer, no, they can't.

This is, IMO, a silly argument.  You're saying that some bad guy has
managed to run code as root on my laptop.  Then, next week, the bad
guy steals my laptop while it's powered off, and Lockdown is supposed
to protect me against that bad guy.  If this happens, I've already
lost completely, lockdown or no.
