Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC95C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D742081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omY66mTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D742081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbeKBAje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:39:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43546 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeKBAje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:39:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so5114470plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WFkluaRjlBh5Ma+sxy4YYmz/PMXSAYVDzT+HWkn44SM=;
        b=omY66mTshrno3QDduIOgiNP3+svlahtK93JSyM0KpwGmFBtpzxlHPDuCGgc0Tbi5kR
         mBCffXanUQrVOgfeOCjbJI/6jAbJqExyWiFuDRX34ZhY6Mzz9YrvNSwywoj8fn5yo+ds
         P2Bm9tCXLJkJRptdV71Y4ZIDz70LLaHE7H6BocubbZHo/bxpxcZU0GTXBS0JP7SS2X59
         wVHF5WMAsLXMnhcenBMIHLG+rXE78Kd1yjozX5Kf9udobsDvgIXFEaPbjeCQIPYcbU1i
         ycXczZR7iMUhDh6GL68YwQr6OYIxDfBxq11eDD0A9R2Svk9Hcp6im5VRqqrruXdQ0XkX
         8u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WFkluaRjlBh5Ma+sxy4YYmz/PMXSAYVDzT+HWkn44SM=;
        b=qBJEJ3zLV9AL7QVsrladx7P46JwzAEYrF+OUuR0q/eO+8kSvui0pO34OHeFNWJJ0EW
         Jxiq5lCJgtJhxPjne9BdPey6Ua6S5g7N5Wlouep+HdSqHhLuG6LXoRvsTqbMBQY5bn/z
         73/x39pueu2GPsqKjykeAqcTIsokE2hE9xhTrd309LRIXnJqjB30ZjyEYL6L/CHtGbzc
         MfLoAycX2SUHFsSS5FMhyYdYYbi224V1LSztaOyQ18WuPx7+GLJlPREGdTTAiJ/o/2yj
         lu5Hb4RZP7w1L2id3AODfqqd8y+fCnWDuXAE/81x6OwEGOXcf09lqosL5YQIS0sqAxIi
         miqQ==
X-Gm-Message-State: AGRZ1gI/5eN09BDwZrXJnD5yBczddse6VlVKXP+qrIywnTHaO4tCaiPo
        uznUc3TV23pCgQEFqu0Sm2hVRrW9
X-Google-Smtp-Source: AJdET5dlOgJFUvAj3FflxUEGlm+FmCKBllZ3PbjKHEEU9D8kcTD4guQbR85lSM8p81hPzW1Nwz23xw==
X-Received: by 2002:a17:902:2e81:: with SMTP id r1-v6mr8154151plb.212.1541086565718;
        Thu, 01 Nov 2018 08:36:05 -0700 (PDT)
Received: from [10.211.55.5] ([49.170.189.99])
        by smtp.gmail.com with ESMTPSA id w2-v6sm29673999pfw.26.2018.11.01.08.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 08:36:04 -0700 (PDT)
Subject: Re: [PATCH] of/platform: Support dynamic device tree on AMBA bus
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Jaewon Kim <jaewon02.kim@gmail.com>, linux-kernel@vger.kernel.org
References: <1540485597-12240-1-git-send-email-jaewon02.kim@samsung.com>
 <25f61a9b-af37-18b1-9975-cb4ccbbb3aa7@gmail.com>
 <6946c801-0ea3-d980-ebe0-12eb5a9d2186@gmail.com>
 <cc737181-6936-fd9c-988a-e142368deeee@gmail.com>
From:   Jaewon Kim <jaewon02.kim@gmail.com>
Message-ID: <ff863120-64f8-f451-ed3c-ccc3b45e4969@gmail.com>
Date:   Fri, 2 Nov 2018 00:36:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cc737181-6936-fd9c-988a-e142368deeee@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/18 1:06 AM, Frank Rowand wrote:
> On 10/31/18 8:32 AM, Jaewon Kim wrote:
>> Hi Frank,
>>
>>
>> Thanks to review my patch.
>>
>> On 18. 10. 31. 오전 8:04, Frank Rowand wrote:
>>> Hi Jaewon,
>>>
>>> On 10/25/18 9:39 AM, Jaewon Kim wrote:
>>>> This patch supports dynamic device-tree for AMBA device.
>>> Add AMBA devices and buses to of_platform_notify() so that dynamic device-tree
>>> will support AMBA.
>> What is meaning of this comment?
>>
>> I already adds AMBA to of_platform_notify().
> I was trying to make the commit comment more explanatory.  (And finding it difficult
> to remain brief, yet meaningful.)  The original patch header comment did not tell me
> why the patch changes added support of dynamic devicetree on AMBA - I had to read the
> patch before I understood what it did.  If you can think of better words than I
> suggested, please come up with different wording.
>
> My intent with this sentence was that more explanation needed to be added to the
> comment, not that the code needed to change in any way other than what I noted
> in-line inside the patch.  Does this make things more clear, or am I misunderstanding
> your question?
>
> -Frank

Now I understand your intentions.

I will write more clear comment in the next patch version.


Thanks

Jaewon Kim

>
>
>>>> The AMBA device must be registered on the AMBA bus, not the platform bus.
>>>>
>>>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>>>> ---
>>>>    drivers/of/platform.c | 93 ++++++++++++++++++++++++++++++++++++++++-----------
>>>>    1 file changed, 73 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>>> index 04ad312..b9ac105 100644
>>>> --- a/drivers/of/platform.c
>>>> +++ b/drivers/of/platform.c
>>>> @@ -286,6 +286,22 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>>>>        of_node_clear_flag(node, OF_POPULATED);
>>>>        return NULL;
>>>>    }
>>>> +
>>>> +/**
>>>> + * of_find_amba_device_by_node - Find the amba_device associated with a node
>>>> + * @np: Pointer to device tree node
>>>> + *
>>>> + * Returns amba_device pointer, or NULL if not found
>>>> + */
>>>> +struct amba_device *of_find_amba_device_by_node(struct device_node *np)
>>>> +{
>>>> +    struct device *dev;
>>>> +
>>>> +    dev = bus_find_device(&amba_bustype, NULL, np, of_dev_node_match);
>>>> +    return dev ? to_amba_device(dev) : NULL;
>>>> +}
>>>> +EXPORT_SYMBOL(of_find_amba_device_by_node);
>>>> +
>>>>    #else /* CONFIG_ARM_AMBA */
>>>>    static struct amba_device *of_amba_device_create(struct device_node *node,
>>>>                             const char *bus_id,
>>>> @@ -294,6 +310,12 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>>>>    {
>>>>        return NULL;
>>>>    }
>>>> +
>>>> +struct amba_device *of_find_amba_device_by_node(struct device_node *np)
>>>> +{
>>>> +    return NULL;
>>>> +}
>>>> +EXPORT_SYMBOL(of_find_amba_device_by_node);
>>>>    #endif /* CONFIG_ARM_AMBA */
>>>>      /**
>>>> @@ -665,6 +687,7 @@ static int of_platform_notify(struct notifier_block *nb,
>>>>    {
>>>>        struct of_reconfig_data *rd = arg;
>>>>        struct platform_device *pdev_parent, *pdev;
>>>> +    struct amba_device *adev_p, *adev;
>>>>        bool children_left;
>>>>          switch (of_reconfig_get_state_change(action, rd)) {
>>>> @@ -677,17 +700,34 @@ static int of_platform_notify(struct notifier_block *nb,
>>>>            if (of_node_check_flag(rd->dn, OF_POPULATED))
>>>>                return NOTIFY_OK;
>>>>    -        /* pdev_parent may be NULL when no bus platform device */
>>>> -        pdev_parent = of_find_device_by_node(rd->dn->parent);
>>>> -        pdev = of_platform_device_create(rd->dn, NULL,
>>>> -                pdev_parent ? &pdev_parent->dev : NULL);
>>>> -        of_dev_put(pdev_parent);
>>>> -
>>>> -        if (pdev == NULL) {
>>>> -            pr_err("%s: failed to create for '%pOF'\n",
>>>> -                    __func__, rd->dn);
>>>> -            /* of_platform_device_create tosses the error code */
>>>> -            return notifier_from_errno(-EINVAL);
>>>> +        if (of_device_is_compatible(rd->dn, "arm,primecell")) {
>>>> +            /* adev_p may be NULL when no bus amba device */
>>>> +            adev_p = of_find_amba_device_by_node(rd->dn->parent);
>>>> +            adev = of_amba_device_create(rd->dn, NULL, NULL,
>>>> +                    adev_p ? &adev_p->dev : NULL);
>>>> +
>>>> +            if (adev_p)
>>>> +                put_device(&adev_p->dev);
>>> Please follow the same model as of_dev_put() here, create a new function
>>> of_amba_dev_put() to implement these two lines.
>> Okay, I will create of_amba_dev_put() function.
>>>
>>>> +
>>>> +            if (adev == NULL) {
>>>> +                pr_err("%s: failed to create for '%s'\n",
>>>> +                        __func__, rd->dn->full_name);
>>>> +                /* of_amba_device_create tosses the error */
>>>> +                return notifier_from_errno(-EINVAL);
>>>> +            }
>>>> +        } else {
>>>> +            /* pdev_parent may be NULL when no bus platform device*/
>>>> +            pdev_parent = of_find_device_by_node(rd->dn->parent);
>>>> +            pdev = of_platform_device_create(rd->dn, NULL,
>>>> +                    pdev_parent ? &pdev_parent->dev : NULL);
>>>> +            of_dev_put(pdev_parent);
>>>> +
>>>> +            if (pdev == NULL) {
>>>> +                pr_err("%s: failed to create for '%pOF'\n",
>>>> +                        __func__, rd->dn);
>>>> +                /* of_platform_device_create tosses the error */
>>>> +                return notifier_from_errno(-EINVAL);
>>>> +            }
>>>>            }
>>>>            break;
>>>>    @@ -698,15 +738,28 @@ static int of_platform_notify(struct notifier_block *nb,
>>>>                return NOTIFY_OK;
>>>>              /* find our device by node */
>>>> -        pdev = of_find_device_by_node(rd->dn);
>>>> -        if (pdev == NULL)
>>>> -            return NOTIFY_OK;    /* no? not meant for us */
>>>> -
>>>> -        /* unregister takes one ref away */
>>>> -        of_platform_device_destroy(&pdev->dev, &children_left);
>>>> -
>>>> -        /* and put the reference of the find */
>>>> -        of_dev_put(pdev);
>>>> +        if (of_device_is_compatible(rd->dn, "arm,primecell")) {
>>>> +            adev = of_find_amba_device_by_node(rd->dn);
>>>> +            if (adev == NULL)
>>>> +                return NOTIFY_OK; /* no? not meant for us */
>>>> +
>>>> +            /* unregister takes one ref away */
>>>> +            of_platform_device_destroy(&adev->dev, &children_left);
>>>> +
>>>> +            /* and put the reference of the find */
>>>> +            if (adev)
>>>> +                put_device(&adev->dev);
>>> of_amba_dev_put() here also
>>>
>>> -Frank
>> Okay, I will create it.
>>>> +        } else {
>>>> +            pdev = of_find_device_by_node(rd->dn);
>>>> +            if (pdev == NULL)
>>>> +                return NOTIFY_OK; /* no? not meant for us */
>>>> +
>>>> +            /* unregister takes one ref away */
>>>> +            of_platform_device_destroy(&pdev->dev, &children_left);
>>>> +
>>>> +            /* and put the reference of the find */
>>>> +            of_dev_put(pdev);
>>>> +        }
>>>>            break;
>>>>        }
>>>>   
>> Thanks
>>
>> Jaewon Kim
>>
>>
