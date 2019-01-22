Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F65C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A672B20861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWo8rKpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfAVFkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:40:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33783 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVFkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:40:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so7677846wmh.0;
        Mon, 21 Jan 2019 21:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QB1IzrQ5ubKqN30REWUtu1MUBzuP4YGWZb0I1SMhJ4g=;
        b=GWo8rKpyxwVx1P/Np1iucGxf5Z4cvEX6tfRj5MViNNNzcfhUOwoDOnOu6gdGhuAgnq
         QyPp033vXfL823Wl2wod8uiiTN5cr9qEBFNDQDofLl6j57j3iRUNcplG1gZZ6yiKDytT
         W4BMs79fPjD09P1W/7vFokG9O5Fb/1D0Mb5bJtGMKytG9heDxm/+ms2CszLRrXMZ0cf3
         ckRfTYpfjV9NikD+oB+ebMZfA5iH6ZqS6YGeYxtxZiATFt4QnWNgcwI8ac8iG1RywVcf
         HPWa1fRtRzEI0RYzq6BDde/aN/akAZTyjGnleZk+VeVAJ/f1yx+LSh/5zCwFdsNo67WY
         M8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QB1IzrQ5ubKqN30REWUtu1MUBzuP4YGWZb0I1SMhJ4g=;
        b=gcOgdWlzpsSGvQj/OafBP06Tvw+3Wv2pLUBlizaCQ2s9UDeb/Fms0VEgVbTMD/brs6
         X+nsa7FF7PHLzhxXLqnCFmNH92qqkZI5LE8q83deMh2TaxdG2vRGu3eJVQSu3gwLBBXo
         5KpfXC7Cf6ANkEdjNd9QfkUxyGk/0Ra9O4G3PqopIkF6nlzuzYxGZKiNu5pT7jF/sEAh
         u8r85mDQygnC10vFvpDu9yoPx1DxyGPj/Zt22zqL1xZKq70izNIiYNPt/EH0Lr8aeIDY
         XNpbPU/uSbFie1VBhMXOvew84JtSHcb271k4Yb717FoZcCHmboPvoLiba58p3lvLi1EM
         bGJw==
X-Gm-Message-State: AJcUukdO7UR51ouQm9FQr7qEeU7xKh4BvRtHm27IZkbfN7zk3n1kemrr
        /uBUO6WZYSfSOyCV06VPRRsnBu0LEroDGAUoyPk=
X-Google-Smtp-Source: ALg8bN72TUMlgypbmHeah/km+hZs6MIoOPc2adTaoak05fUIiMWQk8OiDvZGMXiLTTohcfDoyDYpnvxygH/fW670hp0=
X-Received: by 2002:a1c:9806:: with SMTP id a6mr1988361wme.114.1548135614309;
 Mon, 21 Jan 2019 21:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20181024150525.11552-1-heikki.krogerus@linux.intel.com> <20181024150525.11552-4-heikki.krogerus@linux.intel.com>
In-Reply-To: <20181024150525.11552-4-heikki.krogerus@linux.intel.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Tue, 22 Jan 2019 13:40:02 +0800
Message-ID: <CAKgpwJVaOrZaPOZrfeDiym=P=uZSbG1Aw5T0xayuPMFxG-3cyQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] usb: roles: Find the muxes by also matching
 against the device node
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,
Heikki Krogerus <heikki.krogerus@linux.intel.com> =E4=BA=8E2018=E5=B9=B410=
=E6=9C=8824=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:06=E5=86=99=E9=
=81=93=EF=BC=9A
>
> When the connections are defined in firmware, struct
> device_connection will have the fwnode member pointing to
> the device node (struct fwnode_handle) of the requested
> device, and the endpoint will not be used at all in that
> case.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/common/roles.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/common/roles.c b/drivers/usb/common/roles.c
> index 99116af07f1d..bb52e006d203 100644
> --- a/drivers/usb/common/roles.c
> +++ b/drivers/usb/common/roles.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/usb/role.h>
> +#include <linux/property.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -84,7 +85,12 @@ enum usb_role usb_role_switch_get_role(struct usb_role=
_switch *sw)
>  }
>  EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
>
> -static int __switch_match(struct device *dev, const void *name)
> +static int switch_fwnode_match(struct device *dev, const void *fwnode)
> +{
> +       return dev_fwnode(dev) =3D=3D fwnode;

Seems this should be dev_fwnode(dev->parent) =3D=3D fwnode;
The role switch is the child dev of the caller of usb_role_switch_register(=
).

Li Jun

> +}
> +
> +static int switch_name_match(struct device *dev, const void *name)
>  {
>         return !strcmp((const char *)name, dev_name(dev));
>  }
> @@ -94,8 +100,12 @@ static void *usb_role_switch_match(struct device_conn=
ection *con, int ep,
>  {
>         struct device *dev;
>
> -       dev =3D class_find_device(role_class, NULL, con->endpoint[ep],
> -                               __switch_match);
> +       if (con->fwnode)
> +               dev =3D class_find_device(role_class, NULL, con->fwnode,
> +                                       switch_fwnode_match);
> +       else
> +               dev =3D class_find_device(role_class, NULL, con->endpoint=
[ep],
> +                                       switch_name_match);
>
>         return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
>  }
> --
> 2.19.1
>
