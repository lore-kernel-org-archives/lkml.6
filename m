Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2940596-1524139496-2-4481715988589477365
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524139496; b=rwPbEcc8fkt/LhFpqc9AVXEOAofWSfhxOREfBwj6iwKlZQUCFi
    xTjbElOUuvsAvry6koNkjnOwz4Cu5LNIiruw4CjL8qFS+U9T2L2MM639yExjFenj
    kBszHDwIHeZxCRbXcg9QTFkNW34y0tNLHvIXoru6AiummwE3amuR03cjXqdxnSYG
    P563nMfWmwSrbFnjb0v1w2HLqsfZopT+ujmfuceI6DqERxzdfj53Y9OLZnAWsAZN
    zo9fLJCkN3kuJPqZ939ysjxucSYqBI3t13h3PKFnkMLlBUE786dVRMS80NxlyBtb
    fN0w24ZkAMYesgQKlaHKJPizKic3QlP+ka0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524139496; bh=+StI40tZPkaf3TNFRDIlx671IKNx+JP+xNUpVeR9Ud
    8=; b=QrtN76FAqh6a7H8qXZX9GpaU2PxD6wGfOQt2Ra9IzyjWygsHfhUqrZyBey
    oEiqJp0C5i36ZzY1SedBq6CeC0kuyJ60uv+MU4BfrXhSHRK7BonnE6Cb7H2ffWw+
    1SStKv3VEKoYUcVqI0Ws96oZryZUNHi2kMAtm3R0HhWcGdq4yzLbgO6KKwizIIG3
    NUnLnXXJiuYN5j9e/dZjQRY8B/nOaGv2ySy6Ie3lFxcSiwnVDOxqvrWVWpFG+PiM
    g210UcDIoR4MbihOYk1gFMIGSeqe2zSzuNRlMJEwG85jGPM0bXtwyVeNbPF864SH
    Rd87q0O3YjVlG2QBcDoEux1xiOig==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Cg4NdEuY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gHZ2N9PK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Cg4NdEuY x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gHZ2N9PK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJesKHZu+2fLOHVFcoq+at8zXnDBPi6RQUQVkSqftYyJOkUWsAzkY7deIbqBEYbVtMAXljgtaeyEy5ORn0RNBuZSNcCxTCQk5XUj5+pyxS45Mb0/V68u
    I/J/uJ5DAeUCmthDcu7S1/UbK6TBZU8HD2YPwlurs8FbjyA+uy8yEHkn50t9HnH5I/ho6dT6JvBcRFdWlceRnRNR75ljsUXuCX4rTudBLjnguKCfwtMBmfly
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=fUSZZkATYxXnQMecnGkA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeDSMEm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 08:04:42 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34659 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeDSMEl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 08:04:41 -0400
X-Google-Smtp-Source: AB8JxZrvKeheNiRCpaq7R89NdBMg+yp+slmCqPdmAMeETGkUuhOzN49yKUnn2sf7Uexc2DmgR31xcTlLU1yB0vVd2A4=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1804191240510.1563@nanos.tec.linutronix.de>
References: <CAK8P3a2CEK=4Os4gbnXbR7VJJgaXVQ7NLjihr7rvMSK6g3_tNA@mail.gmail.com>
 <alpine.DEB.2.21.1804191240510.1563@nanos.tec.linutronix.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 14:04:40 +0200
X-Google-Sender-Auth: sqglUqhw9bpZLJBVatw8F0bHGms
Message-ID: <CAK8P3a28Ke-_tjggf2FvO+vsPs3BcoNUbPBNj+xnKXb5FkomyQ@mail.gmail.com>
Subject: Re: [tip GIT PULL] y2038: timekeeping syscall changes
To: Thomas Gleixner <tglx@linutronix.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 12:48 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Can you please fix that and send me an updated pull request?

Done. I sent a v2 pull request now as a separate thread. I still messed
up the URL but replied with the correct one and figured out how to
get that all automatically now.

       Arnd
