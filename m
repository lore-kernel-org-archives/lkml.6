Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA092C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE5F208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PfLVLEVR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gba19rGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE5F208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934374AbeGJPte (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:49:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50114 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934017AbeGJPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:49:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F1C2960791; Tue, 10 Jul 2018 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531237771;
        bh=r7pTaLXa8wg5vGLiyUtgw5EIA0KMcZNS+lopKYncceA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PfLVLEVRT5pv3rIQ7gevVDO1rh+mAtfSwPs9cORhgGRZW4Q0CR8ob9I2OajVmh1Jr
         Puh6lKq4eoPIDXQgyxZn6oh9oPsM0hinzTvmqMOdp7Gu1p1z4S6BdyKZPqQqCh3Iny
         HKn9h1cVlu3qjUnP31etsBJhu75cWtSzyvI/Bi08=
Received: from [10.226.58.143] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pprakash@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1F4C6014B;
        Tue, 10 Jul 2018 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531237770;
        bh=r7pTaLXa8wg5vGLiyUtgw5EIA0KMcZNS+lopKYncceA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gba19rGZKejKdpXXUNKFS2f6JSTW7lo6m72KQZzjNVug18OTfhsLvjA9NXA+godCX
         G5IOJNUhBNsnXJdfftDzruZ2AB1FUNNo2opAsMnTJ+IAbeMSZInLM/S1P9+iz6/oBb
         QYEAycUMxnyAokf0ywAMja+AzMHTz9HhPhH6KoVE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1F4C6014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pprakash@codeaurora.org
Subject: Re: [PATCH v3] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To:     George Cherian <gcherian@caviumnetworks.com>,
        George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net
References: <1531131048-60762-1-git-send-email-george.cherian@cavium.com>
 <802dd310-a26c-3baa-696e-15393d6e1516@codeaurora.org>
 <3bfc37e1-e82b-c09d-462f-bf4f79aec91f@caviumnetworks.com>
From:   "Prakash, Prashanth" <pprakash@codeaurora.org>
Message-ID: <687232fa-d355-1a91-be3d-7cde3c62fc5b@codeaurora.org>
Date:   Tue, 10 Jul 2018 09:49:28 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <3bfc37e1-e82b-c09d-462f-bf4f79aec91f@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2018 11:42 PM, George Cherian wrote:
> Hi Prakash,
>
>
> On 07/09/2018 10:12 PM, Prakash, Prashanth wrote:
>>
>> Hi George,
>>
>>
>> On 7/9/2018 4:10 AM, George Cherian wrote:
>>> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
>>> feedback via set of performance counters. To determine the actual
>>> performance level delivered over time, OSPM may read a set of
>>> performance counters from the Reference Performance Counter Register
>>> and the Delivered Performance Counter Register.
>>>
>>> OSPM calculates the delivered performance over a given time period by
>>> taking a beginning and ending snapshot of both the reference and
>>> delivered performance counters, and calculating:
>>>
>>> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>>>
>>> Implement the above and hook this to the cpufreq->get method.
>>>
>>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>   drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 44 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index a9d3eec..61132e8 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -296,10 +296,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>        return ret;
>>>   }
>>>
>>> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
>>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t0,
>>> +                                  struct cppc_perf_fb_ctrs fb_ctrs_t1)
>>> +{
>>> +     u64 delta_reference, delta_delivered;
>>> +     u64 reference_perf, delivered_perf;
>>> +
>>> +     reference_perf = fb_ctrs_t0.reference_perf;
>>> +
>>> +     delta_reference = (u32)fb_ctrs_t1.reference -
>>> +                             (u32)fb_ctrs_t0.reference;
>>> +     delta_delivered = (u32)fb_ctrs_t1.delivered -
>>> +                             (u32)fb_ctrs_t0.delivered;
>> Why (u32)? These registers can be 64bits and that's why cppc_perf_fb_ctrs
>> have 64b fields for reference and delivered counters.
>>
>> Moreover, the integer math is incorrect. You can run into a scenario where
>> t1.ref/del < t0.ref/del,  thus setting a negative number to u64! The likelihood
>> of this is very high especially when you throw away the higher 32bits.
>>
> Because of binary representation, unsigned subtraction will work even if
> t1.ref/del < t0.ref/del. So essentially, the code should look like
> this,
>
> static inline u64 get_delta(u64 t1, u64 t0)
> {
>         if (t1 > t0 || t0 > ~(u32)0)
>                 return t1 - t0;
>
>         return (u32)t1 - (u32)t0;
> }
>
> As a further optimization, I used (u32) since that also works,
> as long as the momentary delta at any point is not greater than 2 ^ 32.
> I don't foresee any reason for any platform to increment the counters at
> an interval greater than 2 ^ 32.

We are NOT running within any critical section to make sure that there will be
no context switch between feedback counter reads. Thus the assumptions that
the delta always represent a very short momentary window of time and that
it is always less than 2^32 is not accurate.

The single overflow assumption about when the above interger math will
work is also not acceptable - especially when we throw away the higher order bits.
There are hardware out there that uses 64b counters and can overflow lower 32b
in quite short order of time. Since the spec (and some hardware) provides 64bits,
we should use it make our implementation more robust instead of throwing away
 the higher order bits.

I think it's ok to use the above integer math, but please add a comment about
single overflow assumption and don't throw away the higher 32bits.

>
>> To keep things simple, do something like below:
>>
>> if (t1.reference <= t0.reference || t1.delivered <= t0.delivered) {
>>       /* Atleast one of them should have overflowed */
>>       return desired_perf;
>> }
>> else {
>>       compute the delivered perf using the counters.
>> }
>
> No need to do like this as this is tested and found working across counter overruns in our platform.
>>
>>> +
>>> +     /* Check to avoid divide-by zero */
>>> +     if (delta_reference || delta_delivered)
>>> +             delivered_perf = (reference_perf * delta_delivered) /
>>> +                                     delta_reference;
>>> +     else
>>> +             delivered_perf = cpu->perf_ctrls.desired_perf;
>>> +
>>> +     return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
>>> +}
>>> +
>>> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>>> +{
>>> +     struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
>>> +     struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>>> +     int ret;
>>> +
>>> +     ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     udelay(2); /* 2usec delay between sampling */
>>> +
>>> +     ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
>>> +}
>>> +
>>>   static struct cpufreq_driver cppc_cpufreq_driver = {
>>>        .flags = CPUFREQ_CONST_LOOPS,
>>>        .verify = cppc_verify_policy,
>>>        .target = cppc_cpufreq_set_target,
>>> +     .get = cppc_cpufreq_get_rate,
>>>        .init = cppc_cpufreq_cpu_init,
>>>        .stop_cpu = cppc_cpufreq_stop_cpu,
>>>        .name = "cppc_cpufreq",
>>

