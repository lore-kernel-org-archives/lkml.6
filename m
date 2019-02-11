Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9C6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D9421479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p/btbM9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfBKKVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:21:22 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40578 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfBKKVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:21:22 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190211102120euoutp0256e68e4f226d46694eb30d87dd08c872~CSBXkxTMC2476324763euoutp02L
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:21:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190211102120euoutp0256e68e4f226d46694eb30d87dd08c872~CSBXkxTMC2476324763euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549880480;
        bh=K2FIyDmnWvCgj41oCrevnXqZlOJCrg0iCZ9pY71VDXA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=p/btbM9jv36Fa+R+PQJYYwCJXQ7iOR7KCeD16gu5WCMaDoJppDy84Yh0fgmYPOmKd
         qoDiYriQHBahMCasKKIlKtYqWgFXAsrdQEci9oUCZENo3Asg4EPKx4SYCokHPeLf3Y
         JYi1nTbkE2ITVKafk1EbyqY98prZ2sjuxsaAtaFc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190211102119eucas1p23f2c92e207e580bf5e9f3534aed79a94~CSBWa0eCg1662316623eucas1p2q;
        Mon, 11 Feb 2019 10:21:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3A.2A.04441.F9C416C5; Mon, 11
        Feb 2019 10:21:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190211102118eucas1p10b2314a2e0cd705d33b4c38fb0689e0f~CSBVcw-NF0736807368eucas1p1D;
        Mon, 11 Feb 2019 10:21:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190211102118eusmtrp2e3f9fc078c216c81a0d09f338d4b3a54~CSBVauSFO2373523735eusmtrp2x;
        Mon, 11 Feb 2019 10:21:18 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-d0-5c614c9f44c0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 07.9B.04284.E9C416C5; Mon, 11
        Feb 2019 10:21:18 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190211102117eusmtip11f839c551290c2939e80d5ff8e800197~CSBUvhTfM0168301683eusmtip1f;
        Mon, 11 Feb 2019 10:21:17 +0000 (GMT)
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To:     cwchoi00@gmail.com
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <59a5e9bc-a5de-9f98-5710-4cd48cb5b239@partner.samsung.com>
Date:   Mon, 11 Feb 2019 11:21:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGTfZH05zn_FiNt3zSHZJfspvo4RXWPrAtWLUq5xsqKoB3qxBA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUhUURj1zps377mMXEfNj0lKBm0lNwJvC1KhMUVE0Y+ihHrlcynHbJ5a
        lpAmpZktirhMhoaVNhXlaKWDmrkNWm6Vtm80FJpj5kKWoTk+Jf+de8757vkOfCyleEMr2cjo
        WF4bzUWpZHbSB82/O1YUbuFCfLuNDCnLu0uTlyPfaPK1aTkpbGynycUv3ynS0XGPIW2n+hli
        +NJDk58ZH2jy3FggI8PnGxHJ66iVkDuN7xnS1RpM3iaXykhDfypNJnrKpOuc1D9enWbUVbr3
        jNqgPytTl187qb5QoUfqYcOCbbLddmtD+ajIeF7rE7jPLqK33z9mXHWsu9giSUIG93RkywJe
        Cf352VQ6smMVuBTB+FgNsgoKPIKgp9VTFIYR3M+7xcxO6C0PaVEoQZBRfEMiPiwI3hWfo6wu
        Z7wDrjS/llmxC54HD3PMyGqi8CMajL19U+MsK8PeUKk/YvXI8UbILKyYTpBiL8gtvimxYle8
        CxrODyDR4wQt+WapFdvi7VBnLp3mKewGb8yFEhEvhJT7l6f7AE5mIbusfmbtIDAm3ZKK2Bn6
        TBUzvDtMVonDgAVoS9PLRJwIqS2VM5410GDqmt6ZwkvhrtEnHTFT9HqoWWclATvCK4uTuIAj
        ZD3IpURaDmlnFOIXS6Aio3MmZh6U3M5hLiGVbk4t3ZwqujlVdP9Ti5BUj9z4OEETzgt+0fxR
        b4HTCHHR4d4HDmsMaOrinkyYhirR6LP99QizSOUgH+T2hShoLl5I0NQjYCmVi3z/Ji5EIQ/l
        Eo7z2sN7tXFRvFCP5rNSlZv8hM2nPQoczsXyh3g+htfOqhLWVpmEXBZX2zsN3PgccPXM2Iux
        gA2JHuWqZ6vKOX/LhdrXi1IXf0xWHlBybb6bbbwO5po1muT8waUlXp8dOhsG0of9jio8U+qq
        R9P0QmNAe7Bbnun6n1QPX4/HLdtdBv56B6Ktul/2YZlDpCri+dOCpsoiiJ90NQ29Wx2kHKva
        meXYlB+mkgoRnN8ySitw/wBcWbGwbQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xu7rzfBJjDG6uF7TYOGM9q8X1L89Z
        LZ4d1baYf+Qcq0X/49fMFufPb2C3ONv0ht1i0+NrrBYfe+6xWlzeNYfN4nPvEUaLGef3MVms
        PXKX3eLiKVeL240r2CwOv2lntfh3bSOLg6DH+xut7B47Z91l99i0qpPNY/OSeo++LasYPT5v
        kgtgi9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL
        ePnGqOC3UsXVxW+ZGhg3yXQxcnJICJhIrHq7nbWLkYtDSGApo8SbDd3sEAkxiUn7tkPZwhJ/
        rnWxQRS9ZpS4frSFGSQhLBAs8aX1HSOILQLUsH3aE0aQImaBo6wS1zpvQY2dwSwx+/hCIIeD
        g01AT2LHqkKQBl4BN4mJ87eAbWARUJWYvnglE4gtKhAh8fHpPiaIGkGJkzOfsIDYnAKBEgee
        rABbxixgJjFv80NmCFtc4taT+UwQtrxE89bZzBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3O
        Tc8tNtQrTswtLs1L10vOz93ECIzubcd+bt7BeGlj8CFGAQ5GJR7eD4kJMUKsiWXFlbmHGCU4
        mJVEeJM8E2OEeFMSK6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YePJK4g1NDc0tLA3Njc2NzSyU
        xHnPG1RGCQmkJ5akZqemFqQWwfQxcXBKNTBO21+yLGnPPpYDM35mKd8VP84lnnv54o9d9xcw
        5n14nckj3Boidm/T5htRU+Wt25untLcc/nw0Szvr14asJz9EP96fP1EmzqHszW9v3yQbT7+t
        Ej9u9O2clzPr+Mw/Z98xlN9oYNcwMPHvj8786fbR+NWmt2eYdaraTP+snTdfPHCGOe+y85vW
        KrEUZyQaajEXFScCAMIXbYoEAwAA
X-CMS-MailID: 20190211102118eucas1p10b2314a2e0cd705d33b4c38fb0689e0f
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
        <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
        <CAGTfZH05zn_FiNt3zSHZJfspvo4RXWPrAtWLUq5xsqKoB3qxBA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 2/3/19 8:54 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> 2019년 2월 1일 (금) 오후 11:22, Lukasz Luba <l.luba@partner.samsung.com>님이 작성:
> 
>>
>> Hi Chanwoo,
>>
>> On 2/1/19 9:44 AM, Chanwoo Choi wrote:
>>> Hi,
>>>
>>> On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
>>>> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
>>>> Controller frequencies for driver's DRAM timings.
>>>>
>>>> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>>> CC: Chanwoo Choi <cw00.choi@samsung.com>
>>>> CC: Michael Turquette <mturquette@baylibre.com>
>>>> CC: Stephen Boyd <sboyd@kernel.org>
>>>> CC: Kukjin Kim <kgene@kernel.org>
>>>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>>>> CC: linux-samsung-soc@vger.kernel.org
>>>> CC: linux-clk@vger.kernel.org
>>>> CC: linux-arm-kernel@lists.infradead.org
>>>> CC: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    drivers/clk/samsung/clk-exynos5420.c | 15 ++++++++++++++-
>>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>>>> index 3e87421..8bf9579 100644
>>>> --- a/drivers/clk/samsung/clk-exynos5420.c
>>>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>>>> @@ -1325,6 +1325,19 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>>>>       PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
>>>>    };
>>>>
>>>> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
>>>> +    PLL_35XX_RATE(24 * MHZ, 933000000, 311, 4, 1),
>>>> +    PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
>>>> +    PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
>>>> +    PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
>>>> +    PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
>>>> +    PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
>>>> +    PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
>>>> +    PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
>>>> +    PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
>>>> +    PLL_35XX_RATE(24 * MHZ, 138000000, 184, 2, 4),
>>>
>>> Except for 825Mhz, I can't find the target frequency
>>> on Exynos5422 TRM document. Usually, Exynos TRM specified
>>> the supported stable clocks. It means that undefined clocks
>>> are not stable as I knew. Where do you find them?
>>>
>>> When I calculated the PLL frequency with PMS value, it is correct.
>>> But, just we need to check the reference of undefined clocks on TRM
>>> in order to guarantee the stable operation.
>> They values live in vendor code for Android.
>> I have tested the DMC & DDR with these ratios in stress scenarios
>> for a few days and it was stable.
> 
> If possible, please share the url of original vendor code.
Here is the vendor code for the BPLL values:
https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y-android/drivers/clk/samsung/clk-exynos5422.c#L2026

Regards,
Lukasz
> 
>>
>>>
>>> Remove 933/138Mhz because exynos5433-dmc.c doesn't use 933Mhz and 138Mhz
>>> and also Exynos5422 TRM doesn't define 933/138Mhz on pll table.
>> OK, I will remove them.
>>>
>>>> +};
>>>> +
>>>>    static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>>>>       PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
>>>>       PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
>>>> @@ -1467,7 +1480,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>>>>               exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>>>               exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>>>>               exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>>> -            exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>>> +            exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
>>>
>>> Exynos5422 used the same PLL table for apll, kpll, bpll and so on.
>>> You don't need to make the separate pll table. Just add new entries
>>> to exynos5420_pll2550x_24mhz_tbl table.
>> OK, I will extend the exynos5420_pll2550x_24mhz_tbl table.
>>
>> In v4 patch set, it will be fixed.
>>
>> Regards,
>> Lukasz
>>>
>>>>       }
>>>>
>>>>       samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
>>>>
>>>
> 
> 
> 
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
> 
> 
