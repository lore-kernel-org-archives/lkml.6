Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC73C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F77B214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="l7/aT3eX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F77B214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeLCRLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:11:07 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43731 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeLCRLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:11:07 -0500
Received: by mail-yw1-f66.google.com with SMTP id l200so5675963ywe.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xy519ioxY8kNNqHgw43eLJw2UJslvmFbCOo+R7BOUQg=;
        b=l7/aT3eXzVaxIb33IW5tl+/xrLc/3XYobZbHdzwvYzVF82XkWElSuT5jqrYvydaurO
         NJ/0SC2MEjfp57p0NFXr8MtjTzH6zTv1rPhYUIew51KKf3IjM2/jZIb8CayE5k9Dtse7
         80cDy8JrzghJPXlmfr/0HBiv4/g2k+DGRBrCUVp21ME7BJCiITPvCfbGKKReB89hgDhi
         9dZDqcBJw5Kj2uYqU3MRUVSX4rA+OcJLdf0gEL7+tCYZ8ZjFvJ+VpB5AlRJgY4Nk+uIT
         /7DkETnT1k3Giy6+Nja/W5fc45ARKIQ2gbSaTO9I9UYCJH4pO0jbN0fAVeaB0+UQmFZb
         db0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xy519ioxY8kNNqHgw43eLJw2UJslvmFbCOo+R7BOUQg=;
        b=jY5uuQRsIVG+wDWiok1gVbSRZIXmCJrBpfrAM1/d5ywLMxGv+5e9e+cayqg4CSCOvG
         Fn1lTOyI2QuCyHWdKxy15GBLT7079LFXBU++YAF2fkmXp3RqACfyV9akgqSJVYP8+Q3x
         ScNPSfu6dBXF/gyBkbrQSz+WyNqyJWXmpPhVU/1CdLc6Sl/RhUpABVH9WEeDYySUh3Qt
         XEjMVToAhimwfgni9m25DJQzkeLJFtSQV11gu3C0lauj3nHD2dHyuEzE6tUOk4grhpiU
         RzseBbMVbkVTR9/mBapS4kT6YT6MNwauQHmNP6VSscN/fzMIoj0ZkZw5c5mWluYscS40
         DP3g==
X-Gm-Message-State: AA+aEWZBjMuzEDlEl1uT4X/ozG/O/u9WGtQeocELU7g48NR30Fy9Nh7e
        r68MFNjoxPVRyW2dClq/IGwq1kJYAMrWJOLGrZD1vw==
X-Google-Smtp-Source: AFSGD/U0iVGUmF4DalzQ6C7GkHqsUqt9JhxqgrVV/75f745a2lGw7uWaPEpPKpSP6OeyA4zOlDm+Z8WUo30UNQrRrWo=
X-Received: by 2002:a0d:de82:: with SMTP id h124mr16135824ywe.354.1543857065651;
 Mon, 03 Dec 2018 09:11:05 -0800 (PST)
MIME-Version: 1.0
References: <20181203122145.1534-1-nsaenzjulienne@suse.de> <CANk1AXRxUai9SmSFt1uMXVRcoumh+ziKCi8WHb2tCG5Wx4Txow@mail.gmail.com>
In-Reply-To: <CANk1AXRxUai9SmSFt1uMXVRcoumh+ziKCi8WHb2tCG5Wx4Txow@mail.gmail.com>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Mon, 3 Dec 2018 09:01:47 -0800
Message-ID: <CAAtXAHdWrJ3zL7sHygTD9W+trvviTh_0zMSwaU4AtNpxSxLbgg@mail.gmail.com>
Subject: Re: [PATCH] fpga: stratix10-soc: fix wrong of_node_put() in init function
To:     Alan Tull <atull@kernel.org>
Cc:     nsaenzjulienne@suse.de, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

good catch.

On Mon, Dec 3, 2018 at 8:13 AM Alan Tull <atull@kernel.org> wrote:
>
> On Mon, Dec 3, 2018 at 6:22 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
>
> Hi Nicolas,
>
> Thanks for catching this!  I'll fix up one formatting thing (below).
>
> >
> > After finding a "firmware" dt node stratix10 tries to match it's
> > compatible string with it. To do so it's calling of_find_matching_node()
> > which already takes care of decreasing the refcount on the "firmware"
> > node. We are then incorrectly decreasing the refcount on that node
> > again.
> >
> > This patch removes the unwarranted call to of_node_put().
> >
> > Fixes: e7eef1d7633a ("fpga: add intel stratix10 soc fpga manager driver")
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
>
> > ---
> >  drivers/fpga/stratix10-soc.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> > index a1a09e04fab8..e75dbe583152 100644
> > --- a/drivers/fpga/stratix10-soc.c
> > +++ b/drivers/fpga/stratix10-soc.c
> > @@ -509,13 +509,11 @@ static int __init s10_init(void)
> >
> >         np = of_find_matching_node(fw_np, s10_of_match);
> >         if (!np) {
> > -               of_node_put(fw_np);
> >                 return -ENODEV;
> >         }
>
> We don't need the brackets anymore around the return statement.  I'll fix it up.
>
> Thanks,
> Alan
>
> >
> >         of_node_put(np);
> >         ret = of_platform_populate(fw_np, s10_of_match, NULL, NULL);
> > -       of_node_put(fw_np);
> >         if (ret)
> >                 return ret;
> >
> > --
> > 2.19.2
> >

Thanks,
Moritz
