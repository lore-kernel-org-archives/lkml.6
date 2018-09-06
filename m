Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFF3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0D2206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ljjaoyCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0D2206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeIFN41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:56:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48981 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeIFN41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:56:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180906092153euoutp0163c7e83cae11a4662b03efc2ae17656a~RxSWncl_J0214602146euoutp01i
        for <linux-kernel@vger.kernel.org>; Thu,  6 Sep 2018 09:21:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180906092153euoutp0163c7e83cae11a4662b03efc2ae17656a~RxSWncl_J0214602146euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536225713;
        bh=sShkRfZJDVJ/6LrfY3cdMy4vAtie9+FBJuRM7pjbKi8=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=ljjaoyCy5YOX2vQIPTuz4hThRKkxhFKh2cbyezqP339DZk7DZfPUQQytW6dmZBXYy
         CWNmfcs85nUhpEwlotI/C1ns0Cw7VUjXLLzxrKFy2bAeJ0cbvfKW3YkUaeJoUqSutI
         nFgGclcchU8yyJW2CObw12ISutwUZU8pZND5CoUk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180906092152eucas1p2d43ea2209db5fb71ff1a55877ee162d4~RxSWBWkHH0073300733eucas1p2n;
        Thu,  6 Sep 2018 09:21:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9E.CA.04806.0B1F09B5; Thu,  6
        Sep 2018 10:21:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180906092151eucas1p1c7e7e187120468f0e99afce3dd2859b6~RxSVGQkCD1671916719eucas1p1C;
        Thu,  6 Sep 2018 09:21:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180906092151eusmtrp2b41358c551da10d70b63a6f4b10f3893~RxSU05NaR2656826568eusmtrp26;
        Thu,  6 Sep 2018 09:21:51 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-cb-5b90f1b0ab11
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2C.99.04284.FA1F09B5; Thu,  6
        Sep 2018 10:21:51 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180906092151eusmtip26b81a828d07d4ecae0fa5d0d920b898a~RxSUaESQp0037600376eusmtip2d;
        Thu,  6 Sep 2018 09:21:51 +0000 (GMT)
Subject: Re: [RFT] ARM: dts: exynos: Remove double SD card detect pin
 inversion
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        Simon Shields <simon@lineageos.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu, 6 Sep 2018 11:21:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905174024.28366-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djP87obPk6INnjZJGsx/8g5Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyWLBy1ssFofftLNabDlzm82B02PTqk42j5b1m9g8Ni+p
        9+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MBZeaWAo2CFes3J/QwPiHv4uRk0NCwETiwIQz
        LF2MXBxCAisYJdY9aIVyvjBK7NtziBnC+cwoMXXrN8YuRg6wls/fwiHiyxklDq/4BlX0nlFi
        /uduFpC5wgKBEkdubmUESYgInGaSePPvJyNIgk3AUKLrbRcbyCQWARWJiRdDQExRgRiJ37us
        QSp4BQQlTs58AjaGU8BUYl/fAjYQm1lAXmL72znMELa4xK0n85lAxksIbGOXWPN3JjPIHF6B
        MokNjyMh7nSRWHgvGuJLYYlXx7ewQ9gyEv93wrQ2M0q0z5jFDuH0MEpsnbODDaLKWuLw8Yus
        IIOYBTQl1u/Shwg7Sry5NRsaDnwSN94KQpzDJzFp23RmiDCvREebEES1msSs4+vg1h68cIkZ
        wvaQeD7/KdMERsVZSB6eheTJWUienIVwwwJGllWM4qmlxbnpqcXGeanlesWJucWleel6yfm5
        mxiB6ej0v+NfdzDu+5N0iFGAg1GJh3fBuf5oIdbEsuLK3EOMEhzMSiK87tUTooV4UxIrq1KL
        8uOLSnNSiw8xSnOwKInz8mmlRQsJpCeWpGanphakFsFkmTg4pRoYuTd8nfI7U3opb2393odG
        QnlHtpfV/bK9YcX+NO1S3bXGJSZ+hxffU1p9T3JZut3pQB8tlyVlKsI9fgemaM55+WyHlfat
        y5b7b1zYv9xt9ZJlk7ievb/61efEKp2tMey2HV2l6u+U3l4T4jT53POFi2XthS/NzRMs3h1p
        qglfqLNm7QTzAy7vVZRYijMSDbWYi4oTAXGwKJhDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xe7rrP06INlj2X9pi/pFzrBb9j18z
        W5w/v4HdYtPja6wWl3fNYbOYcX4fk8WCl7dYLA6/aWe12HLmNpsDp8emVZ1sHi3rN7F5bF5S
        79G3ZRWjx+dNcgGsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5
        mWWpRfp2CXoZCy41sRRsEK5YuT+hgfEPfxcjB4eEgInE52/hXYycHEICSxklfryxAbElBGQk
        Tk5rYIWwhSX+XOtig6h5yyjRvEoXxBYWCJQ4cnMrYxcjF4eIwGkmifl/trGAOEICHYwSn67/
        ZAepYhMwlOh6C9HNK2An0Xf0MCPIYhYBFYmJF0NAwqICMRJHJ7dAlQhKnJz5hAXE5hQwldjX
        twAszixgJjFv80NmCFteYvvbOVC2uMStJ/OZJjAKzkLSPgtJyywkLbOQtCxgZFnFKJJaWpyb
        nltsqFecmFtcmpeul5yfu4kRGGnbjv3cvIPx0sbgQ4wCHIxKPLwLzvVHC7EmlhVX5h5ilOBg
        VhLhda+eEC3Em5JYWZValB9fVJqTWnyI0RTot4nMUqLJ+cAkkFcSb2hqaG5haWhubG5sZqEk
        znveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgVFNWVzFu1mUi1FoRca/9BtnPy3+azb95JRVx95s
        kn1XucuhMsHjXazqL8Zgq9BLqZcNbX4w9uk/3XTwbjrb7DUX2nWLPLV2PKrum/by89KIEq9H
        f/c/FY5b4HJddlejSypHYnjqAXOHjrzpfVPK59y9MffEVqtZN7b48PLavHywaJqqkulizmVK
        LMUZiYZazEXFiQAP4VoWygIAAA==
Message-Id: <20180906092151eucas1p1c7e7e187120468f0e99afce3dd2859b6~RxSVGQkCD1671916719eucas1p1C@eucas1p1.samsung.com>
X-CMS-MailID: 20180906092151eucas1p1c7e7e187120468f0e99afce3dd2859b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180905174039epcas3p2091bb7ef6c51b2850ea774e6d76b7f5d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180905174039epcas3p2091bb7ef6c51b2850ea774e6d76b7f5d
References: <CGME20180905174039epcas3p2091bb7ef6c51b2850ea774e6d76b7f5d@epcas3p2.samsung.com>
        <20180905174024.28366-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018-09-05 19:40, Krzysztof Kozlowski wrote:
> The SDHCI standard, MMC host controller bindings and MMC core defines
> card detect pin as active low.  Therefore there is no point to invert it
> twice.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Tested only on Odroid U3. Tests on other platforms would be appreciated.

SD card detection still works fine on UniversalC210, Trats2 and OdroidU3 
with this patch.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm/boot/dts/exynos4210-universal_c210.dts | 3 +--
>   arch/arm/boot/dts/exynos4412-midas.dtsi         | 3 +--
>   arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 3 +--
>   3 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 4e6ff97e1ec4..249bfbff1e20 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -537,8 +537,7 @@
>   	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4>;
>   	pinctrl-names = "default";
>   	vmmc-supply = <&ldo5_reg>;
> -	cd-gpios = <&gpx3 4 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpx3 4 GPIO_ACTIVE_LOW>;
>   	status = "okay";
>   };
>   
> diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
> index c0476c290977..aed2f2e2b0d1 100644
> --- a/arch/arm/boot/dts/exynos4412-midas.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
> @@ -1269,8 +1269,7 @@
>   
>   &sdhci_2 {
>   	bus-width = <4>;
> -	cd-gpios = <&gpx3 4 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpx3 4 GPIO_ACTIVE_LOW>;
>   	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_bus4 &sdhci2_cd>;
>   	pinctrl-names = "default";
>   	vmmc-supply = <&ldo21_reg>;
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index a09e46c9dbc0..2caa3132f34e 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -539,8 +539,7 @@
>   	pinctrl-names = "default";
>   	vmmc-supply = <&ldo21_reg>;
>   	vqmmc-supply = <&ldo4_reg>;
> -	cd-gpios = <&gpk2 2 GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpk2 2 GPIO_ACTIVE_LOW>;
>   	status = "okay";
>   };
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

