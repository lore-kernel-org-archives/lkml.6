Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7BDC6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDEB2456A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XuV0otq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDEB2456A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeGDCvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:51:39 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:59793 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752717AbeGDCvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:51:36 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180704025134epoutp01231a64dc23982056089b56d4af1622ee~_CrSWhW6n0088800888epoutp01h;
        Wed,  4 Jul 2018 02:51:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180704025134epoutp01231a64dc23982056089b56d4af1622ee~_CrSWhW6n0088800888epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530672694;
        bh=qTE0ZQiLMNj5uAITiqnDTRuKrnWIXtkC8JhTHMQzjQQ=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=XuV0otq6pWG2uel+BF0iOYETz/tMtT1xUqDyZJqCHclbAZCyUhPOfe+Os0BmQ5WhB
         mAm4+P2PBgPQtW5ZCTs3V+jwFN+z80TOYt8Wd8fezRXhYPom5mITqPf2XtrBD0/hBD
         /kIALHY9mPEBK+4FRTPEtCLpXsY3uTob8HKZDkSE=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.152]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180704025131epcas1p1e3606f5d338cdb4eb45d883a1bd6f17a~_CrP5CXrr1967919679epcas1p1N;
        Wed,  4 Jul 2018 02:51:31 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.65.04187.3363C3B5; Wed,  4 Jul 2018 11:51:31 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20180704025131epcas2p40e706eb0d300e5ca609cada8ab781291~_CrPfDNxQ0869408694epcas2p4r;
        Wed,  4 Jul 2018 02:51:31 +0000 (GMT)
X-AuditID: b6c32a46-c67ff7000000105b-26-5b3c3633021d
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 39.C1.04192.2363C3B5; Wed,  4 Jul
        2018 11:51:30 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PBB00FGUMLUED50@mmp2.samsung.com>; Wed, 04 Jul 2018 11:51:30 +0900 (KST)
Message-id: <5B3C3632.1010706@samsung.com>
Date:   Wed, 04 Jul 2018 11:51:30 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v5 04/12] PM / devfreq: Add struct devfreq_policy
In-reply-to: <20180703234705.227473-5-mka@chromium.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHc/t+onZcq+i1ZqO+RDObFfvD2stWNhOdeWRoMDXGWCc+4QWI
        tCV9LRkmLgXdhCYuIFlcQEAGW7DpVoqdY6Ihg04rUzZEy1bGFuMwTl1QEHUSs7V9MfOve+45
        n3Nyvt/cyxKqKK1my50e0e0UKjh6AXl2aK1FZ9pgtetP383Cz49fZPCJP8dI3PtwmsLt0REK
        X/3yexoHJwYBPtwZovHV2vsM/mPuB4DHzp2k8eyxKMBfjI8q8GzPLYAnarppPDw+S+MrP16j
        8EcXogwOz/EbVXywLQj4+WfHAd/iGyX5vskuwPcG6mn+t/h5mh9oDTL89VgtxUduHCX5TyIB
        wM/2vla4cLdoLROFEtGtEZ3FrpJyZ2ke956taFOReYPeoDPkYguncQoOMY/bXFCo21JekZTG
        aaqECm8yVShIErfubavb5fWImjKX5Mnj7AaDMcegt+QYjcnT9P6bRnMS2SeW+WoaicqQ9oOv
        Yw+BDyRW+UEGi+B6FPb/TPvBAlYF+wCKT/ZQqYIKPgEocb/gBfT36BQhQz0AHRvqAqmCEi5G
        T5t+J/2AZQmYjaLXDqTSBFyLvukPMTI/CdD4TCct81p0s9+X7iXhatTmmyZSMZ3MD9z5Jc1k
        wlXoxtNbaSYL7kLftT9mUvFSaEOn/vmJTA0l4D0SdRyZT2+6BL6LWp61p5szoAWd7pxOy0Fw
        hEH3Pj1BpbZDcDMaeLxHVrME3b0UYeR4JbodCAOZPwrQozuHKfnSANCD4TMKmTKh2x1+hazt
        FVQ39JyRhypR3ccqGeHRzfgFSpb8LUCRR+cVDeDV5pdcav7fpeaXXDoFiABYJlZKjlJRMlYa
        cyTBIXmdpTnFLkcvSL9g7ZY+0DVSMAggC7hFym7vW3YVJVRJ1Y5BgFiCW6qsX2e1q5QlQvVB
        0e0qcnsrRGkQmJMmNxLqrGJX8j84PUUGs9FkMmGzJdekz+WWK8Gv0K6CpYJHPCCKlaL7RZ+C
        zVD7QLd25sP8fxWt1P4dmZdtLl1stOYB1Khb8yf6N86H92bu7D/r3/VG9iXrppnPWsT4lD54
        3Wd7fQeOJJZl5YcaAn/FDnLevVvpbeEm9Tu2rvpg577dW2Nr0Jory/fvXNhGWKobD9V1ZFeN
        rE8Mz31+Mq74KjQWOeOp7bHqEttXNE1xpFQmGLSEWxL+Aw06OI7XAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsVy+t9jQV0jM5tog9tbLS3+TjrGbjH9yWUW
        i00f37NazD9yjtXi7LKDbBZrbh9itGhevJ7N4mzTG3aL+1+PMlpc3jWHzeJz7xFGi6XXLzJZ
        fN7wmNHiduMKNotT1z+zWZw5fYnVonXvEXaLjV89HIQ81sxbw+jx+9ckRo/ZDRdZPHbcXcLo
        sWlVJ5vHnWt72Dz2z13D7nHlRBOrx5ar7SwefVtWMXp83iQXwB3FZZOSmpNZllqkb5fAldHQ
        OJG5YL1WxboTHxkbGG8pdjFyckgImEi8vfiUGcQWEljHKPF/ji2IzSsgKPFj8j2WLkYODmYB
        eYkjl7JBwswC6hKT5i0CKucCKr/PKHF+wT42iHotiYe7GxhBbBYBVYl5De/BZrIBxfe/uAFW
        wy+gKHH1x2NGkJmiAhES3ScqQcIiAsESH5p72EBmMgu8ZZFY+u0/2BxhAVeJ2b/ms0Es284o
        savvOAtIglPAXGLl4vdsExgFZiG5dRbCrbOQ3LqAkXkVo2RqQXFuem6xUYFRXmq5XnFibnFp
        Xrpecn7uJkZgTG47rNW/g/HxkvhDjAIcjEo8vCtKraOFWBPLiitzDzFKcDArifB26ttEC/Gm
        JFZWpRblxxeV5qQWH2KU5mBREuflzz8WKSSQnliSmp2aWpBaBJNl4uCUamCcbm2dvM4pv1Og
        0qHF0r8h4HlFdOclFY5My/Ovz+ydHMzG+/7hPU6lX3kfnnV0xpx5ybWbc8OiOZY8X7uOWHrG
        XAtuTZKc9/jnaZu5O46JC5mmfu+usb/lveRCgK3n7CfatRNvKptu7fO5K1Rw0sT4/wdftT9i
        uYneJ5fx7ftkekLGY3ZF5kUlluKMREMt5qLiRABWYWWtxQIAAA==
X-CMS-MailID: 20180704025131epcas2p40e706eb0d300e5ca609cada8ab781291
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180703235030epcas4p423e7bf876628913adb3e41ffdc8ba3cd
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703235030epcas4p423e7bf876628913adb3e41ffdc8ba3cd@epcas4p4.samsung.com>
        <20180703234705.227473-5-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
> Move variables related with devfreq policy changes from struct devfreq
> to the new struct devfreq_policy and add a policy field to struct devfreq.
> 
> The following variables are moved:
> 
> df->min/max_freq           =>   p->user.min/max_freq
> df->scaling_min/max_freq   =>   p->devinfo.min/max_freq
> df->governor               =>   p->governor
> df->governor_name          =>   p->governor_name
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> ---
> Changes in v5:
> - none
> 
> Changes in v4:
> - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - performance, powersave and simpleondemand governors don't need changes
>   with "PM / devfreq: Don't adjust to user limits in governors"
> - formatting fixes
> ---
>  drivers/devfreq/devfreq.c          | 137 ++++++++++++++++-------------
>  drivers/devfreq/governor_passive.c |   4 +-
>  include/linux/devfreq.h            |  38 +++++---
>  3 files changed, 103 insertions(+), 76 deletions(-)
> 

(skip)

>  
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 3bc29acbd54e..e0987c749ec2 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -99,12 +99,12 @@ static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
>  {
>  	int ret;
>  
> -	if (!devfreq->governor)
> +	if (!devfreq->policy.governor)
>  		return -EINVAL;
>  
>  	mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
>  
> -	ret = devfreq->governor->get_target_freq(devfreq, &freq);
> +	ret = devfreq->policy.governor->get_target_freq(devfreq, &freq);
>  	if (ret < 0)
>  		goto out;
>  
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 3aae5b3af87c..9bf23b976f4d 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -109,6 +109,30 @@ struct devfreq_dev_profile {
>  	unsigned int max_state;
>  };
>  
> +/**
> + * struct devfreq_freq_limits - Devfreq frequency limits
> + * @min_freq:	minimum frequency
> + * @max_freq:	maximum frequency
> + */
> +struct devfreq_freq_limits {
> +	unsigned long min_freq;
> +	unsigned long max_freq;
> +};
> +
> +/**
> + * struct devfreq_policy - Devfreq policy
> + * @user:	frequency limits requested by the user
> + * @devinfo:	frequency limits of the device (available OPPs)
> + * @governor:	method how to choose frequency based on the usage.

nitpick. remove '.' on the end of line.

> + * @governor_name:	devfreq governor name for use with this devfreq
> + */
> +struct devfreq_policy {
> +	struct devfreq_freq_limits user;
> +	struct devfreq_freq_limits devinfo;
> +	const struct devfreq_governor *governor;
> +	char governor_name[DEVFREQ_NAME_LEN];
> +};
> +
>  /**
>   * struct devfreq - Device devfreq structure
>   * @node:	list node - contains the devices with devfreq that have been
> @@ -117,8 +141,6 @@ struct devfreq_dev_profile {
>   * @dev:	device registered by devfreq class. dev.parent is the device
>   *		using devfreq.
>   * @profile:	device-specific devfreq profile
> - * @governor:	method how to choose frequency based on the usage.
> - * @governor_name:	devfreq governor name for use with this devfreq
>   * @nb:		notifier block used to notify devfreq object that it should
>   *		reevaluate operable frequencies. Devfreq users may use
>   *		devfreq.nb to the corresponding register notifier call chain.
> @@ -126,10 +148,7 @@ struct devfreq_dev_profile {
>   * @previous_freq:	previously configured frequency value.
>   * @data:	Private data of the governor. The devfreq framework does not
>   *		touch this.
> - * @min_freq:	Limit minimum frequency requested by user (0: none)
> - * @max_freq:	Limit maximum frequency requested by user (0: none)
> - * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
> - * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
> + * @policy:		Policy for frequency adjustments

The devfreq_policy contains the range of frequency and governor information.
But, this description focus on the frequency. You need to explain the more
correct description of 'policy'.

>   * @stop_polling:	 devfreq polling status of a device.
>   * @total_trans:	Number of devfreq transitions
>   * @trans_table:	Statistics of devfreq transitions
> @@ -151,8 +170,6 @@ struct devfreq {
>  	struct mutex lock;
>  	struct device dev;
>  	struct devfreq_dev_profile *profile;
> -	const struct devfreq_governor *governor;
> -	char governor_name[DEVFREQ_NAME_LEN];
>  	struct notifier_block nb;
>  	struct delayed_work work;
>  
> @@ -161,10 +178,7 @@ struct devfreq {
>  
>  	void *data; /* private data for governors */
>  
> -	unsigned long min_freq;
> -	unsigned long max_freq;
> -	unsigned long scaling_min_freq;
> -	unsigned long scaling_max_freq;
> +	struct devfreq_policy policy;

I recommend that you better to move under 'struct devfreq_dev_profile'
as following:
	
	struct devfreq_dev_profile *profile;
	struct devfreq_policy policy;


>  	bool stop_polling;
>  
>  	/* information for device frequency transition */
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
