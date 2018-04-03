Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2706406-1522798758-2-15298826168561683776
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522798758; b=T1n0az1nHwjgSezILoKtGcSF509VLPekoPR6kVnlZzUvv4RI23
    NEfoBguZV+AAAD1uuRRKKqC1vpolfIjPBHjml2/r3yQEcONKfS4awza85S3g6huE
    Da9d/ORlshvRwaX+K1Zfo7izriVa5lD2U8iScH625jWau+13sq9taAHD2XXDcy/0
    04qRBFkikUDtI/kJkAXFs7k6BWp83vEAoBb5VwNf59zFaO0EfpodkL6ADUL4pMT/
    vI2/ZTYQfgn9iR1THBpTnqDGh2WDSaD+MlK4Fe1WWRDxh4bhKDK98+K25VrD1DPo
    bMTWFu/vlvi1JR5Gy1bYlyEwVSDdn/QkYNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=fm2; t=1522798758; bh=RAqsfJBiDDQBJ72x721dUSRTKkYm7e
    +LC3IopSwCz58=; b=LAFHYsvya4Eu0kSX4yTD8QGZv8GAtflBDlSXEmbyooXflw
    Xw4h5MK2+ZvPwXy/n5Em8SmresVvikKQQDXauq0FOdKgZuErTdCJ4mfG5HnXL3Rf
    XnoUe0Y9wu5BgqrK2J3XDCMRZBuIt5Xe6jODH+vbFf8DBQcsaBS5m9rjyCBIPmEu
    S+ma4D3jjxChZ6qxiry+wC/LWepbdBA1/MgwxoAUjCzud8Wu3DqdZD3KvntFYIad
    R53OgjFVRAuuxEn348DOUpkLC0uHodZ3wmKXHKi1lTMLPb/aYUtJPDXnQZDa3VQn
    A76yEZJ7oE3tBWIKdkLHy8h5BhipQx9jx/XJK6VQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBINaa+LsZGrh6MYeyR9fvUkMeWIfA1Mv7ruZzDQDzDnb1I691BUch2ZVK8/H+amFIAyCBDFfTQzY8ZViGifUrrzHvrpC+d2oNpHLyHFw2LbKJVjIAMB
    yuVLbQ1403K+KRRRLfevqi6F7RuVwdUd4cREr7wcVLOnlA1shZXEKSUhT/++9cd/O0v5GnMYtpqBiAlF8frRQavmuWkLcsSQmswAjxOvKm2HxpLrXEYjtNBO
    iwTAqHi8I1NISbEuzEqc8g==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=HV4UNtG3i72FZkWmguQA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754270AbeDCXjN (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 19:39:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754169AbeDCXjJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 19:39:09 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
References: <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com> <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org> <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk> <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com> <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com> <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com> <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com> <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com> <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10717.1522798745.1@warthog.procyon.org.uk>
Date: Wed, 04 Apr 2018 00:39:05 +0100
Message-ID: <10718.1522798745@warthog.procyon.org.uk>
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The same thing is true of some lockdown patch. Maybe it's a good thing
> in general. But whether it's a good thing is _entirely_ independent of
> any secure boot issue. I can see using secure boot without it, but I
> can very much also see using lockdown without secure boot.
> 
> The two things are simply entirely orthogonal. They have _zero_
> overlap. I'm not seeing why they'd be linked at all in any way.

I'm not sure I agree.  Here's my reasoning:

 (1) Lockdown mode really needs to activated during kernel boot, before
     userspace has a chance to run, otherwise there's a window of opportunity
     in which the kernel *isn't* locked down.

 (2) If the kernel isn't booted in secure boot mode, then there's the
     opportunity to tamper before the kernel even starts booting.

 (3) There doesn't seem any point in booting in secure boot mode if you don't
     protect the running kernel image against tampering.  What does it mean to
     be in "secure boot mode" in that case?  If the kernel can be tampered
     with, it would seem to be, by definition, insecure.

 (4) You can't validly promise the next OS you kexec that *it* is started in
     secure boot mode if you don't stop your image from being tampered with.
     Note that this doesn't prevent a compromised kernel from lying to the
     next OS.

 (5) Tampering with a running kernel can be achieved in a variety of ways:
     loading of arbitrary modules, loading of modified firmware, direct access
     to devices that can effect DMA, writing to /dev/mem, ...

 (6) We need to be able to load modules and firmware, but these can be signed,
     hashed or measured so we have some idea of their provenance - but signing
     can be worked around if, say, /dev/mem is writable.

 (7) If you told the BIOS[*] that you want to be in secure boot mode, then the
     kernel should honour that and try to prevent tampering with the image.

 (8) Turning lockdown mode on if the kernel is booted in secure boot seems to
     be the way to achieve this.

 (9) BIOS vendors can blacklist any of the components - say the SHIM - to
     prevent an insecure kernel from being used to compromise and kexec
     another OS.

Note that I've provided a kernel command line parameter that will turn
lockdown mode on arbitrarily - but that can be turned off by editing the
parameters in grub.cfg, say.

David

[*] Yeah, I know, this is an x86-centric view.
