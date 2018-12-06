Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD1AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F37020700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fmOXN1gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F37020700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeLFKOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:14:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45687 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeLFKOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:14:06 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181206101404euoutp0173b7c28b0aaf5756155e3078e0617231~tts4z1sX72139721397euoutp01s
        for <linux-kernel@vger.kernel.org>; Thu,  6 Dec 2018 10:14:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181206101404euoutp0173b7c28b0aaf5756155e3078e0617231~tts4z1sX72139721397euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544091244;
        bh=gDn7TD04dfrUWr7r68wrUglhw8bAV6f70NFJLMZJOtk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fmOXN1gmC+DlavKtIj37k+lYXXAWqerbUhsVRRr3uy7fcc75eOhTu+bA3sPbflMJr
         OVzK2Wf43gLV8YFyp+gIceNiRSZR6Y1wTPqjDvM9OxKI2j3fifEFSlUu8B2Q3sjD0M
         4gdKzRDwdNFQYEKc8jv+is3IsHH8st0Rj4FtVFl4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181206101402eucas1p24de68039176e82a2e034307edd303194~tts3KkZde0900609006eucas1p2i;
        Thu,  6 Dec 2018 10:14:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.3B.04806.966F80C5; Thu,  6
        Dec 2018 10:14:01 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181206101401eucas1p23036ae977a70e7e67da3d46e6be936f6~tts2WMxkq0901009010eucas1p2Z;
        Thu,  6 Dec 2018 10:14:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181206101401eusmtrp20f7591a94c0298126d535f62bf016d84~tts2FwtYL1261312613eusmtrp2G;
        Thu,  6 Dec 2018 10:14:01 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-7d-5c08f669627a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D2.24.04284.866F80C5; Thu,  6
        Dec 2018 10:14:01 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181206101400eusmtip16ea28fca08ee0c09048f5fc2f21c40c1~tts1HyiDN1346513465eusmtip1i;
        Thu,  6 Dec 2018 10:14:00 +0000 (GMT)
Subject: Re: [PATCH v3 2/5] devfreq: add support for suspend/resume of a
 devfreq device
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
Message-ID: <d64d50db-375d-5fd5-5938-dcd0341ef2d7@partner.samsung.com>
Date:   Thu, 6 Dec 2018 11:13:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C0878C0.4060500@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0yTZxj17XeFWPJamH1gm8bORNGsuAzNqxijkejn5ceWLIiORbr5BZkU
        WT9AURPrEAt4I8QoFIYaXcBSh3YFK+OiFQREKTgmzCsGjPeAAkWitvPjY5F/5znPOXnOefPy
        lKaEDeMTk1NFU7IhSccG0lVXRz1fJnr5uHmXeheRy5Xh5HxBBUMunPcypGvoMUOON7QxJPNU
        BUuu7zeSw73PKeLxnOPIjV9fcMR6pFZFHL23GPJ3dTFLBg82IFLgqVORsw33OPJ7V4eK3NlT
        xpJ71xo/+FtvMiSrtoEj+8oHGPKi/T69VCtU/VXFCPYSOxKKzB20kHf4NRJO1TxVCQ5bDivU
        /2bnhD9P7xZ8VznB+Y+FFg45bUgoKx/hhEHHtG/UGwIXbxKTEtNFU8SS+MDNnS0jKGV45va2
        4n7KjBo/z0U8DzgSCka/zUWBvAaXIdh79hqjDEMIutv7KWUYRFDtqEG5KGDMceFgj0pZlCIY
        eGOnleElAl9JASergvF68LWZkbwIwa0I6uvdrDxQOIsC34CTla+zWA8u2y+yQY1XwMnLbxgZ
        03gmeIfaxvAnOBayH5SzimYKtBT20TIOwHMh339mjKewFm73HVcpeDpkVhaN5QbczYP5USan
        5I4G/x9FtIKD4VmTc5z/DPwXFTNgCW5k21gF7wJLi2tcEwVXmjoYOTOFw6GiOkKhl0HjI7m9
        /JBB0P1yihIhCPKrjlEKrYbsfRpFPRucB9rHD02FUvtRLg/prBOKWSeUsU4oY/149wSibUgr
        pknGBFH6OlncppcMRiktOUH/01ajA334ta2+pmEXqnv3oxthHukmq5/0cHEaxpAuZRjdCHhK
        F6KepOfjNOpNhowdomnrRlNakii50ac8rdOqd07q+V6DEwyp4hZRTBFN/29VfECYGc0vO93n
        nINjpmtTou/Gh8zIWbFnx8Int1c11/I/vLUsWH0xvdKV4wnKiBn9WV8bEXNljcv7MOFmRYl/
        eejRZ1H+VyP5Wb6hzLW3tlv8xc3elZbS1ZFd5uX3w4ZjN3oLdf1fuK/nRXGX5oYunPfvd1ND
        m8/N6lz3Pj62ODU63GJapt8SrKOlzYav5lAmyfAf2tUVALEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe8/dcHCali+CXYYVFh2d11czyS91iIIuFGZ2GXpSyznb2USN
        aCUWGuUFC5va3dBpmdOmZCqKF9TatIvSRTGMSmZkXmaKWJsj8NsP/s/v4Xngz+DSWtKTSUzW
        COpkRZKMWkn0LnYNbUu0MTF+34Yw1PrcB9UUVZOovsZGosHp7yS6224mUebDagq9uqZEuaNW
        HFksz2j0+vI4jfSFTRgyjg6Q6O2LEgpNXW8HqMjSjKEn7UM0Khvsx9CnS+UUGurpsPu9b0iU
        1dROoyuVEyQa7xsmdnrwpkYTyVfdqQJ8sa6f4PNyJwH/8OUYxhsN2RTfUlpF87WPLvKLnTRf
        9/4qwd+oMwC+vHKW5qeMa/dLorlwtUqrEdYnqETNDtkxOfLn5KGI8w8M5eQBIcfD/INkvhHh
        cUJSYqqg9o04xSW8654FKTPeaeaSX7gOdHjlABcGsoGw/voIlgNWMlK2DEBr/gfKGayBBc31
        tJPd4MJADuUcsgLYXGcDjsCNPQoXzTrgCNzZXgALLT1Lq3A2C4djPx8Ap6LD4LhVZ/cZhmI5
        2GA457Al7C54v/UP6WCC9Ya2afMSr2aj4Ouxp8A5swp23/5KONiF3QoL/lYsnYezwfBO7Rfc
        yR7w49e7mJPXwcznxXgekOqX6fplin6Zol+m3AOEAbgLWlEZrxTlnKhQitrkeC5WpTQCe2FM
        nXO1DeBNzaE2wDJA5ir5MULHSElFqpiubAOQwWXukhUcEyOVxCnSMwS16qRamySIbSDI/lw+
        7rk6VmWvX7LmpDxIHoJC5SEBIQHBSOYhsfilR0vZeIVGOCsIKYL6v4cxLp464Fbvne31rXn4
        oGTTdIY+JmhDt3FbsGpuXVd+VFjeJHeiqfSKJtMncWb3nqyNe+fnFyYrRsNsCvcqbeXwSORs
        3xkz+BB5euLlmbSWnsabhvOdeKYkC7/Auzb6fe4L3odNeA/Kug5gmxnqyA04+jj2HTFdfKs6
        5WA/qZkw/X56eLuMEBMU8i24WlT8A56HZA5GAwAA
X-CMS-MailID: 20181206101401eucas1p23036ae977a70e7e67da3d46e6be936f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110620eucas1p14de70dc092580b684a0304b5ce771605@eucas1p1.samsung.com>
        <1544007956-28889-3-git-send-email-l.luba@partner.samsung.com>
        <5C0878C0.4060500@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 12/6/18 2:17 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 2018년 12월 05일 20:05, Lukasz Luba wrote:
>> The patch prepares devfreq device for handling suspend/resume
>> functionality. The new fields will store needed information during this
>> process. Devfreq framework handles opp-suspend DT entry and there is no
>> need of modyfications in the drivers code. It uses atomic variables to
>> make sure no race condition affects the process.
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 47 +++++++++++++++++++++++++++++++++++++++++------
>>   include/linux/devfreq.h   |  7 +++++++
>>   2 files changed, 48 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Thank you for the review and comments for the whole patch series.

Regards,
Lukasz

> 
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index a9fd61b..46517b6 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -316,6 +316,10 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>>   			"Couldn't update frequency transition information.\n");
>>   
>>   	devfreq->previous_freq = new_freq;
>> +
>> +	if (devfreq->suspend_freq)
>> +		devfreq->resume_freq = cur_freq;
>> +
>>   	return err;
>>   }
>>   
>> @@ -667,6 +671,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>   	}
>>   	devfreq->max_freq = devfreq->scaling_max_freq;
>>   
>> +	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>> +	atomic_set(&devfreq->suspend_count, 0);
>> +
>>   	dev_set_name(&devfreq->dev, "devfreq%d",
>>   				atomic_inc_return(&devfreq_no));
>>   	err = device_register(&devfreq->dev);
>> @@ -867,14 +874,28 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>    */
>>   int devfreq_suspend_device(struct devfreq *devfreq)
>>   {
>> +	int ret;
>> +
>>   	if (!devfreq)
>>   		return -EINVAL;
>>   
>> -	if (!devfreq->governor)
>> +	if (atomic_inc_return(&devfreq->suspend_count) > 1)
>>   		return 0;
>>   
>> -	return devfreq->governor->event_handler(devfreq,
>> -				DEVFREQ_GOV_SUSPEND, NULL);
>> +	if (devfreq->governor) {
>> +		ret = devfreq->governor->event_handler(devfreq,
>> +					DEVFREQ_GOV_SUSPEND, NULL);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (devfreq->suspend_freq) {
>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>>   }
>>   EXPORT_SYMBOL(devfreq_suspend_device);
>>   
>> @@ -888,14 +909,28 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>    */
>>   int devfreq_resume_device(struct devfreq *devfreq)
>>   {
>> +	int ret;
>> +
>>   	if (!devfreq)
>>   		return -EINVAL;
>>   
>> -	if (!devfreq->governor)
>> +	if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>>   		return 0;
>>   
>> -	return devfreq->governor->event_handler(devfreq,
>> -				DEVFREQ_GOV_RESUME, NULL);
>> +	if (devfreq->resume_freq) {
>> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (devfreq->governor) {
>> +		ret = devfreq->governor->event_handler(devfreq,
>> +					DEVFREQ_GOV_RESUME, NULL);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>>   }
>>   EXPORT_SYMBOL(devfreq_resume_device);
>>   
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index e4963b0..d985199 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -131,6 +131,9 @@ struct devfreq_dev_profile {
>>    * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>    * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>    * @stop_polling:	 devfreq polling status of a device.
>> + * @suspend_freq:	 frequency of a device set during suspend phase.
>> + * @resume_freq:	 frequency of a device set in resume phase.
>> + * @suspend_count:	 suspend requests counter for a device.
>>    * @total_trans:	Number of devfreq transitions
>>    * @trans_table:	Statistics of devfreq transitions
>>    * @time_in_state:	Statistics of devfreq states
>> @@ -167,6 +170,10 @@ struct devfreq {
>>   	unsigned long scaling_max_freq;
>>   	bool stop_polling;
>>   
>> +	unsigned long suspend_freq;
>> +	unsigned long resume_freq;
>> +	atomic_t suspend_count;
>> +
>>   	/* information for device frequency transition */
>>   	unsigned int total_trans;
>>   	unsigned int *trans_table;
>>
> 
> 
