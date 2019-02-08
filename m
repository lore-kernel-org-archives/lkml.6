Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956C3C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDDD21917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bimrIQgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfBHJP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:15:56 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46231 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfBHJPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:15:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190208091554euoutp022556a2147d36abe65ed247c4abb011a1~BWMX0VGii2250822508euoutp02e
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 09:15:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190208091554euoutp022556a2147d36abe65ed247c4abb011a1~BWMX0VGii2250822508euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549617354;
        bh=17hSZWpv8eWO3nfyIkWXcWOmIk4kyS3C/mCpAFiiNFU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bimrIQgX6bJCjHSrzQsajL7JtgYf5lF7ub7rPgf5hWgXPJhoSo/j6nF8J8nusN+xo
         eEb2wi22yurmoIa20K0d97nKncGip9Ryo0MAkw0iceL89Qz8QSzrJcfxCoFjPBUF41
         KGeeddQxwMTKG1mOwe9N2ypK9A3Lw7KGTlRzKjxg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190208091553eucas1p2e3dbd575d217c2534fdc604facd02f72~BWMW988jy3256532565eucas1p2F;
        Fri,  8 Feb 2019 09:15:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 48.53.04441.8C84D5C5; Fri,  8
        Feb 2019 09:15:52 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190208091552eucas1p208d3d960f31800d2dd9e9942e9b50207~BWMWHG9QQ0953609536eucas1p2H;
        Fri,  8 Feb 2019 09:15:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190208091551eusmtrp2e7e750cadfe0feb1360a5b6dae25cd8e~BWMV4f0yd0471504715eusmtrp22;
        Fri,  8 Feb 2019 09:15:51 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-a6-5c5d48c8c233
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E5.7C.04284.7C84D5C5; Fri,  8
        Feb 2019 09:15:51 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190208091551eusmtip23be39f84381a0432a658ed31fb6ecb26~BWMVC8tHG2664126641eusmtip2c;
        Fri,  8 Feb 2019 09:15:51 +0000 (GMT)
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <bbab0116-c2e5-a3a6-30e4-cbd8c583a120@samsung.com>
Date:   Fri, 8 Feb 2019 10:15:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208085544.vqkebcgg7jpbv2a6@vireshk-i7>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUhUYRSG/eYuc50a/RwND614iUBDzRa4YVmi2e1HUWD9qJEa9aaWM8pM
        phaBNZULZiqWOlgmgub8SGYcVyJoXMatxSXRCmyxoHJQXMiwLK83y3/POd97znte+BhCZafW
        Mgm6C4Jep0lkaQXZ0PHjuX8nH6XeZv29g7OU1FLcyGwWxQ20lNHc9K02xJW8eCLjxueeybje
        nn6KWxiykJxlludqOk3EfgVvNWfT/NuhxzRve5VJ8nk2M+K7usdI3jHcKOOnrRuPyk8q9sQK
        iQkXBX1gyBlFfGNvszx5xjOtdaiCykAZOAe5MoB3wsc7ufIcpGBU+CGCyeEJSipmEBTaimip
        mEZQNTqIlkd+Tf6UiazC1QgWRg9LPIGgf3yJPfEB+GzsXVzLMF7YD76MCOIeArfLYMT+kxY1
        NA6CHGfOEitxCBgHX1Mik3gzFHd9X9q/Bquh6HmbXNJ4QFfpGCmyK94NA+3XCJEJvAkanWV/
        2Rtej5XLRDPAQ3JwTHUQ0tHhMP5lSiaxJ3x12OQSr4ffzcsDRgSZJSa5VOQiqC9roiVVMLQ6
        +igxDoF9obYlUGqHQndrDS22AbvBsNNDOsINChuKCamthKybKkm9BUyOR/9sn77sJ/IRa1oR
        zbQijmlFHNN/3weINCNvIcWgjRMMQTohNcCg0RpSdHEBMUlaK1r8WT0LjqkmNNsfbUeYQexq
        5cutarWK0lw0pGvtCBiC9VLGRESpVcpYTfolQZ90Wp+SKBjsaB1Dst7Kyy7vTqlwnOaCcF4Q
        kgX98quMcV2bgSLT3COjx3qeuUeQA6nto0dGKos9xyu/3bD66+qq6gOd5uOfbft8tAUzV298
        ch5TXPHThvjMhp3oWrUhfPt8xbnrvkbji+A3TF1AmE1beij1rHmyPC/tnum9/xxyid3Fzn9n
        Q+fn47P3WvCrD323s9mBg9WTBflX3LPven+sabhfyJKGeE2QH6E3aP4A13sOE1UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7rHPWJjDE4tMLfYOGM9q8XNrx2s
        Fpd3zWGz+Nx7hNFixvl9TBZvfpxlsjhz+hKrxb9rG1ksNn71sFh5YhazA5fHplWdbB53ru1h
        89hytZ3Fo2/LKkaPk6eesHgcv7GdyePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jO1ndrIXfBGuOHxtIWsDY4NAFyMnh4SAicTfD3+Y
        uhi5OIQEljJK3H3wnhUiISNxcloDlC0s8edaFxtE0VtGiUmb5rOBJIQFXCWeNZ9h72Lk4BAR
        0JJ4eTMVpIZZ4CiTxLsL75khGpYwSfQ0HwJrYBMwlOh62wVm8wrYSTRfuQW2gUVARWL6ye9M
        IINEBWIkrp5jhCgRlDg58wkLiM0pYClx+WgTM4jNLKAu8WfeJShbXmL72zlQtrjErSfzmSYw
        Cs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERil24793LyD8dLG
        4EOMAhyMSjy8GnoxMUKsiWXFlbmHGCU4mJVEeJPdYmOEeFMSK6tSi/Lji0pzUosPMZoC/TaR
        WUo0OR+YQPJK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqemFqQWwfQxcXBKNTDaVb1a
        9+z2ye+PN5gF7VxrVtrb/rbu0gSz9iUF7pJTuScUri6ZvKX8062jz4MuvnyVWOtUvG/ZS8kz
        i8461Xpv5ObbbHBincqF486t048s+Pck6pfBFYcQq76l6k9eHN7N2fRjLotm2a3Kvb6PUqYV
        CE6WmFGe5bUudu4ij5cOczcs6lpZ/PjENyWW4oxEQy3mouJEAKziL5ToAgAA
X-CMS-MailID: 20190208091552eucas1p208d3d960f31800d2dd9e9942e9b50207
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
        <20190207122227.19873-1-m.szyprowski@samsung.com>
        <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
        <dc3802db-2931-e4fa-72f4-fa6e9b5c0e9a@samsung.com>
        <20190208085544.vqkebcgg7jpbv2a6@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2019-02-08 09:55, Viresh Kumar wrote:
> On 08-02-19, 09:12, Marek Szyprowski wrote:
>> On 2019-02-08 07:49, Viresh Kumar wrote:
>>> Why don't you get similar problem during suspend? I think you can get
>>> it when the CPUs are offlined as I2C would have gone by then. The
>>> cpufreq or OPP core can try and run some regulator or genpd or clk
>>> calls to disable resources, etc. Even if doesn't happen, it certainly
>>> can.
>> CPUfreq is suspended very early during system suspend and thus it does
>> nothing when CPUs are being offlined.
>>> Also at resume the cpufreq core may try to change the frequency right
>>> from ->init() on certain cases, though not everytime and so the
>>> problem can come despite of this series.
>> cpufreq is still in suspended state (it is being 'resume' very late in
>> the system resume procedure), so if driver doesn't explicitly change any
>> opp in ->init(), then cpufreq core waits until everything is resumed. To
>> sum up, this seems to be fine, beside the issue with regulator
>> initialization I've addressed in this patchset.
> Yeah, the governors are suspended very soon, but any frequency change
> starting from cpufreq core can still happen. There are at least two
> points in cpufreq_online() where we may end up changing the frequency,
> but that is conditional and may not be getting hit.

Then probably cpufreq core suspend should handle this.

>>> We guarantee that the resources are available during probe but not
>>> during resume, that's where the problem is.
>> Yes, so I've changed cpufreq-dt to the common approach, in which the
>> driver keeps all needed resources for the whole lifetime of the device.
> That's not what I was saying actually. I was saying that it should be
> fine to do a I2C transfer during resume, else we will always have
> problems and have to fix them with hacks like the one you proposed
> where you acquire resources for all the possible CPUs. Maybe we can
> fix it once and for all.

It is fine to do i2c transfers during cpufreq resume (see
drivers/base/power/main.c dpm_resume() function for exact call place).
The problem is that such calls are not allowed in ->init(), which might
be called very early from CPU hotplug path (CPUs are resumed in the
first step of system resume procedure).

What's wrong with my proposed fix? It is not that uncommon to gather all
resources in probe() and keep them until remove() happens.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

