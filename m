Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BF8C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1178A20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5lXukOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1178A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeJXCSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:18:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37768 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJXCSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:18:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id c15-v6so2501835eds.4;
        Tue, 23 Oct 2018 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ErsB+6IR1SWwDDy613nt4Yc7Ycc7aus+5inqh8gqsck=;
        b=u5lXukOaLnGp7bXuRP32tMYrK6i4QhvBpYMAZqBAdljky0+veLZ+oSqX++qF7+LhOM
         caVxenNeQXI47a500iXhQbK60VO7Zd+B1JZj02QKYh0apdVm36Gn3OgsJd3DCIGNtAhl
         GzU7mSsch4rDmI0GkHNqWerCVbqJwJUgt1A73PTODf3oJuVucXAeSTDqobGHd3qCI8v1
         gniP3VU0tliiOv42wl+qh2b+RC6tQXR/CxO+5ZIEP+NgsKCpew9APlxd3adLsw4MvB/c
         J05jph878LOql88Dgz2RnTOeGXxHMt0UPe32ajgBqfmBKpAtO3/WvlwxxBuoFqPCYNfH
         quxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErsB+6IR1SWwDDy613nt4Yc7Ycc7aus+5inqh8gqsck=;
        b=RfxIqHihDgu+QUibEu8InoGtMLzsvLot78Q+BdU6ErviNJwl1n11uyIVSZulEhwRkp
         EITg3ZTZ6EyxFrdWIt+1FsLfjS3a0YGmAkt5XrAA+Wgk6aqG8xog8hhX4aLcmFO26CuO
         R2r9EE6MilT0cZkb2c1W2Lb+1atT8Uhx2N0nNo7G+UWn1OyyWrIJWwzhy2Dageiwvdlg
         uzULTX9/FcjHTnoBVLzQT/nEQIGZhtWcO8ASZABGttS6G/hA9m5YbxT738lKHXsnswVy
         Fy8721CsFefRBgwthj1Py0oey+XBuH7yLV9swSt96m3GBTUl3L3E8vnUWKOR6i1xlpsf
         evLA==
X-Gm-Message-State: ABuFfogS4Av3n9bNrzCwGpzm6sWRkiH+9N7VB/HGjdDtn8qZQ9paC8nP
        rskvRb0e1TUei9UVIA0iutLvgq13aTtEGevWd5J4neKU
X-Google-Smtp-Source: ACcGV61eWZ4U7FZPH4muV8VIajFToNcqQOXTsIIwTeqWM2OAhxuSgi1AMmrc98fmdO2ASklUBnPeHe9SlRAT4d38S70=
X-Received: by 2002:a50:b68b:: with SMTP id d11-v6mr16883474ede.283.1540317264042;
 Tue, 23 Oct 2018 10:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180920145658.GE16851@w540> <CAHCN7x+U=Y=-v1UP5UYvY8WtUFRJGjmx=nawTuE=YcHdm_DYvA@mail.gmail.com>
 <c1cb34b0-b715-cf08-6f75-2842f1090c5d@mentor.com> <20181017080103.GD11703@w540>
 <CAHCN7xLx6uAmYiGh3p=piZFwE0VkfixTLqdjETibKwk2+DhMzA@mail.gmail.com>
 <CAHCN7xJKuPYg04WfRzbYWO4bGoHHnD16LBPRsK1QsiYY1bL7nA@mail.gmail.com>
 <20181022113306.GB2867@w540> <CAHCN7xJkc5RW73C0zruWBgyF7G0J3C5tLE=ZdfxTKbrUqs=-PQ@mail.gmail.com>
 <CAOMZO5ATm4BRzPEQOU+ZD6bHCP2Aqjp4raRYhuc+wNe0t4+C=w@mail.gmail.com>
 <CAHCN7x+csKEk25CF=teUv+F5_GoTe6_3Yqb5PODLn+AmCCm88w@mail.gmail.com>
 <d78877f8-2c23-2bf0-0a9c-cd98b855e95e@mentor.com> <CAHCN7xKhGAXs0jGv96CfOfLQfVubxzsdE9UjpDu+4NM6oLDGWw@mail.gmail.com>
 <bc034299-4a32-f248-d09a-0d1b5872a506@mentor.com>
In-Reply-To: <bc034299-4a32-f248-d09a-0d1b5872a506@mentor.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 23 Oct 2018 12:54:12 -0500
Message-ID: <CAHCN7xKVUgpyCb5k7s0PNXW-efySSwP25ZGMLdbFnohATPwKhg@mail.gmail.com>
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

On Tue, Oct 23, 2018 at 12:39 PM Steve Longerbeam
<steve_longerbeam@mentor.com> wrote:
>
>
> On 10/23/18 10:34 AM, Adam Ford wrote:
> > On Tue, Oct 23, 2018 at 11:36 AM Steve Longerbeam
> > <steve_longerbeam@mentor.com> wrote:
> >> Hi Adam,
> >>
> >> On 10/23/18 8:19 AM, Adam Ford wrote:
> >>> On Mon, Oct 22, 2018 at 7:40 AM Fabio Estevam <festevam@gmail.com> wrote:
> >>>> Hi Adam,
> >>>>
> >>>> On Mon, Oct 22, 2018 at 9:37 AM Adam Ford <aford173@gmail.com> wrote:
> >>>>
> >>>>> Thank you!  This tutorial web site is exactly what I need.  The
> >>>>> documentation page in Linux touched on the media-ctl links, but it
> >>>>> didn't explain the syntax or the mapping.  This graphical
> >>>>> interpretation really helps it make more sense.
> >>>> Is capturing working well on your i.MX6 board now?
> >>> Fabio,
> >>>
> >>> Unfortunately, no.  I built the rootfs based on Jagan's instructions
> >>> at https://openedev.amarulasolutions.com/display/ODWIKI/i.CoreM6+1.5
> >>>
> >>> I tried building both the 4.15-RC6 kernel, a 4.19 kernel and a 4.14 LTS kernel.
> >>>
> >>> Using the suggested method of generating the graphical display of the
> >>> pipeline options, I am able to enable various pipeline options
> >>> connecting different /dev/videoX options tot he camera.  I have tried
> >>> both the  suggested method above as well as the instructions found in
> >>> Documentation/media/v4l-drivers/imx.rst for their respective kernels,
> >>> and I have tried multiple options to capture through
> >>> ipu1_csi1_capture, ipu2_csi1_capture, and ip1_ic_prepenc capture, and
> >>> all yield a broken pipe.
> >>>
> >>> libv4l2: error turning on stream: Broken pipe
> >>> ERROR: from element /GstPipeline:pipeline0/GstV4l2Src:v4l2src0: Could
> >>> not read from resource.
> >>> Additional debug info:
> >>> gstv4l2bufferpool.c(1064): gst_v4l2_buffer_pool_poll ():
> >>> /GstPipeline:pipeline0/GstV4l2Src:v4l2src0:
> >>> poll error 1: Broken pipe (32)
> >>>
> >>> I can hear the camera click when I start gstreamer and click again
> >>> when it stops trying to stream.
> >>>
> >>> dmesg indicates a broken pipe as well..
> >>>
> >>> [ 2419.851502] ipu2_csi1: pipeline start failed with -32
> >>>
> >>> might you have any suggestions?
> >>
> >> This -EPIPE error might mean you have a mis-match of resolution, pixel
> >> format, or field type between one of the source->sink pad links. You can
> >> find out which pads have a mis-match by enabling dynamic debug in the
> >> kernel function __media_pipeline_start.
> > Following Jagan's suggestion, I tried to make sure all the resolution
> > and pixel formats were set the same between each source and sink.
> >
> > media-ctl --set-v4l2 "'ov5640 2-0010':0[fmt:UYVY2X8/640x480
> > field:none]"
> > media-ctl --set-v4l2 "'imx6-mipi-csi2':1[fmt:UYVY2X8/640x480
> > field:none]"
> > media-ctl --set-v4l2 "'ipu1_csi0_mux':2[fmt:UYVY2X8/640x480
> > field:none]"
> > media-ctl --set-v4l2 "'ipu1_csi0':2[fmt:AYUV32/640x480 field:none]"
> >
> >> Also make sure you are attempting to stream from the correct /dev/videoN.
> > I have graphically plotted the pipeline using media-ctl --print-dot
> > and I can see the proper video is routed, but your dynamic debug
> > suggestion yielded something:
> >
> >     imx-media capture-subsystem: link validation failed for 'ov5640
> > 2-0010':0 -> 'imx6-mipi-csi2':0, error -32
>
>
> It's what I expected, you have a format mismatch between those pads.

Is the mismatch something I am doing wrong with:

media-ctl --set-v4l2 "'ov5640 2-0010':0[fmt:UYVY2X8/640x480 field:none]"
media-ctl --set-v4l2 "'imx6-mipi-csi2':2[fmt:UYVY2X8/640x480 field:none]"

or is there something else I need to do?  I just used Jagan's suggestion.

adam
>
> Steve
>
>
> >
> > I am assume this means the interface between the camera and the csi2
> > isn't working.  I am going to double check the power rails and the
> > clocks.  i can hear it click when activated and deactivated, so
> > something is happening.
> >
> > adam
> >
> >> Steve
> >>
