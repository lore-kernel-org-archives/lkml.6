Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C894C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167C22064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWzU4bNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167C22064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJOTAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:00:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46912 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOTAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:00:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id k64-v6so14713872oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y2TVmhGwFdzUfY9nDqymrGyhfWwbq9XIzlDRA7jnFEE=;
        b=UWzU4bNAKh7ybim+3b/tdHhyIq5rjUcNCkqvPFDBfXKlTv0pxDPKOOmTqLBjwgHbCh
         8mMsEWrm1OU0/GGHjQ3+XzoxAtQEiU4chrtsZO4qbYUYXjhPdh0oGFw08DFVdPe3G4nT
         wCo3nlksE7nn/ZZEXl7l4x23Byb4E9vyuyuyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y2TVmhGwFdzUfY9nDqymrGyhfWwbq9XIzlDRA7jnFEE=;
        b=oNi4YcvfYhkLHywzFFnE4WIchv8BuG6JSHJNKfHYWeD22kxpTLiVMd8zeSoJzACEMV
         fAc8UAfMDkWug7LZ9ATyheXCCM4HWAMymOTcBVYGyEgsXdPFdx92Vg5Qz/B+z82N811v
         rcfNvdX4oRF7REsQmSYT/c5AQ2/oM/u7Myti7NWnBFga18CDA4jDi0Jb/7pclf7xdvj7
         crQ+7QKRQ7aeQ4RATQHHkHp06GQtbsLbBWHDMj9o5819I1e7U6n+mTMK7+DTw6zjNjAm
         4SjaLH1H6WyPQZc5ZelJUTcQxPNVsqpUD9G0J9WUDk7byeUpDrSiPfl6fAzNMJc6fuI+
         hz7w==
X-Gm-Message-State: ABuFfoj+vHYXyQACkTqs1zG1LEBRbsH/6Ip2AwcHik8FTYHwpQxfa72k
        ZZSmzobcS8Bqdu66mkSnWvwO4dsg2MSYWmAF7swgZFfNhQ0=
X-Google-Smtp-Source: ACcGV611ntfwuOgCj0IWFc+VNXsiPZQgFtegrAPf9xSLHckSz9B8yPjoeoz69kO5Tum2uceLb+t8UHU+n6XmoBv3roc=
X-Received: by 2002:aca:724b:: with SMTP id p72-v6mr8346698oic.169.1539602111548;
 Mon, 15 Oct 2018 04:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <1537788981-21479-1-git-send-email-yannick.fertre@st.com> <1537788981-21479-2-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1537788981-21479-2-git-send-email-yannick.fertre@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 15 Oct 2018 13:15:00 +0200
Message-ID: <CA+M3ks4L_Cs_GB2sxg1XyygLz79eH7d+JcgLULM3fFN0U=YCZw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm: Add missing flags for pixel clock & data enable
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

Le lun. 24 sept. 2018 =C3=A0 13:59, Yannick Fertr=C3=A9 <yannick.fertre@st.=
com> a =C3=A9crit :
>
> Add missing flags for pixel clock & data enable polarities.
> These flags are similar to other synchronization signals (hsync, vsync...=
).
>
> Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

> ---
>  drivers/gpu/drm/drm_modes.c | 19 ++++++++++++++++++-
>  include/uapi/drm/drm_mode.h |  6 ++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 02db9ac..596f8b3 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -130,7 +130,7 @@ EXPORT_SYMBOL(drm_mode_probed_add);
>   * according to the hdisplay, vdisplay, vrefresh.
>   * It is based from the VESA(TM) Coordinated Video Timing Generator by
>   * Graham Loveridge April 9, 2003 available at
> - * http://www.elo.utfsm.cl/~elo212/docs/CVTd6r1.xls
> + * http://www.elo.utfsm.cl/~elo212/docs/CVTd6r1.xls
>   *
>   * And it is copied from xf86CVTmode in xserver/hw/xfree86/modes/xf86cvt=
.c.
>   * What I have done is to translate it by using integer calculation.
> @@ -611,6 +611,15 @@ void drm_display_mode_from_videomode(const struct vi=
deomode *vm,
>                 dmode->flags |=3D DRM_MODE_FLAG_DBLSCAN;
>         if (vm->flags & DISPLAY_FLAGS_DOUBLECLK)
>                 dmode->flags |=3D DRM_MODE_FLAG_DBLCLK;
> +       if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> +               dmode->flags |=3D DRM_MODE_FLAG_PPIXCLK;
> +       else if (vm->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> +               dmode->flags |=3D DRM_MODE_FLAG_NPIXCLK;
> +       if (vm->flags & DISPLAY_FLAGS_DE_HIGH)
> +               dmode->flags |=3D DRM_MODE_FLAG_PDATAEN;
> +       else if (vm->flags & DISPLAY_FLAGS_DE_LOW)
> +               dmode->flags |=3D DRM_MODE_FLAG_NDE;
> +
>         drm_mode_set_name(dmode);
>  }
>  EXPORT_SYMBOL_GPL(drm_display_mode_from_videomode);
> @@ -652,6 +661,14 @@ void drm_display_mode_to_videomode(const struct drm_=
display_mode *dmode,
>                 vm->flags |=3D DISPLAY_FLAGS_DOUBLESCAN;
>         if (dmode->flags & DRM_MODE_FLAG_DBLCLK)
>                 vm->flags |=3D DISPLAY_FLAGS_DOUBLECLK;
> +       if (dmode->flags & DRM_MODE_FLAG_PPIXDATA)
> +               vm->flags |=3D DISPLAY_FLAGS_PIXDATA_POSEDGE;
> +       else if (dmode->flags & DRM_MODE_FLAG_NPIXDATA)
> +               vm->flags |=3D DISPLAY_FLAGS_PIXDATA_NEGEDGE;
> +       if (dmode->flags & DRM_MODE_FLAG_PDE)
> +               vm->flags |=3D DISPLAY_FLAGS_DE_HIGH;
> +       else if (dmode->flags & DRM_MODE_FLAG_NDE)
> +               vm->flags |=3D DISPLAY_FLAGS_DE_LOW;
>  }
>  EXPORT_SYMBOL_GPL(drm_display_mode_to_videomode);
>
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index d3e0fe3..b335a17 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -89,6 +89,12 @@ extern "C" {
>  #define  DRM_MODE_FLAG_3D_TOP_AND_BOTTOM       (7<<14)
>  #define  DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF    (8<<14)
>
> +/* flags for polarity clock & data enable polarities */
> +#define DRM_MODE_FLAG_PPIXDATA                 (1 << 19)
> +#define DRM_MODE_FLAG_NPIXDATA                 (1 << 20)
> +#define DRM_MODE_FLAG_PDE                      (1 << 21)
> +#define DRM_MODE_FLAG_NDE                      (1 << 22)
> +
>  /* Picture aspect ratio options */
>  #define DRM_MODE_PICTURE_ASPECT_NONE           0
>  #define DRM_MODE_PICTURE_ASPECT_4_3            1
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
