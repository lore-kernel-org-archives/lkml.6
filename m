Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-811314-1526501315-2-18102901914750498135
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526501315; b=BIKq0/azNbuR3CBWCbthPzRjFKjJrC0PqqCWwV86aDNi8QHTvG
    DlNdtbMQT2F93gqW3uQciTDJDA2D8ghppbVRLmuiztuYO7ZijyL4vzL8o50GA0Ma
    KEHkr6nux69zPqIXS1PfiStKC1j13Y5cQXQvRxUGin19XdU7F37qyUSD1b0YxHRN
    S9I8IuhfDtHGEwcMTguIkLmVWFZabdQMJkb/hHGySk+1ikO613QPZdpJqoC1XcNf
    Ns93tCDb3nnYEjDpvUoW1OxPdCbIqwqgBueG93XdGUQ1x0DUkKjZEo1QAJhPe8Pn
    VxGQe3tvnke9AbJYGJMqBbwyhJH6g+Hq0xZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526501315; bh=B1mXDECNKyGeV4WvTGwEeGi2h4YOPfixv8oX2YluUm
    A=; b=XdHa7vD19KlE/bitDlxt61s6+Jsxy9HvK5py+kWB1MvukvGwwflY4spX4g
    +JhHtHWbUKU19nt05+7EhStH9TILDstj3wFBpcEEILczF3mU+PNevm+sIdfkM/M/
    aCkJcVcz+dZG3y0p3Ysijuo2p7nUWvDRizk2ch3d0OPnWBnVrefJumeH939lw5O2
    Ha4krlbaZaGk/gJLliFIZwV0Gjfg/P2Qo14b+FTao+7PAyjVrHpNKw7jbEPFSN8c
    QO4qs0hwCpN6TQUh4Gy7x5GAuPiiRj6n3B4WPJjp4Q/voWn5Swp50L//Gn6FO1hm
    lVjxZzm2VP7798639pf+7TTvoi6w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=KQfkpR7d x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=sIsBu5q0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=KQfkpR7d x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=sIsBu5q0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJVj/zlLpnA7wgwFsz6K3jYqh8hK7+saDLhmzjiaJW0z7PEB1FbWJ2iFjPFLqSIHTmcqaSsL7vtNA+6eyiYOS2/4B11FxF1UQrkM1k6+KZu4gD2OJxHs
    ie8OaIH8hcTFHNtUwHj6XA11vzFr7KWMwyMLf3SlhT9jtGaOahhAjj2QdNwKF+8IdYonXkFMzxCxICPYL3WMQFt9G6zKuC2INvNMTqMjwsOs1leuT9MwKEGX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
    a=cqvmlmxeAAAA:8 a=JMtnl-tTgbdo7rGbwJQA:9 a=tCpMe-zNbNBEihrx:21
    a=PoMfzTmNa2mb7rBR:21 a=QEXdDO2ut3YA:10 a=t_ttxzwXqboA:10
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeEPUIc (ORCPT <rfc822;linux@kroah.com>);
        Wed, 16 May 2018 16:08:32 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:38269 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbeEPUIa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 May 2018 16:08:30 -0400
X-Google-Smtp-Source: AB8JxZoX0tfyU7+Q1yHEYdsepe215FGjRfTDOzr89pBIIBMy6+qZnmG/pNhAO8OTKi9YY/meOIzfjVm+LRZZb5Mc6IY=
MIME-Version: 1.0
In-Reply-To: <CACRpkdbRH-Bz3BoczD+YmaSGqtoeCwtvGj4dGm8PKRKYFXTdKA@mail.gmail.com>
References: <cover.1526400945.git.vilhelm.gray@gmail.com> <CACRpkdbRH-Bz3BoczD+YmaSGqtoeCwtvGj4dGm8PKRKYFXTdKA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 May 2018 23:08:28 +0300
Message-ID: <CAHp75VcGuJ0+qzUZZW=1VSeXmf_rht0tJvCH+yBsXPZz0z8qHA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Introduce the for_each_set_clump macro
To: Linus Walleij <linus.walleij@linaro.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 5:03 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, May 15, 2018 at 6:22 PM, William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
>
>> For example, suppose you would like to iterate over a 16-bit integer 4
>> bits at a time, skipping over 4-bit groups with no set bit, where XXXX
>> represents the current 4-bit group:
>>
>>     Example:        1011 1110 0000 1111
>>     First loop:     1011 1110 0000 XXXX
>>     Second loop:    1011 XXXX 0000 1111
>>     Third loop:     XXXX 1110 0000 1111
>>
>> Each iteration of the loop returns the next 4-bit group that has at
>> least one set bit.
>>
>> The for_each_set_clump macro has six parameters:
>>
>>     * clump: set to current clump index for the iteration
>>     * index: set to current bitmap word index for the iteration
>>     * offset: bits offset of the found clump in the bitmap word
>>     * bits: bitmap to search within
>>     * size: bitmap size in number of clumps
>>     * clump_size: clump size in number of bits
>>
>> The clump_size argument can be an arbitrary number of bits and is not
>> required to be a multiple of 2.
>
> I must say I'm impressed. Very nice arithmetics going on there.
>
> If I can get some ACK for the bitops patch I'd be happy to merge
> it all through the GPIO tree. The users are pretty clear cut.

Give me also some time to go through proposed API, I think it might
have needed more alignment with existing find_* and for_* helpers.

> BTW: if I could, I would pull out Donald Knuth's "The Art of Computer
> Programming vol 4A" chapter 7.1.3 "Bitwise Tricks and Techniques"
> to see what he has to say about the subject, but I don't have
> that book as it turns out.

I can also add the Standford collection of bit algos here:

https://graphics.stanford.edu/~seander/bithacks.html

-- 
With Best Regards,
Andy Shevchenko
