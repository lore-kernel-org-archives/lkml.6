Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE74AC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 21:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694BD2461A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 21:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1kn5avy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694BD2461A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeF3V1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 17:27:02 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34070 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbeF3V06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 17:26:58 -0400
Received: by mail-vk0-f67.google.com with SMTP id l189-v6so2718303vke.1;
        Sat, 30 Jun 2018 14:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZPN3eL2LF4K9QOxpvn5hUAjAYcAZAKR3GwGc4mFNRPw=;
        b=b1kn5avyEd2QbjeoSM6bKtwh7CkQ5an34hsj+IiQBKaKGrDgHs9X5uiwg3OOp4jNmj
         EeLLPCy5v53FtzqKZlCRhB0zesp/550yw2cjirattFeOTS0BNFG1BliNynyMTWKpt4nF
         ehz0DbYlKi9xCjKRCh0Ijw6bSYAC0V2HJRx1jNtHwh2jjX6AYp3iCkwxwGkKx4dlNlzh
         VKvB2gPt6tDQWRTgqwnMxmUAGEcw3R2VbIs4mOutGkerquBieJUqWvTkDdy9tMG6Y7FL
         MaHCzqKC5g2Wgb+pcqTM2Q2u1XN7JvOJLW5BWdGxSMlPwhDS+SqHbLfjs2KiZ0J9h5xC
         Uopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZPN3eL2LF4K9QOxpvn5hUAjAYcAZAKR3GwGc4mFNRPw=;
        b=AlCDlXGElvRuub2bgffKrQIenF17C/nSCX8ApI53jxjoV/BIVcKLOTWsHvqfd3za4w
         rpwkjMD4PwrKW4KDndKsgeE2NiY4Zn7ui81nZyZNdnNj0mOSlzNq6HwIO6+X5QLf9Bnz
         Xw/kJ8w4UZlQqtBo0qfpiksWoTUeqCDt1JYh82gLLscK2EXG+4G3Q4sRXgRL25DAin7m
         RNHjWzuVk5zGglg1Im+Rw1SIOgOCIbHvibxC/INq0OwehdfH9JnD64bMa8VV7gOudrxm
         TJjkvHskDB6HUP0SeHDK+ph5Tlqv1FxeqjP/IJQZRRmehEgRhvsj056tSgUrX/qBHqvn
         88Bg==
X-Gm-Message-State: APt69E24w77pyd4KPy2Q/hGqTl6o8unWXcIB9Lq8fxsMdnxQyUGJ84B+
        K3Ve8Civ+a4bgPIEGjPw5S9XMB1or7yW4VGlvdo=
X-Google-Smtp-Source: AAOMgpf+6x4j4rC0lDn2qDb5DxEHyoIHKpH5j3R625PKUXQrCfcERvdD/5zEZ6sOE3wna2elHzdk6F1NdUEB7NHkB8I=
X-Received: by 2002:a1f:50c:: with SMTP id 12-v6mr11769350vkf.26.1530394017369;
 Sat, 30 Jun 2018 14:26:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 14:26:56
 -0700 (PDT)
In-Reply-To: <1530261516-21118-1-git-send-email-stefan.popa@analog.com>
References: <1530261516-21118-1-git-send-email-stefan.popa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 1 Jul 2018 00:26:56 +0300
Message-ID: <CAHp75Vfb_b6FPpnhu4Z_=iBNovNubneCD3cRG9SawRmMCNOVjw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: dac: Add AD5758 support
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Wunner <lukas@wunner.de>,
        Ismail.Kose@maximintegrated.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        sean.nyekjaer@prevas.dk,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:38 AM, Stefan Popa <stefan.popa@analog.com> wrote:
> The AD5758 is a single channel DAC with 16-bit precision which uses the
> SPI interface that operates at clock rates up to 50MHz.
>
> The output can be configured as voltage or current and is available on a
> single terminal.
>
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758.pdf

Thanks for an update.
Few comments below.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/property.h>
> +#include <linux/delay.h>
> +#include <linux/bsearch.h>

Perhaps keep them ordered?

> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +

> +#include <asm/div64.h>

ASM? Hmm...

> +static int cmpfunc(const void *a, const void *b)
> +{
> +       return (*(int *)a - *(int *)b);

Surrounding parens are not needed.

> +}
> +

> +static int ad5758_find_closest_match(const int *array,
> +                                    unsigned int size, int val)
> +{
> +       int i;
> +
> +       for (i = 0; i < size; i++) {
> +               if (val <= array[i])
> +                       return i;
> +       }
> +
> +       return size - 1;
> +}

Isn't it what bsearch() covers as well?

> +       do {
> +               ret = ad5758_spi_reg_read(st, reg);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (!(ret & mask))
> +                       return 0;
> +

> +               udelay(100);

If it's not called from atomic context, perhaps switch to usleep_range() ?

> +       } while (--timeout);


> +static int ad5758_soft_reset(struct ad5758_state *st)
> +{
> +       int ret;
> +
> +       ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_1);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_2);
> +

> +       /* Perform a software reset and wait 100us */
> +       udelay(100);

Ditto.

> +
> +       return ret;
> +}

> +static int ad5758_find_out_range(struct ad5758_state *st,
> +                                const struct ad5758_range *range,
> +                                unsigned int size,
> +                                int min, int max)
> +{
> +       int i;
> +
> +       for (i = 0; i < size; i++) {
> +               if ((min == range[i].min) && (max == range[i].max)) {
> +                       st->out_range.reg = range[i].reg;
> +                       st->out_range.min = range[i].min;
> +                       st->out_range.max = range[i].max;
> +
> +                       return 0;
> +               }
> +       }

One more candidate to use bsearch().

> +
> +       return -EINVAL;
> +}

> +               index = (int *) bsearch(&tmp, ad5758_dc_dc_ilim,
> +                                       ARRAY_SIZE(ad5758_dc_dc_ilim),
> +                                       sizeof(int), cmpfunc);

I'm not sure you need that casting.

-- 
With Best Regards,
Andy Shevchenko
