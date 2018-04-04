Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-168483-1522848840-2-1039762890449754561
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522848840; b=ss5TcgeEssmz73DkO7hxWJAPjgJ3gZl84Bl1awi2A+Htx9vC/X
    RfumZiKvsAQR1+3RVYQ1pMhtXSX3krEGoWeEixtdcd+ToE7m9BQ3z6+4ookHhhmY
    fRQsoDiDIbKVeO3A2PwLVv3R3/mrJoU1fEKw90H0kgbvysLpG5D5ym+oIrmqpmGP
    o/nWoFXhcbcc0XsXFFIfMVJoenF3hUWIoZIUbjXAv52vmEyvX+UEYCjgkyrJODoO
    r80ZW5nxnF3WTR2vvQ5jcBNqd+jqzgElUAWkZjZa1OKyL3B6yH2UzcAM/SqZtC/u
    AFZWd1ypiQsuYwu/ZWF89peKFz/jR946R+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=fm2; t=1522848840; bh=BH7o5xX/bp9BeVeCLIQqau3GLftRVF
    fmz2U5Nq2XCbw=; b=pgZV2lqChpIP3uIV2CKUfM0fe0Zsno0nCo+GYhGH7M0e3D
    VHGZMNdbLm9qYJP2qw/amOgOzhAuUWRfp37gNSkVtr54sjsK/btgrCPJR/7uIQfS
    s20iLFqDZwbW7+dx+LaBEpbWySYNMKau/tqLBertApB/uWZ4w9rU9NcuSY4ZQ6O3
    X7RwDPqRjdol/tYNERNJrXMP7qxQq/ttyi7+SYlRGfiAJouoKyLYLBmaFZ22QQDp
    bWZg3CItIWG6jk3NEowFZQ2F0bz47JsXy1gKlwxdRnx4wjOz/0uT90YY6Iu2Yo9Y
    KNmkIERJ5EB8N6mEnFmSq5jStXnbOTqGXLDpTgSw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMZqXKynobungkZtSC5JKyNaYw6xGA7YH8sC2Ft38fU5ejlg51GB0DeiKxA/aLnLoOSM2vugMULvMBubmcEpCrhfJ1+znKQ+nMOe18NShP0Z4i60Aqpv
    rvP5mWV9Jr3Osy66POZXvN4Xl0rz6ziEjsAD5fEgPisEz5i1OFz+cmOda93zx2XYU0ElaXLVepLR3NwwaP21TrWJibmIegzk5bOD61N4PX4iSqGlcXoMyZYm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=IyV3JMI6Tgxr1aHGNPMA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeDDNdo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 09:33:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751229AbeDDNdl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Apr 2018 09:33:41 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180404125743.GB16242@thunk.org>
References: <20180404125743.GB16242@thunk.org> <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com> <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com> <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com> <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com> <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com> <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com> <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com> <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com> <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com> <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: dhowells@redhat.com, Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        luto@kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        jmorris@namei.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24352.1522848817.1@warthog.procyon.org.uk>
Date: Wed, 04 Apr 2018 14:33:37 +0100
Message-ID: <24353.1522848817@warthog.procyon.org.uk>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Theodore Y. Ts'o <tytso@mit.edu> wrote:

> Whoa.  Why doesn't lockdown prevent kexec?  Put another away, why
> isn't this a problem for people who are fearful that Linux could be
> used as part of a Windows boot virus in a Secure UEFI context?

Lockdown mode restricts kexec to booting an authorised image (where the
authorisation may be by signature or by IMA).

David
