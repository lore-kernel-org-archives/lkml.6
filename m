Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0713C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507262087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SH/KdTLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507262087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeIXQGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:06:13 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47583 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeIXQGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:06:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180924100455euoutp02f950dd939d77b877151f4bd4ac9893fc~XTfEEByQf1747717477euoutp02C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:04:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180924100455euoutp02f950dd939d77b877151f4bd4ac9893fc~XTfEEByQf1747717477euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537783495;
        bh=2AXwC75v3xobkTMSy1LR+GGYo4noBKKd9mTq+7/7Kok=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SH/KdTLmMCNC6U2/7BW3t4rNQvfQlzf/Xm9yPFQLr2+8m2Ixt5hK10OYLNp29WSLx
         gFP/h+f38qk0FqVg2xzN3jig6XdCQOlm0SA6ZEAu0vk+GYgSTeNwc/1bpzrtRx70aZ
         xT+RpxPDuRB5rsf0DI7kNt1vxyvVk34+uiTcU1oE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180924100454eucas1p22e3599cb10c3255324af462ed202e69a~XTfDLedKd0656406564eucas1p2f;
        Mon, 24 Sep 2018 10:04:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 16.85.04441.6C6B8AB5; Mon, 24
        Sep 2018 11:04:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180924100453eucas1p2cc67bf2cae5c0d0a031c7ce8d1117529~XTfCSQ2rd1041310413eucas1p2S;
        Mon, 24 Sep 2018 10:04:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180924100453eusmtrp25a75dcc59be5967c5007456ebb2db463~XTfB-9_US1743417434eusmtrp2E;
        Mon, 24 Sep 2018 10:04:53 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-1b-5ba8b6c6f4c1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 01.15.04128.5C6B8AB5; Mon, 24
        Sep 2018 11:04:53 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180924100452eusmtip16fb60e091ee3cfd950d256de74645d56~XTfBoPMB02743427434eusmtip1Y;
        Mon, 24 Sep 2018 10:04:52 +0000 (GMT)
Subject: Re: [PATCH] ARM: dts: exynos: Add CD and WP pins to Odroid XU SD
 card
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 24 Sep 2018 12:04:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921210321.12404-1-krzk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87rHtq2INniwg9li/pFzrBb9j18z
        W5w/v4HdYtPja6wWl3fNYbOYcX4fk8W6jbfYHdg9ds66y+6xaVUnm8fmJfUenzfJBbBEcdmk
        pOZklqUW6dslcGWcmbmHseC6SMXF9eoNjCcEuhg5OSQETCS+7epj6mLk4hASWMEoMeXOajYI
        5wujxJ9t+1ggnM+MEjfOHWWGaelt62GESCxnlLjw8RUzhPOeUWJbVzc7SJWwQIDEoQW3wGaJ
        CJxnlFj/ZxUjSIJZQE3i0IrHrCA2m4ChRNfbLjYQm0VAVeLal1lANRwcogIxEr93WYOEeQUE
        JU7OfMICYnMKmEpMaHzEDDFGXmL72zlQtrjErSfzwZ6QEFjGLvFg0kd2iOYyibWHulggznaR
        mHjgHiOELSzx6vgWdghbRuL/TpjmZkaJ9hmz2CGcHkaJrXN2sEFUWUscPn6RFeQ6ZgFNifW7
        9CHCjhJ77/eDhSUE+CRuvBWEOIhPYtK26cwQYV6JjjYhiGo1iVnH18GtPXjhEvMERqVZSN6c
        heS1WUhem4WwdwEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAxHP63/FPOxi/Xko6
        xCjAwajEw8twb3m0EGtiWXFl7iFGCQ5mJRFet1tAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rx8
        WmnRQgLpiSWp2ampBalFMFkmDk6pBka7ij07y9eo3PgX7PJ1edmv2KAZklfXzDXabpLulxd4
        Z+H3vKPSwRMOtdS9nmsjJPL/w9QDC19fVsz0fL6kpfNVROpcm2nptXErZTZ/UzyX8WnWL10t
        65uiTsknVhm6qB7Rl7Wf0bik6lz6nR/ams/ctY+ZfKp/eLe2UOWLZuTyX8H+R3R/3JqtxFKc
        kWioxVxUnAgAfigujjgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7pHt62INmh/wmwx/8g5Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyWLdxlvsDuweO2fdZffYtKqTzWPzknqPz5vkAlii9GyK
        8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLOzNzDWHBd
        pOLievUGxhMCXYycHBICJhK9bT2MXYxcHEICSxklPiw9ygiRkJE4Oa2BFcIWlvhzrYsNougt
        o8TUlhVMIAlhAT+JZf3nwLpFBM4zSpzauRSsg1lATeLQisesEB0djBKLN/4BG8smYCjR9RZk
        FCcHr4CdxPNH05hBbBYBVYlrX2aB1YgKxEgcndwCVSMocXLmExYQm1PAVGJC4yNmiAVmEvM2
        P4Sy5SW2v50DZYtL3Hoyn2kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV5
        6XrJ+bmbGIGxtu3Yzy07GLveBR9iFOBgVOLhXXF7ebQQa2JZcWXuIUYJDmYlEV63W0Ah3pTE
        yqrUovz4otKc1OJDjKZAz01klhJNzgemgbySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp
        2ampBalFMH1MHJxSDYy5c/YpPRf8nPBd5WV9vYoDwwZ/ez7mUy5f+jpi1J9Vvfo86bLDorVa
        EszRpVuvftfiCdC9O2/irSXbtJsfSIkfcJ68/jKXeAdPRMbPhaeVfPxiYhevZs/eN7tJPJXP
        RaM1QGPX9VvPLGKatm0+etRxkVOmTpasbesvjzCmB9ZbF7422c29jF+JpTgj0VCLuag4EQAd
        KY9cywIAAA==
Message-Id: <20180924100453eucas1p2cc67bf2cae5c0d0a031c7ce8d1117529~XTfCSQ2rd1041310413eucas1p2S@eucas1p2.samsung.com>
X-CMS-MailID: 20180924100453eucas1p2cc67bf2cae5c0d0a031c7ce8d1117529
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180921210332epcas3p423aaeeb84ec3d8a44c5a898949f992e8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180921210332epcas3p423aaeeb84ec3d8a44c5a898949f992e8
References: <CGME20180921210332epcas3p423aaeeb84ec3d8a44c5a898949f992e8@epcas3p4.samsung.com>
        <20180921210321.12404-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018-09-21 23:03, Krzysztof Kozlowski wrote:
> Defining card-detect and write-protect GPIO pins in Odroid XU SD Card
> does not change anything from functional point of view - dw-mmc driver
> was reading the state from registers.  Adding cd-gpios and wp-gpios
> properties changes only internal driver behavior to access the pins
> directly.
>
> Add them to DTS only to comprehensively describe the hardware.  Minor
> benefit is that write-protect pin configuration makes sure that it will
> be properly pulled up to indicate write access.
>
> This also removes debug messages:
>      dwmmc_exynos 12220000.mmc: No GPIO consumer cd found
>      dwmmc_exynos 12220000.mmc: No GPIO consumer wp found
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>   arch/arm/boot/dts/exynos5410-odroidxu.dts | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> index a2046f5f998c..dae360f29a47 100644
> --- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
> +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> @@ -525,12 +525,14 @@
>   
>   &mmc_2 {
>   	status = "okay";
> +	wp-gpios = <&gpm5 0 GPIO_ACTIVE_LOW>;
> +	cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
>   	card-detect-delay = <200>;
>   	samsung,dw-mshc-ciu-div = <3>;
>   	samsung,dw-mshc-sdr-timing = <0 4>;
>   	samsung,dw-mshc-ddr-timing = <0 2>;
>   	pinctrl-names = "default";
> -	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
> +	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4 &sd2_wp>;

IMHO there is no point adding cd-gpios property if CD line is already 
assigned to this device via respective pin ctrl entry (as special function).

Handling of WP line is even more controversial imho. Ideally the drivers 
or mmc core should check somehow if WP line is available or not and act 
respectively. WP line is not available on uSD card connector so there is 
no point describing it.

>   	bus-width = <4>;
>   	cap-sd-highspeed;
>   	vmmc-supply = <&ldo21_reg>;
> @@ -573,6 +575,14 @@
>   		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
>   		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
>   	};
> +
> +	sd2_wp: sd2-wp {
> +		samsung,pins = "gpm5-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		/* Pin is floating so pull it up to disable write-protect */
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
> +	};
>   };
>   
>   &pwm {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

