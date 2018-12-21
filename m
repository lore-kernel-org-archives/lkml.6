Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40FDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E0F218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WlF7XGw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391255AbeLUR5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:57:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37817 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391218AbeLUR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:57:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id t18-v6so5480971ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L51gMsxk3nWjd8CCo5rEtMSURBeChgHIO4rTmI626Bc=;
        b=WlF7XGw2/8bAED8Mxo88kVOaHiNSfijgSN0Gs6Xlx9V51b4Zp+0OdaVKOD2yUEQ5xo
         f6tIWBAF9KanWssFhGu+d4XcKEia5r69RoA8rbrPlnbywAObdbaM0aOp5FK2YUwdrXYt
         3rdJWEH3wcyN5pzLwMetCrBKPT9opXREduNsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L51gMsxk3nWjd8CCo5rEtMSURBeChgHIO4rTmI626Bc=;
        b=sGS2e1LOm37WpOBEicBIP9/fcLwfjPUw6LOWeZD5dNwzXZMovWfOIrDNWI5wIaLwD4
         kzL7CM/qrzouYkfgfNbx1TzcXgXI1bI5gINMlehLGjtLgqRtIn6BKM+8QsSbWYo7mhPX
         w/gueAljJGJqDrsbA0U1H3JMoEqrwhvpFpsNUIk+y9gMy97E+m5fHDPXAVtIIGWWJrlG
         kI0HcWBZ/dpSZE7MiDxVUHSlVgDxPCsxQTAbgQbeyOj7nXgI/f7nVgaWA4wlcUSzLEfA
         drXImg9lLvFgdCRU5XWKDJBa/FUsCatFaAm2ZEVQyftZ1ct/WU32U/CqBgUlEB+PYl/P
         Exow==
X-Gm-Message-State: AJcUukdsLIyxD4uDU/bc/PWzLD7VRTyx2T9OOgrBHB6GP5yq+9+Zm41g
        PzEUyBCf47/u+AOtyyy/iJPegcLc4Pk=
X-Google-Smtp-Source: ALg8bN6vhqnGzrAX3pkcxJkigVK5wIKPfr1ru1y4EYLwajGrbcTl/I8bkyDjW+mCDooVICG1AJha6A==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr2272365ljj.9.1545415035328;
        Fri, 21 Dec 2018 09:57:15 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id k13-v6sm2189220lje.89.2018.12.21.09.57.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 09:57:14 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id y11so4497150lfj.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:57:14 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr1854928lff.16.1545415034222;
 Fri, 21 Dec 2018 09:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20181218000834.201748-1-evgreen@chromium.org> <20181218000834.201748-2-evgreen@chromium.org>
 <20181221011853.GA189656@google.com>
In-Reply-To: <20181221011853.GA189656@google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 21 Dec 2018 09:56:37 -0800
X-Gmail-Original-Message-ID: <CAE=gft7c8y7isdkoC6Bte6o5KPdzrgCVRAPje72CZcO5+VMdrQ@mail.gmail.com>
Message-ID: <CAE=gft7c8y7isdkoC6Bte6o5KPdzrgCVRAPje72CZcO5+VMdrQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] soc: qcom: rmtfs-mem: Add class to enable uevents
To:     Brian Norris <briannorris@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ben Chan <benchan@chromium.org>, linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 5:19 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi Evan,
>
> On Mon, Dec 17, 2018 at 04:08:33PM -0800, Evan Green wrote:
> > Currently the qcom_rmtfs_memN devices are entirely invisible to the udev world.
> > Add a class to the rmtfs device so that uevents fire when the device is added.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >
> >  drivers/soc/qcom/rmtfs_mem.c | 23 ++++++++++++++++++-----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> > index 97bb5989aa211..0bf800ee2a978 100644
> > --- a/drivers/soc/qcom/rmtfs_mem.c
> > +++ b/drivers/soc/qcom/rmtfs_mem.c
> > @@ -132,6 +132,11 @@ static int qcom_rmtfs_mem_release(struct inode *inode, struct file *filp)
> >       return 0;
> >  }
> >
> > +static struct class rmtfs_class = {
> > +     .owner          = THIS_MODULE,
> > +     .name           = "rmtfs",
> > +};
> > +
> >  static const struct file_operations qcom_rmtfs_mem_fops = {
> >       .owner = THIS_MODULE,
> >       .open = qcom_rmtfs_mem_open,
> > @@ -173,9 +178,15 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
> >
> >       }
> >
> > +     ret  = class_register(&rmtfs_class);
> > +     if (ret)
> > +             return ret;
>
> Hmm, is this how classes are supposed to work? Usually, you have the
> possibility of more than 1 device per class, and therefore you don't
> register the class in the driver probe -- you register it in the init()
> routine, or something similar. As it is, I expect this will break if
> there were ever a second rmtfs device.
>

Fair enough. I'll move this to an init routine.
