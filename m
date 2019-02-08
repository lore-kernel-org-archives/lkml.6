Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE3AC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C4C21916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 08:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mmzqjzhA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfBHIMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 03:12:54 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48086 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfBHIMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 03:12:53 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190208081251euoutp01b7a9dc53567c3575866bcc8d0eb58816~BVVU8B39V2610926109euoutp01j
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 08:12:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190208081251euoutp01b7a9dc53567c3575866bcc8d0eb58816~BVVU8B39V2610926109euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549613571;
        bh=HbT02cYVEeDeRG/H019OSs/fJbaOjdD+nrtCDD9d35c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mmzqjzhAWUf/a1we6X9fH4Imzim8JpX4teOZndbMYMevuvTykEcjzKqlaQ55gV40Z
         DcWDChHFT9dOuFo6tMkQoxbEqSOnfxRmbvmwczLDG7UJ4E4dCLGPeUg0WrxHwVJWIT
         IhF1qW60TBFKp6adrXSfXFtpdBCtDadJCd0c6jxs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190208081250eucas1p2f3b71c3df049a1307c905ac2e7206192~BVVUfRllW2320323203eucas1p2T;
        Fri,  8 Feb 2019 08:12:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.06.04806.20A3D5C5; Fri,  8
        Feb 2019 08:12:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190208081249eucas1p16730dd936643c8880d1cf35efdb68ec5~BVVTqhtFc0203902039eucas1p1l;
        Fri,  8 Feb 2019 08:12:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190208081249eusmtrp193b4ebdca5e18ef1979817a81edf58a6~BVVTbxmUM3196731967eusmtrp1g;
        Fri,  8 Feb 2019 08:12:49 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-ac-5c5d3a028abb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3C.DB.04128.10A3D5C5; Fri,  8
        Feb 2019 08:12:49 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190208081249eusmtip181c21b0992b26e357c02bab3eadb5c11~BVVS03eUA2308723087eusmtip1r;
        Fri,  8 Feb 2019 08:12:49 +0000 (GMT)
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
Message-ID: <dc3802db-2931-e4fa-72f4-fa6e9b5c0e9a@samsung.com>
Date:   Fri, 8 Feb 2019 09:12:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj2O5ftuFocp+mnhtEKw3tixLFCisoGEkghdJnU0tM03bQdL2kE
        QyttqIWLWmtdIHAppji8YbLqaJ2c5rXElZjlKFJHoA7KRHI7Vv57nvd93vd5n4+PQCVdeBCR
        qc6jNWpFtlQgwlpf/xqIQnanynfYFrZSTYZGnLK7ynFqpMMkoOYruwFlGLAi1OzPtwjV1zuM
        U8ujTRjV5JJRtW+M6D6RzFJ3XSAbH+0UyJrfl2GyquY6IOuxOTAZN9aGyOYtIcnCk6K96XR2
        ZgGtiUk4I8oYMo8gueNRFxt+9wEtqA/VAYKA5E5o/xyiAyJCQj4B8PniJM6TBQArJ1oEPJkH
        cO5x9Qrx9kxonU8RvmEGcOSTFePJDwBbZr6hbpUveQh+Le0Tuj38yHD43U67NSj5CoF2dsmz
        SUDGQp1T58FiMgHarDW4G2PkNniFM3v2bCTl8FZ/t5DX+MCeuw7Mjb3JePhxoNMzi5KbYZvT
        hPI4AH5wPPRcB8lRIdRPmYX82QdhQ0kdwmNfOM01r9Y3wV59BcYPlAJYZjAKeVKxEsfUvhp6
        D+zihnB3HJQMg40dMXx5P7R11Qr4l9wAx5w+/BEbYHXrHZQvi2H5NQmvDoVGruGf7cvBYfQm
        kBrXRDOuiWNcE8f43/cRwOpAAJ3PqJQ0E6emC6MZhYrJVyuj03JUFrDytXqXOVc7sC6dZQFJ
        AOl68WCEXC7BFQVMkYoFkEClfuKo+FS5RJyuKCqmNTmnNfnZNMOCYAKTBogveU2ekpBKRR6d
        RdO5tOZvFyG8g7TAPG3UtyjjEopStPILSe806swDEff8InGq3+lKbLyam28q9H8x0no0MFia
        NPsspYolJKLjJdnUES9BcWNaUEu0bSbxso/igYF16hxfHMdUN+qn56Rbks9nhPlv72Unajh9
        p/X2iamuwNl1zLms+4c5yrQQ2cAKScuuqqn4RSnGZChiw1ENo/gDW53edVYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xu7qMVrExBpcuqllsnLGe1eLm1w5W
        i8u75rBZfO49wmgx4/w+Jos3P84yWZw5fYnV4t+1jSwWG796WKw8MYvZgctj06pONo871/aw
        eWy52s7i0bdlFaPHyVNPWDyO39jO5PF5k1wAe5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
        pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexsXll5kK7uhWrPt9hrGBcY1aFyMnh4SAiUTD27VM
        XYxcHEICSxklbr9ZxwqRkJE4Oa0ByhaW+HOtiw2i6C2jxK3f71hAEsICrhLPms+wdzFycIgI
        aEm8vJkKUsMscJRJ4t2F98wQDQcYJT592ckE0sAmYCjR9RZkEicHr4CdxKl9y8A2sAioSLQc
        X84MMkhUIEbi6jlGiBJBiZMzn4Dt4hSwlLh9fg9YK7OAusSfeZeYIWx5ie1v50DZ4hK3nsxn
        msAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYJRuO/Zzyw7G
        rnfBhxgFOBiVeHgvaMfECLEmlhVX5h5ilOBgVhLhldaPjRHiTUmsrEotyo8vKs1JLT7EaAr0
        20RmKdHkfGACySuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwMjG
        P6ds+ZyokxYe69KObWxfsKayccvKX0IKtxxS7hvyhH75bq19srTngbyRoHbnpVbx7vBUVp3c
        mzJmy06nmLEE9l52Krh2ZBGHzrHP7WanpPkMcv/INEX8mfLyxqWKnwk1O0qWpgto69ev7ni+
        ZXe8m0sld876bdOMd3mxlc5u/CA3r6LsvxJLcUaioRZzUXEiAAPk5w7oAgAA
X-CMS-MailID: 20190208081249eucas1p16730dd936643c8880d1cf35efdb68ec5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190207122255eucas1p1cdebed838c799eca46cce6a654a26187
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
        <20190207122227.19873-1-m.szyprowski@samsung.com>
        <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2019-02-08 07:49, Viresh Kumar wrote:
> On 07-02-19, 13:22, Marek Szyprowski wrote:
>> Recent commit 9ac6cb5fbb17 ("i2c: add suspended flag and accessors for
>> i2c adapters") added a visible warning for an attempt to do i2c transfer
>> over a suspended i2c bus. This revealed a long standing issue in the
>> cpufreq-dt driver, which gives a following warning during system
>> suspend/resume cycle:
>>
>> --->8---
>> Enabling non-boot CPUs ...
>> CPU1 is up
>> CPU2 is up
>> CPU3 is up
>> ------------[ cut here ]------------
>> WARNING: CPU: 4 PID: 29 at drivers/i2c/i2c-core-base.c:1869 __i2c_transfer+0x6f8/0xa50
>> Modules linked in:
>> CPU: 4 PID: 29 Comm: cpuhp/4 Tainted: G        W         5.0.0-rc4-next-20190131-00024-g54b06b29cc65 #5324
>> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>> [<c01110e8>] (unwind_backtrace) from [<c010d11c>] (show_stack+0x10/0x14)
>> [<c010d11c>] (show_stack) from [<c09a2584>] (dump_stack+0x90/0xc8)
>> [<c09a2584>] (dump_stack) from [<c0120bd0>] (__warn+0xf8/0x124)
>> [<c0120bd0>] (__warn) from [<c0120c3c>] (warn_slowpath_null+0x40/0x48)
>> [<c0120c3c>] (warn_slowpath_null) from [<c065cda0>] (__i2c_transfer+0x6f8/0xa50)
>> [<c065cda0>] (__i2c_transfer) from [<c065d168>] (i2c_transfer+0x70/0xe4)
>> [<c065d168>] (i2c_transfer) from [<c053ce4c>] (regmap_i2c_read+0x48/0x64)
>> [<c053ce4c>] (regmap_i2c_read) from [<c0536f1c>] (_regmap_raw_read+0xf8/0x450)
>> [<c0536f1c>] (_regmap_raw_read) from [<c053772c>] (_regmap_bus_read+0x38/0x68)
>> [<c053772c>] (_regmap_bus_read) from [<c05365a0>] (_regmap_read+0x60/0x250)
>> [<c05365a0>] (_regmap_read) from [<c05367cc>] (regmap_read+0x3c/0x5c)
>> [<c05367cc>] (regmap_read) from [<c047cfc0>] (regulator_is_enabled_regmap+0x20/0x90)
>> [<c047cfc0>] (regulator_is_enabled_regmap) from [<c0477660>] (_regulator_is_enabled+0x34/0x40)
>> [<c0477660>] (_regulator_is_enabled) from [<c0478674>] (create_regulator+0x1a4/0x25c)
>> [<c0478674>] (create_regulator) from [<c047c818>] (_regulator_get+0xe4/0x278)
>> [<c047c818>] (_regulator_get) from [<c068f1dc>] (dev_pm_opp_set_regulators+0xa0/0x1c0)
>> [<c068f1dc>] (dev_pm_opp_set_regulators) from [<c0698cc8>] (cpufreq_init+0x98/0x2d0)
>> [<c0698cc8>] (cpufreq_init) from [<c06959e4>] (cpufreq_online+0xc8/0x71c)
>> [<c06959e4>] (cpufreq_online) from [<c06960fc>] (cpuhp_cpufreq_online+0x8/0x10)
>> [<c06960fc>] (cpuhp_cpufreq_online) from [<c01213d4>] (cpuhp_invoke_callback+0xf4/0xebc)
>> [<c01213d4>] (cpuhp_invoke_callback) from [<c0122e4c>] (cpuhp_thread_fun+0x1d8/0x320)
>> [<c0122e4c>] (cpuhp_thread_fun) from [<c0149858>] (smpboot_thread_fn+0x194/0x340)
>> [<c0149858>] (smpboot_thread_fn) from [<c014573c>] (kthread+0x124/0x160)
>> [<c014573c>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
>> Exception stack(0xe897dfb0 to 0xe897dff8)
>> dfa0:                                     00000000 00000000 00000000 00000000
>> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
>> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>> irq event stamp: 3865
>> hardirqs last  enabled at (3873): [<c0186dec>] vprintk_emit+0x228/0x2a4
>> hardirqs last disabled at (3880): [<c0186cf0>] vprintk_emit+0x12c/0x2a4
>> softirqs last  enabled at (3052): [<c0102564>] __do_softirq+0x3a4/0x66c
>> softirqs last disabled at (3043): [<c0128464>] irq_exit+0x140/0x168
>> ---[ end trace db48b455d924fec2 ]---
>> CPU4 is up
>> CPU5 is up
>> CPU6 is up
>> CPU7 is up
>> --->8---
>>
>> This is a scenario that triggers the above issue:
>>
>> 1. system disables non-boot cpu's at the end of system suspend procedure,
>> 2. this in turn deinitializes cpufreq drivers for the disabled cpus,
>> 3. early in the system resume procedure all cpus are got back to online
>>    state,
>> 4. this in turn causes cpufreq to be initialized for the newly onlined
>>    cpus,
>> 5. cpufreq-dt acquires all its resources (clocks, regulators) during
>>    ->init() callback,
>> 6. getting regulator require to check its state, what in turn requires
>>    i2c transfer,
>> 7. during system early resume stage this is not really possible.
>>
>> The issue is caused by cpufreq-dt driver not keeping its resources for
>> the whole driver lifetime and relying that they can be always acquired
>> at any system context. This problem has been observed on Samsung
>> Exynos based Odroid XU3/XU4 boards, but it happens on all boards, which
>> have separate regulators for different CPU clusters.
> Why don't you get similar problem during suspend? I think you can get
> it when the CPUs are offlined as I2C would have gone by then. The
> cpufreq or OPP core can try and run some regulator or genpd or clk
> calls to disable resources, etc. Even if doesn't happen, it certainly
> can.

CPUfreq is suspended very early during system suspend and thus it does
nothing when CPUs are being offlined.

> Also at resume the cpufreq core may try to change the frequency right
> from ->init() on certain cases, though not everytime and so the
> problem can come despite of this series.

cpufreq is still in suspended state (it is being 'resume' very late in
the system resume procedure), so if driver doesn't explicitly change any
opp in ->init(), then cpufreq core waits until everything is resumed. To
sum up, this seems to be fine, beside the issue with regulator
initialization I've addressed in this patchset.

> We guarantee that the resources are available during probe but not
> during resume, that's where the problem is.

Yes, so I've changed cpufreq-dt to the common approach, in which the
driver keeps all needed resources for the whole lifetime of the device.

> @Rafael any suggestions on how to fix this ?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

