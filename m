Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-798120-1526302687-2-15698960413287969942
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526302687; b=h8+Fp43ixVezB0IrSQPEaRIQs9rTwLiA8sdTabvQ2dwGA24cQE
    OujsBwudKSdVYwTE7kMeuBjkStAa3DjjqSf3ixbKewOhA45ztMxQR4lV80Li8Hxm
    CW6zge3DSl/yhz6WGGcqtSDirL/uiThaeIDxrXwb8LFtqPs75kZGPS70wxh5rWH7
    a+QyUyw/x8ZEcrwUNPCkWPUu7j+8uEAbA9Xdf/vbxE8ftrYOWWUehPXz4+e1RQoH
    2aNrKsKezwHKXtsUj1WzL/YaMAWBOFjsn0p/MKsnFB+3lgA8hqw+Ml1Vi9jAWoxl
    bvPOSry2L8c2f9LpZl3jKCh5LSUDlB81ouWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526302687; bh=1PJBPuxDxmJu5uaMqM4Sr1r0smNOGQ
    i0FyNCt6eEJYI=; b=ckWB7ES1+uw5xl7NgwhAEC/TIxafkfb9evnRB5gJVPhRXl
    7PB/Z49hmDfEIk8yHxdzVbgQ197tgPFkoSn8KWa8w9Escq3uOsv+nc2gYQRKX5Zz
    C/bryGihzQevZ85YelRdJcZF/nMqI8pIf3tS2WZeXpn+76XbxyfhDik9CmNiBxhB
    kIErxH5yNoi0SiZCo53jvHUV/QMQwBBvRsDqKqIDkif1pJQZjr4ivjTwUaGMeIKJ
    7KDhwSmbMDav9ywwVCsTm1TSccwj5LMdTp3J4SEttLn2RRwLQTUjEMCBXzIplZaX
    zfPaDTwulgqFf3hQllVilDoBmj6R+mwSIKpVFnFA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=MoARRepg x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=Z3StzXNF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=MoARRepg x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=Z3StzXNF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDtNIdxrTqwSxgOPQ+PI5PjLkDEn6QZ4ddy+Mz0AeFHDmnNSVxRa6YZlIDKiENAsXD10MAO2tMq13zrIvstZESGV8o9VsJql8UIKiXsKGub8G2OJbnxi
    dURDXFyFK8gWbbfbvdWkOX1BA+bzbxgNsw8Eqnjn2wx5uXno9BHHlHXtytawAurF2vyn3dA6ALIdMKilI20wUAcZNXUqL0sQk7T62C13x6B2InvbiuTUByDt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=i6uMeK6BI1QA:10 a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=lmt78iNSK0mcLvgekYAA:9
    a=1n7B4UDXgpEVxvhv:21 a=mA6fID9ln-Mbu-i2:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeENM6E (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 08:58:04 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:41062 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753275AbeENM6C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 May 2018 08:58:02 -0400
X-Google-Smtp-Source: AB8JxZrOHV+KcQ1BHDZdvus2ZnkEabZBpv+TRZX/UQ4hnVNgckD+/84IHDL2jYsJeLtUmAFbsJvrKw==
Date: Mon, 14 May 2018 08:57:54 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] Introduce the for_each_set_port_word macro
Message-ID: <20180514125743.GA20325@sophia>
References: <cover.1525785532.git.vilhelm.gray@gmail.com>
 <CAHp75Vf8TLhj07VKeDdvzqHvViHqgRkd6=n2hZR_yY7in52SHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vf8TLhj07VKeDdvzqHvViHqgRkd6=n2hZR_yY7in52SHA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 13, 2018 at 06:11:45PM +0300, Andy Shevchenko wrote:
>On Tue, May 8, 2018 at 4:26 PM, William Breathitt Gray
><vilhelm.gray@gmail.com> wrote:
>
>> While adding GPIO get_multiple/set_multiple callback support for various
>> drivers, I noticed a pattern of looping manifesting that would be useful
>> standardized as a macro.
>>
>> This patchset introduces the for_each_set_port_word macro and utilizes
>> it in several GPIO drivers. The for_each_set_port_word macro facilitates
>> a for-loop syntax that iterates over entire groups of set bits at a
>> time.
>>
>> For example, suppose you would like to iterate over a 16-bit integer 4
>> bits at a time, skipping over 4-bit groups with no set bit, where XXXX
>> represents the current 4-bit group:
>>
>>     Example:        1011 1110 0000 1111
>>     First loop:     1011 1110 0000 XXXX
>
>>     Second loop:    1011 XXXX 0000 1111
>
>8-bit itteration. Is it correct?

This case is 4-bit iteration for the sake of example, but the idea is
to have the for_each_set_port_word macro to be capable of 8-bit
iteration, as well as any other number of bits, as specified by the
port_size parameter.

>
>>     Third loop:     XXXX 1110 0000 1111
>
>Looking at the example above I highly recommend to introduce some test
>cases for your helper function.
>
>Consider extending lib/test_bitmap.c for this purpose.

That's a good idea. I'll add in some test cases to lib/test_bitmap.c to
help check the implementation of these functions and macro.

William Breathitt Gray

>
>>
>> Each iteration of the loop returns the next 4-bit group that has at
>> least one set bit.
>>
>> The for_each_set_port_word macro has six parameters:
>>
>>     * port_word: set to current port word index for the iteration
>>     * word_index: set to current bitmap word index for the iteration
>>     * word_offset: bits offset of the found port word in the bitmap word
>>     * bits: bitmap to search within
>>     * size: bitmap size in number of port words
>>     * port_size: port word size in number of bits
>>
>> The port_size argument can be an arbitrary number of bits and is not
>> required to be a multiple of 2.
>>
>> I've called the group of bits a "port word" which may be a confusing
>> naming convention; I was afraid calling that them a "group" may be too
>> vague. Should a different name be chosen; what would you suggest?
>>
>> This patchset was rebased on top of the following three commits:
>>
>>     * commit aaf96e51de11 ("gpio: pci-idio-16: Fix port memory offset for get_multiple callback")
>>     * commit 304440aa96c6 ("gpio: pcie-idio-24: Fix port memory offset for get_multiple/set_multiple callbacks")
>>     * commit e026646c178d ("gpio: pcie-idio-24: Fix off-by-one error in get_multiple loop")
>>
>> William Breathitt Gray
>>
>> William Breathitt Gray (7):
>>   bitops: Introduce the for_each_set_port_word macro
>>   gpio: 104-dio-48e: Utilize for_each_set_port_word macro
>>   gpio: 104-idi-48: Utilize for_each_set_port_word macro
>>   gpio: gpio-mm: Utilize for_each_set_port_word macro
>>   gpio: ws16c48: Utilize for_each_set_port_word macro
>>   gpio: pci-idio-16: Utilize for_each_set_port_word macro
>>   gpio: pcie-idio-24: Utilize for_each_set_port_word macro
>>
>>  drivers/gpio/gpio-104-dio-48e.c   |  67 +++++---------------
>>  drivers/gpio/gpio-104-idi-48.c    |  32 ++--------
>>  drivers/gpio/gpio-gpio-mm.c       |  67 +++++---------------
>>  drivers/gpio/gpio-pci-idio-16.c   |  67 ++++++--------------
>>  drivers/gpio/gpio-pcie-idio-24.c  | 102 +++++++++++-------------------
>>  drivers/gpio/gpio-ws16c48.c       |  66 +++++--------------
>>  include/asm-generic/bitops/find.h |  26 ++++++++
>>  include/linux/bitops.h            |   9 +++
>>  lib/find_bit.c                    |  28 ++++++++
>>  9 files changed, 172 insertions(+), 292 deletions(-)
>>
>> --
>> 2.17.0
>>
>
>
>
>-- 
>With Best Regards,
>Andy Shevchenko
