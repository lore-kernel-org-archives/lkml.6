Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC4AC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776AF2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776AF2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJXQuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:50:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60653 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJXQux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:50:53 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gFES7-000830-RK; Wed, 24 Oct 2018 10:23:43 +0200
Message-ID: <896bdd27a559a7c9508524f9b618d480d392bf46.camel@pengutronix.de>
Subject: Re: [PATCH v1 1/2] drm: Add missing flags for pixel clock & data
 enable
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     sean@poorly.run, Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Philippe Cornu <philippe.cornu@st.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Vincent Abriou <vincent.abriou@st.com>
Date:   Wed, 24 Oct 2018 10:23:40 +0200
In-Reply-To: <20181024081658.GD324@phenom.ffwll.local>
References: <1537788981-21479-1-git-send-email-yannick.fertre@st.com>
         <1537788981-21479-2-git-send-email-yannick.fertre@st.com>
         <CA+M3ks4L_Cs_GB2sxg1XyygLz79eH7d+JcgLULM3fFN0U=YCZw@mail.gmail.com>
         <CA+M3ks5HWuUXHdKePT0MAU9G=4YkUdJZBXBasVW_X1A2YTSSoA@mail.gmail.com>
         <20181024081658.GD324@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 24.10.2018, 10:16 +0200 schrieb Daniel Vetter:
> On Tue, Oct 23, 2018 at 04:50:19PM +0200, Benjamin Gaignard wrote:
> > Le lun. 15 oct. 2018 à 13:15, Benjamin Gaignard
> > <benjamin.gaignard@linaro.org> a écrit :
> > > 
> > > Le lun. 24 sept. 2018 à 13:59, Yannick Fertré <yannick.fertre@st.com> a écrit :
> > > > 
> > > > Add missing flags for pixel clock & data enable polarities.
> > > > These flags are similar to other synchronization signals (hsync, vsync...).
> > > > 
> > > > Signed-off-by: Yannick Fertré <yannick.fertre@st.com>
> > > 
> > > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > 
> > Dave or Daniel could you give us your PoV on this patch ?
> 
> Does it work? Iirc we had some userspace chocking on new mode flags, and
> needed explicit opt-in. If that looks good (check weston, -modesetting and
> drm_hwc, that should have you covered I hope) then has my ack.

What's the use of exposing those to userspace? There are a number of
drivers that already have to deal with this and they are totally fine
with keeping this information internal to the driver.

For reference see include/video/display_timing.h, specifically the enum
display_flags.

Regards,
Lucas

> -Daniel
> 
> > Thanks
> > 
> > > 
> > > > ---
> > > >  drivers/gpu/drm/drm_modes.c | 19 ++++++++++++++++++-
> > > >  include/uapi/drm/drm_mode.h |  6 ++++++
> > > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> > > > index 02db9ac..596f8b3 100644
> > > > --- a/drivers/gpu/drm/drm_modes.c
> > > > +++ b/drivers/gpu/drm/drm_modes.c
> > > > @@ -130,7 +130,7 @@ EXPORT_SYMBOL(drm_mode_probed_add);
> > > >   * according to the hdisplay, vdisplay, vrefresh.
> > > >   * It is based from the VESA(TM) Coordinated Video Timing Generator by
> > > >   * Graham Loveridge April 9, 2003 available at
> > > > - * http://www.elo.utfsm.cl/~elo212/docs/CVTd6r1.xls
> > > > + * http://www.elo.utfsm.cl/~elo212/docs/CVTd6r1.xls
> > > >   *
> > > >   * And it is copied from xf86CVTmode in xserver/hw/xfree86/modes/xf86cvt.c.
> > > >   * What I have done is to translate it by using integer calculation.
> > > > @@ -611,6 +611,15 @@ void drm_display_mode_from_videomode(const struct videomode *vm,
> > > >                 dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
> > > >         if (vm->flags & DISPLAY_FLAGS_DOUBLECLK)
> > > >                 dmode->flags |= DRM_MODE_FLAG_DBLCLK;
> > > > +       if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> > > > +               dmode->flags |= DRM_MODE_FLAG_PPIXCLK;
> > > > +       else if (vm->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> > > > +               dmode->flags |= DRM_MODE_FLAG_NPIXCLK;
> > > > +       if (vm->flags & DISPLAY_FLAGS_DE_HIGH)
> > > > +               dmode->flags |= DRM_MODE_FLAG_PDATAEN;
> > > > +       else if (vm->flags & DISPLAY_FLAGS_DE_LOW)
> > > > +               dmode->flags |= DRM_MODE_FLAG_NDE;
> > > > +
> > > >         drm_mode_set_name(dmode);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(drm_display_mode_from_videomode);
> > > > @@ -652,6 +661,14 @@ void drm_display_mode_to_videomode(const struct drm_display_mode *dmode,
> > > >                 vm->flags |= DISPLAY_FLAGS_DOUBLESCAN;
> > > >         if (dmode->flags & DRM_MODE_FLAG_DBLCLK)
> > > >                 vm->flags |= DISPLAY_FLAGS_DOUBLECLK;
> > > > +       if (dmode->flags & DRM_MODE_FLAG_PPIXDATA)
> > > > +               vm->flags |= DISPLAY_FLAGS_PIXDATA_POSEDGE;
> > > > +       else if (dmode->flags & DRM_MODE_FLAG_NPIXDATA)
> > > > +               vm->flags |= DISPLAY_FLAGS_PIXDATA_NEGEDGE;
> > > > +       if (dmode->flags & DRM_MODE_FLAG_PDE)
> > > > +               vm->flags |= DISPLAY_FLAGS_DE_HIGH;
> > > > +       else if (dmode->flags & DRM_MODE_FLAG_NDE)
> > > > +               vm->flags |= DISPLAY_FLAGS_DE_LOW;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(drm_display_mode_to_videomode);
> > > > 
> > > > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> > > > index d3e0fe3..b335a17 100644
> > > > --- a/include/uapi/drm/drm_mode.h
> > > > +++ b/include/uapi/drm/drm_mode.h
> > > > @@ -89,6 +89,12 @@ extern "C" {
> > > >  #define  DRM_MODE_FLAG_3D_TOP_AND_BOTTOM       (7<<14)
> > > >  #define  DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF    (8<<14)
> > > > 
> > > > +/* flags for polarity clock & data enable polarities */
> > > > +#define DRM_MODE_FLAG_PPIXDATA                 (1 << 19)
> > > > +#define DRM_MODE_FLAG_NPIXDATA                 (1 << 20)
> > > > +#define DRM_MODE_FLAG_PDE                      (1 << 21)
> > > > +#define DRM_MODE_FLAG_NDE                      (1 << 22)
> > > > +
> > > >  /* Picture aspect ratio options */
> > > >  #define DRM_MODE_PICTURE_ASPECT_NONE           0
> > > >  #define DRM_MODE_PICTURE_ASPECT_4_3            1
> > > > --
> > > > 2.7.4
> > > > 
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > 
> > 
> > -- 
> > Benjamin Gaignard
> > 
> > Graphic Study Group
> > 
> > Linaro.org │ Open source software for ARM SoCs
> > 
> > Follow Linaro: Facebook | Twitter | Blog
> 
> 

