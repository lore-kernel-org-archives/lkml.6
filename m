Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD62C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1142075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2LN5s1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1142075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeJXB70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:59:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36945 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeJXB70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:59:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id c15-v6so2446363eds.4;
        Tue, 23 Oct 2018 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZQ/betMQwwlwT9kqi3wj89N7Y5+ixDZtRHUXvc0Qg8=;
        b=A2LN5s1JUlGcuOt7Ehi9K86V3FrQxFNbC5853uPoOJjm0iovw03fJqnBz9eDM8RB59
         xcU9nkfQh6mlx/HEBIm0TaP+hsNx2S2eZ9p9g1H0LnduRf1z3uUAszS3KwRgsfVoec9t
         RnLvRzmN8GuJGoV8NVUy1XMmQw+TnJNHLsVSQaMfn1kI0ZLMuF3tW9yui4eNb8DS6oyf
         autuylySKgQuO1winYcUxyMExLsx+HB5TrS3S4nq1nbRmLiCiSwLk0+3y+Zf988hcBS+
         mclNY13waOROSkfnStKuIXeTgJ8LfzJh6Ys7FUyFQ+FI+7F+GITR2FtRq/yd1nLlVkoq
         zmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZQ/betMQwwlwT9kqi3wj89N7Y5+ixDZtRHUXvc0Qg8=;
        b=B2zai+q6pLghxlDs/UzjkH0U64COy0HCX92RApMQy/Gyx/V0YeZlznRljqYQL7+mZB
         cSsFPA3gIDDYuRyDxg0sDB/89fPqj7HkO8QBl1vaUSvRy2VvezpTqdyBEkROhP9x88A2
         M7v9MeY4RcNoxflegzmVWwwwsDikqFZRjjzjRYQfaMJEI6F5Adh9B/iLpwCtD+wnfZwg
         WUE0L21abRciWZ5jwFl8wqg8anjf5i444v2wFkXR3zeQSKIepfexkEtMdNsl3bV4POJy
         h5Pyk1SuvSELTzLnnR3F0L1XyaoVjinNkWtGD0vsPeV3FB/oKWpznRd0OGrXBPP6NOUx
         xfeA==
X-Gm-Message-State: ABuFfojVOCVyBiSmUUPBDFO7bUpc7JZNYiSUfPpinzLZ3rppeBCngOeC
        IJt8XYi1O4NDiblg8O5AWR2d72A8k5R8JCLPi8k=
X-Google-Smtp-Source: ACcGV61zwZ5zfwlWto1SgC6P5EWhXfl02tb9fy7kGBxQRROgMH6Rq16x3kOvC2oEJZZaR0AXPU99LpYpn36NVcGfj0o=
X-Received: by 2002:aa7:c998:: with SMTP id c24-v6mr17066840edt.165.1540316104936;
 Tue, 23 Oct 2018 10:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180920145658.GE16851@w540> <CAHCN7x+U=Y=-v1UP5UYvY8WtUFRJGjmx=nawTuE=YcHdm_DYvA@mail.gmail.com>
 <c1cb34b0-b715-cf08-6f75-2842f1090c5d@mentor.com> <20181017080103.GD11703@w540>
 <CAHCN7xLx6uAmYiGh3p=piZFwE0VkfixTLqdjETibKwk2+DhMzA@mail.gmail.com>
 <CAHCN7xJKuPYg04WfRzbYWO4bGoHHnD16LBPRsK1QsiYY1bL7nA@mail.gmail.com>
 <20181022113306.GB2867@w540> <CAHCN7xJkc5RW73C0zruWBgyF7G0J3C5tLE=ZdfxTKbrUqs=-PQ@mail.gmail.com>
 <CAOMZO5ATm4BRzPEQOU+ZD6bHCP2Aqjp4raRYhuc+wNe0t4+C=w@mail.gmail.com>
 <CAHCN7x+csKEk25CF=teUv+F5_GoTe6_3Yqb5PODLn+AmCCm88w@mail.gmail.com> <d78877f8-2c23-2bf0-0a9c-cd98b855e95e@mentor.com>
In-Reply-To: <d78877f8-2c23-2bf0-0a9c-cd98b855e95e@mentor.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 23 Oct 2018 12:34:53 -0500
Message-ID: <CAHCN7xKhGAXs0jGv96CfOfLQfVubxzsdE9UjpDu+4NM6oLDGWw@mail.gmail.com>
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
To:     steve_longerbeam@mentor.com
Cc:     Fabio Estevam <festevam@gmail.com>, jacopo@jmondi.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        p.zabel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        gstreamer-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:36 AM Steve Longerbeam
<steve_longerbeam@mentor.com> wrote:
>
> Hi Adam,
>
> On 10/23/18 8:19 AM, Adam Ford wrote:
> > On Mon, Oct 22, 2018 at 7:40 AM Fabio Estevam <festevam@gmail.com> wrote:
> >> Hi Adam,
> >>
> >> On Mon, Oct 22, 2018 at 9:37 AM Adam Ford <aford173@gmail.com> wrote:
> >>
> >>> Thank you!  This tutorial web site is exactly what I need.  The
> >>> documentation page in Linux touched on the media-ctl links, but it
> >>> didn't explain the syntax or the mapping.  This graphical
> >>> interpretation really helps it make more sense.
> >> Is capturing working well on your i.MX6 board now?
> > Fabio,
> >
> > Unfortunately, no.  I built the rootfs based on Jagan's instructions
> > at https://openedev.amarulasolutions.com/display/ODWIKI/i.CoreM6+1.5
> >
> > I tried building both the 4.15-RC6 kernel, a 4.19 kernel and a 4.14 LTS kernel.
> >
> > Using the suggested method of generating the graphical display of the
> > pipeline options, I am able to enable various pipeline options
> > connecting different /dev/videoX options tot he camera.  I have tried
> > both the  suggested method above as well as the instructions found in
> > Documentation/media/v4l-drivers/imx.rst for their respective kernels,
> > and I have tried multiple options to capture through
> > ipu1_csi1_capture, ipu2_csi1_capture, and ip1_ic_prepenc capture, and
> > all yield a broken pipe.
> >
> > libv4l2: error turning on stream: Broken pipe
> > ERROR: from element /GstPipeline:pipeline0/GstV4l2Src:v4l2src0: Could
> > not read from resource.
> > Additional debug info:
> > gstv4l2bufferpool.c(1064): gst_v4l2_buffer_pool_poll ():
> > /GstPipeline:pipeline0/GstV4l2Src:v4l2src0:
> > poll error 1: Broken pipe (32)
> >
> > I can hear the camera click when I start gstreamer and click again
> > when it stops trying to stream.
> >
> > dmesg indicates a broken pipe as well..
> >
> > [ 2419.851502] ipu2_csi1: pipeline start failed with -32
> >
> > might you have any suggestions?
>
>
> This -EPIPE error might mean you have a mis-match of resolution, pixel
> format, or field type between one of the source->sink pad links. You can
> find out which pads have a mis-match by enabling dynamic debug in the
> kernel function __media_pipeline_start.

Following Jagan's suggestion, I tried to make sure all the resolution
and pixel formats were set the same between each source and sink.

media-ctl --set-v4l2 "'ov5640 2-0010':0[fmt:UYVY2X8/640x480
field:none]"
media-ctl --set-v4l2 "'imx6-mipi-csi2':1[fmt:UYVY2X8/640x480
field:none]"
media-ctl --set-v4l2 "'ipu1_csi0_mux':2[fmt:UYVY2X8/640x480
field:none]"
media-ctl --set-v4l2 "'ipu1_csi0':2[fmt:AYUV32/640x480 field:none]"

>
> Also make sure you are attempting to stream from the correct /dev/videoN.

I have graphically plotted the pipeline using media-ctl --print-dot
and I can see the proper video is routed, but your dynamic debug
suggestion yielded something:

   imx-media capture-subsystem: link validation failed for 'ov5640
2-0010':0 -> 'imx6-mipi-csi2':0, error -32

I am assume this means the interface between the camera and the csi2
isn't working.  I am going to double check the power rails and the
clocks.  i can hear it click when activated and deactivated, so
something is happening.

adam

>
> Steve
>
