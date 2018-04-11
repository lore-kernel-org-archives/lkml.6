Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523472637-2-12248797872143218358
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523472637; b=n8Ku+juojcbIeB+lLBMZOZFZdD1fNtTMivd3db2/kl0IDf73ni
    xs9MM8uzHV4uxXo8hHhX/Iq+F6ktqsaoahb8ev12WA3dNcghTVG8FY3nf7w4Iznb
    zcWxOSDHr9YnE+O4BvWJuf3lee4DuQXr+72xOHpy4p1/5FkKMZbdIvJ3NgW9jKJf
    X9SzQV0OSUmFWgLsfuQ6/IHY5zNiGWHEsjeBylcRUZqWnXLRAVz1uEghOgFN1aER
    wGa+lUCpRQT1Kq0i00zqSCjOF4lI48dJFCBmY/5+G38cxfdKgz4so9GQm60cP6Ml
    m4rW2yz+iK6/DGcrlI/tvwtngdSq+1jTvQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523472637; bh=zmOmSFE1asy24hZDKNTAm1/F8QS8A4v5MUKsVzn1nS
    Q=; b=rHnmaYoNt5tbdjmqYvU+ZrEwOtA67LbTG8nrejDLQUnImxRnWlEh1CH5+i
    w1RG/6PSvKkDXGSayx2j0uR7USUZn3rSUb8Om7gtrlG8FMGeNxUxs1KF0rFGYrJT
    T7YKOL3ltcoXRhYn7x0IYyyy+ak5tI6+rR5OR7XB3TwU0bm3PEZajksg8MBXdsae
    N8TM9fR4KXGP5fBDYSJiLROwKUEFeOYK2e2abcoXe9+uBSUopGnzSGlOy89PUE1Y
    T+hGTcyzK4LWpypjxW6lwqDOETNGCtPqCoU8E0g3WXBRAh+lUa0wWeewUc/ycW1P
    M5k+zCSKZNKsDfYQaks90ixRKH3A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=r6TPUEDV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IeP/E+im;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=r6TPUEDV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IeP/E+im;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAwvklZippjrjW+WRvD9hq8noKXD/ID5DM4C3UfjKx3Ro1OzkWjB9vvgUdXDh/pAj6bNC4mXHtGkODXaVuVPLy5kagWD0vzyKxWHSCQWBp7Bgc8Bqjv9
    uCUw5A+lLYGevRM3zm8Ov7FKdHYS6ux4Q/vbGkxs7tUzOs6iNg7sbw2swR3tAFpPZWSg+Rg1+iOMB5y7NX2Pg9PmmM+FSs115uW3BKw5ekkLKR2abjlr07p0
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=QWYVPwJI23wA:10 a=Kd1tUaAdevIA:10 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8
    a=inoG4m36AAAA:8 a=VwQbUJbxAAAA:8 a=UgOiYDegew-9PT1OC1kA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=_Qgj-RFg6mImvLaOgLPg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbeDKSuZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:50:25 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46125 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932631AbeDKSuW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 14:50:22 -0400
X-Google-Smtp-Source: AIpwx485EB6on3N71Hj9lhnrfKX9JIcgtRAPE3MZp/XX3rYW08QFqZ1lvA+/FN+PvH/BKMmXfD1Js0NoYZ0T0r3k3qI=
MIME-Version: 1.0
In-Reply-To: <6a37b428-d9fb-12d5-8d36-8a032984af8c@infradead.org>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk> <6a37b428-d9fb-12d5-8d36-8a032984af8c@infradead.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 11 Apr 2018 20:50:00 +0200
Message-ID: <CANiq72n=b3ghgHzknhY=fNP9=f8fi8OuW7OPQHXQGJH_aWrT-w@mail.gmail.com>
Subject: Re: [PATCH 01/24] Add the ability to lock down access to the running
 kernel image
To: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 7:37 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 04/11/2018 09:24 AM, David Howells wrote:
>
>> diff --git a/security/lock_down.c b/security/lock_down.c
>> new file mode 100644
>> index 000000000000..f35ffdd096ad
>> --- /dev/null
>> +++ b/security/lock_down.c
>> @@ -0,0 +1,65 @@
>> +/* Lock down the kernel
>> + *
>> + * Copyright (C) 2016 Red Hat, Inc. All Rights Reserved.
>> + * Written by David Howells (dhowells@redhat.com)
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public Licence
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the Licence, or (at your option) any later version.
>
> fsf.org spells that Licence word as License. :)

Given this is a new file, simply use the SPF identifier on top.

Cheers,
Miguel
