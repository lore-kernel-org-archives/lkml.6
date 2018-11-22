Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF3FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9035E20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NofCagNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9035E20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390808AbeKVVTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:19:06 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60515 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732364AbeKVVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:19:06 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181122104014euoutp012c33aafe7c6b47233cb9e62904b46aa2~pbBvUT0ut0634806348euoutp011
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 10:40:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181122104014euoutp012c33aafe7c6b47233cb9e62904b46aa2~pbBvUT0ut0634806348euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542883214;
        bh=3skxWVU+/hhOhBngib6kBdAfoe2JY3SLVZ1dVYzMEfY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NofCagNlp2ScjssepY9230pz/et+AU2krArIOaDP8nBJlYRoUfwUVYoSj8BSWcTKy
         X7ckpr/aDywVu+MDat7iaMzvVf/afDr+SsMvF9+3qs5j5sLMe9IhqXm7AbA/0BdCWI
         FdCAXQKP+6zn9N2qA0RDT3gg/3ZV+oJ88yJqtk/c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181122104012eucas1p20402d123ba4d1f93709f732ac08d2897~pbBuKJekT0935309353eucas1p2G;
        Thu, 22 Nov 2018 10:40:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0C.E8.04806.C8786FB5; Thu, 22
        Nov 2018 10:40:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181122104011eucas1p285f0f16ea8f06db366d95cc2f0a2acd4~pbBtR-0fl1746917469eucas1p2w;
        Thu, 22 Nov 2018 10:40:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181122104011eusmtrp21245a69a5e2d3a57206a015b60ebca32~pbBtApHll1720417204eusmtrp2v;
        Thu, 22 Nov 2018 10:40:11 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-92-5bf6878c5b65
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F0.64.04284.B8786FB5; Thu, 22
        Nov 2018 10:40:11 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181122104010eusmtip150ed015c94c28a369e4f29a4e713f772~pbBsI_HTU0105501055eusmtip1F;
        Thu, 22 Nov 2018 10:40:10 +0000 (GMT)
Subject: Re: [PATCH 2/6] devfreq: refactor set_target frequency function
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
Message-ID: <9eef3348-e86f-1113-3691-39ba3a620fb8@partner.samsung.com>
Date:   Thu, 22 Nov 2018 11:40:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BF619EE.8090006@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa1BMYRjHvXuuxXLaSs+4zuxMQ4zS6MNrasKEOR98YMwYYz+w1ZlEG/aU
        REYSZZUwJlm3CGXbZLNd5FK2y5ZK0qQmlUw7Gl1c2qwxYxbHyejb73me/3/+z/POyxKqq/Q8
        NjY+QdDHa+PUtCdZ0fijfUVWhkuz8n2PGj8vD8CWvFIKV1pcFO6eHKbwjfqXFD5RUErj1jM6
        nDM0SuD29gcMbksbY7Dx4lMFLht6Q+HO6qs0dmbXI5zX/kyBS+r7GXynu0OB3x4vonH/i4Y/
        /pbXFD75tJ7Bp4q/UHjs1QC51o+veFxB8ebrZsRfSe0g+XM5E4gvePJRwZeZTtN8zTUzwz+8
        fYx3NzK8tSuD5M9aTYgvKv7O8M6yRZuVOzzDooW42IOCPih8l+futK/paH+3/6HCa71kKnqz
        yIBYFrgQcNjDDMiTVXFFCC5XWhRyMYmgtu7nVOFEkPvDShiQx19H68A9JLGKK0TgcKfIonEE
        t5rsCmngzfHgbKxF0sCHa0FQU2OjpYLgThLg/mKlpXCaC4Qq0wHJoOQ2gtvx4G8CyfnDp4kR
        RmJfbjtkviumZY0XNF92kBJ7cMuhJMdCSUxwftDruKGQeTGcKL8ytekgC2luVub10GY+Q8rs
        DSN2KyPzAvj1SPYCJ0JbpomWOQUymqumNKFQZ++gpJUJLgBKq4Pk9jo432lh5GecDT3jXvIG
        s+FCxSVCbish85RKVi8Fa9arqaC5UGjOZc4htXHaXcZptxin3WL8n5uPSBPyExJFXYwgrooX
        kgJFrU5MjI8JjNqnK0N//myL2/6tCj37GWlDHIvUs5Spmm8aFaU9KCbrbAhYQu2j7Fzn0qiU
        0drkw4J+3059Ypwg2tB8llT7KY/MGNSouBhtgrBXEPYL+n9TBesxLxXFNqTnEwnL+iZ857xI
        r7207ag6eHxP1c6F4el7+jYN20Y02TUCuj+e25RkuKXvj/il94jMbJoZNevz0L3VcYbgltGC
        mccKt+wtJ5eUhPOPh550Bfv4fwh1FfRtCp/RELPDtSDv+NZRx0B1b+vN8r41G0K6IgZKsu86
        Ly4NRFGTjZEpalLcrQ1eRuhF7W/FStHzrwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec9lZ2qD4/Ly5oeKSXSjo8frq9RIsDp9kAqDLiv0pCe13Gbn
        bJVFZKWJWtkVapZWKplpupnTrKxkGam5ynSgKIh20SzMWxQibY3Ab7/nef4/Hh545LjSQgbI
        03QGQdTx6SqZJ9E+97p/TUHujCb4zmggelm/Epmv15CowTxDIsfUFxKV2DpJdKa0RoY6CrSo
        cOgbjuz2Wgq9PT1GIdPVZxiyDPWQqKvppgxNnrcBdN3ejKFqWz+Fyh3vMdR3qkKG+tteOf32
        DyTKeWaj0NkH4yQaezdArPfnrE+sJFdVXAW4oqz3BHexcAJwpU9HMM5SmSfjnt+qori6spPc
        XCvFPerOJbgLjyoBV/HgF8VNWhZvVexm1op6o0FYmqqXDOtUGhaFMGwUYkLCohg2NHJvdEi4
        Kki9NllITzssiEHqRCb19M9skOFYdvTerV4iC/QszgceckiHwY6B+8DFSrocwLaKRHffD15u
        bqDcvBDO9uTL8oGnM/MNwPH22n/CQpqDk60vgGvgQ7cDeNXehrkKnM7B4cj3u8CtZGGwoLQJ
        zwdyuYxmYGPlIZetoDfCueFa3MUEvQz+mBj9t86X3gnfjjwE7ow3fHNjmHCxB70aVheaSRfj
        dAQsrhvE3ewPe4dLMDcvgWfqi/CLQGmap5vmKaZ5immechsQlcBHMEraFK3EMhKvlYy6FCZJ
        r7UA579YW3/XNYIP5vgWQMuBaoFixa5pjZLkD0uZ2hYA5bjKR9EVM6NRKpL5zGOCqE8QjemC
        1ALCncddwgN8k/TO79MZEthwNhJFsZGhkaERSOWvsAdn7lbSKbxBOCgIGYL438PkHgFZIJty
        FDCdUWLg0KeJnDhN3GyMcr9O6zB7eXkf0ZVnXPIOt4Re+7OZbotXZ58Y3/Z5e2xHWeem3o+e
        eeei+wZjM76q9tnLDb2tti031Y8zj9N+IVfU1pcHpC/GOKufuIgsY44176sem1V3/6jfsWHH
        qSm+u2EPi03zMctRU0LJZRUhpfLsKlyU+L9PjejMRQMAAA==
X-CMS-MailID: 20181122104011eucas1p285f0f16ea8f06db366d95cc2f0a2acd4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de@eucas1p2.samsung.com>
        <1542823301-23563-3-git-send-email-l.luba@partner.samsung.com>
        <5BF619EE.8090006@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo Choi

On 11/22/18 3:52 AM, Chanwoo Choi wrote:
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
OK
> 
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 62 ++++++++++++++++++++++++++++-------------------
>>   1 file changed, 37 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index e20e7e4..cf9c643 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -285,6 +285,42 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>   	return 0;
>>   }
>>   
>> +static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>> +			      unsigned long *prev_freq, u32 flags)
> 
> Please remove the unused space in front of 'unsigned long *prev_freq'.
> Use tab only for indentation.
OK
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
>> +
>>   /* Load monitoring helper functions for governors use */
>>   
>>   /**
>> @@ -296,7 +332,6 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>    */
>>   int update_devfreq(struct devfreq *devfreq)
>>   {
>> -	struct devfreq_freqs freqs;
>>   	unsigned long freq, cur_freq, min_freq, max_freq;
> 
> 
> cur_freq is not used after modification. Remove it.
> 
>>   	int err = 0;
>>   	u32 flags = 0;
>> @@ -333,31 +368,8 @@ int update_devfreq(struct devfreq *devfreq)
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
>> +	return devfreq_set_target(devfreq, freq, &cur_freq, flags);
> 
> You get the 'cur_freq' from devfreq_set_taget() for devfreq_suspend_device() on patch3.
> But, update_devfreq() and devfreq_resume_device() don't use the 'cur_freq' value
> from devfreq_set_target().
> 
> Instead, getting 'cur_freq' for 'devfreq->resume_freq' in the devfreq_set_target().
> Please remove the 'cur_freq' parameter from devfreq_set_target.

I can remove the 3rd parameter from devfreq_set_target(),
but it implies that patch 1 and 3 cannot be merged. The function 
devfreq_set_target will use 'devfreq->resume_freq' so it must be in 
devfreq struct.
So, in v2 version there will be still 6 patches, with the 1st patch 
defining needed fields in devfreq struct.
Do you agree for that?

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
>>   }
>>   EXPORT_SYMBOL(update_devfreq);
>>   
>>
> 
> 

Regards,
Lukasz Luba
