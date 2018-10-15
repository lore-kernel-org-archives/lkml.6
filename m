Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822A4C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E73205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUek/sW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E73205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeJOTAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:00:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42624 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOTA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:00:29 -0400
Received: by mail-oi1-f196.google.com with SMTP id w81-v6so14737154oiw.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 04:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0tkuA4r59xBabE0gBnMMO9F/scbcvLeUuQCWSHtN004=;
        b=MUek/sW77MsS6X4HZoqf3xSR3ovm6kT1FCz3a+kWtCkcmFg9yFve6yMXuyhczu34Rl
         FezqjmSd1rDPHPOZT1HGArDcjpiotwQg9v3VC1ynjCwb1dPZ5j4UEBkwMI/TOGF/mRGy
         apkRUcswFeSGq/kHcJveootGn6DeqXGgQSprQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0tkuA4r59xBabE0gBnMMO9F/scbcvLeUuQCWSHtN004=;
        b=qmVmWXqHE6VJdLC9x0nBc3WS0NB2rqtF+HqnfFh3woNuN0KO8FGILarw1DkAgaDN1C
         7EPrqge1B0tzrADQmeQK4rRfsYdaHM1ODs2m+ueTXMdPpWQy4+tKOoHYpME/b768noyX
         B8/5RolFNXXbpD1miyn0vvQVfL8FeLnAZQr3jOHy66mW0Dzpvz/lEgKgWrYjJCTQ1aka
         4m33v4Y4wbFxYHvyH9DeQNlQxVyWPLJVgQbnetmBZB3KLKNoJuf8vxlAjGhnV9WX8pPP
         wUGLzqnM3TlMO8qPi1bvsH2gUn5CUTbqMzY1mfkAEYu+EzXVSvat8RZ3p4tpjPsKgnwX
         etwg==
X-Gm-Message-State: ABuFfohQhn+1m0ysSLvSKbyDW5G5eZBL3U6lkPAQ8X34k3oC1VwXTGdK
        +cHRZ9wf/gNGimx8Ous8in0TGrFgY18SS2SWCoqKdQ==
X-Google-Smtp-Source: ACcGV60Rh03uHQTAY717xhaLI0qip7V8vdO4m6KX+3qY3ImfrE1duMJS3uYyEliwcGh1l7VkFNNG4fQWI6mH7qwPppI=
X-Received: by 2002:aca:ba89:: with SMTP id k131-v6mr8374599oif.226.1539602141399;
 Mon, 15 Oct 2018 04:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <1537788981-21479-1-git-send-email-yannick.fertre@st.com> <1537788981-21479-3-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1537788981-21479-3-git-send-email-yannick.fertre@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 15 Oct 2018 13:15:30 +0200
Message-ID: <CA+M3ks4GR5tw_YDTjWNO7mwUx5BhuBsc=5_dzNNMCYnGO08X+Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/stm: ltdc: Solve issue on pixel clock & data
 enable polarity
To:     Yannick Fertre <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        sean@poorly.run, David Airlie <airlied@linux.ie>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 24 sept. 2018 =C3=A0 14:05, Yannick Fertr=C3=A9 <yannick.fertre@st.=
com> a =C3=A9crit :
>
> Wrong flags used for set the pixel clock & data enable polarities.
> Add trace for polarities of hsync, vsync, data enabled & pixel clock.
>
> Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>  drivers/gpu/drm/stm/ltdc.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 808d9fb..f671abc 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -517,7 +517,7 @@ static void ltdc_crtc_mode_set_nofb(struct drm_crtc *=
crtc)
>         struct videomode vm;
>         u32 hsync, vsync, accum_hbp, accum_vbp, accum_act_w, accum_act_h;
>         u32 total_width, total_height;
> -       u32 val;
> +       u32 val =3D 0;
>
>         drm_display_mode_to_videomode(mode, &vm);
>
> @@ -538,7 +538,22 @@ static void ltdc_crtc_mode_set_nofb(struct drm_crtc =
*crtc)
>         total_height =3D accum_act_h + vm.vfront_porch;
>
>         /* Configures the HS, VS, DE and PC polarities. Default Active Lo=
w */
> -       val =3D 0;
> +       if (vm.flags & DISPLAY_FLAGS_HSYNC_LOW)
> +               DRM_DEBUG_DRIVER("Horizontal Synchronization polarity is =
active low");
> +       if (vm.flags & DISPLAY_FLAGS_HSYNC_HIGH)
> +               DRM_DEBUG_DRIVER("Horizontal Synchronization polarity is =
active high");
> +       if (vm.flags & DISPLAY_FLAGS_VSYNC_LOW)
> +               DRM_DEBUG_DRIVER("Vertical Synchronization polarity is ac=
tive low");
> +       if (vm.flags & DISPLAY_FLAGS_VSYNC_HIGH)
> +               DRM_DEBUG_DRIVER("Vertical Synchronization polarity is ac=
tive high");
> +       if (vm.flags & DISPLAY_FLAGS_DE_LOW)
> +               DRM_DEBUG_DRIVER("Data Enable polarity is active low");
> +       if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
> +               DRM_DEBUG_DRIVER("Data Enable polarity is active high");
> +       if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> +               DRM_DEBUG_DRIVER("Pixel clock polarity is active low");
> +       if (vm.flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> +               DRM_DEBUG_DRIVER("Pixel clock polarity is active high");
>
>         if (vm.flags & DISPLAY_FLAGS_HSYNC_HIGH)
>                 val |=3D GCR_HSPOL;
> @@ -546,10 +561,10 @@ static void ltdc_crtc_mode_set_nofb(struct drm_crtc=
 *crtc)
>         if (vm.flags & DISPLAY_FLAGS_VSYNC_HIGH)
>                 val |=3D GCR_VSPOL;
>
> -       if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
> +       if (vm.flags & DISPLAY_FLAGS_DE_LOW)
>                 val |=3D GCR_DEPOL;
>
> -       if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> +       if (vm.flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
>                 val |=3D GCR_PCPOL;
>
>         reg_update_bits(ldev->regs, LTDC_GCR,
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
