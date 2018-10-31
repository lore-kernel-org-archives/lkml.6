Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A736FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629D220821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc6BII+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629D220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbeKABFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:05:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43105 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbeKABFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:05:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id h4-v6so7823230pfi.10;
        Wed, 31 Oct 2018 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=14U5Fc38ibLY6cXRm8cPLgWEGYlSRXlK2Mj/g04ZDSE=;
        b=lc6BII+4JCG653qRipPCpGuci59Yjp+JVY8moHQqXRsfK01eGqxz2QADE2gmbf4Bj4
         RaAAisB6q+wgr+rctUZ/vzP5xgrwgjkq3rVbXKEMNx53/M+zFQzc66bvaauBxOJ+HZa9
         2sT4aXzjGYFDEUX2Gdg2MyMSYj96POa38pT39sC2g+vjOVxiN2eESxKHdnytay3whS+e
         jxIj6H3qEskvLVOxsNF2XhJuCRbP5R6t41yj6pvDE7By4MJQ5jXRlft2rGAvMxM1jZHr
         oYGeINwsq/lSUrR37oP0oiiyYPjzzPHZZK9z0tvBclsdPQV2WJ2DjinxAZIrpaCyCEZa
         JbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=14U5Fc38ibLY6cXRm8cPLgWEGYlSRXlK2Mj/g04ZDSE=;
        b=hc2ePepVYpkRRk74drPuhZhlejXkGpzWnSPkzI1o3fByAHQNcIiapOb9C7cyiwrUlW
         R+YNUZqrZdHqtmXRUogsRfXBAkti2MLDe5OJNxTzLI/0NPyq6zdCRqa5sc85F5RpiiSg
         SvBUKY8bI5LRurfoeWtQM1V6IkyPo/yEymvDEdGck3E1xTenxGEpOB28DCh7y5y8IlB3
         uSsM7oXwJP3qsLAVbYOsT4N1Rd6vQnV2zz2WyF4aG3pxm/yerxMMil4vqQIdRJuuFT62
         UyqyCIC/Zfi0dmAFpF6lH2rjYEbNE66A+WLZOpSgDpkJW5i1t4kJD1ejiAQ1h0Bv9jDB
         m1aA==
X-Gm-Message-State: AGRZ1gJgOMUQrQUjwG9XXBpu+wburGzQZCn7mJC85Yr4g+FC07Dn/H2l
        /pMbBLddBng+C6dP11h4dTk=
X-Google-Smtp-Source: AJdET5cctRA6NI/lXSQHMDecNMnEL/LpcyhEqNQ8LRZYpze9hpXpnNgeoQtrmDMmdy3CjwyDABMukQ==
X-Received: by 2002:aa7:8195:: with SMTP id g21-v6mr4002359pfi.71.1541001987244;
        Wed, 31 Oct 2018 09:06:27 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id p64-v6sm26838960pfi.22.2018.10.31.09.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 09:06:26 -0700 (PDT)
Subject: Re: [PATCH] of/platform: Support dynamic device tree on AMBA bus
To:     Jaewon Kim <jaewon02.kim@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540485597-12240-1-git-send-email-jaewon02.kim@samsung.com>
 <25f61a9b-af37-18b1-9975-cb4ccbbb3aa7@gmail.com>
 <6946c801-0ea3-d980-ebe0-12eb5a9d2186@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <cc737181-6936-fd9c-988a-e142368deeee@gmail.com>
Date:   Wed, 31 Oct 2018 09:06:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6946c801-0ea3-d980-ebe0-12eb5a9d2186@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 8:32 AM, Jaewon Kim wrote:
> Hi Frank,
> 
> 
> Thanks to review my patch.
> 
> On 18. 10. 31. 오전 8:04, Frank Rowand wrote:
>> Hi Jaewon,
>>
>> On 10/25/18 9:39 AM, Jaewon Kim wrote:
>>> This patch supports dynamic device-tree for AMBA device.
>> Add AMBA devices and buses to of_platform_notify() so that dynamic device-tree
>> will support AMBA.
> 
> What is meaning of this comment?
> 
> I already adds AMBA to of_platform_notify().

I was trying to make the commit comment more explanatory.  (And finding it difficult
to remain brief, yet meaningful.)  The original patch header comment did not tell me
why the patch changes added support of dynamic devicetree on AMBA - I had to read the
patch before I understood what it did.  If you can think of better words than I
suggested, please come up with different wording.

My intent with this sentence was that more explanation needed to be added to the
comment, not that the code needed to change in any way other than what I noted
in-line inside the patch.  Does this make things more clear, or am I misunderstanding
your question?

-Frank


> 
>>
>>> The AMBA device must be registered on the AMBA bus, not the platform bus.
>>>
>>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>>> ---
>>>   drivers/of/platform.c | 93 ++++++++++++++++++++++++++++++++++++++++-----------
>>>   1 file changed, 73 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>> index 04ad312..b9ac105 100644
>>> --- a/drivers/of/platform.c
>>> +++ b/drivers/of/platform.c
>>> @@ -286,6 +286,22 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>>>       of_node_clear_flag(node, OF_POPULATED);
>>>       return NULL;
>>>   }
>>> +
>>> +/**
>>> + * of_find_amba_device_by_node - Find the amba_device associated with a node
>>> + * @np: Pointer to device tree node
>>> + *
>>> + * Returns amba_device pointer, or NULL if not found
>>> + */
>>> +struct amba_device *of_find_amba_device_by_node(struct device_node *np)
>>> +{
>>> +    struct device *dev;
>>> +
>>> +    dev = bus_find_device(&amba_bustype, NULL, np, of_dev_node_match);
>>> +    return dev ? to_amba_device(dev) : NULL;
>>> +}
>>> +EXPORT_SYMBOL(of_find_amba_device_by_node);
>>> +
>>>   #else /* CONFIG_ARM_AMBA */
>>>   static struct amba_device *of_amba_device_create(struct device_node *node,
>>>                            const char *bus_id,
>>> @@ -294,6 +310,12 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>>>   {
>>>       return NULL;
>>>   }
>>> +
>>> +struct amba_device *of_find_amba_device_by_node(struct device_node *np)
>>> +{
>>> +    return NULL;
>>> +}
>>> +EXPORT_SYMBOL(of_find_amba_device_by_node);
>>>   #endif /* CONFIG_ARM_AMBA */
>>>     /**
>>> @@ -665,6 +687,7 @@ static int of_platform_notify(struct notifier_block *nb,
>>>   {
>>>       struct of_reconfig_data *rd = arg;
>>>       struct platform_device *pdev_parent, *pdev;
>>> +    struct amba_device *adev_p, *adev;
>>>       bool children_left;
>>>         switch (of_reconfig_get_state_change(action, rd)) {
>>> @@ -677,17 +700,34 @@ static int of_platform_notify(struct notifier_block *nb,
>>>           if (of_node_check_flag(rd->dn, OF_POPULATED))
>>>               return NOTIFY_OK;
>>>   -        /* pdev_parent may be NULL when no bus platform device */
>>> -        pdev_parent = of_find_device_by_node(rd->dn->parent);
>>> -        pdev = of_platform_device_create(rd->dn, NULL,
>>> -                pdev_parent ? &pdev_parent->dev : NULL);
>>> -        of_dev_put(pdev_parent);
>>> -
>>> -        if (pdev == NULL) {
>>> -            pr_err("%s: failed to create for '%pOF'\n",
>>> -                    __func__, rd->dn);
>>> -            /* of_platform_device_create tosses the error code */
>>> -            return notifier_from_errno(-EINVAL);
>>> +        if (of_device_is_compatible(rd->dn, "arm,primecell")) {
>>> +            /* adev_p may be NULL when no bus amba device */
>>> +            adev_p = of_find_amba_device_by_node(rd->dn->parent);
>>> +            adev = of_amba_device_create(rd->dn, NULL, NULL,
>>> +                    adev_p ? &adev_p->dev : NULL);
>>> +
>>> +            if (adev_p)
>>> +                put_device(&adev_p->dev);
>> Please follow the same model as of_dev_put() here, create a new function
>> of_amba_dev_put() to implement these two lines.
> Okay, I will create of_amba_dev_put() function.
>>
>>
>>> +
>>> +            if (adev == NULL) {
>>> +                pr_err("%s: failed to create for '%s'\n",
>>> +                        __func__, rd->dn->full_name);
>>> +                /* of_amba_device_create tosses the error */
>>> +                return notifier_from_errno(-EINVAL);
>>> +            }
>>> +        } else {
>>> +            /* pdev_parent may be NULL when no bus platform device*/
>>> +            pdev_parent = of_find_device_by_node(rd->dn->parent);
>>> +            pdev = of_platform_device_create(rd->dn, NULL,
>>> +                    pdev_parent ? &pdev_parent->dev : NULL);
>>> +            of_dev_put(pdev_parent);
>>> +
>>> +            if (pdev == NULL) {
>>> +                pr_err("%s: failed to create for '%pOF'\n",
>>> +                        __func__, rd->dn);
>>> +                /* of_platform_device_create tosses the error */
>>> +                return notifier_from_errno(-EINVAL);
>>> +            }
>>>           }
>>>           break;
>>>   @@ -698,15 +738,28 @@ static int of_platform_notify(struct notifier_block *nb,
>>>               return NOTIFY_OK;
>>>             /* find our device by node */
>>> -        pdev = of_find_device_by_node(rd->dn);
>>> -        if (pdev == NULL)
>>> -            return NOTIFY_OK;    /* no? not meant for us */
>>> -
>>> -        /* unregister takes one ref away */
>>> -        of_platform_device_destroy(&pdev->dev, &children_left);
>>> -
>>> -        /* and put the reference of the find */
>>> -        of_dev_put(pdev);
>>> +        if (of_device_is_compatible(rd->dn, "arm,primecell")) {
>>> +            adev = of_find_amba_device_by_node(rd->dn);
>>> +            if (adev == NULL)
>>> +                return NOTIFY_OK; /* no? not meant for us */
>>> +
>>> +            /* unregister takes one ref away */
>>> +            of_platform_device_destroy(&adev->dev, &children_left);
>>> +
>>> +            /* and put the reference of the find */
>>> +            if (adev)
>>> +                put_device(&adev->dev);
>> of_amba_dev_put() here also
>>
>> -Frank
> Okay, I will create it.
>>
>>> +        } else {
>>> +            pdev = of_find_device_by_node(rd->dn);
>>> +            if (pdev == NULL)
>>> +                return NOTIFY_OK; /* no? not meant for us */
>>> +
>>> +            /* unregister takes one ref away */
>>> +            of_platform_device_destroy(&pdev->dev, &children_left);
>>> +
>>> +            /* and put the reference of the find */
>>> +            of_dev_put(pdev);
>>> +        }
>>>           break;
>>>       }
>>>  
> Thanks
> 
> Jaewon Kim
> 
> 

