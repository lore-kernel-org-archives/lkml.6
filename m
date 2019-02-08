Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF1CC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA3421924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Eb7ls8Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfBHKbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:31:33 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44900 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBHKbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:31:33 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190208103131euoutp02550257853fb87ba70d699c54cad4a04b~BXOZjcUu33264532645euoutp02B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 10:31:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190208103131euoutp02550257853fb87ba70d699c54cad4a04b~BXOZjcUu33264532645euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549621891;
        bh=b5dtEXpUuO482dXGRtsPGjqikcOpi8AUfz1v7iJ03II=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Eb7ls8UcExOGVqfHiv6IQPON6HNzsHCnWEQUJeTXFCKL2PY9PCuvfMd6B5YvPFH85
         gTB/A/tSYzqSD75ABH61swdurWVheeLJFBXsXkhV6PxaoZf2TynSEFyfHufK/GtMsW
         R/fFggH92XyIEICYl+oDlSkyqfMhzmjAo/eMb04g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190208103130eucas1p22b38d281c664e0704fd80c473d72e082~BXOYwfGy60307803078eucas1p2C;
        Fri,  8 Feb 2019 10:31:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 5E.5E.04441.28A5D5C5; Fri,  8
        Feb 2019 10:31:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190208103129eucas1p2749484db501f58287147ef95b9b72c45~BXOX6Hqqg3184231842eucas1p2B;
        Fri,  8 Feb 2019 10:31:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190208103129eusmtrp132ab81c31f506e13f419992f154945e7~BXOX46P3B1064210642eusmtrp1x;
        Fri,  8 Feb 2019 10:31:29 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-11-5c5d5a821500
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 05.C7.04284.18A5D5C5; Fri,  8
        Feb 2019 10:31:29 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190208103128eusmtip1b82f8d443cd942fe4548c1cf07709087~BXOXQX5l-3170931709eusmtip1h;
        Fri,  8 Feb 2019 10:31:28 +0000 (GMT)
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <bf3e2c35-fbc9-791a-eb10-206d5cfc400d@samsung.com>
Date:   Fri, 8 Feb 2019 11:31:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iU1+YdAqHai+r_ubC1FarC2JWBuc98MG58n+y9=1WB=A@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djPc7pNUbExBvPv81hsnLGe1eLm1w5W
        i8u75rBZfO49wmgx4/w+Jos3P84yWcz9MpXZ4szpS6wW/65tZLHY+NXDYuWJWcwO3B6bVnWy
        edy5tofNY8vVdhaPvi2rGD1OnnrC4nH8xnYmj8+b5ALYo7hsUlJzMstSi/TtErgy+q8XF8zV
        rTjcdp+pgbFDrYuRk0NCwESi6fhMpi5GLg4hgRWMEn0vvrJCOF8YJX5tOgHlfGaUWLxiBxtM
        y+Lb3YwQieWMEl82TmeHcN4zStzr38UEUiUs4CrxrPkMO4gtIhAqsaxxA1gRs0ATs0RPwwpm
        kASbgKFE19susLG8AnYSM3ecAbNZBFQkXq2YAtYsKhAjMeXcEXaIGkGJkzOfsIDYnAKBEs03
        OsDmMAvIS2x/OwfKFpe49WQ+2EcSArfYJfpf/GOGuNtFov/YRHYIW1ji1fEtULaMxOnJPSwQ
        Dc2MEu0zZrFDOD2MElvnwHxtLXH4+EVgcHAArdCUWL9LHyLsKHHq8Eo2kLCEAJ/EjbeCEEfw
        SUzaNp0ZIswr0dEmBFGtJjHr+Dq4tQcvXGKewKg0C8lrs5C8MwvJO7MQ9i5gZFnFKJ5aWpyb
        nlpsmJdarlecmFtcmpeul5yfu4kRmMBO/zv+aQfj10tJhxgFOBiVeHgvaMfECLEmlhVX5h5i
        lOBgVhLh1Y+MjRHiTUmsrEotyo8vKs1JLT7EKM3BoiTOW83wIFpIID2xJDU7NbUgtQgmy8TB
        KdXAqDnjXPjpXK7aoLJtG7lOtv8znbHgcNmGeQ23DscEaKxlFJeZPyM+6qC7O8eNPCPP54/8
        3jKmsWc9es5jqSfiMW/v6UNJ79denXYk2+jU/FMiB0/8Wp682XWp5xoe0w1f1upeNve5I2us
        nVF6h902e/W+x+VpvhVTrgb+l1TIX3lS9av25ZrEZ0osxRmJhlrMRcWJAH0AGBRcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7qNUbExBo3/ZC02zljPanHzawer
        xeVdc9gsPvceYbSYcX4fk8WbH2eZLOZ+mcpsceb0JVaLf9c2slhs/OphsfLELGYHbo9NqzrZ
        PO5c28PmseVqO4tH35ZVjB4nTz1h8Th+YzuTx+dNcgHsUXo2RfmlJakKGfnFJbZK0YYWRnqG
        lhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ/deLC+bqVhxuu8/UwNih1sXIySEhYCKx
        +HY3YxcjF4eQwFJGic9rW9ggEjISJ6c1sELYwhJ/rnWxQRS9ZZTof3kLrEhYwFXiWfMZdhBb
        RCBUYvL2PhaQImaBFmaJk8cmMkF0tDNJHH7VBdbBJmAo0fUWwuYVsJOYueMMmM0ioCLxasUU
        oEkcHKICMRJXzzFClAhKnJz5hAXE5hQIlGi+0cEMYjMLqEv8mXcJypaX2P52DpQtLnHryXym
        CYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIExuu2Yz8372C8
        tDH4EKMAB6MSD6+GXkyMEGtiWXFl7iFGCQ5mJRFe/cjYGCHelMTKqtSi/Pii0pzU4kOMpkC/
        TWSWEk3OB6aSvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFINjLOW
        dSpoyq39LD3l6ffpRd5py5Y3c5bYnI5qqT90fVaCWvb5d4FzjhwWYG3dvvb4qQWLddYvKHlt
        vfevbRvjq5CZm9N5haP0V8u4sTck8E21NprC0LTy/5KYL+I5MSU8D79enHCq8de7GN1Zcx5M
        kKs7N29268QTvo9fzc/4tlXRPdvHK2NK2BUlluKMREMt5qLiRAC/OMOa7QIAAA==
X-CMS-MailID: 20190208103129eucas1p2749484db501f58287147ef95b9b72c45
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
        <20190207122227.19873-1-m.szyprowski@samsung.com>
        <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
        <CAJZ5v0iU1+YdAqHai+r_ubC1FarC2JWBuc98MG58n+y9=1WB=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 2019-02-08 11:22, Rafael J. Wysocki wrote:
> On Fri, Feb 8, 2019 at 7:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 07-02-19, 13:22, Marek Szyprowski wrote:
>>> Dear All,
>>>
>>> Recent commit 9ac6cb5fbb17 ("i2c: add suspended flag and accessors for
>>> i2c adapters") added a visible warning for an attempt to do i2c transfer
>>> over a suspended i2c bus. This revealed a long standing issue in the
>>> cpufreq-dt driver, which gives a following warning during system
>>> suspend/resume cycle:
>>>
>>> --->8---
>>> Enabling non-boot CPUs ...
>>> CPU1 is up
>>> CPU2 is up
>>> CPU3 is up
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 4 PID: 29 at drivers/i2c/i2c-core-base.c:1869 __i2c_transfer+0x6f8/0xa50
>>> Modules linked in:
>>> CPU: 4 PID: 29 Comm: cpuhp/4 Tainted: G        W         5.0.0-rc4-next-20190131-00024-g54b06b29cc65 #5324
>>> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>>> [<c01110e8>] (unwind_backtrace) from [<c010d11c>] (show_stack+0x10/0x14)
>>> [<c010d11c>] (show_stack) from [<c09a2584>] (dump_stack+0x90/0xc8)
>>> [<c09a2584>] (dump_stack) from [<c0120bd0>] (__warn+0xf8/0x124)
>>> [<c0120bd0>] (__warn) from [<c0120c3c>] (warn_slowpath_null+0x40/0x48)
>>> [<c0120c3c>] (warn_slowpath_null) from [<c065cda0>] (__i2c_transfer+0x6f8/0xa50)
>>> [<c065cda0>] (__i2c_transfer) from [<c065d168>] (i2c_transfer+0x70/0xe4)
>>> [<c065d168>] (i2c_transfer) from [<c053ce4c>] (regmap_i2c_read+0x48/0x64)
>>> [<c053ce4c>] (regmap_i2c_read) from [<c0536f1c>] (_regmap_raw_read+0xf8/0x450)
>>> [<c0536f1c>] (_regmap_raw_read) from [<c053772c>] (_regmap_bus_read+0x38/0x68)
>>> [<c053772c>] (_regmap_bus_read) from [<c05365a0>] (_regmap_read+0x60/0x250)
>>> [<c05365a0>] (_regmap_read) from [<c05367cc>] (regmap_read+0x3c/0x5c)
>>> [<c05367cc>] (regmap_read) from [<c047cfc0>] (regulator_is_enabled_regmap+0x20/0x90)
>>> [<c047cfc0>] (regulator_is_enabled_regmap) from [<c0477660>] (_regulator_is_enabled+0x34/0x40)
>>> [<c0477660>] (_regulator_is_enabled) from [<c0478674>] (create_regulator+0x1a4/0x25c)
>>> [<c0478674>] (create_regulator) from [<c047c818>] (_regulator_get+0xe4/0x278)
>>> [<c047c818>] (_regulator_get) from [<c068f1dc>] (dev_pm_opp_set_regulators+0xa0/0x1c0)
>>> [<c068f1dc>] (dev_pm_opp_set_regulators) from [<c0698cc8>] (cpufreq_init+0x98/0x2d0)
>>> [<c0698cc8>] (cpufreq_init) from [<c06959e4>] (cpufreq_online+0xc8/0x71c)
>>> [<c06959e4>] (cpufreq_online) from [<c06960fc>] (cpuhp_cpufreq_online+0x8/0x10)
>>> [<c06960fc>] (cpuhp_cpufreq_online) from [<c01213d4>] (cpuhp_invoke_callback+0xf4/0xebc)
>>> [<c01213d4>] (cpuhp_invoke_callback) from [<c0122e4c>] (cpuhp_thread_fun+0x1d8/0x320)
>>> [<c0122e4c>] (cpuhp_thread_fun) from [<c0149858>] (smpboot_thread_fn+0x194/0x340)
>>> [<c0149858>] (smpboot_thread_fn) from [<c014573c>] (kthread+0x124/0x160)
>>> [<c014573c>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
>>> Exception stack(0xe897dfb0 to 0xe897dff8)
>>> dfa0:                                     00000000 00000000 00000000 00000000
>>> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>>> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>>> irq event stamp: 3865
>>> hardirqs last  enabled at (3873): [<c0186dec>] vprintk_emit+0x228/0x2a4
>>> hardirqs last disabled at (3880): [<c0186cf0>] vprintk_emit+0x12c/0x2a4
>>> softirqs last  enabled at (3052): [<c0102564>] __do_softirq+0x3a4/0x66c
>>> softirqs last disabled at (3043): [<c0128464>] irq_exit+0x140/0x168
>>> ---[ end trace db48b455d924fec2 ]---
>>> CPU4 is up
>>> CPU5 is up
>>> CPU6 is up
>>> CPU7 is up
>>> --->8---
>>>
>>> This is a scenario that triggers the above issue:
>>>
>>> 1. system disables non-boot cpu's at the end of system suspend procedure,
>>> 2. this in turn deinitializes cpufreq drivers for the disabled cpus,
>>> 3. early in the system resume procedure all cpus are got back to online
>>>    state,
>>> 4. this in turn causes cpufreq to be initialized for the newly onlined
>>>    cpus,
>>> 5. cpufreq-dt acquires all its resources (clocks, regulators) during
>>>    ->init() callback,
>>> 6. getting regulator require to check its state, what in turn requires
>>>    i2c transfer,
>>> 7. during system early resume stage this is not really possible.
>>>
>>> The issue is caused by cpufreq-dt driver not keeping its resources for
>>> the whole driver lifetime and relying that they can be always acquired
>>> at any system context. This problem has been observed on Samsung
>>> Exynos based Odroid XU3/XU4 boards, but it happens on all boards, which
>>> have separate regulators for different CPU clusters.
>> Why don't you get similar problem during suspend? I think you can get
>> it when the CPUs are offlined as I2C would have gone by then. The
>> cpufreq or OPP core can try and run some regulator or genpd or clk
>> calls to disable resources, etc. Even if doesn't happen, it certainly
>> can.
>>
>> Also at resume the cpufreq core may try to change the frequency right
>> from ->init() on certain cases, though not everytime and so the
>> problem can come despite of this series.
>>
>> We guarantee that the resources are available during probe but not
>> during resume, that's where the problem is.
>>
>> @Rafael any suggestions on how to fix this ?
> There are cpufreq driver suspend and resume callbacks, maybe use them?
>
> The driver could do the I2C transactions in its suspend/resume
> callbacks and do nothing in online/offline if those are part of
> system-wide suspend/resume.

This is exactly what I suggested, when I wrote to handle it in cpufreq
suspend/resume.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

