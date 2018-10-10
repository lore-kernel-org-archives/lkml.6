Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C54C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBC32087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uTZMgcAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBC32087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJJW6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:58:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50186 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJW6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:58:39 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181010153555euoutp029d3b7c8311ad78fb5fa34775e91d7c73~cSUopzf7r1574615746euoutp02b
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 15:35:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181010153555euoutp029d3b7c8311ad78fb5fa34775e91d7c73~cSUopzf7r1574615746euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539185755;
        bh=LF8CHup0hwN6e3zMjLhGQk2IAJe9bp3KBHoPDx7uFUQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uTZMgcApcZKDKNRZlC4q9Og8Yy+OukHQywXA7aZkocyGqZTpEGinyHixsVDTEVfto
         dBl4anWtzJIJuNB/f3RX6AJOb/+blUqKCNe4V73cSMYhPiwdBa0cFx77puCRbvxki2
         hhzct2UYlkL3XVOFuynV1b2l51D6JckwcHA9MwH4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181010153554eucas1p1eaf7b82c7459eff49b98774638dd2bce~cSUnZtcAJ2965129651eucas1p12;
        Wed, 10 Oct 2018 15:35:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FF.67.04806.95C1EBB5; Wed, 10
        Oct 2018 16:35:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L;
        Wed, 10 Oct 2018 15:35:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181010153552eusmtrp1fb70c9dc8cef3422aaa7ff09a8f9ae91~cSUmDjIlE3183731837eusmtrp1x;
        Wed, 10 Oct 2018 15:35:52 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-8a-5bbe1c59b201
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 15.37.04128.85C1EBB5; Wed, 10
        Oct 2018 16:35:52 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181010153551eusmtip177f92fefbe1a2894fee0c807f76e4ecf~cSUlVhZRy2708527085eusmtip1b;
        Wed, 10 Oct 2018 15:35:51 +0000 (GMT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Wed, 10 Oct 2018 17:35:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0yMYRz3vO97773dHM9d0VeJ7SoTqxjm2Zj5ub3GzD9+dRsdva7mOrm3
        IvMHRdLUjKLulKzReZXbndRJirRatawfNCmGRauUzRUyQ9eb6b/P9/PjeT7fPQ9Ha78oArg4
        c6JgMRtMOlbFVDSMPw/fN79Gv+xX6irycyRfSZx5DgUp9ASRGy+6FCSt2MGS3KdZFPktFbCk
        s+o6SzxZ9Yh0PCmiSGPWE4p8dDkYUjCaS5O+99ksacvNp0lG/TeaOMf49Rq+tLAU8Q+tb5T8
        ffsSvrh6gOJd0gWW7+2qZvnaglIl/6XmJctnl0uI97gW7FRFqdbGCKa4ZMESuS5aFVv1/TOV
        8DjoRMPXSsVpZJubiXw4wCuhZLBBkYlUnBbbEYzmNCi9ghaPIuj6GSoLHgS16RXoX6KzeEQp
        CyUI/rx9ieRhGMHnuxLldfni1dD8Jm8y4Ye3Q/+jK5MJGmfTcC29ZWLgOBZHgFs65oUMDgV7
        6javfQ7eC/Xvbk5G1VgDTfl9jNfig7fCvTspXprG/vC67wYl44VQOXyd9p4O+CYH9YOprJxN
        huIHZ6ZKb4ZPH86xMvaFwcZypYznQ8uVi4yMRWjNkKY8p+B8k3vKswaeNbYrvB1oHAaOqkiZ
        3gBD+bZJGvAseDWskevMgssV12iZVkNGulZ2L4byi22UjOdCSelV5SWks07b0TptMeu0xaz/
        7y1CjIT8hSQx3iiIK8zC8QjREC8mmY0Rh47Gu9DEN2z53TjmRjW/DtYhzCHdTPWPgBq9VmFI
        FlPi6xBwtM5PPQNPUOoYQ8pJwXL0gCXJJIh1KJBjdP7q24VOvRYbDYnCEUFIECz/VIrzCTiN
        AkPNO5rL3ekzNauVEy9/ODStKVc6kODaHZXIpAQFF+R0nI3OCYkqG+P2Lx0Ii0mb3W4bzzMF
        2uftN/X3bBpKRb76vLrmXs32MP14d212TKS0bpdz51ZPpsO2223qGTVvKhoz9t5epGktK4wY
        ubplo90WfscY3O3s3XOrbXZwiI4RYw3Ll9AW0fAXTXbxWIIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42I5/e/4Xd0ImX3RBv/Wqlv8ejeT3WLjjPWs
        FvM+y1rMv3KN1aJ58Xo2i6kHe5ks/q2ay2ZxedccNovPvUcYLS4dWMBkcbz3AJPF003rWSzm
        fpnKbPHkYR+bxYWpM5ktOo58Y7bY+NXDQdBjzbw1jB47Z91l99i8Qstj8Z6XTB6bVnWyedy5
        tofNY//cNewe7/ddZfPo27KK0ePzJrkArig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1D
        Y/NYKyNTJX07m5TUnMyy1CJ9uwS9jF3f3zAV7JWtOPZpO2sD42yxLkZODgkBE4nLi9+xg9hC
        AksZJVqW+UDExSQm7dvODmELS/y51sUGUfOaUaJ7iTqILSxgLnHq7gxGEFtEwEfi+e7JQPVc
        HMwCfcwSz85cZAVxhATmMEqsfruWuYuRg4NNQE9ix6pCEJNXwE3iW3cxiMkioCqxoskbZIyo
        QITE6uUvWEFsXgFBiZMzn7CAlHAKeEqsW1kJEmYWMJOYt/khM4QtLnHryXwmCFteYvvbOcwT
        GIVmIemehaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM/m3Hfm7Zwdj1
        LvgQowAHoxIP7w+pfdFCrIllxZW5hxglOJiVRHgZBIBCvCmJlVWpRfnxRaU5qcWHGE2BXpvI
        LCWanA9MTHkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODilGhjD2k8E
        mDAY7tq6tkPpSuH7A5N1JnzmPr9c+YVJ4fuppd//KPb52hzWXfBw40mbSzZWbJeTrcN+54lt
        cV/49uzzlTWZxicThCe+/VR4mne3yMykPyEP9t4/+ID/irW8Q+tbj4eWdZGvL35mV/51RMvh
        rgdjJpfk+pO+oYZKEYo77xV53mHdzPtMiaU4I9FQi7moOBEASHAiJRQDAAA=
Message-Id: <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
X-CMS-MailID: 20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
        <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

I have run it on Exynos5433 mainline.
When it is enabled with step_wise thermal governor,
some of my tests are showing ~30-50% regression (i.e. hackbench),
dhrystone ~10%.

Could you tell me which thermal governor was used in your case?
Please also share the name of that benchmark, i will give it a try.
Is it single threaded compute-intensive?

Regards,
Lukasz

On 10/09/2018 06:24 PM, Thara Gopinath wrote:
> Thermal governors can respond to an overheat event for a cpu by
> capping the cpu's maximum possible frequency. This in turn
> means that the maximum available compute capacity of the
> cpu is restricted. But today in linux kernel, in event of maximum
> frequency capping of a cpu, the maximum available compute
> capacity of the cpu is not adjusted at all. In other words, scheduler
> is unware maximum cpu capacity restrictions placed due to thermal
> activity. This patch series attempts to address this issue.
> The benefits identified are better task placement among available
> cpus in event of overheating which in turn leads to better
> performance numbers.
> 
> The delta between the maximum possible capacity of a cpu and
> maximum available capacity of a cpu due to thermal event can
> be considered as thermal pressure. Instantaneous thermal pressure
> is hard to record and can sometime be erroneous as there can be mismatch
> between the actual capping of capacity and scheduler recording it.
> Thus solution is to have a weighted average per cpu value for thermal
> pressure over time. The weight reflects the amount of time the cpu has
> spent at a capped maximum frequency. To accumulate, average and
> appropriately decay thermal pressure, this patch series uses pelt
> signals and reuses the available framework that does a similar
> bookkeeping of rt/dl task utilization.
> 
> Regarding testing, basic build, boot and sanity testing have been
> performed on hikey960 mainline kernel with debian file system.
> Further aobench (An occlusion renderer for benchmarking realworld
> floating point performance) showed the following results on hikey960
> with debain.
> 
>                                          Result          Standard        Standard
>                                          (Time secs)     Error           Deviation
> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
> 
> Thara Gopinath (7):
>    sched/pelt: Add option to make load and util calculations frequency
>      invariant
>    sched/pelt.c: Add support to track thermal pressure
>    sched: Add infrastructure to store and update instantaneous thermal
>      pressure
>    sched: Initialize per cpu thermal pressure structure
>    sched/fair: Enable CFS periodic tick to update thermal pressure
>    sched/fair: update cpu_capcity to reflect thermal pressure
>    thermal/cpu-cooling: Update thermal pressure in case of a maximum
>      frequency capping
> 
>   drivers/base/arch_topology.c  |  1 +
>   drivers/thermal/cpu_cooling.c | 20 ++++++++++++-
>   include/linux/sched.h         | 14 +++++++++
>   kernel/sched/Makefile         |  2 +-
>   kernel/sched/core.c           |  2 ++
>   kernel/sched/fair.c           |  4 +++
>   kernel/sched/pelt.c           | 40 ++++++++++++++++++--------
>   kernel/sched/pelt.h           |  7 +++++
>   kernel/sched/sched.h          |  1 +
>   kernel/sched/thermal.c        | 66 +++++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/thermal.h        | 13 +++++++++
>   11 files changed, 157 insertions(+), 13 deletions(-)
>   create mode 100644 kernel/sched/thermal.c
>   create mode 100644 kernel/sched/thermal.h
> 
