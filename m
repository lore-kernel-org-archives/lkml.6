Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13D9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191BE2150C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C50/HExc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191BE2150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbeJJQEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:04:08 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36523 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeJJQEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:04:08 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181010084259euoutp014be368fe787c7036a69ab9cb9870377c~cMsGBR0531053310533euoutp01f
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 08:42:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181010084259euoutp014be368fe787c7036a69ab9cb9870377c~cMsGBR0531053310533euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539160979;
        bh=KlFkt7dTLXaeSc8garkH/TfQXcTY7GsT+0MCoSf166k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=C50/HExcxixVn4ha99eVSL1U2ly1VbqYzfPxEZaQ3nUeP78CbXSdbyjd9fYx3+9Sj
         dLlkbvtZ8GKauLs6a30mvFdiFpxD8HWxZre2xkEkHe3DkrZGmyYjbXHGZ8YVXt1Y1F
         dqv7Oa2zGmnxI5E7Xx9bquShTmTGCQeZoJittd8I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181010084258eucas1p27caa344493563f5b1e90d2b99e70c10d~cMsFi_pmA1087710877eucas1p2g;
        Wed, 10 Oct 2018 08:42:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8D.35.04294.29BBDBB5; Wed, 10
        Oct 2018 09:42:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181010084257eucas1p14a7e3c9e7931e7151f9ea5e8ae415dc0~cMsEsFmFC0910909109eucas1p1h;
        Wed, 10 Oct 2018 08:42:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181010084257eusmtrp2994039e8346b412781422e676831e2da~cMsEbE5qi3174331743eusmtrp2S;
        Wed, 10 Oct 2018 08:42:57 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-32-5bbdbb926bd9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5E.1C.04284.19BBDBB5; Wed, 10
        Oct 2018 09:42:57 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181010084257eusmtip234b4ed6e0b573b128234e91ab8142fc2~cMsELrkiD1230912309eusmtip2H;
        Wed, 10 Oct 2018 08:42:57 +0000 (GMT)
Subject: Re: [PATCH] lib/Kconfig.debug: add a comment to PROVE_LOCKING
 impact
To:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, mingo@redhat.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Wed, 10 Oct 2018 10:42:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c328b3c5-ef09-5cf7-80f5-4b6a8cc9a553@redhat.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduznOd1Ju/dGG6zcomCxccZ6VovLu+aw
        WZw+doLF4tKBBUwOLB7v911l8+jbsorR4/MmuQDmKC6blNSczLLUIn27BK6Mxve/mAtOi1Ys
        bGtia2DsEuxi5OSQEDCRWH3iLHsXIxeHkMAKRonHh38xQjhfGCXaL/9nhnA+M0osez6bDaZl
        4c09UFXLGSWmvdjJAuG8ZZR4t3w/O0iVsIC/xOzjP1lBbBEBJ4lX0yYAFXFwMAvoSfy5oQJi
        sgGZO1YVglSwCKhKLFjxEqxTVCBC4siDhYwgNq+AoMTJmU9YQGxOATuJbWefgtnMAuISt57M
        Z4Kw5SW2v50DdqiEQDe7xJEZLawQzWUSfY33WCGOdpE48PctE4QtLPHq+BZ2CFtG4v/O+VDx
        YomzHaugnqyRaD+5A6rGWuLw8YusEOdrSqzfpQ8RdpTY8OcVI0hYQoBP4sZbQYhz+CQmbZvO
        DBHmlehoE4Ko1pDY0nMBapGYxPI109gnMCrNQvLkLCSPzULy2CyEvQsYWVYxiqeWFuempxYb
        5aWW6xUn5haX5qXrJefnbmIEJpPT/45/2cG460/SIUYBDkYlHt6GC3uihVgTy4orcw8xSnAw
        K4nw7n4IFOJNSaysSi3Kjy8qzUktPsQozcGiJM67bN7GaCGB9MSS1OzU1ILUIpgsEwenVAPj
        pKCij/yqQkoFZ+ZM2HInJ2OR5v8rJU65r/LyOb7JGU05sqGWZftjvT1n5T6u6n2QlFy0tTmx
        0ajrO//vWFHNq4fLSped2nzv8ErOCLbt9ybv3b3KkcGnba9HV/AJk7bFV5XPHP1sJSe90XIt
        /1KfY/eVZ5fOlZJ4lRJ+xsDl2sTY4i8FsoVPlViKMxINtZiLihMB58XeEiIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7oTd++NNljbpWyxccZ6VovLu+aw
        WZw+doLF4tKBBUwOLB7v911l8+jbsorR4/MmuQDmKD2bovzSklSFjPziElulaEMLIz1DSws9
        IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mxve/mAtOi1YsbGtia2DsEuxi5OSQEDCRWHhz
        D2MXIxeHkMBSRonJvUdZIBJiEpP2bWeHsIUl/lzrYgOxhQReM0p0zJIDsYUFfCUmbWhhBbFF
        BJwkXk2bANTLwcEsoCfx54YKxMx/jBKzF75kA4mzAcV3rCoEKecVcJM4fGA62EgWAVWJBSte
        gq0SFYiQWL38BStEjaDEyZlPwM7hFLCT2Hb2KZjNLGAmMW/zQ2YIW1zi1pP5TBC2vMT2t3OY
        JzAKzULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGD/bjv3cvIPx
        0sbgQ4wCHIxKPLwNF/ZEC7EmlhVX5h5ilOBgVhLh3f0QKMSbklhZlVqUH19UmpNafIjRFOi5
        icxSosn5wNjOK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTTx8TBKdXAKKoT
        pvDg3+JDnybcUeY1fnLh/rtFn5YbPJJ5knk4zyL6pHn/Xp/4fX4MbmGLNvIrRJgqzRdqunf+
        3kdFOUPDhVVCWl8NVgo8mm+SKyjOqbJRlqf+45H9p+oYz/nedKm6d2KVmLAla/ND4dVXlH/0
        2bE4HAr8tm7l0z4vhtaZTby6s/5O4p+xX4mlOCPRUIu5qDgRAIKiTmi1AgAA
Message-Id: <20181010084257eucas1p14a7e3c9e7931e7151f9ea5e8ae415dc0~cMsEsFmFC0910909109eucas1p1h@eucas1p1.samsung.com>
X-CMS-MailID: 20181010084257eucas1p14a7e3c9e7931e7151f9ea5e8ae415dc0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41
References: <CGME20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41@eucas1p1.samsung.com>
        <20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41~b_u5xrZ3z3130331303eucas1p1U@eucas1p1.samsung.com>
        <c328b3c5-ef09-5cf7-80f5-4b6a8cc9a553@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Longman,

Thanks for the patches. I have applied them and run on ARM.
In context switch test, there is ~2% improvement
(but still ~15us instead of 5-6us).
In dhrystone: test results are the same.
There is also 2% improvement in boot time.

You can add me on CC list if you have some patches related to
this feature. I will give it a try on arm platforms.

Regards,
Lukasz

On 10/09/2018 07:29 PM, Waiman Long wrote:
> On 10/09/2018 11:39 AM, Lukasz Luba wrote:
>> This patch add some comment related to performance impact,
>> which can be really big (x3 times slower context switch).
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   lib/Kconfig.debug | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 4966c4f..9e67a2a3 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1088,6 +1088,9 @@ config PROVE_LOCKING
>>   	 the proof of observed correctness is also maintained for an
>>   	 arbitrary combination of these separate locking variants.
>>   
>> +	 This feature enables LOCKDEP which can harm system performance
>> +	 even x3 times.
>> +
>>   	 For more details, see Documentation/locking/lockdep-design.txt.
>>   
>>   config LOCK_STAT
>> @@ -1112,6 +1115,10 @@ config LOCK_STAT
>>   	 CONFIG_LOCK_STAT defines "contended" and "acquired" lock events.
>>   	 (CONFIG_LOCKDEP defines "acquire" and "release" events.)
>>   
>> +	 This feature enables LOCKDEP which can harm system performance
>> +	 even x3 times.
>> +	 For more details, see Documentation/locking/lockdep-design.txt.
>> +
>>   config DEBUG_RT_MUTEXES
>>   	bool "RT Mutex debugging, deadlock detection"
>>   	depends on DEBUG_KERNEL && RT_MUTEXES
>> @@ -1175,6 +1182,10 @@ config DEBUG_LOCK_ALLOC
>>   	 spin_lock_init()/mutex_init()/etc., or whether there is any lock
>>   	 held during task exit.
>>   
>> +	 This feature enables LOCKDEP which can harm system performance
>> +	 even x3 times.
>> +	 For more details, see Documentation/locking/lockdep-design.txt.
>> +
>>   config LOCKDEP
>>   	bool
>>   	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
> 
> I don't mind seeing warning message about the performance impact of
> enabling lockdep. However, the actual slowdown depends on many factors
> including the type of systems, workloads and so on. I am a bit hesitant
> to quote an actual figure like x3 in the help text as it may not be
> correct in many cases.
> 
> BTW, my recent lockdep patch (https://lkml.org/lkml/2018/10/2/1410)
> should be able to reduce the performance impact of enabling lockdep.
> Could you try to see if that help in your case?
> 
> Cheers,
> Longman
> 
> 
> 
> 
