Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DE7C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247082084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NVf5yZTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfBKKfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:35:04 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:47082 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfBKKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:35:04 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190211103502epoutp035b0c5d97250bcaa9de3721d9d715a581~CSNUun8V02392623926epoutp03W
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190211103502epoutp035b0c5d97250bcaa9de3721d9d715a581~CSNUun8V02392623926epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549881302;
        bh=kvJT524Acja0/UcdtDWaZ04nkAJMpL0CGUrN0Y/rid8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NVf5yZTOoFQe6/1M9AmFo7FLc173ISEKqpGMDeF59Nhkvhg/VxOJ9qZ7CbrWz4Sql
         F1lCYjeZ+zNsj+zNx83ZXlHXpy04vS8An1GKCSzYFTL5vMsUlmDVjVVAN+v+Ew8vdE
         hzgR8YvPteG/zIyHhd4121SbiLn36Z4cSqalZtj0=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190211103459epcas1p3faf7108b710ebbdbb7a59038a1980847~CSNSX5j6M2023720237epcas1p3P;
        Mon, 11 Feb 2019 10:34:59 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.1D.04069.3DF416C5; Mon, 11 Feb 2019 19:34:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190211103459epcas1p3904fadb55b588dcceb5bc0248a1dce60~CSNR9WRYW2023020230epcas1p3R;
        Mon, 11 Feb 2019 10:34:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190211103459epsmtrp262c15a03e9dad3de4a684c3c2988611b~CSNR5zRi00604906049epsmtrp2A;
        Mon, 11 Feb 2019 10:34:59 +0000 (GMT)
X-AuditID: b6c32a37-989ff70000000fe5-62-5c614fd34ce8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.9C.03971.2DF416C5; Mon, 11 Feb 2019 19:34:59 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190211103458epsmtip161de85e79249ea9616f4c0a737de038b~CSNRoOEQS2986329863epsmtip1R;
        Mon, 11 Feb 2019 10:34:58 +0000 (GMT)
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To:     Lukasz Luba <l.luba@partner.samsung.com>, cwchoi00@gmail.com
Cc:     devicetree <devicetree@vger.kernel.org>,
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
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <790ea13b-7a44-2452-a6b2-51102e60c290@samsung.com>
Date:   Mon, 11 Feb 2019 19:34:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <59a5e9bc-a5de-9f98-5710-4cd48cb5b239@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRmVeSWpSXmKPExsWy7bCmru5l/8QYg9XvVS02zljPavHsqLbF
        /CPnWC36H79mtjh/fgO7xdmmN+wWtxpkLDY9vsZq8bHnHqvF5V1z2Cw+9x5htJhxfh+Txdoj
        d9ktLp5ytbjduILN4vCbdlaLf9c2sjgIery/0crusXPWXXaPTas62Tw2L6n3OPhuD5NH35ZV
        jB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYAna+kUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0
        MDAyBSpMyM74cHMFa8FF/Yrmb4vZGxhPqHYxcnBICJhILPlU3sXIxSEksINRYt6KLcwQzidG
        iUmHLzJBON8YJc739zDCdHSs8YWI72WUWPOqAaroPaPEwmXNQEWcHMICwRJzj91kA7FFBBwk
        dt58yQhSxCwwnVWi+fpeFpAEm4CWxP4XN8CK+AUUJa7+eAzWzCtgJ/Gn/Q1YDYuAqsSCWc1g
        tqhAhMTh3ndQNYISJ2c+AYtzCrhLzNv/iBnEZhYQl7j1ZD4ThC0v0bx1Ntg/EgKH2CVeL/0E
        ViQh4CIxs+8fC4QtLPHq+BZ2CFtK4vO7vWwQdrXEypNH2CCaOxgltuy/wAqRMJbYv3QyEygs
        mAU0Jdbv0odYxifx7msPKySIeCU62oQgqpUlLj+4ywRhS0osbu+EGu8hMWnuJLYJjIqzkLwz
        C8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBcbIsb2JEZy0tcx3MG4453OIUYCDUYmH90NiQowQ
        a2JZcWXuIUYJDmYlEd5Q38QYId6UxMqq1KL8+KLSnNTiQ4ymwNCeyCwlmpwPzCh5JfGGpkbG
        xsYWJoZmpoaGSuK86x2cY4QE0hNLUrNTUwtSi2D6mDg4pRoYO44FNrhz7V+Q5qnLUNT4TNLn
        tJT/tVcnd7F8PePSXy+0s3mK9Z/VhS4bpiht999SzeQ9ebtU3FbRpuN7E85q7BSdtulzhccM
        /fzae9tf33Z+u9fhjWD2Svvq59knNwYYxO8/U/xZkWcyL6Me673zNxdKnr5n9NdwxYwjD7bs
        2/FvUeCKzym6UkosxRmJhlrMRcWJAKuT2mzwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsWy7bCSnO5l/8QYg2uLmC02zljPavHsqLbF
        /CPnWC36H79mtjh/fgO7xdmmN+wWtxpkLDY9vsZq8bHnHqvF5V1z2Cw+9x5htJhxfh+Txdoj
        d9ktLp5ytbjduILN4vCbdlaLf9c2sjgIery/0crusXPWXXaPTas62Tw2L6n3OPhuD5NH35ZV
        jB6fN8kFsEdx2aSk5mSWpRbp2yVwZXy4uYK14KJ+RfO3xewNjCdUuxg5OCQETCQ61vh2MXJy
        CAnsZpQ4voMHxJYQkJSYdvEoM0SJsMThw8VdjFxAJW8ZJWbdWMUOUiMsECzxpfUdI4gtIuAg
        sfPmSzCbWWAuq8S1M7UQDVeZJT59XA7WwCagJbH/xQ02EJtfQFHi6o/HYA28AnYSf9rfsIDY
        LAKqEgtmNYPZogIREh+f7mOCqBGUODnzCVicU8BdYt7+R8wQy9Ql/sy7BGWLS9x6Mp8JwpaX
        aN46m3kCo/AsJO2zkLTMQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsY
        wbGrpbmD8fKS+EOMAhyMSjy8HxITYoRYE8uKK3MPMUpwMCuJ8Ib6JsYI8aYkVlalFuXHF5Xm
        pBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwNgswCY+8aK0T8+qr3lSb+epXNNs
        /rmrdsLOE8d9zdZsLGIVrNwSmG3hHpuQdPz01AVbdt60uPjr/2aLkI/K3fELr2gd0y/U8XIq
        WRzqvv7PF1Zrhs/bp7xI2HFh4tHF0p6Gu1ztSqSb4+7PnV0Rf+3wpCWqbXMKs3xYN0xY1P/l
        99UrjVf8JBmVWIozEg21mIuKEwGc9ccJ2QIAAA==
X-CMS-MailID: 20190211103459epcas1p3904fadb55b588dcceb5bc0248a1dce60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
        <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
        <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
        <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
        <CAGTfZH05zn_FiNt3zSHZJfspvo4RXWPrAtWLUq5xsqKoB3qxBA@mail.gmail.com>
        <59a5e9bc-a5de-9f98-5710-4cd48cb5b239@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 11. 오후 7:21, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 2/3/19 8:54 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> 2019년 2월 1일 (금) 오후 11:22, Lukasz Luba <l.luba@partner.samsung.com>님이 작성:
>>
>>>
>>> Hi Chanwoo,
>>>
>>> On 2/1/19 9:44 AM, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> On 19. 1. 31. 오후 5:49, Lukasz Luba wrote:
>>>>> Add new table rate for BPLL for Exynos5422 SoC supporting Dynamic Memory
>>>>> Controller frequencies for driver's DRAM timings.
>>>>>
>>>>> CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
>>>>> CC: Chanwoo Choi <cw00.choi@samsung.com>
>>>>> CC: Michael Turquette <mturquette@baylibre.com>
>>>>> CC: Stephen Boyd <sboyd@kernel.org>
>>>>> CC: Kukjin Kim <kgene@kernel.org>
>>>>> CC: Krzysztof Kozlowski <krzk@kernel.org>
>>>>> CC: linux-samsung-soc@vger.kernel.org
>>>>> CC: linux-clk@vger.kernel.org
>>>>> CC: linux-arm-kernel@lists.infradead.org
>>>>> CC: linux-kernel@vger.kernel.org
>>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>>> ---
>>>>>    drivers/clk/samsung/clk-exynos5420.c | 15 ++++++++++++++-
>>>>>    1 file changed, 14 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
>>>>> index 3e87421..8bf9579 100644
>>>>> --- a/drivers/clk/samsung/clk-exynos5420.c
>>>>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>>>>> @@ -1325,6 +1325,19 @@ static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __ini
>>>>>       PLL_35XX_RATE(24 * MHZ, 200000000,  200, 3, 3),
>>>>>    };
>>>>>
>>>>> +static const struct samsung_pll_rate_table exynos5422_bpll_rate_table[] = {
>>>>> +    PLL_35XX_RATE(24 * MHZ, 933000000, 311, 4, 1),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 825000000, 275, 4, 1),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 728000000, 182, 3, 1),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 633000000, 211, 4, 1),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 543000000, 181, 2, 2),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 413000000, 413, 6, 2),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 275000000, 275, 3, 3),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 206000000, 206, 3, 3),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 165000000, 110, 2, 3),
>>>>> +    PLL_35XX_RATE(24 * MHZ, 138000000, 184, 2, 4),
>>>>
>>>> Except for 825Mhz, I can't find the target frequency
>>>> on Exynos5422 TRM document. Usually, Exynos TRM specified
>>>> the supported stable clocks. It means that undefined clocks
>>>> are not stable as I knew. Where do you find them?
>>>>
>>>> When I calculated the PLL frequency with PMS value, it is correct.
>>>> But, just we need to check the reference of undefined clocks on TRM
>>>> in order to guarantee the stable operation.
>>> They values live in vendor code for Android.
>>> I have tested the DMC & DDR with these ratios in stress scenarios
>>> for a few days and it was stable.
>>
>> If possible, please share the url of original vendor code.
> Here is the vendor code for the BPLL values:
> https://github.com/hardkernel/linux/blob/odroidxu3-3.10.y-android/drivers/clk/samsung/clk-exynos5422.c#L2026

Thanks for sharing.

bpll_rate_table has two different supported frequency
according to exynos5422 revision as following:
But, this patch only has only one frequency set
for CONFIG_SOC_EXYNOS5422_REV_0.

Could you guarantee that all Exynos5422-based Odroid-xu3 board
has CONFIG_SOC_EXYNOS5422_REV_0 ersion? If not guaranteed,
some board might be fault because of using the unsupported
frequencies.

It is dangerous and unstable to use the unsupported frequencies to SoC.

struct samsung_pll_rate_table bpll_rate_table[] = {
	/* rate		p	m	s	k */
#ifdef CONFIG_SOC_EXYNOS5422_REV_0
	{ 933000000U,   4,  311,    1,  0},
	{ 925000000U,   4,  307,    1,  0},
	{ 825000000U,   4,  275,    1,  0},
	{ 728000000U,   3,  182,    1,  0},
	{ 633000000U,   4,  211,    1,  0},
	{ 543000000U,   2,  181,    2,  0},
	{ 413000000U,   6,  413,    2,  0},
	{ 275000000U,   3,  275,    3,  0},
	{ 206000000U,   3,  206,    3,  0},
	{ 165000000U,   2,  110,    3,  0},
	{ 138000000U,   2,  184,    4,  0},
#else
	{ 933000000U,   4,  311,    1,  0},
	{ 800000000U,   3,  200,    1,  0},
	{ 733000000U,   2,  122,    1,  0},
	{ 667000000U,   2,  111,    1,  0},
	{ 533000000U,   3,  266,    2,  0},
	{ 400000000U,   3,  200,    2,  0},
	{ 266000000U,   3,  266,    3,  0},
	{ 200000000U,   3,  200,    3,  0},
	{ 160000000U,   3,  160,    3,  0},
#endif
};


> 
> Regards,
> Lukasz
>>
>>>
>>>>
>>>> Remove 933/138Mhz because exynos5433-dmc.c doesn't use 933Mhz and 138Mhz
>>>> and also Exynos5422 TRM doesn't define 933/138Mhz on pll table.
>>> OK, I will remove them.
>>>>
>>>>> +};
>>>>> +
>>>>>    static const struct samsung_pll_rate_table exynos5420_epll_24mhz_tbl[] = {
>>>>>       PLL_36XX_RATE(24 * MHZ, 600000000U, 100, 2, 1, 0),
>>>>>       PLL_36XX_RATE(24 * MHZ, 400000000U, 200, 3, 2, 0),
>>>>> @@ -1467,7 +1480,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
>>>>>               exynos5x_plls[apll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>>>>               exynos5x_plls[epll].rate_table = exynos5420_epll_24mhz_tbl;
>>>>>               exynos5x_plls[kpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>>>> -            exynos5x_plls[bpll].rate_table = exynos5420_pll2550x_24mhz_tbl;
>>>>> +            exynos5x_plls[bpll].rate_table = exynos5422_bpll_rate_table;
>>>>
>>>> Exynos5422 used the same PLL table for apll, kpll, bpll and so on.
>>>> You don't need to make the separate pll table. Just add new entries
>>>> to exynos5420_pll2550x_24mhz_tbl table.
>>> OK, I will extend the exynos5420_pll2550x_24mhz_tbl table.
>>>
>>> In v4 patch set, it will be fixed.
>>>
>>> Regards,
>>> Lukasz
>>>>
>>>>>       }
>>>>>
>>>>>       samsung_clk_register_pll(ctx, exynos5x_plls, ARRAY_SIZE(exynos5x_plls),
>>>>>
>>>>
>>
>>
>>
>> --
>> Best Regards,
>> Chanwoo Choi
>> Samsung Electronics
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
