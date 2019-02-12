Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF44C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6CB21773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OR+iSbz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfBLLBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:01:34 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51578 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfBLLBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:01:33 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190212110131euoutp02a4e110b0db2fbf64058f978004dde6f0~CmNu0Ofmm2356323563euoutp02k
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 11:01:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190212110131euoutp02a4e110b0db2fbf64058f978004dde6f0~CmNu0Ofmm2356323563euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549969291;
        bh=wVH98XU7BcA328LQehW4tMhk8FeigHGq7Rd6+UGsok0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OR+iSbz+Dwb7hjQhOcRo5WfmKO9t1QSsl0YH5aoWWI0ECzpPrJtZc7c+nPKixrVNj
         yLYA7JvM9FJvE4Pdd7yRETdHfF0Ng8G1lZijayEwaPi9cXT47jtE5S63bMJZW5dIyr
         dk3K94TZ2pOjmmcExmM9KUOF2peRB3/A0EctBil8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212110130eucas1p22e7b38dd307ab05e0d76ddbd5039a2ce~CmNt2-wJ11859118591eucas1p2h;
        Tue, 12 Feb 2019 11:01:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D4.DC.04294.987A26C5; Tue, 12
        Feb 2019 11:01:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190212110129eucas1p2dfbfd3640b28e76490091f19155f7627~CmNtEr3G61656316563eucas1p28;
        Tue, 12 Feb 2019 11:01:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212110129eusmtrp285d4f3258a051563e9f3cc7bc5e1be58~CmNs1yJzP0510705107eusmtrp2b;
        Tue, 12 Feb 2019 11:01:29 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-3d-5c62a789078a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.FE.04128.887A26C5; Tue, 12
        Feb 2019 11:01:28 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212110128eusmtip183200ccd185348e8e13e8eafeb04a40c~CmNsN4Zvl2468524685eusmtip1q;
        Tue, 12 Feb 2019 11:01:28 +0000 (GMT)
Subject: Re: [PATCH] drivers: devfreq: change devfreq workqueue mechanism
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <899cecb8-726c-0db8-03c3-3e07f8cd2927@partner.samsung.com>
Date:   Tue, 12 Feb 2019 12:01:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211205414.GP117604@google.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUhUURSAu773Zp7i2HW0PJkYTYgLqGlCL7KNMib6kX+SKNPGfLjkOk9N
        qx+W5q5ohnumkWlqLoOZCwpuiQ2mMlRiZYvTBOUSzhhNSubrKfnvO+d8555z4NKEdICypcOi
        4lhllCJCJjIj258bx1wza4P8944b9zGtJc0UU7SoIZk3hq8U8yjZgRm9NStmNF0VIkafO4iY
        J4PvxYy+ZQYxb2/WiZiB2XSKWSjkjprLGysbkbw8eYKUV6ni5dWLS5Q8r60eyfUqe1/ReTPv
        YDYiLIFVuh++ZBY6WaMmYwp8El9Pa8TJ6N3+LGRKA/YCXaVanIXMaCmuQ5Ci/24iBAYEVS8/
        iHlLivVrwb3wjY6lKZ1IkGoRlP+6vd4xh6D0lYrgLSt8Cl7k/RTxbI2dQLs8hniJwKUmMJNl
        XCvQtAi7QUd9LI8SfBJWe6J5ncQOsNzbQvG8DZ+Dgdx5xLMEW8JIqZbk2RR7QHdhw7/nCWwD
        U9r7JgLvgmdzFQQ/CvC0GEZTswlh6xPw2ThDCWwF34bbxALbwWqn0AyYg9GMepHANyB9pGPd
        OQgDwxMUvyeBnaG5y11IH4PM6QcEnwZsAZNzlsIKFnCnvXg9LYGMNKlgO0Fbzvj6oO1Q21gk
        zkeysk2HlW06pmzTMWX/51Yhsh7ZsPFcZAjLeUaxV904RSQXHxXidjk6UoXWvpb6z7ChA3Wt
        BPUjTCOZuSQxWuEvpRQJXFJkPwKakFlLAmqC/KWSYEXSNVYZHaiMj2C5frSTJmU2kutbPl6Q
        4hBFHHuFZWNY5UbVhDa1TUZ7LOV2nwhP8xXNkn3asvaxe3FTobOOm+z1M3gXPL37wyfv0AHH
        ZWb3iiY4yPaILj2FbnXMH8uUm/fGZNuM66R1FTGGwHlXP26HXWFE+LTH0FhTaE7/mYfqsD4/
        42xfglfK0ERsRmf474aqhd2nL35xUR4P2Frte7ZnpLsk2z5VKyO5UIWHC6HkFH8BoCWmPlYD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsVy+t/xu7ody5NiDPq6LCw2zljPajHt02UW
        i+tfnrNaLGtQtTjb9Ibd4vKuOWwWn3uPMFqsPXKX3eLzhseMFrcbV7BZHH7TzmrxfnKxA4/H
        mnlrGD1mN1xk8ViwqdRj4aevrB59W1YxenzeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmh
        Z2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXcWPpaZaCia4V1+5dZm9gvGPexcjJISFgIvH1
        1jO2LkYuDiGBpYwSq55MYYFIiElM2redHcIWlvhzrQuq6DWjxK1Ds1hBEsICnhKn+r6xgdgi
        AhoST36fZwQpYhaYySTRuuQcO0THSiaJ/Rs3A1VxcLAJ6EnsWFUIYvIKuEn835sP0ssioCrx
        e98GsJmiAhESH5/uYwKxeQUEJU7OfAJ2EKeAocTuyavBdjELmEnM2/yQGcIWl7j1ZD4ThC0v
        sf3tHOYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgTG6rZj
        P7fsYOx6F3yIUYCDUYmHVyE3MUaINbGsuDL3EKMEB7OSCG/c0qQYId6UxMqq1KL8+KLSnNTi
        Q4ymQM9NZJYSTc4HppG8knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TByc
        Ug2MDj6VuQtWLpRzcWh6ItvoEVtR/67lOcczS0P1xzMz5z14I11pUJwee/qyzeQFpldUXPdV
        qHvx5ks/do45cK2yoOS988ZesU1mczdsmsR5JGlDhbd+7ULhgLn376+W5rixZcb7hYp/v7kl
        eXhaZTmvXL1BfvLfqvlXzi5TFvNf+U5NbO3texkOSizFGYmGWsxFxYkAzvoj7usCAAA=
X-CMS-MailID: 20190212110129eucas1p2dfbfd3640b28e76490091f19155f7627
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190201183813eucas1p20183a08d4f75f853468a8129b048c208
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201183813eucas1p20183a08d4f75f853468a8129b048c208
References: <CGME20190201183813eucas1p20183a08d4f75f853468a8129b048c208@eucas1p2.samsung.com>
        <1549046283-18242-1-git-send-email-l.luba@partner.samsung.com>
        <20190205003948.GG117604@google.com>
        <880f4d57-263f-cd59-ef33-6bf40a8ee3d1@partner.samsung.com>
        <20190211205414.GP117604@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2/11/19 9:54 PM, Matthias Kaehlcke wrote:
> Hi Lukasz,
> 
> On Mon, Feb 11, 2019 at 11:05:27AM +0100, Lukasz Luba wrote:
>> Hi Matthias,
>>
>> My apologize for late response, I did not have access to mailbox.
>> Thank you for review, please check the comments below.
>>
>> On 2/5/19 1:39 AM, Matthias Kaehlcke wrote:
>>> Hi Lukasz,
>>>
>>> On Fri, Feb 01, 2019 at 07:38:03PM +0100, Lukasz Luba wrote:
>>>> This patch removes devfreq's custom workqueue and uses system one.
>>>> It switches from queue_delayed_work() to schedule_delayed_work().
>>>> It also changes deferred work to delayed work, which is now not missed
>>>> when timer is put on CPU that entered idle state.
>>>> The devfreq framework governor was not called, thus changing the frequency
>>>> of the device did not happen.
>>>> Benchmarks for stressing Dynamic Memory Controller show x2
>>>> performance boost with this patch when 'simpleondemand_governor' is
>>>> responsible for monitoring the device load and frequency changes.
>>>> With this patch, the scheduled delayed work is done no mater CPUs' idle.
>>>> It also does not wake up the system when it enters suspend (this
>>>> functionality stays the same).
>>>> All of the drivers in devfreq which rely on periodic, guaranteed wakeup
>>>> intervals should benefit from it.
>>>>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    drivers/devfreq/devfreq.c | 27 +++++++--------------------
>>>>    1 file changed, 7 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index 0ae3de7..c200b3c 100644
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
>>>> @@ -407,9 +400,9 @@ static void devfreq_monitor(struct work_struct *work)
>>>>     */
>>>>    void devfreq_monitor_start(struct devfreq *devfreq)
>>>>    {
>>>> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
>>>> +	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
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
>>> If I understand correctly this changes three things:
>>>
>>> 1. use system workqueue instead of custom one
>>>
>>> should be fine with the cwmq's we have nowadays
>>>
>>>
>>> 2. use non-freezable workqueue
>>>
>>>     ``WQ_FREEZABLE``
>>>       A freezable wq participates in the freeze phase of the system
>>>       suspend operations.  Work items on the wq are drained and no
>>>       new work item starts execution until thawed.
>>>
>>> I'm not entirely sure what the impact of this is.
>>>
>>> I imagine suspend is potentially quicker because the wq isn't drained,
>>> but could works that execute during the suspend phase be a problem?
>> I did not check if the suspend is quicker, but I will try to simulate
>> and check these scenarios.
>> I just wanted to get rid of another workqueue in the system.
> 
> Are you sure that freezable vs. non-freezable isn't a problem? I
> suppose there was a reason WQ_FREEZABLE was chosen initially, so I
> don't know if it is still valid.
IMO there is no need to call governors for devfreq devices during
suspend. I have added new functionality in devfreq which sets
  frequency to a marked 'opp-suspend' during suspend.
Even if the devices does not choose the opp-suspend, the governor
calculation and OPP pick-up may be skipped during suspend.
> 
>>> 3. use delayed work instead of deferrable work
>>>
>>> I hadn't come across deferrable work yet:
>> Me neither, but using it to run governors is not the best idea.
>>>
>>>     "Add a new deferrable delayed work init.  This can be used to schedule work
>>>     that are 'unimportant' when CPU is idle and can be called later, when CPU
>>>     eventually comes out of idle."
>>>
>>>     28287033e124 ("Add a new deferrable delayed work init")
>>>
>>> The commit message mentions that frequency changes were missed due to
>>> deferred works being scheduled on an idle CPU. The change to a delayed
>>> work seems reasonable to me.
>> It is not only the Dynamic Memory Controller and DRAM affected.
>> The drivers for GPUs, Network on Chip, cache L3 rely on it.
>> They all are missing opportunity to check the HW state and react.
>>
>>>
>>> It could make sense to split this change into two patches, one for the
>>> change from deferrable to delayed work, and another for custom workqueue
>>> to system workqueue (and possibly even a third, transitory change for
>>> freezable to non-freezable, if it's confirmed that that's the right
>>> thing to do).
>> OK, I will split the patch into two: one with delayed work and one with
>> regular system workqueue.
>> I thought that one patch would be simpler to apply to stable tree if needed.
> 
> It's not strictly needed and preferences of different maintainers may
> vary (I'm not a maintainer myself). Splitting up a patch may help
> getting parts of it landed, while others are still under
> discussion. E.g. in this case I'd expect 'deferrable => delayed work'
> to be non-controversial (and IIUC it fixes the issue you want to
> address), the same if probably true for 'custom workqueue => system
> workqueue', however freezable vs. non-freezable might need more
> discussion (though it probably won't be lengthy). And you separate the
> fix of an actual problems from unrelated improvements, which IMO is
> preferable, though there is no hard rule.
> 
> Applying a single (simple) patch to stable should indeed be slightly
> less work, but I wouldn't expect a short series to cause a huge
> overhead. And Greg/stable maintainers might chose to just to take the
> one patch with the actual fix and not the 'improvements'.
Thank you for the explanation. As you recommended, I will keep the
changes in separate patches. It would be easer to verify an impact on
the system for some devfreq users like GPU developers.

Regards,
Lukasz
> 
> Cheers
> 
> Matthias
> 
> 
