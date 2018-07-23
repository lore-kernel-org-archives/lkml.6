Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C03ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A4420779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKBt+W3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A4420779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbeGWRGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:06:47 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38062 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388133AbeGWRGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:06:47 -0400
Received: by mail-qt0-f194.google.com with SMTP id y19-v6so1144040qto.5;
        Mon, 23 Jul 2018 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=yQRZJ4OBVgQq+hf6hP6FMUfSehq+AIGvqcUQyGz6SRg=;
        b=eKBt+W3yzBrhktlWt7YH32KomyKxu5Ct8BAM+RI8V28aakTb2EbGQt6PahZN+Kk0xu
         0mwDEJOc50pfKOqQHUXfDAIXdxJbgVodKbAfvDoO3P6lB1hNS1tYl/7aMUlx9PnnFpLO
         hkqXcxtOBtTAPhL3w+XZXPqX6Ojx8KiHv1ogRvnGBXsxFxKicDYf6e7eJEQV7SPt98gv
         4WVmZaXUhmvC85H4CZFP3GdD4xXtURDbUtAPEjUPGDz/vbw7WetjpSyJyxJSJFi0DBcI
         a8cCqa5q+ot0q/cQSOR9DOmE/4p92EMXxfMHVXLfC6foEXEkY+FEYX7j/8IBKc2DVzxD
         1aZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=yQRZJ4OBVgQq+hf6hP6FMUfSehq+AIGvqcUQyGz6SRg=;
        b=XMvtfWsCN5d0jMs4L4e+1/VuU+t0ckqnp18PRkpL3zXNAIrsytGv8zi5xxfISxTwBq
         aJBQh2TQjhOVKV27aVg7TOmLqA0J91ADXDTvDzoGBuPVVQoFJL5zO57cgsi/7rM+jSIK
         pKxGlQk66LHAgmHudVX5muFhSqOGTWYu6VKs9T45o2WGqeg9qJPxIKQtUD4g2stlh1F7
         NP+flGakH4UMSEhMNQNzggh2qWX+R4L24AETbyh31fmqpFwnrvAS7jf1N2vhCdilQnPB
         X1nsGuSnh7/W4vvHB/9kFZFkmoqE58hrE3VbgXFiuS88dZMNwXHmKhq3bz8Fmq1ZVXg8
         oA7g==
X-Gm-Message-State: AOUpUlHO/QnXwT0eN4tB3FK7PsRUKGTO5fTCvIvPlRkCSn56IPGpvpJG
        7NuAfJWwnrWEjSxRUezZM0GUSSeQabZr6apILBuNoO5T
X-Google-Smtp-Source: AAOMgpdpCVZDfqR6nEbnRLAUNjXBH7XOCiq7MBGyB+1MbcIVcUXwviEOaZwaNwcCmcwcRYu15mNpu3eOlvodkF7CRws=
X-Received: by 2002:ac8:30e3:: with SMTP id w32-v6mr12947093qta.280.1532361892699;
 Mon, 23 Jul 2018 09:04:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 09:04:52
 -0700 (PDT)
In-Reply-To: <CAK8P3a10SsWuPXzOyRcNKa+ukvj_Gq13JyDTngoU8DJu6_MR0Q@mail.gmail.com>
References: <20180721200049.7553-1-anders.roxell@linaro.org>
 <a83ff193-be57-f566-cafb-132075025b56@infradead.org> <20180722082939.2de739f1@bbrezillon>
 <CAK8P3a1_8OSqyKsbw+m3ZzLWfPqDK4ynG3WoPTk+K2uJJsiq5A@mail.gmail.com>
 <20180723114107.664164d2@bbrezillon> <CAK8P3a10SsWuPXzOyRcNKa+ukvj_Gq13JyDTngoU8DJu6_MR0Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 Jul 2018 18:04:52 +0200
X-Google-Sender-Auth: goG9nvJrcURZaG8oazWmH328Yh4
Message-ID: <CAK8P3a0p_8HWz0kLLrkwmpcbt4BsMiDG=hFK4SxeJygucZ1yMg@mail.gmail.com>
Subject: Re: [PATCH] drivers/memory/Kconfig: Add CONFIG_OF dependency
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 5:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jul 23, 2018 at 11:41 AM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
>> On Mon, 23 Jul 2018 11:34:43 +0200
>> Arnd Bergmann <arnd@arndb.de> wrote:
>>
>>> On Sun, Jul 22, 2018 at 8:29 AM, Boris Brezillon
>>> <boris.brezillon@bootlin.com> wrote:
>>> > +Arnd, Rob and the DT ML.
>>> >
>>> > On Sat, 21 Jul 2018 14:53:47 -0700
>>> > Randy Dunlap <rdunlap@infradead.org> wrote:
>>> >
>>> >> On 07/21/2018 01:00 PM, Anders Roxell wrote:
>>> >> > JZ4780_NEMC doesn't depend on OF, and if OF isn't enabled we get t=
his
>>> >> > error:
>>> >> > drivers/memory/jz4780-nemc.c: In function =E2=80=98jz4780_nemc_num=
_banks=E2=80=99:
>>> >> > drivers/memory/jz4780-nemc.c:72:10: error: implicit declaration of
>>> >> >  function =E2=80=98of_read_number=E2=80=99; did you mean =E2=80=98=
down_read_nested=E2=80=99?
>>> >> >  [-Werror=3Dimplicit-function-declaration]
>>> >> >    bank =3D of_read_number(prop, 1);
>>> >> >           ^~~~~~~~~~~~~~
>>> >> >           down_read_nested
>>> >
>>> > Looks like of.h defines stubs so that people can compile-test without
>>> > CONFIG_OF selected. Maybe we should move of_read_number() and
>>> > of_read_ulong() out of the #ifdef CONFIG_OF section.
>>>
>>> That seems fine, though the added dependency seems appropriate
>>> here as well. of_read_number() is rarely used, and for the most part in
>>> powerpc specific code that is guaranteed to have CONFIG_OF enabled,
>>> so it's not that likely to cause many more problems.
>>
>> Ok, then I'll let Miquel apply Anders' patch to the NAND tree.
>>
>> Thanks for your feedback.
>
> My randconfig build bot just ran into a second problem with this driver
> with CONFIG_GPIOLIB disabled:
>
> drivers/mtd/nand/raw/jz4740_nand.c: In function 'jz_nand_dev_ready':
> drivers/mtd/nand/raw/jz4740_nand.c:133:9: error: implicit declaration
> of function 'gpiod_get_value_cansleep'; did you mean
> 'gpio_get_value_cansleep'? [-Werror=3Dimplicit-function-declaration]
>   return gpiod_get_value_cansleep(nand->busy_gpio);
>          ^~~~~~~~~~~~~~~~~~~~~~~~
>          gpio_get_value_cansleep
> drivers/mtd/nand/raw/jz4740_nand.c: In function 'jz_nand_probe':
> drivers/mtd/nand/raw/jz4740_nand.c:388:20: error: implicit declaration
> of function 'devm_gpiod_get_optional'; did you mean
> 'devm_gpio_request_one'? [-Werror=3Dimplicit-function-declaration]
>   nand->busy_gpio =3D devm_gpiod_get_optional(&pdev->dev, "busy", GPIOD_I=
N);
>                     ^~~~~~~~~~~~~~~~~~~~~~~
>                     devm_gpio_request_one
> drivers/mtd/nand/raw/jz4740_nand.c:388:64: error: 'GPIOD_IN'
> undeclared (first use in this function); did you mean 'GPIOF_IN'?
>   nand->busy_gpio =3D devm_gpiod_get_optional(&pdev->dev, "busy", GPIOD_I=
N);
>                                                                 ^~~~~~~~
>                                                                 GPIOF_IN
>
>
> We could add another dependency here or (my preference) include
> linux/gpio/consumer.h to fix that. Do you want a separate patch for
> it, or should Anders send a combined patch?

One more failure, not analyzed yet:

/git/arm-soc/drivers/mtd/nand/raw/jz4740_nand.c: In function
'jz_nand_select_chip':
/git/arm-soc/drivers/mtd/nand/raw/jz4740_nand.c:87:9: error: implicit
declaration of function 'readl'; did you mean 'krealloc'?
[-Werror=3Dimplicit-function-declaration]
  ctrl =3D readl(nand->base + JZ_REG_NAND_CTRL);
         ^~~~~

        Arnd
