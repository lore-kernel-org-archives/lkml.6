Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbeDYJt3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:49:29 -0400
Received: from mail.netline.ch ([148.251.143.178]:57516 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbeDYJt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:49:26 -0400
Subject: Re: [PATCH] drm/radeon: Change the default to PCI on PowerPC
To: Mathieu Malaterre <malat@debian.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>
References: <20180424195512.491-1-malat@debian.org>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <0d3b4b95-044d-ab4f-950e-85098b81cb5d@daenzer.net>
Date: Wed, 25 Apr 2018 11:49:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424195512.491-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-24 09:55 PM, Mathieu Malaterre wrote:
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
> 

Pushed to amd-staging-drm-next, thanks!


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
