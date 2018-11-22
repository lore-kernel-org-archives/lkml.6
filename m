Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67365C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1207A20866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dhtZJkmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1207A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394429AbeKVVjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:39:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39949 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390625AbeKVVjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:39:45 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181122110050euoutp0175d2099576870e88a46ad68f9c1b5846~pbTucwK0G1885018850euoutp01C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 11:00:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181122110050euoutp0175d2099576870e88a46ad68f9c1b5846~pbTucwK0G1885018850euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542884450;
        bh=Nj48rrtHiV7dYf9BCuD75n1lk7uhZY5XpLcyR+Ba1Nw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dhtZJkmo85ihHISqQyGliBX6gOE+zwl1wmm3GNHEToyuYxmxHOiA9dbkJnEmC0tHN
         jBSmUk5LuJOPBB71uNMLbcQpxlC5ZB4bvvyJCKeI4kTDos7IKDgCVjqKWusz9HWwXd
         KAnoXu5Kk9K2XNA4lBXUtfssc2s0hsQlalk/WPBw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181122110049eucas1p2b15fe7bfed83379b96cd285824d6beb6~pbTtbJ_QJ3220132201eucas1p2j;
        Thu, 22 Nov 2018 11:00:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 14.2C.04806.06C86FB5; Thu, 22
        Nov 2018 11:00:48 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181122110048eucas1p12bd36772dc68fa12ed0b3b6d5a972dc6~pbTsnc6cx2568325683eucas1p1w;
        Thu, 22 Nov 2018 11:00:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181122110047eusmtrp16d3e4985f66a27d6d6caf34adc084f32~pbTsWGfrn1183211832eusmtrp1S;
        Thu, 22 Nov 2018 11:00:47 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-1f-5bf68c603904
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4A.57.04284.F5C86FB5; Thu, 22
        Nov 2018 11:00:47 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181122110046eusmtip2976b735e57497c16839dfbf276da0b9e~pbTrfJJL_0241302413eusmtip2L;
        Thu, 22 Nov 2018 11:00:46 +0000 (GMT)
Subject: Re: [PATCH 3/6] devfreq: add support for suspend/resume of a
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
Message-ID: <cce4f194-b574-a12c-e876-f11a6f245940@partner.samsung.com>
Date:   Thu, 22 Nov 2018 12:00:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BF61B3A.9050402@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG/c7d0eK0Lr5opYyiG80koQ8KM7pw6Eb1R4QLatVpSW7qjmZX
        MsU0s+xG2rqsslC2lW1Ns+W01BxpOc0u0r20e0JkWUZYno6R//2e530evveFjyM1p5hQLt6c
        IlrMhgQto6LK63sCk1fndeunvHyrwzfKJmBXYSmNr7i6afzw61sa2+qaaJxZVMrg23tNOL/9
        I4kDgUssvpPxicXWIz4Cu9sf0LjVe4LBXfvqEC4MVBH4Qt1TFp9/2ELgx7tKGPy04WZfv/Eu
        jbN8dSze7fhM40/Nz6jYEKH8WjktOE85kXA8vYUSDuR/QUJR5XtCcNv3MEL1SScrXD63U+it
        ZwXP/WxK2O+xI6HE8Z0Vutyjl6jjVDPWiQnxm0RLZMxq1YYTzioyqTds86v9J5l0FBiei4I5
        4KPhhjsX5SIVp+FLENR6swlFfEVwuquHVEQXgvbXPvJfxXYm0J8qRtDkyuxPdSI4m7vvb2oo
        vxxKKn+w8mAY34igurqGkQXJZ5HQ+9nTJziO4XVQYU+WC2p+Hrx7Us3ITPFj4VWHA8k8nF8B
        Oc8djJIZAreOdVByNZifBFcPzZdtkg+BRx02QuFwyCw7/nch4F9w0HPVSitrz4G2bnc/D4UP
        fg+r8EhoPJxHKSzBnRw7o/B2yL5V0Z+ZDrX+Flp+l+QnQKk3UrFngf+xj5Vt4AdDW+cQZYXB
        cKi8gFRsNeTs1ijp8eDJayYUHgHFzqPsAaS1DrjLOuAY64BjrP/fPY0oOwoRUyWTUZSmmsU0
        nWQwSalmo25tosmN+n5tY6//WwWq+rWmBvEc0g5Sp+u/6TW0YZO0xVSDgCO1w9Sts7r1GvU6
        w5atoiVxlSU1QZRqUBhHaUPU24Je6DW80ZAibhTFJNHyb0pwwaHpaH3ajovfPcuLYhaWzQgf
        lUC9Gd/6IDJm8cwIndnuYmOXss+9v+/OvFcbN63gdWFGmnnkwQZXBXF+pTE5O3x2xjiubLRx
        e/27ptqf3psRk8cd7lzBttweE2EvGDvKFpQfNldYlhHkz2qIdTijrsO80Dkq4qJ4IUkVXRm/
        YL1tUXSVT0tJGwxRE0mLZPgDmaPpfrEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGe8/ZuRiujlPzzejCSuiiJzdvr1FWBHW6fEgMMaV06EElt9nO
        JhmUK1nWstTyQ03TyiRxpm06NfOSYkounRkWdCNLKlPBtMyoJOcI/PbwPM/vD394aFxiIXzp
        VJWW16gUaVJyscg+2/0uID53Oi6w2yBH7bYNyHKthkANlmkCvfz+mUClnX0Eyi6rIdHTi0qU
        93EURw7HfQr1nh2jkKmwBUPWjy8I9LypmERTlzoBuuZoxdC9zrcUKn/5DEOvz1SQ6G3P4zne
        PkAgQ0snhc6ZJwg01v9OtMOHq39YT3BVJVWAK9I/E3H5eZOAK2sewThr5QWSa7tRRXG1d7K4
        2S6KqxvMEXGX6yoBV2H+SXFT1lUHxbHsVo1ap+XXpKgF7TZpnAzJWVk4YuXB4awsKOzIFnmI
        dHPE1iQ+LTWD12yOSGBTiqta8fTZFSc+XL5B6oHD2wjcaMgEw9JbDswIFtMSphzAdvMtzBUs
        g1daGyiX9oR/XhhJV2kUwJ4pE3AGnkw0NOb+pZyBF2MHsNDRM38KZww4HBm/Pd+SMHoMFtn3
        GgFNkwwLGyuPO20xsxt+edNGOrWI8YMfhs3zdW8mBvaOVANXxwM+uT4scqJuzCb44Mo+p40z
        obCkdgh3aR/4argUc+nVMNtWhOcDiWkBbVqAmBYgpgXITSCqBF68TlAmKwUZKyiUgk6VzCaq
        lVYwN5f6rl+1jWDAEtUBGBpI3cXrD/+IkxCKDCFT2QEgjUu9xM93TsdJxEmKzJO8Rh2v0aXx
        QgcImfutAPf1TlTPjU+ljZeFyMJQuCwsKCwoFEl9xI7AzFgJk6zQ8sd4Pp3X/Ocw2s1XD7Jy
        A/sSTx1VljYYtjV9S99u0wYNXpjyuzrDfm03WCej0ko+tdqa1y0yue9fi1j334VLp1P0N4mA
        horxla+h6ZHNf0w87D1UPWgcS8jcs+R0wSvV+6WCzn7eEnlWnT9Lx/b7ZO+LfnJoedIAYfM4
        4BvjP75ryDyRG5kgv4vlzGRJRUKKQrYR1wiKf+JY9LhEAwAA
X-CMS-MailID: 20181122110048eucas1p12bd36772dc68fa12ed0b3b6d5a972dc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180204eucas1p1c5891d498aa59c0e10dd3ba4727a4382@eucas1p1.samsung.com>
        <1542823301-23563-4-git-send-email-l.luba@partner.samsung.com>
        <5BF61B3A.9050402@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/22/18 3:58 AM, Chanwoo Choi wrote:
> On 2018년 11월 22일 03:01, Lukasz Luba wrote:
>> The patch adds support for handling suspend/resume process.
>> It uses atomic variables to make sure no race condition
>> affects the process.
>>
>> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>> solve issue with devfreq device's frequency during suspend/resume.
>> During the discussion on LKML some corner cases and comments appeared
>> related to the design. This patch address them keeping in mind suggestions
>> from Chanwoo Choi.
> 
> Please remove the duplicate information about patch history.
> 
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c | 45 +++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 39 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index cf9c643..7e09de8 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -872,14 +872,33 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
>>    */
>>   int devfreq_suspend_device(struct devfreq *devfreq)
>>   {
>> -	if (!devfreq)
>> -		return -EINVAL;
>> +        int ret;
> 
> Move 'ret' definition under 'if (devfreq->suspend_freq) {'
> because 'ret' is used if suspend_freq isn't zero.
Not only there, 6 lines above 'ret' is used for 
devfreq->governor->event_handler().
> 
>> +        unsigned long prev_freq;
>> +        u32 flags = 0;
>> +
>> +        if (!devfreq)
>> +                return -EINVAL;
>> +
>> +        if (devfreq->governor) {
>> +		ret = devfreq->governor->event_handler(devfreq,
>> +					DEVFREQ_GOV_SUSPEND, NULL);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>> -	if (!devfreq->governor)
>> -		return 0;
>> +	if (devfreq->suspend_freq) {
>> +		if (atomic_inc_return(&devfreq->suspend_count) > 1)
>> +			return 0;
>>   
>> -	return devfreq->governor->event_handler(devfreq,
>> -				DEVFREQ_GOV_SUSPEND, NULL);
>> +		ret = devfreq_set_target(devfreq, devfreq->suspend_freq,
>> +					 &prev_freq, flags);
> 
> Remove the 'prev_freq' parameter.
OK
> 
>> +		if (ret)
>> +			return ret;
>> +
>> +		devfreq->resume_freq = prev_freq;
> 
> As I commented on patch2, if devfreq_set_taget save the current frequency
> to 'devfreq->resume_freq', this line is not needed.
OK
> 
> 
>> +	}
>> +
>> +        return 0;
>>   }
>>   EXPORT_SYMBOL(devfreq_suspend_device);
>>   
>> @@ -893,9 +912,23 @@ EXPORT_SYMBOL(devfreq_suspend_device);
>>    */
>>   int devfreq_resume_device(struct devfreq *devfreq)
>>   {
>> +        int ret;
> 
> Move 'ret' definition under 'if (devfreq->suspend_freq) {'
> because 'ret' is used if suspend_freq isn't zero.
OK
> 
>> +        unsigned long prev_freq;
> 
> Remove prev_freq variable which is not used on this function.
> After calling devfreq_set_target, prev_freq is not used.
OK
> 
>> +        u32 flags = 0;
>> +
>>   	if (!devfreq)
>>   		return -EINVAL;
>>   
>> +	if (devfreq->suspend_freq) {
>> +		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
>> +			return 0;
>> +
>> +		ret = devfreq_set_target(devfreq, devfreq->resume_freq,
>> +					 &prev_freq, flags);
> 
> Remove the 'prev_freq' parameter.
OK
> 
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	if (!devfreq->governor)
>>   		return 0;
>>   
>>
> 
> 

Regards,
Lukasz Luba
