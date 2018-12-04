Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77548C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB632087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HkQPftd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB632087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbeLDJg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:36:59 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46007 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeLDJg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:36:58 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181204093655euoutp02bbed318c533ff83222000aed0be66302~tF55N6dja1018410184euoutp028
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 09:36:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181204093655euoutp02bbed318c533ff83222000aed0be66302~tF55N6dja1018410184euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543916215;
        bh=5oHwbkNBwZ8vyA7aiFkSdMNnG2mYoDqJwLr7psoNemc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HkQPftd/kukHaVN4am1IcXmytVT/aRGRvroja5EID4/igZMKc9vk9b+EBWn7zwxxU
         dD5975dRhB5O0u5J2m9mmPw0UXsluuUe+NYKQRf7VXOPQpO2KdC/Dh/w9kHpP/iCn6
         rJ9QmOpZfKa2BigTskWmfsxAwCVAhV3gV/NEaGLE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181204093654eucas1p2d116d06566f9845accdc7c3863f5fe8a~tF54Ju3rX1999119991eucas1p2f;
        Tue,  4 Dec 2018 09:36:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 18.A7.04441.6BA460C5; Tue,  4
        Dec 2018 09:36:54 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181204093653eucas1p131c58415f6a494ca38c28bce87663f25~tF53C37vv1164211642eucas1p1p;
        Tue,  4 Dec 2018 09:36:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181204093653eusmtrp24278476d6886c845d59dbb463545726c~tF52zHntu0363703637eusmtrp2S;
        Tue,  4 Dec 2018 09:36:53 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-49-5c064ab6b0f6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F4.90.04128.5BA460C5; Tue,  4
        Dec 2018 09:36:53 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181204093652eusmtip20f4a75b67b676023661632c12d2b8ef0~tF512CYcj2472424724eusmtip2e;
        Tue,  4 Dec 2018 09:36:52 +0000 (GMT)
Subject: Re: [PATCH v2 1/5] devfreq: refactor set_target frequency function
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
Message-ID: <545653c6-d68f-9177-6765-15a1beccb60f@partner.samsung.com>
Date:   Tue, 4 Dec 2018 10:36:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5C060511.8020802@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUxTaRSG/XpX0JqP6tgT11iNGxEko+HDFeOSG52JM3/UKMlMHe8gGVq1
        F1BHowiCFTc0aqGyGEElpQattRRQUEAJi2wOMoNUajAaGVECuEWDcrk18u85y5vzvsnhKU0m
        O56PMsaIJqM+Wsf60677H+vnutawEfPOtkwhd2/OJtfTChhSeP0dQ1r7XzAku7KeIYk5BSyp
        O2ogJzv/p0hDwzWOPEh4xRHrmdsq4uh8xJCHxRks6TteiUhaQ6mKXK30cORSa5OKPD6YxxJP
        zb1BfW0zQ5JuV3IkOb+HIa8an9DhWsFV4mIEe5YdCefjm2gh9WQvEnJuvVQJDtsRVijLtHPC
        jdwDwsB9TnC2HKaFE04bEvLy33NCn2PyL+pN/ou3itFRcaIpeOnv/ts8HVZ2R92k3fWXnlDx
        yAwpyI8HPB+uZp5iU5A/r8F5CLrak2il6Efg+ZjuK/oQ3M16rvom+VDYQymDKwhep/xDyQMN
        7kZgzoqSeQxeC7mHuofUY3EtgrKy8qEjFE6iYKDHOVjwPIuDwG3bKaMar4YE7xZZS+PpUGFJ
        42T+AW8Ec0c+K7MaB0B1+jNaZj8cCL39hUM7FNZC27NslcJTIPHm+SFzgL08NPsEgFdC64nX
        nMJjoKvK6eOJ8KUo25dMggdmG6vwPjhc7fbtLIKKqiZG9knh2VBQHKy0l4OlKIGT24BHw7/d
        AYqF0XDaZaGUthrMyRplexY4jzX6Do2DK/ZzXCrSWYcFsw4LYx0Wxvr97gVE25BWjJUMkaIU
        YhR3BUl6gxRrjAz6Y7vBgQaftnagqteN3jZvKUeYR7pR6vBwJkLD6OOkPYZyBDylG6tun8FG
        aNRb9Xv+Fk3bfzPFRotSOZrA0zqteu8I72YNjtTHiH+J4g7R9G2q4v3Gx6PcBS8u/1RS5Bk5
        0j3t6Z3smuDasLZSMTVwXUro5c/GT6ri/5bZp/16B6Ynl9oWQl7CBW9b2nPLl9B5mV0ZYYkH
        vX9yj9tnhm3wVIS65/d8bv5x34oJ3nv2mJYVSwYcTu3cORd/fmN5mrG+U2sN8OuI09Z5pazG
        tR2GhSG3clZNLV2+X0dL2/QhcyiTpP8KAXFL5bADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHO/e1O/HGbWkehDKmFRZOpy6PZRH9EZfS6AXmo2zVbVpus90p
        KUU+eyxKC8O1SsuUbFrm0k2sJZoZpbVUelD5CI1aag+VMhDJNQL/+xy+53PO7wdfGpdYSF86
        RaPndRplqpTyIDqmn/QFNWykEkOsY/NQS0MgqjPWkshW94tEbyY+k6is7QWJ8m7UUqjzjBoV
        Dg7jyOG4K0LPc0dEyFRsx5Bl8DWJepquUGj8bBtARsdDDN1u6xWhyjddGHqfU0Wh3mePZ/yO
        bhIV2NtE6ET1DxKNvOwj1vlw1vtWkqsprQHc5ewugisqHAPcjQdOjLOYT1Nc89UaEXev4jg3
        3S7i6l+dJLhz9WbAVVX/FnHjlkVbmHhZlE6brucXJ2sF/RppghyFyuSRSBYaHimTh0XsWhWq
        kAavjdrPp6Zk8LrgtXtkyb39Jiqtc+GRF5V9eDY4BQ1ATEM2HE7afuAG4EFL2EoA65tuUe5g
        Abzw0CZy83w49dpAuS8NA9hvs2OuYD67CVbkjxKuwIvtALDY8QxzHXC2AIfO0XLgVqYBPD0x
        SRoATVOsDDaaD7uQYTfA3IG9rocINgA+KjH++82b3QmfO+8AFzPsPPj00hDhYjG7Ao5NuCfC
        2ZWw9N5H3M0+8N1QGeZmP5jXcBkvAhLTLN00SzHNUkyzlGuAMAMvPl1Qq9RCqExQqoV0jUq2
        T6u2gJm+WNv/1DcCw7ftrYClgdSTMa4nEyWkMkPIVLcCSONSL+bDUipRwuxXZmbxOm2SLj2V
        F1qBYma587iv9z7tTPs0+iS5Qh6BIuURYRFhK5HUh3GEZMZLWJVSzx/i+TRe99/DaLFvNmjZ
        EZig8hdiDjYGpVy3x2lCvgZU+3sta3aO9kTXwdTyL7W5Jwhm99FIvclzceEjydyBJZvz7VsO
        GOlyz20/bYpxVeyBkmNpU1n9hvYrMXFYRmxnQLfJqlg9PpQWrT76ntPPebLDT5zv+9ZuTsrx
        +L5VfNHq/DRtaUw4eDOc6S6QEkKyUr4c1wnKv3JJz8JFAwAA
X-CMS-MailID: 20181204093653eucas1p131c58415f6a494ca38c28bce87663f25
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5@eucas1p2.samsung.com>
        <1543847475-7600-2-git-send-email-l.luba@partner.samsung.com>
        <5C060511.8020802@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 12/4/18 5:39 AM, Chanwoo Choi wrote:
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
OK

Regards,
Lukasz
> 
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 62 +++++++++++++++++++++++++++--------------------
>>   1 file changed, 36 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 1414130..a9fd61b 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -285,6 +285,40 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>   	return 0;
>>   }
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
>>   /* Load monitoring helper functions for governors use */
>>   
>>   /**
>> @@ -296,8 +330,7 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>    */
>>   int update_devfreq(struct devfreq *devfreq)
>>   {
>> -	struct devfreq_freqs freqs;
>> -	unsigned long freq, cur_freq, min_freq, max_freq;
>> +	unsigned long freq, min_freq, max_freq;
>>   	int err = 0;
>>   	u32 flags = 0;
>>   
>> @@ -333,31 +366,8 @@ int update_devfreq(struct devfreq *devfreq)
>>   		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>>   	}
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
>>   }
>>   EXPORT_SYMBOL(update_devfreq);
>>   
>>
> 
> 
