Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E394C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D6C2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PHsJ3ZJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfBLMFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:05:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46845 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfBLMFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:05:39 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190212120536euoutp029e70244b79d544cb82b5c1c62d362ca0~CnFscmBYX2820628206euoutp02i
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:05:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190212120536euoutp029e70244b79d544cb82b5c1c62d362ca0~CnFscmBYX2820628206euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549973136;
        bh=UEcOD2I5ilgmHKhiRgycbyGuWiuOxtKirP1p21I9iJY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PHsJ3ZJO4/BZ+4pEl3RnBSzxPqntF76WdYBCVgvVxRyru5jK7mqu8tN7lwuQ2E+Oq
         E5GbMVdrzd0jSTbxADa+HJbM9ojKFkDnfqMUJcuy1cZMXWgl7gXvhSy8m/z/IfFz6m
         T9fmoz0U4EyOU4l4cXF6fb26yMMLHN+mkufUWR1s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212120536eucas1p2209b384482a2821d45b0304253422456~CnFrsZwAT1226712267eucas1p2V;
        Tue, 12 Feb 2019 12:05:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8C.B5.04294.F86B26C5; Tue, 12
        Feb 2019 12:05:35 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190212120535eucas1p212e20a071c29f14b9b1bfbce8a8d3e77~CnFq3qi6n1236712367eucas1p28;
        Tue, 12 Feb 2019 12:05:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212120534eusmtrp22bc82726a39f51f4cc844e5191cf2204~CnFqo5vNI2376123761eusmtrp2B;
        Tue, 12 Feb 2019 12:05:34 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-c6-5c62b68fc0cf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 93.6F.04284.E86B26C5; Tue, 12
        Feb 2019 12:05:34 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190212120534eusmtip21519464b17df18ccc474bd9f0736eeaa~CnFqEJZDM0523305233eusmtip2e;
        Tue, 12 Feb 2019 12:05:34 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <f60efa88-cf43-faed-55be-f90ce8f44f9e@partner.samsung.com>
Date:   Tue, 12 Feb 2019 13:05:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djPc7r925JiDOZs1bfYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i8u75rBZfO49wmix9shddovPGx4zWtxuXMFmcfhNO6sDt8eaeWsY
        PWY3XGTxWPjpK6tH35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZay9+Jap4KZCxdtZM1gaGLdJ
        dTFyckgImEg0vJ3J1sXIxSEksIJRonPeMmYI5wujxK7fX1kgnM+MEg0np7PDtMxevRQqsZxR
        YuvrOVD9b4Gq5rUwgVQJC4RIrOk7ADSLg0NEIElixn8bkDCzwAlGiZ6JViBhNgE9iR2rCkHC
        vAJuErsP/gbrZBFQlWjY1whmiwpESBzufccIUSMocXLmExYQm1PAXuJI4xkmiJHiEreezIey
        5SWat84G+0BC4BK7xL6VL9ggjnaRaDo3AeoBYYlXx7dA2TIS/3dCNEsIFEuc7VgFVV8j0X5y
        B1SNtcTh4xdZQW5mFtCUWL9LHyLsKPG+5zsTSFhCgE/ixltBiBP4JCZtm84MEeaV6GgTgqjW
        kNjScwFqkZjE8jXT2CcwKs1C8tgsJM/MQvLMLIS9CxhZVjGKp5YW56anFhvlpZbrFSfmFpfm
        pesl5+duYgQmqdP/jn/ZwbjrT9IhRgEORiUe3or8xBgh1sSy4srcQ4wSHMxKIrzym5NihHhT
        EiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTAa8/z5pPdW6mn+
        pLsc36rf6zlzyTadOlQfsS6g78GPXT8u2uY+LJNf5+T1N37ao4fi3+QvnjGJm6r70d+ghd1z
        VsK3HasO5h4yu1s30+X4QbsLT4yMZP5qtYn8ms+a4Xxv763lfxtnhvnNfK/io/tFmPvzpIhY
        obx09ifry4ODn9glnLNbLfdDiaU4I9FQi7moOBEAMgut9E4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7p925JiDBY3GVlsnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xeVdc9gsPvceYbRYe+Quu8XnDY8ZLW43rmCzOPymndWB22PNvDWM
        HrMbLrJ4LPz0ldWjb8sqRo/Pm+QCWKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1j
        rYxMlfTtbFJSczLLUov07RL0MtZefMtUcFOh4u2sGSwNjNukuhg5OSQETCRmr17KAmILCSxl
        lJh51RgiLiYxad92dghbWOLPtS62LkYuoJrXjBLLF19kA0kIC4RIrOk7wAxiiwgkSUw5/gCs
        iFngBKPEtuOnmCA6LjFKXDnZyNjFyMHBJqAnsWNVIUgDr4CbxO6Dv5lAbBYBVYmGfY1gtqhA
        hMTHp/uYIGoEJU7OfAJ2HaeAvcSRxjNgcWYBM4l5mx8yQ9jiEreezIeKy0s0b53NPIFRaBaS
        9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwNjcduzn5h2MlzYGH2IU
        4GBU4uGtyE+MEWJNLCuuzD3EKMHBrCTCK785KUaINyWxsiq1KD++qDQntfgQoynQcxOZpUST
        84FpI68k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA2Od6xMN15nf
        9OSnpp88qy2a53dAxX27ueytt7PjK8o46lQPRr21D5oUPOlHf6O/g7/dyfsd5vYF9gEz6zYs
        yQ7V1Q323rlxrvDG99zrtOa8/PLaXuHfuu9HJv0z5Jz90Ymrnp3j9EY5tuu51apNx3faH9n+
        5PnLpzZXZ0+WlLQwaExjKPh/pUiJpTgj0VCLuag4EQDcymXa4wIAAA==
X-CMS-MailID: 20190212120535eucas1p212e20a071c29f14b9b1bfbce8a8d3e77
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
        <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo

On 2/12/19 6:46 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 2. 12. 오전 12:30, Lukasz Luba wrote:
>> This patch set changes workqueue related features in devfreq framework.
>> First patch switches to delayed work instead of deferred.
>> The second switches to regular system work and deletes custom 'devfreq'.
>>
>> Using deferred work in this context might harm the system performance.
>> When the CPU enters idle, deferred work is not fired. The devfreq device's
>> utilization does not have to be connected with a particular CPU.
>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
>> They all are missing opportunity to check the HW state and react when
>> the deferred work is not fired.
>> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
>> on full speed, might show x5 worse performance if the crucial CPU is in idle.
> 
> The devfreq framework keeps the balancing between performance
> and power-consumption. It is wrong to focus on only either
> performance or power.
IMO it just does not work, please see my explanation below.
> 
> This cover-letter focus on the only performance without any power-consumption
> disadvantages. It is easy to raise the performance with short sampling rate
> with polling modes. To get the performance, it is good as short as possible
> of period.
The cover-letter mentioned about missing functionality. The interface
has 'polling_ms' field, which driver developer would assume works.
I have test cases where it would not be called for seconds or even
never.
In your driver drivers/devfreq/exynos-bus.c polling_ms = 50
The driver is controlling many devices including Network-on-Chip (NOC).
It is using 'simple_ondemand' governor. When it is missing opportunity
to change the frequency, it can either harm the performance or power
consumption, depending of the frequency the device stuck on.

> 
> Sometimes, when cpu is idle, the device might require the busy state.
> It is very difficult to catch the always right timing between them.
I will try to address them in the next patch set.
> 
> Also, this patch cannot prevent the unneeded wakeup from idle state.
> Apparently, it only focuses on performance without considering
> the power-consumption disadvantage. In the embedded device,
> the power-consumption is very important point. We can not ignore
> the side effect.
Power consumption is important, but we cannot rely on randomness
when we develop core features in a framework.
> 
> Always, I hope to improve the devfreq framwork more that older.
> But, frankly, it is difficult to agree because it only consider
> the performance without considering the side-effect.
> 
> The power management framework always have to consider
> the power-consumption issue. This point is always true.
I do agree that the power vs. performance trade-off must be considered
in the devfreq framework. I have developed 2 additional patches and
I am going to post them today (you can now check them on Tizen gerrit,
change 198160).

We cannot simply pin the *device* load with *CPU* load or idle state.
It is not an implication.
The device like GPU, NoC or Dynamic Memory Controller can have
completely different utilization (i.e in Exynos the GPU is connected
to DDR memory through NoC and DMC).
Some developers who use OpenCL on GPU might be interested in this
improvement.

Thank you for participating in the discussion on this issue.
It will need more development and iterations.
In my opinion currently there is one bug in the devfreq and one missing
feature to solve.

Regards,
Lukasz

> 
>>
>> Changes:
>> v2:
>> - single patch split into two
>> - added cover letter
>>
>> link for the previous version and discussion:
>> https://marc.info/?l=linux-pm&m=154904631226997&w=2
>>
>> Regards,
>> Lukasz Luba
>>
>> Lukasz Luba (2):
>>    drivers: devfreq: change devfreq workqueue mechanism
>>    drivers: devfreq: change deferred work into delayed
>>
>>   drivers/devfreq/devfreq.c | 27 +++++++--------------------
>>   1 file changed, 7 insertions(+), 20 deletions(-)
>>
> 
> 
