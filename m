Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C8EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DA82171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMYKMnYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfA1QUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:20:08 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36158 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388719AbfA1QUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:20:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so18730744wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 08:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNNVpLv0JwVS9DWGA8fa7Tx/+X2wOgOo7y/ry37kMuA=;
        b=tMYKMnYjCbjNzxKj32b1azdsyGCLMGcnOlR7c0EO1Nrs8rlpTU4N9PO35L8jEzbGYA
         C/L3PlMRpzNQ4yes52AhzBtXPLv9hXop8Y6nYaOj+2Q2yiuDG32OC41Tu/Gbr/L02NdX
         rsRvu/OhBHfqf8j3laz9bXUGRY4GyiMrYhekaO5MCQUozuEzJuDQ581dGFs9o0WdSHIA
         f9EFM6zRVtRygurC7WcLNbjoP+rDAcmkAL1Jztb7SQ5CVetvTP11KyPiOQnwEbv3dyi6
         l5doqaPZpUKTbnIFsFRLtDSt5GtEVpMGpz13qE7OyWbU5T5nMEaabb2cMWrQ6fDsENM0
         G0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNNVpLv0JwVS9DWGA8fa7Tx/+X2wOgOo7y/ry37kMuA=;
        b=FNEyJYu1i+abKlL/az6IKzsSMc1/Fq5roHou0WVSijV9h85dBJzM2hpqCm5Fsw1829
         jYZeppO9GdpnSlCrqEvbjdyjYEVd6zBuUjmDBfE9W8cIIcstHGRfHphNwvQZZcCoiZxS
         HrJ57sLoFmcsI2JgMEOyxI4YznyeQUxfTqc6D5R/4Y3nRArnBVmqgeNtI8tsHBYBw7fQ
         XxgEBwI4zdq9leFNizJEcG5JifN5Z3cyEHxgFHCc3b1y5EIylNAPh1m2AjJhJI1TmeH8
         7uyNklMTN/paUALtdAwygSH9/T/NPztgmarylGDIWGIRn6LtY8DBO29NaBsSiet51j2w
         IHxw==
X-Gm-Message-State: AJcUukdIaf5kMVD1Qq0xFLPBtXktKjIGcQb0FOgF+fyqN7KdTq4mYqZ7
        quo2KG5saLHce0lV39J/1fj0KiJEVc5UGtTUi94=
X-Google-Smtp-Source: ALg8bN5DQKLs0BL6Vhc4Lywy6JRCXIcB9MC5EHFCtS14zxtRTtu2HvYKvN/6OnvfDviE6X01BQjIFt46sIxxEXsodlU=
X-Received: by 2002:a5d:488f:: with SMTP id g15mr22311187wrq.15.1548692401178;
 Mon, 28 Jan 2019 08:20:01 -0800 (PST)
MIME-Version: 1.0
References: <20190125215533.GA4878@embeddedor>
In-Reply-To: <20190125215533.GA4878@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 28 Jan 2019 11:19:48 -0500
Message-ID: <CADnq5_Nx1yHoANDaGs50AF5VQXWCUD8PU1YoyHAmGetHxoqiPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Fix missing break in switch
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 5:31 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Add missing break statement in order to prevent the code from falling
> through to the default case.
>
> The resoning for this is that pclk_vol_table is an automatic variable.
> So, it makes no sense to update it just before falling through to the
> default case and return -EINVAL.
>
> This bug was found thanks to the ongoing efforts to enabling
> -Wimplicit-fallthrough.
>
> Fixes: cd70f3d6e3fa ("drm/amd/powerplay: PP/DAL interface changes for dynamic clock switch")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> index f95c5f50eb0f..5273de3c5b98 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1033,6 +1033,7 @@ static int smu10_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
>                 break;
>         case amd_pp_dpp_clock:
>                 pclk_vol_table = pinfo->vdd_dep_on_dppclk;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
