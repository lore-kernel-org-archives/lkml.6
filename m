Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3312FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D850E217C1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ONAtk/wW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D850E217C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934298AbeGDIcW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:32:22 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:63582 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933324AbeGDIcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:32:18 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180704083216epoutp03c6ec5f94686742ac83ef1aa8dc7c9460~_HUwnO4641075110751epoutp03F;
        Wed,  4 Jul 2018 08:32:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180704083216epoutp03c6ec5f94686742ac83ef1aa8dc7c9460~_HUwnO4641075110751epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530693136;
        bh=Es/Swe7CyHMaXrwG4XYfxJbaKArMDCezhlsKeczR6F4=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=ONAtk/wWiXcaPAD9mVsF2f/U0eJBFg569Ex6vLlsjmebhuwAfpiLhPm8/3KPxcN9F
         FreOFeTN0G4FQxVyswblPAVYoKiLv6cQiahg3nxcgn4faOhbDcA5dCqbW38ZcF92sy
         bHd0xapiZ4dPM17uKvwClrDgj3NsyM8JrtHzUf5Q=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.155]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180704083211epcas1p4aa86a0434a784921802f486d2f091298~_HUr5GvRL0083800838epcas1p4a;
        Wed,  4 Jul 2018 08:32:11 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.59.04187.B068C3B5; Wed,  4 Jul 2018 17:32:11 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20180704083210epcas2p17c26992865e39b297d3440843170efab~_HUrmfGS82967029670epcas2p1O;
        Wed,  4 Jul 2018 08:32:10 +0000 (GMT)
X-AuditID: b6c32a46-c67ff7000000105b-87-5b3c860b109a
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.FB.04192.A068C3B5; Wed,  4 Jul 2018 17:32:10 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBC00C2J2DMPV80@mmp1.samsung.com>; Wed, 04 Jul 2018 17:32:10 +0900 (KST)
Message-id: <5B3C860A.8060404@samsung.com>
Date:   Wed, 04 Jul 2018 17:32:10 +0900
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
In-reply-to: <5B3C84CC.2030207@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmuS53m020weyp7BZrbh9itNh8rofV
        4mzTG3aLy7vmsFl87j3CaHG7cQWbA5vHjrtLGD36tqxi9Pi8SS6AOSrVJiM1MSW1SCE1Lzk/
        JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdor5JCWWJOKVAoILG4WEnfzqYo
        v7QkVSEjv7jEVina0NBIz9DAXM/ICEgbx1oZmQKVJKRmbDvYyl7wQapiw5vrzA2M50S7GDk5
        JARMJA6df8TexcjFISSwg1Fi84XnjBDOd0aJWS+72GCqNh5dAJXYzSjR/fAYM0iCV0BQ4sfk
        eyxdjBwczALyEkcuZYOEmQU0JV58mcQCUX+XUaL5dDcbRL2WxKMPy8FsFgFVidOzf7KA2GxA
        8f0vboDF+QUUJa7+eMwIYosKREjsnP+NHcQWEYiUmNT+EewIZoEORokTDc1gzcICyRJnJi4A
        a+YU0JaYcP4JE8TVW9gk7s0vgbBdJBbePssCYQtLvDq+hR3ClpZ4tmoj2FAJgXZGiS8vmlkh
        nAmMEh9ObYaaZCzxbGEXE8RvfBIdh/+yg7wsIcAr0dEmBFHiIfF22xZmiJf7mCTOvrnDNoFR
        dhZSKM1ChNIspFBawMi8ilEstaA4Nz212KjASK84Mbe4NC9dLzk/dxMjOH1pue1gXHLO5xCj
        AAejEg/vilLraCHWxLLiytxDjBIczEoivJ36NtFCvCmJlVWpRfnxRaU5qcWHGE2BgTyRWUo0
        OR+YWvNK4g1NjYyNjS1MzS2NDSyVxHkZbwpECwmkJ5akZqemFqQWwfQxcXBKNTDKHll+5Loq
        11QDzZ4XZ5xYg7//rygSuy/20X57lI6I5u7MGw+CVdtNbEJ2Nz/a9lRz2Z+HSW+32zLkflFM
        D8jKUP6yK1p32ZXNThu2zrgQW6YX1eDkudj67sXy7dcmnWdQORss6N4g8a7LmDtmedgLlncV
        GVnlk+7e8d66tEZp47NTR5n52P2VWIozEg21mIuKEwF8IMFldQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t9jAV2uNptog79TDC3W3D7EaLH5XA+r
        xdmmN+wWl3fNYbP43HuE0eJ24wo2BzaPHXeXMHr0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJX
        xraDrewFH6QqNry5ztzAeE60i5GTQ0LARGLj0QWMXYxcHEICOxklHq3/zQiS4BUQlPgx+R5L
        FyMHB7OAvMSRS9kQprrElCm5EOX3GSWWb17NBlGuJfHow3Iwm0VAVeL07J8sIDYbUHz/ixtg
        cX4BRYmrPx4zgswRFYiQ6D5RCRIWEYiUOLZ5ATvITGaBDkaJb+tWs4MkhAWSJWbd+QN12wQm
        ifMLIZZxCmhLTDj/hGkCo8AsJKfOQjh1FsKpCxiZVzFKphYU56bnFhsVGOWllusVJ+YWl+al
        6yXn525iBIbytsNa/TsYHy+JP8QowMGoxMO7otQ6Wog1say4MvcQowQHs5IIb6e+TbQQb0pi
        ZVVqUX58UWlOavEhRmkOFiVxXv78Y5FCAumJJanZqakFqUUwWSYOTqkGRv1Ztp5Ml8Kc//3l
        Egz/JGn1+3dQyYWIru0y7HG9d9bdrOervjY96W+/lOLCLLHZIprnfH+cKV7BppWVvXfp3cdr
        Wd4bSrbqbi7SfOHjvfpL2LZtazIWTHST65gjcvSUhuLHWlfLy76Ri2sWhcdJh0U/Dlg0//rU
        KanB7u+iT95/cVJZUdZupxJLcUaioRZzUXEiAN0BUaVhAgAA
X-CMS-MailID: 20180704083210epcas2p17c26992865e39b297d3440843170efab
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703132943epcas1p25b68c00ca1143d5eabcc2285c2ce27a0
References: <CGME20180703132943epcas1p25b68c00ca1143d5eabcc2285c2ce27a0@epcas1p2.samsung.com>
        <20180703132931.14389-1-enric.balletbo@collabora.com>
        <5B3C1DA6.7040507@samsung.com>
        <7fcd3fa4-4f57-9013-b6ff-808600eeb612@collabora.com>
        <5B3C84CC.2030207@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Please send this patch to stable-kernel mailing list.

Regards,
Chanwoo Choi

On 2018년 07월 04일 17:26, Chanwoo Choi wrote:
> Hi Enric,
> 
> On 2018년 07월 04일 17:16, Enric Balletbo i Serra wrote:
>> Hi Chanwoo,
>>
>> On 04/07/18 03:06, Chanwoo Choi wrote:
>>> Hi Enric,
>>>
>>> On 2018년 07월 03일 22:29, Enric Balletbo i Serra wrote:
>>>> When the devfreq driver and the governor driver are built as modules,
>>>> the call to devfreq_add_device() or governor_store() fails because the
>>>> governor driver is not loaded at the time the devfreq driver loads. The
>>>> devfreq driver has a build dependency on the governor but also should
>>>> have a runtime dependency. We need to make sure that the governor driver
>>>> is loaded before the devfreq driver.
>>>>
>>>> This patch fixes this bug by adding a try_then_request_governor()
>>>> function. First tries to find the governor, and then, if it is not found,
>>>> it requests the module and tries again.
>>>>
>>>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> ---
>>>>
>>>> Changes in v4:
>>>> - Kept "locked" devfreq_list from the return of find_devfreq_governor() to
>>>>   the unlock of governor_store(). Requested by MyungJoo Ham.
>>>>
>>>> Changes in v3:
>>>> - Remove unneded change in dev_err message.
>>>> - Fix err returned value in case to not find the governor.
>>>>
>>>> Changes in v2:
>>>> - Add a new function to request the module and call that function from
>>>>   devfreq_add_device and governor_store.
>>>>
>>>>  drivers/devfreq/devfreq.c | 53 ++++++++++++++++++++++++++++++++++-----
>>>>  1 file changed, 47 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index 0b5b3abe054e..4ea6b19879a1 100644
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
>>>> @@ -221,6 +222,46 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>>>>  	return ERR_PTR(-ENODEV);
>>>>  }
>>>>  
>>>> +/**
>>>> + * try_then_request_governor() - Try to find the governor and request the
>>>> + *                               module if is not found.
>>>> + * @name:	name of the governor
>>>
>>> Usually, devfreq used 'governor_name' indicating the name of governor.
>>> you better to use 'governor_name' instead of 'name' for more readability.
>>>
>>
>> I don't mind to change if you want. But let me try to convince you first. I used
>> name for two reasons:
>> 1. I saw that you are using governor_name sometimes, but find_devfreq_governor
>> uses name not governor_name. IMHO the function name in these two specific cases
>> 'try_then_request_governor(name)' is enough readable.
> 
> OK. skip the my comment of changing the variable name. Thanks.
> 
>> 2. If we want to use governor_name and then do not have the line exceeding the
>> 80 characters I need to split the function in two lines. For me the readability
>> is better when you have all in one line.
>>
>> If I did not convince you, just let me now and I'll change for governor_name :)
>>
> 
> (snip)
> 

