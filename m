Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E69C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D19218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0CLtXuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfAYGzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:55:41 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42848 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfAYGzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:55:40 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so6942844oiw.9;
        Thu, 24 Jan 2019 22:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zv8x412M3xy9NTN/1GaiIYd9L8YDnqNfiS5wtnkMdJk=;
        b=K0CLtXuUr2acDIGOdrHOwdHaL9+tPvNv6Ck0qg2XMOD15tzgtjpWmUzG/0QXnrU1OU
         vGlfdfVpZpKrq4gtSbBz5UXuW6dygo4uyl0WJgv/4p6FNKBjbJbi+C6Xl232or5O6pIU
         28UbKCHnOeY7fhzEf9/FlqSx+p5FCfjcp/pp1i1VVymWEWCthl7cnmRV98QLzeVeaHya
         7IsM9JUWsz+HJomfJUmp6TIN9TUABg256cPb/dAl8NvmXXBDJCbbl87rDOteMVh3yrcH
         hyq/68xJgCNlV+RUBvN35D4lBaRjd66Z7tcYQyGwbewsjsMPMkq9Tti5k7oTcu/AXy3/
         NJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zv8x412M3xy9NTN/1GaiIYd9L8YDnqNfiS5wtnkMdJk=;
        b=e5z90sbXVg4U5PChCO5OZjJ31UoMKiUINjAspQDwbTAA8mVOhaDPeberLBU1dfqd5Q
         8E9bIBXivOnz40OHq5D1ixwx6dP9gYzPqlok9X+y0/7aKV6wgxEgiQ9nXdWPjQL+FHMF
         /lNUzpUuM3/L+FFotuQd+7qpgJIner4GSMc98RTMPTTYETVRox4lSZu17On0BLl2/R4f
         pDIFHg/r0rbdR8wTj+0nkwOLcUM0oFDyxEPS76HYLVLriYKL+DCYgouiahRUmtd1nh5g
         d+xUucUnPtVsX4wrip0nAP23eid3IjIZkOkc5aHkGwtzcTND9Xsai89Va66YM65wWwYP
         e03w==
X-Gm-Message-State: AJcUukdtRagYlaYML4sV3SictUL++M+w7qecMyZXhpD31yfCU0rs0MHH
        cCouih84uTLKy124YX+qPeoSpnvLNsGH89Ad10o=
X-Google-Smtp-Source: AHgI3IYOWKq30XYuyXva4WjqpbXiZSMzNMKN+17mtdsS4uJANSOlcweDeP6Dv00QxlNyUXF2vOPWQ68tNPY/Gr8yq3s=
X-Received: by 2002:aca:6c4:: with SMTP id 187mr611054oig.290.1548399339886;
 Thu, 24 Jan 2019 22:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20190124142755.GA31059@bhar.linux>
In-Reply-To: <20190124142755.GA31059@bhar.linux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 25 Jan 2019 08:55:27 +0200
Message-ID: <CA+U=Dsrefk01AbyKmkhLrwQyq8mkBKoO6kv_zXYEFSSCCqDObw@mail.gmail.com>
Subject: Re: [PATCH] drivers: iio: industrialio-core: add check when kzalloc fails
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 4:28 PM Bharath Vedartham <linux.bhar@gmail.com> wrote:
>
> add code to handle the case when kzalloc fails to allocate memory to dev
>
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  drivers/iio/industrialio-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4f5cd9f..93caa6b 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1475,6 +1475,8 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
>                 }
>                 dev_set_name(&dev->dev, "iio:device%d", dev->id);
>                 INIT_LIST_HEAD(&dev->buffer_list);
> +       } else {
> +               return NULL;

I'd argue that this is a bit redundant, because `dev` is NULL, the
return below (return dev) will also return NULL.

Alex

>         }
>
>         return dev;
> --
> 2.7.4
>
