Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A2CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DD7217FA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="oG/N8iTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbfBKUOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:14:25 -0500
Received: from cmta18.telus.net ([209.171.16.91]:56842 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfBKUOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:14:23 -0500
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id tHy6gTKn1M04NtHy7gIpaN; Mon, 11 Feb 2019 13:14:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1549916061; bh=+IiXK6nXihWcp1W0HwCqrAVWdQEPXLAKHY6AWRZ22+8=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=oG/N8iTqm9hUO1hX5IEfTNUy4EVHyYZ4tLqg+kl9H2/PfjdP2m/cNaAJuiQNZBY6v
         rx9HCK59DQusz6uMdlNYwuN/pWOJw1LvbdJ+ayNSsHa7bIAplhUsrA/NZ99DzMnY3n
         FDOAHfpcpaJ42KSI/NhSYNPoEakXSJ2fYnJlXh0NMxsWkh0V6jbp2sBRzzj+45hvYL
         bmeFrRMNg/RTDrTGBT3Ymjv1SfHiH22kFF2ESulcHISWt6ZDuR6t6O2RHoxARnNc4a
         DpfM5nDn56ogW+phTGUaWQ811MWJsxK0WDh2TrM+OT53x32ZXQiVOLL+yQf6gEEHyJ
         cJTa3DZLXebgg==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=aNWOVo1m c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=rgcYzkpT7NhB4wCdh7AA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <000001d4ba4e$d33c3220$79b49660$@net> qzTngvRgpCLmLqzTsgj72v
In-Reply-To: qzTngvRgpCLmLqzTsgj72v
Subject: RE: [PATCH] cpufreq: intel_pstate: Rework iowait boosting to be less aggressive
Date:   Mon, 11 Feb 2019 12:14:17 -0800
Message-ID: <002701d4c246$5fdd60b0$1f982210$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdS9SxyQRVy9yYGSS9iLAycbFmPvEAE+YiDA
X-CMAE-Envelope: MS4wfFAx45XOEolA/j6gX8zgmY7tmVFmyPD2OOZpKBek6dhUz5AlUxQn3wy+XP1fX+Zka8XZJwrvgpB8l1YuB3toGKwWAJwIltvNkTK57Fxgdnrous6JQf11
 TZ8QU/KyMiDSbIMiRMRDDU5KE0KV4WEfAjk4bvaXA+zS4t3Qb/l5Qq7ubgCQ5f9o3dMy+XgWd6lmwQrmM/4nZOdJrhHxOoESRZsuMy6fQWiA0trjvbwRcxkX
 /0bF0kBv2etx6M5QuJmIoL/zNil1IVJY+yEbHZifH0sDV/K0KjpjuiH2v7WrtNQZSd0J/T2E/iVpns8Sldhzmw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019.02.05 04:04 Rafael J. Wysocki wrote:
> On Friday, February 1, 2019 5:54:37 PM CET Doug Smythies wrote:
>> On 2019.01.30 16:05 Rafael J. Wysocki wrote:
>> 
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> The current iowait boosting mechanism in intel_pstate_update_util()
>>> is quite aggressive, as it goes to the maximum P-state right away,
>>> and may cause excessive amounts of energy to be used, which is not
>>> desirable and arguably isn't necessary too.
>>>
>>> Follow commit a5a0809bc58e ("cpufreq: schedutil: Make iowait boost
>>> more energy efficient") that reworked the analogous iowait boost
>>> mechanism in the schedutil governor and make the iowait boosting
>>> in intel_pstate_update_util() work along the same lines.
>>> 
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>  drivers/cpufreq/intel_pstate.c |   46 +++++++++++++++++++++++++----------------
>>>  1 file changed, 29 insertions(+), 17 deletions(-)
>>>
>>> Index: linux-pm/drivers/cpufreq/intel_pstate.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>>> +++ linux-pm/drivers/cpufreq/intel_pstate.c
>>> @@ -50,6 +50,8 @@
>>>  #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
>>>  #define fp_toint(X) ((X) >> FRAC_BITS)
>>> 
>>> +#define ONE_EIGHTH_FP ((int64_t)1 << (FRAC_BITS - 3))
>>> +
>>>  #define EXT_BITS 6
>>>  #define EXT_FRAC_BITS (EXT_BITS + FRAC_BITS)
>>>  #define fp_ext_toint(X) ((X) >> EXT_FRAC_BITS)
>>> @@ -1678,17 +1680,14 @@ static inline int32_t get_avg_pstate(str
>>>  static inline int32_t get_target_pstate(struct cpudata *cpu)
>>>  {
>>> 	struct sample *sample = &cpu->sample;
>>> -	int32_t busy_frac, boost;
>>> +	int32_t busy_frac;
>>> 	int target, avg_pstate;
>>> 
>>> 	busy_frac = div_fp(sample->mperf << cpu->aperf_mperf_shift,
>>> 			   sample->tsc);
>>> 
>>> -	boost = cpu->iowait_boost;
>>> -	cpu->iowait_boost >>= 1;
>>> -
>>> -	if (busy_frac < boost)
>>> -		busy_frac = boost;
>>> +	if (busy_frac < cpu->iowait_boost)
>>> +		busy_frac = cpu->iowait_boost;
>>> 
>>> 	sample->busy_scaled = busy_frac * 100;
>>> 
>>> @@ -1767,22 +1766,35 @@ static void intel_pstate_update_util(str
>>> 	if (smp_processor_id() != cpu->cpu)
>>>  		return;
>>>
>>> +	delta_ns = time - cpu->last_update;
>>> 	if (flags & SCHED_CPUFREQ_IOWAIT) {
>>> -		cpu->iowait_boost = int_tofp(1);
>>> -		cpu->last_update = time;
>>> -		/*
>>> -		 * The last time the busy was 100% so P-state was max anyway
>>> -		 * so avoid overhead of computation.
>>> -		 */
>>> -		if (fp_toint(cpu->sample.busy_scaled) == 100)
>>> -			return;
>>> -
>>> -		goto set_pstate;
>>> +		/* Start over if the CPU may have been idle. */
>>> +		if (delta_ns > TICK_NSEC) {
>>> +			cpu->iowait_boost = ONE_EIGHTH_FP;
>>> +		} else if (cpu->iowait_boost) {
>>> +			cpu->iowait_boost <<= 1;
>>> +			if (cpu->iowait_boost >= int_tofp(1)) {
>>> +				cpu->iowait_boost = int_tofp(1);
>>> +				cpu->last_update = time;
>>> +				/*
>>> +				 * The last time the busy was 100% so P-state
>>> +				 * was max anyway, so avoid the overhead of
>>> +				 * computation.
>>> +				 */
>>> +				if (fp_toint(cpu->sample.busy_scaled) == 100)
>>> +					return;
>> 
>> Hi Rafael,
>> 
>> By exiting here, the trace, if enabled, is also bypassed.
>> We want the trace sample.
>
> Fair enough, but the return is there regardless of this patch.
>
> Maybe it should be fixed separately?

O.K.

>> Also, there is a generic:
>> "If the target ptstate is the same as before, then don't set it"
>> later on.
>> Suggest to delete this test and exit condition. (I see that this early
>> exit was done before also.)
>
> Well, exactly.
>
> It is not unreasonable to boost the frequency right away for an IO-waiter
> without waiting for the next sample time IMO.

I agree, but am just saying that it should include a trace sample, otherwise
it is difficult to understand what happened.

By the way, I forgot to mention before, I tried the patch and it does prevent
CPU frequency spikes to maximum every few seconds in a very idle system.

... Doug


