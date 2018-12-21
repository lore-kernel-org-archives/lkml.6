Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943BEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551632176F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dRcLCsmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389506AbeLUK1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:27:20 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36446 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731627AbeLUK1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:27:20 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181221102718euoutp02730e70eb9429febe01f0508939ba955e~yUjuomb8V2344023440euoutp02U
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 10:27:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181221102718euoutp02730e70eb9429febe01f0508939ba955e~yUjuomb8V2344023440euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545388038;
        bh=vuVS/xIXU8/hnvofyyeEnccvitD34qO7Ai2dVr2AUf0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dRcLCsmHI3JtA7P8rj2oVXFs1v9s+Qs+WzdVN+4qa4pmDPjF5pP8ViVjiiKVbp3TU
         0p1w0hKqC1yScVhFlHwzXTQ3xbbJLpjf2X7idkG5f26bc8zQgVyE5i0AFtcz0vT+ea
         cPpAckx5XZ5D9N3DBuUrVBsSkXDqJYeVQ1EKEUQQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181221102717eucas1p2174e936c9803c2fd345a94015da46b47~yUjuKNnOx1984919849eucas1p2V;
        Fri, 21 Dec 2018 10:27:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EE.78.04294.500CC1C5; Fri, 21
        Dec 2018 10:27:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181221102716eucas1p281266752d283cd17a793ec01ccc67391~yUjtPu9gv0431204312eucas1p2n;
        Fri, 21 Dec 2018 10:27:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181221102716eusmtrp292e86dd5a4d9e54fd8d11d8bb6cfe54b~yUjtA07nK2666126661eusmtrp2E;
        Fri, 21 Dec 2018 10:27:16 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-1e-5c1cc0051f9c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 19.FA.04284.400CC1C5; Fri, 21
        Dec 2018 10:27:16 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181221102716eusmtip15218bc79e43c5c5690860dd4f0567c44~yUjskCb4T0492004920eusmtip13;
        Fri, 21 Dec 2018 10:27:16 +0000 (GMT)
Subject: Re: [PATCH 1/4] mfd: exynos-lpass: Enable UART module support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7a43948e-17b9-1fd6-6b11-400016a4a28c@samsung.com>
Date:   Fri, 21 Dec 2018 11:27:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181221101306.GH13248@dell>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+3a2s+Ns8jmtvTixGBUleRc6UbOCkPWPOaykWtnKg0pOZfOS
        SeAlLw0L0cB58hIMVIblJe+F6cxbKy8VdqHQYEKKw7wFhl2cR8v/fu/zPu/3vg98FCHpEHhQ
        cQnJjC5BEy8nRfzW/pVhH0G3p9q/58luutFYL6CtC61COsdUT9IjIw1CemK5D9FvO8tJ2jjS
        xaNfme4K6d7ZfAFtLJkmj4uUTeY7pPLz+DNS+byiTqi812xGysUmr3DBBdHRaCY+LpXR+YVc
        EcUWPh0lk0rwjUfV5zNRi9iAnCjAwdC9PIwMSERJcC2CvPwWAVcsIWifKxNyxSICtqmBvznC
        Ls4SXKMGga2uZsM1h6CqzMJzuNxwKMw3LK29RVHueA8Mzx5yyARe5MHXuXAHkzgADHYD6WAx
        DoFvuS8EDubjvVC+MIQcvAOrYSqzi895XGGozLbOTtgbxvqz+Nybu6DNXk5wLIVPtiqe4x7A
        L4UwXpgl5K4+CbltRYhjN5gZaN7QPeFPx+ZADoJ8IyvkikIELeXtJOc6Ar0DY+tpCHwA6jv9
        OPkEfHzdiBwyYBf4YHfljnCB4tZSgpPFUJAn4dz7gB14/G9tz+gbogjJ2S3R2C1x2C1x2P97
        HyK+GUmZFL02htEHJjBpvnqNVp+SEON7LVHbhNY+lPX3wFI76ly9akGYQvLt4tE2mVoi0KTq
        07UWBBQhdxcXKDzVEnG0Jv0mo0uM0qXEM3oLklF8uVScsW3yogTHaJKZ6wyTxOg2uzzKySMT
        +a9YrKxV5dyqiBxMWw1MORNRbQ7NyojyElF9k6XTqsrsX+M7L8tUxVDpf056NsywgpUqH2fV
        zMStg7zu5VMW33e3s8VJ8/tdT9sjE7Gy/2ewrDZnwphsmXkwlWeSVXyPPVyruqSIgLBGWRkx
        +D40yKZTHOv98uN+kCl3vkHO18dqArwJnV7zF9h+3s1MAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7osB2RiDJr+KlpsnLGe1eL0p23s
        Fs2L17NZnD+/gd3i/tejjBaXd81hs5hxfh+TxZnFvewWh9+0s1rMmPySzYHLY9OqTjaPO9f2
        sHnsn7uG3aNvyypGj8+b5AJYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV
        9O1sUlJzMstSi/TtEvQyenZfYCuYLFCxdllkA+NW3i5GTg4JAROJWZ/fMIPYQgJLGSV+foyF
        iMtInJzWwAphC0v8udbF1sXIBVTzllHizdJ2RpCEsICbxMcNX4CKODhEBFQkzr0xB6lhFvjM
        JHHgUyMjRMNTRonjNz8xgTSwCRhKdL0FmcTJwStgJ/Gi9QjYBhYBVYk5n04yggwSFYiReLag
        GqJEUOLkzCcsIDangJbExWONYDazgLrEn3mXmCFseYntb+dA2eISt57MZ5rAKDQLSfssJC2z
        kLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmA8bjv2c/MOxksbgw8xCnAwKvHw
        auySjhFiTSwrrsw9xCjBwawkwtthKxMjxJuSWFmVWpQfX1Sak1p8iNEU6LeJzFKiyfnAVJFX
        Em9oamhuYWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoGx85JNXnxHa9Lhji/f
        buqeqwy9LfdUmknjuc5tXfkTElu0z1w+lP/Ycm6eLOdpjk15q46ZnPT4sWFGMf+/7Lw3d09W
        HZ9uJOCSwpd68djqA70uSYuaX0vYCy2WO6ZlMNvn3NcgGX7pf1fKths3Mc9v+7xZTjf/EZ+W
        37Xyy43hN1Jv9hWY1T1WYinOSDTUYi4qTgQApgV5s90CAAA=
X-CMS-MailID: 20181221102716eucas1p281266752d283cd17a793ec01ccc67391
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181214113416eucas1p2002adf7b5438c525c34ff3274ceacbd1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214113416eucas1p2002adf7b5438c525c34ff3274ceacbd1
References: <20181214113410.22848-1-m.szyprowski@samsung.com>
        <CGME20181214113416eucas1p2002adf7b5438c525c34ff3274ceacbd1@eucas1p2.samsung.com>
        <20181214113410.22848-2-m.szyprowski@samsung.com>
        <20181221101306.GH13248@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2018-12-21 11:13, Lee Jones wrote:
> On Fri, 14 Dec 2018, Marek Szyprowski wrote:
>
>> From: Beomho Seo <beomho.seo@samsung.com>
>>
>> This patch enables support for UART module in Exynos Audio SubSystem.
>> There are boards (for example TM2), which use it for communication with
>> bluetooth chip.
> Does it though?  Or does it enable the interrupt and reset something?
> These calls would probably benefit from some documentation by way of
> comments.

It only enables routing interrupts out of LPASS HW module. This is
completely transparent for the rest of the system (UART and CPU/GIC).
UART driver will get them via standard ARM/GIC interrupt controller and
UART driver will enable/mask/handle it by itself via standard methods.

>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> [mszyprow: rephrased commit message, added UART reset]
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  drivers/mfd/exynos-lpass.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
>> index ca829f85672f..2713de989f05 100644
>> --- a/drivers/mfd/exynos-lpass.c
>> +++ b/drivers/mfd/exynos-lpass.c
>> @@ -82,11 +82,13 @@ static void exynos_lpass_enable(struct exynos_lpass *lpass)
>>  		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
>>  
>>  	regmap_write(lpass->top, SFR_LPASS_INTR_CPU_MASK,
>> -		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S);
>> +		     LPASS_INTR_SFR | LPASS_INTR_DMA | LPASS_INTR_I2S |
>> +		     LPASS_INTR_UART);
>>  
>>  	exynos_lpass_core_sw_reset(lpass, LPASS_I2S_SW_RESET);
>>  	exynos_lpass_core_sw_reset(lpass, LPASS_DMA_SW_RESET);
>>  	exynos_lpass_core_sw_reset(lpass, LPASS_MEM_SW_RESET);
>> +	exynos_lpass_core_sw_reset(lpass, LPASS_UART_SW_RESET);
>>  }
>>  
>>  static void exynos_lpass_disable(struct exynos_lpass *lpass)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

