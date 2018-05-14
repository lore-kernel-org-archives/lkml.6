Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeENRyi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:54:38 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34332 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeENRyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:54:37 -0400
X-Google-Smtp-Source: AB8JxZpY8IrL875ioX8AQFO2OU0+WP2rGd9ZvavBbd4DVrmzukDq3uxwNrW3rL5tXmV2jHFMPs0OymIVt0ZZU3DJTMA=
MIME-Version: 1.0
In-Reply-To: <20180510140311.02805561@bbrezillon>
References: <1525920400-11392-1-git-send-email-Jane.Wan@nokia.com> <20180510140311.02805561@bbrezillon>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 20:54:36 +0300
Message-ID: <CAHp75VcET7PZYfeRkmiP=n_xCnDzEFYS98ZLjszc1fHjdfDF2A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mtd: rawnand: use bit-wise majority to recover the
 contents of ONFI parameter
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Jane Wan <Jane.Wan@nokia.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        prabhakar.kushwaha@nxp.com, Shawn Guo <shawnguo@kernel.org>,
        jagdish.gediya@nxp.com, Shreeya Patel <shreeya.patel23498@gmail.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ties.bos@nokia.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 3:03 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

>> +#define GET_BIT(bit, val)   (((val) >> (bit)) & 0x01)
>
> Not sure we need that macro, see below.

+1. We have too many nice helpers for bit manipulations
(for_each_set_bit() as an example).


>                         for (k = 0; k < nbufs; k++) {
>                                 const u8 *srcbuf = srcbufs[j];
>
>                                 if (srcbuf[i] & BIT(k))
>                                         m++;
>                         }

...which is effectively hweightXX().

>> -     p = kzalloc(sizeof(*p), GFP_KERNEL);
>> +     p = kzalloc((sizeof(*p) * 3), GFP_KERNEL);
>>       if (!p)
>>               return -ENOMEM;

...which is kcalloc().


-- 
With Best Regards,
Andy Shevchenko
