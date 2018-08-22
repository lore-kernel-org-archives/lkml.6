Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD5BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB13208DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RV+C1cuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB13208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeHWAcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:32:32 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33152 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeHWAcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:32:31 -0400
Received: by mail-pl0-f66.google.com with SMTP id 60-v6so1102420ple.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 14:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l6hESGJnIsS3AgwnxYwIzYuIBgSxC10+VW8Im9OuLAk=;
        b=RV+C1cuYTk+bi6PHDlH1PJvHN399F5h7+4YrfQXPw1X9WeRW2/cj5zQF3aFpyRfIUD
         it/WzKosOhhDSAUTRxmhbNbxEnlA3e2TWoyzK4BhFQN7eRn8tXZBsGfUPI6vlLsJsXCB
         hnc4KM6wGpN/+paS+pFzqzx1nWiOHpHqz+uD3Pdcf8xJXPKzUE2VrhHHA7cUqBsCP/RS
         3CY1UKqpWHW8cftMTv7AypzwDUnG5VXMNVc6jSYvRB8PChXd6V76/dYEVEPjWEdR4Vl+
         JPNUQPmhnSIdF49u/qDew74n/EslZIFGkvTuPQ0FuUBrBp3BqXZohQMEP2ZTgRcinuDx
         mCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l6hESGJnIsS3AgwnxYwIzYuIBgSxC10+VW8Im9OuLAk=;
        b=IT0MOxXszCQUimJQfR0XkWn5/1uvOAAVDi3crZVJSoh0yqub3Vkv1a+kyjSVOraY32
         DamK8zXBEKatJd5Q44vxxWh6WT/l7hkpqoB6kwP/rKJ8ZGrzK6GQOlMSpWiM7XoMkWbC
         ZfVFNZ61zFeVezDhOW/EtRfAq+1pxZQdCFZyutR93zuHTUF6OVOsrAEH1yLDnk/MLoll
         ZKYsubJclBdaLijWsAhxZuOWWpjDsp/ffq6DNzIHiJCyA+RJBPqAj03aM1PORx8srIel
         HnKeXesxCHD73XQIptnjGC8tC9+daBBGU+tiSyv7yFSMqML13/AxOG45UsP2togy5kSL
         cICA==
X-Gm-Message-State: AOUpUlH57OT0JeA/SmX6KwFbV5v4f0up1X4+7zRGCyMFHfLMecb72W5E
        I4mDuUw7dbrp7ONbTmwfQN+XiXDfLpZ9oQ==
X-Google-Smtp-Source: AA+uWPyuXKdAtLEZoh5atZRsiKSU90ENy07+Gos8TKmiOE6dMIGtnSewJUJAdSwPLGUFZLnRy44Ecg==
X-Received: by 2002:a17:902:6bc5:: with SMTP id m5-v6mr54925655plt.274.1534971960994;
        Wed, 22 Aug 2018 14:06:00 -0700 (PDT)
Received: from ?IPv6:2600:380:4b19:6e9b:f0d7:3a36:acbc:cd29? ([2600:380:4b19:6e9b:f0d7:3a36:acbc:cd29])
        by smtp.gmail.com with ESMTPSA id d2-v6sm3519749pfg.172.2018.08.22.14.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 14:05:59 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
To:     Anchal Agarwal <anchalag@amazon.com>
Cc:     fllinden@amazon.com, sblbir@amazon.com,
        holger@applied-asynchrony.com, msw@amazon.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c5152431-6e36-6f6e-616e-1cfbd974817d@kernel.dk>
 <20180820224241.GA72523@8c8590bceeee.ant.amazon.com>
 <70e2063a-53fa-2475-eed9-07db277c8c0d@kernel.dk>
 <b2adf708-d396-94ac-b123-8027d3839fd1@kernel.dk>
 <20180822040126.GA18736@kaos-source-ops-60001.pdx1.amazon.com>
 <76ecb022-f167-67eb-8801-111fc209bbaa@kernel.dk>
 <834649ab-62d6-bc7f-ec60-6c1654ea3f26@applied-asynchrony.com>
 <d8c171ce-6dfe-e9e5-5673-8443cfec5f01@kernel.dk>
 <f71cf3f9c54346e1b69ab42601404597@EX13D13UWB002.ant.amazon.com>
 <f457d299-574b-52e1-782f-51cbc988f4fb@kernel.dk>
 <20180822202645.GA8025@kaos-source-ops-60001.pdx1.amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <af9d0c9f-e65b-b2d1-5e4a-cb4785de8881@kernel.dk>
Date:   Wed, 22 Aug 2018 15:05:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180822202645.GA8025@kaos-source-ops-60001.pdx1.amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/18 2:26 PM, Anchal Agarwal wrote:
> On Wed, Aug 22, 2018 at 11:30:40AM -0600, Jens Axboe wrote:
>> On 8/22/18 10:42 AM, van der Linden, Frank wrote:
>>> On 8/22/18 7:27 AM, Jens Axboe wrote:
>>>> On 8/22/18 6:54 AM, Holger Hoffst??tte wrote:
>>>>> On 08/22/18 06:10, Jens Axboe wrote:
>>>>>> [...]
>>>>>> If you have time, please look at the 3 patches I posted earlier today.
>>>>>> Those are for mainline, so should be OK :-)
>>>>> I'm just playing along at home but with those 3 I get repeatable
>>>>> hangs & writeback not starting at all, but curiously *only* on my btrfs
>>>>> device; for inexplicable reasons some other devices with ext4/xfs flush
>>>>> properly. Yes, that surprised me too, but it's repeatable.
>>>>> Now this may or may not have something to do with some of my in-testing
>>>>> patches for btrfs itself, but if I remove those 3 wbt fixes, everything
>>>>> is golden again. Not eager to repeat since it hangs sync & requires a
>>>>> hard reboot.. :(
>>>>> Just thought you'd like to know.
>>>> Thanks, that's very useful info! I'll see if I can reproduce that.
>>>>
>>> I think it might be useful to kind of give a dump of what we discussed
>>> before this patch was sent, there was a little more than was in the
>>> description.
>>>
>>> We saw hangs and heavy lock contention in the wbt code under a specific
>>> workload, on XFS. Crash dump analysis showed the following issues:
>>>
>>> 1) wbt_done uses wake_up_all, which causes a thundering herd
>>> 2) __wbt_wait sets up a wait queue with the auto remove wake function
>>> (via DEFINE_WAIT), which caused two problems:
>>>    * combined with the use of wake_up_all, the wait queue would
>>> essentially be randomly reordered for tasks that did not get to run
>>>    * the waitqueue_active check in may_queue was not valid with the auto
>>> remove function, which could lead incoming tasks with requests to
>>> overtake existing requests
>>>
>>> 1) was fixed by using a plain wake_up
>>> 2) was fixed by keeping tasks on the queue until they could break out of
>>> the wait loop in __wbt_wait
>>>
>>>
>>> The random reordering, causing task starvation in __wbt_wait, was the
>>> main problem. Simply not using the auto remove wait function, e.g.
>>> *only* changing DEFINE_WAIT(wait) to DEFINE_WAIT_FUNC(wait,
>>> default_wake_function), fixed the hang / task starvation issue in our
>>> tests. But there was still more lock contention than there should be, so
>>> we also changed wake_up_all to wake_up.
>>>
>>> It might be useful to run your tests with only the DEFINE_WAIT change I
>>> describe above added to the original code to see if that still has any
>>> problems. That would give a good datapoint whether any remaining issues
>>> are due to missed wakeups or not.
>>>
>>> There is the issue of making forward progress, or at least making it
>>> fast enough. With the changes as they stand now, you could come up with
>>> a scenario where the throttling limit is hit, but then is raised. Since
>>> there might still be a wait queue, you could end up putting each
>>> incoming task to sleep, even though it's not needed.
>>>
>>> One way to guarantee that the wait queue clears up as fast as possible,
>>> without resorting to wakeup_all, is to use wakeup_nr, where the number
>>> of tasks to wake up is (limit - inflight).
>>>
>>> Also, to avoid having tasks going back to sleep in the loop, you could
>>> do what you already proposed - always just sleep at most once, and
>>> unconditionally proceed after waking up. To avoid incoming tasks
>>> overtaking the ones that are being woken up, you could have wbt_done
>>> increment inflight, effectively reserving a spot for the tasks that are
>>> about to be woken up.
>>>
>>> Another thing I thought about was recording the number of waiters in the
>>> wait queue, and modify the check from (inflight < limit) to (inflight <
>>> (limit - nwaiters)), and no longer use any waitqueue_active checks.
>>>
>>> The condition checks are of course complicated by the fact that
>>> condition manipulation is not always done under the same lock (e.g.
>>> wbt_wait can be called with a NULL lock).
>>>
>>>
>>> So, these are just some of the things to consider here - maybe there's
>>> nothing in there that you hadn't already considered, but I thought it'd
>>> be useful to summarize them.
>>>
>>> Thanks for looking in to this!
>>
>> It turned out to be an unrelated problem with rq reordering in blk-mq,
>> mainline doesn't have it.
>>
>> So I think the above change is safe and fine, but we definitely still
>> want the extra change of NOT allowing a queue token for the initial loop
>> inside __wbt_wait() for when we have current sleepers on the queue.
>> Without that, the initial check in __wbt_wait() is not useful at all.
>>
>>
>> -- 
>> Jens Axboe
>>
>>
> 
> Hi Jens,
> I tested your patches in my environment and they look good. There is no sudden increase in 
> lock contention either. Thanks for catching the corner case though.

Thanks for testing. Can I add your tested-by to the 3 patches?

-- 
Jens Axboe

