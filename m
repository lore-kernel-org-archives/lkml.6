Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9673C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3B321872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="wnc6kxSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfBARCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:02:52 -0500
Received: from cmta18.telus.net ([209.171.16.91]:53685 "EHLO cmta18.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfBARCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:02:52 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Feb 2019 12:02:51 EST
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id pc5QgCMJFM04Npc5RgQwp6; Fri, 01 Feb 2019 09:54:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1549040083; bh=vEYaE2bfobxxD7I1ydWXSGW9TJdgFLumYHZU9Lh3D5M=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=wnc6kxSrDLgr0fgYWjbVFffokNS1ACLD8B0OPVQJNrrSRMEIfaDuLQYsBcSRpowxK
         YSyjLTXZWDHsdANaCXWmVxBU23RUFElAT1eYQYl0w9NwyXFFm5JggkYkbOch+FPj6x
         mnUxeIl3p6N4BSfCSzcmGGPYKbjCPrOGa4mu/PmZjaPQD6LK7mhRMDJyNG51hq8m2K
         icVWe5+9q4bdFsLnE+sox/t+IqZGwQGaPGwdDGVYKfID+rX6PMUCb91w6tc2rLQvfY
         dc9rImqnZPkGyDk3A7/VocWrHXQ9YxQUDq3chbqoi4KgZV+oN6IRapT16lvrAR/ets
         tvNA7b7DSdIiQ==
X-Authority-Analysis: v=2.3 cv=aNWOVo1m c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8
 a=FAqN8EIyFPYRTs4D8IwA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: ozrUgGQWNCLmLozrWgF2we
In-Reply-To: ozrUgGQWNCLmLozrWgF2we
Subject: RE: [PATCH] cpufreq: intel_pstate: Rework iowait boosting to be less aggressive
Date:   Fri, 1 Feb 2019 08:54:37 -0800
Message-ID: <000001d4ba4e$d33c3220$79b49660$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdS4+Ld2b2w+LNdDQuKfsz2z5lg1CwBVC2DQ
Content-Language: en-ca
X-CMAE-Envelope: MS4wfH/Wufd04VLMepO643M07yxME5Ib7v0svb6f/ywITtnSWNJdmYTStgy6ud0pPnr7a5saMxgo9y5ylCs/XNK1wEXVxM/rgv8KqNYNs0/wnCHyJYpbMlFp
 Ay57gBOw2cnjMejwJF5RqyV/bJYfa+ViXj7v1ej8hUFa1tQUD8PYFLvL6qy9xuVffRkyp5atkgDJ9Xb3vSKEvKgvMapATbADNrxhPTDPNGOBkta1AzqCg/Wr
 E4Om+3tZ3iCEkyLVmd/Kr/vq5cqp+eCXR1Y8e7i7xaHfFTSzi+Xj6XeTCX7WyqzySssI9pPPhUG7oJ4evo4Mug==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019.01.30 16:05 Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The current iowait boosting mechanism in intel_pstate_update_util()
> is quite aggressive, as it goes to the maximum P-state right away,
> and may cause excessive amounts of energy to be used, which is not
> desirable and arguably isn't necessary too.
>
> Follow commit a5a0809bc58e ("cpufreq: schedutil: Make iowait boost
> more energy efficient") that reworked the analogous iowait boost
> mechanism in the schedutil governor and make the iowait boosting
> in intel_pstate_update_util() work along the same lines.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c |   46 +++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -50,6 +50,8 @@
>  #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
>  #define fp_toint(X) ((X) >> FRAC_BITS)
> 
> +#define ONE_EIGHTH_FP ((int64_t)1 << (FRAC_BITS - 3))
> +
>  #define EXT_BITS 6
>  #define EXT_FRAC_BITS (EXT_BITS + FRAC_BITS)
>  #define fp_ext_toint(X) ((X) >> EXT_FRAC_BITS)
> @@ -1678,17 +1680,14 @@ static inline int32_t get_avg_pstate(str
>  static inline int32_t get_target_pstate(struct cpudata *cpu)
>  {
> 	struct sample *sample = &cpu->sample;
> -	int32_t busy_frac, boost;
> +	int32_t busy_frac;
> 	int target, avg_pstate;
> 
> 	busy_frac = div_fp(sample->mperf << cpu->aperf_mperf_shift,
> 			   sample->tsc);
> 
> -	boost = cpu->iowait_boost;
> -	cpu->iowait_boost >>= 1;
> -
> -	if (busy_frac < boost)
> -		busy_frac = boost;
> +	if (busy_frac < cpu->iowait_boost)
> +		busy_frac = cpu->iowait_boost;
> 
> 	sample->busy_scaled = busy_frac * 100;
> 
> @@ -1767,22 +1766,35 @@ static void intel_pstate_update_util(str
> 	if (smp_processor_id() != cpu->cpu)
>  		return;
>
> +	delta_ns = time - cpu->last_update;
> 	if (flags & SCHED_CPUFREQ_IOWAIT) {
> -		cpu->iowait_boost = int_tofp(1);
> -		cpu->last_update = time;
> -		/*
> -		 * The last time the busy was 100% so P-state was max anyway
> -		 * so avoid overhead of computation.
> -		 */
> -		if (fp_toint(cpu->sample.busy_scaled) == 100)
> -			return;
> -
> -		goto set_pstate;
> +		/* Start over if the CPU may have been idle. */
> +		if (delta_ns > TICK_NSEC) {
> +			cpu->iowait_boost = ONE_EIGHTH_FP;
> +		} else if (cpu->iowait_boost) {
> +			cpu->iowait_boost <<= 1;
> +			if (cpu->iowait_boost >= int_tofp(1)) {
> +				cpu->iowait_boost = int_tofp(1);
> +				cpu->last_update = time;
> +				/*
> +				 * The last time the busy was 100% so P-state
> +				 * was max anyway, so avoid the overhead of
> +				 * computation.
> +				 */
> +				if (fp_toint(cpu->sample.busy_scaled) == 100)
> +					return;

Hi Rafael,

By exiting here, the trace, if enabled, is also bypassed.
We want the trace sample.
Also, there is a generic:
"If the target ptstate is the same as before, then don't set it"
later on.
Suggest to delete this test and exit condition. (I see that this early exit was done before also.)

> +
> +				goto set_pstate;
> +			}
> +		} else {
> +			cpu->iowait_boost = ONE_EIGHTH_FP;
> +		}
> 	} else if (cpu->iowait_boost) {
> 		/* Clear iowait_boost if the CPU may have been idle. */
> -		delta_ns = time - cpu->last_update;
> 		if (delta_ns > TICK_NSEC)
>  			cpu->iowait_boost = 0;
> +		else
> +			cpu->iowait_boost >>= 1;
> 	}
> 	cpu->last_update = time;
> 	delta_ns = time - cpu->sample.time;


