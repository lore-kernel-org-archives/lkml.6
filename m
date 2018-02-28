Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1161291-1519854040-2-327419451714976452
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519854039; b=WUN0NZgtCe64txEE6KveOduqx6HnB9KSd/goM5jHTGaoSAY
    Z0v+raEDeiGY3nt21ynC8p7zJTYoJED5iHpYxjlRQSAFwig+qbOkhG4RYeKiJybF
    q6ExUZYNvCqq22IqjtK2QgXkkqmjy5YXTPz5XvwsQy/Mij7k2q2WYnh4kbUbd+ED
    Y9jbYNBMbtTl2is4m8e4gZyljX6fBcNu3qlbuC9Qbdw9LLO0ft49TiyWKtn77bAL
    3AugwWDp7fIqigf4CtajBSuZA2YogrwPA7MzeFXDsRiHJYPxKDBPTAkQ+ILFfN4C
    GXMzIqjXng+oMH5i4YnYJvzHrrKFiRShZ+a71fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:reply-to:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:message-id:sender:list-id; s=arctest;
    t=1519854039; bh=dLJxa9MLOO4nGlnSuvdAOahl42CJqWG26WBjJK9V4Z8=; b=
    Ui8YLyt2L5y4I6vkRP7bm16/g//suPBU5QMjhmyGYVd2By78KuC5eztH/snh19sL
    IHNSd94DXREqgDJh3d5Yh1qUxEniBpUX7G4YWTeM86AtIdUCNNFhUw+UBXhIeWHq
    n7YNlxU6UOh+DfMrLiD0IG6209//HmiXwfDBfIVnjP8vsjQlQrMXarD4Jcw/1dSi
    ojePupWloLY/1ROtgDOigud0wHc0WvTXkSMfaHQk5z5zxRZYhuOq15RybiQYcnhm
    Hz/xHah4adPCGJtDvV5+2sB595rgSzzsoRQgAiwB2lixIQKQD1hPd/wH9sAWTRQa
    8du5x6G5vxx9fS2Fng1Oig==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=au1.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=au1.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=au1.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=au1.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935178AbeB1Vkf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 16:40:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932597AbeB1Vkc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 16:40:32 -0500
Subject: Re: [RESEND][PATCH] cpuidle/powernv : Restore different PSSCR for
 idle and hotplug
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: stable@vger.kernel.org, npiggin@gmail.com
Date: Thu, 01 Mar 2018 08:40:22 +1100
In-Reply-To: <1519846389-29414-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1519846389-29414-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022821-0008-0000-0000-000004D6288C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022821-0009-0000-0000-00001E6929F4
Message-Id: <1519854022.2520.12.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280262
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-01 at 01:03 +0530, Akshay Adiga wrote:
> commit 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
> states via stop API.") uses stop-api provided by the firmware to restore
> PSSCR. PSSCR restore is required for handling special wakeup. When special
> wakeup is completed, the core enters stop state based on restored PSSCR.
> 
> Currently PSSCR is restored to deepest available stop state, causing
> a idle cpu to enter deeper stop state on a special wakeup, which causes
> the cpu to hang on wakeup.
> 
> A "sensors" command which reads temperature (through DTS sensors) on idle
> cpu can trigger special wakeup.
> 
> Failed Scenario :
> Request restore of PSSCR with RL = 11
> cpu enters idle state (stop5)
>   user triggers "sensors" command
>    Assert special wakeup on cpu
>      Restores PSSCR with RL = 11  <---- Done by firmware
>       Read DTS sensor
>    Deassert special wakeup
>   cpu enters idle state (stop11) <-- Instead of stop5
> 
> Cpu hang is caused because cpu ended up in a deeper state than it requested
> 
> This patch fixes instability caused by special wakeup when stop11 is
> enabled. Requests restore of PSSCR to deepest stop state used by cpuidle.
> Only when offlining cpu, request restore of PSSCR to deepest stop state.
> On onlining cpu, request restore of PSSCR to deepest stop state used by
> cpuidle.

So if we chose a stop state, but somebody else does a special wakeup,
we'll end up going back into a *deeper* one than the one we came from ?

I still think this is broken by design. The chip should automatically
go back to the state it went to after special wakeup, thus the PPE
controlling the state should override the PSSCR value accordingly
rather than relying on those SW hoops.

> 
> Cc: <stable@vger.kernel.org> # v4.14+
> Fixes : 1e1601b38e6e ("powerpc/powernv/idle: Restore SPRs for deep idle
> states via stop API.")
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/cpuidle.h    |  2 ++
>  arch/powerpc/platforms/powernv/idle.c | 46 ++++++++++++++++++++++++++++++++---
>  drivers/cpuidle/cpuidle-powernv.c     |  1 -
>  3 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index e210a83..f52e9f1 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -67,6 +67,8 @@
>  #define ERR_EC_ESL_MISMATCH		-1
>  #define ERR_DEEP_STATE_ESL_MISMATCH	-2
>  
> +#define POWERNV_THRESHOLD_LATENCY_NS 200000
> +
>  #ifndef __ASSEMBLY__
>  /* Additional SPRs that need to be saved/restored during stop */
>  struct stop_sprs {
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 443d5ca..4b0c7d24 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -56,8 +56,11 @@ u64 pnv_first_deep_stop_state = MAX_STOP_STATE;
>   */
>  static u64 pnv_deepest_stop_psscr_val;
>  static u64 pnv_deepest_stop_psscr_mask;
> +static u64 pnv_deepest_cpuidle_psscr_val;
> +static u64 pnv_deepest_cpuidle_psscr_mask;
>  static u64 pnv_deepest_stop_flag;
>  static bool deepest_stop_found;
> +static bool deepest_cpuidle_found;
>  
>  static int pnv_save_sprs_for_deep_states(void)
>  {
> @@ -76,7 +79,14 @@ static int pnv_save_sprs_for_deep_states(void)
>  	uint64_t hid5_val = mfspr(SPRN_HID5);
>  	uint64_t hmeer_val = mfspr(SPRN_HMEER);
>  	uint64_t msr_val = MSR_IDLE;
> -	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
> +
> +	/*
> +	 * Pick deepest cpuidle psscr as the value to be
> +	 * restored through wakeup engine.
> +	 * We will request a deeper state to be restored
> +	 * in hotplug path
> +	 */
> +	uint64_t psscr_val = pnv_deepest_cpuidle_psscr_val;
>  
>  	for_each_possible_cpu(cpu) {
>  		uint64_t pir = get_hard_smp_processor_id(cpu);
> @@ -409,7 +419,7 @@ static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
>   */
>  unsigned long pnv_cpu_offline(unsigned int cpu)
>  {
> -	unsigned long srr1;
> +	u64 srr1;
>  	u32 idle_states = pnv_get_supported_cpuidle_states();
>  	u64 lpcr_val;
>  
> @@ -429,12 +439,18 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
>  	__ppc64_runlatch_off();
>  
>  	if (cpu_has_feature(CPU_FTR_ARCH_300) && deepest_stop_found) {
> -		unsigned long psscr;
> +		u64 psscr;
> +		u64 pir = get_hard_smp_processor_id(cpu);
>  
>  		psscr = mfspr(SPRN_PSSCR);
>  		psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
>  						pnv_deepest_stop_psscr_val;
> +		if (pnv_deepest_stop_psscr_val != pnv_deepest_cpuidle_psscr_val)
> +			opal_slw_set_reg(pir, P9_STOP_SPR_PSSCR, psscr);
>  		srr1 = power9_idle_stop(psscr);
> +		psscr = (psscr & ~pnv_deepest_cpuidle_psscr_mask) |
> +						pnv_deepest_cpuidle_psscr_val;
> +		opal_slw_set_reg(pir, P9_STOP_SPR_PSSCR, psscr);
>  
>  	} else if ((idle_states & OPAL_PM_WINKLE_ENABLED) &&
>  		   (idle_states & OPAL_PM_LOSE_FULL_CONTEXT)) {
> @@ -555,6 +571,7 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  	u64 *psscr_val = NULL;
>  	u64 *psscr_mask = NULL;
>  	u32 *residency_ns = NULL;
> +	u32 *latency_ns = NULL;
>  	u64 max_residency_ns = 0;
>  	int rc = 0, i;
>  
> @@ -562,6 +579,8 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
>  	residency_ns = kcalloc(dt_idle_states, sizeof(*residency_ns),
>  			       GFP_KERNEL);
> +	latency_ns = kcalloc(dt_idle_states, sizeof(*latency_ns),
> +			     GFP_KERNEL);
>  
>  	if (!psscr_val || !psscr_mask || !residency_ns) {
>  		rc = -1;
> @@ -591,6 +610,13 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  		rc = -1;
>  		goto out;
>  	}
> +	if (of_property_read_u32_array(np,
> +				       "ibm,cpu-idle-state-latencies-ns",
> +					latency_ns, dt_idle_states)) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latency-ns in DT\n");
> +		rc = -1;
> +		goto out;
> +	}
>  
>  	/*
>  	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
> @@ -621,6 +647,12 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  			continue;
>  		}
>  
> +		if (latency_ns[i] <= POWERNV_THRESHOLD_LATENCY_NS) {
> +			pnv_deepest_cpuidle_psscr_val = psscr_val[i];
> +			pnv_deepest_cpuidle_psscr_mask = psscr_mask[i];
> +			deepest_cpuidle_found = true;
> +		}
> +
>  		if (max_residency_ns < residency_ns[i]) {
>  			max_residency_ns = residency_ns[i];
>  			pnv_deepest_stop_psscr_val = psscr_val[i];
> @@ -653,6 +685,14 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  			pnv_deepest_stop_psscr_mask);
>  	}
>  
> +	if (unlikely(!deepest_cpuidle_found)) {
> +		pr_warn("cpuidle-powernv: No suitable deepest CPU-idle state found");
> +	} else {
> +		pr_info("cpuidle-powernv: Deepest cpuidle: psscr = 0x%016llx,mask=0x%016llx\n",
> +			pnv_deepest_cpuidle_psscr_val,
> +			pnv_deepest_cpuidle_psscr_mask);
> +	}
> +
>  	pr_info("cpuidle-powernv: Requested Level (RL) value of first deep stop = 0x%llx\n",
>  		pnv_first_deep_stop_state);
>  out:
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 1a8234e..620765d 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -26,7 +26,6 @@
>   * Expose only those Hardware idle states via the cpuidle framework
>   * that have latency value below POWERNV_THRESHOLD_LATENCY_NS.
>   */
> -#define POWERNV_THRESHOLD_LATENCY_NS 200000
>  
>  static struct cpuidle_driver powernv_idle_driver = {
>  	.name             = "powernv_idle",
