Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B27DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCB820870
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m1HW2EvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCB820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeKZLMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:12:05 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:51565 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKZLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:12:05 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181126001939epoutp0272877535dfe2dc7232dfb045520f17a2~qhJDNO_t92441024410epoutp02m;
        Mon, 26 Nov 2018 00:19:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181126001939epoutp0272877535dfe2dc7232dfb045520f17a2~qhJDNO_t92441024410epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543191579;
        bh=lnL0VXzsqGUE0tz4xEDY25dnxeyeeaWwzm/ipnX5D2A=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=m1HW2EvWRv8FZEtBnjtJCDrnP+TD9FNBnLnVqG033oxGTLZUXK8FRuoooRDeYhvvQ
         qy85YOFbys8slVzg/OAlpshfmIy1NbQzhTBSC/VGKnRNgeHr7ntPupBB4r/FGkEyTu
         1EF/goFD33lxgzSPnfSliiLiy8Ti7XOedzpkEl7E=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181126001937epcas1p30850dfcda0cb3844ee3ecdb2515c0848~qhJBJIncm2137321373epcas1p3a;
        Mon, 26 Nov 2018 00:19:37 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.D1.04060.91C3BFB5; Mon, 26 Nov 2018 09:19:37 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181126001936epcas2p3c3b30693e362cc2e020e7876fa72648a~qhI-5-UhI2199821998epcas2p3L;
        Mon, 26 Nov 2018 00:19:36 +0000 (GMT)
X-AuditID: b6c32a46-b45ff70000000fdc-5e-5bfb3c19ea0f
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.92.03627.71C3BFB5; Mon, 26 Nov 2018 09:19:36 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PIR0051LY8N0410@mmp1.samsung.com>; Mon, 26 Nov 2018 09:19:35 +0900 (KST)
Message-id: <5BFB3C17.40502@samsung.com>
Date:   Mon, 26 Nov 2018 09:19:35 +0900
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
Subject: Re: [PATCH 3/6] devfreq: add support for suspend/resume of a
 devfreq device
In-reply-to: <734d0941-c885-4d36-274b-23843d6626c1@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJsWRmVeSWpSXmKPExsWy7bCmqa6kze9og+/7ZS0ObtW02DhjPavF
        9o3fWC3mHznHatG8eD2bxZnuXIv+x6+ZLc6f38BucbbpDbvFrQYZi1lT9jJZbHp8jdXi8q45
        bBafe48wWsw4v4/JYu2Ru+wWS69fZLK43biCzeLuqaNAM05fYrVo3XuE3aJt9QdWizcX7rE4
        iHts272N1WPNvDWMHrMbLrJ4TOj/xOixeM9LJo9NqzrZPPbPXcPusXlJvce/Y+weB9/tYfLY
        crWdxaNvyypGjxWrv7N7fN4kF8AXlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA/S+kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCv
        ODG3uDQvXS85P9fK0MDAyBSoMCE7Y8W1nWwF29Qrbnw8xtzAOEG+i5GTQ0LAROLomilsXYxc
        HEICOxglvr17wQ7hfGeUmPRoARtMVcfDLqjEbkaJZS+ns4AkeAUEJX5Mvgdkc3AwC8hLHLmU
        DRJmFtCUePFlEgtE/V1Gid6Ne9gg6jUk9jxbyg5iswioSsztecwEYrMJaEnsf3EDrIZfQFHi
        6o/HjCC2qECExM7538AWiwicZ5RYs3MPE4jDLNDKLPHvwxawDmGBMIkVe36ATeUUcJdYOm0z
        K0iRhEAjh8TCSauZIX5wkZhx4BwLhC0s8er4FnYIW1ri2aqNjBAN7YwSX140Q3VPYJT4cGoz
        E0SVscSzhV1MEN/xSXQc/ssO8rSEAK9ER5sQRImHxOErDdBAmsks8X/aKfYJjLKzkMJpFiKc
        ZiGF0wJG5lWMYqkFxbnpqcVGBUbIMbiJEZzctdx2MC4553OIUYCDUYmHd8KvX9FCrIllxZW5
        hxglOJiVRHg/Gv2OFuJNSaysSi3Kjy8qzUktPsRoCgzmicxSosn5wMyTVxJvaGpkbGxsYWpu
        aWxgqSTO+1B6brSQQHpiSWp2ampBahFMHxMHp1QDYw/nrs7385/8alugvkndwdrEi/N+Mde6
        ikXNU2rbcnM3N7oclRRc2sD7+H51ctCLOnXJXR2fAxRf74uXZPxtn6y86mTexbdc2t7Rl5wO
        3S7bszO4mN9tw5SinH82m/gfr4ny26vIvdF6+5GiLtX9m+59NJ7V9KLbyvRPypOookwlK9Ol
        /0LeKrEUZyQaajEXFScCANdCx10EBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t9jAV0Jm9/RBodvc1sc3KppsXHGelaL
        7Ru/sVrMP3KO1aJ58Xo2izPduRb9j18zW5w/v4Hd4mzTG3aLWw0yFrOm7GWy2PT4GqvF5V1z
        2Cw+9x5htJhxfh+Txdojd9ktll6/yGRxu3EFm8XdU0eBZpy+xGrRuvcIu0Xb6g+sFm8u3GNx
        EPfYtnsbq8eaeWsYPWY3XGTxmND/idFj8Z6XTB6bVnWyeeyfu4bdY/OSeo9/x9g9Dr7bw+Sx
        5Wo7i0ffllWMHitWf2f3+LxJLoAvissmJTUnsyy1SN8ugStjxbWdbAXb1CtufDzG3MA4Qb6L
        kZNDQsBEouNhF3sXIxeHkMBORondD86xgSR4BQQlfky+x9LFyMHBLCAvceRSNoSpLjFlSi5E
        +X1GiaaHd5kgyjUk9jxbyg5iswioSszteQwWZxPQktj/4gbYSH4BRYmrPx4zgswRFYiQ6D5R
        CTJHROA8o8TBvk5WkBpmgVZmiUdtWSC2sECYRFfPX6jbZjJLXPh0gREkwSngLrF02mbWCYwC
        s5CcOgvh1FkIpy5gZF7FKJlaUJybnltsVGCUl1quV5yYW1yal66XnJ+7iREY2dsOa/XvYHy8
        JP4QowAHoxIP74s/v6KFWBPLiitzDzFKcDArifB+NPodLcSbklhZlVqUH19UmpNafIhRmoNF
        SZyXP/9YpJBAemJJanZqakFqEUyWiYNTqoHRWGR7LIdn6ZPPDr6z/sRtE/yc27T+4KlzVnnG
        ve/25f4z1pTwdz5U8OJkccEap/rC0oCgb/MWzTfIMHkUZzZvh838z3Mm/ZB53FX9tfzrQevE
        FzNVtbgYeW6/WHtQNEbl+qTu6b+dXUV4Gi8kJays+lYw72XQJc3vTWHCXxVnbzA7bsewZWO4
        EktxRqKhFnNRcSIAfHps3egCAAA=
X-CMS-MailID: 20181126001936epcas2p3c3b30693e362cc2e020e7876fa72648a
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382@eucas1p1.samsung.com>
        <1542823301-23563-4-git-send-email-l.luba@partner.samsung.com>
        <5BF61B3A.9050402@samsung.com>
        <cce4f194-b574-a12c-e876-f11a6f245940@partner.samsung.com>
        <5BF7419E.90006@samsung.com>
        <734d0941-c885-4d36-274b-23843d6626c1@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

I add the one more comment for devfreq_resume_device()

On 2018년 11월 23일 19:01, Lukasz Luba wrote:
> Hi Chanwoo Choi,
> 
> On 11/23/18 12:54 AM, Chanwoo Choi wrote:
>> Hi Lukasz,
>>
>> I add one more comment about devfreq_resume_device().
>>
>> On 2018년 11월 22일 20:00, Lukasz Luba wrote:
>>>
>>>
>>> On 11/22/18 3:58 AM, Chanwoo Choi wrote:
>>>> On 2018년 11월 22일 03:01, Lukasz Luba wrote:
>>>>> The patch adds support for handling suspend/resume process.
>>>>> It uses atomic variables to make sure no race condition
>>>>> affects the process.
>>>>>
>>>>> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>>>>> solve issue with devfreq device's frequency during suspend/resume.
>>>>> During the discussion on LKML some corner cases and comments appeared
>>>>> related to the design. This patch address them keeping in mind suggestions
>>>>> from Chanwoo Choi.
>>>>
>>>> Please remove the duplicate information about patch history.
>>>>
>>>>>
>>>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>>> ---
>>>>>    drivers/devfreq/devfreq.c | 45 +++++++++++++++++++++++++++++++++++++++------
>>>>>    1 file changed, 39 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>>> index cf9c643..7e09de8 100644
>>>>> --- a/drivers/devfreq/devfreq.c
>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>> @@ -872,14 +872,33 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>>>>     */
>>>>>    int devfreq_suspend_device(struct devfreq *devfreq)
>>>>>    {
>>>>> -	if (!devfreq)
>>>>> -		return -EINVAL;
>>>>> +        int ret;
>>>>
>>>> Move 'ret' definition under 'if (devfreq->suspend_freq) {'
>>>> because 'ret' is used if suspend_freq isn't zero.
>>> Not only there, 6 lines above 'ret' is used for
>>> devfreq->governor->event_handler().
>>
>> OK.
>>
>>>>
>>>>> +        unsigned long prev_freq;
>>>>> +        u32 flags = 0;
>>>>> +
>>>>> +        if (!devfreq)
>>>>> +                return -EINVAL;
>>>>> +
>>>>> +        if (devfreq->governor) {
>>>>> +		ret = devfreq->governor->event_handler(devfreq,
>>>>> +					DEVFREQ_GOV_SUSPEND, NULL);
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +	}
>>>>>    
>>>>> -	if (!devfreq->governor)
>>>>> -		return 0;
>>>>> +	if (devfreq->suspend_freq) {
>>>>> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
>>>>> +			return 0;
>>>>>    
>>>>> -	return devfreq->governor->event_handler(devfreq,
>>>>> -				DEVFREQ_GOV_SUSPEND, NULL);
>>>>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq,
>>>>> +					 &prev_freq, flags);
>>>>
>>>> Remove the 'prev_freq' parameter.
>>> OK
>>>>
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +
>>>>> +		devfreq->resume_freq = prev_freq;
>>>>
>>>> As I commented on patch2, if devfreq_set_taget save the current frequency
>>>> to 'devfreq->resume_freq', this line is not needed.
>>> OK
>>>>
>>>>
>>>>> +	}
>>>>> +
>>>>> +        return 0;
>>>>>    }
>>>>>    EXPORT_SYMBOL(devfreq_suspend_device);
>>>>>    
>>>>> @@ -893,9 +912,23 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>>>>     */
>>>>>    int devfreq_resume_device(struct devfreq *devfreq)
>>>>>    {
>>>>> +        int ret;
>>>>
>>>> Move 'ret' definition under 'if (devfreq->suspend_freq) {'
>>>> because 'ret' is used if suspend_freq isn't zero.
>>> OK
>>
>> If you change the devfreq_resume_device() according to my new comment,
>> please ignore it.
>>
>>>>
>>>>> +        unsigned long prev_freq;
>>>>
>>>> Remove prev_freq variable which is not used on this function.
>>>> After calling devfreq_set_target, prev_freq is not used.
>>> OK
>>>>
>>>>> +        u32 flags = 0;
>>>>> +
>>>>>    	if (!devfreq)
>>>>>    		return -EINVAL;
>>>>>    
>>>>> +	if (devfreq->suspend_freq) {

In devfreq_resume_device(), it should check the 'devfreq->resume_freq'
instead of 'devfreq->suspend_freq'.


>>>>> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>>>>> +			return 0;
>>>>> +
>>>>> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq,
>>>>> +					 &prev_freq, flags);
>>>>
>>>> Remove the 'prev_freq' parameter.
>>> OK
>>>>
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +	}
>>>>> +
>>>>>    	if (!devfreq->governor)
>>>>>    		return 0;
>>
>> Please change the code as following because you uses the following type
>> in the devfreq_suspend_device(). If there is any special issue, please
>> keep the same format in order to improve the readability.
>>
>> 	if (devfreq->governor) {
>> 		ret = devfreq->governor->event_handler(devfreq,
>> 				DEVFREQ_GOV_RESUME, NULL);
>> 		if (ret)
>> 			return ret;
>> 	}
>>
>>
> OK, I will change the code to keep the same format.
> Thank you for the review.
> 
> Regards,
> Lukasz
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
