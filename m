Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879B1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E70B2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eY1YyAiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E70B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeJRRkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:40:24 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52345 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbeJRRkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:40:24 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181018094013euoutp0291d911bede4c45a7b5e1576b938d4fb0~eqoWYH-BP2244522445euoutp02f
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:40:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181018094013euoutp0291d911bede4c45a7b5e1576b938d4fb0~eqoWYH-BP2244522445euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539855613;
        bh=omn37BRFkXouUUmTDbfff3MAt739A7kJOVfI1hoi6BM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eY1YyAiNksV4TKKZWowNKAPGy0eau4S0eYN0oaBaGE40Cvg40shEs15qAaCq8SY4J
         TRvlFyIq/EmAkBcf6SHf04f/dsY77/Whs9BEHN/0n0rn9driroAzNK7Ws9wqMsc/Kd
         lTH7nzoYaG1wM8gM6F13/FC/c5uEtFCGnsKYW4cs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018094012eucas1p2dd1f19559e2242f2f360b80c4c1f3623~eqoVTA7V-2851828518eucas1p2b;
        Thu, 18 Oct 2018 09:40:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4D.F0.04441.BF458CB5; Thu, 18
        Oct 2018 10:40:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181018094011eucas1p11831fa3b26007be54af17d57852e120b~eqoUWGdbK0807208072eucas1p1I;
        Thu, 18 Oct 2018 09:40:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181018094010eusmtrp28b2dd8349a7f63fd01b6924e7a4b670c~eqoUFmdsX2897428974eusmtrp2z;
        Thu, 18 Oct 2018 09:40:10 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-30-5bc854fb6dd8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 52.A0.04284.AF458CB5; Thu, 18
        Oct 2018 10:40:10 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181018094010eusmtip1b33e01e2ecef3aa4c703320fd90c6a0d~eqoTlR0W50528505285eusmtip1G;
        Thu, 18 Oct 2018 09:40:10 +0000 (GMT)
Subject: Re: [PATCH v3 3/6] clocksource: exynos_mct: Refactor resources
 allocation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com, marc.zyngier@arm.com,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, Inki Dae <inki.dae@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu, 18 Oct 2018 11:40:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcMPz0wsEU9Lt1e0dp7tEk9+t8kteW=hih7sNsp99Dkkw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjl5713u5qT61z5YVawrDDwVWE3FmEPaER/lAlSSrryptamsquW
        RaRIqUtNBUnnozDRMp/zbSVsopsVaioqQ0pUKBXT1Hxk09xulv+dc77z/b5z4Ediwo+EExke
        Ec0oI2RyMc8Gb+hY6XJb9TMEeI51HKVrcqoIeqYkFdGDC18JunB+F531JQOnu7ur+bRmbICg
        +1ryeXROd6sVbRpe49G1mmyMnvhhwH1speWF5UiqKUvhSYcH3vKk37u6+NLa4gfS9LoyJJ3X
        7L7Av2JzPISRh8cySo8TwTZheaO1RFTijjvpGZn8eJRmr0LWJFBHoKiz1UqFbEgh9RLBiyoD
        nyMLCJp0YwRH5hFUL2qxzZWC9kZkxkKqFEFlt5AzzSAwFGRYTA6UH6Q/1vHMWES5wqBpyfIS
        RpVgMGVYJswDHuUFqmmVxYRT+yDTlLYRhCS3U4Gw2iIxywLKHjpzx3EztqYugi673YIxag80
        TudjHHYE4/gzSwegjHxo6lrEuOVYWO9/hXOpz4AqoeUvdoBJfR2fw86w3ry5nIggKUfN50gq
        gvr8Jh7nkkCb/hNhTodt1Klq8eDkk2BKqcHNMlB2MDRtzwWyg6yGpxgnCyD5kZBz7we1vvLf
        WW1PL5aBxOotNdVbqqm3VFP/v/sc4WXIkYlhFaEM6xXB3HZnZQo2JiLU/XqkQoM2/tiHNf1c
        E/rZe02HKBKJbQUjjD5ASMhi2TiFDgGJiUWCe96GAKEgRBZ3l1FGBilj5AyrQztJXOwoKCms
        CRBSobJo5hbDRDHKzakVae0Uj/JuBB42kf7L9Qdqs6bO9rn5Piki+w25uiEXZ8mk9OEll1Na
        r1nt+gAxmiwOUvgPpfWIHJLuO68UN5fe7DsUb/R5b3R49+tb22zw3KIkL37N8+pa4u9t8vNZ
        9iM9wRNk5l5WvvrZWLMYln4OjYoqKkJfX3bNXpJ4Jxx7Uz9w2jdVjLNhMq+DmJKV/QEBQP+X
        XwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7q/Qk5EGxz6Y2qxccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyeLvnX9sFps3TWW2ePnxBIsD
        j8eaeWsYPTat6mTzuHNtD5vHu3Pn2D02L6n36NuyitHj8ya5APYoPZui/NKSVIWM/OISW6Vo
        QwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzZjzazFjSLVfRNmMjewNgr2MXI
        ySEhYCIx9+h2RhBbSGApo8S/YxUQcRmJk9MaWCFsYYk/17rYIGreMkpcOOEBYgsLhEj0dR8C
        i4sIaEpc//sdqJ6Lg1lgGbPEv/lP2CEaupgkLrfkgNhsAoYSXW8hBvEK2EncevQarIZFQFVi
        4t9eJhBbVCBG4ujkFqgaQYmTM5+wgNicAoESh6YeBbOZBdQl/sy7xAxhy0tsfzsHyhaXuPVk
        PtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQKjdtuxn5t3
        MF7aGHyIUYCDUYmH90Hq8Wgh1sSy4srcQ4wSHMxKIrzVZieihXhTEiurUovy44tKc1KLDzGa
        Aj03kVlKNDkfmFDySuINTQ3NLSwNzY3Njc0slMR5zxtURgkJpCeWpGanphakFsH0MXFwSjUw
        St2eoczX8mHn/u4+U1Fz72OzCzx26fxbIJX80lB8m9fZdwvXzasqvrBi3pkFXxszFwYwpuh4
        /vFs1xNx6zJoSItd0LO1YuvSxiPLd3++61+ecmftpe7yMyedNmek59usyv3/709FUvqDyQoc
        M2JUi04sZd0p4rxnmqCn67K7+TWfYxcwXYtwVGIpzkg01GIuKk4EAGuDw4DwAgAA
Message-Id: <20181018094011eucas1p11831fa3b26007be54af17d57852e120b~eqoUWGdbK0807208072eucas1p1I@eucas1p1.samsung.com>
X-CMS-MailID: 20181018094011eucas1p11831fa3b26007be54af17d57852e120b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181017134206eucas1p1ebc76569f706675d41f2d2183349f1f3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017134206eucas1p1ebc76569f706675d41f2d2183349f1f3
References: <CGME20181017134206eucas1p1ebc76569f706675d41f2d2183349f1f3@eucas1p1.samsung.com>
        <20181017134159.9656-1-m.szyprowski@samsung.com>
        <20181017134159.9656-4-m.szyprowski@samsung.com>
        <CAJKOXPcMPz0wsEU9Lt1e0dp7tEk9+t8kteW=hih7sNsp99Dkkw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018-10-17 16:29, Krzysztof Kozlowski wrote:
> On Wed, 17 Oct 2018 at 15:42, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Move interrupts allocation from exynos4_timer_resources() into separate
>> function together with the interrupt number parsing code from
>> mct_init_dt(), so the code for managing interrupts is kept together.
>> While touching exynos4_timer_resources() function, move of_iomap() to it.
>> No functional changes.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/clocksource/exynos_mct.c | 49 +++++++++++++++++++-------------
>>  1 file changed, 30 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
>> index 49413900b24c..02ad55db390b 100644
>> --- a/drivers/clocksource/exynos_mct.c
>> +++ b/drivers/clocksource/exynos_mct.c
>> @@ -502,11 +502,14 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
>>         return 0;
>>  }
>>
>> -static int __init exynos4_timer_resources(struct device_node *np, void __iomem *base)
>> +static int __init exynos4_timer_resources(struct device_node *np)
>>  {
>> -       int err, cpu;
>>         struct clk *mct_clk, *tick_clk;
>>
>> +       reg_base = of_iomap(np, 0);
>> +       if (!reg_base)
>> +               panic("%s: unable to ioremap mct address space\n", __func__);
>> +
>>         tick_clk = of_clk_get_by_name(np, "fin_pll");
>>         if (IS_ERR(tick_clk))
>>                 panic("%s: unable to determine tick clock rate\n", __func__);
>> @@ -517,9 +520,27 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>>                 panic("%s: unable to retrieve mct clock instance\n", __func__);
>>         clk_prepare_enable(mct_clk);
>>
>> -       reg_base = base;
>> -       if (!reg_base)
>> -               panic("%s: unable to ioremap mct address space\n", __func__);
>> +       return 0;
>> +}
>> +
>> +static int __init exynos4_timer_interrupts(struct device_node *np,
>> +                                          unsigned int int_type)
>> +{
>> +       int i, err, cpu;
>> +
>> +       mct_int_type = int_type;
> This does not look good. Before, assignment was done before call to
> exynos4_timer_resources(). Now, if I follow the path correctly, it
> will be after. Therefore the exynos4_timer_resources() will use wrong
> value. This should pop up during tests.

After refactoring exynos4_timer_resource() doesn't use int_type, but you
are right, there is one item missing: nr_irqs as local variable, what
causes the driver to mess with the global one, what is fatal to the
system. I will send a fixed version in a few minutes.

> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

