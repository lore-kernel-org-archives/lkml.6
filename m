Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3650C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 00:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CEA2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 00:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4gUlM54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbeLaAOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 19:14:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37899 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLaAOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 19:14:49 -0500
Received: by mail-lf1-f66.google.com with SMTP id p86so17586874lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 16:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y29z1ZNaa4ECcg4jJVMyvcCfDvJAd2VSxpC22CP3ibA=;
        b=N4gUlM542g4aQf7XkOD9UO+ueiF2s60lt5N2OEVYJOj/vVJIG9JlUgM64AOfmjIK8o
         coh9GviJAO6EtI739YTtGuryeyfw8cvm19j7lMjIvBx8zMFzcYi9XCxCK6i2RRe7oM86
         ++MqFikL1uH5uVyHeaHOqSCDEJoSkOqKd3f+2z3MQlIRIW7+JCOUVY58vKRyyF6ulRbK
         W6AduQ94fyI3IX6CeMP/JWzwUXWsYGFIKafcaJFiAaYAUXkgtrb73CDoryzuEE9OdPst
         UwZF2aHKlpBZlp8QRbOHAVzbYHP2bnZgTnBRyBTOempbOiBjvDpgPtEEYbCxPsqLBP47
         5M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y29z1ZNaa4ECcg4jJVMyvcCfDvJAd2VSxpC22CP3ibA=;
        b=pRKP7ZE41T6B3O9fy6Fki74SM9Yws07gc7cDY7Ggf8Vj7X3nS1Hdm1EDpy9qE2eRUT
         kB3ftS1sdiw2qKKHot+TtC9YTo16WXk3Vq3iKCaUYnMs4rPYkTzeX6NVIlY7G6S6umTL
         X6Iluhic2Zahutrs/T39M6M7mF/YdMziPn3xPqIrq2fqDta2FRTNyzOZkMPdtuCPSQvr
         xceWKyq8IhzzH4qmRSapjsIqLEMIePMs9qzDoyDPqlKhmGv/2843AYpgrCQ+YlipO516
         MT9JIMc71GuONYUuMvDo0EkbRN7hCo6Xi57iFkZrMVLPudpUeAD+tP/bQFp6aO06xFor
         EbZA==
X-Gm-Message-State: AA+aEWZ0rA4RK1U02wou0T9nlpKI9WVe0Acutdkd6tBnsSQvqfkcpkvo
        Ozf5CwAU6b2jeFAXkp+OA9e9tKouD/6Xc7L4r0M=
X-Google-Smtp-Source: AFSGD/WSbp6/D2cUW/CDECIXBNSQCR88b/0iHpunh8U/oSn2dRZLYNIyv/SkJFelEZGoeGjvEADvun9WXbC6hWjDeA8=
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr16917389lfa.106.1546215285898;
 Sun, 30 Dec 2018 16:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20181230084427.32623-1-afaerber@suse.de>
In-Reply-To: <20181230084427.32623-1-afaerber@suse.de>
From:   Ben Whitten <benwhitten@gmail.com>
Date:   Mon, 31 Dec 2018 00:14:34 +0000
Message-ID: <CAF3==iuRn2juDJHkqyawxTj7ko0kGMaLdi8QsRpWswKUCS3woA@mail.gmail.com>
Subject: Re: [PATCH lora-next] net: lora: sx1301: Fix radio SPI write
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-lpwan@lists.infradead.org,
        Ben Whitten <Ben.Whitten@lairdtech.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Mark +linux-kernel
On Sun, 30 Dec 2018 at 08:45, Andreas F=C3=A4rber <afaerber@suse.de> wrote:
>
> When converting to regmap_bus we omitted the write flag,
> rendering all sx125x register writes no-op.
>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---
>  drivers/net/lora/sx130x_radio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/lora/sx130x_radio.c b/drivers/net/lora/sx130x_ra=
dio.c
> index 6c94d13cd4db..e7b2df808c1a 100644
> --- a/drivers/net/lora/sx130x_radio.c
> +++ b/drivers/net/lora/sx130x_radio.c
> @@ -9,6 +9,7 @@
>   * Copyright (c) 2013 Semtech-Cycleo
>   */
>
> +#include <linux/bitops.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
> @@ -40,7 +41,7 @@ static int sx1301_regmap_bus_write(void *context, unsig=
ned int reg,
>         ret =3D regmap_write(priv->regmap, cs, 0);
>         if (ret)
>                 return ret;
> -       ret =3D regmap_write(priv->regmap, addr, reg);
> +       ret =3D regmap_write(priv->regmap, addr, BIT(7) | reg);

Curious.
Isn't the (read/write)_flag_mask, set in the regmap_config, a property of
the device connected to the regmap_bus?
I would have expected this to have been applied prior to passing to a
regmap_bus call, surely the bus should only be concerned with transport?

It will work in our case as our current hardware uses 1 in bit 7 but it
will not if we ever see other radios with different masks.

If the regmap_bus provider does need to apply the mask, can we get the
end device regmap_config and apply it from there?
Mark what are your thoughts on the route to take?

Regards,
Ben Whitten
