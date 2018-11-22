Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42203C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94E320820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 23:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gq6MBAHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94E320820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439171AbeKWK1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 05:27:45 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:49608 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439142AbeKWK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 05:27:45 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181122234553epoutp04e128c5856ea9d4974fe4b91563621c4c~plvtSM2qj2977329773epoutp04E;
        Thu, 22 Nov 2018 23:45:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181122234553epoutp04e128c5856ea9d4974fe4b91563621c4c~plvtSM2qj2977329773epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542930353;
        bh=F+3mGxjIb4XQZtUy+e5aQ2iQC8gPKy4QoUGyK44FgHI=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=gq6MBAHKCkE6XKxXpD3wg2XA3FnJ2UKIHNKqf0Mf24FFA64jrBEq8RD3SEq50H2qH
         wWT1/O3BgoNhfj2kw2QdXRty/dLcEmZIweAh/bre0W01CxpSOny2of9WfRP/mDM8Jd
         8P6NZ+ZmIGjgZJAON8L7Kdd+MX4kfa9QHd6bERgs=
Received: from epsmges2p2.samsung.com (unknown [182.195.40.155]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181122234546epcas1p261ba264ece32d83db61ffb663c228a66~plvmwOOY52375923759epcas1p2F;
        Thu, 22 Nov 2018 23:45:46 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.40.04060.AAF37FB5; Fri, 23 Nov 2018 08:45:46 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181122234546epcas2p3cd9fa3d5028f1d02bea4e150dfe49980~plvmVig1H2149821498epcas2p3S;
        Thu, 22 Nov 2018 23:45:46 +0000 (GMT)
X-AuditID: b6c32a46-b45ff70000000fdc-23-5bf73faa769a
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.E2.03627.9AF37FB5; Fri, 23 Nov 2018 08:45:45 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PIM00GDDCO9WG40@mmp1.samsung.com>; Fri, 23 Nov 2018 08:45:45 +0900 (KST)
Message-id: <5BF73FA9.7010402@samsung.com>
Date:   Fri, 23 Nov 2018 08:45:45 +0900
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
In-reply-to: <9eef3348-e86f-1113-3691-39ba3a620fb8@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xTVxTHve9nMSt7e4LewRR82xJhgfXHOm+JOI3KXjYScYvRjcXuSV+g
        6c/0FTNNlnU4BFk2cNZE65w6f2HFaGvtFKgodBiZo4oBpwsshuiYwtYIUpYNXNsXM/4793s+
        59x7vvdeBc6OUVkKk80lOm2ChaPmEqGuPFTgeyterupvfRFdOZ+H/HvPkOgH/ySJDkZ6SbT9
        yBkKXf/SihqHH+EoGj1Lo59rRml01/0S8nrCGAoMD5DoVuu3FBr/KgLQ3uglDJ2ODNLo2O2b
        GPr182YKDfb8mOjxUx+JasMRGu04FSPR6I0hYsUCPtQWIvmW71oAv999k+CbGh8D/kj7Hxgf
        8O2k+I4DLTR/7uhn/Ew3zV/5sx3jg/11BP910Af45lNxmh8PLCpL/9C8rEoUjKIzV7RV2I0m
        W2Ux9+77hlUG3ZsqdYFaj5ZyuTbBKhZzq0vLCkpMlsT4XO4WwVKdkMoESeJeX77Maa92iblV
        dslVzIkOo8WhdxRKglWqtlUWVtitRWqVSqNLgB+bq9qe3icdX7z2yUjry27wlGsAaQrIvAE9
        f9VgDWCugmUuADj8pIdMJlgmDuC96eXPoPq+k5QMtQG47/gTIplQMi/Aqd1DiVihwJkcGOkz
        J2WcyYMjE98Qcp9BAPuG3pHxfFh/5zcqGRPMq3DC5wXJmEroHSO/pPTnmcWwf2o4pWcyG+HF
        g5N0ct8MJgpgy8X21ElxphaHM7FgqmIew8Px7supijTmbRg5vI9IQpCZpmFde4xKng4yq6En
        Pl+eZh58eDVIy3E2fODzA5mvA3BiZDspL5oAjPWcw2RKCx8cbsDk2dJhfdc0LTdVwvodrIzw
        cM8/vbRsURiD3Y3NeBNY6J3lkvd/l7yzXDoEcB+YLzoka6UoaRya2bcXAKmnnl9yARztLe0E
        jAJwzynP+ifLWVLYIm21dgKowLkMZc3ieDmrNApbt4lOu8FZbRGlTqBLuLwLz8qssCc+js1l
        UOs0Wq0W6ZbqtSo9t0B5L/tAOctUCi7RLIoO0fmsDlOkZbnBsaGxSDTmkVZ6My5zA5eotWs3
        fHRNDXcXoq5t99+7O2dlgH20iT2J39D/y+wqCk35iXGz5lPTtTXrwydub6htJm6VrlvnGThR
        8sGaDlPx31eDNkPRzKrNvy/ambk/vOKOPnTIuTB9c3bh8dCeOQ9HjV73ksc5KltP2pKxnI5X
        Nn1/nSOkKkGdjzsl4T8wA6vbAAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t9jAd2V9t+jDR6vs7E4uFXTYuOM9awW
        2zd+Y7WYf+Qcq0Xz4vVsFme6cy36H79mtjh/fgO7xdmmN+wWtxpkLGZN2ctksenxNVaLy7vm
        sFl87j3CaDHj/D4mi7VH7rJbLL1+kcniduMKNou7p44CzTh9idWide8Rdou21R9YLd5cuMfi
        IO6xbfc2Vo8189YwesxuuMjiMaH/E6PH4j0vmTw2repk89g/dw27x+Yl9R7/jrF7HHy3h8lj
        y9V2Fo++LasYPVas/s7u8XmTXABfFJdNSmpOZllqkb5dAlfG7v9PWQtatCte7FJuYPyv1MXI
        ySEhYCLRcWklWxcjF4eQwE5GiZWz3jKCJHgFBCV+TL7H0sXIwcEsIC9x5FI2hKkuMWVKLkT5
        fUaJ6/s62CDKtSQ6bt4Hs1kEVCW+rJoFNoYNKL7/xQ2wOL+AosTVH48ZQeaICkRIdJ+oBJkj
        InCeUeJgXycrSA2zQCuzxKO2LBBbWMBD4vOxA4wQy/YySXx9epsFJMEp4C5xZOFMlgmMArOQ
        nDoL4dRZCKcuYGRexSiZWlCcm55bbFRglJdarlecmFtcmpeul5yfu4kRGNfbDmv172B8vCT+
        EKMAB6MSD++Gjd+ihVgTy4orcw8xSnAwK4nwNil+jxbiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        y59/LFJIID2xJDU7NbUgtQgmy8TBKdXAmNe2b5u4u8TBb/+79+YE2dfdu/H+zvtnnBePH0ve
        crt8KmvJrdeNr1nK2l6e03xsd2qLYmXNjw1GdQH/pz7ffOWw/u4I4U/vpP9ePfh9s/Hljx9m
        pmQGFfz+lND2I+CR/fWgYJ7Akv/sjddCjlnI+swNcb3OU6jnZj4jVz7oeeicK6U5In8CHJRY
        ijMSDbWYi4oTAbumkCnnAgAA
X-CMS-MailID: 20181122234546epcas2p3cd9fa3d5028f1d02bea4e150dfe49980
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de@eucas1p2.samsung.com>
        <1542823301-23563-3-git-send-email-l.luba@partner.samsung.com>
        <5BF619EE.8090006@samsung.com>
        <9eef3348-e86f-1113-3691-39ba3a620fb8@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 2018년 11월 22일 19:40, Lukasz Luba wrote:
> Hi Chanwoo Choi
> 
> On 11/22/18 3:52 AM, Chanwoo Choi wrote:
>> On 2018년 11월 22일 03:01, Lukasz Luba wrote:
>>> The refactoring is needed for the new client in devfreq: suspend.
>>> To avoid code duplication, move it to the new local function
>>> devfreq_set_target.
>>>
>>> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>>> solve issue with devfreq device's frequency during suspend/resume.
>>> During the discussion on LKML some corner cases and comments appeared
>>> related to the design. This patch address them keeping in mind suggestions
>>> from Chanwoo Choi.
>>
>> As I commented on patch1, please remove it.
> OK
>>
>>>
>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   drivers/devfreq/devfreq.c | 62 ++++++++++++++++++++++++++++-------------------
>>>   1 file changed, 37 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index e20e7e4..cf9c643 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -285,6 +285,42 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>>   	return 0;
>>>   }
>>>   
>>> +static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>>> +			      unsigned long *prev_freq, u32 flags)
>>
>> Please remove the unused space in front of 'unsigned long *prev_freq'.
>> Use tab only for indentation.
> OK
>>
>>> +{
>>> +	struct devfreq_freqs freqs;
>>> +	unsigned long cur_freq;
>>> +	int err = 0;
>>> +
>>> +	if (devfreq->profile->get_cur_freq)
>>> +		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
>>> +	else
>>> +		cur_freq = devfreq->previous_freq;
>>> +
>>> +	freqs.old = cur_freq;
>>> +	freqs.new = new_freq;
>>> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
>>> +
>>> +	err = devfreq->profile->target(devfreq->dev.parent, &new_freq, flags);
>>> +	if (err) {
>>> +		freqs.new = cur_freq;
>>> +		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>> +		return err;
>>> +	}
>>> +
>>> +	freqs.new = new_freq;
>>> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>> +
>>> +	if (devfreq_update_status(devfreq, new_freq))
>>> +		dev_err(&devfreq->dev,
>>> +			"Couldn't update frequency transition information.\n");
>>> +
>>> +	devfreq->previous_freq = new_freq;
>>> +	*prev_freq = cur_freq;
>>> +
>>> +	return err;
>>> +}
>>> +
>>>   /* Load monitoring helper functions for governors use */
>>>   
>>>   /**
>>> @@ -296,7 +332,6 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>>    */
>>>   int update_devfreq(struct devfreq *devfreq)
>>>   {
>>> -	struct devfreq_freqs freqs;
>>>   	unsigned long freq, cur_freq, min_freq, max_freq;
>>
>>
>> cur_freq is not used after modification. Remove it.
>>
>>>   	int err = 0;
>>>   	u32 flags = 0;
>>> @@ -333,31 +368,8 @@ int update_devfreq(struct devfreq *devfreq)
>>>   		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>>>   	}
>>>   
>>> -	if (devfreq->profile->get_cur_freq)
>>> -		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
>>> -	else
>>> -		cur_freq = devfreq->previous_freq;
>>> -
>>> -	freqs.old = cur_freq;
>>> -	freqs.new = freq;
>>> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
>>> +	return devfreq_set_target(devfreq, freq, &cur_freq, flags);
>>
>> You get the 'cur_freq' from devfreq_set_taget() for devfreq_suspend_device() on patch3.
>> But, update_devfreq() and devfreq_resume_device() don't use the 'cur_freq' value
>> from devfreq_set_target().
>>
>> Instead, getting 'cur_freq' for 'devfreq->resume_freq' in the devfreq_set_target().
>> Please remove the 'cur_freq' parameter from devfreq_set_target.
> 
> I can remove the 3rd parameter from devfreq_set_target(),
> but it implies that patch 1 and 3 cannot be merged. The function 
> devfreq_set_target will use 'devfreq->resume_freq' so it must be in 
> devfreq struct.
> So, in v2 version there will be still 6 patches, with the 1st patch 
> defining needed fields in devfreq struct.
> Do you agree for that?

So, I replied again as following on my other reply[1] of patch2: 
[1] https://lkml.org/lkml/2018/11/22/507

But, you have to add following new code on patch3 instead of patch2.
patch2 doesn't contain the following codes and then
patch3 adds 'resume_freq' variable and adds the following code on patch3.

+
+       if (devfreq->suspend_freq)
+               devfreq->resume_freq = cur_freq;

> 
>>
>>>   
>>> -	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
>>> -	if (err) {
>>> -		freqs.new = cur_freq;
>>> -		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>> -		return err;
>>> -	}
>>> -
>>> -	freqs.new = freq;
>>> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>> -
>>> -	if (devfreq_update_status(devfreq, freq))
>>> -		dev_err(&devfreq->dev,
>>> -			"Couldn't update frequency transition information.\n");
>>> -
>>> -	devfreq->previous_freq = freq;
>>> -	return err;
>>>   }
>>>   EXPORT_SYMBOL(update_devfreq);
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
