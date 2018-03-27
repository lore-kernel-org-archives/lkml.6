Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2622067-1522119421-2-11519348568958854827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522119420; b=sbr56JOnt6x294M4SKwVrbc3XO6n3OMpzty96YWmvitEoqk
    VGgLF4Ci5TlWcFrD9Yyxnrt+EqieuT6/NzzDJHxkQQ5D1RRHOIX2ZVqemyfZP8mY
    zGL9JqTkmXzUeHBJ8aujA0ojGZIsrxnpjvwR3FnME4I0i3y/FB1A5q+6uAlBrdzU
    ML3Q+UqyWWx9jAQ9QEhhN1AVbECrBcplK2bpoiIesntyNQF5nyXzzm/W7LNeE5pk
    F/VI7L56cxcp5edYLGd7xWux2qG2RjITXMvTyt9g44euugT+U1aYMoSiUNS8JCuJ
    QMfR3m4mkTJnWDhBrguGsoHKH8zuR6AX+I2eKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1522119420; bh=J+jarBgn2PtsaFAuZvGyW7gAGT+3ne134FuFiO
    VLTdU=; b=QLDFmubC8nOKc6EFAWvurFd4JfT8aedB2c9olkm3O6Y4vs94v84AjE
    xWosRiX21hRZ3dXYvqS5brzPNcL9Sb8MU8iz6wUEjpGYJSIJ04HOTVcPE3YRhArJ
    3DUZPVMnmwY+g/t9reeHJjwHvv6tGJ7NSBhDDCscOrRDivuBKXyKLO06ZETWn/Kz
    FE0OAK5gjrWLyqE/hEx+7C2jrGhiEqiJVg2zx7fEr/unRa6QdDOKUoowNp4PXbg/
    V3gaor74KErrEB1WuSlU57Cy6djnNQw33HVwt9IIw8xUeChJegMpCI1aBYGqmtbu
    D7rieIygQItyiLkrekcEwyWy42bCAtpw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=kh+5KCe3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Q37St6J0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LNNoOas+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=kh+5KCe3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Q37St6J0 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LNNoOas+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPnxomCDVcZ/rZUgYAX4ct7rsyffXK0mDMzW8Qk2HxpWAZWhesOEH1NKV3T4WhjdbaiEbptn5Oo5wGSUy1KfslanZ/FlO+EiO08rKlthtQpCsdzlugRt
    WtLYImTF3cddNDCmIBcVgH58BXf76UqgAlRHJgM56vp/20cFklDrvQebA1EGElblkI5GDhS/KzLze74cCr/80P3x+7OhWZNF3SDhGZpbYOR23i2HiXNrw26d
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=z1H5ADGQAAAA:8 a=VwQbUJbxAAAA:8 a=7MF9JRXSUlReoRIFudsA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=cNhwqobjEIRUxE0uuXBi:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeC0C4r (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 22:56:47 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:41476 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbeC0C4q (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Mar 2018 22:56:46 -0400
X-Google-Smtp-Source: AG47ELuc3RGu/bGc4rZRCGRl6sd+F3T2eK5r10fotQDpBqf4Ev0hLJWFDoC6kPGyURgE4w5D4z8ldSe8M+4VmvY1tBs=
MIME-Version: 1.0
In-Reply-To: <20180326192428.71c23abf@alans-desktop>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
 <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
 <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
 <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
 <CAE2855tGe0i9XoEPe9iLFpCds3fXyj9uGhDACvK06KaqvhvYBg@mail.gmail.com> <20180326192428.71c23abf@alans-desktop>
From: Aaron Durbin <adurbin@chromium.org>
Date: Mon, 26 Mar 2018 20:56:45 -0600
X-Google-Sender-Auth: yoZ7M5_gb1kKlUApaHppevxFkZQ
Message-ID: <CAE2855tGOq2jjqaZUnWJKL953iM6+9JCgkCAEXhKLkkLRdgUBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Aaron Durbin <adurbin@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Doug Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jeffy <jeffy.chen@rock-chips.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 12:24 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> Sadly, this situation
>> is not unique to this hardware. There is hardware all over that does
>> not meet the current assumptions being made in the early uart drivers
>> within the kernel.
>
> Is there any fundamental reason you can't just embed dt entries in the
> ACPI table to describe the other features you need. I appreciate it
> doesn't solve the generic PC case but it ought to help for anything where
> the firmware cares about Linux ?

What's the method for doing that? Using _DSD methods? Or have a
pointer to examples? Sorry, I haven't spelunked into the current state
of bridging ACPI and devicetree in a while.

-Aaron
