Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6634C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348F214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n6zazEX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfAID7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:59:43 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:59776 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfAID7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:59:43 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190109035940epoutp030d050c426a387f8e177401fd9ade9307~4EhteL9ow0286202862epoutp03e
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 03:59:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190109035940epoutp030d050c426a387f8e177401fd9ade9307~4EhteL9ow0286202862epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547006380;
        bh=fH4qPbBF/D4Bvj4VJqVJBz3eqrQqIqSpfuCCqP5OyBw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=n6zazEX8I3N7KGk2gXbM9WQRSIS9MmRGk+jLOuvZhEOhGG9VaTWDskoea2LCLpOiW
         1uFyCC9v4Ax5KQS5wU3tFQXnoSHFY9zEt5syUb0maL98svw5/V1b07pE5Djyul/JfI
         luxizkd8XqkgoNO48MafbeIoyUnx9fwfShrLgcG0=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190109035937epcas1p204d65e86278ec3c4c14efabb9d92ac09~4EhqQ4kem1045310453epcas1p2I;
        Wed,  9 Jan 2019 03:59:37 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.F8.04064.9A1753C5; Wed,  9 Jan 2019 12:59:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190109035936epcas1p41e5ddaa47193278c389298e902c82ced~4Ehpq3-KN2196321963epcas1p4F;
        Wed,  9 Jan 2019 03:59:36 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190109035936epsmtrp26f353b471251199a2a773a482ec2b9a6~4EhppOias2446024460epsmtrp2P;
        Wed,  9 Jan 2019 03:59:36 +0000 (GMT)
X-AuditID: b6c32a39-011ff70000000fe0-38-5c3571a9bb15
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.79.03694.8A1753C5; Wed,  9 Jan 2019 12:59:36 +0900 (KST)
Received: from [10.113.221.211] (unknown [10.113.221.211]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190109035936epsmtip2e51efced8b6701697c82f47114189b99~4EhpXEufQ2481324813epsmtip2L;
        Wed,  9 Jan 2019 03:59:36 +0000 (GMT)
Subject: Re: [PATCH 1/3] drm/exynos: rotator: Add support for s5pv210
To:     =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        krzk@kernel.org, airlied@linux.ie
Cc:     jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, kgene@kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
From:   Inki Dae <inki.dae@samsung.com>
Message-ID: <265fadf7-5e6f-6cba-85c8-9dcd3c85ae18@samsung.com>
Date:   Wed, 9 Jan 2019 12:59:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219155704.15264-2-pawel.mikolaj.chmiel@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLsWRmVeSWpSXmKPExsWy7bCmnu7KQtMYg443fBa9504yWcw/co7V
        4srX92wWL+5dZLHof/ya2eL8+Q3sFmeb3rBbbHp8jdXi8q45bBYzzu9jslh6/SKTxY/jfcwW
        rXuPsFvMmPySzYHPY828NYweO2fdZffYtKqTzWP7twesHve7jzN5bF5S79G3ZRWjx+dNcgEc
        UQ2MNolFyRmZZakKqXnJ+SmZeem2SqEhbroWSgoZ+cUltkrRhoZGeoYG5npGRkZ6xpaxVkam
        Sgp5ibmptkoVulC9SgpFyQVAtbmVxUADclL1oOJ6xal5KQ5Z+aUgz+oVJ+YWl+al6yXn5yop
        lCXmlAKNUNJP+MaY0fF7JlvBfcmK6cdPsjUwzhPtYuTkkBAwkWhqWMHUxcjFISSwg1FiwtPH
        LBDOJ0aJR5u/sEE43xglTs66yQrTcnbtCWaIxF5GiV/fjkJVvWeU2PT1GiNIlbCAq8St40/B
        bBGBdIkfP2+xgdjMAtuYJBbc4AWx2QRUJSauuA8U5+DgFbCTOPHeESTMIqAicfDIWbByUYEI
        iY77q8FsXgFBiZMzn7CA2JwCLhI3Z+1gghgpLnHryXwoW16ieetssOMkBDaxSzzZuokR4moX
        iXvLNrND2MISr45vgbKlJD6/28sGYZdLPHv3jAXkHgmBGolvcysgTGOJiytSQExmAU2J9bv0
        IYoFJU5f62aG2Mon8e5rDytENa9ER5sQRImSxLGLN6D2S0hcWDIRao+HxJf9axknMCrOQvLX
        LCS/zELyyyyExQsYWVYxiqUWFOempxYbFpgix/YmRnA617LcwXjsnM8hRgEORiUeXov1JjFC
        rIllxZW5hxglOJiVRHjV7wCFeFMSK6tSi/Lji0pzUosPMSYDg30is5Rocj4w1+SVxBuaGhkb
        G1uYGJqZGhoiCZsYGxgYAROquaW5MQ5hJXHeJ1Jzo4UE0hNLUrNTUwtSi2C2MHFwSjUwnlIs
        id929GfCq5NpqwSlfDzf/3h25nhT/TaeC84ZhW5T0i6sll3GsTdVQGwf44EEQ0Yex69iZ+Pb
        z+x5Fb3WaOop/+pv90uKzNf0hz6c/f7XxI3/NwQ+tdSPevz/22Zd0ZZw+fqfbhUXFQTbl3P7
        HWpjuvkmLTO3fMO+u77uLy4azI+3DjneqcRSnJFoqMVcVJwIABDMwy8rBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSvO6KQtMYg8s/FCx6z51ksph/5Byr
        xZWv79ksXty7yGLR//g1s8X58xvYLc42vWG32PT4GqvF5V1z2CxmnN/HZLH0+kUmix/H+5gt
        WvceYbeYMfklmwOfx5p5axg9ds66y+6xaVUnm8f2bw9YPe53H2fy2Lyk3qNvyypGj8+b5AI4
        orhsUlJzMstSi/TtErgyOn7PZCu4L1kx/fhJtgbGeaJdjJwcEgImEmfXnmDuYuTiEBLYzSgx
        Y/NJli5GDqCEhMSWrRwQprDE4cPFECVvGSW2LtjODtIrLOAqcev4U0YQW0QgXeJL0zcmkCJm
        gW1MEj0zDjBCdFxklJj67TYTSBWbgKrExBX32UCm8grYSZx47wgSZhFQkTh45CwbiC0qECFx
        9uU6sKG8AoISJ2c+YQGxOQVcJG7O2gE2hllAXeLPvEvMELa4xK0n86Hi8hLNW2czT2AUmoWk
        fRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4LrW0djCeOBF/
        iFGAg1GJh9divUmMEGtiWXFl7iFGCQ5mJRFe9TtAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzy
        +ccihQTSE0tSs1NTC1KLYLJMHJxSDYxsJo8l0zY93nAx7z93Qvo7T+v7bgbHlx55dsHlhZvB
        w0sPjqrZmLxpeTl91o3Ly/vWeuu9d41KUfxz++rK6VwBziWzar65Fxo9ktGIXntjdup61vgl
        +fmTdldFv+yOPzHbW9RrQ5vgq4dpJnwfSi7VSXDd05l9wFRBRtdGY2PEMpNCZeGt8TOUWIoz
        Eg21mIuKEwGATJKtxwIAAA==
X-CMS-MailID: 20190109035936epcas1p41e5ddaa47193278c389298e902c82ced
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181219160447epcas3p4b25fc066564986e75f170e1816c7a48a
References: <20181219155704.15264-1-pawel.mikolaj.chmiel@gmail.com>
        <CGME20181219160447epcas3p4b25fc066564986e75f170e1816c7a48a@epcas3p4.samsung.com>
        <20181219155704.15264-2-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



18. 12. 20. 오전 12:57에 Paweł Chmiel 이(가) 쓴 글:
> This commit adds support for s5pv210.
> Currently only NV12 and XRGB8888 formats are supported.
> It was tested by using tool from
> https://www.spinics.net/lists/linux-samsung-soc/msg60498.html
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Applied.

Thanks,
Inki Dae

> ---
>  drivers/gpu/drm/exynos/exynos_drm_rotator.c | 23 +++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
> index a820a68429b9..a822d340ccf6 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
> @@ -357,6 +357,11 @@ static int rotator_runtime_resume(struct device *dev)
>  }
>  #endif
>  
> +static const struct drm_exynos_ipp_limit rotator_s5pv210_rbg888_limits[] = {
> +	{ IPP_SIZE_LIMIT(BUFFER, .h = { 8, SZ_16K }, .v = { 8, SZ_16K }) },
> +	{ IPP_SIZE_LIMIT(AREA, .h.align = 2, .v.align = 2) },
> +};
> +
>  static const struct drm_exynos_ipp_limit rotator_4210_rbg888_limits[] = {
>  	{ IPP_SIZE_LIMIT(BUFFER, .h = { 8, SZ_16K }, .v = { 8, SZ_16K }) },
>  	{ IPP_SIZE_LIMIT(AREA, .h.align = 4, .v.align = 4) },
> @@ -372,6 +377,11 @@ static const struct drm_exynos_ipp_limit rotator_5250_rbg888_limits[] = {
>  	{ IPP_SIZE_LIMIT(AREA, .h.align = 2, .v.align = 2) },
>  };
>  
> +static const struct drm_exynos_ipp_limit rotator_s5pv210_yuv_limits[] = {
> +	{ IPP_SIZE_LIMIT(BUFFER, .h = { 32, SZ_64K }, .v = { 32, SZ_64K }) },
> +	{ IPP_SIZE_LIMIT(AREA, .h.align = 8, .v.align = 8) },
> +};
> +
>  static const struct drm_exynos_ipp_limit rotator_4210_yuv_limits[] = {
>  	{ IPP_SIZE_LIMIT(BUFFER, .h = { 32, SZ_64K }, .v = { 32, SZ_64K }) },
>  	{ IPP_SIZE_LIMIT(AREA, .h.align = 8, .v.align = 8) },
> @@ -382,6 +392,11 @@ static const struct drm_exynos_ipp_limit rotator_4412_yuv_limits[] = {
>  	{ IPP_SIZE_LIMIT(AREA, .h.align = 8, .v.align = 8) },
>  };
>  
> +static const struct exynos_drm_ipp_formats rotator_s5pv210_formats[] = {
> +	{ IPP_SRCDST_FORMAT(XRGB8888, rotator_s5pv210_rbg888_limits) },
> +	{ IPP_SRCDST_FORMAT(NV12, rotator_s5pv210_yuv_limits) },
> +};
> +
>  static const struct exynos_drm_ipp_formats rotator_4210_formats[] = {
>  	{ IPP_SRCDST_FORMAT(XRGB8888, rotator_4210_rbg888_limits) },
>  	{ IPP_SRCDST_FORMAT(NV12, rotator_4210_yuv_limits) },
> @@ -397,6 +412,11 @@ static const struct exynos_drm_ipp_formats rotator_5250_formats[] = {
>  	{ IPP_SRCDST_FORMAT(NV12, rotator_4412_yuv_limits) },
>  };
>  
> +static const struct rot_variant rotator_s5pv210_data = {
> +	.formats = rotator_s5pv210_formats,
> +	.num_formats = ARRAY_SIZE(rotator_s5pv210_formats),
> +};
> +
>  static const struct rot_variant rotator_4210_data = {
>  	.formats = rotator_4210_formats,
>  	.num_formats = ARRAY_SIZE(rotator_4210_formats),
> @@ -414,6 +434,9 @@ static const struct rot_variant rotator_5250_data = {
>  
>  static const struct of_device_id exynos_rotator_match[] = {
>  	{
> +		.compatible = "samsung,s5pv210-rotator",
> +		.data = &rotator_s5pv210_data,
> +	}, {
>  		.compatible = "samsung,exynos4210-rotator",
>  		.data = &rotator_4210_data,
>  	}, {
> 
