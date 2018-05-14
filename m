Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1071218-1526317692-2-9745754764258670547
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526317691; b=BKT1SvsOoRsLncmWuWNbY6MQZnwtfA7PQ/GmxSUJcMxYhS9rLO
    olzFgrQYG0ZPxSgJQNqLgCyO9vr71N6BGUN6KQ3jyrSuaZ9HIrN+uaAx0O3FH43H
    TzFhK/aBeY+M1NCvp1LoM6pdULkjRaX6baev5Cu0sUIeD6LD2i5AuNTO8iKDsC7k
    ha+8J8YJnLUrAGqchnkd+8aSm7//bzKxaETgZMuP+FkYwgbhjnExjaQU5dy44Jb4
    8ERI/af0epRXosbAR3bQwSafcyfXE8D9KK9QDtz/0SHXDj3yefrX4Xkwf5F6tQN5
    LYzAVK2cOcQ2vUL3Y7JNmPp1NJ9QOekob+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526317691; bh=5uUhHOTBxCgBzDJWJ4JGKGmy/sdI4SEw+ukmAY3OJM
    U=; b=ZdXnn282A+Vz1AKDzaW2DRMiWpK5ca/W24/i/s+6dYyFgyKXdjzNhW8XWj
    v6B12MdgXSnDp2FLvWqtymJIjNcjaYXtC+Bc+2cM9h3cHOcd6gOrddUdtrsFfPut
    VoVEJqBkSdXDzeagZ1jYHZO7efImXDUdQDG1789DVLI2j6pQAK/xeJQCY2t5wlfo
    xkJ0GZyz4zZbcTG9b9biMzbPXFd6Jl0wM6Dtk8a7cfSHrztSRLHoPOuIgt5DeMZ2
    pmeoj+rYrKhlWrwUmxqcF2fn5+XmCKZdgflEHVMy/oCe8rcdar88h8xtHZBVDDUV
    RXihJBJi+Hkr7GLH/YSWfOeBRv6g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=XeKzepZp x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=uabKDOhS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=XeKzepZp x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=uabKDOhS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAIYJdz+88SwB5ZqZFXYbAvFLQqG4AuIpLXpw/qV0mXIKuMujnAMY7YPZA9Pl7E6feHDclUYzXde1DFh+4/vprJ6UZEGP8OO8OxJvOffLUTzwms2O+25
    eNy3yrE04B5H6RtcdEFuH1sFuaBbVEYPaJrpt4rRX76eG/S94VHtxPQNpLCfYeGPsjzAROpfAJapxot+H8ioVCPOQ+PUay2aJq14NiY0jkTQtU7U5WAjLzri
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=5jLf1UoQtEdzsVzWfaQA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeENRIJ (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 13:08:09 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34725 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeENRII (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 May 2018 13:08:08 -0400
X-Google-Smtp-Source: AB8JxZoWC0m4NKOdU0BM3voiKenI/pjH1ZGsf4Jpu2bNL3OMMyzXXP8RAxwcbcnYJRxif//sCd00NuKfvgsUmyTcaXA=
MIME-Version: 1.0
In-Reply-To: <20180514130438.GB20325@sophia>
References: <cover.1525785532.git.vilhelm.gray@gmail.com> <c919f6c2ff54a29114bd5e566997f11e5ebf29c3.1525785532.git.vilhelm.gray@gmail.com>
 <CAHp75VdBL-K2H9tXAG2wPefCdpv913dbJOvvEkOXE7r=+2+NYQ@mail.gmail.com> <20180514130438.GB20325@sophia>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 20:08:06 +0300
Message-ID: <CAHp75VdRksnTB_Bq_3-V7h_Dd=woj9=998DsVih-MtQo2hUbaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] bitops: Introduce the for_each_set_port_word macro
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 4:04 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Sun, May 13, 2018 at 06:06:42PM +0300, Andy Shevchenko wrote:
>>On Tue, May 8, 2018 at 4:26 PM, William Breathitt Gray
>><vilhelm.gray@gmail.com> wrote:
>>> This macro iterates for each group of bits (port word) with set bits,
>>> within a bitmap memory region. For each iteration, "port_word" is set to
>>> the found port word index, "word_index" is set to the word index of the
>>> bitmap containing the found port word, and "word_offset" is set to the
>>> bit offset of the found port word within the respective bitmap word.
>>
>>Isn't that idea we discussed some time ago?
>
> That's right, I found the time to implement the macro suggestion you
> made during the get_multiple/set_multiple patchset for the PC104 GPIO
> drivers a while ago.

So, if you find it appropriate, please add Suggested-by.

> This macro greatly simplifies the callback function implementations in
> those drivers and reduces the repeated code that kept appearing among
> those drivers. Hopefully it can be useful for other drivers as well.

Yes, I like the idea!

>>In any case, part "port" is too specific for a generic function like
>>this. Please, get rid of it completely. No-one knows what port means
>>here. Just makes a lot of confusion.
>
> Okay, I'll come up with a better name and submit a version 3 of this
> patchset.

I also forgot to mention that kernel-doc should accompany function
definition (in *.c), and not a declaration (in *.h).

-- 
With Best Regards,
Andy Shevchenko
