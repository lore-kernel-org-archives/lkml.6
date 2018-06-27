Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81A3C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8944626314
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="QABzltTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8944626314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933884AbeF0JA5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:00:57 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38667 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933529AbeF0JAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:00:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id e18-v6so1195406wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pBpYWuK6rmiHygTJEzunKDodCOXKughuCiCPMfoXbZ0=;
        b=QABzltTiFYe5GEfW2/q0ht6Za2ORvAtyeOUIUI8yEuLSW7aITPq1jCm4S3NzMaYRzz
         HisFnsIXluxcPljvRjxsQGrglp9TbspwnB7i179L0K21Mt7Rqvez5U/CeRX2zMFNWgwE
         eJIZ9PuMwMfRzWvDducVQ5iV56WLhmYpvy4dMWgJ4CErx1uZxNRom2Qz7djl+myOsJ9R
         t+38/TMeD0OscYcpkxGKHQ1y7Ifp5yejprB2ENg5VD0DrIJeoy1HGODh9TQwMCJzQqOU
         j/ijxTVJX1Qiegw4ySmzUkPjZIjDP4kV6cmg48hZMff/UkOQ3Z5Yy6JPd8Mb25clBuVx
         wMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pBpYWuK6rmiHygTJEzunKDodCOXKughuCiCPMfoXbZ0=;
        b=eLt/bfS0s2MTO0ztUJUV5gHiGM+kx/eu7FLp60/7RazFj//kV1eQ7PxYyClLLI5qvu
         rDUUGRLpGaxmm4xlICGdUOwdeVxOSRo36QH5ePFlVI67aE+P35DzpU9xlWq+uHL+Ob9d
         88e84ocCzDIdZgeQGnr4ZyrEd3GY8lG2SDvH279CpuIwsBr9B5yxz1Qg8FeqpM7GGrDY
         uRAYaGCS6CwwgjN1E3czKjSlcYTVsu4bda9GS+YHAhTKJsUgQGHgSNWGf9mS4rW0PfBA
         r/mLXIrTPlsoB2PX1A5osHpBZJ9tHXbu86MmG5l3J2g7oSc0gcfP9muvOxWb5tXJBPgg
         3kGg==
X-Gm-Message-State: APt69E0yqegsj6NsmIp9WzIvoFG3y10zRmnZkFxeGqMLzObwoRu+M1KT
        x/+CsdeCSNmb6DhwlN0qF/ZZxQ==
X-Google-Smtp-Source: AAOMgpfHEtaIxmzBUazUWEaelmC/R8R4LrrVKlBM6SfDyXQ+yhZ/Sp+qLX4otD6KIeFayg85mA5HHQ==
X-Received: by 2002:adf:e644:: with SMTP id b4-v6mr4604891wrn.254.1530090045215;
        Wed, 27 Jun 2018 02:00:45 -0700 (PDT)
Received: from [192.168.0.197] ([95.146.151.144])
        by smtp.googlemail.com with ESMTPSA id m3-v6sm3126559wro.27.2018.06.27.02.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 02:00:43 -0700 (PDT)
Subject: Re: [RFC 1/4] perf: Move some access checks later in perf_event_open
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
 <20180626153642.5587-2-tvrtko.ursulin@linux.intel.com>
 <861aa316-fa18-4385-af84-0e9445f261d1@linux.intel.com>
From:   Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <d7264619-e9cc-08fe-6a6b-ee19a28c30df@ursulin.net>
Date:   Wed, 27 Jun 2018 10:00:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <861aa316-fa18-4385-af84-0e9445f261d1@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/06/18 18:24, Alexey Budankov wrote:
> Hi,
> 
> On 26.06.2018 18:36, Tvrtko Ursulin wrote:
>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>
>> To enable per-PMU access controls in a following patch first move all call
>> sites of perf_paranoid_kernel() to after the event has been created.
>>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: x86@kernel.org
>> ---
>>   kernel/events/core.c | 36 ++++++++++++++++++++++--------------
>>   1 file changed, 22 insertions(+), 14 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index f490caca9aa4..12de95b0472e 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -10189,10 +10189,6 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
>>   			 */
>>   			attr->branch_sample_type = mask;
>>   		}
>> -		/* privileged levels capture (kernel, hv): check permissions */
>> -		if ((mask & PERF_SAMPLE_BRANCH_PERM_PLM)
>> -		    && perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
>> -			return -EACCES;
>>   	}
>>   
>>   	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
>> @@ -10409,11 +10405,6 @@ SYSCALL_DEFINE5(perf_event_open,
>>   	if (err)
>>   		return err;
>>   
>> -	if (!attr.exclude_kernel) {
>> -		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
>> -			return -EACCES;
>> -	}
>> -
>>   	if (attr.namespaces) {
>>   		if (!capable(CAP_SYS_ADMIN))
>>   			return -EACCES;
>> @@ -10427,11 +10418,6 @@ SYSCALL_DEFINE5(perf_event_open,
>>   			return -EINVAL;
>>   	}
>>   
>> -	/* Only privileged users can get physical addresses */
>> -	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
>> -	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
>> -		return -EACCES;
>> -
>>   	/*
>>   	 * In cgroup mode, the pid argument is used to pass the fd
>>   	 * opened to the cgroup directory in cgroupfs. The cpu argument
>> @@ -10501,6 +10487,28 @@ SYSCALL_DEFINE5(perf_event_open,
>>   		goto err_cred;
>>   	}
>>   
>> +	if (!attr.exclude_kernel) {
>> +		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
>> +			err = -EACCES;
> 
> I would separate this combined permissions check into a function e.g.
> static bool perf_test_pmu_paranoid(const struct pmu *pmu, int *err) to avoid
> code duplication.

My thinking was for this to be as mechanical (code movement) as 
possible, but I can consider it.

Regards,

Tvrtko

>> +			goto err_alloc;
>> +		}
>> +	}
>> +
>> +	/* Only privileged users can get physical addresses */
>> +	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
>> +	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
>> +		err = -EACCES;
>> +		goto err_alloc;
>> +	}
>> +
>> +	/* privileged levels capture (kernel, hv): check permissions */
>> +	if ((attr.sample_type & PERF_SAMPLE_BRANCH_STACK) &&
>> +	    (attr.branch_sample_type & PERF_SAMPLE_BRANCH_PERM_PLM) &&
>> +	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN)) {
>> +		err = -EACCES;
>> +		goto err_alloc;
>> +	}
>> +
>>   	if (is_sampling_event(event)) {
>>   		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
>>   			err = -EOPNOTSUPP;
>>
> 
