Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC29C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E624322504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFJ8iZSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E624322504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbeKMBmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:42:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbeKMBmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:42:25 -0500
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D56CB22503;
        Mon, 12 Nov 2018 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542037717;
        bh=og6tglYplsD+DCYSU6k98sVyaqT68ZPSlxBy/B7WRWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qFJ8iZSOgs64XKZMtEvCwOrIUpcvR/iv3cl9UjVepvNJIkGAjvlp7rchRtRgLvSup
         /qkH8iBLfsB15u0PM1XHP41+dT65zlnouIR3lMd2PyCNMz10xRkvdnNBbCvw7eVmf/
         q6Mb1U5gBFOwSJdF2KToOPJoMOaSIImJl/swrKsk=
Received: by mail-yb1-f169.google.com with SMTP id d18-v6so4082780yba.4;
        Mon, 12 Nov 2018 07:48:36 -0800 (PST)
X-Gm-Message-State: AGRZ1gJU0dSirjvrD/Di1HROdllL2qqb7lYfEVEyDXVDXz3chb15hKLp
        yIGzeDk48hiuad/oiDR7ln6cfeEyWKjIMkEYsUU=
X-Google-Smtp-Source: AJdET5fwKkPzKL4bpZHScsr+GVjqoBqE42/FSBygylER7Ti3KJ3xPxCZpxVkKy9ohKgpF/eVGryrZbUgnv9l7VrPlJ0=
X-Received: by 2002:a25:b28d:: with SMTP id k13-v6mr1393696ybj.222.1542037716075;
 Mon, 12 Nov 2018 07:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20180912144327.3130-1-atull@kernel.org> <20180912144327.3130-5-atull@kernel.org>
 <20180930154921.GB13200@kroah.com>
In-Reply-To: <20180930154921.GB13200@kroah.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 12 Nov 2018 09:48:00 -0600
X-Gmail-Original-Message-ID: <CANk1AXSr1xdqfmyNeN6Jc-OnZhDqbL+C2Uz_j37NGopVRWNj6g@mail.gmail.com>
Message-ID: <CANk1AXSr1xdqfmyNeN6Jc-OnZhDqbL+C2Uz_j37NGopVRWNj6g@mail.gmail.com>
Subject: Re: [PATCH 4/5] fpga: of-fpga-region: Use platform_set_drvdata
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 10:49 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

Hi Greg,

>
> On Wed, Sep 12, 2018 at 09:43:26AM -0500, Alan Tull wrote:
> > From: Moritz Fischer <mdf@kernel.org>
> >
> > Use platform_set_drvdata rather than dev_set_drvdata
> > to match the platform_get_drvdata in the _remove()
> > function of the platform driver.
> >
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > Acked-by: Alan Tull <atull@kernel.org>
> > ---
> >  drivers/fpga/of-fpga-region.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> > index 052a134..d6a70e4 100644
> > --- a/drivers/fpga/of-fpga-region.c
> > +++ b/drivers/fpga/of-fpga-region.c
> > @@ -421,7 +421,7 @@ static int of_fpga_region_probe(struct platform_device *pdev)
> >               goto eprobe_free;
> >
> >       of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
> > -     dev_set_drvdata(dev, region);
> > +     platform_set_drvdata(pdev, region);
>
> Again, not really a bugfix :)

Could you take this patch 4/5 (just sent a reminder for 5/5)?

Thanks
Alan
