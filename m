Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E67DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6DF20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f0Duwm3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6DF20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbeKZSly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:41:54 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:15275 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeKZSly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:41:54 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181126074836epoutp0416d52cd0f53b6ba816b1f98fbaf3f061~qnRBlirmJ1832618326epoutp04A;
        Mon, 26 Nov 2018 07:48:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181126074836epoutp0416d52cd0f53b6ba816b1f98fbaf3f061~qnRBlirmJ1832618326epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543218516;
        bh=gaw7OYCeNg3OE/YOc+BMAZKKNprMv+436me6gkik/2I=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=f0Duwm3CjLEiaFRVZeXWzNqdW5htoGipiX49n0a/SvC2SBUU4OeZlN7tXNlzBzJbL
         4s1hxm1qbmyzY+dJCI3HAA+Sv9YTc+BEaDlk3F51y3PKehDnENP5O11c9BkWBb6p40
         9r6dXr98Ml+C9nnCJmkD5gCeGuyR63th5fVVwjqs=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181126074833epcas1p13abb523efee333dd5686ce2867334fa6~qnQ-FyBLg0277802778epcas1p1Y;
        Mon, 26 Nov 2018 07:48:33 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.1E.04060.155ABFB5; Mon, 26 Nov 2018 16:48:33 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181126074833epcas1p1b203461f1b8d36a08fac32490f5bf338~qnQ_v_YAE0277802778epcas1p1X;
        Mon, 26 Nov 2018 07:48:33 +0000 (GMT)
X-AuditID: b6c32a37-429ff70000000fdc-42-5bfba55135a3
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 1B.5F.03601.055ABFB5; Mon, 26 Nov
        2018 16:48:32 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PIS00MYAJ0WNR10@mmp2.samsung.com>; Mon, 26 Nov 2018 16:48:32 +0900 (KST)
Message-id: <5BFBA550.4020401@samsung.com>
Date:   Mon, 26 Nov 2018 16:48:32 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Anand Moon <linux.amoon@gmail.com>, Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>
Subject: Re: [PATCH 1/3] clk: samsung: exynos5420: add VPLL rate table for
 g3d clock
In-reply-to: <20181123094413.1108-1-linux.amoon@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3uPiyXv6bVr0VlN4pcabvO6TVcLy0GFRlFhP5hF72ouBe7
        UyqKBmIPeyllybBMKyKpOWelvWWagZWvSkzSQC20h2Zamma17SL5z49zvudzDuec36EweQmh
        oNKNVt5i5PQ0MUN6tzZEFbrj2kSiarQ4iO1wNOJscZ3nOdPzGWObmpwk6+ppw9mhk104++p+
        EcEWNj2WsI6KDpItP/8LZ1saNrE5j+pItvbLUZz901YhZcvu/wbrA3SD7Tmk7p69k9S5yo4T
        usqrh3Wnb5cB3bBrUTyRkBGTxnMpvCWYNyabUtKNqVp6y86k2CRNpIoJZaLZKDrYyBl4LR23
        NT50c7re0zEdnMXpMz1SPCcI9Oq1MRZTppUPTjMJVi3Nm1P05mhzmMAZhExjaliyybCGUanC
        NR5wb0baSP0NYP4r3+fIPiWxgaGAXOBHIRiBJt39IBfMoOSwGqCBz+Wk6IwCNFjVLZ2iBlzv
        CDHgBMg2/p3wBmRwNho72+WBKAqDi1Fda4ZXxmAIuvNgqlAnQPm9zUDklaiiv4Dw8lK4DLV9
        MHplwiM/6Wv3lQyAS9CbsR4fPgfuQfeKf5JeOwj2A3RhyNcDBuskqHvoBeYNBMLd6OPxl75k
        P7gG5Q++9kEIniVRy6WXpDhBHJr8NIKJdiD69Ow26W0CwQWo9alW5I8CNNKXjYtOHkDfGiol
        YoIafSzJlYijzUIDP07iYrIMHTsiFxEdOlE/jIsTnwKoxlkK8sBC+7Ql2f8vyT5tSZcBVgbm
        8mbBkMoLjFk9/ftcwHeeyqhq4Gzc6gaQArS/LG98PFGOc1nCfoMbIAqjg2Tbrk4kymUp3P4D
        vMWUZMnU84IbaDw7zscUc5JNnmM3WpMYTbharWYjmEgNw9DzZL2Ki4lymMpZ+QyeN/OWqTwJ
        5aewgazqXetix5wrC9vjhm9l1Sx4AXeW3/xaf/39quWj2TP5vvFmxfOCoMqigBPZyzoctnqZ
        o2tjg6XxUMK5cPe659ud+QKx/EFkQUhMUbRp8uDSu62lTv+NvVgBs/jKXBipbFS0rtiwz/7r
        QlFLadX8qB95sjFzle2tlohQuh/6jx520lIhjWOUmEXg/gEUbfhptAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e+xoG7A0t/RBusXW1jcWneO1WL+ESDR
        //g1s8X58xvYLTY9vsZq8bHnHqvF5V1z2CxmnN/HZLFu4y12i/XTfrJaXDzlatG69wi7xeE3
        7awW/65tZLFYtesPowO/x/sbreweO2fdZffYtKqTzWPzknqPvi2rGD0+b5ILYIvisklJzcks
        Sy3St0vgyvhybCVjwX+hinXNvUwNjB/5uxg5OSQETCTebbrD1sXIxSEksI5R4u+qj6wgCV4B
        QYkfk++xdDFycDALyEscuZQNEmYWUJeYNG8RM0T9fUaJI5M3s0PUa0lsfDmVDaSeRUBV4trT
        PJAwG1B4/4sbbCA2v4CixNUfjxlBSkQFIiS6T1SCjBEReMkoMe/Jd3YQh1ngCJPEx43NrCBF
        wgJhEnP6+SF29TNK/FjzFGwXp4CVxMT3V9gmMArMQnLqLIRTZyE5dQEj8ypGydSC4tz03GKj
        AsO81HK94sTc4tK8dL3k/NxNjMAI2nZYq28H4/0l8YcYBTgYlXh4X/z5FS3EmlhWXJl7iFGC
        g1lJhNd3ye9oId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry3845FCgmkJ5akZqemFqQWwWSZODil
        Ghj7IhPX3glo6j31XWLB7jtfCuaV6l6+5Nc5SU6j3s9tevPt7s3yLifjVt5/NLmOhXfnb49/
        xxmStIUtD1+fVJzCcnqtN4f9WxOB8OtL/F1MGWViPOQTPld8+bv7BatQ/MQp1fb5X3+JV86y
        MmD5rGTEOIklVzU1RHfXqsWCRlNWaixseJ0odUmJpTgj0VCLuag4EQA0ugMWnAIAAA==
X-CMS-MailID: 20181126074833epcas1p1b203461f1b8d36a08fac32490f5bf338
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181123094453epcas4p16be0412e0195fe4bf06680111805352a
References: <CGME20181123094453epcas4p16be0412e0195fe4bf06680111805352a@epcas4p1.samsung.com>
        <20181123094413.1108-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 11월 23일 18:44, Anand Moon wrote:
> From: Marian Mihailescu <mihailescu2m@gmail.com>
> 
> A specific clock rate table is added for VPLL so it is possible
> to set frequency of the VPLL output clock that used by the g3d clock.
> 
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 34cce3c5898f..34156bdfd0d2 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1303,6 +1303,18 @@ static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>  	PLL_36XX_RATE(24 * MHZ,  32768001U, 131, 3, 5, 4719),
>  };
>  
> +static const struct samsung_pll_rate_table exynos5420_vpll_24mhz_tbl[] __initconst = {
> +	PLL_35XX_RATE(24 * MHZ, 600000000U, 200, 2, 2),
> +	PLL_35XX_RATE(24 * MHZ, 543000000U, 181, 2, 2),
> +	PLL_35XX_RATE(24 * MHZ, 533000000U, 533, 6, 2),
> +	PLL_35XX_RATE(24 * MHZ, 480000000U, 320, 4, 2),
> +	PLL_35XX_RATE(24 * MHZ, 420000000U, 140, 2, 2),
> +	PLL_35XX_RATE(24 * MHZ, 350000000U, 175, 3, 2),
> +	PLL_35XX_RATE(24 * MHZ, 266000000U, 266, 3, 3),
> +	PLL_35XX_RATE(24 * MHZ, 177000000U, 118, 2, 3),
> +	PLL_35XX_RATE(24 * MHZ, 100000000U, 200, 3, 4),
> +};

VPLL has the same PMS table with apll/kpll/bpll. You don't need to add new
'exynos5420_vpll_24mhz_tbl' table. Just adding the missing frequency entries
to 'exynos5420_pll2550x_24mhz_tbl' table.

> +
>  static struct samsung_pll_clock exynos5x_plls[nr_plls] __initdata = {
>  	[apll] = PLL(pll_2550, CLK_FOUT_APLL, "fout_apll", "fin_pll", APLL_LOCK,
>  		APLL_CON0, NULL),
> @@ -1428,6 +1440,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>  		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>  		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>  		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> +		exynos5x_plls[vpll].rate_table = exynos5420_vpll_24mhz_tbl;
>  	}
>  
>  	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
