Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3191861-1526224009-2-12220944519982799354
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526224008; b=mi5SJqDv3taNqpI4pjzQkPDx3EEcunfECdc4u8KIWGKWHa105b
    6gSePZUbH22xdZcaeSAhQvKmKbAUWCl7cO+thRMYQBNyO5ousI8AUeUloxP/M/oR
    rM0D/rAxOMPL4HxbOTRw9hjbYQMyv+k6rBmvsAXKfMSaszEBvl8tpuSZ2cFvA+zx
    tcK/YXwyO1tHKHiGq20H2U9Mw3TKFLhOCBwdqYw2nsWWrutJszwM9HmMIDjmJ1HS
    LzRxd6yl7wBHyejwEfWDhOOY30pfxOxJFV01G1OIpMo22De1qIsLhn+GcxHPm9FZ
    DksEw3qPaELCsXgJi79DIjIR2p2/pJMpK+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526224008; bh=gYyWvsU+93odVZH2ZuK8V7EbVrbRL3huRfHb8xiy9l
    s=; b=K97TwoI/PzXs/tedWAG7+gtpl0VlAF3asHGjjiG0CIsng3PrwIkmBy0o6s
    0rqqCR6nqy0jgb3T3myWZldSHGlagizkX5TwzAvJfYU9kRSruZ4y+/FujGVr0kfj
    iuR8kLZGPjcF07JrIYyDD2VFEVlV+yd2BktFOFxYEdd2E6iY1k9lS16zCcn3fYWJ
    TwJx9Eourv6IfS8YS8cOf2CeCeNt1VEtHdUWfkT1P912/GMbqOtcPvcuTOFy25va
    TGEtgcudnqNAjhCtH/Yr/JLoVl9OW2xO0UO6MZwzU1k7wwBHlWrHjaGPrUw6dVFn
    28GyZ9gisFY3/v4R9Rq/1ssIz6hg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=RYQWO3Mw x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=k2paeUJw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=RYQWO3Mw x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=k2paeUJw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH7haIvM3I89GA6CX8OVlw7j+HWtg2NRN+gC7LBhqWpbR5Pym8jSEErmZiERAxJbbHE5f6VENrjRkaWF3h9DCgf3y1jgJlnCX070aGDHr2s7vzFfCB6k
    gGZEJKYsmK1cLKTJQJWJrpsSvOENRAyyPmOuIpq67RLItBFQQMe8LNiPiYkqIDp20Kufet4Spm2tQFvynwNCvWcXNdZH8t9lReTs1DWOZd2lA0+vCoka2FKC
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=Pr0-dAGPk_9eYMltW1kA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeEMPGo (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 11:06:44 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:46530 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeEMPGo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2018 11:06:44 -0400
X-Google-Smtp-Source: AB8JxZpHB2i3tk498GDejVS+PvrJDUODHbsupeCnZFCznxADMbOPMMGJb7rRsTE5xtf9VDrhaDZMWcug6LrRExsWsJo=
MIME-Version: 1.0
In-Reply-To: <c919f6c2ff54a29114bd5e566997f11e5ebf29c3.1525785532.git.vilhelm.gray@gmail.com>
References: <cover.1525785532.git.vilhelm.gray@gmail.com> <c919f6c2ff54a29114bd5e566997f11e5ebf29c3.1525785532.git.vilhelm.gray@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 18:06:42 +0300
Message-ID: <CAHp75VdBL-K2H9tXAG2wPefCdpv913dbJOvvEkOXE7r=+2+NYQ@mail.gmail.com>
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

On Tue, May 8, 2018 at 4:26 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> This macro iterates for each group of bits (port word) with set bits,
> within a bitmap memory region. For each iteration, "port_word" is set to
> the found port word index, "word_index" is set to the word index of the
> bitmap containing the found port word, and "word_offset" is set to the
> bit offset of the found port word within the respective bitmap word.

Isn't that idea we discussed some time ago?

In any case, part "port" is too specific for a generic function like
this. Please, get rid of it completely. No-one knows what port means
here. Just makes a lot of confusion.

> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -20,6 +20,7 @@
>  #include <linux/bitmap.h>
>  #include <linux/export.h>
>  #include <linux/kernel.h>

> +#include <linux/types.h>

No need. It's included by bitmap.h IIRC.


-- 
With Best Regards,
Andy Shevchenko
