Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47695C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB722089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="SVn1I+vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB722089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJBQZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:25:57 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54880 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJBQZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:25:57 -0400
Received: by mail-it1-f195.google.com with SMTP id l191-v6so2570083ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VL33L2BXfLh1jyQS7r/gH4FO1nrLNgAqNmliOTRuAfE=;
        b=SVn1I+vz52XANu1ubyj/ZEQ5Nh2o158ywl1XkCT6oU0DOR+/ov1V5nx/3AdBWhQmYf
         I/Roi6Gznhl8xuXI97+KhAAYvRNt5RFTK9fHSalxLQWqpvpq2K1vCPmS4LwNaee56OjG
         pojDY1TGflAi4UQqpVmju/oh35mslbBDh5tCwvotpZRr9UCEqjjTDRx0h06Kgxb19WiE
         ij+MoM4H5Th10s/QZYx90nYQ3tD6znjASl5kNmVjH7VjPSXvw8XdxT4t59Jk0ayLNMPZ
         g+UIJyRxuAzlC2yXTUJeUM/RdRGXqBVSxGiL4IMbHMzfMkFC1Llag1uBhHPzEBWTH2kq
         V5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VL33L2BXfLh1jyQS7r/gH4FO1nrLNgAqNmliOTRuAfE=;
        b=LlAXonQseuqvQ0R8CPbAfdO26oQRL10zGmX+6PP6a7yV4gol5p2nLS1sGBLtUESY1F
         mhDJlyeRTBms1OXp9e2332iiU2NsvWV3gPsUwYhTUZb/5rmiprnsv6ku6oELD7awOpwO
         MwmN1XJ/0vB5RzdTZbhyv5kQkTFMS4Xlu0+A6EeAwtPVI1JNpA07vl2BqH6uffGnHKTR
         OE10PK0XnwnFYGL3JWiM5gMjfE48SZ00Yf2Px6Sx3RZUdNb1DCUT9clhGV8MwbXvCOsK
         zV9Mk6Ma3UEaJbAXQv3EuBdYddtK41fZbpSnmQo+BOk4kTBnLCu9ZRMoKjOdvCJUEed1
         pubg==
X-Gm-Message-State: ABuFfohie0O00bysrhQsXypX3Kb/g3eca5GQFMxrJzsaItMh4zU60NYa
        0w5CRPnxiZh2e80XRvRqBEq5MdUHF+4loQaXxhQ6Cg==
X-Google-Smtp-Source: ACcGV60l1mMiLAFtyJwA9hdphUfg7WDQgNIGFQ4QRaOg5WEPEgdCj5hT80z/kEUqyaZ7z+vGCR/fw5G9rzILntmuFcM=
X-Received: by 2002:a24:f047:: with SMTP id p7-v6mr1284075iti.125.1538473414050;
 Tue, 02 Oct 2018 02:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181002094238.17571-1-brgl@bgdev.pl>
In-Reply-To: <20181002094238.17571-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 2 Oct 2018 11:43:22 +0200
Message-ID: <CAMRc=Mdu1BZKA89OEjrB7Ti5nZujpO=_jk4EBaxjpESnFgZm1w@mail.gmail.com>
Subject: Re: [PATCH] nvmem: fix nvmem_cell_get_from_lookup()
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Alban Bedel <albeu@free.fr>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 2 pa=C5=BA 2018 o 11:42 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=
=82(a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We check if the pointer returned by __nvmem_device_get() is not NULL
> while we should actually check if it is not IS_ERR(nvmem). Fix it.
>
> While we're at it: fix the next error path where we should assign an
> error value to cell before returning.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/nvmem/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index ad1227df1984..f49474e1ad49 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -952,9 +952,9 @@ nvmem_cell_get_from_lookup(struct device *dev, const =
char *con_id)
>                     (strcmp(lookup->con_id, con_id) =3D=3D 0)) {
>                         /* This is the right entry. */
>                         nvmem =3D __nvmem_device_get(NULL, lookup->nvmem_=
name);
> -                       if (!nvmem) {
> +                       if (IS_ERR(nvmem)) {
>                                 /* Provider may not be registered yet. */
> -                               cell =3D ERR_PTR(-EPROBE_DEFER);
> +                               cell =3D ERR_CAST(nvmem);
>                                 goto out;
>                         }
>
> @@ -962,6 +962,7 @@ nvmem_cell_get_from_lookup(struct device *dev, const =
char *con_id)
>                                                        lookup->cell_name)=
;
>                         if (!cell) {
>                                 __nvmem_device_put(nvmem);
> +                               cell =3D ERR_PTR(-ENOENT);
>                                 goto out;
>                         }
>                 }
> --
> 2.19.0
>

Ugh this was supposed to be v2. Sorry for spamming.

Bart
