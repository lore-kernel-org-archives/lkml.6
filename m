Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C70CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E188920663
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gDeLOT6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E188920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502586AbeKWUIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:08:00 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39112 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393864AbeKWUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:08:00 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181123092433euoutp0286ee932b0ba227caec349df45032b143~pto8V0eJG0193401934euoutp02k
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 09:24:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181123092433euoutp0286ee932b0ba227caec349df45032b143~pto8V0eJG0193401934euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542965073;
        bh=yrC1es2p8gxzb5TKuTgjXIVa/oSKTdIwduNLXk1X68U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gDeLOT6YjOQF/NOGgLDyi+TT09WeKUTW63EydLUlhKJa1cWac9iLomEitAe/xr/Dk
         YEQTgxy4iULwitsEHKMa8AaKgCRojeQEHK2xMLrin19qvNRh5nQMuP2y2A7NlJzUf0
         /nXgmqhXW3O76dkGuGt2vtJ7aJjuZrQ7FYumj6lg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181123092430eucas1p1c3dbd2438a3bf18b16ab6069828eb89d~pto6STAOS0776807768eucas1p1R;
        Fri, 23 Nov 2018 09:24:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A5.61.04806.E47C7FB5; Fri, 23
        Nov 2018 09:24:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181123092429eucas1p2e67d28b703e12eccd9e145f3ad407914~pto5blkZM0297002970eucas1p2A;
        Fri, 23 Nov 2018 09:24:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181123092429eusmtrp19ed4d58aa5f323151cba532588da9c49~pto5LwOY20122801228eusmtrp1d;
        Fri, 23 Nov 2018 09:24:29 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-ce-5bf7c74e5c4e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 56.2A.04128.D47C7FB5; Fri, 23
        Nov 2018 09:24:29 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181123092429eusmtip15c3863dbeb2e043519f2cb0b21bab0cf~pto43bm481461414614eusmtip1D;
        Fri, 23 Nov 2018 09:24:29 +0000 (GMT)
Subject: Re: [PATCH 1/3] regulator: wm8994: Revert back to using devres
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a57ae625-222d-09eb-62a2-f2262d8a4914@samsung.com>
Date:   Fri, 23 Nov 2018 10:24:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7p+x79HG3SfULCY+vAJm8WV1k2M
        Ft+udDBZTPmznMni8q45bBaf3+9ndWDz2DnrLrvHplWdbB53ru1h85g+5z+jx+dNcgGsUVw2
        Kak5mWWpRfp2CVwZP/6tYCnYIVSxb9JelgbGt3xdjJwcEgImEvvP/mbqYuTiEBJYwShxZuYv
        RgjnC6PE3r1bWCCcz4wST/6+YoVpefTyMTuILSSwHKjqezRE0XtGiR2T/7KBJIQF3CXO3P/M
        CGKLCLhJvL6/hhnEZhYokPjW+wTMZhMwlOh62wVWzytgJzHp/H+woSwCqhInTywCWyYqECNx
        bOUNRogaQYmTM5+wgNicAs4Sq1ouM0HMlJfY/nYO1HxxiVtP5oP9IyGwil1i2qxTzBBXu0h0
        3NzHCGELS7w6voUdwpaROD25hwWioZlRon3GLHYIp4dRYuucHWwQVdYSh49fBDqJA2iFpsT6
        XfoQYUeJmQc3soGEJQT4JG68FYQ4gk9i0rbpzBBhXomONiGIajWJWcfXwa09eOES8wRGpVlI
        XpuF5J1ZSN6ZhbB3ASPLKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMDUc/rf8a87GPf9
        STrEKMDBqMTDu2Hjt2gh1sSy4srcQ4wSHMxKIrxNit+jhXhTEiurUovy44tKc1KLDzFKc7Ao
        ifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTDOaxZ403h7vfCR4wvO2+0xMVB4Lnct4lR14yz1
        X7s+BmdZJsz4dIvR5uK1lqeeZb9mJEfNrVuax3HmzcE4h5tLDqn0Xo+t8DMwm37G5NZFplc5
        V1OsWR5x7nDYXhBwTZOzOXOR6IIzoj56TREBtif8xS0/Hp+7wcogSe5vTPWvd3F+bhMCbe4q
        sRRnJBpqMRcVJwIAJi1APzkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xu7q+x79HG2y8pWIx9eETNosrrZsY
        Lb5d6WCymPJnOZPF5V1z2Cw+v9/P6sDmsXPWXXaPTas62TzuXNvD5jF9zn9Gj8+b5AJYo/Rs
        ivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyfvxbwVKw
        Q6hi36S9LA2Mb/m6GDk5JARMJB69fMzexcjFISSwlFHiwLEnTBAJGYmT0xpYIWxhiT/Xutgg
        it4ySjzfMosdJCEs4C5x5v5nRhBbRMBN4vX9NcwgNrNAgcTJlrtQU6cxShzdfQCsgU3AUKLr
        LcgkTg5eATuJSef/g8VZBFQlTp5YBLZNVCBGovP6PKgaQYmTM5+wgNicAs4Sq1ouM0EsUJf4
        M+8S1DJ5ie1v50DZ4hK3nsxnmsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5x
        aV66XnJ+7iZGYLRtO/Zzyw7GrnfBhxgFOBiVeHg3bPwWLcSaWFZcmXuIUYKDWUmEt0nxe7QQ
        b0piZVVqUX58UWlOavEhRlOg5yYyS4km5wMTQV5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0
        xJLU7NTUgtQimD4mDk6pBkb2qWvCY978kvC/tvx6gOCfMs/37pWcv3eHNEfdfb1Iy0Uv6E/b
        AQl3b+ZZUe/eG16TT7F1+fohW9lG4zGv6LtTKRE8Ks/VD0t4n/s9Wfb5BfGGjVP2P/a6Hcp4
        wiC7d81yfclNgQ9PHTz2dMfqopUPj/m4tRnWLe7L82Hk/LqM7ffmlw+XtuxXYinOSDTUYi4q
        TgQAh6viFcwCAAA=
X-CMS-MailID: 20181123092429eucas1p2e67d28b703e12eccd9e145f3ad407914
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181122173037epcas1p39fb96bb168427d58a74a085f42a0ba84
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181122173037epcas1p39fb96bb168427d58a74a085f42a0ba84
References: <CGME20181122173037epcas1p39fb96bb168427d58a74a085f42a0ba84@epcas1p3.samsung.com>
        <20181122173015.23905-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 2018-11-22 18:30, Charles Keepax wrote:
> This reverts commit 466affa06703 ("regulator: wm8994: Don't
> use devres for enable GPIOs"). Whilst that did work around the
> issue in question there are complications on the error paths of
> regulator_register. In the success case clearly the regulator
> core owns the GPIO, however, in the failure case it is unclear
> what should happen. The regulator core could always free the
> GPIO but that may not make sense from the perspective of the
> calling code. Alternatively the regulator core could never free
> the GPIO but that makes the handling in the regulator core rather
> complex. Ultimately it makes more sense to handle the shared GPIO
> in the core.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks for sorting this out! Works fine on Trats2:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>  drivers/regulator/wm8994-regulator.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
> index 46e6b4ee1491a..d7fec533c4032 100644
> --- a/drivers/regulator/wm8994-regulator.c
> +++ b/drivers/regulator/wm8994-regulator.c
> @@ -147,14 +147,11 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
>  	config.regmap = wm8994->regmap;
>  	config.init_data = &ldo->init_data;
>  
> -	/*
> -	 * Look up LDO enable GPIO from the parent device node, we don't
> -	 * use devm because the regulator core will free the GPIO
> -	 */
> -	gpiod = gpiod_get_optional(pdev->dev.parent,
> -				   id ? "wlf,ldo2ena" : "wlf,ldo1ena",
> -				   GPIOD_OUT_LOW |
> -				   GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> +	/* Look up LDO enable GPIO from the parent device node */
> +	gpiod = devm_gpiod_get_optional(pdev->dev.parent,
> +					id ? "wlf,ldo2ena" : "wlf,ldo1ena",
> +					GPIOD_OUT_LOW |
> +					GPIOD_FLAGS_BIT_NONEXCLUSIVE);
>  	if (IS_ERR(gpiod))
>  		return PTR_ERR(gpiod);
>  	config.ena_gpiod = gpiod;
> @@ -187,7 +184,6 @@ static int wm8994_ldo_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err:
> -	gpiod_put(gpiod);
>  	return ret;
>  }
>  

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

