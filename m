Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0942C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A26C219E7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql4EATbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A26C219E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeGDQPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:15:11 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:41242 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeGDQPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:15:09 -0400
Received: by mail-ua0-f195.google.com with SMTP id t14-v6so3744430uao.8;
        Wed, 04 Jul 2018 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wMrl5oeRM9Cu9TmphJa670i3Tirp6R6K6QCbo3AK5zA=;
        b=Ql4EATbvvmz+e4sQanzDuAI/0a0xfyeN3pQAqNrJ7Fz5peDo2Tr70EyYq4tLEpcgPo
         tynG6OURgTYXvEp7dLN3OQtjvp1fsiNwYkOyfmO8wRwpaPnpTjYvb5RL4XquIpT5o7J4
         IXH5mWb9SYvmHw6aKYP9kF4lUl7EqXC2IWkSIPMkTrYLiI1VhA2T4vEHOEXPAs2Fjp4C
         wf3nPyCdfQa9lx0JtS+HYB67hWG0OvaiLkBtx4GjtARKFHRO9frTNIzfAbM1YpaMMDtd
         lTXKlRilXY2TMaw6+B9lQNnmyb3F0RzClTicr06pAIM5REepy9XTRV71uZLwe0gruJdY
         MbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wMrl5oeRM9Cu9TmphJa670i3Tirp6R6K6QCbo3AK5zA=;
        b=clrmM44vMEJsPpaW3NI1naYViTwvqZj8r62x+lVZLSyJuhmDelVF/5vJ5q5yyXtHuH
         0FN9CtjkuI6X92IBSAvd58JY+P8+pKfv1ADr8QgQ5R2QmAOzEzOdPiqvHl9Oq5MKmVsD
         cdUkUUto+ZRlABnqMp6vfoF452ak0aDG2zbls/oTzr0/tceEv/nQiS0BU7onHY/LiQwI
         Rny0kSEURd/+ttrsGnjAUiPB036JltkkqtkfHnoKmZAq9nilspW9/IG9LUjQm/iN7HKA
         DK3PobbCnM4MI4Pw7WRmoiWQyujhdbwE0QoX0ZiRbJnNvcbyHo1gZem87GZuQn3kAABJ
         663g==
X-Gm-Message-State: APt69E0Hq0XiRrHXw+57onGiE/dcMtpOPd73ZAFEOAht+egFXtJRW49q
        OP5pzikoXsa8eIwiskKoLVd+e2wWNMCsmuNAPw0=
X-Google-Smtp-Source: AAOMgpcbIxaY6nBfKuJ0exNYIaU/e+6XCdtsl/Re+8m+f9Mry0jkT3m5OoQpIBWwNvQiLLIHE/nQ0IwLLoqFSK7H2u4=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr1576116uae.12.1530720908489;
 Wed, 04 Jul 2018 09:15:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:15:07 -0700 (PDT)
In-Reply-To: <d6f374da848179583f86bfc965125ebf2e4d8317.1530710826.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530710826.git.nikolaus.voss@loewensteinmedical.de> <d6f374da848179583f86bfc965125ebf2e4d8317.1530710826.git.nikolaus.voss@loewensteinmedical.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 19:15:07 +0300
Message-ID: <CAHp75Vd-cak8m_uqJs=L1eX2z_TFbCUHcbLKrRJ20C3GP--uUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 9:06 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> struct i2c_device_id argument of probe() is not used, so use probe_new()
> instead.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

After Javier's explanations it's more clear now why we leave i2c ID table.

> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>  drivers/iio/accel/st_accel_i2c.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index c6e08c834f11..0659e9a67f85 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -138,8 +138,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>
> -static int st_accel_i2c_probe(struct i2c_client *client,
> -                                               const struct i2c_device_id *id)
> +static int st_accel_i2c_probe(struct i2c_client *client)
>  {
>         struct iio_dev *indio_dev;
>         struct st_sensor_data *adata;
> @@ -179,7 +178,7 @@ static struct i2c_driver st_accel_driver = {
>                 .of_match_table = of_match_ptr(st_accel_of_match),
>                 .acpi_match_table = ACPI_PTR(st_accel_acpi_match),
>         },
> -       .probe = st_accel_i2c_probe,
> +       .probe_new = st_accel_i2c_probe,
>         .remove = st_accel_i2c_remove,
>         .id_table = st_accel_id_table,
>  };
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
