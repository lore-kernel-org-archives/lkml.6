Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9379C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B27421726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qiLvC6aE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfBAIoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:44:22 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:17323 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfBAIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:44:22 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190201084419epoutp01be7df92e7b4c8afe6456ca3139be60a8~-MPz0Nfpg2028520285epoutp014
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 08:44:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190201084419epoutp01be7df92e7b4c8afe6456ca3139be60a8~-MPz0Nfpg2028520285epoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549010659;
        bh=ZhVPXQJDOYPfOvRAQbEOsJtAluOWxGuxTxMUeSiN9r4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qiLvC6aEcMxxmFRVBccmPIaxFbm/qcLEmGrHpMTcKKY5BcBCYv0SGf3dlYjRe8Uua
         Om7t7iRfUref25eCx7u+Hl7YoUP6ad+s34kIiw03Or0Vn62slV/O7r0wrQLrMTnMPP
         Lg2lmIGNJgg+M/j6j1dPhSmMWqFB1afCLN5VuUtI=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.155]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190201084415epcas1p3491fc42304671bef4dbf2d26eab31a71~-MPvWkBeq1970119701epcas1p3P;
        Fri,  1 Feb 2019 08:44:15 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.46.04074.ED6045C5; Fri,  1 Feb 2019 17:44:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190201084414epcas1p3f302302313e90b13966aca98289aadd1~-MPu6Ma3o2143721437epcas1p3H;
        Fri,  1 Feb 2019 08:44:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190201084414epsmtrp1c90129596bafeba042d9ab70ae8b09d4~-MPu4qcKu3138631386epsmtrp1i;
        Fri,  1 Feb 2019 08:44:14 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-3e-5c5406de1515
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.7C.03971.ED6045C5; Fri,  1 Feb 2019 17:44:14 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190201084414epsmtip2eec3b5cddd11d74f61de0ffbf62bc084~-MPumtpms2316023160epsmtip2H;
        Fri,  1 Feb 2019 08:44:14 +0000 (GMT)
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
Date:   Fri, 1 Feb 2019 17:44:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmge49tpAYg9uLbCw2zljPajH/yDlW
        i/7Hr5ktzp/fwG5xtukNu8WtBhmLTY+vsVp87LnHanF51xw2i8+9RxgtZpzfx2Sx9shddouL
        p1wtbjeuYLM4/Kad1eLftY0sDgIe72+0sntsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALSrb
        JiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoaiWFssSc
        UqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsbs
        JWsZCx5LVry8F9PAeFi0i5GTQ0LAROLgpIfsXYxcHEICOxglFs9+ywThfGKU2NB8GCrzjVGi
        98p6dpiWc3++MYLYQgJ7GSX+Pq2EKHrPKNE8tw+sSFggWGLusZtsIAkRgeWMEvum3mUEcZgF
        9jJJLLrRA9bOJqAlsf/FDTYQm19AUeLqj8dgcV4BO4kn7b/B4iwCKhKXFs8FmyoqECFxuPcd
        VI2gxMmZT1hAbE4Bb4mXuyA2MwuIS9x6Mp8JwpaXaN46mxni7H3sEte250DYLhJPPv+CekdY
        4tXxLVC2lMTL/jYou1pi5ckjYB9ICHQwSmzZf4EVImEssX/pZKAFHEALNCXW79KH2MUn8e5r
        DytIWEKAV6KjTQiiWlni8oO7TBC2pMTi9k42CNtDYtLcSWwTGBVnIflmFpIPZiH5YBbCsgWM
        LKsYxVILinPTU4sNCwyRY3sTIzhFa5nuYJxyzucQowAHoxIP74ZfQTFCrIllxZW5hxglOJiV
        RHhns4TECPGmJFZWpRblxxeV5qQWH2I0BQb2RGYp0eR8YP7IK4k3NDUyNja2MDE0MzU0VBLn
        Xe/gHCMkkJ5YkpqdmlqQWgTTx8TBKdXAmLO0f8WGPxGne75urRX+wfnurtn+9WLzPXaLLM+9
        N0u6Vfl7pPHJZGnZ8vcZB791Tcw8aOv75FaTjMxKpc5d+T4WWz9Xz9+z6JKeqNyxY2cemV6c
        UXST07zeOplzlpqNc5vIiZbpaQ8+TPERSV7mxp902eltn5+du3TtSvbVE84lqKdY/szbqcRS
        nJFoqMVcVJwIAKl6majnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSvO49tpAYg/enpS02zljPajH/yDlW
        i/7Hr5ktzp/fwG5xtukNu8WtBhmLTY+vsVp87LnHanF51xw2i8+9RxgtZpzfx2Sx9shddouL
        p1wtbjeuYLM4/Kad1eLftY0sDgIe72+0sntsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALYrL
        JiU1J7MstUjfLoErY/aStYwFjyUrXt6LaWA8LNrFyMkhIWAice7PN8YuRi4OIYHdjBJfO2ex
        QiQkJaZdPMrcxcgBZAtLHD5cDBIWEnjLKLG9lQPEFhYIlvjS+g6sV0RgOaPE3L9LWUAcZoG9
        TBITei6zQky9zyjxZ99TRpAWNgEtif0vbrCB2PwCihJXfzwGi/MK2Ek8af8NFmcRUJG4tHgu
        O4gtKhAh8fHpPiaIGkGJkzOfsIDYnALeEi939YHVMAuoS/yZd4kZwhaXuPVkPhOELS/RvHU2
        8wRG4VlI2mchaZmFpGUWkpYFjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCo1VL
        cwfj5SXxhxgFOBiVeHg3/AqKEWJNLCuuzD3EKMHBrCTCO5slJEaINyWxsiq1KD++qDQntfgQ
        ozQHi5I479O8Y5FCAumJJanZqakFqUUwWSYOTqkGRnG7rZ/r+d849G/pbfq/sO50yXKdW2tb
        ax01jy6W8l3w6kGz/GWHOdsvfQo//9hZ+8vDm4e2Zmxd/vHGWasc86MTjn/l4zzOqqP6mut5
        XMk03QU+bLpyv5+YZXXNc2eqXyqV/ffJx9RLWgs7Eic//n/Y20z4/rLHzxf/tE7qYyj4LxcR
        92n2/m9KLMUZiYZazEXFiQBEQO800gIAAA==
X-CMS-MailID: 20190201084414epcas1p3f302302313e90b13966aca98289aadd1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
        <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
> Controller frequencies for driver's DRAM timings.
> 
> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
> CC: Chanwoo Choi <cw00.choi@samsung.com>
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: linux-samsung-soc@vger.kernel.org
> CC: linux-clk@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 3e87421..8bf9579 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1325,6 +1325,19 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>  	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
>  };
>  
> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
> +	PLL_35XX_RATE(24 * MHZ, 933000000, 311, 4, 1),
> +	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
> +	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
> +	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
> +	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
> +	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
> +	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
> +	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
> +	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
> +	PLL_35XX_RATE(24 * MHZ, 138000000, 184, 2, 4),

Except for 825Mhz, I can't find the target frequency
on Exynos5422 TRM document. Usually, Exynos TRM specified
the supported stable clocks. It means that undefined clocks
are not stable as I knew. Where do you find them?

When I calculated the PLL frequency with PMS value, it is correct.
But, just we need to check the reference of undefined clocks on TRM
in order to guarantee the stable operation.

Remove 933/138Mhz because exynos5433-dmc.c doesn't use 933Mhz and 138Mhz
and also Exynos5422 TRM doesn't define 933/138Mhz on pll table.

> +};
> +
>  static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>  	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
>  	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
> @@ -1467,7 +1480,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>  		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>  		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>  		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> -		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
> +		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;

Exynos5422 used the same PLL table for apll, kpll, bpll and so on.
You don't need to make the separate pll table. Just add new entries
to exynos5420_pll2550x_24mhz_tbl table.

>  	}
>  
>  	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
