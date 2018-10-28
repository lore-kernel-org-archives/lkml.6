Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E122C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C3F2082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoWyvj4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C3F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeJ2Dnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 23:43:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42040 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJ2Dnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 23:43:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id b7-v6so5417241edd.9;
        Sun, 28 Oct 2018 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Ol/yCh5vW0P2jx+mszcTuIu8D5BZF52UWqt+o6US0g=;
        b=NoWyvj4H8aGnOB2pAzBqtflq+isGVAhT2d3pnpWELpPMmIZwYt8JNbu9LWRZggC3sA
         L8Kk/D1UHBF9vlOa6encWLYaQDstvYg9TZvEpWkEmpEUcraBb+dSXb6Pn5koetjwuND4
         KiYjTgvjQjkIt8YpuzeoG2ybe1jc1O37ohNvCjQcsp2XMbM5Z42GmesHjc0gHCapzVMS
         xSSOWobVjMH806lXcCNxxvksAfy4EXkfJTVS8b+7iYVlIZG9n4DL7XFJ0F97IRxV5vwc
         LQ2fsvVmbx2H76TGZ/9D++rgUOwsXNljUq8qg8Z9O1wYsbwcDE8cJg/HAuWsv3Zn0GO2
         mzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Ol/yCh5vW0P2jx+mszcTuIu8D5BZF52UWqt+o6US0g=;
        b=nxXYwQzlYOX63D4vTsVG9KMRBU60bXl/8eRyVeDynSmEmafXiiYloXt+9DR9kRgUhx
         r9Kzn64R2QC9w7gA9MRlEgIyAmqnJr35M+I829KMGhkfhdJ5b3LuvP8yWvXzgXwQvc5/
         u99QAweEZp87rdNVro5hGMBpQSvHWweF7LBGLz1idvgDm98V31h7nAYWt2gVKuYa4Qv9
         uicuazm+w80Ln9fvB0+IH1D0XWysWNqvBm4qEBHpj4a+wV3fa58jhwaHdO24Ehif60sp
         nbwjvumgaEYAh1reCN8mC+Cm/Rsh4y874iRs6sOaNhA8ep0ksYyfewNZjqE7duZDlsF9
         N29A==
X-Gm-Message-State: AGRZ1gIdxTbOMIbc4QfpEy2Y0q4phLm7ToC3pnwZN4+fTa9yCEfZCYM0
        vblfh9cpksvTs+duKI3cO55DB8eiCgCFNyyN2uY=
X-Google-Smtp-Source: AJdET5fVUoZAKBcvN6PTJR4wH00sPcJ3GGa+t3JsaIuzUje0dz3OypREuvT9z7BX5wgZ8cYgJ95RuHqWBSVaEznSs8M=
X-Received: by 2002:a50:a48b:: with SMTP id w11-v6mr11027235edb.74.1540753081663;
 Sun, 28 Oct 2018 11:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181022113306.GB2867@w540> <CAHCN7xJkc5RW73C0zruWBgyF7G0J3C5tLE=ZdfxTKbrUqs=-PQ@mail.gmail.com>
 <CAOMZO5ATm4BRzPEQOU+ZD6bHCP2Aqjp4raRYhuc+wNe0t4+C=w@mail.gmail.com>
 <CAHCN7x+csKEk25CF=teUv+F5_GoTe6_3Yqb5PODLn+AmCCm88w@mail.gmail.com>
 <d78877f8-2c23-2bf0-0a9c-cd98b855e95e@mentor.com> <CAHCN7xKhGAXs0jGv96CfOfLQfVubxzsdE9UjpDu+4NM6oLDGWw@mail.gmail.com>
 <bc034299-4a32-f248-d09a-0d1b5872a506@mentor.com> <CAHCN7xKVUgpyCb5k7s0PNXW-efySSwP25ZGMLdbFnohATPwKhg@mail.gmail.com>
 <20181023230259.GA3766@w540> <CAHCN7xJaY_916OLHvaN_q1FwM2vqH5UXzVxLAS4DuEV0icPUXg@mail.gmail.com>
 <20181024140820.GB3766@w540> <CAHCN7xKbAuTmic+L-a2o1NreSCmYBKzzvmHuUTGZtVHELFoirg@mail.gmail.com>
In-Reply-To: <CAHCN7xKbAuTmic+L-a2o1NreSCmYBKzzvmHuUTGZtVHELFoirg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 28 Oct 2018 13:57:50 -0500
Message-ID: <CAHCN7xLP13PDT_VhV_iQzRB+VS7N4AxY+BObtLpz4bJ6RfxfWg@mail.gmail.com>
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
To:     jacopo@jmondi.org
Cc:     steve_longerbeam@mentor.com, Fabio Estevam <festevam@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        p.zabel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        gstreamer-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 9:17 AM Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Oct 24, 2018 at 9:08 AM jacopo mondi <jacopo@jmondi.org> wrote:
> >
> > Hi Adam,
> >
> > On Wed, Oct 24, 2018 at 08:53:41AM -0500, Adam Ford wrote:
> > > On Tue, Oct 23, 2018 at 6:03 PM jacopo mondi <jacopo@jmondi.org> wrote:
> > > >
> > > > Hi Adam,
> > > >
> > > > On Tue, Oct 23, 2018 at 12:54:12PM -0500, Adam Ford wrote:
> > > > > On Tue, Oct 23, 2018 at 12:39 PM Steve Longerbeam
> > > > > <steve_longerbeam@mentor.com> wrote:
> > > > > >
> > > > > >
> > > > > > On 10/23/18 10:34 AM, Adam Ford wrote:
> > > > > > > On Tue, Oct 23, 2018 at 11:36 AM Steve Longerbeam
> > > > > > > <steve_longerbeam@mentor.com> wrote:
> > > > > > >> Hi Adam,
> > > > > > >>
> > > > > > >> On 10/23/18 8:19 AM, Adam Ford wrote:
> > > > > > >>> On Mon, Oct 22, 2018 at 7:40 AM Fabio Estevam <festevam@gmail.com> wrote:
> > > > > > >>>> Hi Adam,
> > > > > > >>>>
> > > > > > >>>> On Mon, Oct 22, 2018 at 9:37 AM Adam Ford <aford173@gmail.com> wrote:
> > > > > > >>>>
> > > > > > >>>>> Thank you!  This tutorial web site is exactly what I need.  The
> > > > > > >>>>> documentation page in Linux touched on the media-ctl links, but it
> > > > > > >>>>> didn't explain the syntax or the mapping.  This graphical
> > > > > > >>>>> interpretation really helps it make more sense.
> > > > > > >>>> Is capturing working well on your i.MX6 board now?
> > > > > > >>> Fabio,
> > > > > > >>>
> > > > > > >>> Unfortunately, no.  I built the rootfs based on Jagan's instructions
> > > > > > >>> at https://openedev.amarulasolutions.com/display/ODWIKI/i.CoreM6+1.5
> > > > > > >>>
> > > > > > >>> I tried building both the 4.15-RC6 kernel, a 4.19 kernel and a 4.14 LTS kernel.
> > > > > > >>>
> > > > > > >>> Using the suggested method of generating the graphical display of the
> > > > > > >>> pipeline options, I am able to enable various pipeline options
> > > > > > >>> connecting different /dev/videoX options tot he camera.  I have tried
> > > > > > >>> both the  suggested method above as well as the instructions found in
> > > > > > >>> Documentation/media/v4l-drivers/imx.rst for their respective kernels,
> > > > > > >>> and I have tried multiple options to capture through
> > > > > > >>> ipu1_csi1_capture, ipu2_csi1_capture, and ip1_ic_prepenc capture, and
> > > > > > >>> all yield a broken pipe.
> > > > > > >>>
> > > > > > >>> libv4l2: error turning on stream: Broken pipe
> > > > > > >>> ERROR: from element /GstPipeline:pipeline0/GstV4l2Src:v4l2src0: Could
> > > > > > >>> not read from resource.
> > > > > > >>> Additional debug info:
> > > > > > >>> gstv4l2bufferpool.c(1064): gst_v4l2_buffer_pool_poll ():
> > > > > > >>> /GstPipeline:pipeline0/GstV4l2Src:v4l2src0:
> > > > > > >>> poll error 1: Broken pipe (32)
> > > > > > >>>
> > > > > > >>> I can hear the camera click when I start gstreamer and click again
> > > > > > >>> when it stops trying to stream.
> > > > > > >>>
> > > > > > >>> dmesg indicates a broken pipe as well..
> > > > > > >>>
> > > > > > >>> [ 2419.851502] ipu2_csi1: pipeline start failed with -32
> > > > > > >>>
> > > > > > >>> might you have any suggestions?
> > > > > > >>
> > > > > > >> This -EPIPE error might mean you have a mis-match of resolution, pixel
> > > > > > >> format, or field type between one of the source->sink pad links. You can
> > > > > > >> find out which pads have a mis-match by enabling dynamic debug in the
> > > > > > >> kernel function __media_pipeline_start.
> > > > > > > Following Jagan's suggestion, I tried to make sure all the resolution
> > > > > > > and pixel formats were set the same between each source and sink.
> > > > > > >
> > > > > > > media-ctl --set-v4l2 "'ov5640 2-0010':0[fmt:UYVY2X8/640x480
> > > > > > > field:none]"
> > > > > > > media-ctl --set-v4l2 "'imx6-mipi-csi2':1[fmt:UYVY2X8/640x480
> > > > > > > field:none]"
> > > > > > > media-ctl --set-v4l2 "'ipu1_csi0_mux':2[fmt:UYVY2X8/640x480
> > > > > > > field:none]"
> > > > > > > media-ctl --set-v4l2 "'ipu1_csi0':2[fmt:AYUV32/640x480 field:none]"
> > > > > > >
> > > > > > >> Also make sure you are attempting to stream from the correct /dev/videoN.
> > > > > > > I have graphically plotted the pipeline using media-ctl --print-dot
> > > > > > > and I can see the proper video is routed, but your dynamic debug
> > > > > > > suggestion yielded something:
> > > > > > >
> > > > > > >     imx-media capture-subsystem: link validation failed for 'ov5640
> > > > > > > 2-0010':0 -> 'imx6-mipi-csi2':0, error -32
> > > > > >
> > > > > >
> > > > > > It's what I expected, you have a format mismatch between those pads.
> > > > >
> > > > > Is the mismatch something I am doing wrong with:
> > > > >
> > > > > media-ctl --set-v4l2 "'ov5640 2-0010':0[fmt:UYVY2X8/640x480 field:none]"
> > > > > media-ctl --set-v4l2 "'imx6-mipi-csi2':2[fmt:UYVY2X8/640x480 field:none]"
> > > > >
> > > >
> > > > Could you try to verify the actual format configured on the sensor?
> > > > (media-ctl --get-v4l2 "'ov5640 2-0010':0").
> > > >
> > > > Depending on the driver version you are running, you might be affected
> > > > by different regressions.
> > > >
> > > > > or is there something else I need to do?  I just used Jagan's suggestion.
> > > >
> > > > I suggest you to update the driver version to the last one available
> > > > in the media-tree master, or at least try to backport the following
> > > > commit:
> > > > fb98e29 media: ov5640: fix mode change regression
> > > >
> > > > If it turns out the format and mode configured on the sensor do not
> > > > match the one you want.
> > > >
> > > > Thanks
> > >
> > > That got me past one hurdle.   Wtih your help, I was able to confirm
> > > the mis-match of the modes between the sensor and the csi1 source.  I
> > > applied the patch as you suggested, but now I get a new error.
> > >
> > > [  295.294370] imx6-mipi-csi2: LP-11 timeout, phy_state = 0x00000230
> > > [  295.300681] ipu1_csi0: pipeline start failed with -110
> > >
> > >
> >
> > Here you go:
> > bad1774 media: ov5640: Fix timings setup code
> > aa4bb8b media: ov5640: Re-work MIPI startup sequence
> >
> > Please update your ov5640 driver to the last version available on
> > linux-media master repository. There have been a looot of developments
> > and fixes recently (and I would be happy to know if they have helped
> > you)
> >
> > > I am going to go through various patches to the imx framework and
> > > ov5640 driver to see if I can find the solution,  but if you have
> > > suggestions as to which fixes are appropriate, I'll test those.  If I
> >
> > Just get what's on linux-media master tree.
> >
> > > can get this working, would it make sense for me to submit some
> > > requests with kernel-stable to backport some of these commits to 4.19
> > > and if applicable, 4.14 too?
> >
> > Sure it will (even if I'm not familiar with the procedure used to tag
> > patches to be applied to stable. I would just apply everything that's
> > on the latest media tree)
> >
> > Keep us posted!
>
> Thank you everyone for your help.  I pulled the linux-media master and
> built it, and it works perfectly from what I can tell. I'll go through
> the patch list and see what's back-port-able to 4.19.  I noticed that
> just copying the ov5640.c driver breaks the build on 4.19.0, so I'm
> going to focus on just patches labeled 'fix' on both the ov5640 for
> now.
>
> I appreciate everyone's help, and Iearned a lot about the v4l system
> in the process.
>

Does anyone know when the media branch get's merged into the mainline
kernel?  I assume we're in the merge window with 4.19 just having been
released.  Once these have been merged into the mainline, I'll go
through and start requesting they get pulled into 4.19 and/or 4.14
if/when appropriate.

adam


> adam
>
> >    j
> > >
> > > adam
> > > >    j
> > > >
> > > > > adam
> > > > > >
> > > > > > Steve
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > I am assume this means the interface between the camera and the csi2
> > > > > > > isn't working.  I am going to double check the power rails and the
> > > > > > > clocks.  i can hear it click when activated and deactivated, so
> > > > > > > something is happening.
> > > > > > >
> > > > > > > adam
> > > > > > >
> > > > > > >> Steve
> > > > > > >>
