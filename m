Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IvY9J6iSHlvVGAAAmS7hNA
	; Mon, 11 Jun 2018 15:18:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C1E1F607A4; Mon, 11 Jun 2018 15:18:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4PQwvja"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6998160541;
	Mon, 11 Jun 2018 15:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6998160541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932885AbeFKPSi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:18:38 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34797 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932678AbeFKPSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:18:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id o9-v6so31149589lfk.1;
        Mon, 11 Jun 2018 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Grec2OtNvJ00k+NTJFZvu6d8o6nZ7+1BLNe/SIbSBCg=;
        b=I4PQwvjaQrP/34JnUvvL+mxDdEqpMEZGgriiOX4V3Vo5LCsvrq5UU7jf53EFIwz1nD
         bbIcnAVNJyLP3Tx+ZTm1A9PHlSK9bgk9tH1hisXIpQmpXRL7tGOP7ZENRAgjM0/EdjKt
         XX7EUgXY8Qcu/9HpxmmpkmK7IiZtmbYR+XL5jOBQA1+NylacbGEirRndM+eFMmcrSUzI
         xnlYUpklt+yjjAgYWMA0fAoPCPQHPj3B0UPTjGbhdpVOx3/owV8VkX9KmQq5PloGSkDC
         Naiz97n4EFyJ6oKkJP0rA/TOhHi1LCdY1cliKyW9bIBART/N0rcCOJYZk8jEaxLb/OPU
         HMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Grec2OtNvJ00k+NTJFZvu6d8o6nZ7+1BLNe/SIbSBCg=;
        b=KZ2zDwGNE4QCPXC9J40FSRas6xugq0TMfqPEymiOb+DVfNm9DP44L0SWp69jgs8cky
         1NcYivodKQPsEmnEAPZWUWxJ55DU2ruOR9MOi2DfcthBnVVrMjads8M/0hH/uBTTFQse
         7g/3o/1YHElh+syDNUCEa+69/FYwhHD0zvrZEJSyzPUm6zvGuep+O24g5D+gUZ3h9Uy0
         tmHG3DG3mMygYAAs86Lr9gvk31l34cpzcyMyF9nwlidW2XjLK6HRQsMLsokC/NIuSnvQ
         IqXcVrr2IRWTAXzYitwK0u1+39OFIxyCwppr8uTYwf7D9qWcKWsTn/EsTSPQ0rs7eksq
         sI3A==
X-Gm-Message-State: APt69E3519PbWujbuBYSHJOGDoc3HGNkGeOn2wtfuwdtUGFtuBG/J59m
        050ruUd7lPFr3DvNbzEwc+/hZPvDU1D/2FjHKgE=
X-Google-Smtp-Source: ADUXVKJFNEV9b1z/xacpM9J63hYi6r78PJV/ZuUlLzWxHEsmA8gTYV/kCOTMM0B1q7eikXPujocJn8p7sBzbHeCnsEE=
X-Received: by 2002:a2e:1092:: with SMTP id 18-v6mr12560761ljq.115.1528730313213;
 Mon, 11 Jun 2018 08:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-15-ricardo.ribalda@gmail.com> <EBCCCD1F-0F23-4599-8A78-32BBF2DAF746@holtmann.org>
In-Reply-To: <EBCCCD1F-0F23-4599-8A78-32BBF2DAF746@holtmann.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 11 Jun 2018 17:18:16 +0200
Message-ID: <CAPybu_3m8M5guQQQ+_wx9i7eU8qsUhZ1bRvmbdEnSsUPUtAe6A@mail.gmail.com>
Subject: Re: [PATCH v2 14/24] mfd: rave-sp: MODULE_DEVICE_TABLE(serdev)
To: Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel
On Mon, Jun 11, 2018 at 3:14 PM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Ricardo,
>
> > Export serdev table to the module header, allowing module autoload via
> > udev/modprobe.
> >
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > ---
> > drivers/mfd/rave-sp.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
> > index 5c858e784a89..c0ecfbc16dca 100644
> > --- a/drivers/mfd/rave-sp.c
> > +++ b/drivers/mfd/rave-sp.c
> > @@ -694,12 +694,19 @@ static int rave_sp_probe(struct serdev_device *se=
rdev)
> >
> > MODULE_DEVICE_TABLE(of, rave_sp_dt_ids);
> >
> > +static struct serdev_device_id rave_sp_serdev_id[] =3D {
> > +     { "rave-sp", },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(serdev, rave_sp_serdev_id);
> > +
> > static struct serdev_device_driver rave_sp_drv =3D {
> >       .probe                  =3D rave_sp_probe,
> >       .driver =3D {
> >               .name           =3D "rave-sp",
> >               .of_match_table =3D rave_sp_dt_ids,
> >       },
> > +     .id_table =3D rave_sp_serdev_id,
> > };
> > module_serdev_device_driver(rave_sp_drv);
>
> so I would actually prefer that we not duplicate the .driver.name in the =
.id_table. This one for example is non-functional since all supported hardw=
are needs a specific .data entry. It will fail here:
>
>         sp->variant =3D of_device_get_match_data(dev);
>         if (!sp->variant)
>                 return -ENODEV;
>
> Maybe we focus first on getting the base support for new_device etc. merg=
ed and use the Edison Bluetooth platform driver support in hci_bcm.c so we =
can do a real cleanup there. And then later add broad new_device support. S=
ome of these instances should be just fine with never getting it since they=
 require to many per device quirks to make things functional. A blind searc=
h+replace is not going to work.

I think that functionality is added on another patch from the series.
Let me merge both together so the driver is functional (and builds)
from any point of the tree. Let me merge it in
https://github.com/ribalda/linux/tree/serdev3 and resend after I fixed
all the other suggestions


Thanks

>
> And things like device_get_match_data() should work as well even if the h=
ardware is listed via serdev_device_id. Drivers that are solely DT centric =
will need a lot more work before dynamic adding of serdev devices can happe=
n.
>
> Regards
>
> Marcel
>


--=20
Ricardo Ribalda
