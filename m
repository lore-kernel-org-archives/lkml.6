Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BBEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04202085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oLxtLGYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04202085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeKEUqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:46:04 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55268 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeKEUqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:46:04 -0500
Received: by mail-it1-f193.google.com with SMTP id d6so12132279itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 03:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFXZ+eq5GOAou0z4SRE4pcuQ71scjVRSe4k0T+ab+hE=;
        b=oLxtLGYy2olGO8JkIkAL3cnvyykY/lf4j+4PO1r8ufQHt9wdUk552h5i4tbypxhp+0
         lRuwcrwuACpdGKaPFgW215wXTs0qQIkbGiy3MhMQrTEs4Uy23XazZBOvZRuqgIg5oyK6
         /iy9FIobN0Ge0mbTMT1zNVSbk1xov/EHA76Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFXZ+eq5GOAou0z4SRE4pcuQ71scjVRSe4k0T+ab+hE=;
        b=SFBr6Ln3ubJfdnyF0RHgcswFw1sWEDU6j874x7Ab6WOccdjBlEQgmvJi1pbxCVlkFN
         VKmkj/+fMnp6PFjhIJZ8SltMoa/9xDuxXMANt2D5Q6aW5ibXc/jW8m+z38fBS9O3dqOI
         /GxsEo6PdWpOEXR2J79cU9S44LyeiCn0pZBRc/7g3HSRYOqZm9YrDrb5HaRqrBy20kss
         DwpZDTMvvhX8R8inze5/eMbFHxd74K3Wr+8Wd8DuSKTeJNrugO6CXyXXREkRF6AxoXF3
         euc854rLF3SddL2pFHZeQXB+qUDv11B5kZzcX8dYnEpXce5PRrRAPqoJaChIylvvdeXS
         LHDQ==
X-Gm-Message-State: AGRZ1gL7m5KD0Hoh3qa2ZzCBwOJavlk4O6nzjfH7JpZLqPGmIy08M2TY
        IyjgFb0xk503gzIUxSUOjoZZGOUvHKjEOdPiQMFbXQ==
X-Google-Smtp-Source: AJdET5faK+68fm01VdhSO9qJJvLqQG2LeEjrNzwXF2M2VGxtNDWvvcDEYabMwVxlAHkNDjF1ahIum8XbmjqBvR/cfyg=
X-Received: by 2002:a24:7fc8:: with SMTP id r191-v6mr6457256itc.107.1541417208002;
 Mon, 05 Nov 2018 03:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-3-jagan@amarulasolutions.com> <20181105103857.lp7ayw3p6dbthehg@flea>
In-Reply-To: <20181105103857.lp7ayw3p6dbthehg@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 5 Nov 2018 16:56:35 +0530
Message-ID: <CAMty3ZBje8F4YEfWC4qoxADhgdFjbcwZBKJwak633pUAwKAftA@mail.gmail.com>
Subject: Re: [PATCH 02/10] drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 4:09 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sat, Nov 03, 2018 at 03:38:52PM +0530, Jagan Teki wrote:
> > Instruction loop selection would require before writing
> > loop number registers, so enable idle, LP11 bits on
> > loop selection register.
> >
> > Reference code available in BSP
> > (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > (dsi_dev[sel]->dsi_inst_loop_sel.dwval = 2<<(4*DSI_INST_ID_LP11) |
> >       3<<(4*DSI_INST_ID_DLY);
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > index da152c21ec62..077b57ec964c 100644
> > --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> > @@ -397,6 +397,10 @@ static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
> >       struct mipi_dsi_device *device = dsi->device;
> >       u16 delay;
> >
> > +     regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_SEL_REG,
> > +                  DSI_INST_ID_HSC  << (4 * DSI_INST_ID_LP11) |
> > +                  DSI_INST_ID_HSD  << (4 * DSI_INST_ID_DLY));
> > +
>
> Please put this with the other instructions settings below.

Does that mean after computation delay code?
