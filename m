Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B00C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C378F208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PfXbIqvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C378F208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbeH0M2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:28:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40456 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0M2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:28:33 -0400
Received: by mail-wm0-f65.google.com with SMTP id 207-v6so7459426wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 01:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u+twbXenaAT2Vsse6+ZkK10E0FHr6B3A7DzCymXimns=;
        b=PfXbIqvzZz8uBYE6amh0oNA+HuzpMvTFLqR7CVfl2mxeN128lttTLNGzAh1TaOiN0B
         b3HQArPH54STX5CrI7Jlg/qEqyJ9jtIwgt54CXWi6lZIpVEppORFRh0C/iNsCnfX+7VG
         uOgFblkXJFZv7l0cn133H6pGrN/lcQxhqd5Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u+twbXenaAT2Vsse6+ZkK10E0FHr6B3A7DzCymXimns=;
        b=jp5CgdwWQ1KSUfdKDzl+6HNVC/Zlt+Z/u10Y8mYCh1FX9SBZhrMo6CqGLp8QMrkmdU
         qPfV0aKZ2oCiNnTfeAu7wA2hEGwXjfxwjZZkbpoxW1oHV9hh7LwR8jWy984oR8srKv7N
         SjXoEFT6R6PvxG8lzWZIYQTfNZR65KtnpzM9pDpS3+zsE1RAkm/A/Wh79xusplG8iYYH
         QwBJCeEk2YfOlhHWRTxp/lHgkZ/VvOX2JfuieIldu0XsxRx/NLMI1gpBzcyUaGWGzhhe
         U7bHanQNsndvrYnSsFFgKVk84yHHYmrmpazeUd6SiCqfIJldqyuna7FsgGExk909vTAd
         V+iQ==
X-Gm-Message-State: APzg51BMWjJbtb+QOWhQ2nqp7zrKCSJBJFyZlK4WuuspV0KkxtCTzG7j
        ZXmNm6SfrOgjERxsbJJJgwv15jMTjoE=
X-Google-Smtp-Source: ANB0VdZy2Y9zqRkynYVJZ7LQME3VxsVbG7ViUT3NZ2eHSlVn+uAyf9sJ6OugfthoKD0UODy9MkWMfA==
X-Received: by 2002:a1c:398b:: with SMTP id g133-v6mr760281wma.5.1535359370183;
        Mon, 27 Aug 2018 01:42:50 -0700 (PDT)
Received: from [192.168.0.22] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id l24-v6sm29741257wrb.65.2018.08.27.01.42.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:42:49 -0700 (PDT)
Subject: Re: [PATCH] drivers/thermal/tegra: fix a doule free devce node
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     ezequiel@collabora.com, rui.zhang@intel.com, edubezval@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org
References: <1533822056-33930-1-git-send-email-zhongjiang@huawei.com>
 <d2987e9f-5cbf-9622-c6b9-b8bc66b3a5a2@linaro.org>
 <5B763226.1040609@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <469734c9-a79f-9207-303b-1a6713bede17@linaro.org>
Date:   Mon, 27 Aug 2018 10:42:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5B763226.1040609@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2018 04:25, zhong jiang wrote:
> On 2018/8/14 14:39, Daniel Lezcano wrote:
>> On 09/08/2018 15:40, zhong jiang wrote:
>>> Device node iterators will get the return node. Meawhile, It is
>>> also put the previous device node. An explicit put will cause
>>> a double put.
>> What about:
>>
>> Subject: drivers/thermal/tegra: Fix a double free on the device node
>>
>> "The function 'for_each_child_of_node' iterates over the node list by
>> dropping the of_node reference of the previous node.
>>
>> Calling of_node_put() on the iterator is pointless and leads to an
>> inconsistent refcounting in addition to a double free. Remove it."
>  Hi, Daniel
> 
>  Have you picked up the patch or should I repost the patch with above commit
>  message that you have suggested?
> 
>  Thanks,
>  zhong jiang

Hi,

sorry for the delay.

It is not up to me to pick patches for the thermal framework. You should
repost the patch with the suggested commit log above if you agree with.

  -- Daniel

>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  drivers/thermal/tegra/soctherm.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>>> index ed28110..3aa55c9 100644
>>> --- a/drivers/thermal/tegra/soctherm.c
>>> +++ b/drivers/thermal/tegra/soctherm.c
>>> @@ -980,7 +980,6 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
>>>  		tcd = thermal_of_cooling_device_register(np_stcc,
>>>  							 (char *)name, ts,
>>>  							 &throt_cooling_ops);
>>> -		of_node_put(np_stcc);
>>>  		if (IS_ERR_OR_NULL(tcd)) {
>>>  			dev_err(dev,
>>>  				"throttle-cfg: %s: failed to register cooling device\n",
>>>
>>
> 
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

