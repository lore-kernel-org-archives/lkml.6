Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2225902-1522781156-2-2628368484118484007
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522781156; b=tAoRuSyWtnLRuUrXCyLldZ8Ia/UKkvqyscsruHyvVm7YmRonG8
    XO0Ar+NmJQ7yACipjfbXn90CtEEMojUW4sXap5IRc8dc0it103ds4VaKxbnx1PW8
    vcK9i8dEt+rJcmvGC0pOuHzrxn2J9GadalLwPNMJ32mdiSqhmdHBAT1i3OiG/+oj
    TDuAp1QI+M38YPZMsbAxXTp+vmnyHJXGc1va5BepsaxD9wCdRCSZ+BEjBUvLzxI/
    D0/qN2rgPCfEdHtsVNqXwtBT86dwNOJwNUFilD05bBOGLZ+IdZL43qLcBEGKnN/U
    V9hj+qNipqGlxe0kOZ26ZXK9ksW/zRAlSPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522781156; bh=Mwh++Cuz3a+OYnspslbZKZSOtAKnOGlNAJhSINgbTh
    0=; b=rwrQ6kL69F9F7iCRSQYqOUl49pZzkRsG/8ZJE0xnMpgLN7MvPs/yeK6CwS
    EXoi3QB7c80qTqO6viwvDG0qclfmFKarOJmElgDuIdprVSZ1jvtW3nHKpnSgCc/o
    hgsR5KLcMvDUcvqda2J0mVb4caYMbOFTTuaXee5ry3Q5PUALAg5v7BjUHo4UKhGq
    TgOiun6MbtAT9BGndxV6Lu16cyfIynSOsToH9v8m6GhLtye0L3AHl1QijV2N6LPe
    +OWlsmTFEqIQmrFHrmQXwCji0/eb/bJel2ZzHYfVLZ8AOxHm/qpKTu4SNN+eCmkw
    nLSBLEa3pvI3cfr0aTes85uSGHBQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=C+lw1G3b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=AL5Jx44Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dJEaBYFp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=C+lw1G3b x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=AL5Jx44Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dJEaBYFp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOpcHWwOSigFT+J0fyf+BgFBnkf0mfpgjEpV3gbs67qNWsp2TzS0x7qygQ/OR7lBM7tFUZ/rYwBN+jhCj0lMlztMdtAE7xcp4yhEA04VkqgAq+zsALbA
    H6a8IlZtIYsZJocvsOjK2/xi36J0rTrApfx7wKfaQUc/ApN0oZRqBydZ/+gYCCIRiEchDLPOn8T51lNio+5Vp7xru5hXQaJMYkwVulQapGoZoy9/uOyVxRHF
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=ziq4GWAwUgaw-kmiO88A:9
    a=wNIw2HuYT4JZ6moE:21 a=D6rUiPKP0k_XO-E6:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbeDCSpz (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 14:45:55 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46809 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbeDCSpx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 14:45:53 -0400
X-Google-Smtp-Source: AIpwx49khrBasgRospcpgfKAkYvGgZZOpydeNdsI4M1BBaWkW2soXypPM8E9JrICeLDpIRRt2MQhbJHpTPKgiuR/7yY=
MIME-Version: 1.0
In-Reply-To: <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com> <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 3 Apr 2018 11:45:52 -0700
X-Google-Sender-Auth: pCtDw8qg0NwarfTB0tt-flg_G94
Message-ID: <CAGXu5j+CyVXEvsMarJjBwaNh7poVZtmit5PGmQM9rKKqZPqVXg@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Andy Lutomirski <luto@kernel.org>
Cc: Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
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
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 9:45 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Tue, Apr 3, 2018 at 9:29 AM, Matthew Garrett <mjg59@google.com> wrote:
>> On Tue, Apr 3, 2018 at 8:11 AM Andy Lutomirski <luto@kernel.org> wrote:
>>> Can you explain that much more clearly?  I'm asking why booting via
>>> UEFI Secure Boot should enable lockdown, and I don't see what this has
>>> to do with kexec.  And "someone blacklist[ing] your key in the
>>> bootloader" sounds like a political issue, not a technical issue.
>>
>> A kernel that allows users arbitrary access to ring 0 is just an
>> overfeatured bootloader. Why would you want secure boot in that case?
>
> To get a chain of trust.  I can provision a system with some public
> keys, stored in UEFI authenticated variables, such that the system
> will only boot a signed image.  That signed image, can, in turn, load
> a signed (or hashed or otherwise verfified) kernel and a verified
> initramfs.  The initramfs can run a full system from a verified (using
> dm-verity or similar) filesystem, for example.  Now it's very hard to
> persistently attack this system.  Chromium OS does something very much
> like this, except that it doesn't use UEFI as far as I know.  So does
> iOS, and so do some Android versions.

Correct, Chrome OS does not use UEFI, and we still want this patch
series, as it plugs all the known "intentional" escalation paths from
uid-0 to ring-0. Happily, that means all the politics around the UEFI
and Secure Boot case can be ignored, because those issues are specific
to Secure Boot, not the lockdown series. (They are _related_, sure,
but lockdown isn't only about Secure Boot -- it's just that SB is one
of the widely deployed implementations of this kind of
trust-chain-booting-thing. Chrome OS and Android's Verified Boot do
similar things and have the same expectations about the uid-0/ring-0
separation.)

The goal for that bright line on Chrome OS and Android is to stop
attack persistence. We want to know that a reboot onto a new kernel
and OS image will actually result in getting the desired system state,
and that any attack on persistent system data (even for things running
with full root privileges) can't result in using kernel interfaces to
gain kernel control. This isn't expected to be _perfect_, since
nothing is. But it creates a place to work from. The idea that uid-0
is NOT ring-0 is still relatively new, so the existing designs in the
kernel aren't well suited to building that distinction. I view this
series as a solid first step to getting there, though.

-Kees

-- 
Kees Cook
Pixel Security
