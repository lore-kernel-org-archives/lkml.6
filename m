Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D96C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9812D2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ANr80oTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9812D2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeHaM7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:59:12 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:42879 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHaM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:59:11 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180831085243epoutp03994ac0121a5c5cd2c3985a6f79dd6e67~P7BLV7kTg2536925369epoutp03j;
        Fri, 31 Aug 2018 08:52:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180831085243epoutp03994ac0121a5c5cd2c3985a6f79dd6e67~P7BLV7kTg2536925369epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535705563;
        bh=3izehBMZrgnohoRBvf0ncGxZ2/vEzZEgDXCcXAyJzI0=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=ANr80oTkRGIAzu/rOwu19GH3JnrSVKQO/2qEMZ9NLXOPl8kHS7M2Uwps0xMkDxje2
         EBfjb/u+kOMGQ4zFUC+gA3moThettTJu2ABpgn84ER37bn++mkEqCkBsd8wDGEfqTH
         chLYnBusNtWmv5+rrMeVoqtpHzSWd3BVoLQQ59nQ=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180831085240epcas1p26a25dee9cc144f1b2c01dbab4993486d~P7BIKG3wh1011210112epcas1p2b;
        Fri, 31 Aug 2018 08:52:40 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.DF.04305.8D1098B5; Fri, 31 Aug 2018 17:52:40 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180831085239epcas1p2c187a92ff287240eed625541577f0e89~P7BH0w8Pp1219312193epcas1p2a;
        Fri, 31 Aug 2018 08:52:39 +0000 (GMT)
X-AuditID: b6c32a38-595ff700000010d1-37-5b8901d8a6ec
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 51.F6.03702.7D1098B5; Fri, 31 Aug
        2018 17:52:39 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PEB00ACTHZR7C90@mmp2.samsung.com>; Fri, 31 Aug 2018 17:52:39 +0900 (KST)
Message-id: <5B8901D7.5040301@samsung.com>
Date:   Fri, 31 Aug 2018 17:52:39 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     vincent.donnefort@arm.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     john.reitan@arm.com, beata.michalska@arm.com
Subject: Re: [PATCH] PM / devfreq: stopping the governor before
 device_unregister()
In-reply-to: <1535623320-28281-1-git-send-email-vincent.donnefort@arm.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmvu4Nxs5ogz8PWCze3vvIavF91TlW
        i7NNb9gtLu+aw2bxufcIo8XtxhVsFhcbdjA7sHusmbeG0aNvyypGj8+b5AKYo1JtMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslaINDY30DA3M9YyMgLRxrJWRKVBJQmrG38/7WQuWCFdc/dDC1MD4
        nL+LkZNDQsBE4uuel4xdjFwcQgI7GCUm3vvCDuF8Z5SYd/IxI0xV35OTrBCJDYwSXV0LwRK8
        AoISPybfY+li5OBgFpCXOHIpGyTMLKApsXX3eqhBdxklbv87xgpRryWx79xPsF4WAVWJiZsX
        gcXZgOL7X9xgA7H5BRQlrv6AWCwqECGxc/43sEEiAn2MEv+/NzFCbDCQaLnawgRiCwuESmz6
        fZgFxOYU8JKYt+MaC8TVB9gkls0ugrBdJJrOTGOHsIUlXh3fwg5ytISAtMSlo7Yg8yUE2hkl
        vrxoZoVwJjBKfDi1mQmiwVji2cIuJojFfBLvvvawQjTzSnS0CUGUeEhMWjObGeLjuYwSO5a9
        Yp/AKDsLKZBmIQJpFlIgLWBkXsUollpQnJueWmxYYKJXnJhbXJqXrpecn7uJEZzGtCx2MO45
        53OIUYCDUYmHl+F9e7QQa2JZcWXuIUYJDmYlEV7OjI5oId6UxMqq1KL8+KLSnNTiQ4ymwDCe
        yCwlmpwPTLF5JfGGpkbGxsYWJoZmpoaGSuK8Rn7B0UIC6YklqdmpqQWpRTB9TBycUg2Mbjv/
        s3RPv3J9u0n7Jtb15uUqCo59M0ycvXedVLANzUqcqFphJKx0eqHJ9XsvlV+IMd48trpOxD3Z
        OZJTJnVqQnbwuymfhLaVvqz/pvf1tmZ13dUHa5fv5PytsOxw456dLV2OC/+t25Hs+GOvclM+
        v8KJmO0J59b32PrMUKjhK77wXFxO/PwcJZbijERDLeai4kQAP5i1lnkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t9jQd3rjJ3RBufOGFi8vfeR1eL7qnOs
        Fmeb3rBbXN41h83ic+8RRovbjSvYLC427GB2YPdYM28No0ffllWMHp83yQUwR3HZpKTmZJal
        FunbJXBl/P28n7VgiXDF1Q8tTA2Mz/m7GDk5JARMJPqenGTtYuTiEBJYxyix9nEfC0iCV0BQ
        4sfke0A2BwezgLzEkUvZIGFmAXWJSfMWMUPU32eU6L+4kQ2iXkti37mfjCA2i4CqxMTNi1hB
        bDag+P4XN8Bq+AUUJa7+eMwIMlNUIEKi+0QlyBwRgT5GiZV9a5ghFhhItFxtYQKxhQVCJTb9
        PswCsWw+UFFXB9ggTgEviXk7rrFMYBSYheTWWQi3zkJy6wJG5lWMkqkFxbnpucVGBYZ5qeV6
        xYm5xaV56XrJ+bmbGIGBve2wVt8OxvtL4g8xCnAwKvHwMrxvjxZiTSwrrsw9xCjBwawkwsuZ
        0REtxJuSWFmVWpQfX1Sak1p8iFGag0VJnPd23rFIIYH0xJLU7NTUgtQimCwTB6dUA6Pm1EPi
        v59MVuvKMX3/X/r2F9mJQa9O+O1U3n5351bnk+nesot9c3a+4J/VxaZ/tOTtsytHJjf+aHW6
        OltV0Vs7g+fr25ratmt5B2OjLV+z63CqWO1/+JgxLu5rzH0rqY0Oc5qOr8kNKa3+c0JZIveu
        eY7R1LtxKu+nPcyrvLhK5P5aj96Ls3cosRRnJBpqMRcVJwIA8UxcyWgCAAA=
X-CMS-MailID: 20180831085239epcas1p2c187a92ff287240eed625541577f0e89
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180830100409epcas3p266dc05fdd02cd2c086a4355e9a481007
References: <CGME20180830100409epcas3p266dc05fdd02cd2c086a4355e9a481007@epcas3p2.samsung.com>
        <1535623320-28281-1-git-send-email-vincent.donnefort@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 08월 30일 19:02, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> device_release() is freeing the resources before calling the device
> specific release callback which is, in the case of devfreq, stopping
> the governor.
> 
> It is a problem as some governors are using the device resources. e.g.
> simpleondemand which is using the devfreq deferrable monitoring work. If it
> is not stopped before the resources are freed, it might lead to a use after
> free.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Reviewed-by: John Einar Reitan <john.reitan@arm.com>
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4c49bb1..4e43830 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -534,10 +534,6 @@ static void devfreq_dev_release(struct device *dev)
>  	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
>  
> -	if (devfreq->governor)
> -		devfreq->governor->event_handler(devfreq,
> -						 DEVFREQ_GOV_STOP, NULL);
> -
>  	if (devfreq->profile->exit)
>  		devfreq->profile->exit(devfreq->dev.parent);
>  
> @@ -672,7 +668,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	list_del(&devfreq->node);
>  	mutex_unlock(&devfreq_list_lock);
>  
> -	device_unregister(&devfreq->dev);
> +	devfreq_remove_device(devfreq);
>  	devfreq = NULL;
>  err_dev:
>  	if (devfreq)
> @@ -693,6 +689,9 @@ int devfreq_remove_device(struct devfreq *devfreq)
>  	if (!devfreq)
>  		return -EINVAL;
>  
> +	if (devfreq->governor)
> +		devfreq->governor->event_handler(devfreq,
> +						 DEVFREQ_GOV_STOP, NULL);
>  	device_unregister(&devfreq->dev);
>  
>  	return 0;
> 

As description of this patch, if devfreq_wq is executed and then execute
the 'devfreq->governor->get_target_freq' between step1 and step2
after already freed the 'dev' related resource, it might happen the problem
because the registered callback of get_target_freq requires the 'dev' resource.

device_unregister(dev)
	step 1. device_del(dev)
		<- if devfreq_wq is executed
	step 2. put_device(dev)
		device_release()
			devfreq_dev_release()
				stop the governor for specific devfreq instance

It looks good to me. Stop the governor before calling device_unregister().
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>				

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
