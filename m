Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3CBC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02500214DB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G0ApBWes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02500214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeLFBay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:30:54 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:22419 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLFBax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:30:53 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181206013050epoutp03654c897569c028534e2b54cff78c01fe~tmkDUUYRT0968709687epoutp03F;
        Thu,  6 Dec 2018 01:30:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181206013050epoutp03654c897569c028534e2b54cff78c01fe~tmkDUUYRT0968709687epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544059850;
        bh=6Gr1bmJzUWL64rFVd1bqGmgfe5R9n31yoLfNkjesgRM=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=G0ApBWes4rCc9+i2N8h96pwH5K/1AG2cwF7qrkbo5SCw6XgTE6kNykTEEoKmCaJNE
         mberMR6wPPLX2ZDogJkIMoswpGhzMNYIZJzA+/kotba/d/GNtaJbsGovPYy6tRoSSu
         wHcmas++aQ8Wg7bj9qYi9MWYiMlyYHVIOd8rt/2M=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.155]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181206013044epcas1p1a94c9a3550e3fe30e62f596ebf8dc6bc~tmj9v8ein3108331083epcas1p1w;
        Thu,  6 Dec 2018 01:30:44 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.D8.04064.4CB780C5; Thu,  6 Dec 2018 10:30:44 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181206013044epcas1p3df03d153eaf830ff2f35a9dab5755349~tmj9ccmsT3162731627epcas1p3s;
        Thu,  6 Dec 2018 01:30:44 +0000 (GMT)
X-AuditID: b6c32a39-011ff70000000fe0-95-5c087bc42b7b
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 1E.E8.03601.3CB780C5; Thu,  6 Dec
        2018 10:30:44 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJA008KTK776720@mmp2.samsung.com>; Thu, 06 Dec 2018 10:30:43 +0900 (KST)
Message-id: <5C087BC3.1050405@samsung.com>
Date:   Thu, 06 Dec 2018 10:30:43 +0900
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
Subject: Re: [PATCH v3 3/5] devfreq: add devfreq_suspend/resume() functions
In-reply-to: <1544007956-28889-4-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJsWRmVeSWpSXmKPExsWy7bCmnu6Rao4Yg5bzMhYHt2pabJyxntVi
        +8ZvrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+xmpxedcc
        NovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOrxZsL91gc
        xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
        udrO4tG3ZRWjx4rV39k9Pm+SC+CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBX
        nJhbXJqXrpecn2tlaGBgZApUmJCd8W/aapaCfqmK83dXMDUwLhXtYuTkkBAwkdj+6ShjFyMX
        h5DADkaJnsU9UM53RonTjQsYYao+LnvLBJHYwCjx+MIasASvgKDEj8n3WLoYOTiYBeQljlzK
        BgkzC2hKvPgyiQWi/i6jxMGONhaIei2J1Wd+s4PYLAKqEot23gGbwwYU3//iBhuIzS+gKHH1
        x2OwuKhAhMTO+d/YQQaJCJxnlFizcw/YFcwCrcwS/z5sAesQFvCWuNW0hw3kCk4ge/13WZAa
        CYGf7BJv+nYxQbzgIrF241koW1ji1fEt7CD1EgLSEpeO2kLUtzNKfHnRzArhTGCU+HBqM1SD
        scSzhV1MEL/xSbz72sMK0cwr0dEmBGF6SNx5lwNSISRwn1Hi9xOfCYyys5DCaBYijGYhhdEC
        RuZVjGKpBcW56anFhgWmyLG3iRGc1LUsdzAeO+dziFGAg1GJh/fFA/YYIdbEsuLK3EOMEhzM
        SiK8DHocMUK8KYmVValF+fFFpTmpxYcYTYFBPJFZSjQ5H5hx8kriDU2NjI2NLUwMzUwNDZXE
        eZ9IzY0WEkhPLEnNTk0tSC2C6WPi4JRqYJzmf1IkerFj4+r30x77vpjkouZlqPRS2OpC54t/
        Hvl3Zrf/5/y+4+WGgp3+ookbKkOmC/n21nZ7GKe8WO/9a3Wb4rzeWOdnMSEPL/9rmTU3zm3D
        vN97ZW5NrJp7b6KNQWKof930re+nTmxraX/GmKmQlNi9auK2sLsOfTv+L//w8Xzz0qdVd4SU
        WIozEg21mIuKEwESmMPpAAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t9jQd0j1RwxBvNXcVgc3KppsXHGelaL
        7Ru/sVrMP3KO1aJ58Xo2izPduRb9j18zW5w/v4Hd4mzTG3aLWw0yFrOm7GWy2PT4GqvF5V1z
        2Cw+9x5htJhxfh+Txdojd9ktll6/yGRxu3EFm8XdU0eBZpy+xGrRuvcIu0Xb6g+sFm8u3GNx
        EPfYtnsbq8eaeWsYPWY3XGTxmND/idFj8Z6XTB6bVnWyeeyfu4bdY/OSeo9/x9g9Dr7bw+Sx
        5Wo7i0ffllWMHitWf2f3+LxJLoAvissmJTUnsyy1SN8ugSvj37TVLAX9UhXn765gamBcKtrF
        yMkhIWAi8XHZW6YuRi4OIYF1jBJL7q9hBknwCghK/Jh8j6WLkYODWUBe4silbAhTXWLKlFyI
        8vuMEocv7maEKNeSWH3mNzuIzSKgKrFo5x2wOBtQfP+LG2wgNr+AosTVH48ZQeaICkRIdJ+o
        BJkjInCeUeJgXycrSA2zQCuzxKO2LBBbWMBb4lbTHja4Zes3/GQFaeYESqz/LjuBUWAWkktn
        IVw6C+HSBYzMqxglUwuKc9Nzi40KDPNSy/WKE3OLS/PS9ZLzczcxAuN622Gtvh2M95fEH2IU
        4GBU4uF98YA9Rog1say4MvcQowQHs5IIL4MeR4wQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5
        xyKFBNITS1KzU1MLUotgskwcnFINjIL7BRfYLbQy4yt/wjXDferbJzFqlTHsadufLS9uyHfo
        OVjTLuXeHnCoysFFwMrCkelCp+KUp5yOuUUPrr9bwaSfqHx5qoer6V6PqxMZzuqErP38SWWD
        +DJ21ZOzpiwO0Q0pUim5+fXvlHuOQd8SO2zWs695m/Ce9xOnwU3FW2Jl3IsWzf3vpMRSnJFo
        qMVcVJwIAB1n177nAgAA
X-CMS-MailID: 20181206013044epcas1p3df03d153eaf830ff2f35a9dab5755349
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181205110622eucas1p23d788afd54ad34c0a2663efac8734648
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110622eucas1p23d788afd54ad34c0a2663efac8734648@eucas1p2.samsung.com>
        <1544007956-28889-4-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 2018년 12월 05일 20:05, Lukasz Luba wrote:
> This patch adds implementation for global suspend/resume for
> devfreq framework. System suspend will next use these functions.
> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  6 ++++++
>  2 files changed, 50 insertions(+)

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 46517b6..0ae3de7 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -935,6 +935,50 @@ int devfreq_resume_device(struct devfreq *devfreq)
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
> +			dev_err(&devfreq->dev,
> +				"failed to suspend devfreq device\n");
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
> +			dev_warn(&devfreq->dev,
> +				 "failed to resume devfreq device\n");
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
