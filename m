Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACE4C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769492077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iCGJIAu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769492077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJKPBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:01:17 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35111 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:01:17 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181011073512euoutp013db1ae071e0daab5d6671b66f953a4bd~cfaM1OrUW1906719067euoutp01L
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 07:35:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181011073512euoutp013db1ae071e0daab5d6671b66f953a4bd~cfaM1OrUW1906719067euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539243312;
        bh=EmnF4V6pqkHFqj3Bl0mYTuCFP0nWWQ1eR5ATsZz+WXA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iCGJIAu9iYjrT29//cQsn2f0lZlVuVksdiv1dc8bQ+a4vyXMvKNYd8HxbUiwVhMgb
         NgT8jFhykcZedFHesCvw1hue2ea/K8B2eOunQhDAWawHpZuiBki7ggUQnj0JMm8fpf
         RYNMEdyRJLfZnKaEr8Zk/hH/XtA+jXtH/AayzSWA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181011073511eucas1p2e9f48745a06fa916406b84e59d25367f~cfaL9H8at3080330803eucas1p2V;
        Thu, 11 Oct 2018 07:35:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 86.36.04806.F2DFEBB5; Thu, 11
        Oct 2018 08:35:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181011073510eucas1p100bfadd6055a523cd1e92b07bfacfc10~cfaLHcbIo1401014010eucas1p1d;
        Thu, 11 Oct 2018 07:35:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181011073510eusmtrp1434a1d0cf300cdc09580f784bbe90de3~cfaK18PkD1560215602eusmtrp1Q;
        Thu, 11 Oct 2018 07:35:10 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-d8-5bbefd2f873c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DA.A2.04128.E2DFEBB5; Thu, 11
        Oct 2018 08:35:10 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181011073509eusmtip187da5a0a457ae9d45b0320742d814717~cfaKLxewg0904409044eusmtip1P;
        Thu, 11 Oct 2018 07:35:09 +0000 (GMT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        linux-pm@vger.kernel.org, quentin.perret@arm.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Thu, 11 Oct 2018 09:35:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e2091e7e-b6e6-950d-ebab-18ba2de9264f@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGc2em06GxeCkoR1yIjRqFCBKNXpegJiZO5EHfXHjQihMgQMUO
        oBBNCEZFAgRFlpZViaKVWKmk1oawiS2LLCIqLhgXNAoCSpWgQaLDYOTtu/89/znnv7kcrRlV
        +HHR+gTBoNfFalkVY3P+7Fod/LsufM2DSUx+jRiVpLrQoiCl7sWkrPepgpyusLAkrzGLIlPm
        EpY8dhSzxJ3VjEhPQzlFXFkNFPlgtTCk5HseTQbeZrOkO89Ik/TmcZpU/+C3efFVpVWIv2fq
        V/J3rgfwFbWfKd5qPs/yr57Wsnx9SZWSH617wvLZNWbEu61L9qgOqLYcEWKjkwRDcOghVVS2
        ZYSKP6890TvppFLR2IIM5MEBXgevL49QGUjFafB1BM9tjYx8+I7g2eA7pXxwI7B1PWAzEDdt
        yeufK+uVCK6cvc1KrTR4GEFnn7fE3ngDtPUXIol9cArcdDUhyUBjNwWf66eQ1IjFQWA3H5OQ
        wcvhxthSqXwe3gfNby5PW9XYC1qNA4zEHjgUnJkD06No7AsvBsoomf3h7nAxLbUHXMKBdcLB
        yuYkuDT8nJVj7oCWx1lKmb1h0FUzw4ugPTeTkVmEjnTzTP1JONdqn6nZDPddjxTSnjReBRZH
        sCxvhyFjkUJ+Ek/oG/aS1/GEi7YCWpbVkH5WI1evhJrMbkrm+VBZla/MQVrTrJCmWcFMs4KZ
        /s8tR4wZ+QqJYlykIK7VC8eDRF2cmKiPDIo4GmdFf79h+5Trhx3VTR5uQphD2jnqCb+6cI1C
        lyQmxzUh4Gitjzq48K+kPqJLThEMRw8aEmMFsQkt5Bitr/paaXW4BkfqEoQYQYgXDP9uKc7D
        LxXFPFnm6Om7dcC5orPAc/fvTnta0MLcXSHlD2uL4rdWpilGB9tWtZ4Oc+9VOu7np2ZU7wz7
        Nq7oDd0UET1uyw8ZROacttScnk8TH77Y/cti79YIgYVJV+3YN0YftWW/+Vtu//tjrOeiiBVb
        Nwa+NB4+83H9hTOnvjrfh3u1+HQM3bMWaxkxShcSQBtE3R/lhvdoggMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42I5/e/4XV29v/uiDSasFbf49W4mu8XGGetZ
        LeZ9lrWYf+Uaq0Xz4vVsFlMP9jJZ/Fs1l83i8q45bBafe48wWlw6sIDJ4njvASaLp5vWs1jM
        /TKV2eLJwz42iwtTZzJbdBz5xmyx8auHg6DHmnlrGD12zrrL7rF5hZbH4j0vmTw2repk87hz
        bQ+bx/65a9g93u+7yubRt2UVo8fnTXIBXFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqG
        xuaxVkamSvp2NimpOZllqUX6dgl6GX3r3zEVdCpVXPlzjKmB8ZNkFyMHh4SAicTUu/xdjFwc
        QgJLGSUalx5m72LkBIqLSUzatx3KFpb4c62LDaLoNaPEo4MHWEASwgLmEqfuzmAEsUUEqiRW
        /trJCmIzC3xmkuhdKwPRsJdJovvtFjaQbWwCehI7VhWC1PAKuElM2fWGGSTMIqAqsfKTIkhY
        VCBCYvXyF6wQJYISJ2c+AVvFKWAncaznCRvEeDOJeZsfMkPY4hK3nsxngrDlJba/ncM8gVFo
        FpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzABLDt2M8tOxi73gUf
        YhTgYFTi4f0htS9aiDWxrLgy9xCjBAezkgiv/gygEG9KYmVValF+fFFpTmrxIUZToN8mMkuJ
        JucDk1NeSbyhqaG5haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQbGy6IdMZof
        G9Xu2ges/v3z3MXtu/L31yl5arJO9lx5yWtncMD7fSlWcjVihwV55/x9f8d51lzGdUyF8kb/
        rn54PMHmZB5fzqRi/xKD8/FVzoeb95146HJeN6zmZvYdoXKWpOVfVbnV10yrq9Zd13lAOk3Z
        +VmryzWDpOj9kzO70j57iioc0qtSYinOSDTUYi4qTgQAK5K+/RYDAAA=
Message-Id: <20181011073510eucas1p100bfadd6055a523cd1e92b07bfacfc10~cfaLHcbIo1401014010eucas1p1d@eucas1p1.samsung.com>
X-CMS-MailID: 20181011073510eucas1p100bfadd6055a523cd1e92b07bfacfc10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
        <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
        <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
        <e2091e7e-b6e6-950d-ebab-18ba2de9264f@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 10/10/2018 06:54 PM, Daniel Lezcano wrote:
> On 10/10/2018 17:35, Lukasz Luba wrote:
>> Hi Thara,
>>
>> I have run it on Exynos5433 mainline.
>> When it is enabled with step_wise thermal governor,
>> some of my tests are showing ~30-50% regression (i.e. hackbench),
>> dhrystone ~10%.
>>
>> Could you tell me which thermal governor was used in your case?
>> Please also share the name of that benchmark, i will give it a try.
>> Is it single threaded compute-intensive?
> 
> aobench AFAICT
> 
> It would be interesting if you can share the thermal profile of your board.
> 
Thanks for the benchmark name.
It was tested on Samsung TM2 device with Exynos 5433 with debian.
Thermal stuff you can find in mainline:
arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi

Regards,
Lukasz

> 
>> On 10/09/2018 06:24 PM, Thara Gopinath wrote:
>>> Thermal governors can respond to an overheat event for a cpu by
>>> capping the cpu's maximum possible frequency. This in turn
>>> means that the maximum available compute capacity of the
>>> cpu is restricted. But today in linux kernel, in event of maximum
>>> frequency capping of a cpu, the maximum available compute
>>> capacity of the cpu is not adjusted at all. In other words, scheduler
>>> is unware maximum cpu capacity restrictions placed due to thermal
>>> activity. This patch series attempts to address this issue.
>>> The benefits identified are better task placement among available
>>> cpus in event of overheating which in turn leads to better
>>> performance numbers.
>>>
>>> The delta between the maximum possible capacity of a cpu and
>>> maximum available capacity of a cpu due to thermal event can
>>> be considered as thermal pressure. Instantaneous thermal pressure
>>> is hard to record and can sometime be erroneous as there can be mismatch
>>> between the actual capping of capacity and scheduler recording it.
>>> Thus solution is to have a weighted average per cpu value for thermal
>>> pressure over time. The weight reflects the amount of time the cpu has
>>> spent at a capped maximum frequency. To accumulate, average and
>>> appropriately decay thermal pressure, this patch series uses pelt
>>> signals and reuses the available framework that does a similar
>>> bookkeeping of rt/dl task utilization.
>>>
>>> Regarding testing, basic build, boot and sanity testing have been
>>> performed on hikey960 mainline kernel with debian file system.
>>> Further aobench (An occlusion renderer for benchmarking realworld
>>> floating point performance) showed the following results on hikey960
>>> with debain.
>>>
>>>                                           Result          Standard        Standard
>>>                                           (Time secs)     Error           Deviation
>>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
>>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
>>>
>>> Thara Gopinath (7):
>>>     sched/pelt: Add option to make load and util calculations frequency
>>>       invariant
>>>     sched/pelt.c: Add support to track thermal pressure
>>>     sched: Add infrastructure to store and update instantaneous thermal
>>>       pressure
>>>     sched: Initialize per cpu thermal pressure structure
>>>     sched/fair: Enable CFS periodic tick to update thermal pressure
>>>     sched/fair: update cpu_capcity to reflect thermal pressure
>>>     thermal/cpu-cooling: Update thermal pressure in case of a maximum
>>>       frequency capping
>>>
>>>    drivers/base/arch_topology.c  |  1 +
>>>    drivers/thermal/cpu_cooling.c | 20 ++++++++++++-
>>>    include/linux/sched.h         | 14 +++++++++
>>>    kernel/sched/Makefile         |  2 +-
>>>    kernel/sched/core.c           |  2 ++
>>>    kernel/sched/fair.c           |  4 +++
>>>    kernel/sched/pelt.c           | 40 ++++++++++++++++++--------
>>>    kernel/sched/pelt.h           |  7 +++++
>>>    kernel/sched/sched.h          |  1 +
>>>    kernel/sched/thermal.c        | 66 +++++++++++++++++++++++++++++++++++++++++++
>>>    kernel/sched/thermal.h        | 13 +++++++++
>>>    11 files changed, 157 insertions(+), 13 deletions(-)
>>>    create mode 100644 kernel/sched/thermal.c
>>>    create mode 100644 kernel/sched/thermal.h
>>>
> 
> 
