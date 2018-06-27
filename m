Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A518FC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462822645C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="Dq/RQVMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462822645C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933022AbeF0JPM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:15:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39743 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752615AbeF0JPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:15:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so4603271wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SaX0Uz45DIeCyV7QzOv9JGUgknofjeHwTM0CycGXJbY=;
        b=Dq/RQVMGItG9XNB+RGbZ46guMN40ddEUzVtZODMhDd4boInyq0mPyLoOFH7N92TolR
         6aLbcNiMHWthyKLaXiuI0I7hOCCyLa79gTtt3cl62fSh/xuIPi6rmF0Qf+aGirJJswf7
         /Np1ajPi8mECU+c5/iIz+d4dn6O1ikhmP41rcOS1i11gOKplod3OmmXu7lI5plxV1LME
         CG9YDJPah1Wf2zLDhAMLqOLHhbARfXXdX6Ix5MrNOovokc5TqvIzCyQFlVTFTpyWep21
         pJ9QL697E6EWEOUuKtCBrx/MiHRV4OjYG38+6HQ/Wkwy2pm8N6Y4AcGzdQcrMiEk3sq4
         2PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SaX0Uz45DIeCyV7QzOv9JGUgknofjeHwTM0CycGXJbY=;
        b=AexXM//o/APzoH0hqMqDKhdUwkqO9w+wS+NofW7+zeY1uQhsbyA13os5PBVrFojvgd
         eSgIyPPhBu4eMDnx6xKQsk5bozdR/kO/yetSZICp9qXGDGon7Q1+BSkShf0/z8xpL+mo
         b2iVmgpAE646YIvHWT+NyqEZBhJ89cIb88jNe8EPwfyaRDQbvRbLwKHQbIxxXCPT83BK
         TWO7VFt+6yHFcBDhwM3g9KyrNsel8wP5OY64RtULeTnIXPKlj6XTK9Xxjx412+tAPTTH
         ZTFkdCPY2Y34+mMxrfyNjMGdg5pjTg1TDr3S18O4Oq1vGg3xCG7c/UfI0AASjKJz1MyK
         pMVA==
X-Gm-Message-State: APt69E3KfWX7mGbiKzNx4WxKPuK0hWRiJxM6IvBR3Kbq2y4tdhVUIMtZ
        zePf0hvL18JdozE8ZeYzbEEp5w==
X-Google-Smtp-Source: AAOMgpd6fcXb1PBwKXbND2M+3cXRLhYcn6p3J6eH2liMOPlJPFAOrZv0IDTanphzGGZn4t3LvddqQA==
X-Received: by 2002:a1c:b18a:: with SMTP id a132-v6mr4009986wmf.18.1530090908708;
        Wed, 27 Jun 2018 02:15:08 -0700 (PDT)
Received: from [192.168.0.197] ([95.146.151.144])
        by smtp.googlemail.com with ESMTPSA id 12-v6sm6317996wmt.19.2018.06.27.02.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 02:15:07 -0700 (PDT)
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
From:   Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <59478e35-4ac9-7be5-172a-c8301d9e11fd@ursulin.net>
Date:   Wed, 27 Jun 2018 10:15:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e3beeb7e-fc9a-be86-0bea-92e8dd0916f2@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/06/18 18:25, Alexey Budankov wrote:
> Hi,
> 
> On 26.06.2018 18:36, Tvrtko Ursulin wrote:
>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>
>> For situations where sysadmins might want to allow different level of
>> access control for different PMUs, we start creating per-PMU
>> perf_event_paranoid controls in sysfs.
>>
>> These work in equivalent fashion as the existing perf_event_paranoid
>> sysctl, which now becomes the parent control for each PMU.
>>
>> On PMU registration the global/parent value will be inherited by each PMU,
>> as it will be propagated to all registered PMUs when the sysctl is
>> updated.
>>
>> At any later point individual PMU access controls, located in
>> <sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
>> fine grained access control.
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
>>   include/linux/perf_event.h | 12 ++++++--
>>   kernel/events/core.c       | 59 ++++++++++++++++++++++++++++++++++++++
>>   kernel/sysctl.c            |  4 ++-
>>   3 files changed, 71 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index d7938d88c028..22e91cc2d9e1 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -271,6 +271,9 @@ struct pmu {
>>   	/* number of address filters this PMU can do */
>>   	unsigned int			nr_addr_filters;
>>   
>> +	/* per PMU access control */
>> +	int				perf_event_paranoid;
> 
> It looks like it needs to be declared as atomic and atomic_read/atomic_write
> operations need to be explicitly used below in the patch as far this
> variable may be manipulated by different threads at the same time
> without explicit locking.

It is just a write of an integer from either sysfs access or sysctl. As 
such I don't think going atomic would change anything. There is no RMW 
or increment or anything on it.

Unless there are architectures where int stores are not atomic? But then 
the existing sysctl would have the same issue. So I suspect we can 
indeed rely on int store being atomic.

Regards,

Tvrtko

> 
>> +
>>   	/*
>>   	 * Fully disable/enable this PMU, can be used to protect from the PMI
>>   	 * as well as for lazy/batch writing of the MSRs.
>> @@ -1168,6 +1171,9 @@ extern int sysctl_perf_cpu_time_max_percent;
>>   
>>   extern void perf_sample_event_took(u64 sample_len_ns);
>>   
>> +extern int perf_proc_paranoid_handler(struct ctl_table *table, int write,
>> +		void __user *buffer, size_t *lenp,
>> +		loff_t *ppos);
>>   extern int perf_proc_update_handler(struct ctl_table *table, int write,
>>   		void __user *buffer, size_t *lenp,
>>   		loff_t *ppos);
>> @@ -1180,17 +1186,17 @@ int perf_event_max_stack_handler(struct ctl_table *table, int write,
>>   
>>   static inline bool perf_paranoid_tracepoint_raw(const struct pmu *pmu)
>>   {
>> -	return sysctl_perf_event_paranoid > -1;
>> +	return pmu->perf_event_paranoid > -1;
>>   }
>>   
>>   static inline bool perf_paranoid_cpu(const struct pmu *pmu)
>>   {
>> -	return sysctl_perf_event_paranoid > 0;
>> +	return pmu->perf_event_paranoid > 0;
>>   }
>>   
>>   static inline bool perf_paranoid_kernel(const struct pmu *pmu)
>>   {
>> -	return sysctl_perf_event_paranoid > 1;
>> +	return pmu->perf_event_paranoid > 1;
>>   }
>>   
>>   extern void perf_event_init(void);
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 370c89e81722..da36317dc8dc 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -432,6 +432,24 @@ static void update_perf_cpu_limits(void)
>>   
>>   static bool perf_rotate_context(struct perf_cpu_context *cpuctx);
>>   
>> +int perf_proc_paranoid_handler(struct ctl_table *table, int write,
>> +		void __user *buffer, size_t *lenp,
>> +		loff_t *ppos)
>> +{
>> +	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>> +	struct pmu *pmu;
>> +
>> +	if (ret || !write)
>> +		return ret;
>> +
>> +	mutex_lock(&pmus_lock);
>> +	list_for_each_entry(pmu, &pmus, entry)
>> +		pmu->perf_event_paranoid = sysctl_perf_event_paranoid;
>> +	mutex_unlock(&pmus_lock);
>> +
>> +	return 0;
>> +}
>> +
>>   int perf_proc_update_handler(struct ctl_table *table, int write,
>>   		void __user *buffer, size_t *lenp,
>>   		loff_t *ppos)
>> @@ -9425,6 +9443,41 @@ static void free_pmu_context(struct pmu *pmu)
>>   	mutex_unlock(&pmus_lock);
>>   }
>>   
>> +/*
>> + * Fine-grained access control:
>> + */
>> +static ssize_t
>> +perf_event_paranoid_show(struct device *dev,
>> +			 struct device_attribute *attr,
>> +			 char *page)
>> +{
>> +	struct pmu *pmu = dev_get_drvdata(dev);
>> +
>> +	return snprintf(page, PAGE_SIZE - 1, "%d\n", pmu->perf_event_paranoid);
>> +}
>> +
>> +static ssize_t
>> +perf_event_paranoid_store(struct device *dev,
>> +			  struct device_attribute *attr,
>> +			  const char *buf, size_t count)
>> +{
>> +	struct pmu *pmu = dev_get_drvdata(dev);
>> +	int ret, val;
>> +
>> +	ret = kstrtoint(buf, 0, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (val < -1 || val > 2)
>> +		return -EINVAL;
>> +
>> +	pmu->perf_event_paranoid = val;
>> +
>> +	return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(perf_event_paranoid);
>> +
>>   /*
>>    * Let userspace know that this PMU supports address range filtering:
>>    */
>> @@ -9539,6 +9592,11 @@ static int pmu_dev_alloc(struct pmu *pmu)
>>   	if (ret)
>>   		goto free_dev;
>>   
>> +	/* Add fine-grained access control attribute. */
>> +	ret = device_create_file(pmu->dev, &dev_attr_perf_event_paranoid);
>> +	if (ret)
>> +		goto del_dev;
>> +
>>   	/* For PMUs with address filters, throw in an extra attribute: */
>>   	if (pmu->nr_addr_filters)
>>   		ret = device_create_file(pmu->dev, &dev_attr_nr_addr_filters);
>> @@ -9570,6 +9628,7 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
>>   	if (!pmu->pmu_disable_count)
>>   		goto unlock;
>>   
>> +	pmu->perf_event_paranoid = sysctl_perf_event_paranoid;
>>   	pmu->type = -1;
>>   	if (!name)
>>   		goto skip_type;
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 2d9837c0aff4..7f6fccb64a30 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -1142,7 +1142,9 @@ static struct ctl_table kern_table[] = {
>>   		.data		= &sysctl_perf_event_paranoid,
>>   		.maxlen		= sizeof(sysctl_perf_event_paranoid),
>>   		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec,
>> +		.proc_handler   = perf_proc_paranoid_handler,
>> +		.extra1         = &neg_one,
>> +		.extra2         = &two,
>>   	},
>>   	{
>>   		.procname	= "perf_event_mlock_kb",
>>
> 
