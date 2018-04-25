Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeDYHNx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:13:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21271 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750962AbeDYHNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:13:52 -0400
From: Yannick FERTRE <yannick.fertre@st.com>
To: Philippe CORNU <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "David Airlie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH] drm/stm: ltdc: fix warnings in ltdc_plane_create()
Thread-Topic: [PATCH] drm/stm: ltdc: fix warnings in ltdc_plane_create()
Thread-Index: AQHT1+JFaeZhbelLh0aN3VDy/9r5FqQQ+JMA
Date: Wed, 25 Apr 2018 07:13:40 +0000
Message-ID: <1dd09038-3d92-ffd3-bc6e-660f363190d4@st.com>
References: <20180419132804.8317-1-philippe.cornu@st.com>
In-Reply-To: <20180419132804.8317-1-philippe.cornu@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1786F494879C1748AB38DA2EBD79A7B2@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3P7E0mv006960

Hi Philippe,

Reviewed-by: Yannick Fertré <yannick.fertre@st.com>


On 04/19/2018 03:28 PM, Philippe Cornu wrote:
> "make C=1" returns 2 warnings in ltdc_plane_create()
> ("Using plain integer as NULL pointer"). This patch
> fixes them.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 616191fe98ae..d997a6014d6c 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -860,13 +860,13 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
>   
>   	plane = devm_kzalloc(dev, sizeof(*plane), GFP_KERNEL);
>   	if (!plane)
> -		return 0;
> +		return NULL;
>   
>   	ret = drm_universal_plane_init(ddev, plane, possible_crtcs,
>   				       &ltdc_plane_funcs, formats, nb_fmt,
>   				       NULL, type, NULL);
>   	if (ret < 0)
> -		return 0;
> +		return NULL;
>   
>   	drm_plane_helper_add(plane, &ltdc_plane_helper_funcs);
>   
> 
