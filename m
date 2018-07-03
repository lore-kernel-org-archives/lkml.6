Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E1EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6BE2474C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGtU1fAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6BE2474C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbeGCWyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:54:52 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39788 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeGCWyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:54:50 -0400
Received: by mail-ua0-f193.google.com with SMTP id n4-v6so2275172uad.6;
        Tue, 03 Jul 2018 15:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vrrnt1jcIVq3iiJjGe1Z+mSWBFbaV9A8bD8ynsAz+4E=;
        b=gGtU1fADKtocn/qreZ4IethBt5cKQdxyYAnglBOyDO1cUnoJLZavIHY3KHwGiId+Jc
         +tcRaYP7C2Kfwe3mRAbxANAcweTFlCj/dgoRQei4VkWM4HsaCc8jRmo/Ryhg67NTPQh3
         ltDEQBjLqxuICMvCyYQZeFWwaqHGpJsmOxp0yxVrttui9Eb28jbWs/jK9GGRdf1qBZJl
         e7SR7rgVzzSAmczIjBmytKQYZwblmkyAD9YUGt00fcmSP2a8HR8L+/Lr5EfrcUW26x0e
         amuX7CWVcjwU5FfsuWHzhzxo/CNR9vkdfhSKJ2s4rkzTxaFbVSyva7ZaVu2TFs9v20TG
         rA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vrrnt1jcIVq3iiJjGe1Z+mSWBFbaV9A8bD8ynsAz+4E=;
        b=kz+PsiuZmxJeMeOdYlSYa16CWcbDExb5rOaopskg1L2Mjd71Cs3BhFf7yWcpNzkWGO
         wOOR1VRTcoMfuaS8Egxx3yx/ir0Y9BnKkuXlbiCna3svGE0euUrz82Oxn+UcaDF1A2nr
         ksRfhawqPdraodWJtt1O+a7Xmuju1qwySLPi1TIte3MQuo6ml8IjPva4h9xj8nLkPpLN
         E3saSwwVAZkIqNzL/WgJfS6p8sUmFpQNzLZdrq42wrFy/hZV1dyC31f8S/ZJeD9y5403
         S/fXZKA8qPX+PkZ26XIcc5dJxk9a+VjNesMu68XBFT8R7BWebvr7YzooDihRasGq+WPl
         7ktQ==
X-Gm-Message-State: APt69E0P1jzRPkkXD/0ZTAYcOwBvNDtDB/YNrdgfVKEGi2LYLgJjMU3S
        6+BDaY5nbZkGZFTdQclMGZocF2l9AWhM9R+DrsQ=
X-Google-Smtp-Source: AAOMgpfQWypdGDjV3W7hv1zHQtA7pC+8XNnZqP0GuKBgdsWqXlx6D8yz2tDbNHvDTfXkDlQ2YrbkEeEKmCNUGZVsvs8=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr19601740uai.47.1530658489616;
 Tue, 03 Jul 2018 15:54:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 15:54:48 -0700 (PDT)
In-Reply-To: <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de> <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 01:54:48 +0300
Message-ID: <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de,
        linux-iio@vger.kernel.org,
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

This makes...

>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);

...this table obsolete IIUC. At least that's what I did when switched
to ->probe_new() in some drivers.

If I'm mistaken (again? :-) ) I would hear from someone to point me
how it can be used after a switch.

>
> -static int st_accel_i2c_probe(struct i2c_client *client,
> -                                               const struct i2c_device_id *id)
> +static int st_accel_i2c_probe(struct i2c_client *client)
>  {
>         struct iio_dev *indio_dev;
>         struct st_sensor_data *adata;
> @@ -182,7 +181,7 @@ static struct i2c_driver st_accel_driver = {
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
