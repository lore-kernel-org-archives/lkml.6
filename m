Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0A2C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF58C20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FLWecVE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF58C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeJCEJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:09:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37288 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeJCEJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:09:29 -0400
Received: by mail-io1-f66.google.com with SMTP id v14-v6so3337579iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yj2AEP96bJAgg5hnsfIWn+8bIhWJPr6jFzD1cnqeWqA=;
        b=FLWecVE/o9K3xs2tkCGDJ5xL+zOJ83YXav0tpM6j5JrXCV0EMc4C4mQGV6wQdh/B4g
         R7nU1E4jtTgMn50QYdtGASJalYoM18eIQQR3YmDjjEEaI9izB2mhwxq/cMwr3jk+l9dj
         U70RGozoEs43JpDGhGxwqPx0WuCQlmlOD8MPH+J7rRkjX/ZdSvoJlKQuIrftKUsr1rkS
         cN+ok1FAa8/lHpPLuSKAby7hFBEFqoBXTy8WyC4JYnDor6A5VDKzZ7h6A6rDNNUCUTXj
         hluQuO0FUA5abP15wing7WhAv0uKY/FqEnxakwOlDzC+AH5XH0wia9NWJbsC+iYX17RP
         jMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yj2AEP96bJAgg5hnsfIWn+8bIhWJPr6jFzD1cnqeWqA=;
        b=E1KwcFwU3zusL+pIoJLeNIZSgrFcleXINNRhHnltydM+InMtcqpWzU8l2G/+U/HUY8
         3jg0fM0RCJCZPnqrMlMrwRdvDljnurxXTRXvU0UYf1i9GsOAf7Pqaqot5zWZatmD2jjn
         wRskLNj2lgtNcIeh4QOa3UHBUg66lfLOluNjlhMQ4HOzK81b234/bgRYcUYmERTZvdye
         5j+RHyf5cYadfe+KXvPWIzcC6x++PvTahqy+x12rk/suGh1McphQFBqu6LQCYANyrJaf
         iNjw92Gn+0195aACDOCumC6LyEeMLUjdMmXvXGyxLILDbCU7mT4GfxiXuuBiRjVITFCQ
         hmHA==
X-Gm-Message-State: ABuFfojSIc+uHVs1ZulmzACeejzlsqZWvQk2nbHSdgD2AipNARRyBN2o
        8s+9ptKjmQwBbxcj2eAa9dlMmCl4bAmlRCvN0yYF/Fvd
X-Google-Smtp-Source: ACcGV63y4iEt9ygpf/PUCrYgt8aopXFT25I+sEfaZg+I5zQU2jvy7mUUgqfwbqlhFOV/oV5gsIaMsKWKLKRSN1xiIFA=
X-Received: by 2002:a5e:aa02:: with SMTP id s2-v6mr11900506ioe.187.1538515448690;
 Tue, 02 Oct 2018 14:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181002211123.2662419-1-arnd@arndb.de>
In-Reply-To: <20181002211123.2662419-1-arnd@arndb.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 2 Oct 2018 23:23:57 +0200
Message-ID: <CAMRc=Mc4UF-Okbk2zqgnJ+1D-RZvavkSru3-fOGGbJB=ejXxSQ@mail.gmail.com>
Subject: Re: [PATCH] nvmem: hide unused nvmem_find_cell_by_index function
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 2 pa=C5=BA 2018 o 23:11 Arnd Bergmann <arnd@arndb.de> napisa=C5=82(a):
>
> nvmem_find_cell_by_index() is only called from inside an #ifdef,
> so we get a build warning without CONFIG_OF:
>
> drivers/nvmem/core.c:496:1: error: 'nvmem_find_cell_by_index' defined but=
 not used [-Werror=3Dunused-function]
>
> Move it into the same #ifdef as the caller to avoid the warning.
>
> Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/nvmem/core.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index cc815bb2eebd..f99fb74a646e 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -492,22 +492,6 @@ static int nvmem_add_cells_from_table(struct nvmem_d=
evice *nvmem)
>         return rval;
>  }
>
> -static struct nvmem_cell *
> -nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
> -{
> -       struct nvmem_cell *cell =3D NULL;
> -       int i =3D 0;
> -
> -       mutex_lock(&nvmem_mutex);
> -       list_for_each_entry(cell, &nvmem->cells, node) {
> -               if (index =3D=3D i++)
> -                       break;
> -       }
> -       mutex_unlock(&nvmem_mutex);
> -
> -       return cell;
> -}
> -
>  static struct nvmem_cell *
>  nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
>  {
> @@ -972,6 +956,22 @@ nvmem_cell_get_from_lookup(struct device *dev, const=
 char *con_id)
>  }
>
>  #if IS_ENABLED(CONFIG_OF)
> +static struct nvmem_cell *
> +nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
> +{
> +       struct nvmem_cell *cell =3D NULL;
> +       int i =3D 0;
> +
> +       mutex_lock(&nvmem_mutex);
> +       list_for_each_entry(cell, &nvmem->cells, node) {
> +               if (index =3D=3D i++)
> +                       break;
> +       }
> +       mutex_unlock(&nvmem_mutex);
> +
> +       return cell;
> +}
> +
>  /**
>   * of_nvmem_cell_get() - Get a nvmem cell from given device node and cel=
l id
>   *
> --
> 2.18.0
>

Srinivas,

I think this is even better than __maybe_unused so if you're fine I
won't resend my patch tomorrow.

Thanks,
Bart
