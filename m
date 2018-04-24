Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbeDXT5E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:57:04 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43716 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeDXT5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:57:03 -0400
X-Google-Smtp-Source: AIpwx4+nGRg6dG0fUp18PsBcRxC/Yhz6SZvTzkMyXACR70yvpu+cpywu1bfze0z7QVZGHf3rsjOPO+wmRfzbFpyw0IU=
MIME-Version: 1.0
In-Reply-To: <20180424195512.491-1-malat@debian.org>
References: <20180424195512.491-1-malat@debian.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 24 Apr 2018 21:56:42 +0200
X-Google-Sender-Auth: 4ubxF7R-WSg-CrB-I6IRzbbmO94
Message-ID: <CA+7wUszw=fF_kUW+Et07nnX1=0VBtrPJU6yfZsuk_uLUJPQsmw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Change the default to PCI on PowerPC
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3OJvC9Y031347

For reference:

https://lists.freedesktop.org/archives/mesa-dev/2016-May/115453.html

2018-04-24 21:55 GMT+02:00 Mathieu Malaterre <malat@debian.org>:
> AGP mode is unstable on PowerPC. Symptoms are generally of the form:
>
> [ 1228.795711] radeon 0000:00:10.0: ring 0 stalled for more than 10240msec
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index b28288a781ef..2a7977a23b31 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -168,7 +168,12 @@ int radeon_no_wb;
>  int radeon_modeset = -1;
>  int radeon_dynclks = -1;
>  int radeon_r4xx_atom = 0;
> +#ifdef __powerpc__
> +/* Default to PCI on PowerPC (fdo #95017) */
> +int radeon_agpmode = -1;
> +#else
>  int radeon_agpmode = 0;
> +#endif
>  int radeon_vram_limit = 0;
>  int radeon_gart_size = -1; /* auto */
>  int radeon_benchmarking = 0;
> --
> 2.11.0
>
