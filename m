Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3903547-1520446861-2-164808059910808351
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520446861; b=maUIQIRvUn3Kt7Faj5Z1t8afAaqc35NpYd0JVUb+8ZWTvUw
    NV+4GqtS8yxwAoOi9oP1ShtyWirD4U23x1Y99HCiKnC/8j74FS61P6U0kKzUOeBy
    RtIRvVWCNIK2JQCUQ2jcrjNLw/QlJ9AsLlVULhp3B2mrJ+gExYzCrpL/taXQh71H
    LKCiVowSGooc9Ul7uaatnC5AWxsIumrr5MEsfyriPj6B6/eF1IQLymsDM4APe2xS
    Gdmy1ytKaIvfiXccFgUSpABNjwT82alCVhcjmAOOwArt1qOuC0PizpKKTRE1nicw
    NpS/ImAcBLMZSrC6JiRjlqfqMDmMUpIWoGc9m0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520446861; bh=gYldp0KX4K0gXjjq9tO0tFxvUyJGt3vsNsvjuP
    Pr+mk=; b=astL7+eXhfrdNoPSX3fFg+0BzItpqwypk4gXC0ujPiSDtloB4EpEkB
    MMl+l5TaNWBRbfflnDWdhwRVx3B6jaHjwXV9jDw7pp1O4BeKPzAmfKqbKkvO1byM
    3uOlbEqJOcC44E//i5jLQ4h9UyyLfDKWsTeeR2gixe0x2DbHb8R4toIQhVhOIx7u
    UlLUepjPvnii4WKRguixNYFQj1iIWa0em4vZG3ULJvk6plQ0fRZKzO3bS4ZkuCib
    rwmHPHsgwqyBMd9cdSoBaObotP3uIaTGg43n10nUD7lW3BTM+S6dJ04QFQdImDjO
    kmMFYtBiiEIfodsgv1RGUUq6rK/EAEuQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VkAx5mLf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DkmOy3vc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VkAx5mLf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DkmOy3vc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeCGSU5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 13:20:57 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:41649 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753949AbeCGSU4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 7 Mar 2018 13:20:56 -0500
X-Google-Smtp-Source: AG47ELubvnsYW8JIB5JkJHiO5vh7X+sD2xdv3F1qejfzG9awB6gQ/43zl3PlkHDz1naM67kOguhktXKJ3kZys41iY50=
MIME-Version: 1.0
In-Reply-To: <1520446082-12264-1-git-send-email-himanshujha199640@gmail.com>
References: <1520446082-12264-1-git-send-email-himanshujha199640@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 7 Mar 2018 20:20:54 +0200
Message-ID: <CAHp75VfEvKfQ2pp6wG5BXjB38egr_ocQ_dwSXifmj5MwAyNSAA@mail.gmail.com>
Subject: Re: [PATCH] usb: isp1760: Use kasprintf
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 8:08 PM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> Use kasprintf instead of combination of kmalloc and sprintf and
> therefore avoid unnecessary computation of string length.

>         devname = dev_name(isp->dev);

Do you still need this temporary variable?

> -       udc->irqname = kmalloc(strlen(devname) + 7, GFP_KERNEL);
> +       udc->irqname = kasprintf(GFP_KERNEL, "%s (udc)", devname);

Perhaps

devname -> dev_name(isp->dev)

?


-- 
With Best Regards,
Andy Shevchenko
