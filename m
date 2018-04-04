Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-227748-1522850245-2-8375753604003164383
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
    1522850244; b=SjqdL3ZIrqF42wLYWyANH4d61Le4ZEhlAr3JNQJHhtICC1C4tB
    oMkyt2kuSWS02hr6T8ehNwVM9zRi7iSezTqqY9OfW0aRLLMe6U3aobv9fxcN16av
    4lvVFBY6GkX1iYZ+X4Nv2aH4QN00NnaeCWIpv82tJGH9vWtFrM0UwaMPqc0x5JWn
    wMFhn02sqvBHvrbl0J/+JizWdTSnf8X1VS5ziIJ8665hoQ7zBs+mZis7ntorC+7P
    jm8GTIyoSm8wT4/KMYfsx3sxluChnP277YA9GbRd9q32HO1JE7nO/agrF9uglOrL
    tcJ3oiLuvXHmwL8pdG+1PDM4wBmC23W/gqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=fm2; t=1522850244; bh=XL0gaCOOixaJbYY8/RZCpnao46Oozl
    WsFGneOTTOQKQ=; b=joaCUKuc+t/W6P9Fsd6NEjBDpzSEgMXAzG6c3rLoJi/jB5
    UZrIQLbBRaXjagmWUBYwlPYpSuvDne5S5tdJ15eUcKNtLon7as6IYIX/6zIRQk7h
    C2b60Z8ow3bxM3XfU96H7M7UIQD0pVlmBNAPTaO2ZMQ/1crsvA03ZATynWEUKnaP
    5oDYzye68gK22rxADBMTEO1WpxFwyVCnYHFGQev9g0mx1hfNaCpvZQtq327k0heq
    VBRDNTuFo/eSgSKlDk0tojTuYu1FC3FGwNoc5EmGBUOEA9mAwvSTNXAEg4rrcaaT
    A0t7XfSsxPDR933jpYDydamVIC8jVZZODMa+veIA==
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
X-CM-Envelope: MS4wfCNO7RZmnM25+/Ds8kYaasGBo6CLrXBHKGbTlcZgT1vK+6oEP0zEkFeB3sPg+cmm90Xyzo1ooMgctAQT0Qp1DuuDZ3UFpSymyypGQMxbcuuheOcT1hAO
    WbQxcGfQFDTXeKQ8De1efTiuUcO1l8Gok9buupwF935r83/hacFa/BW4EQHHO4diTsEHLBKEpfvsemYenaYFiLoJEIq1FknbtAIJ2nl8yah3fVl30G1b9Djz
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=dsrfxofS0-3d_g-25oEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeDDN5V (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 09:57:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750853AbeDDN5U (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Apr 2018 09:57:20 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180404135251.GD16242@thunk.org>
References: <20180404135251.GD16242@thunk.org> <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com> <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com> <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com> <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com> <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com> <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com> <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com> <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com> <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com> <24353.1522848817@warthog.procyon.org.uk>
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
Content-ID: <27480.1522850235.1@warthog.procyon.org.uk>
Date: Wed, 04 Apr 2018 14:57:15 +0100
Message-ID: <27481.1522850235@warthog.procyon.org.uk>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Theodore Y. Ts'o <tytso@mit.edu> wrote:

> > Lockdown mode restricts kexec to booting an authorised image (where the
> > authorisation may be by signature or by IMA).
> 
> If that's true, then Matthew's assertion that lockdown w/o secure boot
> is insecure goes away, no?

No.

Lockdown prevents the running kernel from being modified (or, at least, that's
the hope).

But it doesn't do anything to prevent the kernel being modified before
lockdown is engaged.

We are trying to use secureboot to protect the system to the point that
lockdown can take over.

David

