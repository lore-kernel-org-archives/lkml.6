Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7BD20821
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s8hofgb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfBHKCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:02:53 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57386 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfBHKCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:02:53 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190208100250euoutp01f2664a34da1cbdd1f2ffb348eefbf0ee~BW1XOYrSb2096920969euoutp01U
        for <linux-kernel@vger.kernel.org>; Fri,  8 Feb 2019 10:02:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190208100250euoutp01f2664a34da1cbdd1f2ffb348eefbf0ee~BW1XOYrSb2096920969euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549620170;
        bh=NWA8pcfokKpsIU7TJWexHgFl2NrCUA/yWu25T4UnToU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=s8hofgb079F/Ur+RvdfamUkg+LJQpzU0bUvMBnWGm2tEEG3VbcN4p+MghZfqb5h9t
         9YxZWRfBYx3i19xK6b3yUOSOvjn3uZdx+dl0dDDE3xUaCk0UpVHg/Vczqqb4x7JtzF
         7MrlvcCs3t/zWLQ9wzwqOtOiTGIwvEP6C1YycNz8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190208100250eucas1p1630d819eb0e94410ce4bbe3d9ffba93b~BW1WpVWZb2184021840eucas1p1g;
        Fri,  8 Feb 2019 10:02:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4C.C5.04806.9C35D5C5; Fri,  8
        Feb 2019 10:02:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190208100249eucas1p17167d9aea3dd6dbfe8e47e6348541627~BW1V2Jah82402624026eucas1p1L;
        Fri,  8 Feb 2019 10:02:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190208100249eusmtrp2f540fe90f4a32c07f36d00df7d174fe3~BW1VnKhOA1789217892eusmtrp2V;
        Fri,  8 Feb 2019 10:02:49 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-5b-5c5d53c90d03
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.0B.04128.8C35D5C5; Fri,  8
        Feb 2019 10:02:48 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190208100248eusmtip23622e17d3f5f2481b986bf746d7cc44c~BW1U3qmj92095620956eusmtip20;
        Fri,  8 Feb 2019 10:02:48 +0000 (GMT)
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
Message-ID: <b0a743d8-ab28-2da3-9cb2-f9bb369ec2dd@samsung.com>
Date:   Fri, 8 Feb 2019 11:02:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208092348.uqkfgxwx2pe3lmpd@vireshk-i7>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djP87ong2NjDNqWW1tsnLGe1eLm1w5W
        i8u75rBZfO49wmgx4/w+Jos3P84yWZw5fYnV4t+1jSwWG796WKw8MYvZgctj06pONo871/aw
        eWy52s7i0bdlFaPHyVNPWDyO39jO5PF5k1wAexSXTUpqTmZZapG+XQJXxuLN31kLDitWbLh8
        jb2B8YdUFyMnh4SAicSz5i62LkYuDiGBFYwS757cYIVwvjBKfLp3jxnC+cwocff3HRaYllsd
        y9khEssZJTbdfQzlvGeUmP2oHaxKWMAVaPAZoAQHh4iAlsTLm6kgNcwCR5kkbh76wwZSwyZg
        KNH1tgvM5hWwkzh2di47iM0ioCLx8dtcVhBbVCBGYsq5I+wQNYISJ2c+AZvPKWApseT6J2YQ
        m1lAXmL72zlQtrjErSfzmSAuvcYucWqlD8gNEgIuEiu2hUKEhSVeHd/CDmHLSPzfCVLOBWQ3
        M0q0z5jFDuH0MEpsnbODDaLKWuLw8YusIIOYBTQl1u/Shwg7Spw6vJINYj6fxI23ghAn8ElM
        2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAvJY7OQPDMLyTOzEPYuYGRZxSieWlqcm55a
        bJyXWq5XnJhbXJqXrpecn7uJEZiyTv87/nUH474/SYcYBTgYlXh4L2jHxAixJpYVV+YeYpTg
        YFYS4X3oHxsjxJuSWFmVWpQfX1Sak1p8iFGag0VJnLea4UG0kEB6YklqdmpqQWoRTJaJg1Oq
        gTGoW6l0XaXfk5ss0ibsa+PufOQ/d8yfSfGQYPKU7yY7nFXS5rG77e++aPH6XaVO8IeglFNr
        Tt/2q9o2LfCuzjzVLwfsTjSUOT64tn3ubNuZceflH+8qeHirddlqhwnrjoXuFPqynoPhP8On
        yuh00UIGoUurLZ/f8VhXKdKl1B823T/JZI/OSSclluKMREMt5qLiRACaOLe9VQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7ongmNjDF4uMbfYOGM9q8XNrx2s
        Fpd3zWGz+Nx7hNFixvl9TBZvfpxlsjhz+hKrxb9rG1ksNn71sFh5YhazA5fHplWdbB53ru1h
        89hytZ3Fo2/LKkaPk6eesHgcv7GdyePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jMWbv7MWHFas2HD5GnsD4w+pLkZODgkBE4lbHcvZ
        uxi5OIQEljJK3L34gQkiISNxcloDK4QtLPHnWhcbRNFbRon7G/8wgySEBVwlnjWfAerm4BAR
        0JJ4eTMVpIZZ4CiTxLsL75khGjqYJX4+3McO0sAmYCjR9RZkEicHr4CdxLGzc8HiLAIqEh+/
        zWUFGSQqECNx9RwjRImgxMmZT1hAbE4BS4kl1z+B7WUWUJf4M+8SlC0vsf3tHChbXOLWk/lM
        ExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjNJtx35u2cHY
        9S74EKMAB6MSD+8F7ZgYIdbEsuLK3EOMEhzMSiK8D/1jY4R4UxIrq1KL8uOLSnNSiw8xmgL9
        NpFZSjQ5H5hA8kriDU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MBas
        OX61TUvyWVDOw/UJvv8lTr2b/13J+fjOZraw4Dcvr6/7Pae4snxLRfbmne6Wi1M6nWOfNjsG
        xvFqmG8P73k3+//ZPy2v5m2dHcHLocl92OYvu0BUfEvCQd7QhJDiPin/Gv3W5A8Rz7ZEPdq6
        fn5D87z7Sf8aGxaIpIVoTG0IrliheLecTYmlOCPRUIu5qDgRAGyZFY7oAgAA
X-CMS-MailID: 20190208100249eucas1p17167d9aea3dd6dbfe8e47e6348541627
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
        <bbab0116-c2e5-a3a6-30e4-cbd8c583a120@samsung.com>
        <20190208092348.uqkfgxwx2pe3lmpd@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 2019-02-08 10:23, Viresh Kumar wrote:
> On 08-02-19, 10:15, Marek Szyprowski wrote:
>> On 2019-02-08 09:55, Viresh Kumar wrote:
>>> On 08-02-19, 09:12, Marek Szyprowski wrote:
>>>> On 2019-02-08 07:49, Viresh Kumar wrote:
>>>>> Why don't you get similar problem during suspend? I think you can get
>>>>> it when the CPUs are offlined as I2C would have gone by then. The
>>>>> cpufreq or OPP core can try and run some regulator or genpd or clk
>>>>> calls to disable resources, etc. Even if doesn't happen, it certainly
>>>>> can.
>>>> CPUfreq is suspended very early during system suspend and thus it does
>>>> nothing when CPUs are being offlined.
>>>>> Also at resume the cpufreq core may try to change the frequency right
>>>>> from ->init() on certain cases, though not everytime and so the
>>>>> problem can come despite of this series.
>>>> cpufreq is still in suspended state (it is being 'resume' very late in
>>>> the system resume procedure), so if driver doesn't explicitly change any
>>>> opp in ->init(), then cpufreq core waits until everything is resumed. To
>>>> sum up, this seems to be fine, beside the issue with regulator
>>>> initialization I've addressed in this patchset.
>>> Yeah, the governors are suspended very soon, but any frequency change
>>> starting from cpufreq core can still happen. There are at least two
>>> points in cpufreq_online() where we may end up changing the frequency,
>>> but that is conditional and may not be getting hit.
>> Then probably cpufreq core suspend should handle this.
> Handle what ? That code is part of cpufreq_online() and needs to be
> there only.

If got it right, it is a matter of handling
CPUFREQ_NEED_INITIAL_FREQ_CHECK flag. Maybe there should be additional
check if CPUfreq is not suspended?

>>>>> We guarantee that the resources are available during probe but not
>>>>> during resume, that's where the problem is.
>>>> Yes, so I've changed cpufreq-dt to the common approach, in which the
>>>> driver keeps all needed resources for the whole lifetime of the device.
>>> That's not what I was saying actually. I was saying that it should be
>>> fine to do a I2C transfer during resume, else we will always have
>>> problems and have to fix them with hacks like the one you proposed
>>> where you acquire resources for all the possible CPUs. Maybe we can
>>> fix it once and for all.
>> It is fine to do i2c transfers during cpufreq resume (see
> By resume I meant system resume and the whole onlining process of
> non-boot CPUs.

Right now those are 2 separate things in cpufreq core.

>> drivers/base/power/main.c dpm_resume() function for exact call place).
>> The problem is that such calls are not allowed in ->init(), which might
>> be called very early from CPU hotplug path (CPUs are resumed in the
>> first step of system resume procedure).
> Right and that's where I think we can do something to fix it in a
> proper way.
>
>> What's wrong with my proposed fix? It is not that uncommon to gather all
>> resources in probe() and keep them until remove() happens.
> For cpufreq drivers, we must be doing most of the stuff in init/exit
> only as far as possible. I am not saying your patch is bad, that is
> the best we can do in such situations. But I don't like that we have
> to get the resources for all CPUs, despite the fact that many of them
> would be part of the same policy and hence share resources. The
> problem was that we need to get sharing-cpus detail as well in probe
> then, etc.

Both resources in this case: clocks and regulators are refcounted by
their frameworks, so the cost of getting a few more references for them
is imho negligible.

> I was thinking about doing disable_nonboot_cpus() much earlier as the
> userspace is already frozen by then.
>
> @Rafael: Will that slowdown the suspend/resume process? Maybe not as
> we are doing everything from a single CPU/thread anyways ?

For some reasons drivers are handled partially asynchronously in
suspend/resume procedure and can do suspend and resume in parallel. I
don't think that limiting the whole suspend/resume process to a single
cpu is the best we can do.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

