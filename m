Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-765481-1526303085-2-117385107543133306
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526303085; b=SuNvr60oRwlGicSx7Zukfc9GQ/I5Qbiw7koaBWx/Y51Tv2btTz
    Puc9l6penvPo6mSRIqimQYLs02x0ycHa3Q9avKTondFvRodnRejAYMcgIk1q2paQ
    T8EMcgLDIzbf9cbSn4biXaiRkGBd1eg6ufIn27I+WEHeQBAd7K0mA+tLOWF1a72Q
    F5NNaM1r6nZF1yJIbgCcHO1XNU1GfKTVcTghVrI3q8RA08dKGkoblzmGeWK/RiHp
    BaBngIRME+9vpEmDaBm0hUonlsPQ/A9zzwW/qTXEHoddm0v6vwYhRU3T267dXf2O
    WRZjVFhy3HgamXzPiZL3h8E9bw8tTlA/p5Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526303085; bh=AiX5zXgkM/jr+EPfqt+srmNWlMhf+f
    B4F9KIGeJKVXw=; b=M23Xz7zHoaMzLpr4V5otMhHm2PKA+7KQyPOQxie9ich2D3
    mKQJvKsb3yRcMnhrVT+ittNHk2/5Ux7huOUvXxszg/vAadmveC4QlNFhc757Klul
    Mbez5Ml8iDcM+Q9g7HHtzRdQ6Vu7wVklVPnVqEb7NXwZg7oC0e8munwOXU8/sVQT
    6FC01qPqYhS4vXhqeK8YACwOnTl5UbpeSPl5u5klmDfHOiYtbEODwGAdnh+PBIsz
    IWx1aw50Ucr0RvqQC5j5Kq4i5/bUj1vveUCNIXcsO9aHD2i2q4Ui/zjRxzjSfuyQ
    pSP/Pctib1tvqYWmJgPBpNaB9p4ICxQq7UW4j11A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=hflXlt3Y x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=dDKFqmqs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=hflXlt3Y x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=dDKFqmqs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOmLJDz6ho0pXZDGrRpq7flAyvD2iptJT78W4E+Ydgev7yym+rDlFrvQNKy9d4z12jtyJw54fj8GiJH2s7D7RjEV/VI6VqrKuYxb3QytSaueZuZ6Pzhv
    Z3c9QutWBZzNBMAkvPhILynCVikFUyoCS7RRDCWkRRqOS7EY+ZmnkbcB1ZR5cKt9Ssd/4QU1D8ZuT3jn5vlKA8WagT9abn9/clY6c6449q++iVWENmFunjSt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=i6uMeK6BI1QA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=H4sSVFdjL9cGooWMoAIA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753416AbeENNEm (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 09:04:42 -0400
Received: from mail-yb0-f172.google.com ([209.85.213.172]:37735 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbeENNEl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 May 2018 09:04:41 -0400
X-Google-Smtp-Source: AB8JxZqo0q0eQkmCpvcv5OcYgPpW/JcWYYGIsAxcb0x6yuLUO4zrd8er6WPy9jdlJIzYMi5U3dohpw==
Date: Mon, 14 May 2018 09:04:38 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/7] bitops: Introduce the for_each_set_port_word macro
Message-ID: <20180514130438.GB20325@sophia>
References: <cover.1525785532.git.vilhelm.gray@gmail.com>
 <c919f6c2ff54a29114bd5e566997f11e5ebf29c3.1525785532.git.vilhelm.gray@gmail.com>
 <CAHp75VdBL-K2H9tXAG2wPefCdpv913dbJOvvEkOXE7r=+2+NYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VdBL-K2H9tXAG2wPefCdpv913dbJOvvEkOXE7r=+2+NYQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 13, 2018 at 06:06:42PM +0300, Andy Shevchenko wrote:
>On Tue, May 8, 2018 at 4:26 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>> This macro iterates for each group of bits (port word) with set bits,
>> within a bitmap memory region. For each iteration, "port_word" is set to
>> the found port word index, "word_index" is set to the word index of the
>> bitmap containing the found port word, and "word_offset" is set to the
>> bit offset of the found port word within the respective bitmap word.
>
>Isn't that idea we discussed some time ago?

That's right, I found the time to implement the macro suggestion you
made during the get_multiple/set_multiple patchset for the PC104 GPIO
drivers a while ago.

This macro greatly simplifies the callback function implementations in
those drivers and reduces the repeated code that kept appearing among
those drivers. Hopefully it can be useful for other drivers as well.

>
>In any case, part "port" is too specific for a generic function like
>this. Please, get rid of it completely. No-one knows what port means
>here. Just makes a lot of confusion.

Okay, I'll come up with a better name and submit a version 3 of this
patchset.

>
>> --- a/lib/find_bit.c
>> +++ b/lib/find_bit.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/bitmap.h>
>>  #include <linux/export.h>
>>  #include <linux/kernel.h>
>
>> +#include <linux/types.h>
>
>No need. It's included by bitmap.h IIRC.

Ah, you are correct, I'll remove this line then.

William Breathitt Gray

>
>
>-- 
>With Best Regards,
>Andy Shevchenko
