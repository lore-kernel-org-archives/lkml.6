Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A09C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D902089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhQwR4ZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D902089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJCOFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:05:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38529 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJCOFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:05:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id v7-v6so3655744ljg.5;
        Wed, 03 Oct 2018 00:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSVwo+jStGGTQtLBo6XaPOmdRgsg6ulI5j+GQbN+tps=;
        b=qhQwR4ZBOVmmQLMc/zuyzxdCFiS/Eh9xJ/eLposiKjMNVHmXknvRcoYJSuFvPPgio/
         7A6RKY/yF9oVvbrpEziFdOWnvDmmIw/ipcvoT/Xx678Orx0LYGlKGSfg1pz3ceqQpXj3
         N6frgReEql52KS1ED6KK2iw1BiMRKpO4Rh+JS/FBqslT6eOd+1DJrMhrtzpZgL1t08JD
         peJ+d3RlOrpZSJkeSZWpS7hS+P2rf3xBqhhpXaNIrllqG0AYGMQrIGFK6KxKBEHJYmmp
         BF7H4tIW5b8H83kdRaZz85gMskm3vmGSeQzdhq0zjT7EYrx1FcgEvjDE12CNvR+kBd7Q
         eePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSVwo+jStGGTQtLBo6XaPOmdRgsg6ulI5j+GQbN+tps=;
        b=ulaFFxycYJjFgRIgu1IMaqhK2DPOTWPuL4KQD4RZHh1sQHSEOa1eVGnO4vBF0lrftZ
         R3k3263S+tgfvubaJ/YXnc+y68KOV2W5tTSyzrh0KOQgaTPlquMFwdH66KHQOwYi9E2u
         xxKhUZuHXdLM5SHDYFiip4Org4TqgDCRG5Y5Zku+YbNL756YUQmXviwQKLncDHBjfxjY
         6XGzsGHzQ0ySOsChNNDUH4089s6SbPkUzfanLVrp+ZGOGJAIERIa0TrwqVTvhEPEQz/l
         MtjBijQs0PQNzgI/plNNHyoYZxzTRlQV5z/DwcxCkOkQPnk8OiMCNgOrXn21lm5yJ80A
         ++Mw==
X-Gm-Message-State: ABuFfohKylXWsXUJEUtG3SaYIZKnB+bL8Cu/0qDj6SxknnCx7BKxTDn/
        bVaV+2mNcFgaXAwzkkZxkvQt7QySQK6NLWaR2iw=
X-Google-Smtp-Source: ACcGV62sDerlimN40gQcRBUnwY3rO7T7CvZnkob6Zd9UneikQgVaOg1DcD28X3EgVcwGvL/xiLTfeW7hd+qw3ZoPJSI=
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr171182ljj.90.1538551093109;
 Wed, 03 Oct 2018 00:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181002133058.12942-1-ricardo.ribalda@gmail.com>
 <20181002133058.12942-2-ricardo.ribalda@gmail.com> <20181002162438.zia2pwztd6vuqme2@paasikivi.fi.intel.com>
In-Reply-To: <20181002162438.zia2pwztd6vuqme2@paasikivi.fi.intel.com>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Wed, 3 Oct 2018 09:17:56 +0200
Message-ID: <CAPybu_1B+zAasFuiRrhByXaVGz6KfuBxXJYWRwBM-CL8Bh6C=g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] [media] imx214: Add imx214 camera sensor driver
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

HI Sakari

Thanks a lot for your review!

On Tue, Oct 2, 2018 at 6:27 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> > +static int imx214_s_power(struct v4l2_subdev *sd, int on)
> > +{
> > +     struct imx214 *imx214 = to_imx214(sd);
> > +     int ret = 0;
> > +
> > +     on = !!on;
> > +
> > +     if (imx214->power_on == on)
> > +             return 0;
> > +
> > +     if (on)
> > +             ret = imx214_set_power_on(imx214);
> > +     else
> > +             imx214_set_power_off(imx214);
> > +
> > +     imx214->power_on = on;
> > +
> > +     return 0;
>
> Using runtime PM would relieve you of this function.

Tried using runtime PM, but did not manage to get it working with the
qcom i2c driver. Will try again when this is merged on a separated
patch.
>
> > +static int imx214_find_mode(u32 height)
> > +{
> > +     int i;
>
> Unsigned int.
>
> > +
> > +     for (i = 0; (i < ARRAY_SIZE(imx214_modes) - 1) ; i++)
>
> Extra parentheses.
>
> How about using v4l2_find_nearest_size()?
>
> > +static int imx214_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev = &client->dev;
> > +     struct imx214 *imx214;
> > +     int ret;
> > +     static const s64 link_freq[] = {
> > +             IMX214_DEFAULT_LINK_FREQ,
>
> This should come from firmware.

Thanks for clarifying this on the IRC. The link frequencies should
come from the firmware, but since we only support one and is probed it
is fine to get a static list.

> Kind regards,
>
> Sakari Ailus
> sakari.ailus@linux.intel.com

Thanks again

--
Ricardo Ribalda
