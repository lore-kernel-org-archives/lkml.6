Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5A8C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F94208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 07:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pyLR8BM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F94208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932459AbeFUH6z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 03:58:55 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:42272 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754280AbeFUH6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 03:58:52 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180621075850epoutp0226f0ac7f40e25a710db37d37857f12ab~6He3KfQBZ2555525555epoutp02N;
        Thu, 21 Jun 2018 07:58:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180621075850epoutp0226f0ac7f40e25a710db37d37857f12ab~6He3KfQBZ2555525555epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529567930;
        bh=kKFjBmX0/uPkDaTo0kUV1r+H+P71AAegaY+8bVY/sKU=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=pyLR8BM2mSs22e81L4AANfvayuyqjj23sNsq97aAZiFo/FYLqk5KuzOduIu1pHIO2
         mMmQAFuZA95txyaLXHcYMeKExrZsnifX6UpKrbKn6fUrmMMv7+dY9QzKGhxEwpmNkI
         aH8Lt/4aUDboJI+oKj3kPG1LR+ZJ6i01eqtyJyv4=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180621075848epcas1p31c49944b95d36e64225d4f255b03e700~6He09p7rL1106911069epcas1p3S;
        Thu, 21 Jun 2018 07:58:48 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.70.04343.5BA5B2B5; Thu, 21 Jun 2018 16:58:45 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180621075845epcas1p3cfe5497f1ea7345d6625fbd60228bbd6~6HeyUA6LW1534015340epcas1p3h;
        Thu, 21 Jun 2018 07:58:45 +0000 (GMT)
X-AuditID: b6c32a38-78bff700000010f7-f9-5b2b5ab5c7f5
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.AE.03915.5BA5B2B5; Thu, 21 Jun 2018 16:58:45 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PAN0026JY5WPEB0@mmp1.samsung.com>; Thu, 21 Jun 2018 16:58:45 +0900 (KST)
Message-id: <5B2B5AB4.4020003@samsung.com>
Date:   Thu, 21 Jun 2018 16:58:44 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        cwchoi00@gmail.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PM / devfreq: Fix devfreq_add_device() when drivers are
 built as modules.
In-reply-to: <9186fc15-c884-a67b-e2fb-113721613146@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmru7WKO1og1VdmhbPjmpbXPi9ks1i
        ze1DjBabz/WwWpxtesNucXnXHDaLz71HGC1uN65gc+Dw2HF3CaPHzll32T36tqxi9Pi8SS6A
        JSrVJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoCiWF
        ssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVK0oaGRnqGBuZ6REZA2jrUyMgUqSUjNmHnlPnvB
        V8eKO8d/sDYwLjfoYuTkkBAwkfj07w1bFyMXh5DADkaJ/XNus0M434GcCRvZYaparvcwQyR2
        M0p8aZjGBpLgFRCU+DH5HksXIwcHs4C8xJFL2SBhZgFNiRdfJrGA2EICdxklrr63gSjXknj2
        YRUjiM0ioCpx7NsJVhCbDSi+/8UNsJH8AooSV388BqsRFYiQ2Dn/G9gNIgLVEhc+32cCuYFZ
        4DijRNfPn8wgCWGBBIm2891gzZwCjhI9Sx+CFUkInGCTWLvvFCvEBy4Slx99Z4OwhSVeHd/C
        DnK0hIC0xKWjthD17UCPvWhmhXAmMEp8OLWZCaLBWOLZwi4miNf4JN597WGFaOaV6GgTgijx
        kDjyppsJEkKbmCXuvDzJPoFRdhZSIM1CBNIspEBawMi8ilEstaA4Nz212LDARK84Mbe4NC9d
        Lzk/dxMjOLFpWexg3HPO5xCjAAejEg/vjTCtaCHWxLLiytxDjBIczEoivOdMtKOFeFMSK6tS
        i/Lji0pzUosPMZoCA3kis5Rocj4w6eaVxBuaGhkbG1uYGJqZGhoqifNW3BSIFhJITyxJzU5N
        LUgtgulj4uCUamBseisntf7wBJO0tkcLl1XOvyYZcEyBS2n101Oxwj9quo67LPuVvXkz//8/
        22oPH8ufJJcYeE73wJxJ8WbW73qXygjOup9yUmfitSnTWReJbvtSI6ezMHDZ94t/qy/fj5Wf
        u+NnXvi187fYXrX4aketXcbGm6T69/u3eQzxm1Z+nVzpdqf8JgNDmhJLcUaioRZzUXEiAKlg
        QtWCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsVy+t9jAd2tUdrRBjsOClk8O6ptceH3SjaL
        NbcPMVpsPtfDanG26Q27xeVdc9gsPvceYbS43biCzYHDY8fdJYweO2fdZffo27KK0ePzJrkA
        ligum5TUnMyy1CJ9uwSujJlX7rMXfHWsuHP8B2sD43KDLkZODgkBE4mW6z3MXYxcHEICOxkl
        3m37ywKS4BUQlPgx+R6QzcHBLCAvceRSNoSpLjFlSi5E+X1GiY8TVzFClGtJPPsAYbMIqEoc
        +3aCFcRmA4rvf3GDDcTmF1CUuPrjMSPIHFGBCInuE5UgYRGBaonjN84zgcxkFjjJKHFsQTPY
        HGGBBIm2891gvUICm5gl9rQIgNicAo4SPUsfMk1gFJiF5NJZCJfOQrh0ASPzKkbJ1ILi3PTc
        YqMCw7zUcr3ixNzi0rx0veT83E2MwCDfdlirbwfj/SXxhxgFOBiVeHhvhGlFC7EmlhVX5h5i
        lOBgVhLhPWeiHS3Em5JYWZValB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMH
        p1QDo96TI+4VqrdvHClwaU9VUK6f8fDCnsmlPdJ9tvXMwieLv/vtL77dniQpX/QifEKGln2I
        Q9oGg/lb5iznML3apzL1zqOrrHuYZRlnKgkLGPSe6VzW0htc/WfW+k+z/kUFFQZzcOiHxwt9
        /R68RWb/QoGvURYmjy97JuydvEHeh++g7YqHK66tVWIpzkg01GIuKk4EAEQQcJxuAgAA
X-CMS-MailID: 20180621075845epcas1p3cfe5497f1ea7345d6625fbd60228bbd6
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180619082320epcas5p228d76c9e326d24acc1c38b43ff152347
References: <20180615100452.17466-1-enric.balletbo@collabora.com>
        <CAGTfZH1QkzBjDPfsS23DgVF=EqO1P9RK+YdAnAwt2rDL6eGPTg@mail.gmail.com>
        <CAFqH_5344NDHup+u0QtimTJjKaVVj46YB6UDMKtdMr70JJmkng@mail.gmail.com>
        <CGME20180619082320epcas5p228d76c9e326d24acc1c38b43ff152347@epcas5p2.samsung.com>
        <7eff02c1-3d78-de08-19ab-a4a45c491a86@collabora.com>
        <5B29A43E.2080402@samsung.com>
        <9186fc15-c884-a67b-e2fb-113721613146@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2018년 06월 20일 19:32, Enric Balletbo i Serra wrote:
> Hi Chanwoo,
> 
> On 20/06/18 02:47, Chanwoo Choi wrote:
>> Hi Enric,
>>
>> On 2018년 06월 19일 17:22, Enric Balletbo i Serra wrote:
>>> Hi Chanwoo,
>>>
>>> On 18/06/18 11:02, Enric Balletbo Serra wrote:
>>>> Hi Chanwoo,
>>>> Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de juny
>>>> 2018 a les 5:50:
>>>>>
>>>>> Hi Enric,
>>>>>
>>>>> This issue will happen on the position to use find_devfreq_governor()
>>>>> as following:
>>>>> - devfreq_add_governora() and governor_store()
>>>>>
>>>>> If device driver with module type after loaded want to change the
>>>>> scaling governor,
>>>>> new governor might be not yet loaded. So, devfreq bettero to consider this case
>>>>> in the find_devfreq_governor().
>>>>>
>>>> Ok, I'll move there and send a v2.
>>>>
>>>
>>> I tried your suggestion but I found one problem, if I move the code in
>>> find_devfreq_governor it end up with a deadlock. The reason is the following calls.
>>>
>>> devfreq_add_device
>>>   find_devfreq_governor (!!!)
>>>     request_module
>>>        devfreq_simple_ondemand_init
>>>           devfreq_add_governor
>>>              find_devfreq_governor (DEADLOCK)
>>>
>>> So I am wondering if shouldn't be more easy fix the issue in both places,
>>> devfreq_add_device and governor_store.
>>>
>>> To devfreq_add_device
>>>
>>> devfreq_add_device
>>>   governor = find_devfreq_governor
>>>   if (IS_ERR(governor) {
>>
>> In this error case, you have to unlock the mutex
>> before calling the request_module(). I added the pseudo code
>> of my opinion.
>>
>>>      request_module
>>>      governor = find_devfreq_governor
>>>      if (IS_ERR(governor)
>>>        return ERR_PTR(governor)
>>>   }
>>>
>>> And the same for governor_store
>>>
>>> governor_store
>>>   governor = find_devfreq_governor
>>>   if (IS_ERR(governor) {
>>>      request_module
>>>      governor = find_devfreq_governor
>>>      if (IS_ERR(governor)
>>>        return ERR_PTR(governor)
>>>   }
>>>
>>> Maybe all  can go in a new function try_find_devfreq_governor_then_request
>>
>> How about modify the find_devfreq_governor() as following?
>> I think that it is possible because previous find_devfreq_governor()
>> always check whether mutex is locked or not.
>>
>> 	find_devfreq_governor() {
>>
>> 		// check whether mutex is locked or not		
>> 		if (!mutex_is_lock(&devfreq_list_lock)) {
>> 			WARN(...)
>> 			return -EINVAL
>> 		}
>>
>> 		// find the registered governor with list_for_each_entry
>>
>> 		if (governor is not loaded) {
>> 			mutex_unlock()
>> 			request_module()
> 
> Then the problem is that the find_devfreq_governor is reentrant because the init
> function of the governor calls devfreq_add_governor and find_devfreq_governor
> again. E.g for simpleondemand governor you will get this loop.
> 
> find_devfreq_governor
>   -> request_module
>       -> devfreq_simple_ondemand_init
>          -> devfreq_add_governor
>             -> find_devfreq_governor
>                -> request_module
>                   -> devfreq_simple_ondemand_init
>                      -> devfreq_add_governor
>                         -> find_devfreq_governor
>                            -> request_module
>                               ...
> 
> Makes sense or I am missing something and there is a way to quit from this loop?

You're right. Sorry, my wrong opinion steals your time.

> 
> FWIW I checked how the cpufreq driver does this as it should have the same
> problem. The find_governor function is just a simple search and instead of
> integrating the request_module inside the find_governor function they have a
> cpu_parse_governor that calls request module from the userspace call and from
> the init call.

Also, I checked the cpufreq's case. We better to make the separate function 
like cpufreq_parse_governor() in cpufreq subsystem.

> 
> store_scaling_governor
>   -> cpu_parse_governor
>      -> request_module
> 
> cpufreq_add_dev_interface
>   -> cpu_freq_init_policy
>      -> cpu_parse_governor
>         -> request_module
> 
> Thanks,
> - Enric
> 
>> 			mutex_lock()	
>> 		}
>>
>> 	}
>>
>>
>>>
>>> Other suggestions?
>>>
>>> - Enric
>>>
>>>> Thanks
>>>>  Enric.
>>>>
>>>>
>>>>> 2018-06-15 19:04 GMT+09:00 Enric Balletbo i Serra
>>>>> <enric.balletbo@collabora.com>:
>>>>>> When the devfreq driver and the governor driver are built as modules,
>>>>>> the call to devfreq_add_device() fails because the governor driver is
>>>>>> not loaded at the time the devfreq driver loads. The devfreq driver has
>>>>>> a build dependency on the governor but also should have a runtime
>>>>>> dependency. We need to make sure that the governor driver is loaded
>>>>>> before the devfreq driver.
>>>>>>
>>>>>> This patch fixes this bug in devfreq_add_device(). First tries to find
>>>>>> the governor, and then, if was not found, it requests the module and
>>>>>> tries again.
>>>>>>
>>>>>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
>>>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>>>> ---
>>>>>>
>>>>>>  drivers/devfreq/devfreq.c | 36 +++++++++++++++++++++++++++++++-----
>>>>>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>>> index fe2af6aa88fc..1d917f043e30 100644
>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>> @@ -11,6 +11,7 @@
>>>>>>   */
>>>>>>
>>>>>>  #include <linux/kernel.h>
>>>>>> +#include <linux/kmod.h>
>>>>>>  #include <linux/sched.h>
>>>>>>  #include <linux/errno.h>
>>>>>>  #include <linux/err.h>
>>>>>> @@ -648,10 +649,35 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>
>>>>>>         governor = find_devfreq_governor(devfreq->governor_name);
>>>>>>         if (IS_ERR(governor)) {
>>>>>> -               dev_err(dev, "%s: Unable to find governor for the device\n",
>>>>>> -                       __func__);
>>>>>> -               err = PTR_ERR(governor);
>>>>>> -               goto err_init;
>>>>>> +               list_del(&devfreq->node);
>>>>>> +               mutex_unlock(&devfreq_list_lock);
>>>>>> +
>>>>>> +               /*
>>>>>> +                * If the governor is not found, then request the module and
>>>>>> +                * try again. This can happen when both drivers (the governor
>>>>>> +                * driver and the driver that calls devfreq_add_device) are
>>>>>> +                * built as modules.
>>>>>> +                */
>>>>>> +               if (!strncmp(devfreq->governor_name,
>>>>>> +                            DEVFREQ_GOV_SIMPLE_ONDEMAND, DEVFREQ_NAME_LEN))
>>>>>> +                       err = request_module("governor_%s", "simpleondemand");
>>>>>> +               else
>>>>>> +                       err = request_module("governor_%s",
>>>>>> +                                            devfreq->governor_name);
>>>>>> +               if (err)
>>>>>> +                       goto err_unregister;
>>>>>> +
>>>>>> +               mutex_lock(&devfreq_list_lock);
>>>>>> +               list_add(&devfreq->node, &devfreq_list);
>>>>>> +
>>>>>> +               governor = find_devfreq_governor(devfreq->governor_name);
>>>>>> +               if (IS_ERR(governor)) {
>>>>>> +                       dev_err(dev,
>>>>>> +                               "%s: Unable to find governor for the device\n",
>>>>>> +                               __func__);
>>>>>> +                       err = PTR_ERR(governor);
>>>>>> +                       goto err_init;
>>>>>> +               }
>>>>>>         }
>>>>>>
>>>>>>         devfreq->governor = governor;
>>>>>> @@ -669,7 +695,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>>  err_init:
>>>>>>         list_del(&devfreq->node);
>>>>>>         mutex_unlock(&devfreq_list_lock);
>>>>>> -
>>>>>> +err_unregister:
>>>>>>         device_unregister(&devfreq->dev);
>>>>>>  err_dev:
>>>>>>         if (devfreq)
>>>>>> --
>>>>>> 2.17.1
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Best Regards,
>>>>> Chanwoo Choi
>>>>> Samsung Electronics
>>>>
>>>
>>>
>>>
>>
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
