Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35787C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC84920861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BH1qTI7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfAVIVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:21:01 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34382 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfAVIVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:21:01 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190122082059euoutp027d4925449a2adf1eb6437cdfd9c22264~8HekhzI-11770117701euoutp02v
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 08:20:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190122082059euoutp027d4925449a2adf1eb6437cdfd9c22264~8HekhzI-11770117701euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548145259;
        bh=ygU/l36li2oqtxJPf2FiPkYKY5wHwP6shXzalp/5FxY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BH1qTI7cCQjcVRazZpqhU9UfoSj9MWAIF0qL7qG72KRpzYenELXKe1azYe+AjYMKE
         yzXFzOw8Zrmt8FR8KlImgSTGVl7O5mz1frPeZr2UQZB1mIDf1l17bqbV6n4T1U4ZWz
         XWCWMB1OFeV87n7wEquYiqIgxopnT2NCxIsVCD9E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190122082058eucas1p15b1faa8d1619592e082b86f855342af2~8Hej_YsNH1718017180eucas1p1W;
        Tue, 22 Jan 2019 08:20:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C8.4F.04806.A62D64C5; Tue, 22
        Jan 2019 08:20:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190122082057eucas1p1533e37ce5ab90d422b6155e479c174a3~8HejA4Qen1689116891eucas1p1U;
        Tue, 22 Jan 2019 08:20:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190122082057eusmtrp1f2cec3efd56e3e3251bcae484dc3f5cd~8HeiyU_0m1234612346eusmtrp1J;
        Tue, 22 Jan 2019 08:20:57 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-c2-5c46d26a93a0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7C.EB.04284.962D64C5; Tue, 22
        Jan 2019 08:20:57 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190122082056eusmtip14189c28794cc1123a69cce8b437f4ce1~8HeiWdVPB1685016850eusmtip1I;
        Tue, 22 Jan 2019 08:20:56 +0000 (GMT)
Subject: Re: [PATCH v2] usb: dwc3: exynos: Fix error handling of
 clk_prepare_enable
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c781bb2f-aad0-84c5-3d6e-1c7ce93bc57f@samsung.com>
Date:   Tue, 22 Jan 2019 09:20:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548105830-26376-1-git-send-email-khoroshilov@ispras.ru>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUYRSG+3ZmdmeXXflcNQ9mCUsJRd7IH5OFFKnsr9AuRLqhU06r5Y0d
        7xUZodmmKJakk5VUaBhama5mZt5wM6P1gmJhGmkXvGR5RTCtdbT895xz3vO974GPJtTVlBMd
        GRPPGWLYKI1UQZraFixuZ7oDdJ5ppVKmLWNExuQMjxFMbcVzGWOxPJExpdeMJFM53EcxPXVF
        UqbA0iBh7pWkE/vk2oKlfKStLLsq1Q6M/aa0zx5c1E5XbgmkghV7w7moyETO4OEbpogYfPyT
        iutRJjcVT5FpSFAYkZwG7A39r+4TRqSg1fghguzRbEosZhC8br8tE4tpBMtZndTaynjXr9WV
        UgR35upWVZMI2t7/JK0qO3wUjFWthJXtcRAsDJmQVUTgHwgyKnpXBlLsBcYJo9TKKuwLwren
        yMok3gaDBeMSI6JpB6yD9B6FKLGF9sKRlfflOABMfeUSKxPYBWomigiRHeHDyF2J1Qtwgwxe
        3JiTiLH94O2XYUJkOxg1V8lEdoaO61mkuHAZwZUCQSYWWQiqi2qlomoPtJi7KGsiAm+Hx3Ue
        Yns/5E5PrQQFbAP9E7ZiCBvIM90kxLYKMjPUotoVBHPFP9umzm4iF2mEdacJ684R1p0j/Pct
        RmQZcuQS+Gg9x++K4ZLceTaaT4jRu5+Kja5Efz9Tx5J5thY1LJ5sRphGGqWKfuevU1NsIp8S
        3YyAJjT2Kv+uAJ1aFc6mpHKG2FBDQhTHN6NNNKlxVJ3b8ClEjfVsPHeW4+I4w9pUQsud0pCP
        c9hGT/ekG/VfzytLlD4XhovLL+lYz8PsjFtQgqC/bnlZdShHWb9Y6Bdyy1WfISyPL7dUByK2
        1zR/upN3UTRmT+6MD7CrHdj6PenjAeRavPnRfD5zML2vrTE3NPhNa/nx1nJvB92x5MyhE0e8
        z9nMBu/+nJcUe/eRL5uqwXSNhuQjWK8dhIFn/wD9K4xsSAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7qZl9xiDHo2c1gca3vCbtH/+DWz
        xY51O9ktzp/fwG6xvLuLxWLT42usFpd3zWGzmHF+H5PFomWtzA6cHjP+TWX02LSqk83jzuu/
        rB6bl9R7fN4kF8AapWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqT
        WZZapG+XoJdxb/0H1oLLPBUHF3xiaWCcxdXFyMkhIWAi8ebiR+YuRi4OIYGljBLbVzxlgUjI
        SJyc1sAKYQtL/LnWxQZR9JZR4k/zD0aQhLBAqETXliPMILaIQKDE/Fc32EFsZoF3jBLzbkhB
        NMxklLgx6z/YJDYBQ4mutyCTODl4BewkZj3fCDaIRUBV4t6MN0wgtqhAjMSsJ33sEDWCEidn
        PgG7iFPATWLbtbVMEAvUJf7Mu8QMYctLbH87B8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWM
        LKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI3HbsZ+bdzBe2hh8iFGAg1GJh5fjnGuMEGti
        WXFl7iFGCQ5mJRFe14tuMUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0wSeSXxhqaG5haW
        hubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGCd+EBe9VXTi6vnw4kcXA87rfBeY
        xVW9Q8fq4ue78ZuYrfItvf83rxftn1JzwaybnWnTOc5NfF1GrxR5GGbMk5NuFk/aMcNfoGuz
        6z+XzTWPBe6vs/jcbuz26MTjLnV3Jj6zGSd/McY/neX6xZp5rVnV87d9atyvO8tZ7r9pYDvy
        /uebzyfSVJVYijMSDbWYi4oTAW0GkqzaAgAA
X-CMS-MailID: 20190122082057eucas1p1533e37ce5ab90d422b6155e479c174a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190121212507epcas1p1f2b689e91046a2736ed26a84367c210a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190121212507epcas1p1f2b689e91046a2736ed26a84367c210a
References: <CGME20190121212507epcas1p1f2b689e91046a2736ed26a84367c210a@epcas1p1.samsung.com>
        <1548105830-26376-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On 2019-01-21 22:23, Alexey Khoroshilov wrote:
> If clk_prepare_enable() fails in dwc3_exynos_probe() or in
> dwc3_exynos_resume(), exynos->clks[0] is left undisabled
> because of usage preincrement in while condition.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 9f2168367a0a ("usb: dwc3: exynos: Rework clock handling and prepare for new variants")
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2: Add fix for the second instance in dwc3_exynos_resume() per Marek Szyprowski note.
>
>  drivers/usb/dwc3/dwc3-exynos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index cb7fcd7c0ad8..c1e9ea621f41 100644
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
> @@ -223,7 +223,7 @@ static int dwc3_exynos_resume(struct device *dev)
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

