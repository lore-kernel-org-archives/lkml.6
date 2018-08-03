Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AA1C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801F5214AB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 00:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GH0IOzaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801F5214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbeHCB6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:58:22 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:38413 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbeHCB6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:58:22 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180803000448epoutp03ee616645b2a3b502a8efb0a424ac9cb4~HNwQBfH8F2411624116epoutp03e;
        Fri,  3 Aug 2018 00:04:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180803000448epoutp03ee616645b2a3b502a8efb0a424ac9cb4~HNwQBfH8F2411624116epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533254688;
        bh=WIlD6Kecg4MdIBGuSnc0+f03+108J8PkhoKXWtInC3g=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=GH0IOzaaZsvyl0a5pZYe8pF2g6dyjevBwqe0/TeRfEBQ3xrQO5WdQ0Y3pDbBPhAqJ
         25WW9OfwomHJH8vryc/zrbdhyv7okK3+Psuf7voAfpZZFsN9RriyuSNmyZvJVhksp1
         exlwS1bEdu3eLXvbhcIJK9BP9xM0pWRu/nBWLtGQ=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180803000445epcas1p275dd3e1d712a4e6bfa97c96b6c02c98c~HNwNVzuks2443824438epcas1p2K;
        Fri,  3 Aug 2018 00:04:45 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5E.D6.04176.D1C936B5; Fri,  3 Aug 2018 09:04:45 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180803000444epcas1p4ac2cf70ba696c9e085cc66b6cd55485a~HNwMwLt5P3182531825epcas1p4m;
        Fri,  3 Aug 2018 00:04:44 +0000 (GMT)
X-AuditID: b6c32a37-6ddff70000001050-ae-5b639c1d21c3
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id FB.82.03704.C1C936B5; Fri,  3 Aug
        2018 09:04:44 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PCU007MIYVWD360@mmp2.samsung.com>; Fri, 03 Aug 2018 09:04:44 +0900 (KST)
Message-id: <5B639C1C.40605@samsung.com>
Date:   Fri, 03 Aug 2018 09:04:44 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 04/12] PM / devfreq: Add struct devfreq_policy
In-reply-to: <4863cf97-37d9-7d81-f44b-10de3dc8267e@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmrq7snORog1+tyhZ/Jx1jt5j+5DKL
        xaaP71kt5h85x2pxdtlBNos1tw8xWjQvXs9mcbbpDbvF/a9HGS0u75rDZvG59wijxdLrF5ks
        Pm94zGhxu3EFm8Wp65/ZLM6cvsRq0br3CLvFxq8eDkIea+atYfT4/WsSo8fshossHjvuLmH0
        2LSqk83jzrU9bB77565h97hyoonVY8vVdhaPvi2rGD0+b5IL4I5KtclITUxJLVJIzUvOT8nM
        S7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBek1JoSwxpxQoFJBYXKykb2dTlF9a
        kqqQkV9cYqsUbWhopGdoYK5nZASkjWOtjEyBShJSM74c38lccF674teHS6wNjIuUuxg5OCQE
        TCRWv6nsYuTiEBLYwSgxdfZSVgjnO6PEp9nfmboYOcGKZu1fzgSR2MAo8fD4XbAEr4CgxI/J
        91hAJjELyEscuZQNEmYW0JR48WUSC0T9XUaJtiuTGEFqeAU0JK6eDgSpYRFQldi7+hkjiM0m
        oCWx/8UNNhCbX0BR4uqPx2BxUYEIiZ3zv7GD2CJArU9+n2cEmcksMI1Vonvaf7AGYQFXidm/
        5rOBzOcUsJf48zIPpEZC4BS7xMGeDkaIB1wkWlrWQz0jLPHq+BZ2iO+lJS4dtYWob2eU+PKi
        mRXCmcAo8eHUZqgGY4lnC7uYID7jk3j3tYcVoplXoqNNCKLEQ+Lhtb3QkNvEJLHm8TuWCYyy
        s5DCaBYijGYhhdECRuZVjGKpBcW56anFhgXGesWJucWleel6yfm5mxjB6VfLfAfjhnM+hxgF
        OBiVeHgvqCZHC7EmlhVX5h5ilOBgVhLhfdsJFOJNSaysSi3Kjy8qzUktPsRoCgzjicxSosn5
        wNyQVxJvaGpkbGxsYWJoZmpoqCTOa+QXHC0kkJ5YkpqdmlqQWgTTx8TBKdXAWL2faWvJlrAT
        bGIcOTPsbrh8mBq2ouTu/8+y0y8ufWmuGqunvq3Tac+GZ7dzjySphDdcu/JHdoKSmZqf2jUV
        HjNPo137Z0xoiXsfvUu9b4v2fb6rXhWb/VLkPi9mM9jX7x4SujWwPbLyT8u+lI6QKe8a94kL
        Fk+WfDpj/elDLavrprA0f9wur8RSnJFoqMVcVJwIANtnj2TVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t9jQV2ZOcnRBmfWm1n8nXSM3WL6k8ss
        Fps+vme1mH/kHKvF2WUH2SzW3D7EaNG8eD2bxdmmN+wW978eZbS4vGsOm8Xn3iOMFkuvX2Sy
        +LzhMaPF7cYVbBanrn9mszhz+hKrReveI+wWG796OAh5rJm3htHj969JjB6zGy6yeOy4u4TR
        Y9OqTjaPO9f2sHnsn7uG3ePKiSZWjy1X21k8+rasYvT4vEkugDuKyyYlNSezLLVI3y6BK+PL
        8Z3MBee1K359uMTawLhIuYuRk0NCwERi1v7lTF2MXBxCAusYJXZ/OsUGkuAVEJT4MfkeSxcj
        BwezgLzEkUvZEKa6xJQpuRDl9xklji79xQ4S5xXQkLh6OhCkk0VAVWLv6meMIDabgJbE/hc3
        wCbyCyhKXP3xmBGkXFQgQqL7RCVIWASo88nv82DlzAIzWCU2XogBsYUFXCVm/5oP1ioksIlJ
        omFxAkgrp4C9xJ+XeRMYBWYhOXMWwpmzEM5cwMi8ilEytaA4Nz232KjAMC+1XK84Mbe4NC9d
        Lzk/dxMjMBK3Hdbq28F4f0n8IUYBDkYlHt4LqsnRQqyJZcWVuYcYJTiYlUR433YChXhTEiur
        Uovy44tKc1KLDzFKc7AoifPezjsWKSSQnliSmp2aWpBaBJNl4uCUamCUWS5Xrfg/8aOwSKTH
        VgvPPOY+E95dExzbe1bfWXtmZcDUhF1T9VeLvt74ZUn1hoTEtC/rdrzg27dIImL6tv6aFhHB
        cIYzz81lZ0ofjbcSZvle4aPB1dt9gpttmar6N9+QFS7r7yz2E3XuCeWbtTQw5unbMsZZvw11
        La6Ihuzv26jO+WtlcaASS3FGoqEWc1FxIgCUCMtSwAIAAA==
X-CMS-MailID: 20180803000444epcas1p4ac2cf70ba696c9e085cc66b6cd55485a
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703235030epcas4p423e7bf876628913adb3e41ffdc8ba3cd
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703235030epcas4p423e7bf876628913adb3e41ffdc8ba3cd@epcas4p4.samsung.com>
        <20180703234705.227473-5-mka@chromium.org> <5B3C3632.1010706@samsung.com>
        <20180706170701.GF129942@google.com>
        <4863cf97-37d9-7d81-f44b-10de3dc8267e@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018년 07월 12일 17:38, Chanwoo Choi wrote:
> Hi Matthias,
> 
> On 2018년 07월 07일 02:07, Matthias Kaehlcke wrote:
>> Hi,
>>
>> On Wed, Jul 04, 2018 at 11:51:30AM +0900, Chanwoo Choi wrote:
>>> Hi,
>>>
>>> On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
>>>> Move variables related with devfreq policy changes from struct devfreq
>>>> to the new struct devfreq_policy and add a policy field to struct devfreq.
>>>>
>>>> The following variables are moved:
>>>>
>>>> df->min/max_freq           =>   p->user.min/max_freq
>>>> df->scaling_min/max_freq   =>   p->devinfo.min/max_freq
>>>> df->governor               =>   p->governor
>>>> df->governor_name          =>   p->governor_name
>>>>
>>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>>> Reviewed-by: Brian Norris <briannorris@chromium.org>
>>>> ---
>>>> Changes in v5:
>>>> - none
>>>>
>>>> Changes in v4:
>>>> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
>>>>
>>>> Changes in v3:
>>>> - none
>>>>
>>>> Changes in v2:
>>>> - performance, powersave and simpleondemand governors don't need changes
>>>>   with "PM / devfreq: Don't adjust to user limits in governors"
>>>> - formatting fixes
>>>> ---
>>>>  drivers/devfreq/devfreq.c          | 137 ++++++++++++++++-------------
>>>>  drivers/devfreq/governor_passive.c |   4 +-
>>>>  include/linux/devfreq.h            |  38 +++++---
>>
>>
>>>>  3 files changed, 103 insertions(+), 76 deletions(-)
>>>>
>>>
>>> (skip)
>>>
>>>>  
>>>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>>>> index 3bc29acbd54e..e0987c749ec2 100644
>>>> --- a/drivers/devfreq/governor_passive.c
>>>> +++ b/drivers/devfreq/governor_passive.c
>>>> @@ -99,12 +99,12 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>>>>  {
>>>>  	int ret;
>>>>  
>>>> -	if (!devfreq->governor)
>>>> +	if (!devfreq->policy.governor)
>>>>  		return -EINVAL;
>>>>  
>>>>  	mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
>>>>  
>>>> -	ret = devfreq->governor->get_target_freq(devfreq, &freq);
>>>> +	ret = devfreq->policy.governor->get_target_freq(devfreq, &freq);
>>>>  	if (ret < 0)
>>>>  		goto out;
>>>>  
>>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>>> index 3aae5b3af87c..9bf23b976f4d 100644
>>>> --- a/include/linux/devfreq.h
>>>> +++ b/include/linux/devfreq.h
>>>> @@ -109,6 +109,30 @@ struct devfreq_dev_profile {
>>>>  	unsigned int max_state;
>>>>  };
>>>>  
>>>> +/**
>>>> + * struct devfreq_freq_limits - Devfreq frequency limits
>>>> + * @min_freq:	minimum frequency
>>>> + * @max_freq:	maximum frequency
>>>> + */
>>>> +struct devfreq_freq_limits {
>>>> +	unsigned long min_freq;
>>>> +	unsigned long max_freq;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct devfreq_policy - Devfreq policy
>>>> + * @user:	frequency limits requested by the user
>>>> + * @devinfo:	frequency limits of the device (available OPPs)
>>>> + * @governor:	method how to choose frequency based on the usage.
>>>
>>> nitpick. remove '.' on the end of line.
>>
>> Ok
>>
>>>> + * @governor_name:	devfreq governor name for use with this devfreq
>>>> + */
>>>> +struct devfreq_policy {
>>>> +	struct devfreq_freq_limits user;
>>>> +	struct devfreq_freq_limits devinfo;
>>>> +	const struct devfreq_governor *governor;
>>>> +	char governor_name[DEVFREQ_NAME_LEN];
>>>> +};
>>>> +
>>>>  /**
>>>>   * struct devfreq - Device devfreq structure
>>>>   * @node:	list node - contains the devices with devfreq that have been
>>>> @@ -117,8 +141,6 @@ struct devfreq_dev_profile {
>>>>   * @dev:	device registered by devfreq class. dev.parent is the device
>>>>   *		using devfreq.
>>>>   * @profile:	device-specific devfreq profile
>>>> - * @governor:	method how to choose frequency based on the usage.
>>>> - * @governor_name:	devfreq governor name for use with this devfreq
>>>>   * @nb:		notifier block used to notify devfreq object that it should
>>>>   *		reevaluate operable frequencies. Devfreq users may use
>>>>   *		devfreq.nb to the corresponding register notifier call chain.
>>>> @@ -126,10 +148,7 @@ struct devfreq_dev_profile {
>>>>   * @previous_freq:	previously configured frequency value.
>>>>   * @data:	Private data of the governor. The devfreq framework does not
>>>>   *		touch this.
>>>> - * @min_freq:	Limit minimum frequency requested by user (0: none)
>>>> - * @max_freq:	Limit maximum frequency requested by user (0: none)
>>>> - * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>>> - * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>>> + * @policy:		Policy for frequency adjustments
>>>
>>> The devfreq_policy contains the range of frequency and governor information.
>>> But, this description focus on the frequency. You need to explain the more
>>> correct description of 'policy'.
>>
>> I wouldn't say that the focus is on 'frequency', but on 'frequency
>> adjustments', and the governor is an integral part of them.
> 
> OK. I agree your original description.
> 
>>
>> I can change it to "Policy for frequency adjustments, including
>> frequency limits and the governor" if you prefer. I'm open to other
>> suggestions.
> 
> (snip)
> 

When you resend next patch with my comment except for description of 'policy',
feel free to add my reviewed-by tag.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
