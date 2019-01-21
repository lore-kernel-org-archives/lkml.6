Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85E9C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E5B214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBbfxhS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfAUJJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:09:52 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33606 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfAUJJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:09:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so14012975oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MbxvX/AkJ3wQ59hS4IMAvv/9UKU2g7OluU2n+zsp7MY=;
        b=fBbfxhS1gG2iO5wnoOR9EILcuAAHPLx5n3A2TE+QsXVm8IBa9G3/m0Quez8GRWyvTf
         i6P07S59zzTO4kYQRZvU1B54rGyrUUzr83hYDW+tr2RfJKIMQRqgxaC20DybPwAYKcKM
         fKKnhcD8QoH2owgnU3q/r2vm5gpmbebQ7voDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MbxvX/AkJ3wQ59hS4IMAvv/9UKU2g7OluU2n+zsp7MY=;
        b=XmOvfMJszfBWVoIj0o+N130zlHukNjjLD7ztNTxND1IWjCu+KRlYd9nHyPqo7HlrNN
         N/Wn2K9pHMipMo0s000KR0zq+8VptCjogbrMawAJE50vb2c6fqa13Mob/JCes8UE7bdR
         Zg4dWY1eDb3He6CLQgneXnq5THbMaeGxO/Rf21sMgHary0wzQFewMzV9sB2U9rEc+hek
         BIUtTtwhjzvQInE+zlg9bXfu+9NSoxmWRQVr73umMZ+Ryc/Sh/pMG1SXsuAUhM6B+MfS
         UQHOuGTBG10k0N9GLh/i2Wg9usCVx9BrfYG1TwKTCcX2oEbc8+wGZ80L1jXLIAzNbQDo
         jI/w==
X-Gm-Message-State: AJcUukf/LYQXMWLHDZO+fVEKLvW5jRg5Ga36q9AlL2acVCsot/94KS51
        vaHPtvrB3Mf9w4rIZI8Dhu969heuQI329qcIpTIznw==
X-Google-Smtp-Source: ALg8bN7Tr+KGqknXoZpqS9FENJsQcfIG1Ng1e0aXG8CMYgJoLBE8RJywzzdx5f84zkVsOi0jqs4rswMITqp1+trPFWY=
X-Received: by 2002:aca:f103:: with SMTP id p3mr4949822oih.94.1548061790765;
 Mon, 21 Jan 2019 01:09:50 -0800 (PST)
MIME-Version: 1.0
References: <1538131180-34108-1-git-send-email-yuehaibing@huawei.com> <1548059241-148022-1-git-send-email-yuehaibing@huawei.com>
In-Reply-To: <1548059241-148022-1-git-send-email-yuehaibing@huawei.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 21 Jan 2019 10:09:39 +0100
Message-ID: <CA+M3ks6Q+hU9jjAbu6qkMqb0knALbBYonS0kRjyFQd_gcSgE=A@mail.gmail.com>
Subject: Re: [PATCH -next] drm/stm: ltdc: remove set but not used variable 'src_h'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 21 janv. 2019 =C3=A0 09:21, YueHaibing <yuehaibing@huawei.com> a =
=C3=A9crit :
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/stm/ltdc.c: In function 'ltdc_plane_atomic_check':
> drivers/gpu/drm/stm/ltdc.c:694:13: warning:
>  variable 'src_y' set but not used [-Wunused-but-set-variable]
>   u32 src_x, src_y, src_w, src_h;
>              ^
>              ^
> drivers/gpu/drm/stm/ltdc.c:694:6: warning:
>  variable 'src_x' set but not used [-Wunused-but-set-variable]
>   u32 src_x, src_y, src_w, src_h;
>       ^
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied on drm-misc-next,

Thanks,
Benjamin

> ---
>  drivers/gpu/drm/stm/ltdc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 61dd661..a91e041 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -691,7 +691,7 @@ static int ltdc_plane_atomic_check(struct drm_plane *=
plane,
>                                    struct drm_plane_state *state)
>  {
>         struct drm_framebuffer *fb =3D state->fb;
> -       u32 src_x, src_y, src_w, src_h;
> +       u32 src_w, src_h;
>
>         DRM_DEBUG_DRIVER("\n");
>
> @@ -699,8 +699,6 @@ static int ltdc_plane_atomic_check(struct drm_plane *=
plane,
>                 return 0;
>
>         /* convert src_ from 16:16 format */
> -       src_x =3D state->src_x >> 16;
> -       src_y =3D state->src_y >> 16;
>         src_w =3D state->src_w >> 16;
>         src_h =3D state->src_h >> 16;
>
>
>
>
>
>
