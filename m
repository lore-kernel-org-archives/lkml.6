Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B694ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229062081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUWMPM1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229062081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeJaIAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:00:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35672 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeJaIAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:00:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so6406845pgu.2;
        Tue, 30 Oct 2018 16:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3F8ka36vfkzT2SFr0etVtoE/l9IhHM5F3+ywvyyhTJA=;
        b=EUWMPM1LhG0oXj7fbYjnFwNt5Cjog2d4mdFWMH6s912ji6XGVEwsjNfVdUmXYJIotf
         O0U/UPVyM1sBJClBg2B+PtCAQ04p/Ln7s8vQoPZiwwn+7uXMsLyB/ubDQXKSv+WPJChz
         q3GY4f4/6L1ExKKArk8ieHe3e7Sky2fXYoUNmlv/64ewwvvOiiPtiGHYVChn2emq0K5m
         H8cpYEjbQ4mqlf3egy3prxh+0OPHx8Xa41rzrmCe8Seu5NvZC1M1J36UktIB2RLBn0Uj
         6mxpXib8ohOkQ/tzBz7JMNo7MD/AHjWHMOVyT22S7ka0JXz6ORzq2/bJpThU7wq2Ves3
         m5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3F8ka36vfkzT2SFr0etVtoE/l9IhHM5F3+ywvyyhTJA=;
        b=ZBopc+8UQG+Yix5seiRYfph0JLIBFLE/FitMt8mN5xS11cu4pADDORCmyqTdqyz8MC
         /vxZH+B/lgfin3CtqQDIkCGtFO2qPGfKyxprqNBQ0poEmJmiat9gERcxmPbkcp6LChfH
         uBJKdgm3Mz7S1sHvjttqZP2jfiD+noitsjU76Zo0Y4B8JLCnF5nqEEUD49+XNFryFsKr
         chYi9DPFogvEWhA583gjAHGLECOLJWXOZiSWQKlNzUewQ+nJCg7Qd8Lec2wIOtPaXLGb
         AXGY+VqDzBh6pP3kjr83fT6VQZ5xNiQyUzzTIfmqR6k+9JHMd3IUd70zhK4mvmkoM2NR
         AzLA==
X-Gm-Message-State: AGRZ1gJPn6M2C3QgFpNMw1r3vqLopoakHTF9sDPnXqBAGElZpd/sCABT
        hVAoqUuC04Sph2nx8jj/d6M=
X-Google-Smtp-Source: AJdET5cS7JpQmwBP3mU+VqsAA8SWFKOmA5lZk+a+Ja3p7Sb2Edi7iho6l88DQ7jK18teHb2HzF9EAA==
X-Received: by 2002:a65:62d5:: with SMTP id m21-v6mr644388pgv.243.1540940693777;
        Tue, 30 Oct 2018 16:04:53 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id s80-v6sm28777795pfa.114.2018.10.30.16.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 16:04:53 -0700 (PDT)
Subject: Re: [PATCH] of/platform: Support dynamic device tree on AMBA bus
To:     Jaewon Kim <jaewon02.kim@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540485597-12240-1-git-send-email-jaewon02.kim@samsung.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <25f61a9b-af37-18b1-9975-cb4ccbbb3aa7@gmail.com>
Date:   Tue, 30 Oct 2018 16:04:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540485597-12240-1-git-send-email-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaewon,

On 10/25/18 9:39 AM, Jaewon Kim wrote:
> This patch supports dynamic device-tree for AMBA device.

Add AMBA devices and buses to of_platform_notify() so that dynamic device-tree
will support AMBA.

> The AMBA device must be registered on the AMBA bus, not the platform bus.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  drivers/of/platform.c | 93 ++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 04ad312..b9ac105 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -286,6 +286,22 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>  	of_node_clear_flag(node, OF_POPULATED);
>  	return NULL;
>  }
> +
> +/**
> + * of_find_amba_device_by_node - Find the amba_device associated with a node
> + * @np: Pointer to device tree node
> + *
> + * Returns amba_device pointer, or NULL if not found
> + */
> +struct amba_device *of_find_amba_device_by_node(struct device_node *np)
> +{
> +	struct device *dev;
> +
> +	dev = bus_find_device(&amba_bustype, NULL, np, of_dev_node_match);
> +	return dev ? to_amba_device(dev) : NULL;
> +}
> +EXPORT_SYMBOL(of_find_amba_device_by_node);
> +
>  #else /* CONFIG_ARM_AMBA */
>  static struct amba_device *of_amba_device_create(struct device_node *node,
>  						 const char *bus_id,
> @@ -294,6 +310,12 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
>  {
>  	return NULL;
>  }
> +
> +struct amba_device *of_find_amba_device_by_node(struct device_node *np)
> +{
> +	return NULL;
> +}
> +EXPORT_SYMBOL(of_find_amba_device_by_node);
>  #endif /* CONFIG_ARM_AMBA */
>  
>  /**
> @@ -665,6 +687,7 @@ static int of_platform_notify(struct notifier_block *nb,
>  {
>  	struct of_reconfig_data *rd = arg;
>  	struct platform_device *pdev_parent, *pdev;
> +	struct amba_device *adev_p, *adev;
>  	bool children_left;
>  
>  	switch (of_reconfig_get_state_change(action, rd)) {
> @@ -677,17 +700,34 @@ static int of_platform_notify(struct notifier_block *nb,
>  		if (of_node_check_flag(rd->dn, OF_POPULATED))
>  			return NOTIFY_OK;
>  
> -		/* pdev_parent may be NULL when no bus platform device */
> -		pdev_parent = of_find_device_by_node(rd->dn->parent);
> -		pdev = of_platform_device_create(rd->dn, NULL,
> -				pdev_parent ? &pdev_parent->dev : NULL);
> -		of_dev_put(pdev_parent);
> -
> -		if (pdev == NULL) {
> -			pr_err("%s: failed to create for '%pOF'\n",
> -					__func__, rd->dn);
> -			/* of_platform_device_create tosses the error code */
> -			return notifier_from_errno(-EINVAL);
> +		if (of_device_is_compatible(rd->dn, "arm,primecell")) {
> +			/* adev_p may be NULL when no bus amba device */
> +			adev_p = of_find_amba_device_by_node(rd->dn->parent);
> +			adev = of_amba_device_create(rd->dn, NULL, NULL,
> +					adev_p ? &adev_p->dev : NULL);
> +

> +			if (adev_p)
> +				put_device(&adev_p->dev);

Please follow the same model as of_dev_put() here, create a new function
of_amba_dev_put() to implement these two lines.


> +
> +			if (adev == NULL) {
> +				pr_err("%s: failed to create for '%s'\n",
> +						__func__, rd->dn->full_name);
> +				/* of_amba_device_create tosses the error */
> +				return notifier_from_errno(-EINVAL);
> +			}
> +		} else {
> +			/* pdev_parent may be NULL when no bus platform device*/
> +			pdev_parent = of_find_device_by_node(rd->dn->parent);
> +			pdev = of_platform_device_create(rd->dn, NULL,
> +					pdev_parent ? &pdev_parent->dev : NULL);
> +			of_dev_put(pdev_parent);
> +
> +			if (pdev == NULL) {
> +				pr_err("%s: failed to create for '%pOF'\n",
> +						__func__, rd->dn);
> +				/* of_platform_device_create tosses the error */
> +				return notifier_from_errno(-EINVAL);
> +			}
>  		}
>  		break;
>  
> @@ -698,15 +738,28 @@ static int of_platform_notify(struct notifier_block *nb,
>  			return NOTIFY_OK;
>  
>  		/* find our device by node */
> -		pdev = of_find_device_by_node(rd->dn);
> -		if (pdev == NULL)
> -			return NOTIFY_OK;	/* no? not meant for us */
> -
> -		/* unregister takes one ref away */
> -		of_platform_device_destroy(&pdev->dev, &children_left);
> -
> -		/* and put the reference of the find */
> -		of_dev_put(pdev);
> +		if (of_device_is_compatible(rd->dn, "arm,primecell")) {
> +			adev = of_find_amba_device_by_node(rd->dn);
> +			if (adev == NULL)
> +				return NOTIFY_OK; /* no? not meant for us */
> +
> +			/* unregister takes one ref away */
> +			of_platform_device_destroy(&adev->dev, &children_left);
> +
> +			/* and put the reference of the find */

> +			if (adev)
> +				put_device(&adev->dev);

of_amba_dev_put() here also

-Frank


> +		} else {
> +			pdev = of_find_device_by_node(rd->dn);
> +			if (pdev == NULL)
> +				return NOTIFY_OK; /* no? not meant for us */
> +
> +			/* unregister takes one ref away */
> +			of_platform_device_destroy(&pdev->dev, &children_left);
> +
> +			/* and put the reference of the find */
> +			of_dev_put(pdev);
> +		}
>  		break;
>  	}
>  
> 

