Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F380C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB6320820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SIruJWUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB6320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405464AbeKVVlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:41:03 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32893 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388010AbeKVVlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:41:03 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181122110209euoutp02a7e08258bf61b443e14b03b09a5a19d7~pbU4DyEcO2632126321euoutp02h
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 11:02:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181122110209euoutp02a7e08258bf61b443e14b03b09a5a19d7~pbU4DyEcO2632126321euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542884529;
        bh=EPt1929Fr7qXPiKIsEm8tflLNokZdq967GSrRF16F5A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SIruJWUnpelUQCOWdMGG3NJ/Os45HWs1iB/cKirpyn/Cm7/OFH41egduisZ5oXyEs
         ijQO3c8k+K+gnij4p4cV8xtdbGCvn6YS1HGwfC+I0bmrT70ScxsxP4g9O8EtPh/zF4
         6PsbFilekzXgujXZ9a9DKCzJpfoPA6LOPq9Y+Lg4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181122110207eucas1p171af3241e34e15d0894857ba93c80259~pbU24x1s02200522005eucas1p1T;
        Thu, 22 Nov 2018 11:02:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D9.D0.04441.FAC86FB5; Thu, 22
        Nov 2018 11:02:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181122110207eucas1p2e56b541c657922be36b05cbc959d2e9b~pbU2CCAxo1936619366eucas1p2N;
        Thu, 22 Nov 2018 11:02:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181122110206eusmtrp17089ef9f89bf6290f6c8ebda8c817be5~pbU1-wzwW1298912989eusmtrp1g;
        Thu, 22 Nov 2018 11:02:06 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-52-5bf68cafa682
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 59.97.04284.EAC86FB5; Thu, 22
        Nov 2018 11:02:06 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181122110206eusmtip217d39ed2a6e5bca5b7abc05d5337838d~pbU1HY_xi0438804388eusmtip2J;
        Thu, 22 Nov 2018 11:02:05 +0000 (GMT)
Subject: Re: [PATCH 4/6] devfreq: add devfreq_suspend/resume() functions
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <28eb896c-ec50-0aaf-f239-b020906fbddb@partner.samsung.com>
Date:   Thu, 22 Nov 2018 12:02:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BF61D7D.2090501@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH99x3mMXHguPozJxVMpwDR9Tk8SVGEgN3yZYYsw8DPkAHN6Cj
        4HoFpxgFUd7shLCpUKsYdIOUkkothTCgG6INY9gCE4mKGmHqUBIUwdc0ermofPudc34nz/8k
        j0BrLdxCYVvGTsmYoU/XcYGM69Jzb4TdNJXwZWVFGPmrcTlpqLCzpKlhiiVXn9xjSVXnZZbk
        n7Fz5J/DBlI6/IAmXu85nvQceMgT869tFHEMD7Ckv8XCkYmfOxGp8LZTpL5ziCe/Xe2lyPW8
        Wo4M/X3xzX53H0sOtXXypKBunCUPfTeZTaGi6w8XK9pO2ZB4IreXEctKHyPxTOv/lOiwFnOi
        +6SNF8+f3S/6L/Gi80ohIx5xWpFYW/eUFyccn2zRxAduSJHSt2VLxpUbkwLTWo/eoXfcXfqT
        ZXSSy0XPFpWgAAHwarDcv06VoEBBi2sRHGtuYtTiCYJBZx+jWFo8gWC0/91G191HtCrVIBho
        NfOqNIbAmR9bggQhGIswULxYcUJwNwK3u4NTChofosE/7uQUicOR0Gz9UdnV4BgwFXpphRkc
        BoWe20jh+fg7KLpVx6nOPOiqHJkOFIBXgOPP49NM41C4NlJFqbwY8htPTIcDPCLAq7GDjJp6
        M7iG/6VUDoZRj5NXeRF0/2KacWToKbJyKu+Fwq7mGWc9XPD0skpmGi8He8tKtR0N7b9X0Uob
        cBAMjs1TIwRBuev4TFsDRQVa1Q4Hp8k3E+AjqLEd48uQzjzrMPOsY8yzjjG/f/c0YqwoVMqS
        DamSHJUh7YqU9QY5KyM1MjnT4EBv/my33/O4GU32fd+BsIB0czThcZMJWlafLe82dCAQaF2I
        pj96KkGrSdHv3iMZMxONWemS3IE+FhhdqCbng9sJWpyq3yn9IEk7JOPbKSUELMxFS6qGTYPR
        9ZakR61rxk+3JO7zXR78b29a7+HiFeXa+JjPYnJyrP6v1z0Paty+9YLhxcsCX5qhrS6vepUx
        e2uEjvsiImdTcKlvdd6C0SR36svqk+EbpW9ro/f545zVk3ODD5R5wtb63FvWDiG8zPXVmuTM
        D232KP4bKuCoufTT2AdzbugYOU0f9TltlPWvARh3Wi2vAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsVy+t/xe7rrer5FG6z8Y2pxcKumxcYZ61kt
        tm/8xmpx/ctzVov5R86xWjQvXs9mcaY716L/8Wtmi/PnN7BbnG16w24xa8peJotNj6+xWlze
        NYfN4nPvEUaLGef3MVmsPXKX3WLp9YtMFrcbV7BZ3D11FKj/9CVWi9a9R9gt2lZ/YLV4c+Ee
        i4O4x7bd21g91sxbw+gxu+Eii8eE/k+MHov3vGTy2LSqk81j/9w17B6bl9R7/DvG7rHlajuL
        R9+WVYweK1Z/Z/f4vEkugDdKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng81srIVEnf
        ziYlNSezLLVI3y5BL2PP1EfMBc+UK+a8+srWwPhDpouRk0NCwETi5LOPzF2MXBxCAksZJV5d
        f8YEkRCTmLRvOzuELSzx51oXG0TRa0aJhesWAjkcHMICHhLXOuVB4iICpxklppw/xQTiMAu0
        Mku8fLuIEaKjgUli3/L7rCAdbAJ6EjtWFYJM5RVwk+hpP88MYrMIqEq0H3/ACGKLCkRInH25
        jhGiRlDi5MwnLCA2p4C2xKYD08FsZgEziXmbHzJD2OISt57MZ4Kw5SWat85mnsAoNAtJ+ywk
        LbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYHrZduzn5h2MlzYGH2IU4GBU
        4uHViPwaLcSaWFZcmXuIUYKDWUmE97Ljt2gh3pTEyqrUovz4otKc1OJDjKZAz01klhJNzgem
        vrySeENTQ3MLS0NzY3NjMwslcd7zBpVRQgLpiSWp2ampBalFMH1MHJxSDYyO61Jf7Hv6yXG3
        QrLmp/67VVHOU56syhXlL/dO0+jzzLi92+BMmtfTvZ0iJlOZQssfSC/U84id6+srttzyR1L4
        +mdBHL7vAto+GIjMXsv337F5b/OKo0xR+5MtJm/adXupQFbr8ri4zUsTrj24eOXh11nCqV1S
        T5hjEkvLlrW9tNwgML/49j8lluKMREMt5qLiRAAIN4IKRQMAAA==
X-CMS-MailID: 20181122110207eucas1p2e56b541c657922be36b05cbc959d2e9b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180205eucas1p1dc52369476400cd07058d232bd8dbcd7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180205eucas1p1dc52369476400cd07058d232bd8dbcd7
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180205eucas1p1dc52369476400cd07058d232bd8dbcd7@eucas1p1.samsung.com>
        <1542823301-23563-5-git-send-email-l.luba@partner.samsung.com>
        <5BF61D7D.2090501@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/18 4:07 AM, Chanwoo Choi wrote:
> Hi,
> 
> On 2018년 11월 22일 03:01, Lukasz Luba wrote:
>> This patch adds implementation for global suspend/resume for
>> devfreq framework. System suspend will next use these functions.
>>
>> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>> solve issue with devfreq device's frequency during suspend/resume.
>> During the discussion on LKML some corner cases and comments appeared
>> related to the design. This patch address them keeping in mind suggestions
>> from Chanwoo Choi.
> 
> Please remove the duplicate information about patch history.
> 
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/devfreq.h   |  7 +++++++
>>   2 files changed, 56 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 7e09de8..2f4391c 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -44,6 +44,9 @@ static LIST_HEAD(devfreq_governor_list);
>>   static LIST_HEAD(devfreq_list);
>>   static DEFINE_MUTEX(devfreq_list_lock);
>>   
>> +/* Flag showing state of suspend/resume */
>> +static bool devfreq_suspended;
> 
> Is it necessary? This patch just saves the 'true' or 'false' to this variable.
> And there are no any point to check the value of this variable.
> Please remove it.
> 
>> +
>>   /**
>>    * find_device_devfreq() - find devfreq struct using device pointer
>>    * @dev:	device pointer used to lookup device devfreq.
>> @@ -938,6 +941,52 @@ int devfreq_resume_device(struct devfreq *devfreq)
>>   EXPORT_SYMBOL(devfreq_resume_device);
>>   
>>   /**
>> + * devfreq_suspend() - Suspend devfreq governors and devices
>> + *
>> + * Called during system wide Suspend/Hibernate cycles for suspending governors
>> + * and devices preserving the state for resume. On some platforms the devfreq
>> + * device must have precise state (frequency) after resume in order to provide
>> + * fully operating setup.
>> + */
>> +void devfreq_suspend(void)
>> +{
>> +	struct devfreq *devfreq;
>> +	int ret;
>> +
>> +	mutex_lock(&devfreq_list_lock);
>> +	list_for_each_entry(devfreq, &devfreq_list, node) {
>> +		ret = devfreq_suspend_device(devfreq);
>> +		if (ret)
>> +			dev_warn(&devfreq->dev, "device suspend failed\n");
>> +	}
>> +	mutex_unlock(&devfreq_list_lock);
>> +
>> +	devfreq_suspended = true;
> 
> Remove it.
> 
>> +}
>> +
>> +/**
>> + * devfreq_resume() - Resume devfreq governors and devices
>> + *
>> + * Called during system wide Suspend/Hibernate cycle for resuming governors and
>> + * devices that are suspended with devfreq_suspend().
>> + */
>> +void devfreq_resume(void)
>> +{
>> +	struct devfreq *devfreq;
>> +	int ret;
>> +
>> +	devfreq_suspended = false;
> 
> Remove it.
> 
>> +
>> +	mutex_lock(&devfreq_list_lock);
>> +	list_for_each_entry(devfreq, &devfreq_list, node) {
>> +		ret = devfreq_resume_device(devfreq);
>> +		if (ret)
>> +			dev_warn(&devfreq->dev, "device resume failed\n");
>> +	}
>> +	mutex_unlock(&devfreq_list_lock);
>> +}
>> +
>> +/**
>>    * devfreq_add_governor() - Add devfreq governor
>>    * @governor:	the devfreq governor to be added
>>    */
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index 7fe96f9..4f0fea8 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -202,6 +202,10 @@ extern void devm_devfreq_remove_device(struct device *dev,
>>   extern int devfreq_suspend_device(struct devfreq *devfreq);
>>   extern int devfreq_resume_device(struct devfreq *devfreq);
>>   
>> +
> 
> Remove the blank line.
> 
>> +extern void devfreq_suspend(void);
>> +extern void devfreq_resume(void);
>> +
>>   /**
>>    * update_devfreq() - Reevaluate the device and configure frequency
>>    * @devfreq:	the devfreq device
>> @@ -396,6 +400,9 @@ static inline int devfreq_update_stats(struct devfreq *df)
>>   {
>>   	return -EINVAL;
>>   }
>> +
>> +static inline void devfreq_suspend(void) {}
>> +static inline void devfreq_resume(void) {}
> 
> You better to move the inline definitions
> under 'devfreq_resume_device' inline function.
OK, I will move it there.
> 
>>   #endif /* CONFIG_PM_DEVFREQ */
>>   
>>   #endif /* __LINUX_DEVFREQ_H__ */
>>
> 
>

Regards,
Lukasz Luba
