Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BADC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5CF214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XqOowwIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5CF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbeLDFgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:36:18 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:14517 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeLDFgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:36:18 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181204053615epoutp02380fc98edc33c4350effa94c4d6e87d5~tCnwXBp2k1281112811epoutp02C;
        Tue,  4 Dec 2018 05:36:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181204053615epoutp02380fc98edc33c4350effa94c4d6e87d5~tCnwXBp2k1281112811epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543901775;
        bh=KcuQ2k4cSB8paUNuhdomC7q2w0oKUqGv1RxpN+45NUA=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=XqOowwIyyYJ7bIgnVXVEMLZgRrxukD5fC18PkGUPFAfxlSpVCAmhvHpuPtfr/uP2t
         ydy9NT9P2yhDoADEuxm5WLs+KCjZejbvFYrSjMpe+b5yGh/jU1CqfQOucZadL23uMj
         RLfrVvGQ8iCIZ4daICX6BqleX4XAdKyaV347QAZo=
Received: from epsmges2p4.samsung.com (unknown [182.195.40.153]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181204053612epcas1p2030242731222dadd867a8b416b49c15b~tCnuAEJgF1499314993epcas1p2m;
        Tue,  4 Dec 2018 05:36:12 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.36.04055.C42160C5; Tue,  4 Dec 2018 14:36:12 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20181204053612epcas2p2d2bae82ef8af2e80261abc67c6a43962~tCntr-Rwi2921329213epcas2p2P;
        Tue,  4 Dec 2018 05:36:12 +0000 (GMT)
X-AuditID: b6c32a48-3c1ff70000000fd7-a7-5c06124cbf3d
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.31.03627.C42160C5; Tue,  4 Dec 2018 14:36:12 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJ7006V668BWR60@mmp1.samsung.com>; Tue, 04 Dec 2018 14:36:12 +0900 (KST)
Message-id: <5C06124B.5030409@samsung.com>
Date:   Tue, 04 Dec 2018 14:36:11 +0900
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
Subject: Re: [PATCH v2 2/5] devfreq: add support for suspend/resume of a
 devfreq device
In-reply-to: <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJsWRmVeSWpSXmKPExsWy7bCmua6PEFuMwfl2HYuDWzUtNs5Yz2qx
        feM3Vov5R86xWjQvXs9mcaY716L/8Wtmi/PnN7BbnG16w25xq0HGYtaUvUwWmx5fY7W4vGsO
        m8Xn3iOMFjPO72OyWHvkLrvF0usXmSxuN65gs7h76ijQjNOXWC1a9x5ht2hb/YHV4s2FeywO
        4h7bdm9j9Vgzbw2jx+yGiyweE/o/MXos3vOSyWPTqk42j/1z17B7bF5S7/HvGLvHwXd7mDy2
        XG1n8ejbsorRY8Xq7+wenzfJBfBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
        KynkJeam2iq5+AToumXmAL2vpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNAr
        TswtLs1L10vOz7UyNDAwMgUqTMjO+HDhJlvBXtWKmyd/MzUw/pTtYuTkkBAwkXjb3cTUxcjF
        ISSwg1Hi0KJ3LBDOd0aJm5N3s8JUtU4+DpXYzShxf+cBZpAEr4CgxI/J94ASHBzMAvISRy5l
        g4SZBTQlXnyZBFV/l1Hi/6xPUPVaEpO+bQSzWQRUJbbfegNmswHF97+4wQZi8wsoSlz98ZgR
        xBYViJDYOf8bO8ggEYHzjBJrdu4Bu5VZoJVZ4t+HLWAdwgKREqcWPwWbxCngJTH5xDlWkCIJ
        gUYOiWX39jND/OAi8XPhZyYIW1ji1fEt7BC2tMSzVRsZIRraGSW+vGiG6p7AKPHh1GaoDmOJ
        Zwu7mCC+45PoOPyXHeRpCQFeiY42IYgSD4m+nnXscE8/nN7HNIFRdhZSOM1ChNMspHBawMi8
        ilEstaA4Nz212KjABDkGNzGCk7uWxw7GA+d8DjEKcDAq8fA6OLDGCLEmlhVX5h5ilOBgVhLh
        LShkiRHiTUmsrEotyo8vKs1JLT7EaAoM5onMUqLJ+cDMk1cSb2hqZGxsbGFqbmlsYKkkzvtQ
        em60kEB6YklqdmpqQWoRTB8TB6dUA+N8s2tz/vttYaow7/n44F7DoqKn8w89fKDCnxx9+eOd
        c+0fXO9/N1/6T5+jfgLrnrPn2op4292vzg56Ebyw7vn88w7ZTNXrp/a6zi9NND5qIH/z7CPb
        qyeP358T2dU1UXDvpoanDsv5Pq9NPtl1sKDtXXjVtAuBDnJGKyq1z8hc67yumvxTOFRLiaU4
        I9FQi7moOBEAvojoEAQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t9jAV0fIbYYg/vdEhYHt2pabJyxntVi
        +8ZvrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+xmpxedcc
        NovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOrxZsL91gc
        xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
        udrO4tG3ZRWjx4rV39k9Pm+SC+CL4rJJSc3JLEst0rdL4Mr4cOEmW8Fe1YqbJ38zNTD+lO1i
        5OSQEDCRaJ18nKWLkYtDSGAno0T7shfMIAleAUGJH5PvASU4OJgF5CWOXMqGMNUlpkzJhSi/
        zyhx5dsiFohyLYlJ3zaCtbIIqEpsv/UGzGYDiu9/cYMNxOYXUJS4+uMxI8gcUYEIie4TlSBz
        RATOM0oc7OtkBalhFmhllnjUlgViCwtESpxa/JQZYtldRokJ+9YygSQ4BbwkJp84xzqBUWAW
        klNnIZw6C+HUBYzMqxglUwuKc9Nzi40KjPJSy/WKE3OLS/PS9ZLzczcxAiN722Gt/h2Mj5fE
        H2IU4GBU4uF1cGCNEWJNLCuuzD3EKMHBrCTCW1DIEiPEm5JYWZValB9fVJqTWnyIUZqDRUmc
        lz//WKSQQHpiSWp2ampBahFMlomDU6qBcf8a5/QWx/bPbKf71Z9tMGM8rsCYVnYuNfTJWW+n
        HudWmTX7jie0v9o//1y7gt8Vddd5tb17qjdN3NBYN0XliPA6icyzrbtnTN70O3nF9FNya+Ys
        v/Z4/e2wOZxzV1unPLwXnhu9eB2v7//NIXl8bczKS1M/FwW8uXvc8O2l+7K/X10UieJg+KnE
        UpyRaKjFXFScCACbozxJ6AIAAA==
X-CMS-MailID: 20181204053612epcas2p2d2bae82ef8af2e80261abc67c6a43962
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
        <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

Looks good to me. But, I add the some comments.
If you will fix it, feel free to add my tag:
Reviewed-by: Chanwoo choi <cw00.choi@samsung.com>

On 2018년 12월 03일 23:31, Lukasz Luba wrote:
> The patch prepares devfreq device for handling suspend/resume
> functionality.  The new fields will store needed information during this

nitpick. Remove unneeded space. There are two spaces between '.' and 'The new'. 

> process.  Devfreq framework handles opp-suspend DT entry and there is no

ditto.

> need of modyfications in the drivers code.  It uses atomic variables to

ditto.

> make sure no race condition affects the process.
> 
> The patch is based on earlier work by Tobias Jakobi.

Please remove it from each patch description.

> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 51 +++++++++++++++++++++++++++++++++++++++--------
>  include/linux/devfreq.h   |  7 +++++++
>  2 files changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index a9fd61b..36bed24 100644
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
> -		return 0;
> +	if (devfreq->governor) {
> +		ret = devfreq->governor->event_handler(devfreq,
> +					DEVFREQ_GOV_SUSPEND, NULL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (devfreq->suspend_freq) {
> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
> +			return 0;
> +
> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	return devfreq->governor->event_handler(devfreq,
> -				DEVFREQ_GOV_SUSPEND, NULL);
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
> -		return 0;
> +	if (devfreq->resume_freq) {
> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
> +			return 0;
>  
> -	return devfreq->governor->event_handler(devfreq,
> -				DEVFREQ_GOV_RESUME, NULL);
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
