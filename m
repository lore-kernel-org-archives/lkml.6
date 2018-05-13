Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3191861-1526224311-2-12488952820496624531
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526224311; b=Dy/zqsucq8EoBWRbsLacTyw3IV5D8DFaFCPJWigkPPLIvHDfPH
    A69ZdTMYiRKxK3Botlw4YtXkhq/dp6+4kSeHy4O0YEKfPKRAz8kZmZshNxkpob1Z
    63EuChn+fgCh4mvTP9xa5tNIEX88Y4gENYp8jjYm/hLYUwKl6JTqIvPHeqERwOM2
    8tWwnj647yJiUOzSNeRhQ6IbkBoVAC42Zjh4lKNg5ipM2N81wKfDVadZWt+hyUgW
    ndQsmljRp1U51ZQ3nCRwkhTdUxATEfyl+tOGaAODb56gl0EsS+lYustf1tq6UoFA
    PXf9XY9iVO4/T4VLNe9Io7B+tP2HOo9+VG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526224311; bh=7k3Q2qiSCPuP2LOZ5czWKccv9X+ukDnRkFHLYskvCk
    I=; b=RqTnPB/I9TNfzkMfMOzupcxmuUsYmluBZfNX27xHc+Hn4/eMqPi9DvCiSO
    2BSDtdVNLg7SSlviL5uwdOWUzolUdfSOvUrwBxR7rPYzs5EBFH0LcKC8IZCwRqsV
    VzpU0bxHB0lrm/yKj0AEly3CyYIzHMp9iMEFaLWByM1CItcefmhGka2pRYeFcQPY
    xDlygB3GJiIDSU1qRROFlPBnxb/CxqtiQVL2FvCHPXo2VexwLOSZdHdxm9zqw9/g
    /xohdOas505f0KICIFQGJzQV8Sx2cGgyqpBymnOOWWlD8QXzoMhAYAF9rSOEyHeW
    ZsqTHSF314bXc+OqXOAXgyFBsaag==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=jBx0Dr2V x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=PZep+wsJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=jBx0Dr2V x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=PZep+wsJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJFlTJLeO7funntqTepaDDDofaC76q36CZ2oBYWTWQeA9cWjew71Ews39ZIVK5a2cG2UJlIdv2Z0aNbRsFefDzOTAFaKS4xFRtCnUxFzQPxtoRhAcspa
    F204A7khpwIX5LjbCWmXQwpsQLuRAkFHLl12kKBeyXUia+OnPQCE0szKzyvHCDaG0pZ3UucUYU1jgfCFihoIEOOxwQJJ1pVJ5iyErek/HlJDwyGFLXJl0PTn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=0aByb3_ueFGEFILzZzcA:9
    a=l9R-1pqIGbAUW3Cf:21 a=TNkPu5GnIlQLmWip:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeEMPLr (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 11:11:47 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45603 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeEMPLq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2018 11:11:46 -0400
X-Google-Smtp-Source: AB8JxZrJOG9eVVBeBL8Ud+Wzyi5Swe0DuAeEV7urGLtkiiwLAo50tJGcEPOpMlq8dqh6/xgsctWG9BbPB1B4H89mUnw=
MIME-Version: 1.0
In-Reply-To: <cover.1525785532.git.vilhelm.gray@gmail.com>
References: <cover.1525785532.git.vilhelm.gray@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 13 May 2018 18:11:45 +0300
Message-ID: <CAHp75Vf8TLhj07VKeDdvzqHvViHqgRkd6=n2hZR_yY7in52SHA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Introduce the for_each_set_port_word macro
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 4:26 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> While adding GPIO get_multiple/set_multiple callback support for various
> drivers, I noticed a pattern of looping manifesting that would be useful
> standardized as a macro.
>
> This patchset introduces the for_each_set_port_word macro and utilizes
> it in several GPIO drivers. The for_each_set_port_word macro facilitates
> a for-loop syntax that iterates over entire groups of set bits at a
> time.
>
> For example, suppose you would like to iterate over a 16-bit integer 4
> bits at a time, skipping over 4-bit groups with no set bit, where XXXX
> represents the current 4-bit group:
>
>     Example:        1011 1110 0000 1111
>     First loop:     1011 1110 0000 XXXX

>     Second loop:    1011 XXXX 0000 1111

8-bit itteration. Is it correct?

>     Third loop:     XXXX 1110 0000 1111

Looking at the example above I highly recommend to introduce some test
cases for your helper function.

Consider extending lib/test_bitmap.c for this purpose.

>
> Each iteration of the loop returns the next 4-bit group that has at
> least one set bit.
>
> The for_each_set_port_word macro has six parameters:
>
>     * port_word: set to current port word index for the iteration
>     * word_index: set to current bitmap word index for the iteration
>     * word_offset: bits offset of the found port word in the bitmap word
>     * bits: bitmap to search within
>     * size: bitmap size in number of port words
>     * port_size: port word size in number of bits
>
> The port_size argument can be an arbitrary number of bits and is not
> required to be a multiple of 2.
>
> I've called the group of bits a "port word" which may be a confusing
> naming convention; I was afraid calling that them a "group" may be too
> vague. Should a different name be chosen; what would you suggest?
>
> This patchset was rebased on top of the following three commits:
>
>     * commit aaf96e51de11 ("gpio: pci-idio-16: Fix port memory offset for get_multiple callback")
>     * commit 304440aa96c6 ("gpio: pcie-idio-24: Fix port memory offset for get_multiple/set_multiple callbacks")
>     * commit e026646c178d ("gpio: pcie-idio-24: Fix off-by-one error in get_multiple loop")
>
> William Breathitt Gray
>
> William Breathitt Gray (7):
>   bitops: Introduce the for_each_set_port_word macro
>   gpio: 104-dio-48e: Utilize for_each_set_port_word macro
>   gpio: 104-idi-48: Utilize for_each_set_port_word macro
>   gpio: gpio-mm: Utilize for_each_set_port_word macro
>   gpio: ws16c48: Utilize for_each_set_port_word macro
>   gpio: pci-idio-16: Utilize for_each_set_port_word macro
>   gpio: pcie-idio-24: Utilize for_each_set_port_word macro
>
>  drivers/gpio/gpio-104-dio-48e.c   |  67 +++++---------------
>  drivers/gpio/gpio-104-idi-48.c    |  32 ++--------
>  drivers/gpio/gpio-gpio-mm.c       |  67 +++++---------------
>  drivers/gpio/gpio-pci-idio-16.c   |  67 ++++++--------------
>  drivers/gpio/gpio-pcie-idio-24.c  | 102 +++++++++++-------------------
>  drivers/gpio/gpio-ws16c48.c       |  66 +++++--------------
>  include/asm-generic/bitops/find.h |  26 ++++++++
>  include/linux/bitops.h            |   9 +++
>  lib/find_bit.c                    |  28 ++++++++
>  9 files changed, 172 insertions(+), 292 deletions(-)
>
> --
> 2.17.0
>



-- 
With Best Regards,
Andy Shevchenko
