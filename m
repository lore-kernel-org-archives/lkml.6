Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CB3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF46E20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYTmOZn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF46E20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388720AbeGWQmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:42:19 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34026 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387831AbeGWQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:42:18 -0400
Received: by mail-qt0-f195.google.com with SMTP id m13-v6so1063323qth.1;
        Mon, 23 Jul 2018 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Y3ROiEKf1jGLoB6Yk9HRSDvRLfvA2IMy8StZB/Zmq1E=;
        b=XYTmOZn9tOeAKn8DUeasJefje4X2g8ffkRfkpFDXthvQPWkkzWOJD2xjP9QYeWHjh6
         A4Ijz8gJEdJWzyy8KqF0lV3ZQok7edxLzTDtrK3cAbCW9aTsJQUL2dWRYhsO6zyJ6P5W
         ZHYEWVn3A45CYJiSSg28yXuRyApQuTc1pVp2Tp/20ocW3mE0CBuc3Ygxm4Xl6xJ/e+Rr
         N1K/BiXHavdIMHcjmpEwuWkK/2hIMY25NXJav/4jVj7jTZGD3ghZmjEtE9Lc1tGLWwL9
         nGBVn1cLAkmBco1wwrtotnAKHpw6pqkxokOSSJZFc0vDIt03d4a1CPP5igluH7cQwKqo
         Mlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Y3ROiEKf1jGLoB6Yk9HRSDvRLfvA2IMy8StZB/Zmq1E=;
        b=YYkj+XAHH0onapHzT3Ekr9x5z38mEGRdNBV6B1qI7DAwHV8FNekIRye7RCjDXkAT8V
         67M/H5XC9Bmo3iNlWq7C8bigUAFHEttVopGpbx7jflfcPNvBEBrT9LEf2HqhfcNICwsN
         QsjgSP3wyyANXWgoLVRBQ4jUqLTeNJ70ZBH0JR5o3Mx/UVeuHAn6s/S8KV5P1L9BKTzP
         MwLlUMAjqtgGW34Xc1mnnrOrVcRXCLpbc0ivT5caPyBfCA4ayF6n5QXN7lsLpVxYwlA/
         7AdibzZT/r1XHZ/SkndPBRh/5IouwWMZUMENFRB+Xm9GVwhCLR4u/puQc1ZZ8X8pelyL
         lkUw==
X-Gm-Message-State: AOUpUlFfervTVgl69zrR+UMJ5zSJq12LRT3im9z+2UKB1JdkqMg1RX4n
        0NbuxBWpKxpBFK0oA8F7Y3AGtyo0heIsufm2F2lZXrLv
X-Google-Smtp-Source: AAOMgpcm0Ae/rc582zfsccdh7fCArW37o+NT1zW/Ob9O/Hv3GiH1VIN8ANG3TAFaT9sNyYTjlXVmKRWv9r3WgFR8Kus=
X-Received: by 2002:a0c:afb8:: with SMTP id s53-v6mr11647100qvc.164.1532360429934;
 Mon, 23 Jul 2018 08:40:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 08:40:29
 -0700 (PDT)
In-Reply-To: <20180723114107.664164d2@bbrezillon>
References: <20180721200049.7553-1-anders.roxell@linaro.org>
 <a83ff193-be57-f566-cafb-132075025b56@infradead.org> <20180722082939.2de739f1@bbrezillon>
 <CAK8P3a1_8OSqyKsbw+m3ZzLWfPqDK4ynG3WoPTk+K2uJJsiq5A@mail.gmail.com> <20180723114107.664164d2@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 Jul 2018 17:40:29 +0200
X-Google-Sender-Auth: rU6qj8z_Kexr8FNm9nkkBcOmRFw
Message-ID: <CAK8P3a10SsWuPXzOyRcNKa+ukvj_Gq13JyDTngoU8DJu6_MR0Q@mail.gmail.com>
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

On Mon, Jul 23, 2018 at 11:41 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Mon, 23 Jul 2018 11:34:43 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Sun, Jul 22, 2018 at 8:29 AM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > +Arnd, Rob and the DT ML.
>> >
>> > On Sat, 21 Jul 2018 14:53:47 -0700
>> > Randy Dunlap <rdunlap@infradead.org> wrote:
>> >
>> >> On 07/21/2018 01:00 PM, Anders Roxell wrote:
>> >> > JZ4780_NEMC doesn't depend on OF, and if OF isn't enabled we get th=
is
>> >> > error:
>> >> > drivers/memory/jz4780-nemc.c: In function =E2=80=98jz4780_nemc_num_=
banks=E2=80=99:
>> >> > drivers/memory/jz4780-nemc.c:72:10: error: implicit declaration of
>> >> >  function =E2=80=98of_read_number=E2=80=99; did you mean =E2=80=98d=
own_read_nested=E2=80=99?
>> >> >  [-Werror=3Dimplicit-function-declaration]
>> >> >    bank =3D of_read_number(prop, 1);
>> >> >           ^~~~~~~~~~~~~~
>> >> >           down_read_nested
>> >
>> > Looks like of.h defines stubs so that people can compile-test without
>> > CONFIG_OF selected. Maybe we should move of_read_number() and
>> > of_read_ulong() out of the #ifdef CONFIG_OF section.
>>
>> That seems fine, though the added dependency seems appropriate
>> here as well. of_read_number() is rarely used, and for the most part in
>> powerpc specific code that is guaranteed to have CONFIG_OF enabled,
>> so it's not that likely to cause many more problems.
>
> Ok, then I'll let Miquel apply Anders' patch to the NAND tree.
>
> Thanks for your feedback.

My randconfig build bot just ran into a second problem with this driver
with CONFIG_GPIOLIB disabled:

drivers/mtd/nand/raw/jz4740_nand.c: In function 'jz_nand_dev_ready':
drivers/mtd/nand/raw/jz4740_nand.c:133:9: error: implicit declaration
of function 'gpiod_get_value_cansleep'; did you mean
'gpio_get_value_cansleep'? [-Werror=3Dimplicit-function-declaration]
  return gpiod_get_value_cansleep(nand->busy_gpio);
         ^~~~~~~~~~~~~~~~~~~~~~~~
         gpio_get_value_cansleep
drivers/mtd/nand/raw/jz4740_nand.c: In function 'jz_nand_probe':
drivers/mtd/nand/raw/jz4740_nand.c:388:20: error: implicit declaration
of function 'devm_gpiod_get_optional'; did you mean
'devm_gpio_request_one'? [-Werror=3Dimplicit-function-declaration]
  nand->busy_gpio =3D devm_gpiod_get_optional(&pdev->dev, "busy", GPIOD_IN)=
;
                    ^~~~~~~~~~~~~~~~~~~~~~~
                    devm_gpio_request_one
drivers/mtd/nand/raw/jz4740_nand.c:388:64: error: 'GPIOD_IN'
undeclared (first use in this function); did you mean 'GPIOF_IN'?
  nand->busy_gpio =3D devm_gpiod_get_optional(&pdev->dev, "busy", GPIOD_IN)=
;
                                                                ^~~~~~~~
                                                                GPIOF_IN


We could add another dependency here or (my preference) include
linux/gpio/consumer.h to fix that. Do you want a separate patch for
it, or should Anders send a combined patch?

      Arnd
