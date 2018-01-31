Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932147AbeAaPzv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:55:51 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10554 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752610AbeAaPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:55:50 -0500
From: Philippe CORNU <philippe.cornu@st.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "laurent.pinchart@ideasonboard.com"
        <laurent.pinchart@ideasonboard.com>
CC: "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/stm: check pitch and size calculations even if
 !CONFIG_MMU
Thread-Topic: [PATCH v2] drm/stm: check pitch and size calculations even if
 !CONFIG_MMU
Thread-Index: AQHTmmpApfoADTvM1UuDNlLVosfTS6OOEkmA
Date: Wed, 31 Jan 2018 15:55:40 +0000
Message-ID: <8c2364a4-9085-1a7e-4ac9-b9d4db6baa7f@st.com>
References: <20180131080508.14356-1-benjamin.gaignard@linaro.org>
In-Reply-To: <20180131080508.14356-1-benjamin.gaignard@linaro.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3A0CC9171ABC343BC408371AED419BE@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-31_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0VFtuZr008296

Hi Benjamin,
Great, Many thanks,

Tested-by: Philippe Cornu <philippe.cornu@st.com>

Philippe :-)


On 01/31/2018 09:05 AM, Benjamin Gaignard wrote:
> In all cases we have to check pitch and size calculations to speed up
> data transfer.
> 
> Fixes: 21f815bf773c ("drm/stm: drv: Improve data transfers")
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>   drivers/gpu/drm/stm/drv.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> index 8bc7e8418b8d..9ab00a87f7cc 100644
> --- a/drivers/gpu/drm/stm/drv.c
> +++ b/drivers/gpu/drm/stm/drv.c
> @@ -35,7 +35,6 @@ static int stm_gem_cma_dumb_create(struct drm_file *file,
>   				   struct drm_device *dev,
>   				   struct drm_mode_create_dumb *args)
>   {
> -#ifdef CONFIG_MMU
>   	unsigned int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
>   
>   	/*
> @@ -44,7 +43,6 @@ static int stm_gem_cma_dumb_create(struct drm_file *file,
>   	 */
>   	args->pitch = roundup(min_pitch, 128);
>   	args->height = roundup(args->height, 4);
> -#endif
>   
>   	return drm_gem_cma_dumb_create_internal(file, dev, args);
>   }
> 
