Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48565C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E045020878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aK36Rs7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E045020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391761AbeKVNcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:32:19 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:18818 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbeKVNcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:32:19 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181122025459epoutp02c7883b6b6319c805bfa7a013d88689c5~pUrhYMAmC1182711827epoutp02R;
        Thu, 22 Nov 2018 02:54:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181122025459epoutp02c7883b6b6319c805bfa7a013d88689c5~pUrhYMAmC1182711827epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542855299;
        bh=eLpvbuS9P1bVggCI3RoGYXu11UZRwMS1HTJhDL2owI0=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=aK36Rs7bJjTCVJkJDQmOl/BI2wEYBZVyv2/8hOMs4uGtJedEiR8LIvHWSJvCX+B5z
         GdSOWFNGcIrkyYGwVW6bttd8R6B/ixspC63mE72Vh+PciT21VgyCKOC9/3pX6XXl1x
         0adcepbDqzPDIjyU06UeU2210I+lzxPIdYWPcAMk=
Received: from epsmges2p4.samsung.com (unknown [182.195.40.155]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181122025451epcas1p45b841cd62e4ed29db785de4831fe23eb~pUradM9wf0747507475epcas1p4q;
        Thu, 22 Nov 2018 02:54:51 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.F0.04055.B7A16FB5; Thu, 22 Nov 2018 11:54:51 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181122025451epcas2p4f719d879498cc1eef455c9131e7838c7~pUraKfPSs1272912729epcas2p4E;
        Thu, 22 Nov 2018 02:54:51 +0000 (GMT)
X-AuditID: b6c32a48-3c1ff70000000fd7-7b-5bf61a7b1331
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.4C.03627.A7A16FB5; Thu, 22 Nov 2018 11:54:51 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PIK006MKQRE2A00@mmp1.samsung.com>; Thu, 22 Nov 2018 11:54:50 +0900 (KST)
Message-id: <5BF61A7A.1060805@samsung.com>
Date:   Thu, 22 Nov 2018 11:54:50 +0900
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
Subject: Re: [PATCH 2/6] devfreq: refactor set_target frequency function
In-reply-to: <5BF619EE.8090006@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJsWRmVeSWpSXmKPExsWy7bCmmW611Ldog+ttihYHt2pabJyxntVi
        +8ZvrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+xmpxedcc
        NovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOrxZsL91gc
        xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
        udrO4tG3ZRWjx4rV39k9Pm+SC+CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBX
        nJhbXJqXrpecn2tlaGBgZApUmJCd8ep3asFPjYpF79YzNjBeVehi5OSQEDCRmHBgCmMXIxeH
        kMAORonrn2eyQTjfGSW+357JClO1eeJ8JojEbkaJLcd/sIMkeAUEJX5MvsfSxcjBwSwgL3Hk
        UjZImFlAU+LFl0ksEPV3GSW2d55lgqjXknh1dQYziM0ioCoxpfcb2Bw2oPj+FzfYQGx+AUWJ
        qz8eM4LYogIREjvng9RwcYgInGeUWLNzD9gVzAKtzBL/PmwB6xAW8JD4fOwAWAengLbE5EfX
        wR6SEPjLLnG8/RwTxA8uEv+XrGaHsIUlXh3fAmVLSzxbtRGqoZ1R4suLZlYIZwKjxIdTm6G6
        jSWeLexigviOT6Lj8F92kKclBHglOtqEIEo8JKb+PscO8XQDk8S6FV/ZJjDKzkIKp1mIcJqF
        FE4LGJlXMYqlFhTnpqcWGxWYIEfgJkZwatfy2MF44JzPIUYBDkYlHt6G6K/RQqyJZcWVuYcY
        JTiYlUR4L6wACvGmJFZWpRblxxeV5qQWH2I0BQbzRGYp0eR8YN7JK4k3NDUyNja2MDW3NDaw
        VBLnfSg9N1pIID2xJDU7NbUgtQimj4mDU6qBcdoRmZhfizzTMrjUNZdlfZzNWHz8nudqm5Tc
        042dql8sb969vOCJkqLUqtQ9tu67WH3dH/jHTWDr3fe2rn2NzxfVGa8P8U9v3/2oZtZKszv/
        39p5mdWkXVwqdeLtrxWfuU6a+uT+veTdZNjRo/mbeXMhp076lWf6+eXbvzu3pvDZWVyPKlno
        ocRSnJFoqMVcVJwIAJ99zSEDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t9jAd1qqW/RBqcOcVkc3KppsXHGelaL
        7Ru/sVrMP3KO1aJ58Xo2izPduRb9j18zW5w/v4Hd4mzTG3aLWw0yFrOm7GWy2PT4GqvF5V1z
        2Cw+9x5htJhxfh+Txdojd9ktll6/yGRxu3EFm8XdU0eBZpy+xGrRuvcIu0Xb6g+sFm8u3GNx
        EPfYtnsbq8eaeWsYPWY3XGTxmND/idFj8Z6XTB6bVnWyeeyfu4bdY/OSeo9/x9g9Dr7bw+Sx
        5Wo7i0ffllWMHitWf2f3+LxJLoAvissmJTUnsyy1SN8ugSvj1e/Ugp8aFYverWdsYLyq0MXI
        ySEhYCKxeeJ8pi5GLg4hgZ2MEstatzKBJHgFBCV+TL7H0sXIwcEsIC9x5FI2hKkuMWVKLkT5
        fUaJl/fPskOUa0m8ujqDGcRmEVCVmNL7DSzOBhTf/+IGG4jNL6AocfXHY0aQOaICERLdJypB
        5ogInGeUONjXyQpSwyzQyizxqC0LxBYW8JD4fOwAI8SyBiaJ7sW7wBZwCmhLTH50nXECo8As
        JKfOQjh1FsKpCxiZVzFKphYU56bnFhsVGOWllusVJ+YWl+al6yXn525iBMb1tsNa/TsYHy+J
        P8QowMGoxMOrEfk1Wog1say4MvcQowQHs5II74UVQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        /PnHIoUE0hNLUrNTUwtSi2CyTBycUg2MkjmXGOu+tCwRYb1qe/Lg4or1vsLHL8x8u8f5XG1+
        bPI2leIfG1jkZTS+BUUueprCv5nLWOP1iWvrjH3fb3xu4iCUtt/9y88EycNpapan1p84675L
        KejDIl6Vxx4nokL774t+Ojmrcsnn0zsOa+rMaBN+9etA17EJpnO2zvzkK3i3g0ll4a+CACWW
        4oxEQy3mouJEAA/ZKPnnAgAA
X-CMS-MailID: 20181122025451epcas2p4f719d879498cc1eef455c9131e7838c7
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de@eucas1p2.samsung.com>
        <1542823301-23563-3-git-send-email-l.luba@partner.samsung.com>
        <5BF619EE.8090006@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 11월 22일 11:52, Chanwoo Choi wrote:
> On 2018년 11월 22일 03:01, Lukasz Luba wrote:
>> The refactoring is needed for the new client in devfreq: suspend.
>> To avoid code duplication, move it to the new local function
>> devfreq_set_target.
>>
>> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>> solve issue with devfreq device's frequency during suspend/resume.
>> During the discussion on LKML some corner cases and comments appeared
>> related to the design. This patch address them keeping in mind suggestions
>> from Chanwoo Choi.
> 
> As I commented on patch1, please remove it.
> 
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>  drivers/devfreq/devfreq.c | 62 ++++++++++++++++++++++++++++-------------------
>>  1 file changed, 37 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index e20e7e4..cf9c643 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -285,6 +285,42 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>  	return 0;
>>  }
>>  
>> +static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>> +			      unsigned long *prev_freq, u32 flags)
> 
> Please remove the unused space in front of 'unsigned long *prev_freq'.
> Use tab only for indentation.
> 
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
>> +	*prev_freq = cur_freq;
>> +
>> +	return err;
>> +}

You can change the devfreq_set_target as following:

 static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
-                             unsigned long *prev_freq, u32 flags)
+                       u32 flags)
 {
        struct devfreq_freqs freqs;
        unsigned long cur_freq;
@@ -319,7 +319,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
                        "Couldn't update frequency transition information.\n");
 
        devfreq->previous_freq = new_freq;
-       *prev_freq = cur_freq;


But, you have to add following new code on patch3 instead of patch2.

+
+       if (devfreq->suspend_freq)
+               devfreq->resume_freq = cur_freq;

 
        return err;
 }



>> +
>>  /* Load monitoring helper functions for governors use */
>>  
>>  /**
>> @@ -296,7 +332,6 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>   */
>>  int update_devfreq(struct devfreq *devfreq)
>>  {
>> -	struct devfreq_freqs freqs;
>>  	unsigned long freq, cur_freq, min_freq, max_freq;
> 
> 
> cur_freq is not used after modification. Remove it.
> 
>>  	int err = 0;
>>  	u32 flags = 0;
>> @@ -333,31 +368,8 @@ int update_devfreq(struct devfreq *devfreq)
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
>> +	return devfreq_set_target(devfreq, freq, &cur_freq, flags);
> 
> You get the 'cur_freq' from devfreq_set_taget() for devfreq_suspend_device() on patch3.
> But, update_devfreq() and devfreq_resume_device() don't use the 'cur_freq' value
> from devfreq_set_target().
> 
> Instead, getting 'cur_freq' for 'devfreq->resume_freq' in the devfreq_set_target().
> Please remove the 'cur_freq' parameter from devfreq_set_target.
> 
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
