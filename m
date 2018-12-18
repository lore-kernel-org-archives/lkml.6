Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105DBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91AE21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bOXKUD+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeLRPoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:44:17 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38628 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeLRPoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:44:17 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so13098869ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/zhACGiqYxD973F16CJgW7lHQ7NOo+F2AGOaW1Tmr0=;
        b=bOXKUD+ium5IZD/ej6gBo6AoeyCaxHe8W9E5ZCZ9r7rduXf5QJjE0bAwXxg5B+JEfK
         WS01OpHBsjkNblLxpp6gAfnuzn6KtYTbtpH0ctGniiWx9TjXXVTgeEuZn9Iu+P9Xowri
         3MGz/BfMlSZXAHytSqm5GvouhhTxIq6b0pQV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/zhACGiqYxD973F16CJgW7lHQ7NOo+F2AGOaW1Tmr0=;
        b=RUronwX2CVcFvdp9rhIPVK3szLiynKruxg55Y1GdHr9Ubmlrx9YaWBmPtz4+BeQth0
         Ules4phsgBRGZqxmgcAwT4/MkIfDwdgW8QrydlrWtPGt2n1p1q+GclgqwJUmezJXKKDX
         ECAR9qTlbF9SY3eTRDgrzRIyGkutu6u99FN0xsz1blRXPpQHX30MKlYRUoIQYf/Ewprx
         4h72igpBcazMc2jVUwcApsKgKLqlIAdkZifxdu+nwHT7hRDAReHKkoKKhE3Dx8pphx0Q
         1ADaw8CgCx/hkcY43WCHHOcRnOq1jYBqeO5ifWswtHeKoOxI7bTHV+DEuwIzXEi3fArU
         vuHw==
X-Gm-Message-State: AA+aEWaca/rRgzEE6zaFW5kfLQiwS0+DUXzj5vTd98N6AhQC7zYw8pSz
        orVMkc5SMaNxRbnxmQA9GeUkKAPCK7EJvqpQDB3bTw==
X-Google-Smtp-Source: AFSGD/Vw0JOZ8RKR8b2+LlUMZj0hoUL5Xw8rRsU9Uzbab7HLMC2KsHzEDHMZE7NyQ0gEePst9K8pHK0stt+GL7m2nTU=
X-Received: by 2002:a5e:c609:: with SMTP id f9mr13929097iok.114.1545147508734;
 Tue, 18 Dec 2018 07:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
 <20181218113320.4856-4-jagan@amarulasolutions.com> <20181218152318.duynff7f5m2gxtv4@flea>
In-Reply-To: <20181218152318.duynff7f5m2gxtv4@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 18 Dec 2018 21:08:17 +0530
Message-ID: <CAMty3ZCS+QT_YqbJueR-qeityaDxNbQ7p_d3D6bNATSJLQpRnQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] media: sun6i: Update default CSI_SCLK for A64
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 8:53 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Dec 18, 2018 at 05:03:17PM +0530, Jagan Teki wrote:
> > Unfortunately A64 CSI cannot work with default CSI_SCLK rate.
> >
> > A64 BSP is using 300MHz clock rate as default csi clock,
> > so sun6i_csi require explicit change to update CSI_SCLK
> > rate to 300MHZ for A64 SoC's.
> >
> > So, set the clk_mod to 300MHz only for A64.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > index 9ff61896e4bb..91470edf7581 100644
> > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > @@ -822,6 +822,11 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
> >               return PTR_ERR(sdev->clk_mod);
> >       }
> >
> > +     /* A64 require 300MHz mod clock to operate properly */
> > +     if (of_device_is_compatible(pdev->dev.of_node,
> > +                                 "allwinner,sun50i-a64-csi"))
> > +             clk_set_rate_exclusive(sdev->clk_mod, 300000000);
> > +
>
> If you're using clk_set_rate_exclusive, you need to put back the
> "exclusive" reference once you're not using the clock.
>
> Doing it here is not really optimal either, since you'll put a
> constraint on the system (maintaining that clock at 300MHz), while
> it's not in use.

I think we can handle via clk_rate_exclusive_put for those errors
cases? If I'm not wrong
