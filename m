Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D581BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8295620647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="arl1sqYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8295620647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeH3C7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:59:00 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:32190 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH3C67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:58:59 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180829225946epoutp04e4dec61ae9d42851ec3a9f17e626153c~PfSLdj3ea3085330853epoutp04V;
        Wed, 29 Aug 2018 22:59:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180829225946epoutp04e4dec61ae9d42851ec3a9f17e626153c~PfSLdj3ea3085330853epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535583586;
        bh=DXUsN0+1Mi5Fs3WOb11J9M6iS/wrB5xRBrKds3KMtjY=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=arl1sqYWgjOi5Qo5n+9L4alClA2qKKEaIPhjfy/ZQDe2nk1elKqFgvCFXJ8qK97N2
         zc1t1YLRRGbZxqJmJxcfQeJRzFVYwsNmYe+IbibyFGU+UPExUC4Ycldmar0RwSNiTx
         yqlunHC3oMobsMxadZ7Uivvwp5rboXpXG/FfPk1o=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20180829225944epcas1p3f7a04d3a4d728e255f06b477862adeaf~PfSJJkRVL3191831918epcas1p3H;
        Wed, 29 Aug 2018 22:59:44 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.78.04218.F55278B5; Thu, 30 Aug 2018 07:59:44 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20180829225943epcas2p3f799ee197d6c5aa7d3379761dcea8dd3~PfSIjDd9f2202822028epcas2p3r;
        Wed, 29 Aug 2018 22:59:43 +0000 (GMT)
X-AuditID: b6c32a45-253ff7000000107a-1f-5b87255f56fd
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.06.03703.F55278B5; Thu, 30 Aug 2018 07:59:43 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PE800I9RVVJK090@mmp1.samsung.com>; Thu, 30 Aug 2018 07:59:43 +0900 (KST)
Message-id: <5B87255F.80207@samsung.com>
Date:   Thu, 30 Aug 2018 07:59:43 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rafael.j.wysocki@intel.com, chanwoo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Add new name attribute for sysfs
In-reply-to: <3263263.FggQa7iA9D@amdc3058>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmqW6Canu0wa//TBYbZ6xntZh44wqL
        xdmmN+wWl3fNYbP43HuE0eJ24wo2i8cr3rJbLNj4iNGBw2PxnpdMHptWdbJ59G1ZxejxeZNc
        AEtUqk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0BlK
        CmWJOaVAoYDE4mIlfTubovzSklSFjPziElulaENDIz1DA3M9IyMgbRxrZWQKVJKQmnHjziSW
        greCFQ8Of2BrYNzI18XIwSEhYCLReCW+i5GLQ0hgB6PE/eUvmCGc74wSaydtYu1i5AQr+j75
        KytEYjejxNeO7ywgCV4BQYkfk++xgExiFpCXOHIpGyTMLKApsXX3enaI+ruMEpv33WaCqNeQ
        mHp3GzOIzSKgKvFg1jOwBWwCWhL7X9xgA7H5BRQlrv54zAhiiwpESOyc/40dxBYRsJBYu+It
        C8hQZpAjVp69DVYkLOAsMXH5e7CDOIEGTZ99BmyzhMBlNolJi/exQLzgIrHx4wtmCFtY4tXx
        LewQtrTEs1UbGSEa2hklvrxoZoVwJjBKfDi1mQmiylji2cIuJojn+CQ6Dv9lh4Qer0RHmxBE
        iYdE1/pGJoifdzJKLHn+nXUCo+wspGCahQimWUjBtICReRWjWGpBcW56arFRgaFecWJucWle
        ul5yfu4mRnBy03LdwTjjnM8hRgEORiUe3gsz2qKFWBPLiitzDzFKcDArifBynQMK8aYkVlal
        FuXHF5XmpBYfYjQFhvJEZinR5Hxg4s0riTc0NTI2NrYwNbc0NrBUEuet9guOFhJITyxJzU5N
        LUgtgulj4uCUamCsZdO4nfYmxjtofrFq3rI9fxsyAqptEt3c+zcfsMr/vsi1/t379FDLyYl7
        qg5Ec93gXJzLGdd67sEhlneiXz7Jp5m/KlkqfXN5do+QZ967ea8bzqjVuLdMO+Ymm5Lr9S3o
        0f/yi24Kr7rzLde++8q5JPL4B9cJmTvD2o/zxzV2H0/y/6PwoUSJpTgj0VCLuag4EQClR06t
        hAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsVy+t9jAd141fZogzeTpS02zljPajHxxhUW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFo9XvGW3WLDxEaMDh8fiPS+ZPDat6mTz6NuyitHj8ya5
        AJYoLpuU1JzMstQifbsErowbdyaxFLwVrHhw+ANbA+NGvi5GTg4JAROJ75O/snYxcnEICexk
        lJj69hUbSIJXQFDix+R7LF2MHBzMAvISRy5lg4SZBdQlJs1bxAxRf59R4sex/SwQ9RoSU+9u
        YwaxWQRUJR7MesYKYrMJaEnsf3EDbCa/gKLE1R+PGUFmigpESHSfqAQJiwhYSKxd8ZYFZCaz
        wG5Gibv/f4HNFBZwlpi4/D0LxDKgxLpl/8EWcAINnT77DPsERoFZSG6dhXDrLCS3LmBkXsUo
        mVpQnJueW2xUYJSXWq5XnJhbXJqXrpecn7uJERjs2w5r9e9gfLwk/hCjAAejEg/vhRlt0UKs
        iWXFlbmHGCU4mJVEeLnOAYV4UxIrq1KL8uOLSnNSiw8xSnOwKInz8ucfixQSSE8sSc1OTS1I
        LYLJMnFwSjUwqpe8388XqXo0eOVniRdO3TP5Xh6e9jPR6Ne5dWv+BS/srQvbLfFonVq/JHef
        XKFMU2X34R+lPmtnqC6cqWBfn2jcsubIi33HrcNu+K0OvthyMXiF6tYlD066LT4bG/IzWe+2
        zY9w3j9h60X4Pay4a0/mfnPL+T9zPW/rrYM7zbsitdvT2m79VGIpzkg01GIuKk4EAIAVd0dy
        AgAA
X-CMS-MailID: 20180829225943epcas2p3f799ee197d6c5aa7d3379761dcea8dd3
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122
References: <CGME20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122@epcas1p2.samsung.com>
        <1535528046-18835-1-git-send-email-cw00.choi@samsung.com>
        <3263263.FggQa7iA9D@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

On 2018년 08월 29일 21:50, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Chanwoo,
> 
> On Wednesday, August 29, 2018 04:34:06 PM Chanwoo Choi wrote:
>> commit 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for
>> sysfs") changed the node name to devfreq(x). After this commit, it is not
>> possible to get the device name through /sys/class/devfreq/devfreq(X)/*.
>>
>> Add new name attribute in order to get device name.
> 
> Could you please describe the issue encountered in more detail
> (what the old device name is needed for)?

You can check it on mail thread[1].
[1] https://lkml.org/lkml/2018/5/8/1042

>  
>> Cc: stable@vger.kernel.org
>> Fixes: 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for sysfs")
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 11 +++++++++++
>>  include/linux/devfreq.h   |  3 +++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 4c49bb1330b5..2145563d5ee5 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -620,6 +620,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	}
>>  	devfreq->max_freq = devfreq->scaling_max_freq;
>>
>> +	devfreq->name = dev_name(devfreq->dev.parent);
> 
> It seems that 'dev' can be used instead of 'devfreq->dev.parent'.

devfreq->dev.parent is same with dev. it doesn't matter.

> 
>> +	if (IS_ERR_OR_NULL(devfreq->name))
> 
> Error values are not encoded into pointer returned by dev_name()
> (drivers/base/ code is only checking for pointer being NULL).

OK. I'll just check whether NULL or not.

> 
>> +		return -EINVAL;
> 
> This leaks 'devfreq' object and doesn't encode return value into
> pointer returned by devfreq_add_device(), it should be replaced by:

Right. I'll fix it.

> 
> 	err = -EINVAL;
> 	goto err_dev;
> 
>>  	dev_set_name(&devfreq->dev, "devfreq%d",
>>  				atomic_inc_return(&devfreq_no));
>>  	err = device_register(&devfreq->dev);
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
