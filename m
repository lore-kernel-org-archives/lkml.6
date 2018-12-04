Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D9CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821E0214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MAbq23BF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821E0214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeLDGKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:10:39 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:31292 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLDGKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:10:39 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181204061035epoutp043fa0a03cdb3b86d09221b5c6bfa275a8~tDFu8GR8P0722507225epoutp04s;
        Tue,  4 Dec 2018 06:10:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181204061035epoutp043fa0a03cdb3b86d09221b5c6bfa275a8~tDFu8GR8P0722507225epoutp04s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543903835;
        bh=4+VwYZ6Xyo7nNuBKziSikLxXqYyXpf8jpntNyG8EGtE=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=MAbq23BFiN2RkvqxutGgL6TJ3okS3W4AaIkehi7Zx1iOunWnZcV3md7NvzTVdBU0v
         v1rMZYGhy+La5JDYyrEEtWs8ttl+iAvpMCE51TCkf/tXwR2hsfS3/MsyKOpX5pBSLj
         GA5PZWLP4uaSMyxkhxKRnCmG9acnKCDYJhIWRp4A=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181204061032epcas1p2ede234c97ac4ebe289e0e2e7732cea0d~tDFsjsyc-2154021540epcas1p2D;
        Tue,  4 Dec 2018 06:10:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.56.04058.85A160C5; Tue,  4 Dec 2018 15:10:32 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181204061031epcas1p35234fb21941830b2ff1dd5920aff0709~tDFrvsBN_1960219602epcas1p3M;
        Tue,  4 Dec 2018 06:10:31 +0000 (GMT)
X-AuditID: b6c32a35-e37ff70000000fda-c8-5c061a58bcec
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 9C.B2.03601.75A160C5; Tue,  4 Dec
        2018 15:10:31 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJ700CVJ7TJ6J50@mmp2.samsung.com>; Tue, 04 Dec 2018 15:10:31 +0900 (KST)
Message-id: <5C061A57.7040002@samsung.com>
Date:   Tue, 04 Dec 2018 15:10:31 +0900
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
In-reply-to: <5C06140E.7010603@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTVxjHd+47ZsW7ovOkzg2v2ZZikF5q2XGx27Khu4nGsLkPTFi6O7gD
        Qt/opW5scat1qKBTdCZrOhANLjFQAUuBluELrMykG1ZqmIQNl7U6cSpphKmZmVvLjRnfnuc5
        v/9zzv855zC4+g6lYaqstZLDKpo5ahHR9702L7dYQ5Xq9t5chYZ6tei0p4tE/afvkag1fJFE
        u9q6KPTTPgs6mLiFo2i0m0aj7ts0mnQ9g7xHzmDIn/iZRJcHmik0+2UYIE/0LIZOhado9O2V
        MQz9svMkhaYiI6keP8ZIVH8mTKPdHUkS3b50lXhtmdD3XR8p+I76gPCNa4wQmg7eBULb4E1M
        8Lc3UMK5Fh8t9Jz4XHj0Ay0MzQxiQmB8DyEcCLQD4WTHfVqY9T9blLmten2lJJZLjmzJWmYr
        r7JWGLlNW01vmAwFOj6XX4de4rKtokUycoWbi3I3VplT9rns7aLZmSoVibLM5b2y3mFz1krZ
        lTa51shJ9nKzfZ19jSxaZKe1Yk2ZzfIyr9PlG1Lg+9WVA0P1pN2b93HvwHXgAp4XGkEGA9m1
        0B3vJxvBIkbNBgH0J+NEekHN3gdwzLf8MTS1rw9X6t0Aus+WpGMV+xR88NXVFM8wOPscDMeq
        02Wc1cLpucOE0nMKwNFIPa3wOXCk4wZIxwT7PEyON8/vRaXq56YnqHS8mF0Jxx8k5pmlbDEM
        td6j042WsFEAfaFBLJ3gbD0OHyUD84os9l0YabuOp0+Rwa6GvzesSjOQ3cnAwN3LQHFQCCcf
        HqaUOAv+eSFAp3nILoexEaPC7wFwbnoXqSRNACYjPZgi0MM/jjdiirdMOPPXflIRq+De3WoF
        EeCB/Z20YrkFg71dXxBNYIV3wZS8/0/Ju2BKxwDeDp6W7LKlQpJ5O7/w9vxg/qnnGILgyMXN
        w4BlAPekyvM6Waomxe1ynWUYQAbnlqjsNUSpWlUu1n0iOWwmh9MsycPAkBryIVyztMyW+jjW
        WhNvyNfr9WgtX2DgeW6Z6pqmpUTNVoi1UrUk2SXHYx3GZGhcoLO5ZiQ3qnWLkzZn0Pd27J07
        qxNXut4rToY0v754PpE1s3VD8HyPflPcQxS4Fne35SUbvu6XRkOX8lcEZ1dataEtA39/Nqme
        ezXTN/HWbPzGLV1mcsdH1vih8X+v5ZS8+bDwnwj5QfGg+zfpgm2i1dhpqjtV82nTjqMbNCe2
        xT584jhHyJUin4M7ZPE/Ee5iigAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t9jQd1wKbYYg2dfjC0ObtW02DhjPavF
        9o3fWC3mHznHatG8eD2bxZnuXIv+x6+ZLc6f38BucbbpDbvFrQYZi1lT9jJZbHp8jdXi8q45
        bBafe48wWsw4v4/JYu2Ru+wWS69fZLK43biCzeLuqaNAM05fYrVo3XuE3aJt9QdWizcX7rE4
        iHts272N1WPNvDWMHrMbLrJ4TOj/xOixeM9LJo9NqzrZPPbPXcPusXlJvce/Y+weB9/tYfLY
        crWdxaNvyypGjxWrv7N7fN4kF8AXxWWTkpqTWZZapG+XwJWx62Ara8Es/Yqtu54yNjDOUOti
        5OSQEDCRuNu9jbmLkYtDSGAdo8Sloz8YQRK8AoISPybfY+li5OBgFpCXOHIpG8JUl5gyJRei
        /D6jxIKWM8wQ5VoSR1c/B2tlEVCV+HB1DguIzQYU3//iBhuIzS+gKHH1x2NGkDmiAhES3Scq
        QeaICJxnlDjY18kKUsMs0Mos8agtC8QWFoiUOLX4Kdh8IYG5TBJtzcYgvZwC2hIPO5UnMArM
        QnLoLIRDZyEcuoCReRWjZGpBcW56brFRgWFearlecWJucWleul5yfu4mRmBUbzus1beD8f6S
        +EOMAhyMSjy8M5xYY4RYE8uKK3MPMUpwMCuJ8BYUssQI8aYkVlalFuXHF5XmpBYfYpTmYFES
        572ddyxSSCA9sSQ1OzW1ILUIJsvEwSnVwOjNv+z7+6sXvlyPKWcJXVCc2+DD8Dfm6cvE3/c3
        VZvKbXTdclnlyHzFEkGra9O8hI3frQ+KqFg22f23dRPPk0fOX9w0m37/OPry5uOzBrdSpHv3
        fg2u/XY1XHVei3nK6xLGkkUVj4SY799gW7TOkyl0YVfV18zpdnfvrpj6ZAeD0VRV9veh3lxK
        LMUZiYZazEXFiQAcnK+25gIAAA==
X-CMS-MailID: 20181204061031epcas1p35234fb21941830b2ff1dd5920aff0709
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
        <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
        <5C06124B.5030409@samsung.com> <5C06140E.7010603@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

I add the comment about 'suspend_count'.

On 2018년 12월 04일 14:43, Chanwoo Choi wrote:
> Hi,
> 
> On 2018년 12월 04일 14:36, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> Looks good to me. But, I add the some comments.
>> If you will fix it, feel free to add my tag:
>> Reviewed-by: Chanwoo choi <cw00.choi@samsung.com>
> 
> Sorry. Fix typo 'choi' to 'Choi' as following.
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
>>
>> On 2018년 12월 03일 23:31, Lukasz Luba wrote:
>>> The patch prepares devfreq device for handling suspend/resume
>>> functionality.  The new fields will store needed information during this
>>
>> nitpick. Remove unneeded space. There are two spaces between '.' and 'The new'. 
>>
>>> process.  Devfreq framework handles opp-suspend DT entry and there is no
>>
>> ditto.
>>
>>> need of modyfications in the drivers code.  It uses atomic variables to
>>
>> ditto.
>>
>>> make sure no race condition affects the process.
>>>
>>> The patch is based on earlier work by Tobias Jakobi.
>>
>> Please remove it from each patch description.
>>
>>>
>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>  drivers/devfreq/devfreq.c | 51 +++++++++++++++++++++++++++++++++++++++--------
>>>  include/linux/devfreq.h   |  7 +++++++
>>>  2 files changed, 50 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index a9fd61b..36bed24 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -316,6 +316,10 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>>>  			"Couldn't update frequency transition information.\n");
>>>  
>>>  	devfreq->previous_freq = new_freq;
>>> +
>>> +	if (devfreq->suspend_freq)
>>> +		devfreq->resume_freq = cur_freq;
>>> +
>>>  	return err;
>>>  }
>>>  
>>> @@ -667,6 +671,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  	}
>>>  	devfreq->max_freq = devfreq->scaling_max_freq;
>>>  
>>> +	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>>> +	atomic_set(&devfreq->suspend_count, 0);
>>> +
>>>  	dev_set_name(&devfreq->dev, "devfreq%d",
>>>  				atomic_inc_return(&devfreq_no));
>>>  	err = device_register(&devfreq->dev);
>>> @@ -867,14 +874,28 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>>   */
>>>  int devfreq_suspend_device(struct devfreq *devfreq)
>>>  {
>>> +	int ret;
>>> +
>>>  	if (!devfreq)
>>>  		return -EINVAL;
>>>  
>>> -	if (!devfreq->governor)
>>> -		return 0;
>>> +	if (devfreq->governor) {
>>> +		ret = devfreq->governor->event_handler(devfreq,
>>> +					DEVFREQ_GOV_SUSPEND, NULL);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	if (devfreq->suspend_freq) {
>>> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
>>> +			return 0;
>>> +
>>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
>>> +		if (ret)
>>> +			return ret;
>>> +	}

In this patch, if some users call 'devfreq_suspend_device' twice,
'devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_SUSPEND, NULL)'
is called twice but devfreq_set_target() is called only one.
I knew that it is no problem for operation.

But,
I think that you better to use 'suspend_count' as the reference count
of devfreq_suspend/resume_device(). But, if you use 'suspend_count'
in order to check whether this devfreq is suspended or not,
we can reduce the unneeded redundant call when calling it twice.

clock and regulator used the 'reference count' method in order to
remove the redundant call.


>>>  
>>> -	return devfreq->governor->event_handler(devfreq,
>>> -				DEVFREQ_GOV_SUSPEND, NULL);
>>> +	return 0;
>>>  }
>>>  EXPORT_SYMBOL(devfreq_suspend_device);
>>>  
>>> @@ -888,14 +909,28 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>>   */
>>>  int devfreq_resume_device(struct devfreq *devfreq)
>>>  {
>>> +	int ret;
>>> +
>>>  	if (!devfreq)
>>>  		return -EINVAL;
>>>  
>>> -	if (!devfreq->governor)
>>> -		return 0;
>>> +	if (devfreq->resume_freq) {
>>> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>>> +			return 0;

ditto.

>>>  
>>> -	return devfreq->governor->event_handler(devfreq,
>>> -				DEVFREQ_GOV_RESUME, NULL);
>>> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	if (devfreq->governor) {
>>> +		ret = devfreq->governor->event_handler(devfreq,
>>> +					DEVFREQ_GOV_RESUME, NULL);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	return 0;
>>>  }
>>>  EXPORT_SYMBOL(devfreq_resume_device);
>>>  
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index e4963b0..d985199 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -131,6 +131,9 @@ struct devfreq_dev_profile {
>>>   * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>>   * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>>   * @stop_polling:	 devfreq polling status of a device.
>>> + * @suspend_freq:	 frequency of a device set during suspend phase.
>>> + * @resume_freq:	 frequency of a device set in resume phase.
>>> + * @suspend_count:	 suspend requests counter for a device.
>>>   * @total_trans:	Number of devfreq transitions
>>>   * @trans_table:	Statistics of devfreq transitions
>>>   * @time_in_state:	Statistics of devfreq states
>>> @@ -167,6 +170,10 @@ struct devfreq {
>>>  	unsigned long scaling_max_freq;
>>>  	bool stop_polling;
>>>  
>>> +	unsigned long suspend_freq;
>>> +	unsigned long resume_freq;
>>> +	atomic_t suspend_count;
>>> +
>>>  	/* information for device frequency transition */
>>>  	unsigned int total_trans;
>>>  	unsigned int *trans_table;
>>>
>>
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
