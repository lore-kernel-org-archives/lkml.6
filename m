Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D42C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB76421872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="OW5JQBNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfAXRcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:32:17 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43471 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfAXRcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:32:17 -0500
Received: by mail-yw1-f67.google.com with SMTP id n21so2733174ywd.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 09:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=es879vh7LCU65XImqJ2cVOvRVK7zPgDroBODXSqimIE=;
        b=OW5JQBNgEwbltMxjyp/fCNRj7xBNvvRc9pY2Vy5tuiIwVV6MMpvsMZtRxrHan1YCKu
         tAPVMlEOP2BQpe7hkHzLw8eYKWpM8CYN32MRdrG/SQyxjR9h7sdgXLex+57y7Im4J1Az
         Q9BHvhquU3m2GBC0iTw3QpjkZXEZnvym41GEjnGvVu2Oh4lR3oNjJnYbqJ6UTILhAMQ1
         o1CsoWDWvMkY/M9hLBx/2Eh/iX4XPZvISFulf2wU89JYok27o6HEaFjUSCqx2kev2eO+
         TY7WpC70718YvoeLKlPE0pr5mjrtJGRe74hsKaNoS/DhnFUwkaWojPvGaus3Kj4bwnaH
         MIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=es879vh7LCU65XImqJ2cVOvRVK7zPgDroBODXSqimIE=;
        b=i6bESKnhUkP1UgI75LipY7hCPzrdgAvLPbOYBbh0zBJeFJ+zTwPBuvPkvT25aXVVcv
         8rPAV4aL12MC461MDBASPGdn2HZRxTNm20UL432AuLEu6VXudhgda6lg0KKZDncwDeIm
         TeuoTGt7kQ/V1nhwdherHNW9MZJQUirH18aDPXX+VCubpDqJ3L1gfWBE3s61lNQdoCiw
         PIhDTwnPMJPTQDJ1uSgb2k0gp9LPUkarEKnFWdOx3bPgjVXQcb11J81z2aRxCKe41C9b
         ketZkrh/Vgl2ykCrYAbfgZppmXChwwqTl9vVTHvYzjrVzCu4vOVQqkwLAuHTjFI5uAqW
         h8GQ==
X-Gm-Message-State: AJcUukd0Bccr5b6aL+f/dWnnMAFTB7mTU5aCMO6boWiH+o2g6bF66TkI
        dOlYH8DYS+Ow/ykOrRS8wwbpLtDVsLvC6jOfdKDQKQ==
X-Google-Smtp-Source: ALg8bN4P04cNLyFU6m3nlNFR8cQ4b03qLA2SNN1JEclS+GPlAUIGVHG7XzrmGaHfRC0NjIBBrRcZmajIcpnQMCJDjNk=
X-Received: by 2002:a0d:de82:: with SMTP id h124mr7205953ywe.354.1548351135906;
 Thu, 24 Jan 2019 09:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20181129231016.4580-1-colin.king@canonical.com> <CANk1AXRP-65fK48vqQ+Dy9-cz-4XQ1bWNyDCvzJK8rkoA2F24g@mail.gmail.com>
In-Reply-To: <CANk1AXRP-65fK48vqQ+Dy9-cz-4XQ1bWNyDCvzJK8rkoA2F24g@mail.gmail.com>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Thu, 24 Jan 2019 09:22:54 -0800
Message-ID: <CAAtXAHf-_5_aFdkpa5LtnQvy6ddxYwrnXcK9QBkrrP1gkRvLtA@mail.gmail.com>
Subject: Re: [PATCH] fpga: mgr: altera-ps-spi: make array dummy static,
 shrinks object size
To:     Alan Tull <atull@kernel.org>
Cc:     Colin King <colin.king@canonical.com>, linux-fpga@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

sorry dropped of my radar.

On Thu, Jan 24, 2019 at 9:17 AM Alan Tull <atull@kernel.org> wrote:
>
> On Thu, Nov 29, 2018 at 5:10 PM Colin King <colin.king@canonical.com> wrote:
>
> Hi Colin,
>
> Thanks!
>
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Don't populate the const array dummy on the stack but instead
> > make it static. Makes the object code smaller by 26 bytes:
> >
> > Before:
> >    text    data     bss     dec     hex filename
> >    7371    2032       0    9403    24bb drivers/fpga/altera-ps-spi.o
> >
> > After:
> >    text    data     bss     dec     hex filename
> >    7281    2096       0    9377    24a1 drivers/fpga/altera-ps-spi.o
> >
> > (gcc version 8.2.0 x86_64)
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>

>
>
> > ---
> >  drivers/fpga/altera-ps-spi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> > index 8c18beec6b57..678d0115f840 100644
> > --- a/drivers/fpga/altera-ps-spi.c
> > +++ b/drivers/fpga/altera-ps-spi.c
> > @@ -205,7 +205,7 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
> >                                     struct fpga_image_info *info)
> >  {
> >         struct altera_ps_conf *conf = mgr->priv;
> > -       const char dummy[] = {0};
> > +       static const char dummy[] = {0};
> >         int ret;
> >
> >         if (gpiod_get_value_cansleep(conf->status)) {
> > --
> > 2.19.1
> >

Moritz
