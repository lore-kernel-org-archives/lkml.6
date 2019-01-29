Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A87C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D07A20857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="obuEOlm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfA2Ikj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:40:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56121 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfA2Iki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:40:38 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190129084036euoutp0230c4ce4a5894c713a41ba81dc7b1e2de~_RQtcYTVI1974419744euoutp02O
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 08:40:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190129084036euoutp0230c4ce4a5894c713a41ba81dc7b1e2de~_RQtcYTVI1974419744euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548751236;
        bh=mpVff15XUR2HT1fVajMRfi77iegXSvo4d2OfXVhiKq4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=obuEOlm08JMFDIkpclwgDd9CJ7ceLHNTwkmAzLpoc9ZHx8Frs19IUDkJfoecuqsgG
         7aTsxXkN2mPbmPYPGbvwLbK6HfGrD1wpxM3whihZ/PjLnhSoeAmHu4nrN7KvW8hp3K
         RdEDjeDvmeWVIpLitNJqfvuz6CCf3V62FyOnS5Fs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190129084036eucas1p1c199606e801e7ed49c8f9e8f5d322037~_RQsviYPJ0827908279eucas1p1e;
        Tue, 29 Jan 2019 08:40:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 44.BA.04441.381105C5; Tue, 29
        Jan 2019 08:40:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190129084035eucas1p1ff0667649d889ac5851ffc92eabc9328~_RQrw841Q2871828718eucas1p1S;
        Tue, 29 Jan 2019 08:40:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190129084034eusmtrp117316e66d27215c2f4a53ae0c2bf5ccf~_RQrg-HMQ2151021510eusmtrp1L;
        Tue, 29 Jan 2019 08:40:34 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-35-5c5011837e98
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3A.80.04284.281105C5; Tue, 29
        Jan 2019 08:40:34 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190129084033eusmtip18a99ed48f6d9370100013fb5b89f012c~_RQqdZz7r2738627386eusmtip1T;
        Tue, 29 Jan 2019 08:40:33 +0000 (GMT)
Subject: Re: [PATCH] drm/exynos: gsc: Variable "gscblk_cfg" in function
 gsc_set_gscblk_fimd_wb() could be uninitialized
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <455d9474-253d-7f1c-f312-08dffad242f3@samsung.com>
Date:   Tue, 29 Jan 2019 09:40:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128182851.8558-1-yzhai003@ucr.edu>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj22zk7O642jtPw1axklGDgZVBwxDKlfox+mFgQ6SBXHm95a1Pz
        QuQ1c5qXSaRLqR9WskhlmVsGoSucJrq8lCKYkpqXNPFupJbb0fLf8z6X730f+EhMNMx1JqPj
        kxhFvDxWTPDxprZf3R45dkEy77JCH/p+dweHXh8o59D9K/MErR4pxemprz04XTL2A6PN5gYe
        3ZU9y6N1Y1+4dF9zFUFXmN9x6IryaYJueZmP6JbVOeQvlOYWVSOpTltASPWro1zpSKGJI31V
        c0da3KhFUs2jzxzpku5wEBnCPxXOxEanMAovvzB+VFb5OJE4vC9V/TYXy0Q9tipkSwJ1AkbL
        mjAV4pMiqhbBZtHGzrCMYKHzAY8dlhAMtXzn7EaqP0xwWeE5gub64h3XPIKnmf24xWVPpYFq
        fpKwYAfqEMxsLVgTGNWKQXvJNLIIBCUB1ZzKahJQfqCv7LDyOHUMKqZrtwMkeYCSQV4fn7XY
        QUfluPV9W+oktLwxci0Yo46Afq4KY7EjDI0/5lh2AbXCg7qfapw9+xx0zbYjFtvDjKmRx2IX
        6CwvwtlADoL8Cg2PHYoQvK4yEKzLF96beqwXYZQ71Dd7sXQAVNYsYhYaKCEMztmxRwhB3fRw
        hxbAvbsi1u0GGlPdv7Wtn3qxUiTW7Kmm2VNHs6eO5v/eJwjXIkcmWRkXySgl8cwtT6U8Tpkc
        H+l5PSFOh7Y/XeeWadGAVnqvGRFFIvF+gTdxQSbiylOUaXFGBCQmdhBIfm9TgnB5WjqjSLiq
        SI5llEZ0kMTFjoIMm9FQERUpT2JuMEwio9hVOaStcybSB6RuzOJ/0iPMfjZnZSvBMi/jRd75
        ybzmBSE/I0K9fNpVGBims++w0TZt3XZdi5FM5Is9bPwds0sa+s0utR/pmIHawZsCl2DvoJyR
        AvKbb6DAR+s+M5i1HNDo5H3JbUqBymI2Q1WV3VlnQiZiDTltz+r6nY5eNqxfyVhLfdEgxpVR
        cslxTKGU/wW1LBJwcAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsVy+t/xu7pNggExBstmG1j0njvJZPHj+mQm
        iytf37NZTLo/gcXixb2LLBb9j18zW5w/v4Hd4mzTG3aLTY+vsVpc3jWHzWLG+X1MFjMmv2Sz
        OLC2ndHiwLe3jA58Hi09cxk9Nq3qZPPY/u0Bq8f97uNMHpuX1Hv0bVnF6DFr9lUmj8+b5AI4
        ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyGic/
        YSu4y10xaXcLcwPjRc4uRk4OCQETiblHnrJ2MXJxCAksZZQ4OP8XE0RCRuLktAZWCFtY4s+1
        LjaIoreMEu/XtLKBJIQFKiW63j8Hs0UEZCVe/fsI1sAscJBZ4tZsXYiGDkaJbfNughWxCRhK
        dL3tArN5Bewkts88yQhiswioSsx4uQKsWVQgRmLWkz52iBpBiZMzn7CA2JwCphIHdh6CWqAu
        8WfeJWYIW15i+9s5ULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2yoV5yY
        W1yal66XnJ+7iREY2duO/dy8g/HSxuBDjAIcjEo8vAZs/jFCrIllxZW5hxglOJiVRHgNfwOF
        eFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YdPJK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmk
        J5akZqemFqQWwfQxcXBKNTDmrnt40zY1l8vs4Sr1SckX/r26uezjt6dGayLurtuybl7Npp1t
        El+25W6591YyisXAxeGFe7PQ6n+3JzyJuMUw4/uffg/7VunlDgrqnvOFpzn/X6Fyu1d//qIW
        Bq4l3IqNJ35Uc92+IHlWfc+Pl/sfTzD+E9oyr1jM7qP5OlY+k895U5Y+1/2mrMRSnJFoqMVc
        VJwIAHSPy4kCAwAA
X-CMS-MailID: 20190129084035eucas1p1ff0667649d889ac5851ffc92eabc9328
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190128184257epcas2p1575d038676762164323e1946dffd1113
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128184257epcas2p1575d038676762164323e1946dffd1113
References: <CGME20190128184257epcas2p1575d038676762164323e1946dffd1113@epcas2p1.samsung.com>
        <20190128182851.8558-1-yzhai003@ucr.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2019-01-28 19:28, Yizhuo wrote:
> In function gsc_set_gscblk_fimd_wb(), local variable "gscblk_cfg"
> could be uninitialized of function regmap_read returns -EINVAL.
> However, this value will be  write to the register after "or"
> operation. This is potentially unsafe.
>
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_gsc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> index 0506b2b17ac1..b1d0f974fe80 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> @@ -441,11 +441,16 @@ static int gsc_sw_reset(struct gsc_context *ctx)
>  static void gsc_set_gscblk_fimd_wb(struct gsc_context *ctx, bool enable)

This function has been completely removed in mainline kernel by commit
8b7d3ec83aba ("drm/exynos: gsc: Convert driver to IPP v2 core API"), so
there is no need for any fix anymore.

>  {
>  	unsigned int gscblk_cfg;
> +	int ret;
>  
>  	if (!ctx->sysreg)
>  		return;
>  
> -	regmap_read(ctx->sysreg, SYSREG_GSCBLK_CFG1, &gscblk_cfg);
> +	ret = regmap_read(ctx->sysreg, SYSREG_GSCBLK_CFG1, &gscblk_cfg);
> +	if (ret) {
> +		DRM_ERROR("gsc: Fail to read system register\n");
> +		return;
> +	}
>  
>  	if (enable)
>  		gscblk_cfg |= GSC_BLK_DISP1WB_DEST(ctx->id) |

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

