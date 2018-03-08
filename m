Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2264920-1520523276-2-8569515242702818953
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  FREEMAIL_REPLYTO_END_DIGIT 0.25, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520523274; b=R4qU3QdgLMwtKzEeJT7W8krmOXVObs4XA4SlRIOMu2wz2ql
    Qz+ro5Y0ms65ejwtFJgbdE+kPghqWk7kCRJHYhEWh75SUB+nLgdwt8ue0aAYI9IU
    iNzQYw+IcWu2exQRNyURQtemg9dUVrytONIsY/JNhIkrx3JDK3IU/tH4Q8+O2omT
    Ph+n1EMmpS414jjX2y6FyJEm4moNicGt9wQtRT3b7kYhAlqnSd1UjJFYxDNVgrGk
    agDS8OGI8zSTuK7ByLzuzHzdWtpwy+triofkHMAxY7fwsQG+5tJTbvJJcaScZEsZ
    sCOE8yy1B6XGRKP9bSQpcxXn6RYe9VCUJXneeeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:reply-to:to:cc
    :date:in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520523274; bh=0VOkjZ3cauWCpNS/Y2hW1ypmNNvhYRvoO8yD7XIZ9AU=; b=c
    pJLN6rXdEkIqEmUU8tQBPFa2lqr12MTT6KmwhHLbc8Axl1IWfYPzbzMNKKIncJZG
    YYd0xqxw9TpZMzUHu1+8FSI3C0NwgR6PiDg0MsU5rvwT/rEmEm25PC3/32nbZFwi
    2VyuGBYWzJNBqK5cnz1wiDv5nwSyXN8G6oqjOWISgO1lebVSLJVtdRb+4UGdKawD
    8bkdtROwDYmkh7FzJRnoytIxwatVOhxpegrVfbjP4/XCAY5/a+u6CGyOcejSk0bj
    1Vxh2gswzLulm/PP6JSYiAym94p4YkKc1NgEYBKWCTtLhltZ37kM45ulcDm4aR9j
    B333GMdOuLZW5iotlNi+A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755030AbeCHPed (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 10:34:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:11850 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752059AbeCHPed (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 10:34:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800";
   d="scan'208";a="37042818"
Message-ID: <1520523268.20980.43.camel@gmail.com>
Subject: Re: [PATCH] ubi: Reject MLC NAND
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Richard Weinberger <richard@nod.at>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Mark Vasut <marek.vasut@gmail.com>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, tharvey@gateworks.com,
        stable <stable@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 08 Mar 2018 17:34:28 +0200
In-Reply-To: <10429741.dU3vzh71GH@blindfold>
References: <20180303104554.5958-1-richard@nod.at>
         <3797589.z8fAhu5iDP@blindfold> <1520521275.20980.41.camel@gmail.com>
         <10429741.dU3vzh71GH@blindfold>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-08 at 16:28 +0100, Richard Weinberger wrote:
> You mean *not* widely used?

Yes, indeed, thanks for correction. MLC just wasn't there yet when
UBI/UBIFS were upstreamed.
