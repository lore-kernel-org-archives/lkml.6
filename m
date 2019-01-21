Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4563CC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF65E2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l8qKDjEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfAUJ4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:56:51 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47379 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfAUJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:56:50 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190121095649euoutp02006acdb6ef520f2631bd3a4abf70d702~71I9tEVrz2880828808euoutp02w
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 09:56:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190121095649euoutp02006acdb6ef520f2631bd3a4abf70d702~71I9tEVrz2880828808euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548064609;
        bh=gAeUY3NdYAY5YJdeVEXrL6jG4LkqBcVSY6RfdqMMW2I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l8qKDjEayk4Yr96K0AIbmfDa9VTITkcdCTGQlDcKXX60DuNJdZ17TvafQWUYP9Ilq
         ndE8+R34w5dtWXoTAJ8IBa2OMB/yezOUarOqXi5kJDoFF+sCiGeTO2Nn7YRRkCVkRZ
         gTsWuiV2txg9hB122N0szzRNwrXaCyDNVInzWp1U=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190121095648eucas1p21816af0a6ea41aacdbf4f447f0fa64db~71I9Cz1wK2631826318eucas1p2A;
        Mon, 21 Jan 2019 09:56:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BA.B3.04806.067954C5; Mon, 21
        Jan 2019 09:56:48 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190121095647eucas1p2c01e40031159e1f5399f5074ad8635c5~71I8I9rCU2510325103eucas1p2r;
        Mon, 21 Jan 2019 09:56:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190121095647eusmtrp10ed828af62112af5ec11f98d3d996d25~71I76gjmF1832718327eusmtrp15;
        Mon, 21 Jan 2019 09:56:47 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-6e-5c4597609a25
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D7.E5.04284.F57954C5; Mon, 21
        Jan 2019 09:56:47 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190121095646eusmtip157d9fe7677eac156ad0e380c24bd119d~71I7ZUW5y0133101331eusmtip1b;
        Mon, 21 Jan 2019 09:56:46 +0000 (GMT)
Subject: Re: [PATCH] usb: dwc3: exynos: Fix error handling of
 clk_prepare_enable
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <abc0f943-1d34-cc44-dc65-0428d6188354@samsung.com>
Date:   Mon, 21 Jan 2019 10:56:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547846257-19970-1-git-send-email-khoroshilov@ispras.ru>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2znbzmbHvh01XyoURnaDTM3ggNENrUEQaQWZo1p20MjN2Lzk
        BTJiVlOwe9taVJIplrbmJbutWuUpitTUMCkVtD+uqaRWRlmdnSz/Pd/7PM/7vA98FMHUSedQ
        +wxZnNGgy1DLlGRj88TrpbvPJ2ijHlyfzTYXD8jZsn4vwTbV3pGzLS1OOVtZYiFZV/9bKdt+
        1yFjrS1uCVt+zUysUWisk2eRxlV9XKZ57/0p1dRdPaQZdYVtlu5QrtzLZezL4YzLVu1Wpj/q
        tJEHOhQHJ+rvSYvQkNyCFBTgWPhkvUdYkJJicBUCX8Okn2DwGAK+b5tIjCL4dew5MeXwVPBy
        kahEMGGrkYiOYQTOMZWAg3ASvDPbkICDcSJM9DYiwUDgIQTFtZ3+TTIcDRafRSZgGq+CseFe
        /yISR8A5c/OfBIoKwVowtytFiQpe2AZIASvweqhwXvTLCRwOt30OQsSh0D1wSSJkAXbLoYr/
        SYpXx8No+00k4iAY5Ov/9p8HL0+XkqLhCIKjVrtcfJQiaHA0yURVHDzh26TCRQReDDfvLhPH
        a6HG2S8RxoADocunEo8IhFON5wlxTMOxYkZULwA7X/sv9nHrG+IEUtunVbNPq2OfVsf+P/cy
        IqtRKJdt0qdxpuUGLjfSpNObsg1pkamZehf685VeTvLjTcj9Y48HYQqpZ9LfeuK1jFSXY8rT
        exBQhDqY9m5I0DL0Xl1ePmfM3GXMzuBMHjSXItWhdMGMvhQGp+myuP0cd4AzTrESSjGnCD3N
        m5XvKwz7wnSsI1LDV8ds3RL7fWfg/PFNlSMVM+MT8UlnyEP3D7c72ZO68GTU19Tmj8m9ddvb
        Fl2oDxssKNm4gsdxSWULy1UpZ+CDN9Ehb3LfHu76nMtERmuf9QVga8StVvroYE/Jq3zzufuq
        G4dHXBti6LIr47bwx92Fu5gANWlK10UvIYwm3W+ItTtqRgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7rx011jDFa9ELM41vaE3aL/8Wtm
        ix3rdrJbnD+/gd1ieXcXi8Wmx9dYLS7vmsNmMeP8PiaLRctamR04PWb8m8rosWlVJ5vHndd/
        WT02L6n3+LxJLoA1Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUn
        syy1SN8uQS/jwNWZLAVXOCt+btnN2sD4jr2LkZNDQsBE4tDS40A2F4eQwFJGibv79rNAJGQk
        Tk5rYIWwhSX+XOtigyh6yyjx5s5TsG5hgSCJm60zGUFsEYFAifmvboDFmQXeMUrMuyEFYgsJ
        zGSUuPe5GsRmEzCU6HoLMoiTg1fATuLL+/tMIDaLgKrEtNZjYL2iAjESs570sUPUCEqcnPkE
        7CBOATeJpRvmMkHMV5f4M+8SM4QtL7H97RwoW1zi1pP5TBMYhWYhaZ+FpGUWkpZZSFoWMLKs
        YhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzDbcd+bt7BeGlj8CFGAQ5GJR7eH/dcYoRYE8uK
        K3MPMUpwMCuJ8L52d40R4k1JrKxKLcqPLyrNSS0+xGgK9NxEZinR5HxgisgriTc0NTS3sDQ0
        NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp1cAoOV0nQ17l69ztzRElMok8Jz47yqlF
        2C9R2sctx3n/8a0liUssn0obv9t5VYhDPMPX6XFTU4BfmlO5zaZ5Cmm2PJ7hd8716R241Oxk
        2vnhvVU3V7/bq6yn8o93fF2Q+seK57/MhAqv7VMd+rz8TLJdwz/xfY/WNJLtm+me9G77K+lD
        UwP+lymxFGckGmoxFxUnAgDuHpbp2QIAAA==
X-CMS-MailID: 20190121095647eucas1p2c01e40031159e1f5399f5074ad8635c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190118211823epcas1p32d11bff9f7822eb48c0387c85a94da70
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190118211823epcas1p32d11bff9f7822eb48c0387c85a94da70
References: <CGME20190118211823epcas1p32d11bff9f7822eb48c0387c85a94da70@epcas1p3.samsung.com>
        <1547846257-19970-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On 2019-01-18 22:17, Alexey Khoroshilov wrote:
> If clk_prepare_enable() fails in dwc3_exynos_probe(),
> exynos->clks[0] is left undisabled because of usage
> preincrement in while condition.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 9f2168367a0a ("usb: dwc3: exynos: Rework clock handling and prepare for new variants")

My fault. There is also a similar issue dwc3_exynos_resume(), so please
fix it too if possible.

> ---
>  drivers/usb/dwc3/dwc3-exynos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index cb7fcd7c0ad8..e7f6cff27b9a 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -78,7 +78,7 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>  	for (i = 0; i < exynos->num_clks; i++) {
>  		ret = clk_prepare_enable(exynos->clks[i]);
>  		if (ret) {
> -			while (--i > 0)
> +			while (i-- > 0)
>  				clk_disable_unprepare(exynos->clks[i]);
>  			return ret;
>  		}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

