Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15289C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9961223E8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 01:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ljb0viGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9961223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753598AbeGDBGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 21:06:53 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:15493 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753508AbeGDBGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 21:06:51 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180704010649epoutp02abed53eb64c3636bd08091be4a594a0f~_BP1pX-TE1907619076epoutp02O;
        Wed,  4 Jul 2018 01:06:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180704010649epoutp02abed53eb64c3636bd08091be4a594a0f~_BP1pX-TE1907619076epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530666409;
        bh=WGdcfqhgcIH7XeJkAgymSL5GJpGszQghhVLBEZQeGNY=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=Ljb0viGOWC0OzZdn/GMPZBldT4QV+0GjPRnT2WyVA5KbVfeMbr/8mEdxX9PdV0NbK
         5CGxXTnILQACvmW4UeYFmDZauqJyu7++yA19LZfP8eOqJ3lHE3KkuTPDfkbxy9gJaA
         6sj7DlQvpSnRt6WGyc+eHEtbC9XnLfREMrYnyQw0=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180704010646epcas1p2e82c1db017b912931c706136eedbd22d~_BPy3seim0366303663epcas1p2A;
        Wed,  4 Jul 2018 01:06:46 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.FF.04186.6AD1C3B5; Wed,  4 Jul 2018 10:06:46 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20180704010646epcas2p1ddee5d32b281c2a7c52543add37827a2~_BPypl98j0576105761epcas2p1F;
        Wed,  4 Jul 2018 01:06:46 +0000 (GMT)
X-AuditID: b6c32a47-9c7ff7000000105a-c3-5b3c1da68017
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.EC.04192.6AD1C3B5; Wed,  4 Jul 2018 10:06:46 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBB00J63HRA3J30@mmp1.samsung.com>; Wed, 04 Jul 2018 10:06:46 +0900 (KST)
Message-id: <5B3C1DA6.7040507@samsung.com>
Date:   Wed, 04 Jul 2018 10:06:46 +0900
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
In-reply-to: <20180703132931.14389-1-enric.balletbo@collabora.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmhe4yWZtog19f9S3W3D7EaLH5XA+r
        xdmmN+wWl3fNYbP43HuE0eJ24wo2BzaPHXeXMHr0bVnF6PF5k1wAc1SqTUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVK0oaGRnqGBuZ6REZA2jrUyMgUqSUjNuN/+hrlgkk7F/Z8zWRoYvyt1MXJy
        SAiYSCzaPYG5i5GLQ0hgB6PE8++TWSCc74wSd+b9ZYSpurzoOztEYjejxOIZy1hBErwCghI/
        Jt8D6uDgYBaQlzhyKRskzCygKbF193qo+ruMEhP3z2IDqeEV0JL4P8kJpIZFQFVi9tFONhCb
        DSi8/8UNMJtfQFHi6o/HYHtFBSIkds7/xg5iiwhESkxq/8gIMpNZoINR4kRDMwtIQlggWeLM
        xAVgzZwCThI/p25lAymSENjDJtGydj8rxAcuEtcfz2aGsIUlXh3fwg5hS0s8W7WREaKhnVHi
        y4tmVghnAqPEh1ObmSCqjCWeLexigviNT6Lj8F92kHckBHglOtqEIEo8JN5u2wINyKmMEu+X
        3GCdwCg7CymUZiFCaRZSKC1gZF7FKJZaUJybnlpsVGCsV5yYW1yal66XnJ+7iRGcvrTcdzBu
        O+dziFGAg1GJh3dFqXW0EGtiWXFl7iFGCQ5mJRHee7+AQrwpiZVVqUX58UWlOanFhxhNgaE8
        kVlKNDkfmFrzSuINTY2MjY0tTM0tjQ0slcR5GW8KRAsJpCeWpGanphakFsH0MXFwSjUwLpfx
        c/C5sfzQjptsO9Zy6m77w2P3tvp50MSKmIOXW4RcVhzdLGOQvmrCQ6UIj1iv1WGzGDxyRVI2
        3FMP3630dXXTsZpoXhebt3p3nOedk5hz8fxS9dunwzbZvzITSJ+ZyiX/sZ5b7sab064BH2Ye
        +tze1/15abasTfCGvrK94ny8dp8s1Te4KLEUZyQaajEXFScCAJ9n/nV1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t9jAd1lsjbRBo3TFCzW3D7EaLH5XA+r
        xdmmN+wWl3fNYbP43HuE0eJ24wo2BzaPHXeXMHr0bVnF6PF5k1wAcxSXTUpqTmZZapG+XQJX
        xv32N8wFk3Qq7v+cydLA+F2pi5GTQ0LAROLyou/sXYxcHEICOxklfu96wgaS4BUQlPgx+R5L
        FyMHB7OAvMSRS9kgYWYBdYlJ8xYxg9hCAvcZJbpPS4OU8ApoSfyf5AQSZhFQlZh9tBNsChtQ
        eP+LG2A2v4CixNUfjxlBykUFIiS6T1SChEUEIiWObV4AdgGzQAejxLd1q9lBEsICyRKz7vxh
        hDhtOlBi8zqwBKeAk8TPqVvZJjAKzEJy6SyES2chuXQBI/MqRsnUguLc9NxiowKjvNRyveLE
        3OLSvHS95PzcTYzAUN52WKt/B+PjJfGHGAU4GJV4eFeUWkcLsSaWFVfmHmKU4GBWEuG99wso
        xJuSWFmVWpQfX1Sak1p8iFGag0VJnJc//1ikkEB6YklqdmpqQWoRTJaJg1OqgVF/xfLkZf9q
        lp2vWal1/qDKzqntl7dKOjIIpaV5bxFa+Hebq9e+var3UhZvKNbfa/GpqN7IYuP8kMZ1h34v
        6D8974zf+0k1ITvk03f68VkcCTYWiHxezfeG1evNzU9czqocUamXFcKtdtl5/dsQ7+X7jvfZ
        qbAP4hwuzueXyc/p28eq/0L1RacSS3FGoqEWc1FxIgCyUoWmYQIAAA==
X-CMS-MailID: 20180704010646epcas2p1ddee5d32b281c2a7c52543add37827a2
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703132943epcas1p25b68c00ca1143d5eabcc2285c2ce27a0
References: <CGME20180703132943epcas1p25b68c00ca1143d5eabcc2285c2ce27a0@epcas1p2.samsung.com>
        <20180703132931.14389-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On 2018년 07월 03일 22:29, Enric Balletbo i Serra wrote:
> When the devfreq driver and the governor driver are built as modules,
> the call to devfreq_add_device() or governor_store() fails because the
> governor driver is not loaded at the time the devfreq driver loads. The
> devfreq driver has a build dependency on the governor but also should
> have a runtime dependency. We need to make sure that the governor driver
> is loaded before the devfreq driver.
> 
> This patch fixes this bug by adding a try_then_request_governor()
> function. First tries to find the governor, and then, if it is not found,
> it requests the module and tries again.
> 
> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor using name)
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v4:
> - Kept "locked" devfreq_list from the return of find_devfreq_governor() to
>   the unlock of governor_store(). Requested by MyungJoo Ham.
> 
> Changes in v3:
> - Remove unneded change in dev_err message.
> - Fix err returned value in case to not find the governor.
> 
> Changes in v2:
> - Add a new function to request the module and call that function from
>   devfreq_add_device and governor_store.
> 
>  drivers/devfreq/devfreq.c | 53 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0b5b3abe054e..4ea6b19879a1 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/kmod.h>
>  #include <linux/sched.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
> @@ -221,6 +222,46 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
>  	return ERR_PTR(-ENODEV);
>  }
>  
> +/**
> + * try_then_request_governor() - Try to find the governor and request the
> + *                               module if is not found.
> + * @name:	name of the governor

Usually, devfreq used 'governor_name' indicating the name of governor.
you better to use 'governor_name' instead of 'name' for more readability.

> + *
> + * Search the list of devfreq governors and request the module and try again
> + * if is not found. This can happen when both drivers (the governor driver
> + * and the driver that call devfreq_add_device) are built as modules.
> + * devfreq_list_lock should be held by the caller.
> + *
> + * Return: The matched governor's pointer.

Usually, devfreq.c didn;t use the 'Return: ...'. So, you better to explain
what is returned from this function with function description.

> + */
> +static struct devfreq_governor *try_then_request_governor(const char *name)

ditto. (name -> governor_name)

> +{
> +	struct devfreq_governor *governor;
> +	int err = 0;

You have to check whether governor name is NULL or not.

	if (IS_ERR_OR_NULL(name)) {                                             
		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);          
		return ERR_PTR(-EINVAL);
	}

> +
> +	WARN(!mutex_is_locked(&devfreq_list_lock),
> +	     "devfreq_list_lock must be locked.");
> +
> +	governor = find_devfreq_governor(name);
> +	if (IS_ERR(governor)) {
> +		mutex_unlock(&devfreq_list_lock);
> +
> +		if (!strncmp(name, DEVFREQ_GOV_SIMPLE_ONDEMAND,
> +			     DEVFREQ_NAME_LEN))
> +			err = request_module("governor_%s", "simpleondemand");
> +		else
> +			err = request_module("governor_%s", name);
> +		if (err)
> +			return NULL;

When error happen, you unlock the mutex. If failed to request module,
you should restore the previous state. Please mutex_lock(&devfreq_list_lock)
before return.

> +
> +		mutex_lock(&devfreq_list_lock);
> +
> +		governor = find_devfreq_governor(name);
> +	}
> +
> +	return governor;
> +}
> +
>  static int devfreq_notify_transition(struct devfreq *devfreq,
>  		struct devfreq_freqs *freqs, unsigned int state)
>  {
> @@ -643,11 +684,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	srcu_init_notifier_head(&devfreq->transition_notifier_list);
>  
>  	mutex_unlock(&devfreq->lock);
> -

This change is not related to this patch.

>  	mutex_lock(&devfreq_list_lock);
> -	list_add(&devfreq->node, &devfreq_list);
>  
> -	governor = find_devfreq_governor(devfreq->governor_name);
> +	governor = try_then_request_governor(devfreq->governor_name);
>  	if (IS_ERR(governor)) {
>  		dev_err(dev, "%s: Unable to find governor for the device\n",
>  			__func__);
> @@ -663,14 +702,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  			__func__);
>  		goto err_init;
>  	}
> +
> +	list_add(&devfreq->node, &devfreq_list);
> +
>  	mutex_unlock(&devfreq_list_lock);
>  
>  	return devfreq;
>  
>  err_init:
> -	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
> -

This change is not related to this patch.

>  	device_unregister(&devfreq->dev);
>  err_dev:
>  	if (devfreq)
> @@ -989,7 +1029,8 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  
>  	mutex_lock(&devfreq_list_lock);
> -	governor = find_devfreq_governor(str_governor);
> +

Don't need to add the blank line. It is enough to change the function
from find_devfreq_governor to try_then_request_governor.

> +	governor = try_then_request_governor(str_governor);
>  	if (IS_ERR(governor)) {
>  		ret = PTR_ERR(governor);
>  		goto out;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
