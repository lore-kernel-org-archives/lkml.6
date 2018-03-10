Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3802465-1520707724-2-4173077477045280556
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520707723; b=M8A0lplCQfGm/RJ599vXsmK7n3mcLUFOb5ZFEHBVqz5kvXK
    n0FQa0Pj6BJqPTsoTIi/c/OQhcpoDQPOdJHNjyk9Ko6f3wcgK57qmyTsvEgGhrsd
    gV/EgKNnaQFwfe7ChOy47SP/O0BV1lDX04iQWgAz7ToivsMlLjYvJj8qxpiVCRPf
    CmJN4nZRAggYMchEl63orYFw5Pzn0jhiqHmmbgHMGeSS21QkDCek/92t6uTrYmeI
    SX/mLgJhVcv+PjUe9dOVd9uIUvgCKe9QnYtUtRzr0ZEjngnCW9KAKcfCqPVvU8HD
    v9td1GsqfrlgHbnXi/fpT3yKXuPVKWcVwoE1MeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520707723; bh=nNO+xvIZZ/wOu6e+0U+qpDI4HNkwaztcQRQn8I
    J5Nzo=; b=t8lkJ88Pmw76CryiTNIsRr8I/HuqCFwZUuZC6Fdh9pXX38jYO82hhr
    hYMKi5rOnfQN9l73oAKOto+ccAVyBFJv1nhXRn18LU5xyI0G95AjuejSR1wfns+E
    UmR5q1zVmn/fhELGMEQu1hcyt+5jL7NwH8NfZuMZi4GqaVmuhtjMohPIndC9ElTa
    HOLLr0Bnj9eNm8RHMWvwqe7BByW5Y+RrI1cxD6XboqNz+et8l+qwVwqJzL5qol/5
    HzhFABcoSA/QQz0u2LvdLs8au9keddEGxsmX7j2LZMHDsUBzpXL3fDtumA5Ku+pK
    kXkMoRs6Do60suJfs41KpAFBPnRJex+g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OYxdrzHU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eWbcLJYB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OYxdrzHU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eWbcLJYB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932114AbeCJSsY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 13:48:24 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34842 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbeCJSsX (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sat, 10 Mar 2018 13:48:23 -0500
X-Google-Smtp-Source: AG47ELtigwE2pV17zXxXvJZ+iXo2Spfk8Gg4wwkxbGk/EYfojFP88MlIgWjUWkHy84NVG738qDRzFEhMwcwkA4bFALI=
MIME-Version: 1.0
In-Reply-To: <1520707317.5345.15.camel@perches.com>
References: <b92bebdb-c1dc-a9d3-2e3a-845d8dc4998f@users.sourceforge.net>
 <a7fff45f-4426-ec33-8b8d-caf1e3a9f0be@users.sourceforge.net> <1520707317.5345.15.camel@perches.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 10 Mar 2018 20:48:21 +0200
Message-ID: <CAHp75VfJQPUsfJ14MvoJiN4S72EaNXdf1K+ahdZ8pX3qOFMkEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/usb/ax88179_178a: Use common code in ax88179_chk_eee()
To: Joe Perches <joe@perches.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
        USB <linux-usb@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>,
        Philippe Reynes <tremyfr@gmail.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 8:41 PM, Joe Perches <joe@perches.com> wrote:
> On Sat, 2018-03-10 at 19:24 +0100, SF Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Sat, 10 Mar 2018 18:22:43 +0100
>>
>> Adjust a jump target so that a bit of common code can be better reused
>> at the end of this function.
>
> Please stop mindlessly sending patching Markus.
>
> How about looking at the code being modified and
> thinking about what it does?

You have a strong nerve, I gave up on him and would rather simple ban.

-- 
With Best Regards,
Andy Shevchenko
