Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C87BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A248213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FvDD3zdJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A248213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeLFBSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:18:01 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:43053 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLFBSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:18:00 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181206011756epoutp0264540841ab7d1f32a0d9e36445dabc8f~tmYyKDTvb3148831488epoutp02_;
        Thu,  6 Dec 2018 01:17:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181206011756epoutp0264540841ab7d1f32a0d9e36445dabc8f~tmYyKDTvb3148831488epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544059076;
        bh=rO6+7vedM3VIPPy+ACWq9sRhJJmlX93RUgnGkA4sq34=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=FvDD3zdJhBnZwTHuF41oQkwi/HC69D04ZDXwX9Y/tY2KdVEfE66ACf6FoPWNPfhks
         WIBSmMclL5PqGW/OGscjtycOetzaJrUignFTe+NrzC52KlEUsQrqV4pk8eeWkvzHwd
         fl5Jqtw46A4B+purHegklyBG1Z5Bfq/TaMEbDxkI=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.153]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181206011753epcas1p2a1ee8c954d993b6a116f4f5b05db601d~tmYv2oHhA0770307703epcas1p2x;
        Thu,  6 Dec 2018 01:17:53 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.A6.04060.1C8780C5; Thu,  6 Dec 2018 10:17:53 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181206011753epcas2p3a45b7e5e2f1758e887613df51a7ad801~tmYvYlXJw0727007270epcas2p3B;
        Thu,  6 Dec 2018 01:17:53 +0000 (GMT)
X-AuditID: b6c32a46-b45ff70000000fdc-cc-5c0878c195df
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.E6.03627.0C8780C5; Thu,  6 Dec 2018 10:17:53 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJA008NAJLSEI00@mmp1.samsung.com>; Thu, 06 Dec 2018 10:17:52 +0900 (KST)
Message-id: <5C0878C0.4060500@samsung.com>
Date:   Thu, 06 Dec 2018 10:17:52 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v3 2/5] devfreq: add support for suspend/resume of a
 devfreq device
In-reply-to: <1544007956-28889-3-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjeubf3A7PqWUE9wNR6F00gAVu6yqkRt2XG3ES2sfhnGyx4Q+8K
        o1/rbYmYZasi6FgUNsni2MRt4MZqiVALyKcBysxw8qGCzoHONXEdIiHDAfEDbXvdxr/nfd/n
        fc77vOccllRN0wlsgdUpOqyCmaOXKVr6ktJTevawOZrSBxzuaU7CTcdOU7i1aY7CJwKDFC6p
        PU3jXz614IrgHRIPDTUy+OL+KQZfdz+Pq6u6COwLjlH4cvvXNJ49HAD42FA3gRsCEww+eXWE
        wL/tq6fxxEB/WOPCJQqXdgUYXHZqhsJTwzcUL6/mWzpaKN5b4wX8V+4RBV9Z8Tfgazv/Inif
        5xOaP3fcy/Bn6j7mF39i+J7pToL3jx5U8Ef8HsDXn5pn+Fnf2qzl7xRuzRcFo+hQi9Y8m7HA
        asrgdu7KfTVXv1mjTdEacDqntgoWMYPbnpmVsqPAHLbPqYsEsyucyhIkidu0bavD5nKK6nyb
        5MzgRLvRbDfYUyXBIrmsptQ8m2WLVqNJ04eJuwvzq7rnCPs4t+eHmmI3WEgsBzEsgi+i+slm
        uhwsY1XwLEAl072kHMwD5CvrBv+x7noJudARZt26TkQKSvgcWjh6Q1EOWJaE61DgUmEkTcIk
        FLr3uULmTwD0YNhPy/xk9P2v7WQEK+AG1P9HKxPBdDh/LnQtylkB16PRhWD04JXwLdR2Yo6J
        CMXBIYC8bZ3RKUhYSqLFGVk1Fr6NFgfd0Y4YuBNdHP+Slsf+h0Htk+/LeDs60Njx1E4smjzv
        Z2SciG57mkBEFMGDAN0LlVByUAnQzMAZQmbp0O1vywnZ3HJ0qO8RE/GMoBIdKlPJkEfD/WrZ
        8k2AaquuEJVgTfWSLVX/v6XqJVv6BpAesEq0SxaTKKXZ05Zenw9E33ryjrOgbjCzF0AWcM8q
        Q78zOSpKKJKKLb0AsSQXp3wmlc1RKY1C8V7RYct1uMyi1Av04SV/RiaszLOFf47VmavVp+l0
        OqxPN+g0Bm618lbi8WwVNAlOsVAU7aLj3z6CjUlwg+w3Zj1ryA0v8TB7spkNrTh//6N4zarZ
        C4GT73V8sLZxXTdl6dk23ze2d+KmJXi3bP3hR8qqqxtHr/049rAt9rXvaphg64dxA/2mXYbA
        7njuaMvPXUV3iJEF4+XxA953hY1/xr/pff2LqVcaGh4zyXPs5sp0jT8z4Yrk4upeqAgUbDrC
        KaR8QZtMOiThCf1UIBABBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02RW0iTYRjHfb+zy+XnVHzTqBxIJOSJLl4izIuID7opCM1Y2dAvNd2hzdMi
        aGkaU/JQI9TyAJrKnJlTZ5qHZlMk06WlZqmhSyo8YI3UvJCcUnb343n+/J4/PAwuek/4Mony
        FF4llyaLKQExuGlnj1oyGElIdyuFLK1HUFNxI4namlZJVGEdJlFWVSOF3uTJUIF9AUc22zMa
        DWUu0uijdj8q1XdhyGQfJ9G7jscUctyzAlRs68ZQg3WaRk8mRjD06XYdhaZf9205BkdJlN1l
        pVFO/QqJFt/OEBE+nPmFmeSM5UbAPdKOEFxhwU/AVXV+xziTQUdxPWVGmmuuvsVt9tOcZbkT
        41rG7hJcfosBcHX1azTnMB04u/ei4EQcn5yYxquCw68IEvTdq5hySpxRW67RgnW/XODKQPYY
        rFsyYrlAwIjYdgDvzBpp50LIesD1BzNELmAYnD0IraNJO3gY6vWynfhnAJv6l8mdeCCsmezA
        nUywAbBvrm1bQ23Ne759oJzszvrDsXU7cHq82Qswb0Dj9HixNgAt+bptD85m43Au55qTPdlo
        uDmsBf+Omds3tqWu7Bk4NFVCFQK29L+qpbtVS3erVgLcAPbxSrUsXqYOU4bJ+fQgtVSmTpXH
        B8UqZCaw9Wvzq8CC58BeHdMLWAaI3YSFM7RERErT1BpZL4AMLvYSugQxEpEwTqq5wasUMarU
        ZF7dC/wYQuwjdFf0R4vYeGkKn8TzSl71d4sxrr5aoOhg5biLDfhpBwTHZ6c3lzI4h91Umb/H
        UJNnCeAlblcH/R+Og0uO0/a1vRrl74D56+ewmyvESK3kS4RHclRkqNF+WWTOjD1UpHjaXFKU
        FfmjTyd7mbmiO/WrJCq9uN39/gY8r28IOJmz9nUor8wTuE0Kguc3FkIqgMF7IlxMqBOkoYG4
        Si39A/BL+J3nAgAA
X-CMS-MailID: 20181206011753epcas2p3a45b7e5e2f1758e887613df51a7ad801
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110620eucas1p14de70dc092580b684a0304b5ce771605@eucas1p1.samsung.com>
        <1544007956-28889-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 2018년 12월 05일 20:05, Lukasz Luba wrote:
> The patch prepares devfreq device for handling suspend/resume
> functionality. The new fields will store needed information during this
> process. Devfreq framework handles opp-suspend DT entry and there is no
> need of modyfications in the drivers code. It uses atomic variables to
> make sure no race condition affects the process.
> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 47 +++++++++++++++++++++++++++++++++++++++++------
>  include/linux/devfreq.h   |  7 +++++++
>  2 files changed, 48 insertions(+), 6 deletions(-)

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index a9fd61b..46517b6 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -316,6 +316,10 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>  			"Couldn't update frequency transition information.\n");
>  
>  	devfreq->previous_freq = new_freq;
> +
> +	if (devfreq->suspend_freq)
> +		devfreq->resume_freq = cur_freq;
> +
>  	return err;
>  }
>  
> @@ -667,6 +671,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	}
>  	devfreq->max_freq = devfreq->scaling_max_freq;
>  
> +	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
> +	atomic_set(&devfreq->suspend_count, 0);
> +
>  	dev_set_name(&devfreq->dev, "devfreq%d",
>  				atomic_inc_return(&devfreq_no));
>  	err = device_register(&devfreq->dev);
> @@ -867,14 +874,28 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>   */
>  int devfreq_suspend_device(struct devfreq *devfreq)
>  {
> +	int ret;
> +
>  	if (!devfreq)
>  		return -EINVAL;
>  
> -	if (!devfreq->governor)
> +	if (atomic_inc_return(&devfreq->suspend_count) > 1)
>  		return 0;
>  
> -	return devfreq->governor->event_handler(devfreq,
> -				DEVFREQ_GOV_SUSPEND, NULL);
> +	if (devfreq->governor) {
> +		ret = devfreq->governor->event_handler(devfreq,
> +					DEVFREQ_GOV_SUSPEND, NULL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (devfreq->suspend_freq) {
> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(devfreq_suspend_device);
>  
> @@ -888,14 +909,28 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>   */
>  int devfreq_resume_device(struct devfreq *devfreq)
>  {
> +	int ret;
> +
>  	if (!devfreq)
>  		return -EINVAL;
>  
> -	if (!devfreq->governor)
> +	if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>  		return 0;
>  
> -	return devfreq->governor->event_handler(devfreq,
> -				DEVFREQ_GOV_RESUME, NULL);
> +	if (devfreq->resume_freq) {
> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (devfreq->governor) {
> +		ret = devfreq->governor->event_handler(devfreq,
> +					DEVFREQ_GOV_RESUME, NULL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(devfreq_resume_device);
>  
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index e4963b0..d985199 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -131,6 +131,9 @@ struct devfreq_dev_profile {
>   * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>   * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>   * @stop_polling:	 devfreq polling status of a device.
> + * @suspend_freq:	 frequency of a device set during suspend phase.
> + * @resume_freq:	 frequency of a device set in resume phase.
> + * @suspend_count:	 suspend requests counter for a device.
>   * @total_trans:	Number of devfreq transitions
>   * @trans_table:	Statistics of devfreq transitions
>   * @time_in_state:	Statistics of devfreq states
> @@ -167,6 +170,10 @@ struct devfreq {
>  	unsigned long scaling_max_freq;
>  	bool stop_polling;
>  
> +	unsigned long suspend_freq;
> +	unsigned long resume_freq;
> +	atomic_t suspend_count;
> +
>  	/* information for device frequency transition */
>  	unsigned int total_trans;
>  	unsigned int *trans_table;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
