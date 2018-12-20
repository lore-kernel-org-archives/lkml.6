Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C69C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C589D206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HdF8DGGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbeLTQnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:43:01 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58678 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbeLTQnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:43:00 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181220164259euoutp02ce1f5ac493d7f3b73db3fbd5f3baab55~yGCdeMBq10614606146euoutp02D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 16:42:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181220164259euoutp02ce1f5ac493d7f3b73db3fbd5f3baab55~yGCdeMBq10614606146euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545324179;
        bh=5tVfjnbzRFa3mICddZwU/vbfaEPMfgDWAAyooERIFo8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HdF8DGGgu3P4KGYc7sr7IBn7cG8X+aT3FTEsXiSD9NdFTLfA7KIyWaX2dg5pksqsx
         Scn08G6NV+/kKVH66alRHXJGv4E7T0u7x5WRxM9CjIYkc+Fml80gubfw7zRnpvYLkt
         HSOD8oWyFxSEitpF0J+rfN9e3Xgd+/JD98v3tvWs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220164258eucas1p25af43ea0a506b794c6ec2b844e01a134~yGCcfbsBO2918629186eucas1p2s;
        Thu, 20 Dec 2018 16:42:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 04.87.04806.296CB1C5; Thu, 20
        Dec 2018 16:42:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181220164257eucas1p1cabbeee44fdf0f85e7dadaef059a8243~yGCbwG_IT2168721687eucas1p1_;
        Thu, 20 Dec 2018 16:42:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181220164257eusmtrp1234fc78a767b7a06faca98e1d737a436~yGCbhzUai1901719017eusmtrp1d;
        Thu, 20 Dec 2018 16:42:57 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-47-5c1bc69205b4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CD.27.04284.196CB1C5; Thu, 20
        Dec 2018 16:42:57 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181220164257eusmtip2d316bc7d80e50d66e0bb1cfda43f0066~yGCbP4qfa0433904339eusmtip24;
        Thu, 20 Dec 2018 16:42:57 +0000 (GMT)
Subject: Re: [PATCH] video: clps711x-fb: release disp device node in probe()
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Alexander Shiyan <shc_work@mail.ru>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <05f1c984-ddda-6a83-32dd-e96756eac916@samsung.com>
Date:   Thu, 20 Dec 2018 17:42:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1541197423-31560-1-git-send-email-khoroshilov@ispras.ru>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87qTjknHGCx5yWFx5et7Nosd63ay
        Wyzv7mKxONH3gdXi8q45bBaTdkg5sHnM+DeV0ePO67+sHve7jzN5TJl7hNXj8ya5ANYoLpuU
        1JzMstQifbsEroyvn88wF3zlqnh9+jVrA+MPji5GTg4JAROJ+Ut2s3UxcnEICaxglOj72Azl
        fGGUWP/7CpTzmVGif+EHVpiWVxeOMEIkljNKLDnZxAzhvGeU2L+tj72LkYNDWMBHYv9td5AG
        EQE9iY+vtjKB1DALLGWU2NP1mAkkwSZgJTGxfRUjiM0rYCfR9eMAG4jNIqAqseHNXSaQOaIC
        ERL9Z9QhSgQlTs58wgJicwq4SUzZdQOslVnAQOLIojmsELa8xPa3c8DukRCYxy6x5NUvJoir
        XSQ2tB5lhrCFJV4d38IOYctInJ7cwwLRMJ1R4s2vpVDOekaJNWeOQXVbSxw+fhHqf0eJhVMP
        gX0pIcAnceOtIMRmPolJ26YzQ4R5JTrahCCq1SQ2LNvABrOra+dKqBs8JPYs3cg2gVFxFpLf
        ZiH5ZxaSfxYwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITDKn/x3/uoNx35+kQ4wC
        HIxKPLwau6RjhFgTy4orcw8xSnAwK4nwrj8EFOJNSaysSi3Kjy8qzUktPsQozcGiJM5bzfAg
        WkggPbEkNTs1tSC1CCbLxMEp1cC45KzN0ptmzbucXj41z/3McHqv3tGU9Z2BhiX3F6rGpzxb
        VRzdv8JI9ePOt7t6Fh8w0MlqZNHrOlV98Ues037n1xwflV/uvL944asMG+mCjvP5H79ejFP7
        wztTrzM+dvWSLu3n0uJ7XnW/3qhxWtbjzsm9h9a6rJz+9W1w6p+N/3bx9rP91Ff4rMRSnJFo
        qMVcVJwIAFdQmTEuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7oTj0nHGNxokLC48vU9m8WOdTvZ
        LZZ3d7FYnOj7wGpxedccNotJO6Qc2Dxm/JvK6HHn9V9Wj/vdx5k8psw9wurxeZNcAGuUnk1R
        fmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbXz2eYC75y
        Vbw+/Zq1gfEHRxcjJ4eEgInEqwtHGLsYuTiEBJYySkyd95qli5EDKCEjcXx9GUSNsMSfa11s
        EDVvGSUOL3vJBFIjLOAjsf+2O0iNiICexMdXW5kgamYySrz4sRWsgRlk6MYzE5hBqtgErCQm
        tq9iBLF5Bewkun4cYAOxWQRUJTa8ucsEYosKREjcetjBAlEjKHFy5hMwm1PATWLKrhtgvcxA
        23Zc/8UKYctLbH87h3kCo+AsJC2zkJTNQlK2gJF5FaNIamlxbnpusaFecWJucWleul5yfu4m
        RmDkbDv2c/MOxksbgw8xCnAwKvHwauySjhFiTSwrrsw9xCjBwawkwrv+EFCINyWxsiq1KD++
        qDQntfgQoynQExOZpUST84FRnVcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUI
        po+Jg1OqgVHzj0jKTMkNLX7fNQVOyGxKmnXNUSXy/v5fNuXy1nMPSrUXfgx++mv2ox3cc/hP
        rzCf8SFgR4cY+98LKcUKthW7Wh65zhfJOqHSKOqY7SqdFaFdELEuSOLJPovXf86svBOft3Gy
        ouuUGwpcp83mvz+7XdJuuvuPvNhDiVqFZ/h7doXJnnoVu1GJpTgj0VCLuag4EQALP6aZsgIA
        AA==
X-CMS-MailID: 20181220164257eucas1p1cabbeee44fdf0f85e7dadaef059a8243
X-Msg-Generator: CA
X-RootMTR: 20181102222440epcas1p3ccba6957ba132ddbbc6e32d6ff912062
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181102222440epcas1p3ccba6957ba132ddbbc6e32d6ff912062
References: <CGME20181102222440epcas1p3ccba6957ba132ddbbc6e32d6ff912062@epcas1p3.samsung.com>
        <1541197423-31560-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ added dri-devel ML to Cc: ]

On 11/02/2018 11:23 PM, Alexey Khoroshilov wrote:
> clps711x_fb_probe() increments refcnt of disp device node by
> of_parse_phandle() and leaves it undecremented on both
> successful and error paths.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Patch queued for 4.21, thanks.

> ---
>  drivers/video/fbdev/clps711x-fb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
> index ff561073ee4e..42f909618f04 100644
> --- a/drivers/video/fbdev/clps711x-fb.c
> +++ b/drivers/video/fbdev/clps711x-fb.c
> @@ -287,14 +287,17 @@ static int clps711x_fb_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = of_get_fb_videomode(disp, &cfb->mode, OF_USE_NATIVE_MODE);
> -	if (ret)
> +	if (ret) {
> +		of_node_put(disp);
>  		goto out_fb_release;
> +	}
>  
>  	of_property_read_u32(disp, "ac-prescale", &cfb->ac_prescale);
>  	cfb->cmap_invert = of_property_read_bool(disp, "cmap-invert");
>  
>  	ret = of_property_read_u32(disp, "bits-per-pixel",
>  				   &info->var.bits_per_pixel);
> +	of_node_put(disp);
>  	if (ret)
>  		goto out_fb_release;
>  

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
