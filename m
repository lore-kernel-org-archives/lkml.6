Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8120EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4920620823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oSy9Boj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfBHLrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:47:11 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34942 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBHLrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:47:11 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190208114709euoutp019a111bc14e90b5a119751b077fd873a6~BYQb7qq4M1119211192euoutp01g
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 11:47:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190208114709euoutp019a111bc14e90b5a119751b077fd873a6~BYQb7qq4M1119211192euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549626429;
        bh=sAuF0odAIqE6VKNVvF2FfJIe2CuHBI72K94cY4v64JQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oSy9Boj7+4rrzf3/ESEHOK2u3fqRsd4Ppv2f6Z8G+cZeGk5iKl1+QobbJNi2jtj+1
         btqiv/6bpAxLEs2bEV2xNR146Hq+Ud4SIuqhUYaugane2gKfHV2JSO8kUb0k1QFhqi
         kHwgG9ZOPJ2ZCCfW110YEUISF7oauzbKvDXYhOFQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190208114708eucas1p20046060ae27cbe216ee528ce8bc1bf89~BYQbOlOLa1240412404eucas1p2v;
        Fri,  8 Feb 2019 11:47:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1E.53.04806.C3C6D5C5; Fri,  8
        Feb 2019 11:47:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190208114707eucas1p1b9ab9c6763681ed07a9c6e9c6d4d6d88~BYQaM1OI-0757707577eucas1p1Z;
        Fri,  8 Feb 2019 11:47:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190208114707eusmtrp151faeac645ffd55ba96fe3a82a6037f7~BYQZ_Bo9T0163001630eusmtrp1p;
        Fri,  8 Feb 2019 11:47:07 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-0a-5c5d6c3c8311
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C6.11.04284.B3C6D5C5; Fri,  8
        Feb 2019 11:47:07 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190208114706eusmtip2c33fd9bdaf21457f2935ace5fdcb0991~BYQZcv4Eo1884318843eusmtip2L;
        Fri,  8 Feb 2019 11:47:06 +0000 (GMT)
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <87302853-74cc-8eeb-6bd4-6338746e0738@samsung.com>
Date:   Fri, 8 Feb 2019 12:47:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208110053.GA7913@e107155-lin>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk7nq1mn1PxxW6yQunirSxOZWJRcPoTVj8Km+jKg4rz0qam
        RqApeWGGmJoOzYJiOkVRdIqllFpT5y0tsTLQEIPlGmSalVhuR8t/7/u8z8PzPB8fTUgHhe50
        THwSp4pXKGWUmDS8+jnsHagMk/t9qXZhGssahMy7hVwhM9ZeQTHzBT2IKRvuFDBzS4MCZsA0
        KmRWxhtJRtffRjKNCyxT06slgjezdQ/qENukz6PYyfFnFNv8Nodk7zbrEdvXP0OyxolWATvf
        tDOEDhUHRnLKmBRO5RsUIY6uHFokEztFqV1T36gMNOyQj0Q04ABoMX0k8pGYluJqBBPWUopf
        viPQLHwQ8Ms8giqNiVyXtOfNrkl0CMbm3whtBym2Isgu9bDNzvgMzGYN2D1csBc8HmxGNgGB
        rQL48aTDLqCwP+Rb8inbLMFB8Ev32y4g8R6w1JfaOa5YDsVDPQ48xwn6ymdWU9C0CPtBVnes
        DSbwLmi1VBD87AbvZ6rsqQF/coBaXbaQT30aCkpq1xo4g9nYvPYA28F0T0PygiwEOWVaB37R
        IGipaKN41nHoNr4W2pwJvBca2n15+CT0d9dQNhiwI0xYnPgQjlBkuE/wsARy70h5tidojfX/
        bF+MjBKFSKbd0Ey7oY52Qx3tf9+HiNQjNy5ZHRfFqQ/Fczd81Io4dXJ8lM+1hLgmtPrJTCvG
        hTbUuXy1C2EaybZIRvbL5VKhIkWdFteFgCZkLpLyqDC5VBKpSEvnVAnhqmQlp+5C22hS5ia5
        uWnqihRHKZK4WI5L5FTrVwEtcs9AqmBnZehSYmWx5hbu/ZN53cPx/OeM6ull8wlFhOusD6Xv
        8G4tX9R/neyN0Rn6zTsqnmfqZq0v5dXTPV67l0vMzNNUkaWOYtInKguPHQwpNxz1azGV6AqP
        GJWXisSHa0nncxd7AgQtt42ngi9PhYeS8gPjWz3PGi40Fj+aa3MtkZHqaIX/PkKlVvwFThVH
        Q2ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7rWObExBnNP8ltsnLGe1eLm1w5W
        i8u75rBZfO49wmgx4/w+Jos3P84yWZw5fYnV4t+1jSwWy0/tYLHY+NXDYuWJWcwO3B5r5q1h
        9Ni0qpPN4861PWweW662s3j0bVnF6HHy1BMWj+M3tjN5fN4kF8ARpWdTlF9akqqQkV9cYqsU
        bWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJcx99w3loJ9nBWHHnxia2A8z97F
        yMkhIWAisavzGXMXIxeHkMBSRokdzRPYIBIyEienNbBC2MISf651sUEUvWWUmH/oJ1iRsICr
        xLPmM2CTRATUJZac3cIIUsQs8J5JYuumA0wgCSGB7YwSk44bgNhsAoYSXW+7wJp5Bewkfi3/
        DdbMIqAi8XbdNKBtHByiAjESV88xQpQISpyc+YQFJMwpYCDRfDgbJMwMtOrPvEvMELa8xPa3
        c6BscYlbT+YzTWAUmoWkexaSlllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMj
        MG63Hfu5eQfjpY3BhxgFOBiVeHg19GJihFgTy4orcw8xSnAwK4nwzkyPjRHiTUmsrEotyo8v
        Ks1JLT7EaAr02kRmKdHkfGBKySuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE
        08fEwSnVwNhmcUczu/DOyxcdd+21JZsaDfhkCk1mzpomzPq2fmvBhkvWKxtX6L1unnI6XlDY
        9Gilpe5h2ZPsc21L5Nwlt4bsr+C6vEeI36lZ03Kt0DTDreZ3Cm20M9Wm1i48+UkzZFuq37Pc
        Wmv9rdmszSbvFtf1SwXp5yaXvK5at8Xtb0nIqT0V6U3iSizFGYmGWsxFxYkAHQFSnvECAAA=
X-CMS-MailID: 20190208114707eucas1p1b9ab9c6763681ed07a9c6e9c6d4d6d88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
        <20190207122227.19873-1-m.szyprowski@samsung.com>
        <20190208110053.GA7913@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 2019-02-08 12:00, Sudeep Holla wrote:
> On Thu, Feb 07, 2019 at 01:22:25PM +0100, Marek Szyprowski wrote:
>> Dear All,
>>
>> This is a scenario that triggers the above issue:
> [...]
>> 1. system disables non-boot cpu's at the end of system suspend procedure,
>> 2. this in turn deinitializes cpufreq drivers for the disabled cpus,
>> 3. early in the system resume procedure all cpus are got back to online
>>    state,
>> 4. this in turn causes cpufreq to be initialized for the newly onlined
>>    cpus,
>> 5. cpufreq-dt acquires all its resources (clocks, regulators) during
>>    ->init() callback,
> This is strictly not just restricted to cpufreq-dt, but to any driver
> supporting multiple policies. So we need a generic fix not just
> cpufreq-dt specific.

Could you point which other driver needs similar fix? Here in cpufreq-dt
the problem was caused by using regulator api (indirectly) from
->init(). All other drivers, which have regulators support, are for old,
obsolete, uni-processor systems, which don't have the problem of
secondary cpu suspend during system suspend/resume cycle.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

