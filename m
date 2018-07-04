Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DA7C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F41241C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HPGheRJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F41241C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933952AbeGDI1C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:27:02 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34540 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbeGDI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:26:58 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180704082656epoutp0198654d115e0b1e609fc524ea45ed2211~_HQGXkdLx2461924619epoutp01P;
        Wed,  4 Jul 2018 08:26:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180704082656epoutp0198654d115e0b1e609fc524ea45ed2211~_HQGXkdLx2461924619epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530692816;
        bh=OJqjI+DWs9sefcuzCEDSJytunrUHJFuWIaTkPb0N364=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=HPGheRJ8XVVnfddKEthw3cqXCxpf2gsOMCjgEGo5j/3Ht+HCQwVIiN//MCZfHrGsv
         OocOsW+R/3Loouey8185m6Kwb8FTRET5JHkyiMnuf+mQ0FMziPL1eV3qScfPVr1JtT
         8/kVJTVBU5KQzixZCL0jRL1QRRcmL58zB5cJGvZQ=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.153]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180704082653epcas1p1087caa691d11948a75dc9e4322ca4ec5~_HQEJH3LM0982509825epcas1p1T;
        Wed,  4 Jul 2018 08:26:53 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.4E.04217.DC48C3B5; Wed,  4 Jul 2018 17:26:53 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20180704082653epcas2p20642ff5818e4c74f7db063b6f600ddb1~_HQDqmxAD0518905189epcas2p2K;
        Wed,  4 Jul 2018 08:26:53 +0000 (GMT)
X-AuditID: b6c32a45-441ff70000001079-02-5b3c84cd7192
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id CB.CB.04192.CC48C3B5; Wed,  4 Jul
        2018 17:26:53 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBC008YW24SRQ50@mmp2.samsung.com>; Wed, 04 Jul 2018 17:26:52 +0900 (KST)
Message-id: <5B3C84CC.2030207@samsung.com>
Date:   Wed, 04 Jul 2018 17:26:52 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4] PM / devfreq: Fix devfreq_add_device() when drivers
 are built as modules.
In-reply-to: <7fcd3fa4-4f57-9013-b6ff-808600eeb612@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmme7ZFptog4/LlS3W3D7EaLH5XA+r
        xdmmN+wWl3fNYbP43HuE0eJ24wo2BzaPHXeXMHr0bVnF6PF5k1wAc1SqTUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVK0oaGRnqGBuZ6REZA2jrUyMgUqSUjNWH78I3vBHsmKhfMSGhi3inQxcnBI
        CJhIHHgV1MXIxSEksINRou/NJ1YI5zujROOeXjaYogtPpCDiGxglNrfdYOli5OTgFRCU+DH5
        HgtIDbOAvMSRS9kgYWYBTYkXXyaxQNTfZZRY2dnHBFGvJdE57wMbiM0ioCpxY+kOsDgbUHz/
        ixtgcX4BRYmrPx4zgtiiAhESO+d/YwexRQQiJSa1f2QEGcos0MEocaKhGewIYYFkiTMTF4A1
        cwo4Ssx/sgMsLiGwhU1ixQkvCNtF4u6DZUwQtrDEq+Nb2CFsaYlnqzaCDZUQaGeU+PKimRXC
        mcAo8eHUZqgOY4lnC7uYIH7jk+g4/JcdEiy8Eh1tQhAlHhJvt21hhnj5LdB1u38zTmCUnYUU
        SrMQoTQLKZQWMDKvYhRLLSjOTU8tNiow1CtOzC0uzUvXS87P3cQITlxarjsYZ5zzOcQowMGo
        xMPLUGEdLcSaWFZcmXuIUYKDWUmEt1PfJlqINyWxsiq1KD++qDQntfgQoykwkCcyS4km5wOT
        al5JvKGpkbGxsYWpuaWxgaWSOC/jTYFoIYH0xJLU7NTUgtQimD4mDk6pBsbepWqHq5IWXXuS
        /WVnurNUg92BrF2dlq+acyf5r3oT2vwg+WBrmHhN9YN3WoJTnq9bLOvRyf6Ry1X0rT5f3MYc
        pXodBlemGZu+yRr9VTmsWbWd+byHebyPz8y9Sk29iTyy/cEF8UcUT7Bd9v5XmP583VzOi+8u
        KLKcXXOFL3kly8fSB6n6vkosxRmJhlrMRcWJAF4JanFyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jQd2zLTbRBl/2M1usuX2I0WLzuR5W
        i7NNb9gtLu+aw2bxufcIo8XtxhVsDmweO+4uYfTo27KK0ePzJrkA5igum5TUnMyy1CJ9uwSu
        jOXHP7IX7JGsWDgvoYFxq0gXIweHhICJxIUnUl2MnBxCAusYJSa+dgSxeQUEJX5MvscCUsIs
        IC9x5FI2hKkuMWVKbhcjF1D1fUaJBbM6mCDKtSQ6531gA7FZBFQlbizdARZnA4rvf3EDLM4v
        oChx9cdjRpA5ogIREt0nKkHCIgKREsc2L2AHmcks0MEo8W3danaQhLBAssSsO38YIZa9Z5Q4
        u+okWIJTwFFi/pMdLBMYBWYhOXUWwqmzEE5dwMi8ilEytaA4Nz232KjAKC+1XK84Mbe4NC9d
        Lzk/dxMjMIi3Hdbq38H4eEn8IUYBDkYlHt4VpdbRQqyJZcWVuYcYJTiYlUR4O/VtooV4UxIr
        q1KL8uOLSnNSiw8xSnOwKInz8ucfixQSSE8sSc1OTS1ILYLJMnFwSjUwJu/mE+rLTub2OxV+
        YQL/xSBZi/gzvA5bDZUfyvNUveK+rLqzjyFK5J3n0g25nxoWbt2Xf07jAGflrQMzXCLO/ntg
        ssNL6yRDtuuZ67O6JnLtiVXZuafoxJXr/0Nr7n5SOxq29kGESP6bQ/Vfjmw5ETEnTv9bblf0
        +oUmIUqvL8jtuHRq/8nyK0osxRmJhlrMRcWJANaiR4VeAgAA
X-CMS-MailID: 20180704082653epcas2p20642ff5818e4c74f7db063b6f600ddb1
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703132943epcas1p25b68c00ca1143d5eabcc2285c2ce27a0
References: <CGME20180703132943epcas1p25b68c00ca1143d5eabcc2285c2ce27a0@epcas1p2.samsung.com>
        <20180703132931.14389-1-enric.balletbo@collabora.com>
        <5B3C1DA6.7040507@samsung.com>
        <7fcd3fa4-4f57-9013-b6ff-808600eeb612@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2018년 07월 04일 17:16, Enric Balletbo i Serra wrote:
> Hi Chanwoo,
> 
> On 04/07/18 03:06, Chanwoo Choi wrote:
>> Hi Enric,
>>
>> On 2018년 07월 03일 22:29, Enric Balletbo i Serra wrote:
>>> When the devfreq driver and the governor driver are built as modules,
>>> the call to devfreq_add_device() or governor_store() fails because the
>>> governor driver is not loaded at the time the devfreq driver loads. The
>>> devfreq driver has a build dependency on the governor but also should
>>> have a runtime dependency. We need to make sure that the governor driver
>>> is loaded before the devfreq driver.
>>>
>>> This patch fixes this bug by adding a try_then_request_governor()
>>> function. First tries to find the governor, and then, if it is not found,
>>> it requests the module and tries again.
>>>
>>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> ---
>>>
>>> Changes in v4:
>>> - Kept "locked" devfreq_list from the return of find_devfreq_governor() to
>>>   the unlock of governor_store(). Requested by MyungJoo Ham.
>>>
>>> Changes in v3:
>>> - Remove unneded change in dev_err message.
>>> - Fix err returned value in case to not find the governor.
>>>
>>> Changes in v2:
>>> - Add a new function to request the module and call that function from
>>>   devfreq_add_device and governor_store.
>>>
>>>  drivers/devfreq/devfreq.c | 53 ++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 47 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 0b5b3abe054e..4ea6b19879a1 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -11,6 +11,7 @@
>>>   */
>>>  
>>>  #include <linux/kernel.h>
>>> +#include <linux/kmod.h>
>>>  #include <linux/sched.h>
>>>  #include <linux/errno.h>
>>>  #include <linux/err.h>
>>> @@ -221,6 +222,46 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>>>  	return ERR_PTR(-ENODEV);
>>>  }
>>>  
>>> +/**
>>> + * try_then_request_governor() - Try to find the governor and request the
>>> + *                               module if is not found.
>>> + * @name:	name of the governor
>>
>> Usually, devfreq used 'governor_name' indicating the name of governor.
>> you better to use 'governor_name' instead of 'name' for more readability.
>>
> 
> I don't mind to change if you want. But let me try to convince you first. I used
> name for two reasons:
> 1. I saw that you are using governor_name sometimes, but find_devfreq_governor
> uses name not governor_name. IMHO the function name in these two specific cases
> 'try_then_request_governor(name)' is enough readable.

OK. skip the my comment of changing the variable name. Thanks.

> 2. If we want to use governor_name and then do not have the line exceeding the
> 80 characters I need to split the function in two lines. For me the readability
> is better when you have all in one line.
> 
> If I did not convince you, just let me now and I'll change for governor_name :)
> 

(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
