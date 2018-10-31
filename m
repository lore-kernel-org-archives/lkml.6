Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCD7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A895C20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEgSvkZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A895C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbeKAAbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:31:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43378 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeKAAbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:31:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id h4-v6so7778667pfi.10;
        Wed, 31 Oct 2018 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=s0Bpoyf+jnbgI1Fy6CqAZnVC58u2WF8gDCJY/ugX2pg=;
        b=dEgSvkZ2Qbs2ZQopf2h5POPbdBG9fuSzMcyrpBLw6UG1TrxanPSkZZcd+rrV4lzeTL
         S0aeq4DixyaCw0hUX+CPsAnnEaQrm6R9P3tcDxTeS1xEYF+s4mKbI/hpXcN7PJFjXvhi
         462xxlGpB/VqwwqmJJpdaXTS/pEB71enFOAS2iFUfuogW/9ukozUb7OwJJMqRR0EVH94
         yQBWhl7ae6sEqqdW9RMrx8+b8mSDHuMokn/4dxWufhrmJj2JhkxjhYOOzeZm4+jZL9DI
         iQTcvNLtUS9ipWHV6MmHugdKBCjGHtd+i/P1wlkxLeidKEtcfHez1nJ4UwLaTfacL/Xv
         3K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=s0Bpoyf+jnbgI1Fy6CqAZnVC58u2WF8gDCJY/ugX2pg=;
        b=DJ0pVwgGeQHSrtTgRjLzMVwwN/trtOQHGbnpridAPEm4Dv8ryOtWSHCZgVnNmlyIyt
         lX2flWg2IHDdvK76FcUHTwLhVmrpZpEHrihfkb73odQWj5QGdJoMlaPEIR5Mdxa9SQiL
         vjPn+g3AXDeXQ89G8PjYQNLGXkpEzaeYfbxKgqXFFSBhvnDA/cBaC87lpZQJVxkFVx14
         bDIu9POELEoeBPT6SJKpfs8Xz5v69EB9BgZTMf8h8t0p5FYsWrxRiC/uXe0RGPWCKrqv
         RfQVkc5qRlkBzQODJXlb2SVLCCYdN7TI09C7L7UMrehHTHACzkVwnNx0pwsE/sHxisAp
         wxmQ==
X-Gm-Message-State: AGRZ1gLUB5Mr3NceowAolKGHMyclBmf4f3tmMxKNW2DVJiz1580MR7tN
        c+A3WoCVhQwr2iHsSfJhzSj5PZzl
X-Google-Smtp-Source: AJdET5cSrPxMH3suk6xIvK9pfeI6pqJwDlpYfGdtLTxAc+kFnaWUbPgnHuyqqTmUUczqBUVcmnR0+g==
X-Received: by 2002:a62:2782:: with SMTP id n124-v6mr3955587pfn.216.1540999957196;
        Wed, 31 Oct 2018 08:32:37 -0700 (PDT)
Received: from [10.211.55.5] ([49.170.189.99])
        by smtp.gmail.com with ESMTPSA id u1-v6sm27598199pgr.61.2018.10.31.08.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 08:32:36 -0700 (PDT)
Subject: Re: [PATCH] of/platform: Support dynamic device tree on AMBA bus
To:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540485597-12240-1-git-send-email-jaewon02.kim@samsung.com>
 <25f61a9b-af37-18b1-9975-cb4ccbbb3aa7@gmail.com>
From:   Jaewon Kim <jaewon02.kim@gmail.com>
Message-ID: <6946c801-0ea3-d980-ebe0-12eb5a9d2186@gmail.com>
Date:   Thu, 1 Nov 2018 00:32:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <25f61a9b-af37-18b1-9975-cb4ccbbb3aa7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,


Thanks to review my patch.

On 18. 10. 31. 오전 8:04, Frank Rowand wrote:
> Hi Jaewon,
>
> On 10/25/18 9:39 AM, Jaewon Kim wrote:
>> This patch supports dynamic device-tree for AMBA device.
> Add AMBA devices and buses to of_platform_notify() so that dynamic device-tree
> will support AMBA.

What is meaning of this comment?

I already adds AMBA to of_platform_notify().

>
>> The AMBA device must be registered on the AMBA bus, not the platform bus.
>>
>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>> ---
>>   drivers/of/platform.c | 93 ++++++++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 73 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index 04ad312..b9ac105 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -286,6 +286,22 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>>   	of_node_clear_flag(node, OF_POPULATED);
>>   	return NULL;
>>   }
>> +
>> +/**
>> + * of_find_amba_device_by_node - Find the amba_device associated with a node
>> + * @np: Pointer to device tree node
>> + *
>> + * Returns amba_device pointer, or NULL if not found
>> + */
>> +struct amba_device *of_find_amba_device_by_node(struct device_node *np)
>> +{
>> +	struct device *dev;
>> +
>> +	dev = bus_find_device(&amba_bustype, NULL, np, of_dev_node_match);
>> +	return dev ? to_amba_device(dev) : NULL;
>> +}
>> +EXPORT_SYMBOL(of_find_amba_device_by_node);
>> +
>>   #else /* CONFIG_ARM_AMBA */
>>   static struct amba_device *of_amba_device_create(struct device_node *node,
>>   						 const char *bus_id,
>> @@ -294,6 +310,12 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>>   {
>>   	return NULL;
>>   }
>> +
>> +struct amba_device *of_find_amba_device_by_node(struct device_node *np)
>> +{
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL(of_find_amba_device_by_node);
>>   #endif /* CONFIG_ARM_AMBA */
>>   
>>   /**
>> @@ -665,6 +687,7 @@ static int of_platform_notify(struct notifier_block *nb,
>>   {
>>   	struct of_reconfig_data *rd = arg;
>>   	struct platform_device *pdev_parent, *pdev;
>> +	struct amba_device *adev_p, *adev;
>>   	bool children_left;
>>   
>>   	switch (of_reconfig_get_state_change(action, rd)) {
>> @@ -677,17 +700,34 @@ static int of_platform_notify(struct notifier_block *nb,
>>   		if (of_node_check_flag(rd->dn, OF_POPULATED))
>>   			return NOTIFY_OK;
>>   
>> -		/* pdev_parent may be NULL when no bus platform device */
>> -		pdev_parent = of_find_device_by_node(rd->dn->parent);
>> -		pdev = of_platform_device_create(rd->dn, NULL,
>> -				pdev_parent ? &pdev_parent->dev : NULL);
>> -		of_dev_put(pdev_parent);
>> -
>> -		if (pdev == NULL) {
>> -			pr_err("%s: failed to create for '%pOF'\n",
>> -					__func__, rd->dn);
>> -			/* of_platform_device_create tosses the error code */
>> -			return notifier_from_errno(-EINVAL);
>> +		if (of_device_is_compatible(rd->dn, "arm,primecell")) {
>> +			/* adev_p may be NULL when no bus amba device */
>> +			adev_p = of_find_amba_device_by_node(rd->dn->parent);
>> +			adev = of_amba_device_create(rd->dn, NULL, NULL,
>> +					adev_p ? &adev_p->dev : NULL);
>> +
>> +			if (adev_p)
>> +				put_device(&adev_p->dev);
> Please follow the same model as of_dev_put() here, create a new function
> of_amba_dev_put() to implement these two lines.
Okay, I will create of_amba_dev_put() function.
>
>
>> +
>> +			if (adev == NULL) {
>> +				pr_err("%s: failed to create for '%s'\n",
>> +						__func__, rd->dn->full_name);
>> +				/* of_amba_device_create tosses the error */
>> +				return notifier_from_errno(-EINVAL);
>> +			}
>> +		} else {
>> +			/* pdev_parent may be NULL when no bus platform device*/
>> +			pdev_parent = of_find_device_by_node(rd->dn->parent);
>> +			pdev = of_platform_device_create(rd->dn, NULL,
>> +					pdev_parent ? &pdev_parent->dev : NULL);
>> +			of_dev_put(pdev_parent);
>> +
>> +			if (pdev == NULL) {
>> +				pr_err("%s: failed to create for '%pOF'\n",
>> +						__func__, rd->dn);
>> +				/* of_platform_device_create tosses the error */
>> +				return notifier_from_errno(-EINVAL);
>> +			}
>>   		}
>>   		break;
>>   
>> @@ -698,15 +738,28 @@ static int of_platform_notify(struct notifier_block *nb,
>>   			return NOTIFY_OK;
>>   
>>   		/* find our device by node */
>> -		pdev = of_find_device_by_node(rd->dn);
>> -		if (pdev == NULL)
>> -			return NOTIFY_OK;	/* no? not meant for us */
>> -
>> -		/* unregister takes one ref away */
>> -		of_platform_device_destroy(&pdev->dev, &children_left);
>> -
>> -		/* and put the reference of the find */
>> -		of_dev_put(pdev);
>> +		if (of_device_is_compatible(rd->dn, "arm,primecell")) {
>> +			adev = of_find_amba_device_by_node(rd->dn);
>> +			if (adev == NULL)
>> +				return NOTIFY_OK; /* no? not meant for us */
>> +
>> +			/* unregister takes one ref away */
>> +			of_platform_device_destroy(&adev->dev, &children_left);
>> +
>> +			/* and put the reference of the find */
>> +			if (adev)
>> +				put_device(&adev->dev);
> of_amba_dev_put() here also
>
> -Frank
Okay, I will create it.
>
>> +		} else {
>> +			pdev = of_find_device_by_node(rd->dn);
>> +			if (pdev == NULL)
>> +				return NOTIFY_OK; /* no? not meant for us */
>> +
>> +			/* unregister takes one ref away */
>> +			of_platform_device_destroy(&pdev->dev, &children_left);
>> +
>> +			/* and put the reference of the find */
>> +			of_dev_put(pdev);
>> +		}
>>   		break;
>>   	}
>>   
>>
Thanks

Jaewon Kim

