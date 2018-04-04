Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-470151-1522859989-2-2045728641581471034
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522859988; b=MBeNZ1j435+/USU/uwl7frmC0vBFalTkdUgK1iu9BY84WrJuxF
    GRE2QJ72qENU/G6oyEd7Hud355Nv84fqlrblLEtIwHq+9UwiPqGC94bVDM1uTGdw
    n1jGWYxaF58jRP860yhi24NiodehDw+6X8JI3MX0SpEB3w73ex3AV3eHubl0w9rn
    FO7jhf5HTFspxWopJSUSb508zKHnml50/DmKipgvlPL38nRNBjP9V72PJuEwr7rn
    Jq4NbAJYVWIIM8tIRwqKR5kZHMPnnogV49/r3sYCL1oHfICFZFH+Nr1L6LicOW9e
    o1RK33WYGdVAO/tnciOBxSbv+efinG94/6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522859988; bh=jQSXd7Bw4uR0fPtYF+NSintjpT0p8vqJkQ5V2KM8Bv
    k=; b=Cb1qQup15CRiXTfEbwb3OcT1fD+d29Bzy6X5m0xbFSeTlKzK9iF0MhGmRE
    o4KDkRK1TQcYlpniEIVUzIw++s4bHl4qZ8gLF4EIatES7CodF5PnAkytFtUR5ADY
    XtlSull0WZL5F9iTGNs+mWwMRbSZ94/fl14aggOnhtZ7PBLRQYgH8dkQFDX0fjuD
    TH/VzxuKpDQBvt4zcVPtR7Air61LNggnI6Yqd1amfd1JA+PfWPrG89u8SH/Sc5UG
    sznWKzcwlzMp5h0IpclZk6RB4/T8K0MkMf7NEh4eubA0hNc9RIXwSrs/cl5SfJsL
    90JOkXlDVCDjgbHOlJuxy56OLGcQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJicJQy/dHZeaB5Yz1Hv0tXEX314xczH+EnzonIwLHlHaDwEpdCeqschMPyEYDFXwoAe8XEJmBQLBYAUtUYC4R+Q/pKnhzIe0QmRD0EJDvcus63cMUjH
    hBt3zwkyXLM1pi3NZ0uN519Wx8/XJ2NDXOMHU/xZv7v00gAk0AMLLs/6hSg055L7+bAe/QYZ5CwXlH/Me5w1qp5kcFvi3LHNMTU9gqvSo58y4xoLHff0zAtM
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=PfEXFTo1KNk8WtJVIS8A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752444AbeDDQjd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 12:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752390AbeDDQja (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Apr 2018 12:39:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B632183A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx48eziqNEZQfC0Uy/NuaotOS1ywqp47o3/C9XXp024kJDUyMDKfJ8or3vIxNw6xwls5gODj58w1XyMQ5no2KH0E=
MIME-Version: 1.0
In-Reply-To: <CACdnJuuGRRUt-a3i89o906ka3RDOhs+_7tz_G8LTG8Jc0DXAyQ@mail.gmail.com>
References: <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
 <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
 <24353.1522848817@warthog.procyon.org.uk> <20180404135251.GD16242@thunk.org> <CACdnJuuGRRUt-a3i89o906ka3RDOhs+_7tz_G8LTG8Jc0DXAyQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 4 Apr 2018 09:39:08 -0700
X-Gmail-Original-Message-ID: <CALCETrXwp1faWnqRJ5iLeo6bOOrRS_-L74_xnRAN1Md1YZW8Tg@mail.gmail.com>
Message-ID: <CALCETrXwp1faWnqRJ5iLeo6bOOrRS_-L74_xnRAN1Md1YZW8Tg@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Matthew Garrett <mjg59@google.com>
Cc: "Ted Ts'o" <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 9:22 AM, Matthew Garrett <mjg59@google.com> wrote:
> On Wed, Apr 4, 2018 at 6:52 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
>> On Wed, Apr 04, 2018 at 02:33:37PM +0100, David Howells wrote:
>> > Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> >
>> > > Whoa.  Why doesn't lockdown prevent kexec?  Put another away, why
>> > > isn't this a problem for people who are fearful that Linux could be
>> > > used as part of a Windows boot virus in a Secure UEFI context?
>> >
>> > Lockdown mode restricts kexec to booting an authorised image (where the
>> > authorisation may be by signature or by IMA).
>
>> If that's true, then Matthew's assertion that lockdown w/o secure boot
>> is insecure goes away, no?
>
> If you don't have secure boot then an attacker with root can modify your
> bootloader or kernel, and on next boot lockdown can be silently disabled.

This has been rebutted over and over and over.  Secure boot is not the
only verified boot mechanism in the world.  Other, better, much more
auditable, and much simpler mechanisms have been around for a long,
long time.

>> The fact that this Verified Boot on, lockdown off causes trouble
>> points to a clear problem.   User owns the hardware they should have
>> the right to defeat secureboot if they wish to.
>
> Which is why Shim allows you to disable validation if you prove physical
> user presence.

And that's a giant hack.  The actual feature should be that a user
proves physical presence and thus disables lockdown *without*
disabling verification.

--Andy
