Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2519967-1522792706-2-14995878268890761054
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522792706; b=b2u4FDrO+uqrhq509ZE3K9culoQewiWSMRDC5U4q9K65E1dPmi
    KmVDHSYIwUapkijKJHluGG5WuJPd3PuP2ddGDXmx+r6xJ3ar2remNNmCCbilXQhe
    B+1A56Z828hT95t6H7ARGo2jfYSyl5fMWtMwaNKDek57+DuxkC35y1kb3oA8aF6a
    01yxBQpZWPh49LsjmZsCPS25IuBzJl8aIWNOg131QpNLNrXqPJ1EaE9qCIcV4Ovm
    W89m5BHwSuZNBVM/b5oH9UnfRsiSnCaGFTKf8S0Y8FhBA9skZ5JaNeXyKjq4Ga57
    Y7Rebk2xsQFiYHmO6Qvfdt5SY5fGPl5CKy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522792706;
    bh=isk4Nhfg3BWHqwzXIW8mac32sULckFgZqakQ1xDcWec=; b=kKJaH/z6ueiW
    pvSFWdEGJ0o96eYon7uZ1vaGAcbG9C5uLQiZuhuFIrjA/qcPscZskPX4CTcRqlOd
    7jw+HYu5Kh2MBJS71zOQnnUtnUOyBqKycXmqtefz56iGJNxf39oOPAgh9JX54rAW
    25cQNGIRttdGHEhu/BPm6E1lQf5XqrlMvsKTBUvQxVpdrjAgcWQ/WuZqthuG6CwD
    XWw64KCFisRQc9WYePffAoY1P7n5sm1gxbID1UF5vcUyNH8MIUinyWTHGXe8UZHQ
    /0M/wpUohjKeezNTYb07jiq4ilBp+woPHCVOFqopOh4m22Y7GZnwAwfvUbzprzkD
    grjsFGUfNg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfN0rSGvyS8DWxqe4Xqf05T22ArbAB6wSsYH4QlyatyeWp6tdX7AfC3TFSftTEIKk6TRgaL+AdJc6d1+3dAPzDUzz6cyDgmNGJsU15gydAEany6n3d2Ym
    NC47ZYyd1lkhs4ITLd2xEXroZKaFyhgHLhwE74KBFp3COpQEGYupJ89iFfqXyQrnL/IeWgR5arxls5h123tRpYkqgZpiP+I5gdEOGhvRbfgUtpN6zwogo9kf
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=R5sSl4h8D-HxIyvYh_8A:9
    a=SleB_vWs3IcEB3uM:21 a=DXO4F1RmZmVRtUTt:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbeDCV6Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Tue, 3 Apr 2018 17:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753861AbeDCV6W (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Apr 2018 17:58:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD4021837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx4+grorAUFJeq7RNp85eBQcDUfa+xmVfu6mgIgDzLiUm8fbPMXIawLazGq/nQ7xSCPoVcCGxFDGYex6E6Vus/q0=
MIME-Version: 1.0
In-Reply-To: <13189.1522784944@warthog.procyon.org.uk>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 3 Apr 2018 14:58:01 -0700
X-Gmail-Original-Message-ID: <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
Message-ID: <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 12:49 PM, David Howells <dhowells@redhat.com> wrote:
> Andy Lutomirski <luto@kernel.org> wrote:
>
>> >>> A kernel that allows users arbitrary access to ring 0 is just an
>> >>> overfeatured bootloader. Why would you want secure boot in that case?
>> >>
>> >> To get a chain of trust.
>> >
>> > You don't have a chain of trust that you can trust in that case.
>> >
>> Please elaborate on why I can’t trust it.
>
> If the user can arbitrarily modify the running kernel image, you cannot trust
> anything.  You cannot determine the trustworthiness of something because your
> basis for determining that trust can be compromised.

I'm having a very, very hard time coming up with a scenario where I
can "trust" something if an attacker can get root but can't modify the
running kernel image but I can't "trust" something if the attacker
can't.  About the only think I can come up with is that root generally
has a hard time directly reading kernel keyring data.

But if we really think that kernel keyring data is so sacred, let's
please solve it properly using SGX or some hypervisor doodad like
Microsoft's Credential Guard.  Protecting the keyring with lockdown is
a whole lot of annoyance without all that much gain.

>
>> Please also elaborate on how lockdown helps at all.
>
> Stopping the kernel from being arbitrarily modified allows you to preserve
> your trust.

If I build a voting machine, an ATM, or a server that runs Panera
Bread's website, I can certainly issue a press release that says "hey,
the bad guy just downloaded tens of millions of customer records, but
they didn't actually get to run CPL0 code, so all is well."

</sarcasm>

>
> Stopping the kernel from being arbitrarily read stops any encryption keys it
> may be using from being retrieved.

If I build a server that runs Panera Bread 2.0's website, and the
attacker exploits my machine to steal tens of millions of customer
records by getting the machine to talk to some database server using
keys that are securely stored in the kernel keyring, I would feel
sooooooo much better knowing that the attacker didn't also manage to
extract the key that lets the machine talk to the database server.
Never mind that the attacker already stole the entire contents of the
database.

</sarcasm>
