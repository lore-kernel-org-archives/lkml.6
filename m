Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61783C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1027121479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oAfomONj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfBKKFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:05:35 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33978 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfBKKFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:05:34 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190211100531euoutp02c75d4560e33b888a5c08b2a55fc752d5~CRzkEzkEE1549015490euoutp02r
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:05:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190211100531euoutp02c75d4560e33b888a5c08b2a55fc752d5~CRzkEzkEE1549015490euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549879532;
        bh=94EnA4fe3VdgAy6sdhL8Se4IHxeLRWgorb8ecY2ChKQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oAfomONjJYhBzyprooIsVhArIin0qdc+wvpummnBdOkiR6SqvEbsC6VnhMYKQdDMd
         M9N092hkf/zcWrFOT1UUcdKV6einWa3fxq+LOw5WC+YeUAvAcUNBGrLvEokZ4JT5Jt
         8fRXeIGViwan51fvXd4ZXfbVa2f2U+7y/AH3FrOU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190211100530eucas1p2f0e9966626c2e7e4261a8998ca4bed66~CRzjATgeA2372623726eucas1p2Z;
        Mon, 11 Feb 2019 10:05:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E4.53.04806.AE8416C5; Mon, 11
        Feb 2019 10:05:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190211100530eucas1p28186f9c9267871b996fc151849e29227~CRziQJk032990329903eucas1p2P;
        Mon, 11 Feb 2019 10:05:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190211100529eusmtrp2b606b9ffc6d3a8ffccc3a14d623ed69a~CRziA3Idf1961719617eusmtrp2V;
        Mon, 11 Feb 2019 10:05:29 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-a9-5c6148eacd9d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id DA.E0.04128.9E8416C5; Mon, 11
        Feb 2019 10:05:29 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190211100529eusmtip231d75bc029ff948045cd15559cdbd192~CRzhf-21y2731127311eusmtip2f;
        Mon, 11 Feb 2019 10:05:29 +0000 (GMT)
Subject: Re: [PATCH] drivers: devfreq: change devfreq workqueue mechanism
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <880f4d57-263f-cd59-ef33-6bf40a8ee3d1@partner.samsung.com>
Date:   Mon, 11 Feb 2019 11:05:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205003948.GG117604@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djPc7qvPBJjDDbdULbYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i8u75rBZfO49wmix9shddovPGx4zWtxuXMFmcfhNO6vF+8nFDjwe
        a+atYfSY3XCRxWPBplKPhZ++snr0bVnF6PF5k1wAWxSXTUpqTmZZapG+XQJXRsPkpcwF600q
        5j5YxN7A2KLVxcjJISFgIjFp9y/WLkYuDiGBFYwS574+Y4ZwvjBKLJuyngnC+cwosXTFYSCH
        A6ylca4qRHw5o8Sd9juMEM5bRomnKxexg8wVFvCUONX3jQ3EFhHQkHjy+zxYEbPATCaJx10/
        2UAmsQnoSexYVQhSwyvgJrHt/yGwehYBVYnP/66AzREViJA43PuOEaJGUOLkzCcsIDangKHE
        zfM3mEFsZgFxiVtP5jNB2PIS29/OAXtBQuAeu8Sb01fZIB51kZg47TwThC0s8er4FnYIW0bi
        /875UPFiibMdq6DqayTaT+6AqrGWOHz8IivIzcwCmhLrd+lDhB0lOu8tYoYECp/EjbeCECfw
        SUzaNh0qzCvR0SYEUa0hsaXnAtQiMYnla6axT2BUmoXksVlInpmF5JlZCHsXMLKsYhRPLS3O
        TU8tNs5LLdcrTswtLs1L10vOz93ECExbp/8d/7qDcd+fpEOMAhyMSjy8HxITYoRYE8uKK3MP
        MUpwMCuJ8Ia4JMYI8aYkVlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi
        4JRqYNTjnrrSt6VpUlT3g6Ue/3gcOhxf+Hey/q0LkZv68OUDWynZ2yqH7mQrX/11YuFZs63G
        t2OdJab6/JQJdXXNyMyaF/K4Xbut7qbpbwvpo35uGqX8l64qMphuvPJ/Xe3SZSHVN36/0FoZ
        EfjjoXbPZvFfSXkHu1uMlZ5/m1BQVLauykOPV0fyuhJLcUaioRZzUXEiACX/eVBXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7ovPRJjDLYs0rXYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i8u75rBZfO49wmix9shddovPGx4zWtxuXMFmcfhNO6vF+8nFDjwe
        a+atYfSY3XCRxWPBplKPhZ++snr0bVnF6PF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWF
        npGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRsPkpcwF600q5j5YxN7A2KLVxcjBISFgItE4
        V7WLkYtDSGApo8TXxiNMXYycQHExiUn7trND2MISf651sUEUvWaUWD/nEQtIQljAU+JU3zc2
        EFtEQEPiye/zjCBFzAIzmSRal5wD6xYSOMoo0f2vDmQbm4CexI5VhSBhXgE3iW3/D4H1sgio
        Snz+dwWsXFQgQuLj031MEDWCEidnPgHbxSlgKHHz/A1mEJtZwExi3uaHULa4xK0n85kgbHmJ
        7W/nME9gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85P3cTIzBStx37
        uWUHY9e74EOMAhyMSjy8HxITYoRYE8uKK3MPMUpwMCuJ8Ia4JMYI8aYkVlalFuXHF5XmpBYf
        YjQFem4is5Rocj4wieSVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCU
        amBkvF56ZNW3x/bX9dOiYlSrpFM+VP49vI5HqfzK8QjT6wtFj8+6e6DCQcc64NXNleE7rv2Y
        dujt+ck6SUY9L05q7a92mm+xKLfB7o+uWN2HK/HNjntkeP4fmMKQbsX8fcNqbYPAN2cWCAua
        R5x7whnbdmpZQT5H67P/pw7dOLBcrjGH7d9BViEbJZbijERDLeai4kQAiMOfZuoCAAA=
X-CMS-MailID: 20190211100530eucas1p28186f9c9267871b996fc151849e29227
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190201183813eucas1p20183a08d4f75f853468a8129b048c208
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201183813eucas1p20183a08d4f75f853468a8129b048c208
References: <CGME20190201183813eucas1p20183a08d4f75f853468a8129b048c208@eucas1p2.samsung.com>
        <1549046283-18242-1-git-send-email-l.luba@partner.samsung.com>
        <20190205003948.GG117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

My apologize for late response, I did not have access to mailbox.
Thank you for review, please check the comments below.

On 2/5/19 1:39 AM, Matthias Kaehlcke wrote:
> Hi Lukasz,
> 
> On Fri, Feb 01, 2019 at 07:38:03PM +0100, Lukasz Luba wrote:
>> This patch removes devfreq's custom workqueue and uses system one.
>> It switches from queue_delayed_work() to schedule_delayed_work().
>> It also changes deferred work to delayed work, which is now not missed
>> when timer is put on CPU that entered idle state.
>> The devfreq framework governor was not called, thus changing the frequency
>> of the device did not happen.
>> Benchmarks for stressing Dynamic Memory Controller show x2
>> performance boost with this patch when 'simpleondemand_governor' is
>> responsible for monitoring the device load and frequency changes.
>> With this patch, the scheduled delayed work is done no mater CPUs' idle.
>> It also does not wake up the system when it enters suspend (this
>> functionality stays the same).
>> All of the drivers in devfreq which rely on periodic, guaranteed wakeup
>> intervals should benefit from it.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 27 +++++++--------------------
>>   1 file changed, 7 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 0ae3de7..c200b3c 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -31,13 +31,6 @@
>>   
>>   static struct class *devfreq_class;
>>   
>> -/*
>> - * devfreq core provides delayed work based load monitoring helper
>> - * functions. Governors can use these or can implement their own
>> - * monitoring mechanism.
>> - */
>> -static struct workqueue_struct *devfreq_wq;
>> -
>>   /* The list of all device-devfreq governors */
>>   static LIST_HEAD(devfreq_governor_list);
>>   /* The list of all device-devfreq */
>> @@ -391,8 +384,8 @@ static void devfreq_monitor(struct work_struct *work)
>>   	if (err)
>>   		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
>>   
>> -	queue_delayed_work(devfreq_wq, &devfreq->work,
>> -				msecs_to_jiffies(devfreq->profile->polling_ms));
>> +	schedule_delayed_work(&devfreq->work,
>> +			      msecs_to_jiffies(devfreq->profile->polling_ms));
>>   	mutex_unlock(&devfreq->lock);
>>   }
>>   
>> @@ -407,9 +400,9 @@ static void devfreq_monitor(struct work_struct *work)
>>    */
>>   void devfreq_monitor_start(struct devfreq *devfreq)
>>   {
>> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>> +	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>>   	if (devfreq->profile->polling_ms)
>> -		queue_delayed_work(devfreq_wq, &devfreq->work,
>> +		schedule_delayed_work(&devfreq->work,
>>   			msecs_to_jiffies(devfreq->profile->polling_ms));
>>   }
>>   EXPORT_SYMBOL(devfreq_monitor_start);
>> @@ -473,7 +466,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>>   
>>   	if (!delayed_work_pending(&devfreq->work) &&
>>   			devfreq->profile->polling_ms)
>> -		queue_delayed_work(devfreq_wq, &devfreq->work,
>> +		schedule_delayed_work(&devfreq->work,
>>   			msecs_to_jiffies(devfreq->profile->polling_ms));
>>   
>>   	devfreq->last_stat_updated = jiffies;
>> @@ -516,7 +509,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>>   
>>   	/* if current delay is zero, start polling with new delay */
>>   	if (!cur_delay) {
>> -		queue_delayed_work(devfreq_wq, &devfreq->work,
>> +		schedule_delayed_work(&devfreq->work,
>>   			msecs_to_jiffies(devfreq->profile->polling_ms));
>>   		goto out;
>>   	}
>> @@ -527,7 +520,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>>   		cancel_delayed_work_sync(&devfreq->work);
>>   		mutex_lock(&devfreq->lock);
>>   		if (!devfreq->stop_polling)
>> -			queue_delayed_work(devfreq_wq, &devfreq->work,
>> +			schedule_delayed_work(&devfreq->work,
>>   			      msecs_to_jiffies(devfreq->profile->polling_ms));
>>   	}
>>   out:
>> @@ -1430,12 +1423,6 @@ static int __init devfreq_init(void)
>>   		return PTR_ERR(devfreq_class);
>>   	}
>>   
>> -	devfreq_wq = create_freezable_workqueue("devfreq_wq");
>> -	if (!devfreq_wq) {
>> -		class_destroy(devfreq_class);
>> -		pr_err("%s: couldn't create workqueue\n", __FILE__);
>> -		return -ENOMEM;
>> -	}
>>   	devfreq_class->dev_groups = devfreq_groups;
>>   
>>   	return 0;
> 
> If I understand correctly this changes three things:
> 
> 1. use system workqueue instead of custom one
> 
> should be fine with the cwmq's we have nowadays
> 
> 
> 2. use non-freezable workqueue
> 
>    ``WQ_FREEZABLE``
>      A freezable wq participates in the freeze phase of the system
>      suspend operations.  Work items on the wq are drained and no
>      new work item starts execution until thawed.
> 
> I'm not entirely sure what the impact of this is.
> 
> I imagine suspend is potentially quicker because the wq isn't drained,
> but could works that execute during the suspend phase be a problem?
I did not check if the suspend is quicker, but I will try to simulate
and check these scenarios.
I just wanted to get rid of another workqueue in the system.

> 
> 
> 3. use delayed work instead of deferrable work
> 
> I hadn't come across deferrable work yet:
Me neither, but using it to run governors is not the best idea.
> 
>    "Add a new deferrable delayed work init.  This can be used to schedule work
>    that are 'unimportant' when CPU is idle and can be called later, when CPU
>    eventually comes out of idle."
> 
>    28287033e124 ("Add a new deferrable delayed work init")
> 
> The commit message mentions that frequency changes were missed due to
> deferred works being scheduled on an idle CPU. The change to a delayed
> work seems reasonable to me.
It is not only the Dynamic Memory Controller and DRAM affected.
The drivers for GPUs, Network on Chip, cache L3 rely on it.
They all are missing opportunity to check the HW state and react.

> 
> It could make sense to split this change into two patches, one for the
> change from deferrable to delayed work, and another for custom workqueue
> to system workqueue (and possibly even a third, transitory change for
> freezable to non-freezable, if it's confirmed that that's the right
> thing to do).
OK, I will split the patch into two: one with delayed work and one with
regular system workqueue.
I thought that one patch would be simpler to apply to stable tree if needed.

Regards,
Lukasz
> 
> Cheers
> 
> Matthias
> 
> 
