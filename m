Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F62C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A072146D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pbLQRMPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A072146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeLEAJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:09:45 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:19333 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeLEAJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:09:44 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181205000941epoutp03162469c6aa70d2b67fd03a3c23b48f86~tRz6sWV5d2161921619epoutp039;
        Wed,  5 Dec 2018 00:09:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181205000941epoutp03162469c6aa70d2b67fd03a3c23b48f86~tRz6sWV5d2161921619epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543968581;
        bh=S+QT0DZsFYe1xVEY8vxx3e2XiJylriJ1xvs0T7i23kQ=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=pbLQRMPYjhcf8AQw4oC2fVBTn3I5BGZlusoJ/xsQhp9sTWuYt98Kuz07SIf8pBaHz
         nvqByUlIBa2JuW8t3vOiVOJgycYWOwOftVSjmC+BiiuqBVBASlz8cXlAwMvSb8UhdB
         cI1GOS+C/Q7LpatVy2tcLcQG0qEtt/p0JONqpjH0=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181205000938epcas1p3882db0e0d5885f6e74abcf818386dfe0~tRz3777Ei1857018570epcas1p3-;
        Wed,  5 Dec 2018 00:09:38 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.3A.04060.247170C5; Wed,  5 Dec 2018 09:09:38 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181205000937epcas1p18e44f236dbc6ab59bd589cddda184591~tRz3LEkwy0638406384epcas1p1y;
        Wed,  5 Dec 2018 00:09:37 +0000 (GMT)
X-AuditID: b6c32a37-411ff70000000fdc-68-5c071742d415
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.24.03601.147170C5; Wed,  5 Dec 2018 09:09:37 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJ800MV4LS0DG10@mmp1.samsung.com>; Wed, 05 Dec 2018 09:09:37 +0900 (KST)
Message-id: <5C071740.7090000@samsung.com>
Date:   Wed, 05 Dec 2018 09:09:36 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 2/5] devfreq: add support for suspend/resume of a
 devfreq device
In-reply-to: <7662d626-5c3e-aec5-05e4-c6cd2e56ef49@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjOud+QlV2qyJF91bvMCKTApVaOxi5mI/NmI47EZB+MyO7gDkg/
        11vccEuGY+DGGGXikKGsLuBioIBWhhbqiLWoYZsoBreM1f3AEaYMO1DK4iBrezHj3/s+7/O8
        73mfcw6Dq0NUClNucUh2i2jiqHii/0Jqpva5ZLowa/9EBjr/XSo61dJLojOnFkjkClwhUXV7
        L4V+/MyMnJN3cDQ6epJGP300Q6Nfqx5HrYfOYcgzeYNE1weOUmj+8wBALaPfY6g7EKTR8Z+v
        YWhi/wkKBUeGIz1+GCNRzbkAjWq7QiSauXqT2JEs9A/2k4L7azcQjlRdI4RG5xwQ2n1/YoKn
        81NKGGpz08Lpjg+F5Yu0cH7Whwl94wcIoaGvEwgnusK0MO95Mj+hwLi9TBJLJLtGshRbS8ot
        pQbupd1Fzxfpt2TxWn4ryuE0FtEsGbjcvHztC+WmyPqcZq9oqohA+aIsc5nPbrdbKxySpswq
        OwycZCsx2bbaMmTRLFdYSjOKreZtfFZWtj5CfNNY9tvUA8IWznlvuGmWrAKHtXUgjoHsZtgx
        XUPVgXhGzZ4FsP66fyUJA9jcPQcesuavVtNKYRDApoGFWEHFJsLFpptEHWAYnH0KBsaMURhn
        U+H0vYOEwg8C2HJ3jlD4aTAU7MajMcE+A5cX/4rhVAQfmv6FisaPshvg+OJkrH8S+xr0uhZi
        g9eyowC6vT4smuBsDQ6XQ30xxRr2dTjS/kesaxy7E/puNZNREmSXaDjec4ZUdsiFF28rAsiu
        gbcv9dHRY0P2MTg2bFD4BwC8N129Im4EMDRyGlMEOjj1TR2mLJcAZ+/Xk4pYBT+pVSsUATbU
        96x49ACDS/96sUbwROsqm1r/t6l1lU3HAN4J1kk22VwqybxNt/oCPSD22tNyzoKTV/L8gGUA
        94gKHqIK1aS4V640+wFkcG6tKhCOQKoSsXKfZLcW2StMkuwH+ojLX+ApScXWyN+xOIp4fbZO
        p0Ob+S16nueSVbdS2t5Qs6WiQzJKkk2yP9RhTFxKFfhKqhm43OzeNT/8yqUd3sMN/m0f7/n7
        2+a8jmBhopMpuO9JX58+kX6H68DCLufTmbXH3tq0IZHeuZFeEgxf7vMYChzvT71bvTGpIWl9
        743stldntL7dL67bVJAwePloQNPZ9faFu/b4f1wOY63OPtfe8rLX6SI/eOc4sYcZ+r2nciSX
        I+QykU/D7bL4H+035w4DBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t9jAV1HcfYYg96zZhYHt2pabJyxntVi
        +8ZvrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+xmpxedcc
        NovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOrxZsL91gc
        xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
        udrO4tG3ZRWjx4rV39k9Pm+SC+CL4rJJSc3JLEst0rdL4Mq48+w3S8F384qjk9+xNjBO1+1i
        5OSQEDCR+HyhmR3EFhLYyShxdrEYiM0rICjxY/I9li5GDg5mAXmJI5eyIUx1iSlTcrsYuYCq
        7zNKNJ7fzAZRriXx4e5aZhCbRUBV4t+PtywgNhtQfP+LG2A1/AKKEld/PGYEmSMqECHRfaIS
        ZI6IwHlGiYN9nawgNcwCrcwSj9qyQGxhgUiJU4ufMkMs+80ksewaRBGngLvEnifTWCcwCsxC
        cuoshFNnIZy6gJF5FaNkakFxbnpusVGBYV5quV5xYm5xaV66XnJ+7iZGYFxvO6zVt4Px/pL4
        Q4wCHIxKPLwKs9lihFgTy4orcw8xSnAwK4nwHvkOFOJNSaysSi3Kjy8qzUktPsQozcGiJM57
        O+9YpJBAemJJanZqakFqEUyWiYNTqoGxmvGA5+NFc1du3LNgEadt4M5MpRDGpXfuXhdQW8+7
        OZAvrqmWtzE+SrvyhW3siv91msm99hf2f+9+2PEiXjV1g/MVa7U8uYm8a0MLoi5f38zB+/SI
        t8/ig+c/r91tt01xcyIj64lglQp2zx0Mu/03SSRnVsdaCF1tOpC8d/uDR8WJvtz7KucosRRn
        JBpqMRcVJwIA60wOCecCAAA=
X-CMS-MailID: 20181205000937epcas1p18e44f236dbc6ab59bd589cddda184591
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
        <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
        <5C06124B.5030409@samsung.com> <5C06140E.7010603@samsung.com>
        <5C061A57.7040002@samsung.com>
        <7662d626-5c3e-aec5-05e4-c6cd2e56ef49@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 2018년 12월 04일 18:53, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 12/4/18 7:10 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> I add the comment about 'suspend_count'.
>>
>> On 2018년 12월 04일 14:43, Chanwoo Choi wrote:
>>> Hi,
>>>
>>> On 2018년 12월 04일 14:36, Chanwoo Choi wrote:
>>>> Hi Lukasz,
>>>>
>>>> Looks good to me. But, I add the some comments.
>>>> If you will fix it, feel free to add my tag:
>>>> Reviewed-by: Chanwoo choi <cw00.choi@samsung.com>
>>>
>>> Sorry. Fix typo 'choi' to 'Choi' as following.
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>
>>>>
>>>> On 2018년 12월 03일 23:31, Lukasz Luba wrote:
>>>>> The patch prepares devfreq device for handling suspend/resume
>>>>> functionality.  The new fields will store needed information during this
>>>>
>>>> nitpick. Remove unneeded space. There are two spaces between '.' and 'The new'.
>>>>
>>>>> process.  Devfreq framework handles opp-suspend DT entry and there is no
>>>>
>>>> ditto.
>>>>
>>>>> need of modyfications in the drivers code.  It uses atomic variables to
>>>>
>>>> ditto.
>>>>
>>>>> make sure no race condition affects the process.
>>>>>
>>>>> The patch is based on earlier work by Tobias Jakobi.
>>>>
>>>> Please remove it from each patch description.
>>>>
>>>>>
>>>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>>> ---
>>>>>   drivers/devfreq/devfreq.c | 51 +++++++++++++++++++++++++++++++++++++++--------
>>>>>   include/linux/devfreq.h   |  7 +++++++
>>>>>   2 files changed, 50 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index a9fd61b..36bed24 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -316,6 +316,10 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>>>>>   			"Couldn't update frequency transition information.\n");
>>>>>   
>>>>>   	devfreq->previous_freq = new_freq;
>>>>> +
>>>>> +	if (devfreq->suspend_freq)
>>>>> +		devfreq->resume_freq = cur_freq;
>>>>> +
>>>>>   	return err;
>>>>>   }
>>>>>   
>>>>> @@ -667,6 +671,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>>>   	}
>>>>>   	devfreq->max_freq = devfreq->scaling_max_freq;
>>>>>   
>>>>> +	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>>>>> +	atomic_set(&devfreq->suspend_count, 0);
>>>>> +
>>>>>   	dev_set_name(&devfreq->dev, "devfreq%d",
>>>>>   				atomic_inc_return(&devfreq_no));
>>>>>   	err = device_register(&devfreq->dev);
>>>>> @@ -867,14 +874,28 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>>>>    */
>>>>>   int devfreq_suspend_device(struct devfreq *devfreq)
>>>>>   {
>>>>> +	int ret;
>>>>> +
>>>>>   	if (!devfreq)
>>>>>   		return -EINVAL;
>>>>>   
>>>>> -	if (!devfreq->governor)
>>>>> -		return 0;
>>>>> +	if (devfreq->governor) {
>>>>> +		ret = devfreq->governor->event_handler(devfreq,
>>>>> +					DEVFREQ_GOV_SUSPEND, NULL);
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +	}
>>>>> +
>>>>> +	if (devfreq->suspend_freq) {
>>>>> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
>>>>> +			return 0;
>>>>> +
>>>>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +	}
>>
>> In this patch, if some users call 'devfreq_suspend_device' twice,
>> 'devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_SUSPEND, NULL)'
>> is called twice but devfreq_set_target() is called only one.
>> I knew that it is no problem for operation.
>>
>> But,
>> I think that you better to use 'suspend_count' as the reference count
>> of devfreq_suspend/resume_device(). But, if you use 'suspend_count'
>> in order to check whether this devfreq is suspended or not,
>> we can reduce the unneeded redundant call when calling it twice.
>>
>> clock and regulator used the 'reference count' method in order to
>> remove the redundant call.
> 
> I think I've got the point. I will move the atomic check just
> after the !devfreq check. Something like the code bellow is what you
> would like to see?
> ---8<-----
> if (!devfreq)
> 	return -EINVAL;
> if (atomic_inc_return(&devfreq->suspend_count) > 1)
> 	return0;

Looks good to me. I agree.

> 
> ---->8-------
>>
>>
>>>>>   
>>>>> -	return devfreq->governor->event_handler(devfreq,
>>>>> -				DEVFREQ_GOV_SUSPEND, NULL);
>>>>> +	return 0;
>>>>>   }
>>>>>   EXPORT_SYMBOL(devfreq_suspend_device);
>>>>>   
>>>>> @@ -888,14 +909,28 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>>>>    */
>>>>>   int devfreq_resume_device(struct devfreq *devfreq)
>>>>>   {
>>>>> +	int ret;
>>>>> +
>>>>>   	if (!devfreq)
>>>>>   		return -EINVAL;
>>>>>   
>>>>> -	if (!devfreq->governor)
>>>>> -		return 0;
>>>>> +	if (devfreq->resume_freq) {
>>>>> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>>>>> +			return 0;
>>
>> ditto.
> Same approach here:
> ---8<-----
> if (!devfreq)
> 	return -EINVAL;
> if (atomic_dec_return(&devfreq->suspend_count) >= 1)
> 	return 0;

Looks good to me.

> ---->8-------
> 
> Regards,
> Lukasz
>>
>>>>>   
>>>>> -	return devfreq->governor->event_handler(devfreq,
>>>>> -				DEVFREQ_GOV_RESUME, NULL);
>>>>> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +	}
>>>>> +
>>>>> +	if (devfreq->governor) {
>>>>> +		ret = devfreq->governor->event_handler(devfreq,
>>>>> +					DEVFREQ_GOV_RESUME, NULL);
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>>   }
>>>>>   EXPORT_SYMBOL(devfreq_resume_device);
>>>>>   
>>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>>> index e4963b0..d985199 100644
>>>>> --- a/include/linux/devfreq.h
>>>>> +++ b/include/linux/devfreq.h
>>>>> @@ -131,6 +131,9 @@ struct devfreq_dev_profile {
>>>>>    * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>>>>    * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>>>>    * @stop_polling:	 devfreq polling status of a device.
>>>>> + * @suspend_freq:	 frequency of a device set during suspend phase.
>>>>> + * @resume_freq:	 frequency of a device set in resume phase.
>>>>> + * @suspend_count:	 suspend requests counter for a device.
>>>>>    * @total_trans:	Number of devfreq transitions
>>>>>    * @trans_table:	Statistics of devfreq transitions
>>>>>    * @time_in_state:	Statistics of devfreq states
>>>>> @@ -167,6 +170,10 @@ struct devfreq {
>>>>>   	unsigned long scaling_max_freq;
>>>>>   	bool stop_polling;
>>>>>   
>>>>> +	unsigned long suspend_freq;
>>>>> +	unsigned long resume_freq;
>>>>> +	atomic_t suspend_count;
>>>>> +
>>>>>   	/* information for device frequency transition */
>>>>>   	unsigned int total_trans;
>>>>>   	unsigned int *trans_table;
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
