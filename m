Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA786C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A768320870
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q1DMDQkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfA2AzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:55:00 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:48588 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfA2Ay7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:54:59 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190129005457epoutp02778d6cfa74f8cbfeb4be129b4d7fa3dd~_K6JNlgTz2317923179epoutp020
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:54:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190129005457epoutp02778d6cfa74f8cbfeb4be129b4d7fa3dd~_K6JNlgTz2317923179epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548723297;
        bh=zLAibsdoFvMmWEbacdodHxeeG2Y32JVatu5Ty0jm96E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Q1DMDQkqnLsbQXzLxVcBPVAMlpDoEx6/2XCDVpRvaynye8xF63Iv/sgUlRmq4v4OF
         P5ZvVvvI5Wo+tNoq6gAPT1AbAY/yTfJ/9RrQBb0QLDe/F+5DqZhKjKraWi5Q/e+ZRQ
         Cl+DswuXDKnQDjBD88llaG+2AaizZUgQupvtAA68=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190129005450epcas1p32077770357f698a7c0b6ba2aade77fe5~_K6CEphDz0449004490epcas1p3v;
        Tue, 29 Jan 2019 00:54:50 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.A0.04206.A54AF4C5; Tue, 29 Jan 2019 09:54:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190129005449epcas1p25ed3cb1e476f164d6720f9c34aa49b7a~_K6BizHHD0902409024epcas1p2f;
        Tue, 29 Jan 2019 00:54:49 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190129005449epsmtrp23b61f0098ebecda13b6c4a6fc447d60a~_K6Bem85x1829418294epsmtrp2r;
        Tue, 29 Jan 2019 00:54:49 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-52-5c4fa45a8549
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.A4.03601.954AF4C5; Tue, 29 Jan 2019 09:54:49 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190129005449epsmtip19de1b48c94645808bbbef57bd8b95e46~_K6BQ6K2b1774017740epsmtip1w;
        Tue, 29 Jan 2019 00:54:49 +0000 (GMT)
Subject: Re: [PATCH 1/8] clk: samsung: add needed IDs for DMC clocks in
 Exynos5420
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        krzk@kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d6cbbeac-c15f-91b8-caf3-b22b8715665a@samsung.com>
Date:   Tue, 29 Jan 2019 09:54:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548703299-15806-2-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmgW7UEv8Yg67zPBYbZ6xntZh/5Byr
        Rf/j18wW589vYLe41SBjsenxNVaLy7vmsFnMOL+PyWLp9YtMFrcbV7BZtO49wm5x+E07qwOP
        x5p5axg9Nq3qZPPYvKTe4+C7PUwefVtWMXp83iQXwBaVbZORmpiSWqSQmpecn5KZl26r5B0c
        7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKKSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4
        xFYptSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITtjy9fLLAV3xCr+Nz5kbmB8INTFyMkh
        IWAiMeX3P6YuRi4OIYEdjBJ7Lt2Ccj4xSpyc3c4G4XxjlLizdCkLTMvZ1xNZIRJ7GSVe/r3P
        BpIQEnjPKPFrqg2ILSwQIrF9xR52EFtEwEPi9ecprCA2s8BJJommySYgNpuAlsT+FzfAevkF
        FCWu/njMCGLzCthJnPu+ixnEZhFQlbg2dy8TiC0qECFxuPcdVI2gxMmZT8AO4hTwllj0bx8T
        xHxxiVtP5kPZ8hLNW2czgxwqITCPXeLf24VMEB+4SPzf854dwhaWeHV8C5QtJfH53V42CLta
        YuXJI2wQzR2MElv2X2CFSBhL7F86GWgQB9AGTYn1u/QhlvFJvPvawwoSlhDglehog4avssTl
        B3eh1kpKLG7vhBrvIbFiUjPLBEbFWUjemYXkhVlIXpiFsGwBI8sqRrHUguLc9NRiwwJT5Nje
        xAhOvlqWOxiPnfM5xCjAwajEw2vA5h8jxJpYVlyZe4hRgoNZSYR36nW/GCHelMTKqtSi/Pii
        0pzU4kOMpsDQnsgsJZqcD8wMeSXxhqZGxsbGFiaGZqaGhkrivOsdnGOEBNITS1KzU1MLUotg
        +pg4OKUaGI9vlfDrOsR9vOJUtP+sV2kXqlj22E4yt2s6p/9Qtu6ixanQ4z6Sxm9kbKLufcr5
        9+1NxY1fa65mbf384BpD1p/dzidtvE3ECoW9lE7ovylK2Pqb83ap6+Ir9y60FtvXWR5ydhC+
        v8i7OCWoxWiTh0o9R/BnkdZCB77TVa8iJMMKGRTsb5dvV2Ipzkg01GIuKk4EAOS/RZLUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSnG7kEv8Yg6kblC02zljPajH/yDlW
        i/7Hr5ktzp/fwG5xq0HGYtPja6wWl3fNYbOYcX4fk8XS6xeZLG43rmCzaN17hN3i8Jt2Vgce
        jzXz1jB6bFrVyeaxeUm9x8F3e5g8+rasYvT4vEkugC2KyyYlNSezLLVI3y6BK2PL18ssBXfE
        Kv43PmRuYHwg1MXIySEhYCJx9vVE1i5GLg4hgd2MEo9nvWOHSEhKTLt4lLmLkQPIFpY4fLgY
        ouYto8SPv3vAaoQFQiS2r4CwRQQ8JF5/ngI2iFngJJNE87tJjCAJIYH7jBI7PimA2GwCWhL7
        X9xgA7H5BRQlrv54DFbDK2Ance77LmYQm0VAVeLa3L1MILaoQITEx6f7mCBqBCVOznzCAmJz
        CnhLLPoHEWcWUJf4M+8SM4QtLnHryXyouLxE89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRM
        LSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjkMtrR2MJ07EH2IU4GBU4uE1YPOPEWJNLCuu
        zD3EKMHBrCTCO/W6X4wQb0piZVVqUX58UWlOavEhRmkOFiVxXvn8Y5FCAumJJanZqakFqUUw
        WSYOTqkGRuFsl23xv2Ln7uUIVNjNHDKX19YwYc/cj3ur455/rXm7q09pS+v23+2fr1g5C4Wf
        Z3ddaf3n2vWp6nduHA3LlRfQ0S682jbh1a8duXMZ60L/TT739NnaysaW6/1PIhpXGs9997Ke
        ze3u3oTIT4ceB65Ljtpca9Y399rhX4kXmaSWx9qwPd319LQSS3FGoqEWc1FxIgCpKem1vwIA
        AA==
X-CMS-MailID: 20190129005449epcas1p25ed3cb1e476f164d6720f9c34aa49b7a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190128192151eucas1p1754d1286ff0f46e8e98796d7583d8e96@eucas1p1.samsung.com>
        <1548703299-15806-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

This patchset don't contain the cover-letter. Please send the
cover-letter which explains what to do on this patchset.

And is it supporting all Exynos5 for both 32bit(5420,5422)
and 64bit(5433) or only Exynos542x(32bit)? If it only support
the Exynos 542x series, you have to change the driver name
from 'exynos5-dmc.c' to 'exynos5420-dmc.c' or 'exynos5422-dmc.c'
in order to prevent the confusion according to the driver name.


On 19. 1. 29. 오전 4:21, Lukasz Luba wrote:
> Define new IDs for clocks used by Dynamic Memory Controller in
> Exynos5422 SoC.
> 
> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
> CC: Chanwoo Choi <cw00.choi@samsung.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: linux-samsung-soc@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  include/dt-bindings/clock/exynos5420.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/exynos5420.h b/include/dt-bindings/clock/exynos5420.h
> index 355f469..1827a64 100644
> --- a/include/dt-bindings/clock/exynos5420.h
> +++ b/include/dt-bindings/clock/exynos5420.h
> @@ -60,6 +60,7 @@
>  #define CLK_MAU_EPLL		159
>  #define CLK_SCLK_HSIC_12M	160
>  #define CLK_SCLK_MPHY_IXTAL24	161
> +#define CLK_SCLK_BPLL		162
>  
>  /* gate clocks */
>  #define CLK_UART0		257
> @@ -195,6 +196,16 @@
>  #define CLK_ACLK432_CAM		518
>  #define CLK_ACLK_FL1550_CAM	519
>  #define CLK_ACLK550_CAM		520
> +#define CLK_CLKM_PHY0		521
> +#define CLK_CLKM_PHY1		522
> +#define CLK_ACLK_PPMU_DREX0_0	523
> +#define CLK_ACLK_PPMU_DREX0_1	524
> +#define CLK_ACLK_PPMU_DREX1_0	525
> +#define CLK_ACLK_PPMU_DREX1_1	526
> +#define CLK_PCLK_PPMU_DREX0_0	527
> +#define CLK_PCLK_PPMU_DREX0_1	528
> +#define CLK_PCLK_PPMU_DREX1_0	529
> +#define CLK_PCLK_PPMU_DREX1_1	530
>  
>  /* mux clocks */
>  #define CLK_MOUT_HDMI		640
> @@ -217,6 +228,10 @@
>  #define CLK_MOUT_EPLL		657
>  #define CLK_MOUT_MAU_EPLL	658
>  #define CLK_MOUT_USER_MAU_EPLL	659
> +#define CLK_MOUT_DPLL		660
> +#define CLK_MOUT_ACLK_G3D	661
> +#define CLK_MOUT_SCLK_SPLL	662
> +#define CLK_MOUT_MX_MSPLL_CCORE_PHY	663
>  
>  /* divider clocks */
>  #define CLK_DOUT_PIXEL		768
> @@ -248,8 +263,9 @@
>  #define CLK_DOUT_CCLK_DREX0	794
>  #define CLK_DOUT_CLK2X_PHY0	795
>  #define CLK_DOUT_PCLK_CORE_MEM	796
> +#define CLK_FF_DOUT_SPLL2	797
>  
>  /* must be greater than maximal clock id */
> -#define CLK_NR_CLKS		797
> +#define CLK_NR_CLKS		798
>  
>  #endif /* _DT_BINDINGS_CLOCK_EXYNOS_5420_H */
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
