Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE71C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93B52087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aZH8dZaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93B52087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbeLDGTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:19:42 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:11738 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLDGTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:19:42 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181204061936epoutp0347b1937a6968b8e23a17ef8fd9c93e8b~tDNm5rLKw3207632076epoutp038;
        Tue,  4 Dec 2018 06:19:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181204061936epoutp0347b1937a6968b8e23a17ef8fd9c93e8b~tDNm5rLKw3207632076epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543904376;
        bh=KAWhR31NxtOmiWLfxm4iRJWBqukFe+N418flXq88B2A=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=aZH8dZaWNWd5u4ZRQHMwT/jNZ/UbRsT0i84oyay2e8nTQy+X28GRuq5tOqv+vQpvB
         vscvr7JyRMzLaXLtT6nSPG/ASI71bgukLNS3WjaJKdIO7xtw4LjAjvBD8PtAO2e0fg
         Sg7uCFDvpO2AZAlmaOpd42f27Kumg4LlxuzuBnpc=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.158]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181204061933epcas1p130cb84e1eea4741d9316db3419d2971f~tDNkQkuf52171421714epcas1p1V;
        Tue,  4 Dec 2018 06:19:33 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.F5.04055.57C160C5; Tue,  4 Dec 2018 15:19:33 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181204061933epcas2p3fc013e7960266fcf9e3f1abab94bdd61~tDNjzxLcZ2199121991epcas2p39;
        Tue,  4 Dec 2018 06:19:33 +0000 (GMT)
X-AuditID: b6c32a45-711ff70000000fd7-69-5c061c75d631
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        45.82.03627.47C160C5; Tue,  4 Dec 2018 15:19:33 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJ700A4V88KCE60@mmp1.samsung.com>; Tue, 04 Dec 2018 15:19:32 +0900 (KST)
Message-id: <5C061C74.808@samsung.com>
Date:   Tue, 04 Dec 2018 15:19:32 +0900
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
Subject: Re: [PATCH v2 3/5] devfreq: add devfreq_suspend/resume() functions
In-reply-to: <1543847475-7600-4-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xbVRjNfa/vB8uKb2VsV5hbfcZlkLC11MrFrEbdNC92USL+sSgGn/AC
        rL+efS2KjlAGjK3LXJXF1G6IA4YTuhRYxxiwkZU6kg1XwYCLkyUOM4EthIyFTZ1oXx8q/53z
        fee7955z76VxzRyZRpfZXYLTzltZcpWqZygjJ8u9gSzQfR5k0aWzGajLHyLQua5FAjVFrxGo
        piVEopFDNnRk6g6OYrFOCn237y6FfvJsQIGjFzDUPTVBoB/6jpNo4XAUIH/sIoZORycpdPLH
        UQzdqD5Foskr38bXuDpGoLoLUQrt75gn0N3vb6peWM/19PcQXPDLIOCOeUZVnO/IPcC1DMxg
        XHf7QZIbbAxS3JnWKm7pMsVdmhvAuPB4vYr7JNwOuFMdDyhuoXtjXvJblu2lAl8sOLWCvchR
        XGYvMbHm/MIdhcZndfosfS7KYbV23iaY2J278rJeKbPG7bPact7qjpfyeElitz2/3elwuwRt
        qUNymVhBLLaKueJWibdJbnvJ1iKH7Tm9TpdtjAvftZR2NTwuHtv44RdtU8ADYtALkmjIPAN7
        /AdJL1hFa5heAP1tzZRCHgDY+atMllWLh4DS6Aewdt8sITfUzBr4sOGmygtoGmc2weiYRS7j
        TAacvv+ZStFPAjgW6AOyRs1shr0TH8saFfM0PDd6mZQxyWTCwenrCfwY8yQcfzgFZJzK7Ibn
        mxYTB1rLxAAMnh/AZIIzdThcmg8nJlIYM/yldiQxkcS8CsNNdxI7Q6aahh0XD5OKhZ1wYrZ/
        2U4KnB0OL+N0eLu9CygD9QDen64hFOIDcP7KGUxRGeDtE15MMZcMDwz9Rcl+IKOGB/ZrFMjB
        E3Nr/rP89x+zwAeeCKxIKfB/SoEVKX0F8HawThAlW4kgZYv6ldfXDRJvPfPlXuC/tisCGBqw
        q9X+l4gCDcGXSxW2CIA0zq5Vi++rCjTqYr7iI8HpKHS6rYIUAcZ4yp/iaalFjvjPsbsK9cZs
        g8GAjDm5Bl0uu159K73xbQ1TwrsEiyCIgvPfOYxOSvOAVG/zN62v8ebGdabVFSHPXtvpoXf8
        u09u2rKFv7XgE4vSQ8cfvdd0NTg+8jOhflReZf6gz1I93PLi0ps3fJV/1t8brP56z1LNTDhy
        9o2UzLoGOrk1ULlnqK5ZO5zv68PCuOn12tQZyt2646nebddDVeHa39gZYGgz741FNuf/XtnJ
        qqRSXp+JOyX+H7PD5F8BBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t9jAd1SGbYYgzldnBYHt2pabJyxntVi
        +8ZvrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+xmpxedcc
        NovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOrxZsL91gc
        xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
        udrO4tG3ZRWjx4rV39k9Pm+SC+CL4rJJSc3JLEst0rdL4MrYOFmyYLZcxcxljxkbGM9LdDFy
        ckgImEhs+9bN2MXIxSEksJNR4vm5u6wgCV4BQYkfk++xdDFycDALyEscuZQNYapLTJmSC1F+
        n1Fi1t9mZpA4r4CaxI5r1SCdLAKqEtsvHmMDsdkEtCT2v7gBZvMLKEpc/fGYEaRcVCBCovtE
        JcgYEYHzjBIH+zrBtjILtDJLPGrLArGFBbwlHracgTrtLqPE1Y+vmEESnAJeElvmv2aZwCgw
        C8mlsxAunYVw6QJG5lWMkqkFxbnpucVGBUZ5qeV6xYm5xaV56XrJ+bmbGIFRve2wVv8OxsdL
        4g8xCnAwKvHwOjiwxgixJpYVV+YeYpTgYFYS4S0oZIkR4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zsuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwDi1xry+ennK1/t2fi+7q9y+7nixknfijOATUqdc
        GBbOms11/3XlbsEJThnTSj9YhLWekf4vOyn93vGl+QbRpbq72fYsXXnS7OqiVSfjCvmeyUw7
        2n4/edYKE1NrN1vfvv+KsTcTG//niG1Rq08slI24cbi768xBn1V3zcuvyZn8NlY8utx5p4ES
        S3FGoqEWc1FxIgAdFJyt5gIAAA==
X-CMS-MailID: 20181204061933epcas2p3fc013e7960266fcf9e3f1abab94bdd61
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143132eucas1p128c029a7c7461e1127924a08e4a71811
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143132eucas1p128c029a7c7461e1127924a08e4a71811@eucas1p1.samsung.com>
        <1543847475-7600-4-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 2018년 12월 03일 23:31, Lukasz Luba wrote:
> This patch adds implementation for global suspend/resume for
> devfreq framework. System suspend will next use these functions.
> 
> The patch is based on earlier work by Tobias Jakobi.

Please remove it from each patch description.

> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  6 ++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 36bed24..7d60423 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -935,6 +935,48 @@ int devfreq_resume_device(struct devfreq *devfreq)
>  EXPORT_SYMBOL(devfreq_resume_device);
>  
>  /**
> + * devfreq_suspend() - Suspend devfreq governors and devices
> + *
> + * Called during system wide Suspend/Hibernate cycles for suspending governors
> + * and devices preserving the state for resume. On some platforms the devfreq
> + * device must have precise state (frequency) after resume in order to provide
> + * fully operating setup.
> + */
> +void devfreq_suspend(void)
> +{
> +	struct devfreq *devfreq;
> +	int ret;
> +
> +	mutex_lock(&devfreq_list_lock);
> +	list_for_each_entry(devfreq, &devfreq_list, node) {
> +		ret = devfreq_suspend_device(devfreq);
> +		if (ret)
> +			dev_warn(&devfreq->dev, "device suspend failed\n");

When I checked the cpufreq_suspend(), cpufreq_suspend() prints message as 'err' level.
I think that dev_err is more proper than dev_warn.

I'm not sure what is more correct log.
But, 'devfreq->dev' device has the separate suspend/resume function.
So, I think that devfreq_suspend() should print error log containing
that it is error by devfreq framework.

"device suspend failed"
-> "failed to suspend devfreq device"

> +	}
> +	mutex_unlock(&devfreq_list_lock);
> +}
> +
> +/**
> + * devfreq_resume() - Resume devfreq governors and devices
> + *
> + * Called during system wide Suspend/Hibernate cycle for resuming governors and
> + * devices that are suspended with devfreq_suspend().
> + */
> +void devfreq_resume(void)
> +{
> +	struct devfreq *devfreq;
> +	int ret;
> +
> +	mutex_lock(&devfreq_list_lock);
> +	list_for_each_entry(devfreq, &devfreq_list, node) {
> +		ret = devfreq_resume_device(devfreq);
> +		if (ret)
> +			dev_warn(&devfreq->dev, "device resume failed\n");

ditto.

"device resume failed"
-> "failed to resume devfreq device"


> +	}
> +	mutex_unlock(&devfreq_list_lock);
> +}
> +
> +/**
>   * devfreq_add_governor() - Add devfreq governor
>   * @governor:	the devfreq governor to be added
>   */
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index d985199..fbffa74 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -205,6 +205,9 @@ extern void devm_devfreq_remove_device(struct device *dev,
>  extern int devfreq_suspend_device(struct devfreq *devfreq);
>  extern int devfreq_resume_device(struct devfreq *devfreq);
>  
> +extern void devfreq_suspend(void);
> +extern void devfreq_resume(void);
> +
>  /**
>   * update_devfreq() - Reevaluate the device and configure frequency
>   * @devfreq:	the devfreq device
> @@ -331,6 +334,9 @@ static inline int devfreq_resume_device(struct devfreq *devfreq)
>  	return 0;
>  }
>  
> +static inline void devfreq_suspend(void) {}
> +static inline void devfreq_resume(void) {}
> +
>  static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>  					   unsigned long *freq, u32 flags)
>  {
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
