Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51671C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA3120861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cSIFH9VJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA3120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503073AbeKWUmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:42:16 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51186 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbeKWUmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:42:16 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181123095840euoutp02b8d86e19b2c433fbb75ceb02c3fc7cc0~puGuwTMXo2249322493euoutp02L
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 09:58:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181123095840euoutp02b8d86e19b2c433fbb75ceb02c3fc7cc0~puGuwTMXo2249322493euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542967120;
        bh=/Y2i6DyUJOtYxmsGGE4Uogj5xLOa8prowwyheV0KOWY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cSIFH9VJBO+VhR811LR1H0bnKsB/dSJN/16aOPp+nXZZBH3TXLszR7pzzrpWKWcrY
         RXXaqkVT9yEbTu9YP245UZGOGDWd25hv7Tq3QwSSeoLQGahIfgRqc3wAd85xpj1pEm
         yq33pKSUe+i3crlwCiAAsGxbKyZOWeA6N4KF8U74=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181123095839eucas1p181a1b49641e060ff00b4784365bb564e~puGt2eWcq0146201462eucas1p1F;
        Fri, 23 Nov 2018 09:58:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 49.FE.04294.E4FC7FB5; Fri, 23
        Nov 2018 09:58:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181123095837eucas1p277a3b6c61a3bbbaf3a214ec51897b977~puGs1Dsaf1679816798eucas1p29;
        Fri, 23 Nov 2018 09:58:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181123095837eusmtrp226493a36f74ff76efe9fae044eb846e9~puGsgrFH60360303603eusmtrp2X;
        Fri, 23 Nov 2018 09:58:37 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-6d-5bf7cf4e830b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BD.AA.04284.D4FC7FB5; Fri, 23
        Nov 2018 09:58:37 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181123095836eusmtip20a122b84852c12f3159244d60b63d51c~puGrphNhC2095920959eusmtip2I;
        Fri, 23 Nov 2018 09:58:36 +0000 (GMT)
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
Message-ID: <1c3a4aad-99cb-9295-3a5e-ff7a3c5245a3@partner.samsung.com>
Date:   Fri, 23 Nov 2018 10:58:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BF73FA9.7010402@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRztu2+lxdey/GXvlZSJZlH0URG9ufSH9FdEBrnytkJntZuVGWSK
        NU1No8fctKKSZFo+mo+WqZkparY0lr2sIEFKB0NlIpXl5Rr53znndw7nO/AJtDafCxKOxJ+Q
        TPH6OB3nz1Q1j7rCIl0jURGFd0LJs8oQUm4pZUl1uY8l3cN9LLnV9IolqXdLOfLykpFc/tZP
        E5erjCcdKQM8sV59SpGKb29Z8saZz5GhrCZELK46ijxo6uFJYXcnRT6eL+JIT9uL8Xx7F0vS
        njbx5EKxlyUDrz8zmwLFqidVrFhyswSJtuRORsy5PIjEu7XfKbHCns6J9QUlvPjo3jlxrJkX
        He6LjJjtsCOxqHiEF4cq5u/S7PXfECPFHTkpmVZsjPY/nJ615lhG2Gmn10wlI/eSDOQnAF4N
        /XmfGAVrcRGC7kLIQP7jeBiBL8XHq2QIwdeyLuZfosDtYdTDfQS/772iVOJBMHjlIae4ZmAR
        hpobkHIIwO0I6usbOYXQOI2GMa9jnAgCh8Ohxn5cCWjwDmi1e1gFMzgYqttrkYJn4j1g/lLM
        qZ7p0JrXyyhRPxwK5/toRaZxIHzovUWpeAGkVtpopQrwJwFSGzo59dnboO6Gd2LCDPjR4uBV
        PBf+PFbDgGXoMNsn/GfhYmvNhGc9PG/pZJVeGodAqXOFKm+G3DflvCIDngbvPNPVJ0yDK1U3
        aFXWgPmCVnUvA0fm64miWXC/5Dqfg3TWSbusk8ZYJ42x/u+9jRg7CpQSZKNBklfFS6fCZb1R
        Tog3hB88aqxA43+2faxluAY5fx1oRFhAuqmasnJflJbVn5QTjY0IBFoXoElZNBKl1cToE89I
        pqP7TQlxktyI5giMLlCTNOVrlBYb9CekWEk6Jpn+XSnBLygZZUZcS7Iseb8yN7cy/WH17La8
        6EPVs7d0WZzp868P/8oRssKctY+3btXjjdmbbev63bd9usVzbR7vdjGUyd60NPNOTgfl7pIX
        Ba+ve5fVbPHNCumzJcwbjFy4O8nc1kvvS/yxIGggeefnPz8Nazt6yqSIBnvGnNhY7/dRQ9/A
        mdwwHSMf1q9cTptk/V/Hb8tlrwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+5/LzlEanKblP4myUdEFjx51+rfsQnQ5YpFgoShhQ08abc52
        tsy+5CWtNNPCDzazq4LMlW7eu2jOpXippaFSoRAK4q1EQxNM2lqB3573fZ4fLy88NC4zk970
        hRSdoE1RquQSd6JnpXPE96R9Mc6/LN8HtdXvQuaSahI1mhdINPRznESPbB9IlP2sWoJ689Wo
        cHQKR3Z7DYXeZ01TyFD8BkOW0UESfXr5QILmC2wAldhbMPTcNkyhiqE+DH3NrJSg4e53Dr6n
        n0Q5b2wUyq2aJdH0xxHikBff8KqB5E0PTYAvzegj+KLCOcA/ez2B8RbjLQnfWmai+Nrya/xK
        B8XXDdwg+Dt1RsBXVi1S/Lxlc6Q0lg3TavQ6wSdZI+r2y+M4FMByoYgNCAplucCQs3sDFHK/
        A2GJgurCZUHrd+Acm3yrQJGa53vl5exNLAMMbMsDbjRkgmDZwAyRB9xpGVMBYG/7JOkyNsB7
        LY2US3vA5cE8iSs0BWDm72HMaXgwPJzveAuchifTA2CxvRtzDjiTg8OJmafAhYxgcL570nGE
        piUMC5uMl5y0lDkGu4wzf88RzHbY2PMaOPV6Jga+n3gBXJl1sOv+2F/UjdkDM8dx5xpnguHD
        2m//tBf8MvYIc+ktMLu+FC8CMsMq2rAKMaxCDKuQx4AwAk9BL6qT1CLHikq1qE9JYhM0agtw
        1KWhY6m2CfSbo6yAoYF8rbTGvBAnI5WXxXS1FUAal3tKs7Yuxsmkicr0q4JWE6/VqwTRChSO
        3+7i3usTNI7ypejiOQUXgkK5kMCQwGAk95La/dNjZUySUidcFIRUQfufw2g37wyQewcfP11U
        80OqasMLogyE5OS6sZigiPDC4snw1ujzn5upLUd9dJbtmzT6qMgnTVFzC7Yd8ftOkLbbplOk
        KVWlaG//fngY2//4CPcrM/xM/kL5mtIma0StqoSIzt5YXVF17HtXzHJqwvH4rmyr9non2Wzb
        GbHUz6YFRqQdxNZY5ISYrOR241pR+QeRt0XsRAMAAA==
X-CMS-MailID: 20181123095837eucas1p277a3b6c61a3bbbaf3a214ec51897b977
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
        <9eef3348-e86f-1113-3691-39ba3a620fb8@partner.samsung.com>
        <5BF73FA9.7010402@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo Choi,

On 11/23/18 12:45 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 2018년 11월 22일 19:40, Lukasz Luba wrote:
>> Hi Chanwoo Choi
>>
>> On 11/22/18 3:52 AM, Chanwoo Choi wrote:
>>> On 2018년 11월 22일 03:01, Lukasz Luba wrote:
>>>> The refactoring is needed for the new client in devfreq: suspend.
>>>> To avoid code duplication, move it to the new local function
>>>> devfreq_set_target.
>>>>
>>>> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>>>> solve issue with devfreq device's frequency during suspend/resume.
>>>> During the discussion on LKML some corner cases and comments appeared
>>>> related to the design. This patch address them keeping in mind suggestions
>>>> from Chanwoo Choi.
>>>
>>> As I commented on patch1, please remove it.
>> OK
>>>
>>>>
>>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>>> ---
>>>>    drivers/devfreq/devfreq.c | 62 ++++++++++++++++++++++++++++-------------------
>>>>    1 file changed, 37 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>>> index e20e7e4..cf9c643 100644
>>>> --- a/drivers/devfreq/devfreq.c
>>>> +++ b/drivers/devfreq/devfreq.c
>>>> @@ -285,6 +285,42 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>>>> +			      unsigned long *prev_freq, u32 flags)
>>>
>>> Please remove the unused space in front of 'unsigned long *prev_freq'.
>>> Use tab only for indentation.
>> OK
>>>
>>>> +{
>>>> +	struct devfreq_freqs freqs;
>>>> +	unsigned long cur_freq;
>>>> +	int err = 0;
>>>> +
>>>> +	if (devfreq->profile->get_cur_freq)
>>>> +		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
>>>> +	else
>>>> +		cur_freq = devfreq->previous_freq;
>>>> +
>>>> +	freqs.old = cur_freq;
>>>> +	freqs.new = new_freq;
>>>> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
>>>> +
>>>> +	err = devfreq->profile->target(devfreq->dev.parent, &new_freq, flags);
>>>> +	if (err) {
>>>> +		freqs.new = cur_freq;
>>>> +		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>>> +		return err;
>>>> +	}
>>>> +
>>>> +	freqs.new = new_freq;
>>>> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>>> +
>>>> +	if (devfreq_update_status(devfreq, new_freq))
>>>> +		dev_err(&devfreq->dev,
>>>> +			"Couldn't update frequency transition information.\n");
>>>> +
>>>> +	devfreq->previous_freq = new_freq;
>>>> +	*prev_freq = cur_freq;
>>>> +
>>>> +	return err;
>>>> +}
>>>> +
>>>>    /* Load monitoring helper functions for governors use */
>>>>    
>>>>    /**
>>>> @@ -296,7 +332,6 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>>>>     */
>>>>    int update_devfreq(struct devfreq *devfreq)
>>>>    {
>>>> -	struct devfreq_freqs freqs;
>>>>    	unsigned long freq, cur_freq, min_freq, max_freq;
>>>
>>>
>>> cur_freq is not used after modification. Remove it.
>>>
>>>>    	int err = 0;
>>>>    	u32 flags = 0;
>>>> @@ -333,31 +368,8 @@ int update_devfreq(struct devfreq *devfreq)
>>>>    		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>>>>    	}
>>>>    
>>>> -	if (devfreq->profile->get_cur_freq)
>>>> -		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
>>>> -	else
>>>> -		cur_freq = devfreq->previous_freq;
>>>> -
>>>> -	freqs.old = cur_freq;
>>>> -	freqs.new = freq;
>>>> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
>>>> +	return devfreq_set_target(devfreq, freq, &cur_freq, flags);
>>>
>>> You get the 'cur_freq' from devfreq_set_taget() for devfreq_suspend_device() on patch3.
>>> But, update_devfreq() and devfreq_resume_device() don't use the 'cur_freq' value
>>> from devfreq_set_target().
>>>
>>> Instead, getting 'cur_freq' for 'devfreq->resume_freq' in the devfreq_set_target().
>>> Please remove the 'cur_freq' parameter from devfreq_set_target.
>>
>> I can remove the 3rd parameter from devfreq_set_target(),
>> but it implies that patch 1 and 3 cannot be merged. The function
>> devfreq_set_target will use 'devfreq->resume_freq' so it must be in
>> devfreq struct.
>> So, in v2 version there will be still 6 patches, with the 1st patch
>> defining needed fields in devfreq struct.
>> Do you agree for that?
> 
> So, I replied again as following on my other reply[1] of patch2:
> [1] https://lkml.org/lkml/2018/11/22/507
> 
> But, you have to add following new code on patch3 instead of patch2.
> patch2 doesn't contain the following codes and then
> patch3 adds 'resume_freq' variable and adds the following code on patch3.
> 
> +
> +       if (devfreq->suspend_freq)
> +               devfreq->resume_freq = cur_freq;
> 
OK, I will add that change to patch 3.

Regards,
Lukasz
>>
>>>
>>>>    
>>>> -	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
>>>> -	if (err) {
>>>> -		freqs.new = cur_freq;
>>>> -		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>>> -		return err;
>>>> -	}
>>>> -
>>>> -	freqs.new = freq;
>>>> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
>>>> -
>>>> -	if (devfreq_update_status(devfreq, freq))
>>>> -		dev_err(&devfreq->dev,
>>>> -			"Couldn't update frequency transition information.\n");
>>>> -
>>>> -	devfreq->previous_freq = freq;
>>>> -	return err;
>>>>    }
>>>>    EXPORT_SYMBOL(update_devfreq);
>>>>    
>>>>
>>>
>>>
>>
>> Regards,
>> Lukasz Luba
>>
>>
> 
> 

