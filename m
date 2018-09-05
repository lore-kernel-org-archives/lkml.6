Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD82C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405FF2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKUXgUXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 405FF2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeIEOhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:37:39 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51442 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbeIEOhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:37:39 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so9109363itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jsd4yBIRSWL0embmZfwlYTqguwQN1biomenzMOvMI8w=;
        b=cKUXgUXZcowNJ0/gTH8LoLxet20zhtq1ZcA2Uqlm2C9mfX0DCuuhmfMwKk5ZLiixQi
         oZgo005ebvVn5XCGq5ciLeHoT+lC4IoN7FOtNDUdStGa8rRCIcQ4v+XQBGMGTgsP/zkD
         d/4bXeF1/HJ+ZqHGepQUS8+0+E6zBDs83FOC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jsd4yBIRSWL0embmZfwlYTqguwQN1biomenzMOvMI8w=;
        b=SRoUA6EVqDI7TssPMDk2oDNeSSeFPDqBzGDVknSKO/hOkDWzokFKVR9+UVqkgG7Pza
         fD4yBMgGHyJvMK7TYsZINUyKIg4u/btys1LTeUSJ3d6nQQcGjnOVbmHvpjndUJeYM0MQ
         aD8HEJMx5SRCso39O5CmkyJjJowPmf8dRvGf3EHny1HWOHBLuyVze+l0AIVcacWu6xJB
         Yjwpd3W8noBk7PNtqk4updqDf0/SZyFkPqBKpxfkct+0Z//foOiPyOV2E97GAyXbTdy8
         IJASYjbbGdJRcgOqmY7BthL4H96aLJP/MWFxLF0/tOQQPlr4XLQd6ZjN/yYcmHzFfOsD
         mZvQ==
X-Gm-Message-State: APzg51DA8n3YsEXaxyf6yLuCmUUidyOdvRT9Kwtxr2U5jjWVqJheMCEi
        VpIeMVD5U0vayRN4Hdlk65f2vYfFSrFGTV/z1V7Q8Q==
X-Google-Smtp-Source: ANB0VdZhqgzTHUuxp+AjCZyUBIRA+paNgq0p/7B+e3ygX1t1ibsAx9q4km0ct4EhpDNuH+RtqlZm1m1pK9Sx00R4u50=
X-Received: by 2002:a24:1f06:: with SMTP id d6-v6mr3001802itd.54.1536142088368;
 Wed, 05 Sep 2018 03:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180830144151.13417-1-marek.behun@nic.cz> <20180830144151.13417-2-marek.behun@nic.cz>
In-Reply-To: <20180830144151.13417-2-marek.behun@nic.cz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Sep 2018 12:07:56 +0200
Message-ID: <CACRpkdYm-qkBT-T0Zx8+eN70XcMuUkxX3oM1bs3NicvHc=_ZmQ@mail.gmail.com>
Subject: Re: [PATCH mfd+gpio 2/2] drivers: gpio: Add support for GPIOs over
 Moxtet bus
To:     marek.behun@nic.cz,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek!

Your DT bindings patch should ideally be in a separate patch and
must be sent to devicetree@vger.kernel.org as well.

On Thu, Aug 30, 2018 at 4:44 PM Marek Beh=C3=BAn <marek.behun@nic.cz> wrote=
:

> + - moxtet,input-mask   : Bitmask. Those bits which correspond to input G=
PIOs
> +                         when read from Moxtet bus should be set here.
> +                         For example if bit 0 and bit 3 are input GPIO b=
its,
> +                         this should be set to 0x9.
> +                         Since there are only 4 input bits, 0xf is max v=
alue.
> + - moxtet,output-mask  : Bitmask. Those bits which correspond to output =
GPIOs
> +                         when written to Moxtet bus should be set here.
> +                         For example if bit 1 and bit 6 are output GPIO =
bits,
> +                         this should be set to 0x41.
> +                         Since there are at most 8 output bits, 0xff is =
max
> +                         value.

Please don't do it like this. Let the consumers decide if they want
to use a certain line as input or output.

Enumerate ALL GPIOs from 0 to N and let a consumer pick
GPIO x and then decide if it will be used as input or output.
Re-enumerating the GPIOs presented from the chip is complicating
things by shuffleing around the local offset (HW numbering)
space.

For GPIOs that are not usable at all, use the
gpio-reserved-ranges =3D <> property, see gpio.txt

If you want to indicate that some lines can just be used for
input and some can just be used for output and some cannot
be used at all, let the .set_direction_output() and
.set_direction_input() callbacks fail for these pins with
-EINVAL or so.

If these masks cannot be derived from the compatible
strings, then create generic bindings to mark lines
as input-only or output-only in gpio.txt and use the
same syntax as gpio-reserved-ranges, and handle it
in the gpiolib just as with gpio-reserved-ranges, not
in your local driver.

For example gpio-output-only-ranges and
gpio-input-only-ranges.

But first convince us that you really need that.

> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio.h>

This is a driver so only #include <linux/gpio/driver.h>
Skip the two above.

> +#include <linux/mfd/moxtet.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>

You don't need this either. Delete that include.

> +static int moxtet_gpio_dir_mask(struct gpio_chip *gc, unsigned int offse=
t,
> +                               int *dir, u8 *mask)
> +{
> +       struct moxtet_gpio_chip *chip =3D gpiochip_get_data(gc);
> +       int i;
> +
> +       *dir =3D 0;
> +       for (i =3D 0; i < 4; ++i) {
> +               *mask =3D 1 << i;

#include <linux/bitops.h>

*mask =3D BIT(i);

> +               if (*mask & chip->in_mask) {
> +                       if (offset =3D=3D 0)
> +                               return 0;
> +                       --offset;
> +               }
> +       }
> +
> +       *dir =3D 1;
> +       for (i =3D 0; i < 8; ++i) {
> +               *mask =3D 1 << i;
> +               if (*mask & chip->out_mask) {
> +                       if (offset =3D=3D 0)
> +                               return 0;
> +               }
> +       }
> +
> +       return -EINVAL;
> +}

This looks convoluted and I think will go away with my suggestion to
cut the masks.

Otherwise use primitives such as for_each_set_bit() etc.

> +static int moxtet_gpio_get_value(struct gpio_chip *gc, unsigned int offs=
et)
> +{
> +       struct moxtet_gpio_chip *chip =3D gpiochip_get_data(gc);
> +       int ret, dir;
> +       u8 mask;
> +
> +       if (moxtet_gpio_dir_mask(gc, offset, &dir, &mask) < 0)
> +               return -EINVAL;
> +
> +       if (dir)
> +               ret =3D moxtet_device_written(chip->dev);
> +       else
> +               ret =3D moxtet_device_read(chip->dev);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       return (ret & mask) ? 1 : 0;
> +}
> +
> +static void moxtet_gpio_set_value(struct gpio_chip *gc, unsigned int off=
set,
> +                                 int val)
> +{
> +       struct moxtet_gpio_chip *chip =3D gpiochip_get_data(gc);
> +       int state, dir;
> +       u8 mask;
> +
> +       if (moxtet_gpio_dir_mask(gc, offset, &dir, &mask) < 0)
> +               return;

So skip this and trust the consumers to ask for the right GPIO and set
it up.

Yours,
Linus Walleij
