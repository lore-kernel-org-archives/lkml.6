Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02111C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC35E20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O+jHfRQw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC35E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJPRSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:18:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44650 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJPRSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:18:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016092833euoutp016de68e13566dc626f07984a65f464f45~eDLl3ABBE2130821308euoutp01H
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 09:28:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016092833euoutp016de68e13566dc626f07984a65f464f45~eDLl3ABBE2130821308euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539682113;
        bh=TIe2eBd3QC9SwqFwii0V+dbzqof0G3FOQ92tX+cCj8g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=O+jHfRQwzdaJNAG6f64od/8JvjRl2q2dSO9qHeEv9KAnVv+tdGAgj4mAYpgUrXzWZ
         ssOJXvsMi8/isp3lIHkrzbW468yolawSoEXgmElsW2Fp/cLhYXttITqGqzE91Df3bm
         3wq9ulby3Jozsp5sQfPNksWmiye6yX9i+qTQyq48=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016092832eucas1p13b5273f34e2a491241b0b9f12f0cab99~eDLk8AprX0622506225eucas1p1F;
        Tue, 16 Oct 2018 09:28:32 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6D.EE.04294.F3FA5CB5; Tue, 16
        Oct 2018 10:28:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181016092831eucas1p1d9fa0678c15afb01d72b6f3df80352f8~eDLkNsh6l0620706207eucas1p1V;
        Tue, 16 Oct 2018 09:28:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181016092831eusmtrp1b3c775a33eb6d494acddc51b06c580a5~eDLkL_ZCg1240312403eusmtrp1c;
        Tue, 16 Oct 2018 09:28:31 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-ba-5bc5af3fc78e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 75.6A.04284.F3FA5CB5; Tue, 16
        Oct 2018 10:28:31 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016092830eusmtip2db9879036fd121f545d4d35ab04cdd56~eDLjbvVu50680506805eusmtip2E;
        Tue, 16 Oct 2018 09:28:30 +0000 (GMT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, l.luba@partner.samsung.com,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Tue, 16 Oct 2018 11:28:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016073305.GA64994@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c45OzteJset8iW7wKQoKa1I+qK0ex2Iwr+ilC6rDs5yajtq
        GRGzokzUNNN0NDXEGmu0XGLLrKZNRe1qeU8zWpSK3aZmUVLzLPK/53ve38v7PPAxpPy3ZCYT
        G5/Ea+NVcUram6pq+PF08VpLffQS+zsC//xUJMUVhRYJLnbNxiWv2iX4dJmFxvm1WQSeMBlo
        3K2bhV9WX6GxK8uB8I2JZoRb7aUEbsyyE/i91UJhw0g+iZ1vs2n8PL+IxOmOMRJXjHJrFZy5
        2Iy4u/peKXfbGMyV1QwQnNV0nuZet9fQ3EODWcrVfqohuM8P2mguu9KEOJd1TqRPlPfqg3xc
        bAqvDY3Y561uKDVJE28EHeu1nKV1yB6YgbwYYJdDVWEOlYG8GTlrRNCmM0vExwiCxy6jZ+JC
        8OBVFflvpfXCN+TWcvY6grTBKBEaRvDBOki5Bwp2BTT3Fk5C09hIMHQ7kRsi2WYSLMUFf28w
        DM2GgM10xM1Q7DzoMt6fPDCd3QmO/quTuzLWH5qKnJQb92JDYeSdwm2TbAB0O0sIUc+FO8NX
        PNlsDJSfCRNXU2BoyCkR/Y3QlPuVELUCBhsrpaKeBS15mZSoBXiSbqJFfQLONdk8zCp41Phi
        MjHJLgRLdahor4PTxi+k2wbWDzqH/cU0fnCx6rLHlkH6WblIL4DKzOeeADPgurlAmoOU+ikV
        9VN66af00v+/W4ooEwrgkwVNDC8si+ePhggqjZAcHxNyIEFjRX8/ZctE44gNVf/aX4dYBil9
        ZeMdjmi5RJUipGrqEDCkcppsdmp9tFx2UJV6nNcm7NUmx/FCHQpkKGWA7FpxRbScjVEl8Yd5
        PpHX/psSjNdMHVq5Ycec7c6O0Wd7TqUtOt7TVkF/HAuq2aZIU1d3zn8zL29Xxpeo977qW9k3
        +yKppFN3dLH2geU9v2LDN20JN9vKI/oTSqxhJ7Nrty4NXixb8/RA0A5dM2c5tHCgfr2Pvbbg
        2qB/1NhE2b2PjpLNGV0dl3Zvybw/Y7wv95Ga7tNs/F7upaQEtWppMKkVVH8AUeAm/5ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec/Zzo7W8LRpvnhLFhVJHT3e9ipeiiJOH7pQBKWFLT2o6Jzt
        TNMgEJtdBLUMS5dTw0SZytCZmpqpzTuUWGl5K9HCkgzzgqZIzhH47cfzf35/eOAhcckjoRMZ
        m6Dh1AmKeBlhK+jf6J44HGrsDPdqzXZCf+cKRKgm3yhERQuuqPjDkBDdLjUSKK89C0MbBj2B
        RtJc0PumQgItZJkBqtzoA2iwrQRD3VltGPpWaxQg/WIejqYnswk0kFeAo3vmZRzVLLFHpGxV
        URVgX+rGRaypwoMtbfmBsbWG+wQ7NtRCsK/1VSK2fa4FY3+3fiTY7DoDYBdq3c7uCKOD1Kok
        Deceo+I1wbJwBnnTTACivX0DaMZHfiXQ20/mGRIUxcXHJnNqz5CrdExXiUGUWLk3Zdx4h0gD
        bc6ZwIaElC8czPkDMoEtKaHKAOyabhNag90wt7VBZGUpXB/KJKxLswDOD2oxSyCl5LBvPB9Y
        2J46DUfXCraacKoPh2t18yKrocXg8ETxpkGSBEXDRsN1iyCmTkBz5cxWkYDaBz9XvMIt7EBd
        hJXlM0Lrzi7YWzAtsKg2lCdcnJJaxjjlD4tMk7iVHeHIdDFm5T2w4Vch/gBIdNts3TZFt03R
        bVNKgMAA7LkkXhmt5BmaVyj5pIRoOlKlrAWbD1HftWpqBIM15zsARQLZTvHKsDlcIlQk86nK
        DgBJXGYvdk3tDJeIoxSpNzm1KkKdFM/xHcBv87aHuJNDpGrzvRI0EYwfI0cBjNxH7uOPZI7i
        d16pYRIqWqHh4jgukVP/9zDSxikNBJhzXU6ZA/X6x71jXxNXOi+FXLg78qk/fx1XP3E2h745
        7tvulp6xFpO3/PTQi5O2KQNa35rq2XntfmGyey89atfMNHnUf69Oz9A+X3qLFiMvz12rewqy
        V8Xnbh0b9uHW2DM2P7PsoptvrE/1MM/KTUcje6jgnP72wqUD/V/iDpbJBHyMgvHA1bziH6zD
        P1QmAwAA
Message-Id: <20181016092831eucas1p1d9fa0678c15afb01d72b6f3df80352f8~eDLkNsh6l0620706207eucas1p1V@eucas1p1.samsung.com>
X-CMS-MailID: 20181016092831eucas1p1d9fa0678c15afb01d72b6f3df80352f8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016073315epcas4p1e0d57bf856cf95312a622004ce20391f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016073315epcas4p1e0d57bf856cf95312a622004ce20391f
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
        <20181010061751.GA37224@gmail.com> <5BBE1E1F.3030308@linaro.org>
        <CGME20181016073315epcas4p1e0d57bf856cf95312a622004ce20391f@epcas4p1.samsung.com>
        <20181016073305.GA64994@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/16/2018 09:33 AM, Ingo Molnar wrote:
> 
> * Thara Gopinath <thara.gopinath@linaro.org> wrote:
> 
>>>> Regarding testing, basic build, boot and sanity testing have been
>>>> performed on hikey960 mainline kernel with debian file system.
>>>> Further aobench (An occlusion renderer for benchmarking realworld
>>>> floating point performance) showed the following results on hikey960
>>>> with debain.
>>>>
>>>>                                          Result          Standard        Standard
>>>>                                          (Time secs)     Error           Deviation
>>>> Hikey 960 - no thermal pressure applied 138.67          6.52            11.52%
>>>> Hikey 960 -  thermal pressure applied   122.37          5.78            11.57%
>>>
>>> Wow, +13% speedup, impressive! We definitely want this outcome.
>>>
>>> I'm wondering what happens if we do not track and decay the thermal
>>> load at all at the PELT level, but instantaneously decrease/increase
>>> effective CPU capacity in reaction to thermal events we receive from
>>> the CPU.
>>
>> The problem with instantaneous update is that sometimes thermal events
>> happen at a much faster pace than cpu_capacity is updated in the
>> scheduler. This means that at the moment when scheduler uses the
>> value, it might not be correct anymore.
> 
> Let me offer a different interpretation: if we average throttling events
> then we create a 'smooth' average of 'true CPU capacity' that doesn't
> fluctuate much. This allows more stable yet asymmetric task placement if
> the thermal characteristics of the different cores is different
> (asymmetric). This, compared to instantaneous updates, would reduce
> unnecessary task migrations between cores.
> 
> Is that accurate?
> 
> If the thermal characteristics of the cores is roughly symmetric and the
> measured CPU-intense load itself is symmetric as well, then I have
> trouble seeing why reacting to thermal events should make any difference
> at all.
> 
> Are there any inherent asymmetries in the thermal properties of the
> cores, or in the benchmarked workload itself?
The aobench that at least I have built is a single threaded app.
If there is migration of the process to cluster and core which is in
avg faster, then it will gain.
The hikey960 platform has limited number of OPPs.
big cluster: 2.36, 2.1, 1.8, 1.4, 0.9 [GHz]
little cluster: 1.84, 1.7, 1.4, 1.0, 0.5 [GHz]
Comparing to Exynos5433 which has 15 OPPs for big cluster every 100MHZ,
it is harder to pick-up the right one.
I can imagine that the thermal governor is jumping around 1.8, 1.4, 0.9
for the big cluster. Maybe little cluster is at higher OPP
and running there longer would help. Thermal has time slots are 100ms
(based on this DT).

Regarding other asymmetries, there are different parts of the cluster
and core utilized depending of workload and data set.
There might be floating point or vectorized code utilizing long piplines
in NEON and also causing less cache misses.
That will warm up more than integer unit or copy using load/store unit
(which occupy less silicon (and C 'capacitance')) at the same frequency.

There are also SoCs which have single power rail from DCDC in PMIC
for both asymmetric clusters. In SoC on front of these clusters,
there is internal LDO, which reduces the voltage to the cluster.
In such system cpufreq driver chooses max of the voltages for the
clusters and sets it to the PMIC, then sets LDOx voltage diff for
cluster with smaller voltage. This causes another asymmetries,
because more current going through LDO causes more heat than
direct DCDC voltage (i.e. seen as a heat on big cluster).

There are also cache portion power down asymmetries.
I have been developing such driver. Based on memory traffic
and cache hit/miss ratio it chooses how much cache can be powered down.
I can image that some HW does it without the need of SW assist.

There are SoCs with DDR modules mounted on top - PoP.
I still have to investigate what is different in SoC power budget
in such setup (depending on workload).

There are also workloads for UI using GPU, which can also
be utilized in 'portions' (shader cores from 1 to 32).

These asymmetries cause that simple assumptio
P_dynamic = C * V^2 * f
is probably not enough.

I would suggest to choose platform with more fine grained OPPs or
add more points to hikey960 and repeat the tests.

Regards,
Lukasz Luba

> 
> Thanks,
> 
> 	Ingo
> 
> 
