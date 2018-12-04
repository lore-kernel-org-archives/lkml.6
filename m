Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A77FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B990208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ONPukvUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B990208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLDFnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:43:50 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:47249 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeLDFnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:43:50 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181204054345epoutp03734f363606dc8dc81e986c8e82c842f8~tCuT7H9M53159231592epoutp03d;
        Tue,  4 Dec 2018 05:43:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181204054345epoutp03734f363606dc8dc81e986c8e82c842f8~tCuT7H9M53159231592epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543902225;
        bh=4oGW7XwCNxm94z+693eCu9Dv4VowqODy06ccceThHwc=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=ONPukvUkzNMngBdBy3vhrxWF+y0a9PG32P2DbAFgqCOSJwvDit+bq6fzqgIqMK0Wg
         PhKUUQhdYho0YJdus724sLz0/c+0fN88BzMOfll1a8MfXDVrsFz9GT2H/hYw3uIVKA
         E3QxPWn7rYJ/WtM058bC26cRPtKTHTepc7nkFB04=
Received: from epsmges2p4.samsung.com (unknown [182.195.40.153]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181204054343epcas1p41774334bea7be7ee7f19dd3773db0232~tCuRXEMzi1872718727epcas1p4X;
        Tue,  4 Dec 2018 05:43:43 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.59.04055.E04160C5; Tue,  4 Dec 2018 14:43:43 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181204054342epcas2p1218e8b20b845499ef6a3aa4d930555c0~tCuQ-kB780880308803epcas2p1a;
        Tue,  4 Dec 2018 05:43:42 +0000 (GMT)
X-AuditID: b6c32a48-3a9ff70000000fd7-cc-5c06140e3379
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.71.03627.E04160C5; Tue,  4 Dec 2018 14:43:42 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJ700AWX6KTGF40@mmp1.samsung.com>; Tue, 04 Dec 2018 14:43:42 +0900 (KST)
Message-id: <5C06140E.7010603@samsung.com>
Date:   Tue, 04 Dec 2018 14:43:42 +0900
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
In-reply-to: <5C06124B.5030409@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJsWRmVeSWpSXmKPExsWy7bCmuS6/CFuMQeNWRouDWzUtNs5Yz2qx
        feM3Vov5R86xWjQvXs9mcaY716L/8Wtmi/PnN7BbnG16w25xq0HGYtaUvUwWmx5fY7W4vGsO
        m8Xn3iOMFjPO72OyWHvkLrvF0usXmSxuN65gs7h76ijQjNOXWC1a9x5ht2hb/YHV4s2FeywO
        4h7bdm9j9Vgzbw2jx+yGiyweE/o/MXos3vOSyWPTqk42j/1z17B7bF5S7/HvGLvHwXd7mDy2
        XG1n8ejbsorRY8Xq7+wenzfJBfBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqY
        KynkJeam2iq5+AToumXmAL2vpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNAr
        TswtLs1L10vOz7UyNDAwMgUqTMjOeDl7KntBr0bFt5NsDYxTFboYOTkkBEwkXk1aytLFyMUh
        JLCDUWLJ9ElsIAkhge+MEv2LKmCKGva9Y4Yo2s0o0Xr+NDtIgldAUOLH5HtA3RwczALyEkcu
        ZYOEmQU0JV58mQQ19C6jxM1l+9gg6rUk/nXuZwaxWQRUJQ68vwwWZwOK739xA8zmF1CUuPrj
        MSOILSoQIbFz/jd2kEEiAucZJdbs3MME4jALtDJL/PuwBaxDWCBS4tTip2BTOQW0JX4cXQx2
        qoTAT3aJ1a+vMUH84CKxcf5FdghbWOLV8S1QtrTEs1UbGSEa2hklvrxoZoVwJjBKfDi1Garb
        WOLZwi4miO/4JDoO/2UHeVpCgFeio00IosRDoq9nHTvE0/8YJV5/3ME8gVF2FlI4zUKE0yyk
        cFrAyLyKUSy1oDg3PbXYqMAEOf42MYITu5bHDsYD53wOMQpwMCrx8Do4sMYIsSaWFVfmHmKU
        4GBWEuEtKGSJEeJNSaysSi3Kjy8qzUktPsRoCgzmicxSosn5wKyTVxJvaGpkbGxsYWpuaWxg
        qSTO+1B6brSQQHpiSWp2ampBahFMHxMHp1QDY45PYv31dedK/aptlF+Gb964UDJ5RXd7k/M1
        nZMz6i8yqT+6IJngXnFy1fsaz1PXdn34aG3rtaY6Zf2XRN+/DUcXPXCV2K5d9st+74x07sXn
        Jr/9X9a8T4b9woTW1DnmRXWyKVtMzvXPfWTkMH9v/78TP//L8z3++vBa6W4PZeeVvYdOPlgf
        9kWJpTgj0VCLuag4EQBkjdewAgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t9jAV0+EbYYgy9HlCwObtW02DhjPavF
        9o3fWC3mHznHatG8eD2bxZnuXIv+x6+ZLc6f38BucbbpDbvFrQYZi1lT9jJZbHp8jdXi8q45
        bBafe48wWsw4v4/JYu2Ru+wWS69fZLK43biCzeLuqaNAM05fYrVo3XuE3aJt9QdWizcX7rE4
        iHts272N1WPNvDWMHrMbLrJ4TOj/xOixeM9LJo9NqzrZPPbPXcPusXlJvce/Y+weB9/tYfLY
        crWdxaNvyypGjxWrv7N7fN4kF8AXxWWTkpqTWZZapG+XwJXxcvZU9oJejYpvJ9kaGKcqdDFy
        ckgImEg07HvH3MXIxSEksJNRovfcelaQBK+AoMSPyfdYuhg5OJgF5CWOXMqGMNUlpkzJhSi/
        zyjx59dqRohyLYl/nfuZQWwWAVWJA+8vs4HYbEDx/S9ugNn8AooSV388ZgSZIyoQIdF9ohJk
        jojAeUaJg32dYGuZBVqZJR61ZYHYwgKREqcWP4W67R+jxNlt7WALOAW0JX4cXcw8gVFgFpJT
        ZyGcOgvh1AWMzKsYJVMLinPTc4uNCozyUsv1ihNzi0vz0vWS83M3MQLjetthrf4djI+XxB9i
        FOBgVOLhdXBgjRFiTSwrrsw9xCjBwawkwltQyBIjxJuSWFmVWpQfX1Sak1p8iFGag0VJnJc/
        /1ikkEB6YklqdmpqQWoRTJaJg1OqgdHzkCbPhYmaut55mVFvjYo4tW7wZfr8KVK4MHHhl9ZC
        hZ1FmqucJgbmvfjs3OIuEFn++8zzBZtSV2+1tLCz5hKU73niUnjO4ETkai0LM/UQprwD71+Z
        n+yQSklMttmdX5WjzLnwcbbQU0313KBday5u92rjvH1mgoSUx/63vxJf6qRZ/nt1QYmlOCPR
        UIu5qDgRAEKpdrbnAgAA
X-CMS-MailID: 20181204054342epcas2p1218e8b20b845499ef6a3aa4d930555c0
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
        <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
        <5C06124B.5030409@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 12월 04일 14:36, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> Looks good to me. But, I add the some comments.
> If you will fix it, feel free to add my tag:
> Reviewed-by: Chanwoo choi <cw00.choi@samsung.com>

Sorry. Fix typo 'choi' to 'Choi' as following.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
> On 2018년 12월 03일 23:31, Lukasz Luba wrote:
>> The patch prepares devfreq device for handling suspend/resume
>> functionality.  The new fields will store needed information during this
> 
> nitpick. Remove unneeded space. There are two spaces between '.' and 'The new'. 
> 
>> process.  Devfreq framework handles opp-suspend DT entry and there is no
> 
> ditto.
> 
>> need of modyfications in the drivers code.  It uses atomic variables to
> 
> ditto.
> 
>> make sure no race condition affects the process.
>>
>> The patch is based on earlier work by Tobias Jakobi.
> 
> Please remove it from each patch description.
> 
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 51 +++++++++++++++++++++++++++++++++++++++--------
>>  include/linux/devfreq.h   |  7 +++++++
>>  2 files changed, 50 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index a9fd61b..36bed24 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -316,6 +316,10 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>>  			"Couldn't update frequency transition information.\n");
>>  
>>  	devfreq->previous_freq = new_freq;
>> +
>> +	if (devfreq->suspend_freq)
>> +		devfreq->resume_freq = cur_freq;
>> +
>>  	return err;
>>  }
>>  
>> @@ -667,6 +671,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>  	}
>>  	devfreq->max_freq = devfreq->scaling_max_freq;
>>  
>> +	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
>> +	atomic_set(&devfreq->suspend_count, 0);
>> +
>>  	dev_set_name(&devfreq->dev, "devfreq%d",
>>  				atomic_inc_return(&devfreq_no));
>>  	err = device_register(&devfreq->dev);
>> @@ -867,14 +874,28 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>   */
>>  int devfreq_suspend_device(struct devfreq *devfreq)
>>  {
>> +	int ret;
>> +
>>  	if (!devfreq)
>>  		return -EINVAL;
>>  
>> -	if (!devfreq->governor)
>> -		return 0;
>> +	if (devfreq->governor) {
>> +		ret = devfreq->governor->event_handler(devfreq,
>> +					DEVFREQ_GOV_SUSPEND, NULL);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	if (devfreq->suspend_freq) {
>> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
>> +			return 0;
>> +
>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
>> +		if (ret)
>> +			return ret;
>> +	}
>>  
>> -	return devfreq->governor->event_handler(devfreq,
>> -				DEVFREQ_GOV_SUSPEND, NULL);
>> +	return 0;
>>  }
>>  EXPORT_SYMBOL(devfreq_suspend_device);
>>  
>> @@ -888,14 +909,28 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>   */
>>  int devfreq_resume_device(struct devfreq *devfreq)
>>  {
>> +	int ret;
>> +
>>  	if (!devfreq)
>>  		return -EINVAL;
>>  
>> -	if (!devfreq->governor)
>> -		return 0;
>> +	if (devfreq->resume_freq) {
>> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>> +			return 0;
>>  
>> -	return devfreq->governor->event_handler(devfreq,
>> -				DEVFREQ_GOV_RESUME, NULL);
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
>>  }
>>  EXPORT_SYMBOL(devfreq_resume_device);
>>  
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index e4963b0..d985199 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -131,6 +131,9 @@ struct devfreq_dev_profile {
>>   * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
>>   * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
>>   * @stop_polling:	 devfreq polling status of a device.
>> + * @suspend_freq:	 frequency of a device set during suspend phase.
>> + * @resume_freq:	 frequency of a device set in resume phase.
>> + * @suspend_count:	 suspend requests counter for a device.
>>   * @total_trans:	Number of devfreq transitions
>>   * @trans_table:	Statistics of devfreq transitions
>>   * @time_in_state:	Statistics of devfreq states
>> @@ -167,6 +170,10 @@ struct devfreq {
>>  	unsigned long scaling_max_freq;
>>  	bool stop_polling;
>>  
>> +	unsigned long suspend_freq;
>> +	unsigned long resume_freq;
>> +	atomic_t suspend_count;
>> +
>>  	/* information for device frequency transition */
>>  	unsigned int total_trans;
>>  	unsigned int *trans_table;
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
