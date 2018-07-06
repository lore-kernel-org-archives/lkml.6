Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B07C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC2A2404A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOiZ9tdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC2A2404A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753674AbeGFIYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:24:07 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40948 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753428AbeGFIYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:24:05 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so21966547oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 01:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zBqtVO99/DcDIZionrvwkaKzyKllDWvEdV19hnREFE4=;
        b=dOiZ9tddGTZPfCi37VVLSwxKQ1mFt39xBRag1Y5EJdXPJjXJfaOJU9nf0UTCh8gFv2
         PFtlA/YC5rxZ0/NxWR2oAwfnb7lbqlyvwA0jOMUAxdAGyHZGSAb5mWfrzq6C+eOvaopG
         3wnbIgH/rXRq0OWiB69PqFaMabDsTVuV6DxHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zBqtVO99/DcDIZionrvwkaKzyKllDWvEdV19hnREFE4=;
        b=SAV60jg5CM2yDabDeYgox291motYWxo+uRH2NKrLyymFdvc3Z1jH+5g9mIV/vsAtAL
         SzmXMOn92KQ9+MYxjCqoqPUcgWJY6eUrdTOkSJvc1APVy/I8WIipSRyI8FPCG1OSHvh2
         BhG0x+KPhDRlhjyc4qDwUFz5MVMx2rm6SqRb2bVk4sx+WTND38spqI/cQPVIHqPHahFd
         20+kOO18nrgTxshZgVqgM89nIPUmiQ8On62KkBWUfsh8q+ZwyoWOgLx693ukSjlLJTCX
         ZI6YiDYOKPX4lRN0X7TAZM+853SuXNVrBwROmuSgse7LMPlbK1AC5XQ0i775VIUgZqmW
         ACCA==
X-Gm-Message-State: APt69E1oNCzflTblY/IHT3uwYCZ+gnDF+laMvPiZV0cf6Irg9JQTEi03
        +4nnk6LeSfZj9ZHSIy13udZlUnO68AKSyMNdtcVbCA==
X-Google-Smtp-Source: AAOMgpeSecGEsD61D6qQD3XhDwv1FWXT3zsZLfSOQkL/7/kLW1nfnWu2NK5eb1hHQwtQ+thgNxqNHItnRJeF+kkivdc=
X-Received: by 2002:aca:ccc4:: with SMTP id c187-v6mr9664661oig.282.1530865444561;
 Fri, 06 Jul 2018 01:24:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:192d:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 01:24:04 -0700 (PDT)
In-Reply-To: <20180605135407.20214-2-benjamin.gaignard@linaro.org>
References: <20180605135407.20214-1-benjamin.gaignard@linaro.org> <20180605135407.20214-2-benjamin.gaignard@linaro.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 6 Jul 2018 10:24:04 +0200
Message-ID: <CA+M3ks5sUvPQz81Wav3c7-7hS1+iv=2W-UcZzPdd_LvOK7crWA@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] drm: print plane state normalized zpos value
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Vincent Abriou <vincent.abriou@st.com>
Cc:     dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-05 15:54 GMT+02:00 Benjamin Gaignard <benjamin.gaignard@linaro.org>:
> When dumping plane state print normalized zpos value as done for
> the other plane state fields.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Applied on drm-misc-next.
The others patches of this series are abandoned

Benjamin

> ---
>  drivers/gpu/drm/drm_atomic.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 07fef42869aa..cd1d677617c8 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -988,6 +988,7 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
>         drm_printf(p, "\tcrtc-pos=" DRM_RECT_FMT "\n", DRM_RECT_ARG(&dest));
>         drm_printf(p, "\tsrc-pos=" DRM_RECT_FP_FMT "\n", DRM_RECT_FP_ARG(&src));
>         drm_printf(p, "\trotation=%x\n", state->rotation);
> +       drm_printf(p, "\tnormalized-zpos=%x\n", state->normalized_zpos);
>         drm_printf(p, "\tcolor-encoding=%s\n",
>                    drm_get_color_encoding_name(state->color_encoding));
>         drm_printf(p, "\tcolor-range=%s\n",
> --
> 2.15.0
>
