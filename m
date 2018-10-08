Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A647C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C17920878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3Pw6I0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C17920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeJHPKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:10:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34916 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeJHPKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:10:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id e187-v6so7295638wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 01:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7Pa2qVSj7FpkwWoRFDaQJr589BVVh/B2eseJDSrRMl4=;
        b=m3Pw6I0B3Kvv1Ghj5ixs8EIbyTWgGhdauVobkoN5tEP/QPgQ99slEq5+RKiDffAPn6
         WkulEB57OPYcDWf/GlisgSuU1v8e+EMl/Ed8mCW/o3mFtyEDIzKal0CwfmFcP2zMnwWL
         w6tj5ENLpvITBtCUjRUTwgoYplWmz8G0Rn4A7MX9RRlI0iAQeSQ2uUwE7cz/g+N7IR4W
         8nWpUFAfPxaO3w+d3V27urg6elRvC4KOzVmRZi3SC3xOShNvP2BEZ3cIQlfvaAzCoH/N
         HmXT4x5EowPlk5eRoY4QStumS+K2zrT87TwFfHr5s4oXV3x5B5EaB6DNozqJjsu6Q6bV
         5TGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=7Pa2qVSj7FpkwWoRFDaQJr589BVVh/B2eseJDSrRMl4=;
        b=YYtoQLTluVY991XWJcSU6FpJAOc/zPbg4GFxG+QO2RKBJ1/WJvaqYKrb4PZeW2DiHV
         Di6LA2yU0YghSQ5TCqse4/l7VCLeqBN8PVBylNCRxYeLd6sHM0Z60tqDxk288hPEDvKr
         VJGNoHoKbeWAyjbvn0vuyZi3FllKB2ZfI/aXKdIssg9wRz6q4+WkNQc00x8nsg6JPuUL
         p6p8UQrLsQosbBV6lTxOXAKeZ2Bu8wAeVRx6XVSyyCGIecWRvQUTHKDCXkrJiJr76HH4
         OFUs2KlyssrvQ/B1Mn/h5owjRYvEJu0PWBH85+UN1SYuKOgLZ3/U/zwph7398K8IPdPt
         MbBg==
X-Gm-Message-State: ABuFfojfmjdChBKyarJdTaEs2XGNh/ZZrzqoNLSflXQTjSFSdFXbiuUu
        6l67PdmUy9nbMkHhkRY9CSc=
X-Google-Smtp-Source: ACcGV62HAYnDG3B1cFeO4fti2TO+u7KhGf0gXTDCR8XeX9dsdGp/UZL31ZD40doe7WWtHXWd47MBEQ==
X-Received: by 2002:a1c:8fc5:: with SMTP id r188-v6mr1084960wmd.136.1538985617431;
        Mon, 08 Oct 2018 01:00:17 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id k93-v6sm21572327wrc.89.2018.10.08.01.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 01:00:16 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] amdgpu/gmc : fix compile warning
To:     Guenter Roeck <linux@roeck-us.net>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Peng Hao <peng.hao2@zte.com.cn>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
 <20181004185237.GA20667@roeck-us.net>
 <022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com>
 <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4da23fcb-4a94-2695-ad80-929025e84bd2@gmail.com>
Date:   Mon, 8 Oct 2018 10:00:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4772f72c-6018-3556-6324-5f49faa00073@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.10.2018 um 10:38 schrieb Guenter Roeck:
> On 10/05/2018 01:14 AM, Koenig, Christian wrote:
>> Am 04.10.2018 um 20:52 schrieb Guenter Roeck:
>>> Hi,
>>>
>>> On Fri, Sep 14, 2018 at 06:05:52PM +0800, Peng Hao wrote:
>>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:
>>>>       In function ‘gmc_v8_0_process_interrupt’:
>>>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:10:
>>>>       warning: missing braces around initializer [-Wmissing-braces]
>>>>
>>>> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
>>> Was there any feedback on this patch ? The problem does affect us,
>>> and we'll need a fix.
>>
>> Well as discussed using "{ { 0 } }" is as wrong as using "{ 0 }".
>>
>
> Ah, sorry, I must have missed the discussion.
>
> It is for sure not the best solution, but at least it compiles, and it 
> seems
> to be proliferating.

Yeah, and exactly that's the problem. As the discussion showed "{ { 0 } 
}" is buggy because it tells the compiler to only initialize the first 
member of the structure, but not all of it.

That is incorrect and rather dangerous cause it can lead to unforeseen 
results and should probably trigger a warning.

>
> $ git grep "{ *{ *0 *} *}" | wc
>     144    1180   11802
> $ git grep "{ *{ *0 *} *}" drivers/gpu/drm/amd/ | wc
>      50     459    5239
>
>> We should either use only "{ }" or even better make nails with heads and
>> use memset().
>
> I'd rather leave it up to the compiler to decide what is most efficient.

And I would rather prefer to have a working driver :)

Christian.

>
> Guenter
>
>>
>> Christian.
>>
>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
>>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> index 9333109..55f4755 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>> @@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct 
>>>> amdgpu_device *adev,
>>>>            gmc_v8_0_set_fault_enable_default(adev, false);
>>>>           if (printk_ratelimit()) {
>>>> -        struct amdgpu_task_info task_info = { 0 };
>>>> +        struct amdgpu_task_info task_info = { {0} };
>>> I wondered if
>>>         struct amdgpu_task_info task_info = { };
>>> would be better.
>>>
>>> Thanks,
>>> Guenter
>>>
>>>> amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> index 72f8018..e8b78c5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>> @@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct 
>>>> amdgpu_device *adev,
>>>>        }
>>>>           if (printk_ratelimit()) {
>>>> -        struct amdgpu_task_info task_info = { 0 };
>>>> +        struct amdgpu_task_info task_info = { {0} };
>>>>               amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

