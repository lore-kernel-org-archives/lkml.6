Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7B9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BA32089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFelLLfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BA32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeIZMSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:18:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42928 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIZMSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:18:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id y71-v6so7563216lje.9;
        Tue, 25 Sep 2018 23:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RvIi8AIgrUbc2KzmfjlB15kGT1FwpsM3p+5fa3aMHZQ=;
        b=MFelLLfE10a8zHFGKyDgFygeushVkwpzZSxL51r0+57JznYRmiIWOoo0sRG6NOx03g
         aF1vWAAH/X485LTtGfu4sk4okhDcCazOMpM4WzKGjjDTas4GQbwLxdM/JNjbLHvWpVHx
         8g4VeRxoBj0x4kuz6D2vXzfrNb4KntvSasgHoinyQujEKLb8QO4FZp0JgWvLTgF266Jf
         KV+FHiIQB/leLONspB3TBlrJRtvQk+rgtzeeVVj838dj4k4KBlvsdEu2/f3iAZRZ8uNi
         5uoyhxuqEK97PnVSidI4q7laQHC3NtpEDJY6XqLKwW/0+Wyg/RWQAgz5Zu3GTMd0iB9y
         royg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RvIi8AIgrUbc2KzmfjlB15kGT1FwpsM3p+5fa3aMHZQ=;
        b=AjobRKOjZYOOSuFcKZKgOjecKgA+bS5p7y5o1Od/koyY9GysIv5NjB1Df0jWdTZLTt
         Iq98UKTZrdNTEdsiG0aFE3/6uGI2qTxHl/kem296sgqAS+CTSaL+tMW/buxDIYp0kBto
         piWLyXN7L40/BPgEioEq6LboQwneqIxZTGUNsfOD9jXRLMP4wFeO+jTb3E8EgnJ86HRE
         Skgpa3455awY6zlHwL9x09dMB5w8uncXKTRaPwl7BtCZZf/KOTm3yWiZF/0YMhLvIOyW
         6Ef+LqzXwOvCOBStTunN7wdgq0Ty8KuNI7FsFVSsdofaglVsXu3p1JpeuZVwRCq6kDvs
         4QQw==
X-Gm-Message-State: ABuFfojC0E6fVYcGIgmjlSpE/vrdlmFOCsIewBV3329tBun33fKSY5pH
        +657klTnb1icV7UBjXY3RTrOfaVUyGobf9JA1DM=
X-Google-Smtp-Source: ACcGV62vJIo1pcI3IIyKcfbfJ5mq0Olah1D59vMoavUffxqqM5fXic839TATAyPfEbZDb4elxzZUXD4xUP24dbWt26s=
X-Received: by 2002:a2e:92c4:: with SMTP id k4-v6mr3348827ljh.18.1537942033556;
 Tue, 25 Sep 2018 23:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180921085450.19224-1-ricardo.ribalda@gmail.com>
 <20180921092833.c3bznrhc3yyarmq4@kekkonen.localdomain> <CAPybu_2J4b8C_AQu5trH6fLG3FAkSvFiUOYt-HFwG+YXK9PkkQ@mail.gmail.com>
 <20180924203252.wxeclgjc7zvepyhb@kekkonen.localdomain> <CAPybu_3WF3x42k814dvEwqrMMfaxt2s4OpuK3BGMobBfmsgQ5Q@mail.gmail.com>
In-Reply-To: <CAPybu_3WF3x42k814dvEwqrMMfaxt2s4OpuK3BGMobBfmsgQ5Q@mail.gmail.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 26 Sep 2018 08:06:55 +0200
Message-ID: <CAPybu_0quOqpSrCooOgesnsZBSL1vthmff4SmPdY2=_VvTch5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] [media] imx214: Add imx214 camera sensor driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari
On Wed, Sep 26, 2018 at 7:26 AM Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
>
> Hello Sakari
> On Mon, Sep 24, 2018 at 10:32 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Ricardo,
> >
> > On Fri, Sep 21, 2018 at 12:15:55PM +0200, Ricardo Ribalda Delgado wrote=
:
> > ...
> > > > > +static struct reg_8 mode_1920x1080[];
> > > > > +static struct reg_8 mode_4096x2304[];
> > > >
> > > > Const. Could you rearrange the bits to avoid the forward declaratio=
ns?
> > > Const done, but I prefer to keep the forward declaration. Otherwise
> > > the long tables will "hide" the mode declaration.
> >
> > Well, I guess the long tables do "hide" a bunch of other stuff, too. :-=
)
> > But... I agree there's no trivial way around those tables either.
> >
> > It appears I'm not the only one who's commented on the matter of the
> > forward declaration.
>
> Ok, I will change it, Eppur si muove  ;)
> >
> > ...
> >
> > > > > +static int imx214_probe(struct i2c_client *client)
> > > > > +{
> > > > > +     struct device *dev =3D &client->dev;
> > > > > +     struct imx214 *imx214;
> > > > > +     struct fwnode_handle *endpoint;
> > > > > +     int ret;
> > > > > +     static const s64 link_freq[] =3D {
> > > > > +             (IMX214_DEFAULT_PIXEL_RATE * 10LL) / 8,
> > > >
> > > > You should check the link frequency matches with that from the firm=
ware.
> > >
> > > I am not sure what you mean here sorry.
> >
> > The system firmware holds safe frequencies for the CSI-2 bus on that
> > particular system; you should check that the register lists are valid f=
or
> > that frequency.
> >

Can you point me to a driver that does this? Just for the example. Thanks

> > ...
> >
> > > > > +     imx214->pixel_rate =3D v4l2_ctrl_new_std(&imx214->ctrls, NU=
LL,
> > > > > +                                            V4L2_CID_PIXEL_RATE,=
 0,
> > > > > +                                            IMX214_DEFAULT_PIXEL=
_RATE, 1,
> > > > > +                                            IMX214_DEFAULT_PIXEL=
_RATE);
> > > > > +     imx214->link_freq =3D v4l2_ctrl_new_int_menu(&imx214->ctrls=
, NULL,
> > > > > +                                                V4L2_CID_LINK_FR=
EQ,
> > > > > +                                                ARRAY_SIZE(link_=
freq) - 1,
> > > > > +                                                0, link_freq);
> > > >
> > > > Do I understand this correctly that the driver does not support set=
ting
> > > > e.g. exposure time or gain? Those are very basic features...
> > >
> > >
> > > Yep :), this is just a first step. I do not have the register set fro=
m
> > > the device :(. So I am reverse engineering a lot of things.
> > > I will add more controls as I am done with them.
> >
> > Looking at the registers you have in the register list, the sensor's
> > registers appear similar to those used by the smiapp driver (the old SM=
IA
> > standard).
> >
> > I'd guess the same register would work for setting the exposure time. I=
'm
> > less certain about the limits though.
>
> Thanks for the pointer! I will try this out and probably add it as a patc=
h.
>
> >
> > >
> > > >
> > > > You'll also need to ensure the s_ctrl() callback works without s_po=
wer()
> > > > being called. My suggestion is to switch to PM runtime; see e.g. th=
e ov1385
> > > > driver in the current media tree master.
> > >
> > >
> > > There is one limitation with this chip on the dragonboard. I2c only
> > > works if the camss is ON. Therefore whatever s_ctrl needs to be
> > > cached and written at streamon.
> >
> > That's something that doesn't belong to this driver. It's the I=E6=B6=
=8E adapter
> > driver / camss issue, and not necessarily related to drivers only. Is t=
he
> > I=E6=B6=8E controller part of the camss btw.?
>
> I am with you here. The i2c controller is a different driver but is
> integrated with camss. Checkout
> https://patchwork.kernel.org/patch/10569961/ I am interacting with
> Todor and Vinod to enable the i2c port indepently with camss. At least
> now it does not kill the port after an i2c timeout :)
>
> Will fix the fwd declaration and the csi-2 register. Then I wll upload
> it to my github, try it on real hw next monday and send back to the
> mailing list
>
> Thanks!
>
> >
> > --
> > Regards,
> >
> > Sakari Ailus
> > sakari.ailus@linux.intel.com
>
>
>
> --
> Ricardo Ribalda



--=20
Ricardo Ribalda
