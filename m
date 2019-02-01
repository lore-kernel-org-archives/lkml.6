Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93053C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EBC2084C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 13:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Pm3/c6uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfBAN4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 08:56:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51527 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbfBAN4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 08:56:06 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190201135604euoutp017cba7a1a36acabb664fbc182e4cbfe51~-Qf-2msn-2869228692euoutp01Q
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 13:56:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190201135604euoutp017cba7a1a36acabb664fbc182e4cbfe51~-Qf-2msn-2869228692euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549029364;
        bh=vGCkjjc38KTLZR8V8dBDUGhzuNKTWM8Hge6EE2HJtZE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Pm3/c6uoGWjqCDj0NZk/gM2TCpcgdJYPyZFdtTA3mSNYcvtueIFDt9hPv7Hke1zE6
         /N11bfjoPZo9IGMtbt2JRey0LhgyRHfbO6UeW7L33pwl//jaQHPpnZkVr3Czsvti/z
         bwzw3XdV+wt3FIrqEB1xrMKgxjownemOwEqJX6Oc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190201135603eucas1p2dc15b83ad9e6dfec8771c12b8cd42954~-Qf-LH5fl1873418734eucas1p2q;
        Fri,  1 Feb 2019 13:56:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 80.E1.04441.3FF445C5; Fri,  1
        Feb 2019 13:56:03 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190201135602eucas1p2abc21cde057d4c0e1311a2b02b8e17f9~-Qf_KFds13009530095eucas1p2n;
        Fri,  1 Feb 2019 13:56:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190201135602eusmtrp2b5a46a7b3408ade4a4587f772229dd66~-Qf97FPFv2700327003eusmtrp2f;
        Fri,  1 Feb 2019 13:56:02 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-3d-5c544ff3a203
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E9.1F.04128.2FF445C5; Fri,  1
        Feb 2019 13:56:02 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190201135601eusmtip1590c3adcd8bc2bfc4ae3f1586e07ca55~-Qf9QTqaU2387923879eusmtip1e;
        Fri,  1 Feb 2019 13:56:01 +0000 (GMT)
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To:     Chanwoo Choi <cw00.choi@samsung.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
Date:   Fri, 1 Feb 2019 14:56:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut3vvdl0tfm7mDmpGqz/KSBMiflD0wBWDosL8Q9SolZclbrN2
        1bSE7OmjVVL4aJZGRc5VqMvMSgumaBnLMl9lb5XKR5ozpHfd7iL/+853zne+88FhKWUbE8Am
        mJM5i1lv1EjldE3Tl9aFng1RcYuKX6hIVVEFQ7rG3zGktPEhQ070DlKktbVSRtwHhmTE2dvJ
        kE/Wlwx5cuuMlHiONSJS1HpHQq42vpCRxy2rSc9+u5Q0DGUx5GdnFb0S60a6D8t0TkeOVHft
        4j7d8WoH0nmcwRuZGPmyeM6YkMpZwpZvle+oy6d3eoLS+kdGqEw0qs5FPizgxXDPeY3ORXJW
        ie0IJorLvcU4glPv3zBi4UFw43ap7J+krf2gt1GGoKJuyCsZRtBSMkgLUyq8Cc42PZUKDT98
        AUF++TeJUFC4XgLnu60oF7GsFIdCrWOXIFDgNZB39yMlYBrPheE+299FM3A0NBz7iMQZX7h/
        uu8v74NXwI2cOomAKayGZ32lXjwLDl4vpsRTv8hg2J4oYi3kFFR6I6hgoLnai4Pg101RC5gH
        d7ZDKuIMyLpf651ZCg3NjxnhZArPh4pbYblI9odeBfUrBRLwdOge9hX9p8PJmkJKpBWQfUQp
        rpgH1dZHXht/KLtSIMtDGtukVLZJSWyTktj+u55DtAOpuRTeZOD4cDO3O5TXm/gUsyF0e5LJ
        if582oOfzWO16HPbNhfCLNJMU1R+jYxTMvpUPt3kQsBSGj+FXRsVp1TE69P3cJakLZYUI8e7
        UCBLa9SKvVNexyqxQZ/MJXLcTs7yrythfQIyUXRwQslUEtKY0R6bpsz0qX2+ILJ9aH0JZQ6M
        COlrfiSdOFzQ72razC156z/zcuHswY4uw7qbkQPZMTFRlrGw8JLn7u+BSQ0Z8drEYK38w9MP
        EZfWqjM7NliseYfyRmt+zHG/orQ9W631uqwBx4B+1lk1Z7w9xrmj8o9mR6gW6RI1NL9DHx5C
        WXj9bzCyDDNlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsVy+t/xu7qf/ENiDE70ilpsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4mPPPVaLy7vmsFl87j3CaDHj/D4mi7VH7rJb
        XDzlanG7cQWbxeE37awW/65tZHEQ8Hh/o5XdY9OqTjaPzUvqPfq2rGL0+LxJLoA1Ss+mKL+0
        JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jz1SWgs8yFU/f
        v2duYPwg3sXIySEhYCJx6UozaxcjF4eQwFJGiU0XzzFBJMQkJu3bzg5hC0v8udbFBlH0mlFi
        yY4JbCAJYYFgiS+t7xhBbBGBxYwSX1urQYqYBfYySUzoucwKkhASmMIk8etbTRcjBwebgJ7E
        jlWFIGFeATeJCfvfMYPYLAIqEm+fzGIBsUUFIiQ+Pt3HBFEjKHFy5hOwOKeAvcT2zj1gcWYB
        M4l5mx8yQ9jiEreezIeKy0s0b53NPIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73i
        xNzi0rx0veT83E2MwEjeduznlh2MXe+CDzEKcDAq8fBu+BUUI8SaWFZcmXuIUYKDWUmEd4VL
        SIwQb0piZVVqUX58UWlOavEhRlOg5yYyS4km5wOTTF5JvKGpobmFpaG5sbmxmYWSOO95g8oo
        IYH0xJLU7NTUgtQimD4mDk6pBsbDWzgF5TwiV3h39mTr2X6dlHz5xWpN/Vency5v/uJ/1+hW
        DndHgtODSMPINSeb177dyx7hf6uyZ9f/NdP8VE5n6Z0IMHxcWJC6/9+UyA0KX9+/+Cxm2rVD
        bFfaSc8tskfWCN9jz9lq0vTYZdo25ZQFEtM5bmnu65RqOWo9RWJbifSFS+8jXjkosRRnJBpq
        MRcVJwIAvHZ2vfoCAAA=
X-CMS-MailID: 20190201135602eucas1p2abc21cde057d4c0e1311a2b02b8e17f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
        <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
        <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 2/1/19 9:44 AM, Chanwoo Choi wrote:
> Hi,
> 
> On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
>> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
>> Controller frequencies for driver's DRAM timings.
>>
>> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> CC: Chanwoo Choi <cw00.choi@samsung.com>
>> CC: Michael Turquette <mturquette@baylibre.com>
>> CC: Stephen Boyd <sboyd@kernel.org>
>> CC: Kukjin Kim <kgene@kernel.org>
>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>> CC: linux-samsung-soc@vger.kernel.org
>> CC: linux-clk@vger.kernel.org
>> CC: linux-arm-kernel@lists.infradead.org
>> CC: linux-kernel@vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>> index 3e87421..8bf9579 100644
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -1325,6 +1325,19 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>>   	PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
>>   };
>>   
>> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
>> +	PLL_35XX_RATE(24 * MHZ, 933000000, 311, 4, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
>> +	PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
>> +	PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
>> +	PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
>> +	PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
>> +	PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
>> +	PLL_35XX_RATE(24 * MHZ, 138000000, 184, 2, 4),
> 
> Except for 825Mhz, I can't find the target frequency
> on Exynos5422 TRM document. Usually, Exynos TRM specified
> the supported stable clocks. It means that undefined clocks
> are not stable as I knew. Where do you find them?
> 
> When I calculated the PLL frequency with PMS value, it is correct.
> But, just we need to check the reference of undefined clocks on TRM
> in order to guarantee the stable operation.
They values live in vendor code for Android.
I have tested the DMC & DDR with these ratios in stress scenarios
for a few days and it was stable.

> 
> Remove 933/138Mhz because exynos5433-dmc.c doesn't use 933Mhz and 138Mhz
> and also Exynos5422 TRM doesn't define 933/138Mhz on pll table.
OK, I will remove them.
> 
>> +};
>> +
>>   static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>>   	PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
>>   	PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
>> @@ -1467,7 +1480,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>>   		exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>   		exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>>   		exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>> -		exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>> +		exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
> 
> Exynos5422 used the same PLL table for apll, kpll, bpll and so on.
> You don't need to make the separate pll table. Just add new entries
> to exynos5420_pll2550x_24mhz_tbl table.
OK, I will extend the exynos5420_pll2550x_24mhz_tbl table.

In v4 patch set, it will be fixed.

Regards,
Lukasz
> 
>>   	}
>>   
>>   	samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
>>
> 
