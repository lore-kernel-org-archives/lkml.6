Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A510C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA0D20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs0kfNsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA0D20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeK0H2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:28:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33529 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeK0H2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:28:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id 79so52254wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 12:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9HEiEP43l4lksGbsXP4NfH0xju5BmiAXNZ1gf4H5aI=;
        b=Rs0kfNsFDytRxcqfDw/aPCr/POuD1phUzCO2iw5/S9BzH9EdtPlmYGqo3XQizu/+5d
         uYzTRgYBXxCMMkCu2yY8cDsPyPSTzDmEMLKXHRBvki4Sc2KNnqyxsb9+atv5Jr0MOfy+
         PLGri6DBoDySyD1Zdy0xA9ZJwA0Gw72W4UFvvHqgU8vOYB2+Y4Ssw9IakgNDEsuRhjbm
         bWfL7vqcGsl0lBQbj88oaVt4rJ4xvrIyrF0FH/Q+XX9XLJi9nUqbf8qmCYmvG9G7pbGH
         MTKvS+2c1/QKKYY+1DGrxs5gC9akzEVCtrK+rRHIAtffaEiHtSrH6SPZ9v7sgoPqYFbJ
         zovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9HEiEP43l4lksGbsXP4NfH0xju5BmiAXNZ1gf4H5aI=;
        b=oFISIXQvRQ77kUD8TK47ri4rEUpfLLjlY9OORFXt/eAlIRh6qbmEfFJjVD8EtgNX+N
         gFZmS0DNS/VBqJcUu/R+y/17UG4UXrfEt3oaRus6hq97cxoqgpZzE7GL+lwlUC1sAhhF
         sJWYPjHk+Oo3jzt2cS0NLUrpbuxtH1Cxs2zyXUkUOVwwRncSCZhE2tbZWAxtoNw0bzZV
         goebrZ5UYUFgEeVeVSfY9ugpfEctuWUUsvySTQ5oGLxQa+r8Lw0/Ed50vUfqqYNzOKXi
         dOfHHVgjcRHDB3H96pMFvcMLoEWxXk7Kjszl1bbU1TS55dBPWf3dbQf1dOeNZhL/mOjX
         1XHQ==
X-Gm-Message-State: AGRZ1gJiEy586CkhkleCow+hGh1N17H4G3RQnQgf3Ai+FMN5HjvF9GKQ
        LFRWe8Z3bOjcChgXiPdQUPVoe/j9hn9QpYrx/QE=
X-Google-Smtp-Source: AJdET5fZbHje3EA68os50VVnnEyannjzduhbaNy866Kt+DEKXsMJ39PqxPqfrX2CSYC7LX3TTurf8pvAhmA13WMqtcE=
X-Received: by 2002:a1c:ba54:: with SMTP id k81mr24392247wmf.153.1543264376859;
 Mon, 26 Nov 2018 12:32:56 -0800 (PST)
MIME-Version: 1.0
References: <20181123031831.GA2470@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181123031831.GA2470@hp-pavilion-15-notebook-pc-brajeswar>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 26 Nov 2018 15:32:42 -0500
Message-ID: <CADnq5_OEj_6nryB6uf_LTL2OPcpQF1Ai9fCBbuDza6uADO8=oA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Remove duplicate header
To:     brajeswar.linux@gmail.com
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        "Li, Samuel" <Samuel.Li@amd.com>,
        "Daenzer, Michel" <michel.daenzer@amd.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 2:41 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove drm/drm_fb_helper.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index b9e9e8b02fb7..1cac12a26a4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -38,7 +38,6 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_plane_helper.h>
> -#include <drm/drm_fb_helper.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-algo-bit.h>
>  #include <linux/hrtimer.h>
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
