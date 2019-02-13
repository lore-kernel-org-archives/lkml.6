Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C55BC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F83222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 01:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M07QfJso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfBMBJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 20:09:25 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:61758 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfBMBJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 20:09:24 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190213010920epoutp02427bde9a4c55e07c5545ef70318d1081~Cxx_nSjky0711107111epoutp02m
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:09:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190213010920epoutp02427bde9a4c55e07c5545ef70318d1081~Cxx_nSjky0711107111epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550020160;
        bh=zOBnbIDUgE30SsKakrZWCxSyoKY1tyOqufmqGOdOvro=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=M07QfJsooUcAznlMlz/gtXt3c9hhClv8nDmuh04sqlE95x8sf3KJJGro1ukBeND//
         i4AOd65xrnk6der8V27ahuiiy8D9EY1+zX8lJeKbzs+N3sFD5b98NPSgO+gbqnMIOy
         ghbidSqfKTl+rrEFDmC1AJCjrWO8BR+zyEXNuS8U=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.155]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190213010916epcas1p11929303e2eba2d054a007cd8fff3f8e1~Cxx6bDO6D2307723077epcas1p1D;
        Wed, 13 Feb 2019 01:09:16 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.42.04173.B3E636C5; Wed, 13 Feb 2019 10:09:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190213010915epcas1p35b7b60f74e030c83703a1a4c51440fe7~Cxx5okn4Y2409624096epcas1p3I;
        Wed, 13 Feb 2019 01:09:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190213010915epsmtrp2566c30528e4406156f778fa47c744226~Cxx5nXzIw2253822538epsmtrp2C;
        Wed, 13 Feb 2019 01:09:15 +0000 (GMT)
X-AuditID: b6c32a36-5d9ff7000000104d-a2-5c636e3b4c6e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.BE.03971.A3E636C5; Wed, 13 Feb 2019 10:09:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190213010914epsmtip240bf20b1f65ba022c2a728a62442c990~Cxx5R8DiH1093410934epsmtip2J;
        Wed, 13 Feb 2019 01:09:14 +0000 (GMT)
Subject: Re: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <815961f8-f9c3-6d26-8811-880e4cd76cb9@samsung.com>
Date:   Wed, 13 Feb 2019 10:09:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f60efa88-cf43-faed-55be-f90ce8f44f9e@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmrq51XnKMwb59VhYbZ6xntZj26TKL
        xbIGVYuzTW/YLW41yFhc3jWHzeJz7xFGi7VH7rJbfN7wmNHiduMKNovDb9pZHbg91sxbw+gx
        u+Eii8fCT19ZPQ6+28Pk0bdlFaPH501yAWxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYG
        hrqGlhbmSgp5ibmptkouPgG6bpk5QNcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtS
        cgosC/SKE3OLS/PS9ZLzc60MDQyMTIEKE7IzenZfYCvYr13xcNZ1lgbGX0pdjJwcEgImEkcm
        b2HuYuTiEBLYwSixqeUhC4TziVFi2eFHrBDON0aJaZd+ssG0rFjzGswWEtjLKHHprxZE0XtG
        ict3j7CAJIQFQiTW9B1gBrFFBNIk3rbfZQKxmQVOMEr0TLQCsdkEtCT2v7gBNohfQFHi6o/H
        jCA2r4CdxPKN68DmsAioSkx+0wBWIyoQIXG49x1UjaDEyZlPwGo4Bdwljr+czQoxX1zi1pP5
        ULvkJZq3zgb7TUJgOrtE54LTrBAfuEjsmbgIyhaWeHV8CzuELSXx+d1eqC+rJVaePMIG0dzB
        KLFl/wWoBmOJ/UsnA23gANqgKbF+lz7EMj6Jd197WEHCEgK8Eh1tQhDVyhKXH0D8LiEgKbG4
        vRNqvIfEi6PrWScwKs5C8s4sJC/MQvLCLIRlCxhZVjGKpRYU56anFhsWGCHH9iZGcMrVMtvB
        uOiczyFGAQ5GJR7eFUeTYoRYE8uKK3MPMUpwMCuJ8LYkJscI8aYkVlalFuXHF5XmpBYfYjQF
        hvZEZinR5HxgPsgriTc0NTI2NrYwMTQzNTRUEudd7+AcIySQnliSmp2aWpBaBNPHxMEp1cDo
        3jBRxa5XZZnF7q18s4Icuu7ezNJQsHR6b++20vqb5Scxt3ufrpsda7vArCHElZ0xuyKL+VeX
        UPe8qLdlC/qVfyRVrX+TUyJy7sdmM/b/sasK/Kql5nC2JCXE2nPefR1euIax6VasVOa1h52b
        Qn5t1GUomm6uKf8mv2ixyU758/z7/tSUMiuxFGckGmoxFxUnAgBCrYVuzwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvK51XnKMwd91jBYbZ6xntZj26TKL
        xbIGVYuzTW/YLW41yFhc3jWHzeJz7xFGi7VH7rJbfN7wmNHiduMKNovDb9pZHbg91sxbw+gx
        u+Eii8fCT19ZPQ6+28Pk0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBk9uy+wFezXrng46zpL
        A+MvpS5GTg4JAROJFWtes3UxcnEICexmlFg6dy4LREJSYtrFo8xdjBxAtrDE4cPFEDVvGSU2
        7NrBCFIjLBAisabvADOILSKQJnGo4TY7SBGzwAlGiW3HTzFBdPQzSXw4PgdsKpuAlsT+FzfY
        QGx+AUWJqz8eg03iFbCTWL5xHVgNi4CqxOQ3DWA1ogIREh+f7mOCqBGUODnzCVgNp4C7xPGX
        s1lBbGYBdYk/8y4xQ9jiEreezGeCsOUlmrfOZp7AKDwLSfssJC2zkLTMQtKygJFlFaNkakFx
        bnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcPxpae5gvLwk/hCjAAejEg/viqNJMUKsiWXFlbmH
        GCU4mJVEeFsSk2OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8z7NOxYpJJCeWJKanZpakFoEk2Xi
        4JRqYIx2id/wtPHK2zS1yVIfZAJy90Wlrg7QWv86ybDQoMdyYkiOttC2X+I+Ch0eWQs+CO94
        Hnx0owELu+/ZmfOn9a3i/9dtd/OW0405RpPC3gq9WdDWl27+UVrV9lD3o9bOlo8WBx7v0P7f
        U+dbPOeUveZmLsHpnyZPS0/Tn/L5cF+zu925pUYnfiixFGckGmoxFxUnAgB1+pG+uwIAAA==
X-CMS-MailID: 20190213010915epcas1p35b7b60f74e030c83703a1a4c51440fe7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
        <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
        <f60efa88-cf43-faed-55be-f90ce8f44f9e@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 12. 오후 9:05, Lukasz Luba wrote:
> Hi Chanwoo
> 
> On 2/12/19 6:46 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> On 19. 2. 12. 오전 12:30, Lukasz Luba wrote:
>>> This patch set changes workqueue related features in devfreq framework.
>>> First patch switches to delayed work instead of deferred.
>>> The second switches to regular system work and deletes custom 'devfreq'.
>>>
>>> Using deferred work in this context might harm the system performance.
>>> When the CPU enters idle, deferred work is not fired. The devfreq device's
>>> utilization does not have to be connected with a particular CPU.
>>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
>>> They all are missing opportunity to check the HW state and react when
>>> the deferred work is not fired.
>>> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
>>> on full speed, might show x5 worse performance if the crucial CPU is in idle.
>>
>> The devfreq framework keeps the balancing between performance
>> and power-consumption. It is wrong to focus on only either
>> performance or power.
> IMO it just does not work, please see my explanation below.
>>
>> This cover-letter focus on the only performance without any power-consumption
>> disadvantages. It is easy to raise the performance with short sampling rate
>> with polling modes. To get the performance, it is good as short as possible
>> of period.
> The cover-letter mentioned about missing functionality. The interface
> has 'polling_ms' field, which driver developer would assume works.
> I have test cases where it would not be called for seconds or even
> never.
> In your driver drivers/devfreq/exynos-bus.c polling_ms = 50
> The driver is controlling many devices including Network-on-Chip (NOC).
> It is using 'simple_ondemand' governor. When it is missing opportunity
> to change the frequency, it can either harm the performance or power
> consumption, depending of the frequency the device stuck on.

Almost everyone knew that DVFS governor is never perfect in the linux kernel. 
I don't want to discuss it with this too generic opinion which doesn't 
include the real measured data.

> 
>>
>> Sometimes, when cpu is idle, the device might require the busy state.
>> It is very difficult to catch the always right timing between them.
> I will try to address them in the next patch set.
>>
>> Also, this patch cannot prevent the unneeded wakeup from idle state.

Please answer this question. 

When release the real mobile product like galaxy phone,
it is very important issue to remove the unneeded wakeup on idle state.


>> Apparently, it only focuses on performance without considering
>> the power-consumption disadvantage. In the embedded device,
>> the power-consumption is very important point. We can not ignore
>> the side effect.
> Power consumption is important, but we cannot rely on randomness
> when we develop core features in a framework.

Sure, I agree that as I commented, the devfreq framework keep
the balancing between performance and power-consumption.

Instead, this patch only focus on the performance without considering
the power-consumption side-effect.

>>
>> Always, I hope to improve the devfreq framwork more that older.
>> But, frankly, it is difficult to agree because it only consider
>> the performance without considering the side-effect.
>>
>> The power management framework always have to consider
>> the power-consumption issue. This point is always true.
> I do agree that the power vs. performance trade-off must be considered
> in the devfreq framework. I have developed 2 additional patches and

You should only mention the posted patches on mailing list.

> I am going to post them today (you can now check them on Tizen gerrit,
> change 198160).

It is not good to mention the some specific gerrit. I just only review
the patches on mailing list. First of all, please answer the question
on above

> 
> We cannot simply pin the *device* load with *CPU* load or idle state.
> It is not an implication.
> The device like GPU, NoC or Dynamic Memory Controller can have
> completely different utilization (i.e in Exynos the GPU is connected
> to DDR memory through NoC and DMC).

In order to get the high performance, the performance of GPU depends on CPU.
h/w have depended on them tightly coupled. So, it is not easy to show
the just relationship between them. We need the comprehensive measured data
for both performance and power-consumption on all cases without the corner cases.

> Some developers who use OpenCL on GPU might be interested in this
> improvement.> 
> Thank you for participating in the discussion on this issue.
> It will need more development and iterations.
> In my opinion currently there is one bug in the devfreq and one missing
> feature to solve.
> 
> Regards,
> Lukasz
> 
>>
>>>
>>> Changes:
>>> v2:
>>> - single patch split into two
>>> - added cover letter
>>>
>>> link for the previous version and discussion:
>>> https://marc.info/?l=linux-pm&m=154904631226997&w=2
>>>
>>> Regards,
>>> Lukasz Luba
>>>
>>> Lukasz Luba (2):
>>>    drivers: devfreq: change devfreq workqueue mechanism
>>>    drivers: devfreq: change deferred work into delayed
>>>
>>>   drivers/devfreq/devfreq.c | 27 +++++++--------------------
>>>   1 file changed, 7 insertions(+), 20 deletions(-)
>>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
