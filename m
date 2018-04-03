Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2231918-1522782087-2-8871680028155217501
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522782087; b=N2cSkLq3NwhFf4isBfqwugb5r5WNPAFUTeJHmiTJ+0sbtHfEAY
    rDJ094RyZwrf1vU7PrguIaIpVAZBABPzu62KuOW9QUr659spPjIqrSvtzsepmgmi
    FLNMh0Xp0uBwPXP8V5k94hgNtXlZZKD1YV1rdhpfJVaQ4iPsr53Np+7oDdeA5RJp
    ECtR0cZ7yRd7l/mUwec/dbXylvjpaH2nC2Ohcai/f7Uri+Ym438FoZCQUHetr5Bl
    P/wNK+BELeK+f7snM1QyilsKbWEDT/d2ZB4YYPy6SwNOeh7IOYSVkOZn8S3VzQmY
    KQKHbHDdBWUlKZFPxIctdnn4YSdmtsIA3ivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522782087; bh=8hGwjS2kzhSobEDBUjYIMqvINpvK9lv3AA7UWaRGmf
    w=; b=k3p/iFgMDPS7VYnbbhW0nhnIIO9LVXdBhuQQIXmqqsMeXyW7qxHAzo5ytP
    XJyD+WxptwwfBmjrRb6tZnPJkQJ20udhXVfbQc/DNb3056MbR5T8pftHWV25PAkD
    5uxBOTJIMuP2PNmLE73O0KybR5s564Q8hCrUNrg77j1LDSPt64A+pZ32RYi9T/6U
    EajaeM2TL6qA3uQT7iHpbnM0c94H0lMRJju0v/c2MTYKSzfPYphy4joYYXNi/XVp
    A6AfzdOcClWkEyxjCy/HmK7BsQFGcXlfV76JKDosMtllGUepGaGY/gZZuxpZgLkX
    1S8Jpm/FRqwn3b94Hw/fekRbo5sg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGdGTH3Q7/9hIKIeBdbVy72uTe2U+DIIHnZ77oHc/g3ZH64X2aALnCPUZA+4wSmFma9ZTquoLXPEMO5YTQ46TzA3/DvHXnpjbhiOV/x/DQKNMIJbOVWH
    ZmNFjpNhbqtGyGXw34XLdVQOWB43TN1PLvylvHGd0CBU1yEUKUR29mPIsRRNfEc3PNyXsV9K5SNRhuf27ShyB6wuPjdrzcJjEp13XAFbCbkjHc0gBDRTizAh
    Xrx8QkJouamafD53QmFzRQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=W5Vn0-Gu9KEajcEPNI0A:9
    a=eenzqbfFY4Q3-N33:21 a=EZyZPr22MFCd-PyH:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753142AbeDCTBY (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 15:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752973AbeDCTBX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 15:01:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827232183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx48IFx1YV/7qooS/0sQzA7mRinaJQAeAeOK1dL0pTeexLjfqCkvdDtXb5uUwG8pfyuRJEGyodplq+8BBgjB8owo=
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+CyVXEvsMarJjBwaNh7poVZtmit5PGmQM9rKKqZPqVXg@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com> <CAGXu5j+CyVXEvsMarJjBwaNh7poVZtmit5PGmQM9rKKqZPqVXg@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 3 Apr 2018 12:01:01 -0700
X-Gmail-Original-Message-ID: <CALCETrW=Tjd2K9Ka0y_9es3XWiWHpKySDBwCq9vG=pbgkd2nFQ@mail.gmail.com>
Message-ID: <CALCETrW=Tjd2K9Ka0y_9es3XWiWHpKySDBwCq9vG=pbgkd2nFQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
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
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 11:45 AM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Apr 3, 2018 at 9:45 AM, Andy Lutomirski <luto@kernel.org> wrote:
>> On Tue, Apr 3, 2018 at 9:29 AM, Matthew Garrett <mjg59@google.com> wrote:
>>> On Tue, Apr 3, 2018 at 8:11 AM Andy Lutomirski <luto@kernel.org> wrote:
>>>> Can you explain that much more clearly?  I'm asking why booting via
>>>> UEFI Secure Boot should enable lockdown, and I don't see what this has
>>>> to do with kexec.  And "someone blacklist[ing] your key in the
>>>> bootloader" sounds like a political issue, not a technical issue.
>>>
>>> A kernel that allows users arbitrary access to ring 0 is just an
>>> overfeatured bootloader. Why would you want secure boot in that case?
>>
>> To get a chain of trust.  I can provision a system with some public
>> keys, stored in UEFI authenticated variables, such that the system
>> will only boot a signed image.  That signed image, can, in turn, load
>> a signed (or hashed or otherwise verfified) kernel and a verified
>> initramfs.  The initramfs can run a full system from a verified (using
>> dm-verity or similar) filesystem, for example.  Now it's very hard to
>> persistently attack this system.  Chromium OS does something very much
>> like this, except that it doesn't use UEFI as far as I know.  So does
>> iOS, and so do some Android versions.
>
> Correct, Chrome OS does not use UEFI, and we still want this patch
> series, as it plugs all the known "intentional" escalation paths from
> uid-0 to ring-0. Happily, that means all the politics around the UEFI
> and Secure Boot case can be ignored, because those issues are specific
> to Secure Boot, not the lockdown series. (They are _related_, sure,
> but lockdown isn't only about Secure Boot -- it's just that SB is one
> of the widely deployed implementations of this kind of
> trust-chain-booting-thing. Chrome OS and Android's Verified Boot do
> similar things and have the same expectations about the uid-0/ring-0
> separation.)
>
> The goal for that bright line on Chrome OS and Android is to stop
> attack persistence. We want to know that a reboot onto a new kernel
> and OS image will actually result in getting the desired system state,
> and that any attack on persistent system data (even for things running
> with full root privileges) can't result in using kernel interfaces to
> gain kernel control. This isn't expected to be _perfect_, since
> nothing is. But it creates a place to work from. The idea that uid-0
> is NOT ring-0 is still relatively new, so the existing designs in the
> kernel aren't well suited to building that distinction. I view this
> series as a solid first step to getting there, though.
>

But wouldn't Chrome OS possibly want to lock down kernel memory write
vectors but not read vectors?  After all, debugging is useful even on
Chrome OS.

--Andy
