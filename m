Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-470151-1522860157-2-16237404853508276275
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522860157; b=SfUfApE0daGVukZ1lUPRDkcsyUGKydWOditpjCLSnVmhjVzhmp
    558NSKODGqG89e+MLoKex65WmZ5Wj76ihxdYgRO9A/3mz5Q8l2+yG9/YX6m3af4r
    QzfitCDFE1SLH3/b+/Qyjr2uXZhIMW2INOA/QWRl/4/O/T6IXb9xerTqiBCXnFGt
    lkhm7UYxQbyZgHITLif5Chx5TP02kZ/7otXA6BV7Lm7s6ZXRp/eglgxiU69csDsA
    MwuFTAte4SslJaBxRKHjKnMp+QalXUQ93nhdXLwl/S3y3jeIR9mfqWDg6AVB7vPa
    YweMG0B+Xad4h+QIcsViYfD3TBfZSN1qFXXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522860157; bh=T6QdogV5djmn7h4tMCQdGC7WAlGF1JIiySJaOrHnL5
    M=; b=hdupBMTjnwPjMMTr29Re19aLhkCVK/jWUfwKhXOKTtW+OdZg2seYRqYrdq
    KUstfZbrn0wjPVchS/wzlf4YZwgQJXmrUddb/ClFaRXvpR58ZXXVVUKpN4El8AzT
    oZOk5ExoVvsGAcqy8G7tkgmNzx7aWAqHmxf/aXIeUmWzqMk8Tb4cq9Voj8Q/pDOD
    4txObdddGB48U1Yi3eABh52zYnT7wutAJUYQgrghglOsm6BKNVCbs1YY/AqWJq6L
    u3Ezb6i7CzZuyJj0O6o4ChJBxb3DcL909ix0Muv2s2VCnX+fB8Z8y0oma9/jCEmG
    i65cXN1/HpeLgXe9kxtJ9N790P1g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=JYiXRiA3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EIWLtyTU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=JYiXRiA3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EIWLtyTU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCuBlSqzC6HXBcMI5TUbTHeM5OmYXYdnNSRYE5JQiQj3DlBoiP/Bv2VHLNlexog1eQa4ywJa06clyMJGSU2tOTpvyMacqA05nwaTaHnPUyTdAa0s5ARe
    bGNoZCgkRNNmEwvRCpnobBRj80kWIbriRIv8d6aENhxSINTL338uaKISU4TCY+ULTh8zirwmVG/t0LlYoP5hZaid/TpPMXmkLRli0E1AJFbMw9nfCqITBDtc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=tq6O3M0fpb1aZQJuoD0A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeDDQmd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 12:42:33 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40863 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbeDDQmc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 12:42:32 -0400
X-Google-Smtp-Source: AIpwx4/kum7STlCKxATGuv6VA2hLpv3cmkuarfs6+BLBawIO1ukthIyqDIIfAPaf1tutpkTKRWPEhhvJaWyyUbiRZK0=
MIME-Version: 1.0
References: <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
 <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
 <24353.1522848817@warthog.procyon.org.uk> <20180404135251.GD16242@thunk.org>
 <CACdnJuuGRRUt-a3i89o906ka3RDOhs+_7tz_G8LTG8Jc0DXAyQ@mail.gmail.com> <CALCETrXwp1faWnqRJ5iLeo6bOOrRS_-L74_xnRAN1Md1YZW8Tg@mail.gmail.com>
In-Reply-To: <CALCETrXwp1faWnqRJ5iLeo6bOOrRS_-L74_xnRAN1Md1YZW8Tg@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 04 Apr 2018 16:42:20 +0000
Message-ID: <CACdnJutctrxMUKfXxOXv6Z6mrjeZh8xFmg0Yhid56G2YCWGHVA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: luto@kernel.org
Cc: tytso@mit.edu, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 9:39 AM Andy Lutomirski <luto@kernel.org> wrote:
> On Wed, Apr 4, 2018 at 9:22 AM, Matthew Garrett <mjg59@google.com> wrote:
> > If you don't have secure boot then an attacker with root can modify your
> > bootloader or kernel, and on next boot lockdown can be silently
disabled.

> This has been rebutted over and over and over.  Secure boot is not the
> only verified boot mechanism in the world.  Other, better, much more
> auditable, and much simpler mechanisms have been around for a long,
> long time.

Right and if you *know* that you're in that situation then you either turn
it on in bootparams from the verified bootloader (which we can't do in UEFI
because the *firmware* can be the bootloader thanks to the EFI boot stub)
or you enable it from userland later (I can't remember if this version of
the patchset provides that functionality, but a previous one did).

> > Which is why Shim allows you to disable validation if you prove physical
> > user presence.

> And that's a giant hack.  The actual feature should be that a user
> proves physical presence and thus disables lockdown *without*
> disabling verification.

That's a completely reasonable feature request.
