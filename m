Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976D6C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483402082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxtKfn0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483402082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeJDQ7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:59:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34832 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeJDQ7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:59:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id o14-v6so7845708ljj.2;
        Thu, 04 Oct 2018 03:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LMwMIpNo9BoxjsZCyB38K6u5kj58SlDOP+no+C7Q0I=;
        b=kxtKfn0ZI7NKXRfdG4X+wE39J8SHLbwCcGicwEjFB5VHzw0gcf8coA6ChJyFAlak6u
         2w+BqLy69jcDtgE/WDjlGKIeRU4KocxKN2QP7DAqWHfOHYilZ3jwyORJnbGBghb3gDGL
         Tm/oE1mw1NaPFSFeH7gyd6cm6KPFg7bTLTcej8fggt/h9ETuJ4Vm3hOe4cs2+gFGqUtJ
         mKCxSj7iojDwC0G48ANGWPNcO/7EvHHQDI0sfd+9wEVKzMWusiGjdrDo8UM5z1WNjflV
         lWkLq2HLpZJwUQc2774Yz3ei1n7OXOSz2xGy5lhbfyDGfK3n3XMLT+w2XYtH17CayDEk
         s7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LMwMIpNo9BoxjsZCyB38K6u5kj58SlDOP+no+C7Q0I=;
        b=h5Hf440pVmT6zgkO2B08sJVbk7Hvk0XTELHWaovXcMnnaHNMTLGU57cXJSXJgX7tY2
         tIrFDcxjKOJuJ3UElYfGz2DY1PIN5l0eSNXzhtgtIHKsKAGMLcAJY68gUXOTX1mSgPMY
         nJubRE201bb9e39t1dtn3RUHTRGScUaHp7tZKFv+9gjFuCQ9g5aq8n33nJ0ZxCqREPhq
         1hLgFwKr+LkwoT+NdIGpfGKbOtWuyYmZux2M137dpEKrsmAslmF59772JTeFukKPq7nS
         WbgPAdu1RnCM+rGZeQuXCVrWuikHQoXEKY+oFStqV7FdUJ/gd6/QzD85nnRBd6XFgMPt
         7E0Q==
X-Gm-Message-State: ABuFfojDgHujlYDJHntf/RJiuTeH2qND4feRUiS6rIEBdIOtrlNjZj/F
        RYqdKrgKo52fuiT6L0N/qlZOnaBT3ECGc1Tb7qhEGg==
X-Google-Smtp-Source: ACcGV60akK9ptUZ/lg3Ywlg0eHEAZBlx3IivwmpPiyS+RNDYw5Px74tqGAHfzLGniMflCtgmcEkIPb4uisciLd8bzMk=
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr3735176ljj.30.1538647633054;
 Thu, 04 Oct 2018 03:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181003130951.19140-1-ricardo.ribalda@gmail.com>
 <20181003194658.zj6jkfmpbrkmnlen@kekkonen.localdomain> <CAPybu_0Og50WhkO2hHmg5cLQ6a2sx+KEp3_DOTKS=AJ2Shf3YQ@mail.gmail.com>
 <20181003221415.jgpeea5ligm7oyr6@kekkonen.localdomain>
In-Reply-To: <20181003221415.jgpeea5ligm7oyr6@kekkonen.localdomain>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 4 Oct 2018 12:06:56 +0200
Message-ID: <CAPybu_2CPQFwuGF9Pbbnqe6KHCZzm_70+Zs2xs3iPsUgQqjECQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] [media] imx214: Add imx214 camera sensor driver
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>, jacopo@jmondi.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari
On Thu, Oct 4, 2018 at 12:14 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Wed, Oct 03, 2018 at 10:24:17PM +0200, Ricardo Ribalda Delgado wrote:
> ...
> > > > +static int imx214_enum_frame_size(struct v4l2_subdev *subdev,
> > > > +                               struct v4l2_subdev_pad_config *cfg,
> > > > +                               struct v4l2_subdev_frame_size_enum *fse)
> > > > +{
> > > > +     if (fse->code != IMX214_MBUS_CODE)
> > > > +             return -EINVAL;
> > > > +
> > > > +     if (fse->index >= ARRAY_SIZE(imx214_modes))
> > >
> > > array_index_nospec() ?? I find it scary that you'd need that in drivers.
> > > :-o
>
> Uh... not needed.
>
> The value is just sent back to the user as such so this is fine AFAICT.
>
> > >
> > > > +             return -EINVAL;
> > > > +
> > > > +     fse->min_width = fse->max_width = imx214_modes[fse->index].width;
> > > > +     fse->min_height = fse->max_height = imx214_modes[fse->index].height;
> > > > +
> > > > +     return 0;
> > > > +}
>
> ...
>
> > > > +     /*
> > > > +      * WARNING!
> > > > +      * Values obtained reverse engineering blobs and/or devices.
> > > > +      * Ranges and functionality might be wrong.
> > > > +      *
> > > > +      * Sony, please release some register set documentation for the
> > > > +      * device.
> > > > +      *
> > > > +      * Yours sincerely, Ricardo.
> > > > +      */
> > > > +     imx214->exposure = v4l2_ctrl_new_std(&imx214->ctrls, &imx214_ctrl_ops,
> > > > +                                          V4L2_CID_EXPOSURE,
> > > > +                                          0, 0xffff, 1, 0x0c70);
> > >
> > > The exposure is in lines so it can't exceed frame height + blanking.
> > > There's a marginal, too. I don't know what it might be for this sensor
> > > though. Usually it's small, such as 8 or 16. The image will almost
> > > certainly be garbled if you exceed the allowed value.
> > >Seems that this sensor
> >
> > On this sensor what I am experiencing instead of garbage is that the
> > fps gets reduced. So I believe it is fine to
> > set it up this way.
>
> That's rather confusing as well. The user should explicitly need to change
> fps first, rather than it happening as a side effect of a seemingly
> unrelated control.
>

I'd rather maintain this behaviour until we get access to better documentation.

Currently I cannot change the fps on demand, just changing the
exposure time, so I have no proper way of set/get fps



> --
> Regards,
>
> Sakari Ailus
> sakari.ailus@linux.intel.com



--
Ricardo Ribalda
