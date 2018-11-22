Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E027C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CCD20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RTe0eqoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CCD20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439205AbeKWKgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 05:36:02 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:43689 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439190AbeKWKgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 05:36:01 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181122235409epoutp03a2fecfb5549fab55b872b9c25a693f26~pl27aDdgK1895718957epoutp03Q;
        Thu, 22 Nov 2018 23:54:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181122235409epoutp03a2fecfb5549fab55b872b9c25a693f26~pl27aDdgK1895718957epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542930849;
        bh=7Fnpio1xsp2AnXGVYYJ7w4oWVCI3j2JOB4AD6Br0BAI=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=RTe0eqoKoVOXCER6dP+sthUNWv1jdYJEMWn/X6WHbxvOpEg0drFbeJo3ZdBeg5YUM
         J8WvNZ+Szthwr83fKPQSUBSWw3+OOzsBy/uaFK98w8wIm1By8s9td3HaHKTIZmzRCH
         LkcDKIsT+nfRA1nHCfDgRQoPgELYPmV1vCh41mFQ=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181122235407epcas1p12b4cb8952a209744366109511eb00fc2~pl245Y0jt0349003490epcas1p1J;
        Thu, 22 Nov 2018 23:54:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.DE.04146.E9147FB5; Fri, 23 Nov 2018 08:54:06 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181122235406epcas1p473319653066e5472852a18070c8aece3~pl24j7zMr1809318093epcas1p4W;
        Thu, 22 Nov 2018 23:54:06 +0000 (GMT)
X-AuditID: b6c32a38-18fff70000001032-11-5bf7419eebb4
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.73.03601.E9147FB5; Fri, 23 Nov 2018 08:54:06 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PIM00GICD26OQ40@mmp1.samsung.com>; Fri, 23 Nov 2018 08:54:06 +0900 (KST)
Message-id: <5BF7419E.90006@samsung.com>
Date:   Fri, 23 Nov 2018 08:54:06 +0900
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
Subject: Re: [PATCH 3/6] devfreq: add support for suspend/resume of a
 devfreq device
In-reply-to: <cce4f194-b574-a12c-e876-f11a6f245940@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjm3Nv7gbPuriiedeLwLi6AgXGF4nGTfUQnN5kJ3WaWRX6wG7hp
        Cf1abyFglqyVoA7pZGxZSJ04xW4ESiwITLFQLdWxyqyyFZcZdIZt6aazZColy9T1cmPGv+d9
        3+c5eZ/nnEPjmgSppWssDtFuEUwsuUw1PJ5bkN/5WrKi8NhvL6FzQ7mov+MEgb7pnyfQkfAl
        AjV1nSDR5AEzOjh7C0fRqJ9C3++5TaGfnWuQ57NRDA3MThPoh5EvSHTXHQaoIzqGob7wDIW8
        V69g6Jqrm0QzkfOpMy5OEah5NEyhvb1zBLp9+brq1dX88Jlhgvd1+gB/yHlFxbcd/BvwXYE/
        MH6g5yOSDx72UfzJ4x/yDy9Q/Lk7AYwfjO1T8R8P9gC+uzdJ8XcH1upX7KrdYhSFatGeLVqq
        rNU1FkMp+8bblVsrdSWFXD63GW1isy2CWSxlt+3Q52+vMaXss9n1gqku1dILksS+8PIWu7XO
        IWYbrZKjlBVt1SbbZluBJJilOouhoMpqfpErLNyoSxHfqzXe7EgQtrPPNUSiM6QTjGtbQDoN
        mWJ4cXo/kLGGOQXgeFtZC1iWwkkAnYm46jHJ0+IilMEZAB/FLlDyQM08BRc+vZ4i0TTOPAvD
        U7VyG2dyYfxeu0rhzwDobW3FFX4OPHojiclYxayHTaN9hIxJJg8G4z+RMn6SWQdjC7OLG61i
        3oWnj8xT8kErmSiAvtMBTC5wphmHD+cGFxUZzDuwO7CwuFE6UwZd10ZwmQSZBxTsD02Siodt
        8KvLXkrBGfDPbwcpeW3IPAOnzpcq/H0A3os3EUrRBuBc5CSmCIrg70dbMMXcCnjnfiuhiNVw
        /16NQuHh+I9OSvE8isGxryN4G8jyLInJ839MniUxfQnwHpAp2iSzQZQ4W/HS+xsAi489D50C
        gUs7QoChAbtc7e+fr9AQQr3UaA4BSOPsSvWedckKjbpaaNwt2q2V9jqTKIWALpXyJ7h2VZU1
        9XUsjkpOt7GoqAgVcyU6jmNXq3/VHq7QMAbBIdaKok20P9ZhdLrWCYzvI+vs67ulvqC//UHV
        dr16TZo3JyfyD5X1ppZ0pa2duHq/seGA3+BO3no+4/N6f/P6sRF3IhTL9HsPTdLxhr9c7l1Z
        wfKJkkRnefjGBnHacNYdyyz/7umum49+2dA75LNscpn1jXY/n8aVffDEUO7C1p1vTWSY/l3u
        b98Z9L3CqiSjwOXhdkn4D+p9GEYCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0iTYRiGe/cdNVdvc+Kb2sFZlIqmEvFGofXLrxPUj6SUsKFfHjfXPrVm
        UFPRcJ5JyFZZoYJ4wLOWeWi6PNvSMEPRkRJUDgslJ4WSU8L+XfDcz/Xc8LCEZJx0YWOUibxa
        KY+X0fbk0Noc9Ck5bQ3zMz6UYUOzJ64vrqVwa/0yhZ8Z31E4vbSWxsPZCpw/N09gk6mOwSNp
        FgZPat2wvqhDhBvmPlL4Q9sTGi/lGgEuNnWKcI1xmsHlE6MiPJVaQePpwbfrjqExCmd0GBmc
        WfWTwpb3M+QpZ67ldQvFVZdUA+6xdpTkCvIXAVfa/k3ENVRm0VzX02qGayy7x631MpxhoV3E
        NY3fJ7m8pkrAVVRZGW6pYe/FHaH2JyP5+JhkXn0k8Lp99OfiH5TqjcftQdM0rQU9LjpgxyJ4
        FOl1qZQO2LMS+AqgvtZMkW0ghrvQyoMZUgdYloD7kHEsbhMPoaIixWbcDFDxwgCzGT+MXpit
        G6skPIjSO2ooG9PQC3V9/UTbeCd0R+Mrc8DmcYJXUHa/xuaRQhNAhrysjTwBMwg0mxlrY0cY
        gnQ5q8zmsQ4RSs+t2xDZwWCUOtVGFACo/6+qfquqfqvqc0BUgt28SlBEKYQAlb+Sv+UryBVC
        kjLKNyJB0QDWn93S45X3EpjLwrsBZIHMQVxXvxwmoeTJgkbRDRBLyKTiNHdrmEQcKdek8OqE
        cHVSPC90A1eWlDmLp5S9VyUwSp7Ix/G8ilf/m4pYOxctCB0OLrzc1d45qGqOKHh0NyS6XA1/
        p3vfWUzxqBk+MxNUWhh709zotLfX+mV/X3/4r2MXAq+ZHDxXs9w0xFC9ga6o2N6sks6f1Shz
        BuZnM2Is5y/98XMnW/vNpHbSbUTaLzje+F6SY+nb4xRI+AQRWqdt3krrxIFz0eLjJwJcpTJS
        iJb7exFqQf4XLif+9OgCAAA=
X-CMS-MailID: 20181122235406epcas1p473319653066e5472852a18070c8aece3
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382@eucas1p1.samsung.com>
        <1542823301-23563-4-git-send-email-l.luba@partner.samsung.com>
        <5BF61B3A.9050402@samsung.com>
        <cce4f194-b574-a12c-e876-f11a6f245940@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

I add one more comment about devfreq_resume_device().

On 2018년 11월 22일 20:00, Lukasz Luba wrote:
> 
> 
> On 11/22/18 3:58 AM, Chanwoo Choi wrote:
>> On 2018년 11월 22일 03:01, Lukasz Luba wrote:
>>> The patch adds support for handling suspend/resume process.
>>> It uses atomic variables to make sure no race condition
>>> affects the process.
>>>
>>> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>>> solve issue with devfreq device's frequency during suspend/resume.
>>> During the discussion on LKML some corner cases and comments appeared
>>> related to the design. This patch address them keeping in mind suggestions
>>> from Chanwoo Choi.
>>
>> Please remove the duplicate information about patch history.
>>
>>>
>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   drivers/devfreq/devfreq.c | 45 +++++++++++++++++++++++++++++++++++++++------
>>>   1 file changed, 39 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index cf9c643..7e09de8 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -872,14 +872,33 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>>    */
>>>   int devfreq_suspend_device(struct devfreq *devfreq)
>>>   {
>>> -	if (!devfreq)
>>> -		return -EINVAL;
>>> +        int ret;
>>
>> Move 'ret' definition under 'if (devfreq->suspend_freq) {'
>> because 'ret' is used if suspend_freq isn't zero.
> Not only there, 6 lines above 'ret' is used for 
> devfreq->governor->event_handler().

OK.

>>
>>> +        unsigned long prev_freq;
>>> +        u32 flags = 0;
>>> +
>>> +        if (!devfreq)
>>> +                return -EINVAL;
>>> +
>>> +        if (devfreq->governor) {
>>> +		ret = devfreq->governor->event_handler(devfreq,
>>> +					DEVFREQ_GOV_SUSPEND, NULL);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>>   
>>> -	if (!devfreq->governor)
>>> -		return 0;
>>> +	if (devfreq->suspend_freq) {
>>> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
>>> +			return 0;
>>>   
>>> -	return devfreq->governor->event_handler(devfreq,
>>> -				DEVFREQ_GOV_SUSPEND, NULL);
>>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq,
>>> +					 &prev_freq, flags);
>>
>> Remove the 'prev_freq' parameter.
> OK
>>
>>> +		if (ret)
>>> +			return ret;
>>> +
>>> +		devfreq->resume_freq = prev_freq;
>>
>> As I commented on patch2, if devfreq_set_taget save the current frequency
>> to 'devfreq->resume_freq', this line is not needed.
> OK
>>
>>
>>> +	}
>>> +
>>> +        return 0;
>>>   }
>>>   EXPORT_SYMBOL(devfreq_suspend_device);
>>>   
>>> @@ -893,9 +912,23 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>>    */
>>>   int devfreq_resume_device(struct devfreq *devfreq)
>>>   {
>>> +        int ret;
>>
>> Move 'ret' definition under 'if (devfreq->suspend_freq) {'
>> because 'ret' is used if suspend_freq isn't zero.
> OK

If you change the devfreq_resume_device() according to my new comment,
please ignore it.

>>
>>> +        unsigned long prev_freq;
>>
>> Remove prev_freq variable which is not used on this function.
>> After calling devfreq_set_target, prev_freq is not used.
> OK
>>
>>> +        u32 flags = 0;
>>> +
>>>   	if (!devfreq)
>>>   		return -EINVAL;
>>>   
>>> +	if (devfreq->suspend_freq) {
>>> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>>> +			return 0;
>>> +
>>> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq,
>>> +					 &prev_freq, flags);
>>
>> Remove the 'prev_freq' parameter.
> OK
>>
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>>   	if (!devfreq->governor)
>>>   		return 0;

Please change the code as following because you uses the following type
in the devfreq_suspend_device(). If there is any special issue, please
keep the same format in order to improve the readability. 

	if (devfreq->governor) {                                                
		ret = devfreq->governor->event_handler(devfreq,                 
				DEVFREQ_GOV_RESUME, NULL);             
		if (ret)                                                        
			return ret;                                             
	}        


>>>   
>>>
>>
>>
> 
> Regards,
> Lukasz Luba
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
