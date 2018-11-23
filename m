Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B193C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D0320861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiDkP7X7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D0320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502959AbeKWU60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:58:26 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37588 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387808AbeKWU6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:58:25 -0500
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so11418479wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 02:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6F/QXxnTlrWUviTltTc05PuMEQQxtuWU3eLn6e3BlNI=;
        b=DiDkP7X7aYPiEt3uZuBjcLdpqqnYj2mSeW2We/m2GazOpJGvJ2ljBk4lnc3Pd4GLF3
         p5n9rQMoLI4lcocy5ARh2jsIvorrQWeGeEvcG36HTdTZdwOCO7JUuMlJ/tRfZ7nJjTIT
         r06BKf56zlfrqGRVtgXtwS+iDKkbpDOisXxj1lSuwetJvSoDMJZ3E9Y0MhLCv1Ri+Hw8
         mIHQSZfCAxs65MssfKJXVgJhzEObdiheMPHl7AHeDkxYBCghqn2nmNwQgexBvbOL6pcP
         CjZk/h96crJkOt5QltCVaFkXKS385P07dHLWMF3kvycTZy49GSkM8RAvAeLC2m+G26rD
         Kd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6F/QXxnTlrWUviTltTc05PuMEQQxtuWU3eLn6e3BlNI=;
        b=r8pGZcabR/q5CPX2KYXjvh8wtlB+/RFiFUG+59za17KmeYc5ShT5GMpDWAAR1Jxtxx
         DA1re2x0A2VT7+inGp4VDaTQhQCRvxa69NUOdy86IkKAJe2bcvAh6U0GZvgDiq1GFGu3
         2Ac7x6/tSdXjU6lA8MpAPsxLGo7IGQZukozcc1YHfhfXq5fcUb53m5WXlYWo3YcGG0RC
         zVCBdZ0fDzFseHZXy+zMrYOHERNwB30jKUJtFkGUUERwZE9+PMr5gwUhl+1m/X3Ljz2E
         F+sZ7mzAm7c/gnZeDMScTln+0Qz0/Dd2WlY/xeLnlWYwH4/mV2OHUwgLLX41Tr3ZCcl4
         U3vg==
X-Gm-Message-State: AGRZ1gKFtih5T80JGYA74FxdvUDj73fNZovRPfl1Ih5s7685EDb1ToUH
        pWUWzxVXFSAWuQFq7F4S4To=
X-Google-Smtp-Source: AJdET5dJ/TB3JoKOpuHjYImf8xKcCUTkvjmgPYLyX2R3U0b7tGUl/YJ0fFg68tVL+tTMOx0Hg3PbBw==
X-Received: by 2002:a7b:c003:: with SMTP id c3-v6mr12075741wmb.133.1542968086013;
        Fri, 23 Nov 2018 02:14:46 -0800 (PST)
Received: from ?IPv6:2a02:908:125b:9a00:a142:2be6:b7be:5a3a? ([2a02:908:125b:9a00:a142:2be6:b7be:5a3a])
        by smtp.gmail.com with ESMTPSA id d18-v6sm37528859wre.25.2018.11.23.02.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 02:14:45 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 2/3] mm, notifier: Catch sleeping/blocking for !blockable
To:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20181122165106.18238-1-daniel.vetter@ffwll.ch>
 <20181122165106.18238-3-daniel.vetter@ffwll.ch>
 <f9c39a9a-5afd-4aed-c9ad-0c3fef34a449@amd.com>
 <20181123084609.GH4266@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <59f25d62-904a-86cf-3daf-88e38d526dcf@gmail.com>
Date:   Fri, 23 Nov 2018 11:14:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181123084609.GH4266@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.11.18 um 09:46 schrieb Daniel Vetter:
> On Thu, Nov 22, 2018 at 06:55:17PM +0000, Koenig, Christian wrote:
>> Am 22.11.18 um 17:51 schrieb Daniel Vetter:
>>> We need to make sure implementations don't cheat and don't have a
>>> possible schedule/blocking point deeply burried where review can't
>>> catch it.
>>>
>>> I'm not sure whether this is the best way to make sure all the
>>> might_sleep() callsites trigger, and it's a bit ugly in the code flow.
>>> But it gets the job done.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: David Rientjes <rientjes@google.com>
>>> Cc: "Christian König" <christian.koenig@amd.com>
>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>>> Cc: linux-mm@kvack.org
>>> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>>> ---
>>>    mm/mmu_notifier.c | 8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
>>> index 59e102589a25..4d282cfb296e 100644
>>> --- a/mm/mmu_notifier.c
>>> +++ b/mm/mmu_notifier.c
>>> @@ -185,7 +185,13 @@ int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
>>>    	id = srcu_read_lock(&srcu);
>>>    	hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist) {
>>>    		if (mn->ops->invalidate_range_start) {
>>> -			int _ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
>>> +			int _ret;
>>> +
>>> +			if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP) && !blockable)
>>> +				preempt_disable();
>>> +			_ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
>>> +			if (IS_ENABLED(CONFIG_DEBUG_ATOMIC_SLEEP) && !blockable)
>>> +				preempt_enable();
>> Just for the sake of better documenting this how about adding this to
>> include/linux/kernel.h right next to might_sleep():
>>
>> #define disallow_sleeping_if(cond)    for((cond) ? preempt_disable() :
>> (void)0; (cond); preempt_disable())
>>
>> (Just from the back of my head, might contain peanuts and/or hints of
>> errors).
> I think these magic for blocks aren't used in the kernel. goto breaks
> them, and we use goto a lot.

Yeah, good argument.

> I think a disallow/allow_sleep() pair with
> the conditional preept_disable/enable() calls would be nice though. I can
> do that if the overall idea sticks.

Sounds like a good idea to me as well.

Christian.

> -Daniel
>
>> Christian.
>>
>>>    			if (_ret) {
>>>    				pr_info("%pS callback failed with %d in %sblockable context.\n",
>>>    						mn->ops->invalidate_range_start, _ret,

