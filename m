Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BDCC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AB7222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B3npqSN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfBLVhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:37:33 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33860 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732531AbfBLVh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:37:27 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190212213724euoutp0118eb19da1b1d1982a5c9e3291697a83d~Cu48Q8xBj1579515795euoutp01u
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 21:37:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190212213724euoutp0118eb19da1b1d1982a5c9e3291697a83d~Cu48Q8xBj1579515795euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550007444;
        bh=kpq8zgVocr9PRpcTTKDK0+SvRu4YpSgAMp11ePaGOvg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B3npqSN7B0t9t7fexv1fiElo7HQX75kWcKpK5wJW7TU3tqVYIHMdHxeIlWI4WgvaA
         43JLiaVv1eL7H/7uJf0m2fg2zeYYffuB/cxh7xWwDW0XGor74n0tjp44nG54CQ8miS
         bZwSJRE1LE8taggTmsK0qDPaXqbp08zRKyiQ35sE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212213724eucas1p2804a93e79a937e1190eeda40f45fb5dd~Cu47rJezQ0223802238eucas1p2X;
        Tue, 12 Feb 2019 21:37:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A0.82.04441.39C336C5; Tue, 12
        Feb 2019 21:37:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190212213722eucas1p2612c77dc6481d858044334d7bb6e1a49~Cu45_9xH20223802238eucas1p2W;
        Tue, 12 Feb 2019 21:37:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212213722eusmtrp25209da3a072a4766d9f6996ad901751b~Cu45wTbsO1722517225eusmtrp2P;
        Tue, 12 Feb 2019 21:37:22 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-20-5c633c93a3c8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D4.33.04128.19C336C5; Tue, 12
        Feb 2019 21:37:21 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190212213721eusmtip2bb4a90802dcb5826664596af507e6eac~Cu44-Pqzq0196501965eusmtip2B;
        Tue, 12 Feb 2019 21:37:21 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] drivers: devfreq: change devfreq workqueue
 mechanism
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <6eb6fc90-27ef-87d2-1123-3d71f0a5102e@partner.samsung.com>
Date:   Tue, 12 Feb 2019 22:37:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212201228.GU117604@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfXfO2Y7Ljddp+WBRNDC08EZ9OOAQhaj1xcpPkkLNeVLz2o6X
        TA0VvKKlCTrNzELUzEuOZVM0SJciMsy0rGQmahjmBZyrpLA8HiW//d7n+T/8/394aUIxSLnT
        sYkprC5RE68US8nuoc0x70qVNsKvaEbFdOk7KaZqfYJkpjYWKaYpx4Ox5C1LmIneOjFjKzMj
        pt1slTC25/OImc5tETODy4UUs1bJBTmp2+rbkPpBzjipbjCkqh+v2yn1XWMrUtsMRy+Jr0hV
        UWx8bBqr8w28Jo1pXJxHyb2nb5V15FE5qM2rBDnSgM+A/tlrMc8K3ILAWn1c4A0EDY3RJUi6
        zTYEXxu3qL2Dsp56Ulg0IzAXVVPCYwVBX+UU4lUuOBSM/R0Ez67YExZ+jyFeROAaEcyXbG77
        0bQY+4Cp9SavkeFz0JPXJOKZxB6Q/9CwE+kgDoPBslUkaJxhpGaB5NkR+0N/u20nEYHd4PPC
        I5HAx+DlSh3BewGekYDd8nQ39lkYmq7aZRdYGjZKBD4Cf3uEY8AcWIpaxQJnQeGIaVcTAIPD
        4xSfmcBe0NnrK4yDYfVT384YsBw+rjgLEeRwv7uaEMYyKCpQCGpPMJa+3TU6BM1tVZJypKzd
        V6x2X5nafWVq//s2ILIVubGpXEI0y/knsuk+nCaBS02M9tEmJRjQ9tca3RpeNyH7u8gBhGmk
        dJK1vImMUFCaNC4jYQABTShdZdcJbYRCFqXJuM3qkq7qUuNZbgAdpkmlmyzTYTZcgaM1KWwc
        yyazur2tiHZ0z0EXguS/uuI6uS8mY3X8+Qq7Xrr884BKK58uXVs7kXXj4o8gt433E046zxgk
        GrV+W8oV68M6CwzSoI4O+aTPk1jvDxV+jVITM3kqICQi8E+xedYhJK7m3tydhUKcmT774lXF
        uEWrX8kvbipftsxdDrdnG6Q1leZgx+bvKmuoNVtJcjEa/5OEjtP8A8UEpBFWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7oTbZJjDDafMLPYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i8u75rBZfO49wmix9shddovPGx4zWtxuXMFmcfhNO6vF+8nFDjwe
        a+atYfSY3XCRxWPBplKPhZ++snr0bVnF6PF5k1wAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWF
        npGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexpLnjxkLdhlX9K5rYm1gXKPZxcjJISFgItG7
        cx5LFyMXh5DAUkaJaf9usEIkxCQm7dvODmELS/y51sUGUfSaUeLU2U42kISwQJDElr3rmEFs
        EQENiSe/zzOCFDELzGSSaF1yjh2i4wWTxJ4rk4B2cHCwCehJ7FhVCNLAK+AmsbNpGROIzSKg
        KtE6dxPYUFGBCImPT/cxQdQISpyc+YQFxOYUMJTYu/Yz2HXMAmYS8zY/ZIawxSVuPZnPBGHL
        S2x/O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiB0brt
        2M8tOxi73gUfYhTgYFTi4V1xNClGiDWxrLgy9xCjBAezkghvGnNyjBBvSmJlVWpRfnxRaU5q
        8SFGU6DnJjJLiSbnAxNJXkm8oamhuYWlobmxubGZhZI473mDyighgfTEktTs1NSC1CKYPiYO
        TqkGxqN3dV6lXjwU/sOy3XXSqqbmTW0qTiJtc9rb5kn+vD9ZaUW8yNKJTz+eeH6vtm/Xoac5
        iu+Fr/nFVebcOawsGPpU55X13z3pogbqH76qXu/2t7EI297NaXaSVzc/51JV/saexbHGr27e
        ZgvmuOF3eHtveIRYQND9ZROMD/veO/W6qFR1ys0MXSWW4oxEQy3mouJEANJyY2bsAgAA
X-CMS-MailID: 20190212213722eucas1p2612c77dc6481d858044334d7bb6e1a49
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
        <01644c1c-a419-9864-3b34-0837a114b799@partner.samsung.com>
        <20190212201228.GU117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2/12/19 9:12 PM, Matthias Kaehlcke wrote:
> On Tue, Feb 12, 2019 at 12:20:42PM +0100, Lukasz Luba wrote:
>> Hi Matthias,
>>
>> On 2/11/19 10:42 PM, Matthias Kaehlcke wrote:
>>> Hi Lukasz,
>>>
>>> On Mon, Feb 11, 2019 at 04:30:04PM +0100, Lukasz Luba wrote:
>>>> There is no need for creating another workqueue in the system,
>>>> the existing one should meet the requirements.
>>>> This patch removes devfreq's custom workqueue and uses system one.
>>>> It switches from queue_delayed_work() to schedule_delayed_work().
>>>> It also does not wake up the system when it enters suspend (this
>>>> functionality stays the same).
>>>>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    drivers/devfreq/devfreq.c | 25 ++++++-------------------
>>>>    1 file changed, 6 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index 0ae3de7..882e717 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -31,13 +31,6 @@
>>>>    
>>>>    static struct class *devfreq_class;
>>>>    
>>>> -/*
>>>> - * devfreq core provides delayed work based load monitoring helper
>>>> - * functions. Governors can use these or can implement their own
>>>> - * monitoring mechanism.
>>>> - */
>>>> -static struct workqueue_struct *devfreq_wq;
>>>> -
>>>>    /* The list of all device-devfreq governors */
>>>>    static LIST_HEAD(devfreq_governor_list);
>>>>    /* The list of all device-devfreq */
>>>> @@ -391,8 +384,8 @@ static void devfreq_monitor(struct work_struct *work)
>>>>    	if (err)
>>>>    		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
>>>>    
>>>> -	queue_delayed_work(devfreq_wq, &devfreq->work,
>>>> -				msecs_to_jiffies(devfreq->profile->polling_ms));
>>>> +	schedule_delayed_work(&devfreq->work,
>>>> +			      msecs_to_jiffies(devfreq->profile->polling_ms));
>>>>    	mutex_unlock(&devfreq->lock);
>>>>    }
>>>>    
>>>> @@ -409,7 +402,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>>>>    {
>>>>    	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>>>>    	if (devfreq->profile->polling_ms)
>>>> -		queue_delayed_work(devfreq_wq, &devfreq->work,
>>>> +		schedule_delayed_work(&devfreq->work,
>>>>    			msecs_to_jiffies(devfreq->profile->polling_ms));
>>>>    }
>>>>    EXPORT_SYMBOL(devfreq_monitor_start);
>>>> @@ -473,7 +466,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>>>>    
>>>>    	if (!delayed_work_pending(&devfreq->work) &&
>>>>    			devfreq->profile->polling_ms)
>>>> -		queue_delayed_work(devfreq_wq, &devfreq->work,
>>>> +		schedule_delayed_work(&devfreq->work,
>>>>    			msecs_to_jiffies(devfreq->profile->polling_ms));
>>>>    
>>>>    	devfreq->last_stat_updated = jiffies;
>>>> @@ -516,7 +509,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>>>>    
>>>>    	/* if current delay is zero, start polling with new delay */
>>>>    	if (!cur_delay) {
>>>> -		queue_delayed_work(devfreq_wq, &devfreq->work,
>>>> +		schedule_delayed_work(&devfreq->work,
>>>>    			msecs_to_jiffies(devfreq->profile->polling_ms));
>>>>    		goto out;
>>>>    	}
>>>> @@ -527,7 +520,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>>>>    		cancel_delayed_work_sync(&devfreq->work);
>>>>    		mutex_lock(&devfreq->lock);
>>>>    		if (!devfreq->stop_polling)
>>>> -			queue_delayed_work(devfreq_wq, &devfreq->work,
>>>> +			schedule_delayed_work(&devfreq->work,
>>>>    			      msecs_to_jiffies(devfreq->profile->polling_ms));
>>>>    	}
>>>>    out:
>>>> @@ -1430,12 +1423,6 @@ static int __init devfreq_init(void)
>>>>    		return PTR_ERR(devfreq_class);
>>>>    	}
>>>>    
>>>> -	devfreq_wq = create_freezable_workqueue("devfreq_wq");
>>>> -	if (!devfreq_wq) {
>>>> -		class_destroy(devfreq_class);
>>>> -		pr_err("%s: couldn't create workqueue\n", __FILE__);
>>>> -		return -ENOMEM;
>>>> -	}
>>>>    	devfreq_class->dev_groups = devfreq_groups;
>>>>    
>>>>    	return 0;
>>>
>>> As commented on v1, the change from a custom to a system workqueue
>>> seems reasonable to me. However this patch also changes from a
>>> freezable workqueue to a non-freezable one. C&P of my comments on v1:
>>>
>>> ``WQ_FREEZABLE``
>>>       A freezable wq participates in the freeze phase of the system
>>>       suspend operations.  Work items on the wq are drained and no
>>>       new work item starts execution until thawed.
>>>
>>> I'm not entirely sure what the impact of this is.
>>>
>>> I imagine suspend is potentially quicker because the wq isn't drained,
>>> but could works that execute during the suspend phase be a problem?
>> The devfreq supports suspend from v4.20-rc6, which picks OPP for a
>> device based on its DT 'opp-suspend'. For the devices which do not
>> choose the suspend OPP it is possible to enter that state with any
>> frequency. Queuing work for calling governor during suspend which
>> calculates the device's frequency for the next period is IMO not needed,
>> The 'next period' is actually suspend and is not related to
>> 'predicted' load by the governor.
> 
> If I am not mistaken the monitor can still be running after a device
> was suspended:
> 
> devfreq_suspend
>    list_for_each_entry(devfreq, &devfreq_list, node)
>      devfreq_suspend_device
>        devfreq->governor->event_handler(devfreq,
>                                         DEVFREQ_GOV_SUSPEND, NULL);
> 
> According to the comment of devfreq_monitor_suspend() the function is
> supposed to be called by the governor in response to
> DEVFREQ_GOV_SUSPEND, however this doesn't seem to be universally the case:
> 
> git grep devfreq_monitor_suspend
>    drivers/devfreq/governor_simpleondemand.c:              devfreq_monitor_suspend(devfreq);
>    drivers/devfreq/tegra-devfreq.c:                devfreq_monitor_suspend(devfreq);
> 
> i.e. the other governors don't seem to call devfreq_monitor_suspend().
> 
> Am I missing something?
Probably not.
Good catch, these governors should support case DEVFREQ_GOV_SUSPEND.
The system suspend which calls 'devfreq_suspend' does it when the
workqueues are frozen and sets the desired OPP for later resume.
The other use use cases (like pm_suspend) might assume that these
governors are ready for DEVFREQ_GOV_SUSPEND...
Do you like to write a patch for them (I can test it) or should I do it?

Regards,
Lukasz
> 
> Thanks
> 
> Matthias
> 
> 
