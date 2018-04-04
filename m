Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-504949-1522860397-2-3579473659780261390
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522860396; b=QffEjwO2QF9BrzcVaHaVNhmp3juWKY4BGUaYV7bISReD60POWF
    edKshaYPWIUD2ZlVDpJAg+2S9ZYJbvkI4uCKVr88dibUJdXCbMpToj0AW4ioE2mD
    AP/GfCOFTMLVtCZd2Uo/SG1+H6R0UM8loU7+RjTuaka2RDPUWt8dcOe1M/MMybX3
    x7NACOJPMuZLoIQeg9Rer7AgfXt9v02IvFmJIU3pKAZP8Ld9ALmlYqumLelwhvM+
    UGBThlB0DcF+bh5cUMbMs0m5XQ6Mh5erVd/iy1TmGjfE+ZNc8tax1GjPZzg3uHSc
    QFpvvF1+Xdr7xCbjbak3SiN2e3lwffnRi78A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522860396; bh=lLilVAhMDKLOozHc1rsVNhdj0BWsQ5k+p1zfVMXRhQ
    4=; b=Bna1TnGMnmtdMCDFRkFrX95H+J4254JXctV/A91EU7hulaRAdl/4d7Lm/W
    nb+GrsGAlyuDq19qPR4xYOrvPLFPz/8CU7JhMKVON66PE9f522VQwrNe5X7BnwlP
    nCPUrC7NjDq2stVXAKo8yMxv6fMMSm1pRQKFOoPGRbdPj5AxJnUD/+b2gkDRQPEM
    U3qYRt/B54zcXfxNrwv0PxCKNfpUNsqeLDgbXnV34SCdQo9Vv7Se3r5T/CvLCcvY
    Z+lWUVhivbhC0MN0EK1BJyfnyUsJO2wihQPPNHBZd8XUfz2LPWBm/EpX89YMtmfe
    jaHN21y1QxPb6AzCMLz1OHBH8JKw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F4yqq+lL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F4yqq+lL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIGw4hgguY0WvCU1h4EKd48LBaRHxdBQ3MzcfoD3hJ0du3EDaOFtYbrH5lTI61jSq3HGsvjU/jw3tyik40bFjaOWVDsVVLfrIkdSh2LnH5J5uK2+26lK
    r2g2N4W85of1lze8vDHG7l5UT5mHMrgkvsZJRH0YQAgb4LkczlNjbEWHREtMBaCEAz2GaQ7+UlNuk8TG3igluD82LHBSd3ZQlmylrHoV8bcpAYF3A+8Pmbms
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=bwa0CqLJMcXNJkvFhvoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeDDQqd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 12:46:33 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40738 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbeDDQqc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 12:46:32 -0400
X-Google-Smtp-Source: AIpwx48RmM/DDyh7FiUBb0xo8ggxLPpcGfH+BKRTYufmZeP4IIb1oKsyGL90kU7CVNcOXRH9+9p5PGLFRG2QnfJrLHc=
MIME-Version: 1.0
In-Reply-To: <CALCETrXwp1faWnqRJ5iLeo6bOOrRS_-L74_xnRAN1Md1YZW8Tg@mail.gmail.com>
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
From: Justin Forbes <jforbes@redhat.com>
Date: Wed, 4 Apr 2018 11:46:31 -0500
Message-ID: <CAFbkSA1BT6Ca7ZtcjvCubvtke07ctgMQVo25fcWY4ZTRLKw0pA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Andy Lutomirski <luto@kernel.org>
Cc: Matthew Garrett <mjg59@google.com>, "Ted Ts'o" <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 11:39 AM, Andy Lutomirski <luto@kernel.org> wrote:
> On Wed, Apr 4, 2018 at 9:22 AM, Matthew Garrett <mjg59@google.com> wrote:
>> On Wed, Apr 4, 2018 at 6:52 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>
>>> On Wed, Apr 04, 2018 at 02:33:37PM +0100, David Howells wrote:
>>> > Theodore Y. Ts'o <tytso@mit.edu> wrote:
>>> >
>>> > > Whoa.  Why doesn't lockdown prevent kexec?  Put another away, why
>>> > > isn't this a problem for people who are fearful that Linux could be
>>> > > used as part of a Windows boot virus in a Secure UEFI context?
>>> >
>>> > Lockdown mode restricts kexec to booting an authorised image (where the
>>> > authorisation may be by signature or by IMA).
>>
>>> If that's true, then Matthew's assertion that lockdown w/o secure boot
>>> is insecure goes away, no?
>>
>> If you don't have secure boot then an attacker with root can modify your
>> bootloader or kernel, and on next boot lockdown can be silently disabled.
>
> This has been rebutted over and over and over.  Secure boot is not the
> only verified boot mechanism in the world.  Other, better, much more
> auditable, and much simpler mechanisms have been around for a long,
> long time.
>
That is certainly the case, and one of the main reasons for the
secureboot patchset being split out and lockdown taking a different
name. The problem is, right now, secure boot is the only thing using
lockdown. I certainly wouldn't go through any effort to tie into it
with any other mechanism knowing that this patch set has been delayed
upstream for years. I would hope and expect that once lockdown is in
mainline, other verified boot mechanisms would leverage it as well.

>>> The fact that this Verified Boot on, lockdown off causes trouble
>>> points to a clear problem.   User owns the hardware they should have
>>> the right to defeat secureboot if they wish to.
>>
>> Which is why Shim allows you to disable validation if you prove physical
>> user presence.
>
> And that's a giant hack.  The actual feature should be that a user
> proves physical presence and thus disables lockdown *without*
> disabling verification.
>
> --Andy
