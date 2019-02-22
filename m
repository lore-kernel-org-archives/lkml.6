Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2BBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708402081B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uxQT4HOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBVK3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:29:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51440 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbfBVK3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:29:17 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190222102915euoutp024c0f3d3f90198cb977a6f44d30071676~FqOa5L8zE0286402864euoutp02f
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:29:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190222102915euoutp024c0f3d3f90198cb977a6f44d30071676~FqOa5L8zE0286402864euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550831355;
        bh=q2w48S7CcqS2viXojHghl1JaTVXvgPQxpY8I4IVYnzc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uxQT4HORzBNo0TgykJjor529xbECNlmfFEnveJtnBZKA0Y2kfEc670wWYI7veupeU
         vVP1AXjJ/yn4u/yE3TUQHJO+EpzW0J5xpHNjxNfxmhBZiMPPjRIaAcGVdOhMOFRiul
         +w5ahAV2g8SCHHyNuqut4PC2EFdVwmUhzB1Ywbmw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190222102914eucas1p181c7a360d9417496b655c2778be9bdff~FqOaPFXux3161531615eucas1p1S;
        Fri, 22 Feb 2019 10:29:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E2.3C.04294.AFECF6C5; Fri, 22
        Feb 2019 10:29:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190222102913eucas1p103d9dd48b2518e274d2b1c6ba41c1f2e~FqOZLogZg3160631606eucas1p1h;
        Fri, 22 Feb 2019 10:29:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190222102913eusmtrp1b8e00448258eb2dd26f18c089c715497~FqOY9XyEy0771207712eusmtrp1l;
        Fri, 22 Feb 2019 10:29:13 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-49-5c6fcefaa44f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 57.B8.04284.9FECF6C5; Fri, 22
        Feb 2019 10:29:13 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190222102913eusmtip12b2fac3a886b8b60c790baef1850d5f3~FqOYhy2Zo1257612576eusmtip1n;
        Fri, 22 Feb 2019 10:29:13 +0000 (GMT)
Subject: Re: [PATCH] ARM: dts: exynos: Add pin configuration for read strobe
 for Odroid XU3/XU4 eMMC
To:     Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d4f36ce1-ddef-5756-05dc-74e8dd08417c@samsung.com>
Date:   Fri, 22 Feb 2019 11:29:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222101948.848-1-linux.amoon@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjt3b139zqcvF4NH8yKZhMS0oyoRSEK/RgGGUn04UBXXj/Qbbqr
        poUo5VdiKhqlQ3GSooywaebHJKFpLjOnZoqJQh8aYoxFipFU5rxa/jvnOed5n3PgZQi2ifJl
        krTpnF6rTpGJJWTn4E/74TW7TnXEYQ5Q1A/YKcXoqJlWtH+eohQTllqxonq0T6RobZuhFQXP
        B+gwWtljmKOV7aa7YuXTxlzlcvu+8+RVyek4LiUpk9MHh8ZKEqcbQlLHPbJmlheoPFTnXoLc
        GMDHwD5SQZcgCcPiFgSTY7NbZAWBqbBJJJBlBOaFNXp7Zb3RhgShGcHsxwVCIE4ExU4L5XJ5
        4XgwvmwmXYI3vofAXpdPugQCJ8OnjjqRC4txCJQ4SsQuLMWhUHG/ZhOTWA5vWqY3/AyzG6vA
        +ihTsHjCUM385jNu+CQ43zuQ8OR+6HLUEgL2gZn5+s3YgE00rI8YxULsM1D4ZZAQsBcs2Tq2
        6vjBcFUpKSzcQVBUbaAFUorgWW331vYp6LeNU65EBD4ETyzBwjgchr7dFrnGgD1g2uEphPCA
        ys6HhDCWQnEhK7gDwGBr/Xf2xdhbogLJDDuqGXbUMeyoY/h/14hIE/LhMnhNAscf1XI3gni1
        hs/QJgRd12na0cbnGf5jW+lGll/XrAgzSOYuVbRpVSylzuSzNVYEDCHzllqGdCpWGqfOvsnp
        dTH6jBSOt6I9DCnzkd7a9SGaxQnqdC6Z41I5/bYqYtx88xC32DD0u6BI4rBX+R/MqoqlI7H5
        Xd+PACW7KklrQK8XS0eOt1X3543M+eWkFVE1E5qo/AsLBRXh319d6slY/RqZUzkQI+e75MbQ
        A6x/45r8Yn981tlzEeIlYwQjL7pymWrM5diy8t4TiWGiySg1flDW9jh6ypeb7XXuLbcEykg+
        UR0SSOh59V9Pyex7OAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7o/z+XHGKzslrKYf+Qcq8X58xvY
        LTY9vsZqcXnXHDaLGef3MVms23iL3aJ17xF2B3aPnbPusntsWtXJ5rF5Sb3H501yASxRejZF
        +aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehk3FhoWXOSr
        uPX5KWsD41yeLkZODgkBE4n/S44zdjFycQgJLGWUuDZ7JzNEQkbi5LQGVghbWOLPtS42iKK3
        jBINT7awgCSEBdIkFhxdzgKSEBHoZZS42tAH1s0skC3Ref4TO0RHD6PEgYkTGUESbAKGEl1v
        QUZxcvAK2ElMmDITzGYRUJU4s+IG2FRRgRiJD3dvMEHUCEqcnPkELM4pYCnx/uZbRogF6hJ/
        5l2CWiYvsf3tHChbXOLWk/lMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0u
        zUvXS87P3cQIjLVtx35u3sF4aWPwIUYBDkYlHl6LjXkxQqyJZcWVuYcYJTiYlUR4d53MjxHi
        TUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGAayCuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCe
        WJKanZpakFoE08fEwSnVwMhxwfXBuz7zaUUvaj1mlZnsCBAq15XaxaT3+U6KfUBZHvP+sjUM
        9yZk2TnlLy1VNrk8nb1MQP3ne40nzNcvtL1crOd/6PNkpg2huk/PZV7KP3a30vZiyMru3dyf
        n+2Wv2M51eu85smi3sCUlnPNjyTeX3La9DzDdfb/2r8WfooaF/KbzkSyGSixFGckGmoxFxUn
        AgA7hkjsywIAAA==
X-CMS-MailID: 20190222102913eucas1p103d9dd48b2518e274d2b1c6ba41c1f2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190222102034epcas3p373245ed6e3e83e297bcaff48aec37992
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190222102034epcas3p373245ed6e3e83e297bcaff48aec37992
References: <CGME20190222102034epcas3p373245ed6e3e83e297bcaff48aec37992@epcas3p3.samsung.com>
        <20190222101948.848-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On 2019-02-22 11:19, Anand Moon wrote:
> Add Read Strobe RDQS pin configuration for eMMC to support higher data rate read/write.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 6 ++++++
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> index b82af7c89654..4fb3865e082a 100644
> --- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> @@ -206,6 +206,12 @@
>  		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
>  	};
>  
> +	sd0_rdqs: sd0-rdqs {
> +		samsung,pins = "gpc0-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
> +	};
> +

The above lines are not needed. There is already a sd0_rclk node with
exactly the same configuration just above your change.

>  	sd1_clk: sd1-clk {
>  		samsung,pins = "gpc1-0";
>  		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index b299e541cac0..d41397748ed2 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -411,7 +411,7 @@
>  	samsung,dw-mshc-hs400-timing = <0 2>;
>  	samsung,read-strobe-delay = <90>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
> +	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_rdqs &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
>  	bus-width = <8>;
>  	cap-mmc-highspeed;
>  	mmc-hs200-1_8v;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

