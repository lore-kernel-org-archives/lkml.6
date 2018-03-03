Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-511746-1520094324-2-15370348494557556555
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520094324; b=wxta1s74ZJWWHjpi3OpZh/Eqzyl4LIygc5X2G/wkjNbFMRw
    xmilB7ncdSb16OsK595tlr5H93bT3S6nmPHTtuB/eFE47/ukfsW3Uw2sFm7uir9A
    LW7boGdeVmG0+8tgFnnMPHe4dV24gvwc/HDkwjQuKa0bmGpl6O/g77Mli1WThnhP
    gxQzp/l4NbiziXR5kebpxVaSd85bK3Fe+4dSwtIneNIhPcBVlGYuvpyxopPUcu21
    u50xUokP/Fbn9Fr6+ijYaeZeWCZK5Y8m0fZlwLxJkVa5knQVp2Hy76eEdw9FICSF
    hh97OPs1c0qNr1+fZY4oM+zIdyinlu6DzBT+AIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520094324; bh=LI/IHGajrocdOjR173Xmj28Cgi5HOHgdtY7tDu
    4s+NA=; b=ZSQ677ag9+vLcuXdPeVtHVSBu5OfFmABplBZnjTfbfYr0/F7iN2cQT
    K0FDJbQ7+9ek4dfuKZR7uw9tnIlBfjzjeOwqNpEVt6HX58dWyqbM6tE3LUFFOVXH
    5GoJSNh0iCxit8f3tOx0TkLF1B8J+g3vuXXDiLCIblP3t0OGpLSzYR2QLi1TjbJu
    ge2C4ZDYJ76HJM4dzlcuMm06+l7Niz3H2oNaxcQxiKjEmTMO4E1M0Q3zu1x9Opqg
    zVZtZOuXASy2VN5PlHW4mQXFe5PDo4lh9tm4TjgIgrRWpVw84sxiWVRmTExMDIDY
    dklzTH17aVz/HFnup7fNHObr/MdsH9Qg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=M2KVnk47 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aPPr7ek9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=M2KVnk47 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aPPr7ek9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeCCQZU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 11:25:20 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44980 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeCCQZS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Mar 2018 11:25:18 -0500
X-Google-Smtp-Source: AG47ELtPeqrkL3kszyUlGL8ro1ZjpprHkKEl2tjjLqvqHiQEB7EM3NfSMV6uAIlgekp2TeGH6WjWSrVaVSLG+u7yR8U=
MIME-Version: 1.0
In-Reply-To: <20180302162821.bmsxgrqqaginjooo@lakrids.cambridge.arm.com>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk> <20180302124647.sfhnto77wgdh5sv6@katana>
 <20180302125907.GA9418@n2100.armlinux.org.uk> <20180302135854.76ue5jzsg7lvxjxw@katana>
 <20180302140901.lrjqiaa2k4nxkqco@mwanda> <20180302153221.GB9418@n2100.armlinux.org.uk>
 <20180302162821.bmsxgrqqaginjooo@lakrids.cambridge.arm.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 3 Mar 2018 18:25:17 +0200
Message-ID: <CAHp75VcPMmATbCCczm3NqNDGCda6J5vga-FDW4SFABaqBKe4iw@mail.gmail.com>
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
To: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-samsung-soc@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Stable <stable@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 2, 2018 at 6:28 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Mar 02, 2018 at 03:32:22PM +0000, Russell King - ARM Linux wrote:
>> How do we break this status quo and finally solve the IRQ 0 and
>> NO_IRQ issue?

Guys, the question: Wouldn't be request_irq() failed when it gets a
wrong number on input?

-- 
With Best Regards,
Andy Shevchenko
