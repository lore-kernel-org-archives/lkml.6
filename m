Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A565C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21B921904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HdWtmJis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfBNEAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:00:42 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:39482 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfBNEAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:00:41 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190214040037epoutp0223cc392b7eaf6ccf2932766c98a6e24c~DHw0FVDkQ1760717607epoutp02k
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 04:00:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190214040037epoutp0223cc392b7eaf6ccf2932766c98a6e24c~DHw0FVDkQ1760717607epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550116837;
        bh=isR0QyBZ/XJK1/S8mw5vNeyapyJKynDjnM6PG1W1fUI=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=HdWtmJis0BRPlJfg56IfMaei63eAiSui5AP2Liv/cw7yYelpk+S3c7Dk7dxIncd5G
         ClmNYd9OA6hpl7jjyLO6w0TiMLdQ4AP1DRR6tcmBz6s3xI3nYerEgkUOlxmcfz0KJw
         z1EeqLJvEdlzHVxiXNkaMQiZOdJmpu5gw7116S1k=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190214040035epcas1p2afadb99d29454164e61f00530ece93b2~DHwxw1t4E1102611026epcas1p27;
        Thu, 14 Feb 2019 04:00:35 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.86.04074.2E7E46C5; Thu, 14 Feb 2019 13:00:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190214040034epcas1p2e3dd3c7080439772b6ebe531f7835cf1~DHwxC-Lrx1103311033epcas1p2i;
        Thu, 14 Feb 2019 04:00:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190214040034epsmtrp25eda182c22b664d4e0b5607d33576e76~DHwxBqno02664626646epsmtrp2s;
        Thu, 14 Feb 2019 04:00:34 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-9f-5c64e7e215ce
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.AC.03971.2E7E46C5; Thu, 14 Feb 2019 13:00:34 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190214040034epsmtip198897613b4e9be7b349d7291b4895987~DHwwzycW03114031140epsmtip1W;
        Thu, 14 Feb 2019 04:00:34 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, joel@joelfernandes.org,
        chris.diamand@arm.com, mka@chromium.org
Organization: Samsung Electronics
Message-ID: <d0cd3ee1-0472-e3ff-8119-95889c41f994@samsung.com>
Date:   Thu, 14 Feb 2019 13:00:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <376d00b9-0635-539a-3106-f83baa2e15ea@partner.samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmge7j5ykxBkfMLTbOWM9qMe3TZRaL
        ZQ2qFmeb3rBb3GqQsbi8aw6bxefeI4wWa4/cZbf4vOExo8XtxhVsFofftLM6cHusmbeG0WN2
        w0UWj4WfvrJ6HHy3h8mjb8sqRo/Pm+QC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
        dQ0tLcyVFPISc1NtlVx8AnTdMnOAjlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTk
        FFgW6BUn5haX5qXrJefnWhkaGBiZAhUmZGfsuLaUteB3YMXJVTUNjD8duxg5OCQETCTOf9Xt
        YuTiEBLYwSixf/YiVgjnE6PEyUNLGCGcb4wSS9dcYO9i5ATr6OkCqeIESuxllLjYWwpR9J5R
        YuPJi8wgCTYBLYn9L26wgdjCAiESa/oOgMVFBNIk3rbfZQKxmQVOMEr0TLQCsfkFFCWu/njM
        CGLzCthJnLv7AsxmEVCV2HH0E9gcUYEIicO976BqBCVOznzCAmJzCrhLNL2YwA4xU1zi1pP5
        UPPlJZq3zmYGOU5CYDK7xPuFXSwQH7hIHN6xkhXCFpZ4dXwL1GdSEp/f7WWDsKslVp48wgbR
        3MEosWX/BagGY4n9SyczgQKPWUBTYv0ufYhlfBLvvvawQsKUV6KjTQiiWlni8gOIfyUEJCUW
        t3dCjfeQeHF0PesERsVZSN6ZheSFWUhemIWwbAEjyypGsdSC4tz01GLDAkPkuN7ECE62WqY7
        GKec8znEKMDBqMTDWyGUEiPEmlhWXJl7iFGCg1lJhHf3I6AQb0piZVVqUX58UWlOavEhRlNg
        aE9klhJNzgdmgrySeENTI2NjYwsTQzNTQ0Mlcd71Ds4xQgLpiSWp2ampBalFMH1MHJxSDYx2
        DBw/bzs5s7ZsCfpybYvMxSux/3Rk/r/+cNirKn2BFs9z9Rwn6Z1SC7omv3gy9VapXtyb58u+
        HoiYuV3JO1Jq3qcLYnblW3742c7MVZvt6b5Hj1+Bb/eRumPKX3ZVvhCO6dx5poztuJ/HxhnG
        D54wev5R5plicSfXeOusnkVvwrJaXH3FRH4rsRRnJBpqMRcVJwIAcxO1OcwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSnO6j5ykxBjc+clpsnLGe1WLap8ss
        FssaVC3ONr1ht7jVIGNxedccNovPvUcYLdYeuctu8XnDY0aL240r2CwOv2lndeD2WDNvDaPH
        7IaLLB4LP31l9Tj4bg+TR9+WVYwenzfJBbBFcdmkpOZklqUW6dslcGXsuLaUteB3YMXJVTUN
        jD8duxg5OSQETCR6uhaxdjFycQgJ7GaUuHS9nw0iISkx7eJR5i5GDiBbWOLw4WKImreMErc2
        LWIEqWET0JLY/+IGWL2wQIjEmr4DzCC2iECaxKGG2+wgDcwCJxglth0/xQTR3cgssfbeXiaQ
        Kn4BRYmrPx6DTeIVsJM4d/cFmM0ioCqx4+gnsKmiAhESH5/uY4KoEZQ4OfMJC4jNKeAu0fRi
        AjuIzSygLvFn3iVmCFtc4taT+UwQtrxE89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjO
        Tc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjj4tzR2Ml5fEH2IU4GBU4uGtEEqJEWJNLCuuzD3E
        KMHBrCTCu/sRUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjv07xjkUIC6YklqdmpqQWpRTBZJg5O
        qQZGfTOxT/7n9Gcv7T7zeTn3YtVTX+fMZSuZ250++VBpbeNqwYb8/zN/CGusnmX5SDUmu/WO
        SOv+/vyYUP6JSjseaJt4eCUbOqYcCEvcXfZ6/eRTqdyPWX9m2uumvE9/G7rjs2B95pEPJTIS
        i1rlMxyl9giG/bwzyyEt7BHfpc6MlVqVOfcsX8YqsRRnJBpqMRcVJwIASw++8LoCAAA=
X-CMS-MailID: 20190214040034epcas1p2e3dd3c7080439772b6ebe531f7835cf1
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
        <815961f8-f9c3-6d26-8811-880e4cd76cb9@samsung.com>
        <376d00b9-0635-539a-3106-f83baa2e15ea@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 19. 2. 13. 오후 7:47, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 2/13/19 2:09 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> On 19. 2. 12. 오후 9:05, Lukasz Luba wrote:
>>> Hi Chanwoo
>>>
>>> On 2/12/19 6:46 AM, Chanwoo Choi wrote:
>>>> Hi Lukasz,
>>>>
>>>> On 19. 2. 12. 오전 12:30, Lukasz Luba wrote:
>>>>> This patch set changes workqueue related features in devfreq framework.
>>>>> First patch switches to delayed work instead of deferred.
>>>>> The second switches to regular system work and deletes custom 'devfreq'.
>>>>>
>>>>> Using deferred work in this context might harm the system performance.
>>>>> When the CPU enters idle, deferred work is not fired. The devfreq device's
>>>>> utilization does not have to be connected with a particular CPU.
>>>>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
>>>>> They all are missing opportunity to check the HW state and react when
>>>>> the deferred work is not fired.
>>>>> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
>>>>> on full speed, might show x5 worse performance if the crucial CPU is in idle.
>>>>
>>>> The devfreq framework keeps the balancing between performance
>>>> and power-consumption. It is wrong to focus on only either
>>>> performance or power.
>>> IMO it just does not work, please see my explanation below.
>>>>
>>>> This cover-letter focus on the only performance without any power-consumption
>>>> disadvantages. It is easy to raise the performance with short sampling rate
>>>> with polling modes. To get the performance, it is good as short as possible
>>>> of period.
>>> The cover-letter mentioned about missing functionality. The interface
>>> has 'polling_ms' field, which driver developer would assume works.
>>> I have test cases where it would not be called for seconds or even
>>> never.
>>> In your driver drivers/devfreq/exynos-bus.c polling_ms = 50
>>> The driver is controlling many devices including Network-on-Chip (NOC).
>>> It is using 'simple_ondemand' governor. When it is missing opportunity
>>> to change the frequency, it can either harm the performance or power
>>> consumption, depending of the frequency the device stuck on.
>>
>> Almost everyone knew that DVFS governor is never perfect in the linux kernel.
>> I don't want to discuss it with this too generic opinion which doesn't
>> include the real measured data.
>>
>>>
>>>>
>>>> Sometimes, when cpu is idle, the device might require the busy state.
>>>> It is very difficult to catch the always right timing between them.
>>> I will try to address them in the next patch set.
>>>>
>>>> Also, this patch cannot prevent the unneeded wakeup from idle state.
>>
>> Please answer this question.
>>
>> When release the real mobile product like galaxy phone,
>> it is very important issue to remove the unneeded wakeup on idle state.
> I would say that these devfreq wake-ups are important and people thought
> that they are periodic and rely on it. Since the devfreq does not have
> trace events no one knew what is actually happening inside.

I agree that adding the trace events for devfreq.

But, just I mentioned the 'unneeded wakeup from idle state'.
As I already replied on patch, v2 patchset don't provide
the any tunable interface for the kind of work. 

The v2 patches just changed the work from deferrable to delayed.
Someone want to keep the deferrable or someone want to use
the periodic without considering idle. 

But, in this series, just remove the deferrable work
without any choice. It is my point to discuss your patch.


> Profiling the whole devfreq framework just for one product is not fair.
> The devfreq clients are not only mobiles, there are other type of
> embedded devices. There are embedded devices (based on TI, iMX, etc)
> which are not powered from battery and are used i.e. for streaming video
> from camera or image recognition.

I agree absolutely. There are many kind of embedded devices.
For one embedded device, I don't want to remove the previous benefit.

To remove the any confusion, I mention my opinion once again.

It is not proper to just remove the deferrable work
without any tunable interface. Instead, if devfreq
framework supports both deferrable and delayed work
according to tunable interface, I agree.


>>
>>
>>>> Apparently, it only focuses on performance without considering
>>>> the power-consumption disadvantage. In the embedded device,
>>>> the power-consumption is very important point. We can not ignore
>>>> the side effect.
>>> Power consumption is important, but we cannot rely on randomness
>>> when we develop core features in a framework.
>>
>> Sure, I agree that as I commented, the devfreq framework keep
>> the balancing between performance and power-consumption.
>>
>> Instead, this patch only focus on the performance without considering
>> the power-consumption side-effect.
> Please refer to patch set v3 which tries to address battery power
> devices.

I didn't object to send next patches.
But, Without any agreement and enough discussion on this series,
you just sent next patches. It is not proper for review sequence. 

> 
>>
>>>>
>>>> Always, I hope to improve the devfreq framwork more that older.
>>>> But, frankly, it is difficult to agree because it only consider
>>>> the performance without considering the side-effect.
>>>>
>>>> The power management framework always have to consider
>>>> the power-consumption issue. This point is always true.
>>> I do agree that the power vs. performance trade-off must be considered
>>> in the devfreq framework. I have developed 2 additional patches and
>>
>> You should only mention the posted patches on mailing list.
> The patches are now posted on LKLM as v3 (after ~7h).
> Frankly, I do not understand your behavior.
> You were explicitly added on the review on Tizen kernel
> on these patches (from 21 Jan) before even discussion on LKLM

As I mentioned, I only want to discuss something on mailing list.

> happen. There was a few iteration and good review.
> I just wanted to say that it was verified and questions about
> power usage also appeared.> 
> Secondly, people are referring to different patches in Android
> kernel, ARM EAS kernel or like Matthias to LineageOS.
> They are even referring to some research papers or trace analyses.
> I have mentioned these patches and said that the same day they will
> be posted on LKLM (which actually happen) because they were ready.

You seem to misunderstand.

I only mentioned that didn't agree to remove the deferrable work
without considering the any side-effect and any tunable interface
in order to use the deferrable work.

>>
>>> I am going to post them today (you can now check them on Tizen gerrit,
>>> change 198160).
>>
>> It is not good to mention the some specific gerrit. I just only review
>> the patches on mailing list. First of all, please answer the question
>> on above
> I have already replayed: devfreq is broken, drivers for GPUs, buses
> cannot rely on it. Cost of a fix is in corner case: waking up CPU
> a few times per second. Result: reliable periodic callback for drivers.
> The way how it is implemented in v3 provides a tunable for driver

As I commented already, 
I don't want to just remove the deferrable work and change
the style of timer from deferrable to delayed work.

Instead, if devfreq framework supports both deferrable
and delayed work without considering the idle state
according to tunable interface, I agree.

> developer which saves some power when the device is less utilized:
> 'polling_idle_ms'.
> Thermal framework also has two polling intervals: longer when the
> temperature is lower than threshold (i.e. 1s) and shorter when the
> temperature crosses threshold (i.e. 100ms).

Actullay, there is critical different between thermal and DVFS framework
like cpufreq, devfreq. 

If thermal framework doesn't check the temperature on idle state,
it may cause the critical problem of embedded board or SoC.
Because the external reasons can affect and raise the temperature
of embedded board or SoC even if the system is on idle state.

> Suggestion from Matthias that we could use power efficient wq
> would have to involve changes in configs and verifications on
> probably a lot of ARM platforms.
>>
>>>
>>> We cannot simply pin the *device* load with *CPU* load or idle state.
>>> It is not an implication.
>>> The device like GPU, NoC or Dynamic Memory Controller can have
>>> completely different utilization (i.e in Exynos the GPU is connected
>>> to DDR memory through NoC and DMC).
>>
>> In order to get the high performance, the performance of GPU depends on CPU.
>> h/w have depended on them tightly coupled. So, it is not easy to show
>> the just relationship between them. We need the comprehensive measured data
>> for both performance and power-consumption on all cases without the corner cases.
> Are you sure that the fully loaded GPU implies that all CPUs are not in
> idle? What about tasks pinned to CPU cgroups?
> I will try create some small OpenCL kernel for Odroid XU4 and verify it.
> 
> The current devfreq implementation is missing trace events.
> I have posted in v3 basic support. It would be a good starting point
> for measurements and analysis.
> 
> Regards,
> Lukasz
>>
>>> Some developers who use OpenCL on GPU might be interested in this
>>> improvement.>
>>> Thank you for participating in the discussion on this issue.
>>> It will need more development and iterations.
>>> In my opinion currently there is one bug in the devfreq and one missing
>>> feature to solve.
>>>
>>> Regards,
>>> Lukasz
>>>
>>>>
>>>>>
>>>>> Changes:
>>>>> v2:
>>>>> - single patch split into two
>>>>> - added cover letter
>>>>>
>>>>> link for the previous version and discussion:
>>>>> https://marc.info/?l=linux-pm&m=154904631226997&w=2
>>>>>
>>>>> Regards,
>>>>> Lukasz Luba
>>>>>
>>>>> Lukasz Luba (2):
>>>>>     drivers: devfreq: change devfreq workqueue mechanism
>>>>>     drivers: devfreq: change deferred work into delayed
>>>>>
>>>>>    drivers/devfreq/devfreq.c | 27 +++++++--------------------
>>>>>    1 file changed, 7 insertions(+), 20 deletions(-)
>>>>>
>>>>
>>>>
>>>
>>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
