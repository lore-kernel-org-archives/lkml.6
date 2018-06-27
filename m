Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6913DC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D64225115
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="kBCn/UhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D64225115
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933493AbeF0KFI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:05:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34917 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbeF0KFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:05:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id z137-v6so4826648wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H+5sKzy/objm/6G6pI/R9U1gohuMbfA8JrsXIUcPALc=;
        b=kBCn/UhQ6AOE34czLiGtHpbUFEx5T90k7hkZ4YBCkkZjhLtz+Q5QVgpCwIZFEH766H
         OirCLdSD5oo3zRNb2wnNvOxhOW0LJ1+UIjqKI2laSzZpoYJ2wP6enQquvDyyX4+0UQ7s
         1IpaOK7W515S9hk78PG9nuD2RLep6oin+yCBbydWogzMy1Bnso3yPOE1dPxqIQfXnm7H
         jz7x4ee6IK/7B3j9uk1DaUt1nXCj0+Lp9RxJDHlHcii3/YRvoPk7XDHBL9s/jg9Kcs9X
         SgleqvSXcpqI+3qQYCE4OxRt3lwojdC2kcsASLoFCt63dtoFxZtKr5BO8uEpqHZ3pgyp
         C25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H+5sKzy/objm/6G6pI/R9U1gohuMbfA8JrsXIUcPALc=;
        b=ZQfFrD+vpf9xTWJnwZHdT6u/gzanZv63xI4iTmVvKHOYucDhf9VXDzbuaTIpxZluHK
         kjwtuocGZEAaQXNFqrFpfpE1+PJxx+aLlcpgVd2ietXQBTDnhtCicag3eHds8LwAhtaV
         YyMh948zm5k5d5+wAyRPkJJQQ3r79ZzJuT16YhmjsZbzsYZSezgvp3u5WDAiKifov5O5
         H9XtwufzWEg+w8pW1ze39x73UY48Mf9Z0IA5llCmXM8uNP9UDnc5umhtmdUruaMxTUZ7
         HbSJxM5mnZQQ/F3umbRqTQxLLvqNCBEnd0F0rg6JOqhqptW8mdaO5U7RIP8M9kmrpaeN
         hTGg==
X-Gm-Message-State: APt69E0Ts3ZictHBVGYzJiigx5u+14JDYtSN91n+oIbc9S7ISD8N8Jgr
        03i7rndPUhvBmQ1kNvH4nIJ3bQ==
X-Google-Smtp-Source: AAOMgpcfciPZ2X252goKpLaD2IYKsx6jrYSOavbBoiMK7d4Uo4cP/hRAg+/b7m2k6GdLMvJG89ocmA==
X-Received: by 2002:a1c:8803:: with SMTP id k3-v6mr4612171wmd.6.1530093905567;
        Wed, 27 Jun 2018 03:05:05 -0700 (PDT)
Received: from [192.168.0.197] ([95.146.151.144])
        by smtp.googlemail.com with ESMTPSA id s2-v6sm5894720wrn.75.2018.06.27.03.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 03:05:04 -0700 (PDT)
Subject: Re: [RFC 3/4] perf: Allow per PMU access control
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org
References: <20180626153642.5587-1-tvrtko.ursulin@linux.intel.com>
 <20180626153642.5587-4-tvrtko.ursulin@linux.intel.com>
 <e3beeb7e-fc9a-be86-0bea-92e8dd0916f2@linux.intel.com>
 <59478e35-4ac9-7be5-172a-c8301d9e11fd@ursulin.net>
 <2d389cf9-e284-0557-159a-e70a758d357b@linux.intel.com>
From:   Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <3b774f2e-56da-3d39-6fda-a4240a195377@ursulin.net>
Date:   Wed, 27 Jun 2018 11:05:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2d389cf9-e284-0557-159a-e70a758d357b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/06/18 10:47, Alexey Budankov wrote:
> 
> 
> On 27.06.2018 12:15, Tvrtko Ursulin wrote:
>>
>> On 26/06/18 18:25, Alexey Budankov wrote:
>>> Hi,
>>>
>>> On 26.06.2018 18:36, Tvrtko Ursulin wrote:
>>>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>>>
>>>> For situations where sysadmins might want to allow different level of
>>>> access control for different PMUs, we start creating per-PMU
>>>> perf_event_paranoid controls in sysfs.
>>>>
>>>> These work in equivalent fashion as the existing perf_event_paranoid
>>>> sysctl, which now becomes the parent control for each PMU.
>>>>
>>>> On PMU registration the global/parent value will be inherited by each PMU,
>>>> as it will be propagated to all registered PMUs when the sysctl is
>>>> updated.
>>>>
>>>> At any later point individual PMU access controls, located in
>>>> <sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
>>>> fine grained access control.
>>>>
>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>> Cc: Jiri Olsa <jolsa@redhat.com>
>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>>>> Cc: Andi Kleen <ak@linux.intel.com>
>>>> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: x86@kernel.org
>>>> ---
>>>>    include/linux/perf_event.h | 12 ++++++--
>>>>    kernel/events/core.c       | 59 ++++++++++++++++++++++++++++++++++++++
>>>>    kernel/sysctl.c            |  4 ++-
>>>>    3 files changed, 71 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>>> index d7938d88c028..22e91cc2d9e1 100644
>>>> --- a/include/linux/perf_event.h
>>>> +++ b/include/linux/perf_event.h
>>>> @@ -271,6 +271,9 @@ struct pmu {
>>>>        /* number of address filters this PMU can do */
>>>>        unsigned int            nr_addr_filters;
>>>>    +    /* per PMU access control */
>>>> +    int                perf_event_paranoid;
>>>
>>> It looks like it needs to be declared as atomic and atomic_read/atomic_write
>>> operations need to be explicitly used below in the patch as far this
>>> variable may be manipulated by different threads at the same time
>>> without explicit locking.
>>
>> It is just a write of an integer from either sysfs access or sysctl. As such I don't think going atomic would change anything. There is no RMW or increment or anything on it.
>>
>> Unless there are architectures where int stores are not atomic? But then the existing sysctl would have the same issue. So I suspect we can indeed rely on int store being atomic.
> 
> Yep, aligned word read/write is atomic on Intel and there is no runtime issue
> currently, but the implementation itself is multithread and implicitly relies
> on that atomicity so my suggestion is just explicitly code that assumption :).
> Also, as you mentioned, that makes the arch independent part of code more portable.

Perhaps we are not on the same page, but my argument was that the 
current sysctl (or sysctl via proc) has the same issue with multiple 
threads potentially writing to it. As long as the end result is a valid 
value it is not a problem. So I don't see what this patch changes in 
that respect. Different tasks writing either of the sysctl/sysfs values 
race, but end up with valid values everywhere. If we can rely on int 
stores to be atomic on all architectures I don't see an effective 
difference after changing to atomic_t, or even taking the pmu mutex over 
the per PMU sysfs writes. So I don't see value in complicating the code 
with either approach but am happy to be proved wrong if that is the case.

Regards,

Tvrtko
