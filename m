Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A179C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41A62082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Avc9zmM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41A62082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLDJoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:44:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49162 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDJox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:44:53 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181204094451euoutp028a046a955d108d0ec681775e1561dd83~tGA0E5WcP1430614306euoutp02U
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 09:44:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181204094451euoutp028a046a955d108d0ec681775e1561dd83~tGA0E5WcP1430614306euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543916691;
        bh=f+WU9Gp86xU9qgTi6jNl25QiCGGFXV/6k5uQqb9i5No=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Avc9zmM6GBHcnjpNtUOITggKOu3Fabq2TadSCFmL0ZLrT5zPtFQCnp+RyjA7CpU9L
         cZSGShd0kx+cQQphHsS0d12yUtgi9o87ybPQSbCBxoZolYlRtwrvA7eucMTgDRLIe4
         qCKgcZrKUbAm+alLMCnPdrOQZdbjjrSqtjVszIJ8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181204094449eucas1p1e079a735091b9c12c7ea5f1f40ddddb9~tGAynlO_o2232222322eucas1p1B;
        Tue,  4 Dec 2018 09:44:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 61.03.04806.19C460C5; Tue,  4
        Dec 2018 09:44:49 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181204094448eucas1p2c7e2367dad1909b112b42df4de88fac5~tGAxyHJFc2425624256eucas1p2F;
        Tue,  4 Dec 2018 09:44:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181204094448eusmtrp105a67b802cb088e17d5b94b203168f22~tGAxiTLj41089810898eusmtrp1h;
        Tue,  4 Dec 2018 09:44:48 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-32-5c064c91ddfe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2B.1C.04284.09C460C5; Tue,  4
        Dec 2018 09:44:48 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181204094447eusmtip19cc51854e23421e50f2e2aa7f08d4fbe~tGAwkt-iM2933329333eusmtip1j;
        Tue,  4 Dec 2018 09:44:47 +0000 (GMT)
Subject: Re: [PATCH v2 3/5] devfreq: add devfreq_suspend/resume() functions
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
Message-ID: <bb7c2fd1-69e2-fdc6-ecb9-83ee22c2601e@partner.samsung.com>
Date:   Tue, 4 Dec 2018 10:44:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C061C74.808@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeVCMYRzHPfuepc3Tin5yzew4yoxo+OMZjMEYXsOMzDCz2MHSOznalX0r
        woxFlxy5ZR3RhmaLtLatiUTXypbkiojI2eHKPU1pezP67/P9Pd/vPN/fMw9PqU6z/vwaQ6Ro
        NOjC1awn7Sj/fWfsgXmsdvzzvKHkZm4gyUnJZkhezg+G1H57x5DU0jsM2WnJZknlbj1Jbmym
        SHX1ZY5U7WjhiPlwoYLYGh8x5H7BSZa07S1FJKX6uoJcLK3nyLnaGgV5uj2DJfW3y7ryrnsM
        iSss5Uh85meGtNx9Tk/zExxXHYyQdToLCSdMNbSwP/krEizXPigEm3UXKxSdyuKEK+nbhI5y
        TrA/TKCFfXYrEjIyf3JCm21YiHKJ55RQMXxNtGgcN3WF5+qEX7u4iPbhm5wJrAl9HZSEPHjA
        E+FTUrsiCXnyKpyB4EGnk5bFNwSVJXZOFm0Iam+UKf5FYt8f6YlcQHD2WiUli1YEX0qaOLer
        P54LL2MrkfvAF7sQFBUVs25B4TgKOj7buwTPszgI8q0b3AElngVxmc3dYRqPAEdZMuvmAVgD
        iS8yWdnjAxXHX9Nu9sCj4XBcAeVmCvtB3etUhczDYWfuie5GgJ/x8Ke1k5J7z4SCcisjc39o
        cto5mYeA69AeWmYJqhKtrMxbIaEiv8czGUqcNYy7M4UDIbtgnDyeDkm5pu4xYG943OojV/CG
        g45jlDxWQmK8SnYHgH3P3Z5HHAgXso5y+5Ha3Gsxc69lzL2WMf+/9wyirchPjJL0YaI0wSBu
        DJJ0einKEBa0ar3ehrp+ravD+T0fXW9fWYwwj9ReypQZjFbF6KKlGH0xAp5S+yqfjWK1KmWo
        LmazaFy/3BgVLkrFaDBPq/2UW/o0LFXhMF2kuE4UI0Tjv1MF7+FvQjMOOdLn+IZ4f9ycaqvr
        LGyMcnktgwhfTYvpVaRl03kTHnDr3qczrxZpBjYHlCfmVY0c/bau3xDLGzH4kmXiwktpH7Ua
        e/3t2ertW3+tLXr5RBvvH6O5P31qaN9ow8HFV/mL+V5oSu6RlvkNSw4MjbVV/GgInryg71Pb
        pPHzmDd708xNalparQseQxkl3V+QAdKVsQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec/ZuagNTtP0zQ9Z6yJFzebUvZaOCspD9iGoqMyooQe1Nmc7
        W2UFWbaGRm2Ggc3SyiRRS91M7aKVrEytlloK6UxRKNMudLNSRpsr2Lcf/J/fc4GHxkVWIpTO
        yNRx2kylSkz6Czpdbc4V5k1k8srp2gXo0e2lqK6ohkCNdT8J1Pf9HYFK7S8IlFtWQ6JnZ9TI
        NDKOI4ejlkLPT05QyFLYjCHrSC+Beu5eItG3s3aAihwtGLppd1KovK8LQ/0nKkjk7Hjs9ju7
        CWRotlPodNUXAk28HBSsCWEb7jUQbHVJNWCLc7oErNn0FbBl98cw1lqZR7IPLldTrO36cdb1
        hGLrXxsF7Ln6SsBWVE1S7DfrvM3CJEmcVqPXcfPTNbwuXrxLiiIl0lgkiYyKlUhl8t2rIqPF
        EYq4VE6VcZDTRij2StKNv/KorOmww21GMgd8nZsP/GjIRMFT7y9g+cCfFjHlAD4dLca9QTA8
        39JIeTkQTvfmk96icQCnnJ8xTxDIJMLhU8+AJwhiOgEsdHTMtMIZAw7HPl4DXuUPgPcKatw+
        TZOMBDZVHvDYQmYDNFSNz4wQMItgw2MT6eE5zA74fOwW8NbMhu0XRwUe9mPCYaHh7sx6OBMD
        S2zD/zgEvhktxbwcBnNvF+NmILL46BYfxeKjWHyUK0BQCYI4Pa9OU/NSCa9U8/rMNEmKRm0F
        7n9pePLb1gS667a0AoYG4lnConVEsohQHuSz1a0A0rg4SDiwhEwWCVOV2Uc4rWaPVq/i+FYQ
        7T6uAA+dk6Jxf1+mbo80WipHsVK5TC6LQeIQoWNldpKISVPquP0cl8Vp/3sY7ReaA+hgm1nx
        dvlCTQ+2+fCPq4OHEM6sjz8rvPFBvU3/9IzJPywhKWG9eHI4Zsm+irjEfnlBW79/2bmByeqA
        zsWtyavvuHbmWcuPBhiHp0H31hXqsWOqDblreZcpwzRg2rhwPin0G9p+nykL5x++OmIMmdrd
        bkto1g3Z60/Lgj/hio9iAZ+ulC7DtbzyL+dOnXVFAwAA
X-CMS-MailID: 20181204094448eucas1p2c7e2367dad1909b112b42df4de88fac5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203143132eucas1p128c029a7c7461e1127924a08e4a71811
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143132eucas1p128c029a7c7461e1127924a08e4a71811
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143132eucas1p128c029a7c7461e1127924a08e4a71811@eucas1p1.samsung.com>
        <1543847475-7600-4-git-send-email-l.luba@partner.samsung.com>
        <5C061C74.808@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 12/4/18 7:19 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 2018년 12월 03일 23:31, Lukasz Luba wrote:
>> This patch adds implementation for global suspend/resume for
>> devfreq framework. System suspend will next use these functions.
>>
>> The patch is based on earlier work by Tobias Jakobi.
> 
> Please remove it from each patch description.
OK
> 
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/devfreq.h   |  6 ++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 36bed24..7d60423 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -935,6 +935,48 @@ int devfreq_resume_device(struct devfreq *devfreq)
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
> 
> When I checked the cpufreq_suspend(), cpufreq_suspend() prints message as 'err' level.
> I think that dev_err is more proper than dev_warn.
> 
> I'm not sure what is more correct log.
> But, 'devfreq->dev' device has the separate suspend/resume function.
> So, I think that devfreq_suspend() should print error log containing
> that it is error by devfreq framework.
> 
> "device suspend failed"
> -> "failed to suspend devfreq device"
OK, changed in next v3 patch set.
> 
>> +	}
>> +	mutex_unlock(&devfreq_list_lock);
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
>> +	mutex_lock(&devfreq_list_lock);
>> +	list_for_each_entry(devfreq, &devfreq_list, node) {
>> +		ret = devfreq_resume_device(devfreq);
>> +		if (ret)
>> +			dev_warn(&devfreq->dev, "device resume failed\n");
> 
> ditto.
> 
> "device resume failed"
> -> "failed to resume devfreq device"
> 
ACK

Regards,
Lukasz
> 
>> +	}
>> +	mutex_unlock(&devfreq_list_lock);
>> +}
>> +
>> +/**
>>    * devfreq_add_governor() - Add devfreq governor
>>    * @governor:	the devfreq governor to be added
>>    */
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index d985199..fbffa74 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -205,6 +205,9 @@ extern void devm_devfreq_remove_device(struct device *dev,
>>   extern int devfreq_suspend_device(struct devfreq *devfreq);
>>   extern int devfreq_resume_device(struct devfreq *devfreq);
>>   
>> +extern void devfreq_suspend(void);
>> +extern void devfreq_resume(void);
>> +
>>   /**
>>    * update_devfreq() - Reevaluate the device and configure frequency
>>    * @devfreq:	the devfreq device
>> @@ -331,6 +334,9 @@ static inline int devfreq_resume_device(struct devfreq *devfreq)
>>   	return 0;
>>   }
>>   
>> +static inline void devfreq_suspend(void) {}
>> +static inline void devfreq_resume(void) {}
>> +
>>   static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>>   					   unsigned long *freq, u32 flags)
>>   {
>>
> 
