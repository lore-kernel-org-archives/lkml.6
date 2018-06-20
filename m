Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0738AC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B80320693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hUBcjZDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B80320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeFTAsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:48:09 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:49951 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeFTAsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:48:06 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180620004803epoutp019cd44048e2118f32f9d5c569e2ca06f8~5t9c_jbor1953219532epoutp01f;
        Wed, 20 Jun 2018 00:48:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180620004803epoutp019cd44048e2118f32f9d5c569e2ca06f8~5t9c_jbor1953219532epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529455683;
        bh=QIaimuAztCRzx+lFhXiyeE1XXNWjvECfB4hzueEhcjo=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=hUBcjZDEmlBfINLO03km85Kl08Sg7pZaVq2yuJxuvRxQ0sA1rGRdLSRGOGQFVXyEP
         lIj6ZaEUTMlA3Aqb9P+7JAklbruFw5i2nSsePtJ0RlcMiPgHkG9PZ3FQxDQjGsYzCb
         0MQVpZ4k/ox9x/EwmBl1H7pNNYY6rbw1jFqf2EB0=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180620004800epcas1p1c74567b1e9aee3510ff55ddfea19e243~5t9aMLJ6e0385103851epcas1p1o;
        Wed, 20 Jun 2018 00:48:00 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.A3.04076.F34A92B5; Wed, 20 Jun 2018 09:47:59 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180620004759epcas1p1ab9f0f2f4c355e69b2072b50e96ce550~5t9Y4pXkC2337323373epcas1p1Y;
        Wed, 20 Jun 2018 00:47:59 +0000 (GMT)
X-AuditID: b6c32a37-a59ff70000000fec-ce-5b29a43fb963
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.CD.03915.F34A92B5; Wed, 20 Jun 2018 09:47:59 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PAL00F2XJJYOG10@mmp1.samsung.com>; Wed, 20 Jun 2018 09:47:58 +0900 (KST)
Message-id: <5B29A43E.2080402@samsung.com>
Date:   Wed, 20 Jun 2018 09:47:58 +0900
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
In-reply-to: <7eff02c1-3d78-de08-19ab-a4a45c491a86@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURjHPbt32524uk2tg1HqjaBZrt3N6S1cLxQ1ykLoSzRqXfUyrb21
        u4nVl8qwmM6WQdB6MUEqSypURIuy1mo2aokaWaYWK5EojaY5K6Ld3SI/nf95zu9/eJ4/D4bI
        JoRpWJnFwdgttIkQJaLtj+TZ2Wsb5XrlyMf51Ojj5VTPzyYR1TzoA1RrqEZIPT/2WUz13bkg
        oiJuP6AGj14TrcN0HUONQNfpHRLratuuA12kZXEhuovJL2XoEsaewViKrSVlFqOW2LrDsMGg
        yVWS2eQqKo/IsNBmRktsLCjM3lRminVBZJTTJmesVEizLLFyTb7d6nQwGaVW1qEl9CSpUpDK
        PIVKFTvVu1erNDFkL1PqvtKE2PrIih+9feAImFjiAhIM4jnw9+8uoQskYjK8A8DmQETAX6YB
        DN14K3YBLE49qHTy9bsAuqejIs4txefB6JlhlGMQPB36e/dzZQSXw7HJOpTnhwCc6g4LeD4L
        XuxpFXIaxZfC+nf9KKdFsXrX2ED8z7l4JnwZDQNOp+I7YWf9dzGnU/DDsCcyEm8OwQMAumZm
        EO4hGd8Lq15Ux80SfD2s/TaKcBDEn4ng4KlfgJ9zI3w/dhzldTL8FGj7O9lC2PtYy/MnAJwc
        qxTyFw+AX4OtAt6ghqMNLgE/2xw4PlUj5M1SeLJKxiM66P9c/Te6NwLY/XoA9YBF3lkpef+n
        5J2V0mWAXAfzGRtrNjIsaVMrWNrMOi1GRbHV3ALiy5aV1wFuhwp8AMcAkSRNQOR6mZAuZw+a
        fQBiCJEiTQgu08ukJfTBQ4zdarA7TQzrA5pYyKeRtNRia2x1LQ4DqVGp1Woqh8zVkCSxQFrx
        GtfLcCPtYPYzjI2x//MJMEnaEWAfnk66Gd13Q6IxfQheSd7jcydoX5HbM4vOVYY849t8yG7b
        fbenHvS0j54fbKBXO8R7zqtWejvvGGrVO7rCz1QHln5p32z6KUo3ucXNZlPKm/5bD08lWZ9e
        zdzyxF93b1dZOC+sDNSdlacX5fdvTd68ItBQn/ir8lLFhmDfhDCHQNlSmsxC7Cz9B2B5xUaC
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsVy+t9jAV37JZrRBs+bOSyeHdW2uPB7JZvF
        mtuHGC02n+thtTjb9Ibd4vKuOWwWn3uPMFrcblzB5sDhsePuEkaPnbPusnv0bVnF6PF5k1wA
        SxSXTUpqTmZZapG+XQJXRu+ylcwFlw0rfl26zNjA+F65i5GDQ0LAROJAc2kXIxeHkMBORolt
        Dw+ydjFycvAKCEr8mHyPBaSGWUBe4silbAhTXWLKlFyI8vuMEj0/etghyrUk5l7YDNbKIqAq
        Mf/BFRYQmw0ovv/FDTYQm19AUeLqj8eMIHNEBSIkuk9UgoRFBKoljt84zwQyk1ngJKPEsQXN
        jCAJYYEEibbz3WwQy24xSRydMAMswSngKNH36RnzBEaBWUhOnYVw6iyEUxcwMq9ilEwtKM5N
        zy02KjDMSy3XK07MLS7NS9dLzs/dxAgM8m2Htfp2MN5fEn+IUYCDUYmHl4FZM1qINbGsuDL3
        EKMEB7OSCC/DKY1oId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry3845FCgmkJ5akZqemFqQWwWSZ
        ODilGhjnMNTnXvGRqOU8++Lsp41HJqTcfJSie43p85ykf08excevUk0wP7J0I4OytOTGv5tO
        X9gmeOj1rpMzHnQKv71QrJKR8YzXlGmD2t2AfvfZXeJTbPWFrjXWXVruskzohuke9Vvlq86Z
        pn/61DTDq/214Mz5d5gV80MzP/BfELT+OZ9j9o2caWs2K7EUZyQaajEXFScCAByfKYhuAgAA
X-CMS-MailID: 20180620004759epcas1p1ab9f0f2f4c355e69b2072b50e96ce550
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2018년 06월 19일 17:22, Enric Balletbo i Serra wrote:
> Hi Chanwoo,
> 
> On 18/06/18 11:02, Enric Balletbo Serra wrote:
>> Hi Chanwoo,
>> Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de juny
>> 2018 a les 5:50:
>>>
>>> Hi Enric,
>>>
>>> This issue will happen on the position to use find_devfreq_governor()
>>> as following:
>>> - devfreq_add_governora() and governor_store()
>>>
>>> If device driver with module type after loaded want to change the
>>> scaling governor,
>>> new governor might be not yet loaded. So, devfreq bettero to consider this case
>>> in the find_devfreq_governor().
>>>
>> Ok, I'll move there and send a v2.
>>
> 
> I tried your suggestion but I found one problem, if I move the code in
> find_devfreq_governor it end up with a deadlock. The reason is the following calls.
> 
> devfreq_add_device
>   find_devfreq_governor (!!!)
>     request_module
>        devfreq_simple_ondemand_init
>           devfreq_add_governor
>              find_devfreq_governor (DEADLOCK)
> 
> So I am wondering if shouldn't be more easy fix the issue in both places,
> devfreq_add_device and governor_store.
> 
> To devfreq_add_device
> 
> devfreq_add_device
>   governor = find_devfreq_governor
>   if (IS_ERR(governor) {

In this error case, you have to unlock the mutex
before calling the request_module(). I added the pseudo code
of my opinion.

>      request_module
>      governor = find_devfreq_governor
>      if (IS_ERR(governor)
>        return ERR_PTR(governor)
>   }
> 
> And the same for governor_store
> 
> governor_store
>   governor = find_devfreq_governor
>   if (IS_ERR(governor) {
>      request_module
>      governor = find_devfreq_governor
>      if (IS_ERR(governor)
>        return ERR_PTR(governor)
>   }
> 
> Maybe all  can go in a new function try_find_devfreq_governor_then_request

How about modify the find_devfreq_governor() as following?
I think that it is possible because previous find_devfreq_governor()
always check whether mutex is locked or not.

	find_devfreq_governor() {

		// check whether mutex is locked or not		
		if (!mutex_is_lock(&devfreq_list_lock)) {
			WARN(...)
			return -EINVAL
		}

		// find the registered governor with list_for_each_entry

		if (governor is not loaded) {
			mutex_unlock()
			request_module()
			mutex_lock()	
		}

	}


> 
> Other suggestions?
> 
> - Enric
> 
>> Thanks
>>  Enric.
>>
>>
>>> 2018-06-15 19:04 GMT+09:00 Enric Balletbo i Serra
>>> <enric.balletbo@collabora.com>:
>>>> When the devfreq driver and the governor driver are built as modules,
>>>> the call to devfreq_add_device() fails because the governor driver is
>>>> not loaded at the time the devfreq driver loads. The devfreq driver has
>>>> a build dependency on the governor but also should have a runtime
>>>> dependency. We need to make sure that the governor driver is loaded
>>>> before the devfreq driver.
>>>>
>>>> This patch fixes this bug in devfreq_add_device(). First tries to find
>>>> the governor, and then, if was not found, it requests the module and
>>>> tries again.
>>>>
>>>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> ---
>>>>
>>>>  drivers/devfreq/devfreq.c | 36 +++++++++++++++++++++++++++++++-----
>>>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index fe2af6aa88fc..1d917f043e30 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -11,6 +11,7 @@
>>>>   */
>>>>
>>>>  #include <linux/kernel.h>
>>>> +#include <linux/kmod.h>
>>>>  #include <linux/sched.h>
>>>>  #include <linux/errno.h>
>>>>  #include <linux/err.h>
>>>> @@ -648,10 +649,35 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>
>>>>         governor = find_devfreq_governor(devfreq->governor_name);
>>>>         if (IS_ERR(governor)) {
>>>> -               dev_err(dev, "%s: Unable to find governor for the device\n",
>>>> -                       __func__);
>>>> -               err = PTR_ERR(governor);
>>>> -               goto err_init;
>>>> +               list_del(&devfreq->node);
>>>> +               mutex_unlock(&devfreq_list_lock);
>>>> +
>>>> +               /*
>>>> +                * If the governor is not found, then request the module and
>>>> +                * try again. This can happen when both drivers (the governor
>>>> +                * driver and the driver that calls devfreq_add_device) are
>>>> +                * built as modules.
>>>> +                */
>>>> +               if (!strncmp(devfreq->governor_name,
>>>> +                            DEVFREQ_GOV_SIMPLE_ONDEMAND, DEVFREQ_NAME_LEN))
>>>> +                       err = request_module("governor_%s", "simpleondemand");
>>>> +               else
>>>> +                       err = request_module("governor_%s",
>>>> +                                            devfreq->governor_name);
>>>> +               if (err)
>>>> +                       goto err_unregister;
>>>> +
>>>> +               mutex_lock(&devfreq_list_lock);
>>>> +               list_add(&devfreq->node, &devfreq_list);
>>>> +
>>>> +               governor = find_devfreq_governor(devfreq->governor_name);
>>>> +               if (IS_ERR(governor)) {
>>>> +                       dev_err(dev,
>>>> +                               "%s: Unable to find governor for the device\n",
>>>> +                               __func__);
>>>> +                       err = PTR_ERR(governor);
>>>> +                       goto err_init;
>>>> +               }
>>>>         }
>>>>
>>>>         devfreq->governor = governor;
>>>> @@ -669,7 +695,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>  err_init:
>>>>         list_del(&devfreq->node);
>>>>         mutex_unlock(&devfreq_list_lock);
>>>> -
>>>> +err_unregister:
>>>>         device_unregister(&devfreq->dev);
>>>>  err_dev:
>>>>         if (devfreq)
>>>> --
>>>> 2.17.1
>>>>
>>>
>>>
>>>
>>> --
>>> Best Regards,
>>> Chanwoo Choi
>>> Samsung Electronics
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
