Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC01C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5A82084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BZzm2MxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfBLLUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:20:48 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54264 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfBLLUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:20:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190212112045euoutp0165fe3c7ad98ff65a35bbbd52043c6e6d~Cmeh5kjk20725107251euoutp01X
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 11:20:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190212112045euoutp0165fe3c7ad98ff65a35bbbd52043c6e6d~Cmeh5kjk20725107251euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549970445;
        bh=N1ueiTIKZGTjpKBINCwuiZROC7YGiLBIfgv9ZIRAlb8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BZzm2MxVtfDYRJ+ITNFwZqPXbjOk2LYckGM+N3fCYLJ9YmWm7DTWPo9MMTQOhRvMH
         Ie0qi1XbHPliYhNcBCbL/H7IuITSIt8xo2gzRipS8FSJPkMaSECFsCKT2XLeaG1l6B
         JoEnXpL7nL5PkoEfwfi52O/lIW4gF4Y3IDlL8Hok=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212112045eucas1p2131018dfa1d45051da4b2d5fde56375c~CmehcKRtI2180421804eucas1p2N;
        Tue, 12 Feb 2019 11:20:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CF.49.04806.C0CA26C5; Tue, 12
        Feb 2019 11:20:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190212112044eucas1p15ee6ba8b5b17f0ea85131e4f06fb57f7~CmegsOxpP2343623436eucas1p1o;
        Tue, 12 Feb 2019 11:20:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212112043eusmtrp2b46daedbf453d0cedbc6192fd9754833~CmegdUJyy1106511065eusmtrp29;
        Tue, 12 Feb 2019 11:20:43 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-e1-5c62ac0c5215
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9D.59.04284.B0CA26C5; Tue, 12
        Feb 2019 11:20:43 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190212112043eusmtip21f9210769710d9f64ad9738c49133c42~Cmef4TQsg2402224022eusmtip2_;
        Tue, 12 Feb 2019 11:20:43 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] drivers: devfreq: change devfreq workqueue
 mechanism
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <01644c1c-a419-9864-3b34-0837a114b799@partner.samsung.com>
Date:   Tue, 12 Feb 2019 12:20:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211214252.GR117604@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbSyVYRj2nPfjvE5Oexxy7qllO42kOkJtb2NNW2vnRz9Ua1NMXnmH8tV5
        EfIDbcjSpKZ8k3yMIzkzYbHmyMcwXzNk+sCmdDBfLWPK8bL8u+7rvq7nuu7tYQiFgbJlQsKj
        eG04F6qiZWRDx3r/aQtdgO+ZuYlTbN2rWorNXh4m2dHVWYotT7Rn+5KNUna4OZ9mVzLaEVvT
        PillV95NI3YiqZJmDcZUil18LnhaaHSFOqTJSxwkNcX6aE3J8hqleVpfhTQr+qNe9C2ZRyAf
        GhLDa50v+MuCf3zqoiL7HWKLmoboRFRgl47MGcBnYbRskk5HMkaBKxH8HDeQ4rCK4NHUnEQc
        VhAkl3wl9iz6lqFdSwWC7HIjZVoo8DyC3gmlCVvha1Df8nbHYI0dYWajH5kMBM6RwHT6+rab
        YWishsaq+yaNHF+G0czXlIkmsT1MzKpN9CHsDYaMBSRKLKE7Z4Y0YXPsAhXVv3eeJ7ASPs8U
        SURsB+/n8wlTFOAvUng2skiJpS/B2FSmRMRWMNdZLxXxEfjbVLTLC9CXVkWLOAFSuxt3Ne5g
        6Bzc6UbgE1Db7CzSF2Fh/MMODfggjM1bihUOQlbDS0Kk5ZCWohDVjlD/ZGA3yAYqdNnSTKTK
        3XdY7r5jcvcdk/s/txiRVUjJRwthQbzgFs4/UAtcmBAdHqS+ExGmR9tfq2erc60RtW4GtCHM
        IJWFPDaC81VQXIwQF9aGgCFU1nK/sgBfhTyQi4vntRG3tdGhvNCGDjOkSil/aPbNR4GDuCj+
        Hs9H8tq9rYQxt01EQdxqyWaEdXLgTTe/G6Nxsb9KP3a1qSyv+w/oWmxq/ENah0qWDNPLBcFO
        9Hkv/vjdNM8s7yF1mszD62RPVm/U1W6f+JhCNjDvj1RJtMqSFA6+L8hQ/L3uSqnTAeutN2Ud
        UwuuKefci5bUriM+x+oGBs1cN7yricfGhHj/ho6YDhUpBHMuToRW4P4BrGcsOFYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7rca5JiDFY1mlpsnLGe1WLap8ss
        Fte/PGe1WNaganG26Q27xeVdc9gsPvceYbRYe+Quu8XnDY8ZLW43rmCzOPymndXi/eRiBx6P
        NfPWMHrMbrjI4rFgU6nHwk9fWT36tqxi9Pi8SS6ALUrPpii/tCRVISO/uMRWKdrQwkjP0NJC
        z8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv48XRE6wF59Uq5u+8xNbAOFe+i5GTQ0LARGLT
        3ktsXYxcHEICSxklJj9dwAiREJOYtG87O4QtLPHnWhdU0WtGiaUTF4EVCQsESWzZu44ZxBYR
        0JB48vs8I0gRs8BMJonWJefAuoUEWpgkej9VdDFycLAJ6EnsWFUIEuYVcJO4PmERK0iYRUBV
        4vZzPZCwqECExMen+5ggSgQlTs58wgJicwoYSixf/Q1sFbOAmcS8zQ+hbHGJW0/mM0HY8hLb
        385hnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYKRuO/Zz
        8w7GSxuDDzEKcDAq8fBW5CfGCLEmlhVX5h5ilOBgVhLhjVuaFCPEm5JYWZValB9fVJqTWnyI
        0RTot4nMUqLJ+cAkklcSb2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1Oq
        gVHun+Y8h73hQnGzVa5cEv3E9/WyxcrtZiLZz1oMViZuvnJE1cc/TlazcFJ+ZsbDw+0P960O
        rXt84ECeyJ7bwb0CT94xy79NPfXfd8bfJn5vu9bfj4xe/qyal53Im/yutzjj6pKtvxUsDfqj
        9BxS20sOK0RMNkxyWLt041X5qitW/Cu+Cn0qlFJiKc5INNRiLipOBAA/dTIs6gIAAA==
X-CMS-MailID: 20190212112044eucas1p15ee6ba8b5b17f0ea85131e4f06fb57f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190211153035eucas1p12ecdd3289a20ce9fb28588ba20869c60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190211153035eucas1p12ecdd3289a20ce9fb28588ba20869c60
References: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190211153035eucas1p12ecdd3289a20ce9fb28588ba20869c60@eucas1p1.samsung.com>
        <1549899005-7760-2-git-send-email-l.luba@partner.samsung.com>
        <20190211214252.GR117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2/11/19 10:42 PM, Matthias Kaehlcke wrote:
> Hi Lukasz,
> 
> On Mon, Feb 11, 2019 at 04:30:04PM +0100, Lukasz Luba wrote:
>> There is no need for creating another workqueue in the system,
>> the existing one should meet the requirements.
>> This patch removes devfreq's custom workqueue and uses system one.
>> It switches from queue_delayed_work() to schedule_delayed_work().
>> It also does not wake up the system when it enters suspend (this
>> functionality stays the same).
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 25 ++++++-------------------
>>   1 file changed, 6 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 0ae3de7..882e717 100644
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
>> @@ -409,7 +402,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>>   {
>>   	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
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
> As commented on v1, the change from a custom to a system workqueue
> seems reasonable to me. However this patch also changes from a
> freezable workqueue to a non-freezable one. C&P of my comments on v1:
> 
> ``WQ_FREEZABLE``
>      A freezable wq participates in the freeze phase of the system
>      suspend operations.  Work items on the wq are drained and no
>      new work item starts execution until thawed.
> 
> I'm not entirely sure what the impact of this is.
> 
> I imagine suspend is potentially quicker because the wq isn't drained,
> but could works that execute during the suspend phase be a problem?
The devfreq supports suspend from v4.20-rc6, which picks OPP for a
device based on its DT 'opp-suspend'. For the devices which do not
choose the suspend OPP it is possible to enter that state with any
frequency. Queuing work for calling governor during suspend which
calculates the device's frequency for the next period is IMO not needed,
The 'next period' is actually suspend and is not related to
'predicted' load by the governor.

You are right, the suspend will be faster.

Regards,
Lukasz
> 
> Cheers
> 
> Matthias
> 
> 
