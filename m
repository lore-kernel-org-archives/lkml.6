Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE458C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED4B2174D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XzRWkNsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED4B2174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbeHGNNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:13:39 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51486 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727155AbeHGNNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:13:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180807105952euoutp018f209a5e6ae0c76de763de0c44fe6c18~IlRVmY9-B1216012160euoutp01K
        for <linux-kernel@vger.kernel.org>; Tue,  7 Aug 2018 10:59:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180807105952euoutp018f209a5e6ae0c76de763de0c44fe6c18~IlRVmY9-B1216012160euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533639592;
        bh=P8lvddq8nVsi87aQry2BzN+y0KwmZuHtwtwLmrGo/Lg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=XzRWkNsKUCJJCDS9LfpjwesFNysfyt3ZQG7MuJ7WhXNw/sqVtmen2ND+GCiZKbFnx
         5j99ZfWIEPtsKNH7qKXQP4tsygBleGxJR2Ilww+vQ10f2BwvWi0CYtJ8ZqX8tE/zPy
         xvupBhae8IMGSUnhgs0Dve9uIrdTj8Ql8nsCz3wY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180807105951eucas1p25909fbdad3ac222e73f738a3eca6e825~IlRUts9ML1380813808eucas1p2l;
        Tue,  7 Aug 2018 10:59:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BC.C2.04294.6AB796B5; Tue,  7
        Aug 2018 11:59:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180807105950eucas1p1e48a3d064afb4d601fa33eeb67f0ba02~IlRTyxXuT0840608406eucas1p1t;
        Tue,  7 Aug 2018 10:59:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180807105950eusmtrp26465a3053d43cf7e6db21130cf14631c~IlRTiT_bZ1291012910eusmtrp2c;
        Tue,  7 Aug 2018 10:59:50 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-d5-5b697ba69ac6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5A.07.04128.5AB796B5; Tue,  7
        Aug 2018 11:59:49 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180807105949eusmtip12877b77d253d8db9ed5a0d58f89a1ffe~IlRSw3CtN2199521995eusmtip1a;
        Tue,  7 Aug 2018 10:59:49 +0000 (GMT)
Subject: Re: [RFT 4/4] ARM: dts: exynos: Add LDO28 regulator on Exynos5422
 Odroid boards
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Tue, 7 Aug 2018 12:59:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806160933.6578-4-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsWy7djP87rLqzOjDT5NZbLYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZLL1+kcmide8RdgcujzXz1jB6bFrV
        yeaxeUm9R9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGVs+/aJteCKQMXFhauZGhgX8XYxcnJI
        CJhIfN70nbmLkYtDSGAFo8TFOw9ZIZwvjBJ7F7RAOZ8ZJf6e6WOGadmy/jhUy3JGidkrdkM5
        7xkl1nZNZgKpEhaIkni9cDpYQkRgBpPEtX+LWUESzAIJEhN+XwUrYhMwlOh628UGYrMIqEgs
        a5oA1MDBISoQI/F7lzVImFdAUOLkzCcsIDYn0OY3H26xQIyRl9j+dg4zhC0ucevJfCaI63ax
        S5w/zgrRWybxYcVbqKtdJHofX2SFsIUlXh3fwg5hy0j83wnSywVkNzNKtM+YxQ7h9DBKbJ2z
        gw2iylri8HGQbg6gbZoS63fpQ4QdJR5+2MgOEpYQ4JO48VYQ4h4+iUnbpjNDhHklOtqEIKrV
        JGYdXwe39uCFS8wTGJVmIflyFpLPZiH5bBbC3gWMLKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1
        kvNzNzECE9Tpf8e/7GDc9SfpEKMAB6MSD2/GsoxoIdbEsuLK3EOMEhzMSiK8vJlAId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rx8WmnRQgLpiSWp2ampBalFMFkmDk6pBkYOcdbGXXfWNRvv/Hu0
        OnoSl+2yRZ6/2e7q/thqICY0YXvW2i/ZHkFxJx7dmfBj3atOseJDIv7ivUFsommH8yd9fMvh
        7dsYc2STsEDGw4jp7E63w2wvubwv8LrivW+9p9yvZ7K9QstuTzga6bDm6OIpu6oWHhd/qMjI
        MHtp0ewPhqe9Xt+tOJ2rxFKckWioxVxUnAgA301Vj0wDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7pLqzOjDdo2aVtsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gsll6/yGTRuvcIuwOXx5p5axg9Nq3q
        ZPPYvKTeo2/LKkaPz5vkAlij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX0
        7WxSUnMyy1KL9O0S9DK2ffvEWnBFoOLiwtVMDYyLeLsYOTkkBEwktqw/zgxiCwksZZT4eJUJ
        Ii4jcXJaAyuELSzx51oXG0TNW0aJBbvTQGxhgSiJ1wunA/VycYgIzGCS+DDzD1gzs0CCxLf7
        nxkhGjYySsy56AZiswkYSnS9hRjEK2AncWjiUzCbRUBFYlnTBLAjRAViJI5OboGqEZQ4OfMJ
        C4jNCXTomw+3WCDmm0nM2/yQGcKWl9j+dg6ULS5x68l8pgmMQrOQtM9C0jILScssJC0LGFlW
        MYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbjtmM/t+xg7HoXfIhRgINRiYdXYElGtBBrYllx
        Ze4hRgkOZiURXt5MoBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA1NFXkm8oamhuYWlobmx
        ubGZhZI473mDyighgfTEktTs1NSC1CKYPiYOTqkGRuFuh50MCRxdVW0KjF9di1o4a9MkYi09
        l/u931JZfuOiw8LDO10O2CTdCtysXeA0wVTQM1jjq1umcbJx6HmblU+OyAeqpYmdC2i9sXTZ
        rvbbu5d2/d+uxM/YHa3x+XtibmtasfWvmbEzz3jIv/5uzhfkJMJ56l2EwQMmgyb2jDK/pfv4
        F/IqsRRnJBpqMRcVJwIAEYpDUt0CAAA=
Message-Id: <20180807105950eucas1p1e48a3d064afb4d601fa33eeb67f0ba02~IlRTyxXuT0840608406eucas1p1t@eucas1p1.samsung.com>
X-CMS-MailID: 20180807105950eucas1p1e48a3d064afb4d601fa33eeb67f0ba02
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180806160955epcas4p14c924297f156db1dcb30ce543bc2d79a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180806160955epcas4p14c924297f156db1dcb30ce543bc2d79a
References: <20180806160933.6578-1-krzk@kernel.org>
        <CGME20180806160955epcas4p14c924297f156db1dcb30ce543bc2d79a@epcas4p1.samsung.com>
        <20180806160933.6578-4-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018-08-06 18:09, Krzysztof Kozlowski wrote:
> The LDO28 is used only on Odroid XU3 for Display Port.  Define it so DTS
> will describe entire hardware.
>
> Depending on bootloader behavior this might affect the Display Port
> because none of drivers are enabling it. By default it is off in S2MPS11
> PMIC reset values.  However it could be enabled by bootloader so in such
> case kernel will later disable it as unused regulator.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Odroid XU3 boots fine with this patch. Display Port is not yet enabled in
mainline for OdroidXU3, so there is not much else to test for now.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>
> Not tested on Odroid XU3 with Display Port.
> ---
>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 7 +++++++
>   arch/arm/boot/dts/exynos5422-odroidxu3.dts    | 6 ++++++
>   2 files changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index b0dc9cc81b94..178e1064cfc7 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -331,6 +331,13 @@
>   				regulator-always-on;
>   			};
>   
> +			ldo28_reg: LDO28 {
> +				/* Used on XU3 */
> +				regulator-name = "vdd_ldo26";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3950000>;
> +			};
> +
>   			ldo29_reg: LDO29 {
>   				/* Unused */
>   				regulator-name = "vdd_ldo29";
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> index 0322f281912c..db0bc17a667b 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> @@ -49,6 +49,12 @@
>   	};
>   };
>   
> +&ldo28_reg {
> +	regulator-name = "dp_p3v3";
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +};
> +
>   &pwm {
>   	/*
>   	 * PWM 0 -- fan

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

