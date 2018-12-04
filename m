Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C41BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FDA208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ecbQzlCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FDA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLDFnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:43:20 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52256 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbeLDFnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:43:20 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181204054315epoutp0151e3e8cbc264a4b79d071ce1b598e57f~tCt4CxDpb0647006470epoutp01N;
        Tue,  4 Dec 2018 05:43:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181204054315epoutp0151e3e8cbc264a4b79d071ce1b598e57f~tCt4CxDpb0647006470epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543902195;
        bh=+9ztf+bV6r/gJ6qrM1G5w/aDE+1hLuUHZrAIGFmAf/Y=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=ecbQzlCDpEFPQAS3eXHNi/nGAeA40ZD7VPEzD6HAzTl5596MuPxHTk95Z3uDDkobD
         IwrgwY9xtXjto1hWFYV/QGZ3FoKRJ7Vl0yiKsozd85Ms1UQEt79g/+pLuMtoRaFYfa
         SWYpi71FSpUVdj+QWdXSwf1QxuZKRKrtOUa+9gYg=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181204054311epcas1p3cafd58cbc339e0b4ae60edc5f784374c~tCt0AB10F3132131321epcas1p31;
        Tue,  4 Dec 2018 05:43:11 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.08.04057.FE3160C5; Tue,  4 Dec 2018 14:43:11 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181204054311epcas1p194e62327afd8ea59388dea4f8b801f8d~tCtzq8cjC0754607546epcas1p1q;
        Tue,  4 Dec 2018 05:43:11 +0000 (GMT)
X-AuditID: b6c32a36-d19ff70000000fd9-2c-5c0613ef0278
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.F1.03601.EE3160C5; Tue,  4 Dec 2018 14:43:11 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJ700AS86JYCE40@mmp1.samsung.com>; Tue, 04 Dec 2018 14:43:10 +0900 (KST)
Message-id: <5C0613EE.9000208@samsung.com>
Date:   Tue, 04 Dec 2018 14:43:10 +0900
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
Subject: Re: [PATCH v2 1/5] devfreq: refactor set_target frequency function
In-reply-to: <5C060511.8020802@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxbVRz1vm8WCm9llRucrD7nH8Uw+2Bld0iNsMU8A38wZ6JxmPoCL0Do
        x7OvzE0TrSJDGNtwMwtBNrYxB0JJBSofAhKwkwTd6lCUYcAPdOJARl3ZWHRo2zcj/53fyfmd
        3HPuvQyuXaSSmFK7S3LaRStHbSB6PjMYU28kUAXGilAyGvnYgDrrvSTq7bxFoib/ZRJVNHsp
        9OVhGzo2t4CjQOAjGl16a5FG0+7NqOG9IQx1zX1Loq8/aaTQzSN+gOoDn2Kowz9Dow++u4Kh
        799spdDM+MWwxxcTJKoc8tPoUPsyiRa/miWeTBR6BnpIwXPaA4T33VcIoe7Yn0BoHvwdE7ra
        qilh+JSHFrrPvyGsfU4LI0uDmOCbrCKEo742ILS236aFm13J+XEvlGWVSGKR5NRL9kJHUam9
        2Mzl7rXsspgyjHwqvxPt4PR20SaZud15+alPlVrD8Tn9ftFaHqbyRUXhHnsiy+kod0n6Eofi
        MnOSXGSVd8rbFNGmlNuLtxU6bJm80ZhmCgtfKivxBa9i8kjygeE7uW6wAmtADAPZ7fDC0jJZ
        AzYwWrYPwKGFNUIdbgN44uRdUAOYqCp4VafyA2F+tYWObGvYjXD1xCwR0eDsFuifKIvQOGuA
        86Hj93xmAOxsGgOqPgVOD3xIRjDBPgL/CXZHMRXmh+enqAiOZx+Ck6tzUb2OfR72N92iI0ab
        2ACAnv5BLDLgbCUO15Z90Y0ENheef/sPIoJj2Eeh9/oUpma7S0Nf6HEV74aNh0OEihPg9TEf
        rSZ7AE5cNEc8IVsFYGi+glSHOgCXx7vvGaXDa2drMDVbHFxaqSXVZQ1855BWlQhwcqU/eh4t
        uwZgsC+7DjzYsK6khv9LalhX0hmAt4H7JVmxFUsKL6etv7wuEH3pKRl94NzlvFHAMoCL1dTn
        kAVaUtyvHLSNAsjg3CaN/DJRoNUUiQdflZwOi7PcKimjwBTu+F08SVfoCP8bu8vCm9LS09PR
        dj7DxPNcouaXpFP7tGyx6JLKJEmWnP/tYUxMkhtkbtGZp6qPtx65lvYzQqNnfg3onutw5c2f
        rm30bF0BBwK1hm+kyt657Bd1G3uP7qr1tCT+eKdqPJjI6DJvyDmvv/Js876xHClujyd2z29c
        fpa+/cLDHX/nvqa/z/s0+4N3itoc/5NzVq4Y6+z76xmD5dyllrMJoWpzrMadnbkQP72DI5QS
        kU/BnYr4L6EsSQ3/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsVy+t9jAd33wmwxBgc62C0ObtW02DhjPavF
        9o3fWC3mHznHatG8eD2bxZnuXIv+x6+ZLc6f38BucbbpDbvFrQYZi1lT9jJZbHp8jdXi8q45
        bBafe48wWsw4v4/JYu2Ru+wWS69fZLK43biCzeLuqaNAM05fYrVo3XuE3aJt9QdWizcX7rE4
        iHts272N1WPNvDWMHrMbLrJ4TOj/xOixeM9LJo9NqzrZPPbPXcPusXlJvce/Y+weB9/tYfLY
        crWdxaNvyypGjxWrv7N7fN4kF8AXxWWTkpqTWZZapG+XwJWx5eNNpoKDchX7f3o3MH6V6GLk
        4JAQMJH4eFO0i5GLQ0hgJ6NE44nrrF2MnBy8AoISPybfYwGpYRaQlzhyKRvCVJeYMiUXpEJI
        4D6jRM9FLYhqLYlbu1eCdbIIqEr8/7gZzGYDiu9/cYMNxOYXUJS4+uMxI8gYUYEIie4TlSBb
        RQTOM0oc7OsEq2cWaGWWeNSWBWILC3hLLGl5ywJx2j9Gic4vP8CKOAW0Jda/usE0gVFgFpJL
        ZyFcOgvh0gWMzKsYJVMLinPTc4uNCgzzUsv1ihNzi0vz0vWS83M3MQJjetthrb4djPeXxB9i
        FOBgVOLhneHEGiPEmlhWXJl7iFGCg1lJhLegkCVGiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/t
        vGORQgLpiSWp2ampBalFMFkmDk6pBsa2oxf8ddyCd+8OiPDPal0S3iDToChm5J9VJ/Rs3tND
        2dqzT27uMHr9VOmH0Y6V5+IjKn91nDl97KXX+2U2T4PnXWQTquqdkqAYfSnONrq+/VyX1nLW
        Ta4fC71udTK6dYbxvtkdIPR55e7dzyWq1wdz37Ji/rnj4e0ohqy4dY+ijeatKTTbYKHEUpyR
        aKjFXFScCABcEovl5QIAAA==
X-CMS-MailID: 20181204054311epcas1p194e62327afd8ea59388dea4f8b801f8d
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5@eucas1p2.samsung.com>
        <1543847475-7600-2-git-send-email-l.luba@partner.samsung.com>
        <5C060511.8020802@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 12월 04일 13:39, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 2018년 12월 03일 23:31, Lukasz Luba wrote:
>> The refactoring is needed for the new client in devfreq: suspend.
>> To avoid code duplication, move it to the new local function
>> devfreq_set_target.
>>
>> The patch is based on earlier work by Tobias Jakobi.
> 
> As I already commented, Please remove it. You already mentioned it on cover-letter.
> If you want to contain the contribution history of Tobias, you might better
> to add 'Signed-off-by' or others.

If you will fix it, feel free to add my tag:
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 62 +++++++++++++++++++++++++++--------------------
>>  1 file changed, 36 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 1414130..a9fd61b 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -285,6 +285,40 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>  	return 0;
>>  }
>>  
>> +static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>> +			      u32 flags)
>> +{
>> +	struct devfreq_freqs freqs;
>> +	unsigned long cur_freq;
>> +	int err = 0;
>> +
>> +	if (devfreq->profile->get_cur_freq)
>> +		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
>> +	else
>> +		cur_freq = devfreq->previous_freq;
>> +
>> +	freqs.old = cur_freq;
>> +	freqs.new = new_freq;
>> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
>> +
>> +	err = devfreq->profile->target(devfreq->dev.parent, &new_freq, flags);
>> +	if (err) {
>> +		freqs.new = cur_freq;
>> +		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>> +		return err;
>> +	}
>> +
>> +	freqs.new = new_freq;
>> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>> +
>> +	if (devfreq_update_status(devfreq, new_freq))
>> +		dev_err(&devfreq->dev,
>> +			"Couldn't update frequency transition information.\n");
>> +
>> +	devfreq->previous_freq = new_freq;
>> +	return err;
>> +}
>> +
>>  /* Load monitoring helper functions for governors use */
>>  
>>  /**
>> @@ -296,8 +330,7 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>   */
>>  int update_devfreq(struct devfreq *devfreq)
>>  {
>> -	struct devfreq_freqs freqs;
>> -	unsigned long freq, cur_freq, min_freq, max_freq;
>> +	unsigned long freq, min_freq, max_freq;
>>  	int err = 0;
>>  	u32 flags = 0;
>>  
>> @@ -333,31 +366,8 @@ int update_devfreq(struct devfreq *devfreq)
>>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>>  	}
>>  
>> -	if (devfreq->profile->get_cur_freq)
>> -		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
>> -	else
>> -		cur_freq = devfreq->previous_freq;
>> -
>> -	freqs.old = cur_freq;
>> -	freqs.new = freq;
>> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
>> +	return devfreq_set_target(devfreq, freq, flags);
>>  
>> -	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
>> -	if (err) {
>> -		freqs.new = cur_freq;
>> -		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>> -		return err;
>> -	}
>> -
>> -	freqs.new = freq;
>> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>> -
>> -	if (devfreq_update_status(devfreq, freq))
>> -		dev_err(&devfreq->dev,
>> -			"Couldn't update frequency transition information.\n");
>> -
>> -	devfreq->previous_freq = freq;
>> -	return err;
>>  }
>>  EXPORT_SYMBOL(update_devfreq);
>>  
>>
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
