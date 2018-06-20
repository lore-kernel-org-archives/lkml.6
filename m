Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EE6C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E45520846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E45520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeFTFBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:01:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750831AbeFTFBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:01:10 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5K4x19G137477
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:01:09 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jqae23ag2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:01:09 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 01:01:08 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 01:01:05 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5K5147W3801598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 05:01:04 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABD96124054;
        Wed, 20 Jun 2018 02:02:47 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73E6E124064;
        Wed, 20 Jun 2018 02:02:47 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 02:02:47 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 38D0E2E2E44; Wed, 20 Jun 2018 10:31:03 +0530 (IST)
Date:   Wed, 20 Jun 2018 10:31:03 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH 3/3] powernv/cpuidle: Use parsed device tree values for
 cpuidle_init
Reply-To: ego@linux.vnet.ibm.com
References: <1529384668-27548-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1529384668-27548-4-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529384668-27548-4-git-send-email-akshay.adiga@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18062005-0068-0000-0000-0000030B99E9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009224; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049561; UDB=6.00537803; IPR=6.00828535;
 MB=3.00021751; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-20 05:01:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062005-0069-0000-0000-000044BEE45B
Message-Id: <20180620050103.GC21984@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akshay,

On Tue, Jun 19, 2018 at 10:34:28AM +0530, Akshay Adiga wrote:
> Export pnv_idle_states and nr_pnv_idle_states so that its accessible to
> cpuidle driver. Use properties from pnv_idle_states structure for powernv
> cpuidle_init.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/cpuidle.h |  2 ++
>  drivers/cpuidle/cpuidle-powernv.c  | 49 +++++++++++++++++++++++---------------
>  2 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index 55ee7e3..1446747 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -93,6 +93,8 @@ struct pnv_idle_states_t {
>  	u32 flags;
>  };
> 
> +extern struct pnv_idle_states_t *pnv_idle_states;
> +extern int nr_pnv_idle_states;
>  extern u32 pnv_fastsleep_workaround_at_entry[];
>  extern u32 pnv_fastsleep_workaround_at_exit[];
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index d29e4f0..de8ba26 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -285,6 +285,11 @@ static int powernv_add_idle_states(void)
>  		goto out;
>  	}
> 
> +	if (nr_pnv_idle_states <= 0) {
> +		pr_warn("opal: No idle states found\n");

We would have a warning of this type in the powernv/idle.c right ? We
don't need to warn again. Or at least have a different warning
something like: 

      	         pr_warn("cpuidle: Only snooze state is available\n");
> +		goto out;
> +	}

> +
>  	/* Read values of any property to determine the num of idle states */
>  	dt_idle_states = of_property_count_u32_elems(power_mgt, "ibm,cpu-idle-state-flags");


We don't need to get dt_idle_states from the device tree now that we
have nr_pnv_idle_states. 


>  	if (dt_idle_states < 0) {
> @@ -338,7 +343,7 @@ static int powernv_add_idle_states(void)
>  	 * If the idle states use stop instruction, probe for psscr values
>  	 * and psscr mask which are necessary to specify required stop level.
>  	 */
> -	has_stop_states = (flags[0] &
> +	has_stop_states = (pnv_idle_states[0].flags &
>  			   (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP));
>  	if (has_stop_states) {
>  		count = of_property_count_u64_elems(power_mgt,
> @@ -387,51 +392,55 @@ static int powernv_add_idle_states(void)
>  						residency_ns, dt_idle_states);
>  	}
> 
> -	for (i = 0; i < dt_idle_states; i++) {
> +	for (i = 0; i < nr_pnv_idle_states; i++) {
>  		unsigned int exit_latency, target_residency;
>  		bool stops_timebase = false;
> +		struct pnv_idle_states_t *state = &pnv_idle_states[i];
> 
>  		/*
>  		 * Skip the platform idle state whose flag isn't in
> -		 * the supported_cpuidle_states flag mask.
> +		 * the supported_pnv_idle_states flag mask.
>  		 */
> -		if ((flags[i] & supported_flags) != flags[i])
> +		if ((state->flags & supported_flags) !=
> +				state->flags)
>  			continue;
>  		/*
>  		 * If an idle state has exit latency beyond
>  		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
>  		 * in cpu-idle.
>  		 */
> -		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
> +		if (state->latency_ns > POWERNV_THRESHOLD_LATENCY_NS)
>  			continue;
>  		/*
>  		 * Firmware passes residency and latency values in ns.
>  		 * cpuidle expects it in us.
>  		 */
> -		exit_latency = DIV_ROUND_UP(latency_ns[i], 1000);
> +		exit_latency = DIV_ROUND_UP(state->latency_ns, 1000);
>  		if (!rc)
> -			target_residency = DIV_ROUND_UP(residency_ns[i], 1000);
> +			target_residency = DIV_ROUND_UP(state->residency_ns, 1000);
>  		else
>  			target_residency = 0;
> 
>  		if (has_stop_states) {
> -			int err = validate_psscr_val_mask(&psscr_val[i],
> -							  &psscr_mask[i],
> -							  flags[i]);

> +			int err;
> +			err = validate_psscr_val_mask(&state->pm_ctrl_reg_val,
> +						      &state->pm_ctrl_reg_mask,
> +						      state->flags);
>  			if (err) {
> -				report_invalid_psscr_val(psscr_val[i], err);
> +				report_invalid_psscr_val(state->pm_ctrl_reg_val,
> +							 err);
>  				continue;
>  			}

We have already validated the states once. We should simply use the
result here.


>  		}
> 
> -		if (flags[i] & OPAL_PM_TIMEBASE_STOP)
> +		if (state->flags & OPAL_PM_TIMEBASE_STOP)
>  			stops_timebase = true;
> 
>  		/*
>  		 * For nap and fastsleep, use default target_residency
>  		 * values if f/w does not expose it.
>  		 */
> -		if (flags[i] & OPAL_PM_NAP_ENABLED) {
> +		if (state->flags & OPAL_PM_NAP_ENABLED) {
>  			if (!rc)
>  				target_residency = 100;
>  			/* Add NAP state */
> @@ -439,10 +448,11 @@ static int powernv_add_idle_states(void)
>  					  CPUIDLE_FLAG_NONE, nap_loop,
>  					  target_residency, exit_latency, 0, 0);
>  		} else if (has_stop_states && !stops_timebase) {
> -			add_powernv_state(nr_idle_states, names[i],
> +			add_powernv_state(nr_idle_states, state->name,
>  					  CPUIDLE_FLAG_NONE, stop_loop,
>  					  target_residency, exit_latency,
> -					  psscr_val[i], psscr_mask[i]);
> +					  state->pm_ctrl_reg_val,
> +					  state->pm_ctrl_reg_mask);
>  		}
> 
>  		/*
> @@ -450,8 +460,8 @@ static int powernv_add_idle_states(void)
>  		 * within this config dependency check.
>  		 */
>  #ifdef CONFIG_TICK_ONESHOT
> -		else if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
> -			 flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
> +		else if (state->flags & OPAL_PM_SLEEP_ENABLED ||
> +			 state->flags & OPAL_PM_SLEEP_ENABLED_ER1) {
>  			if (!rc)
>  				target_residency = 300000;
>  			/* Add FASTSLEEP state */
> @@ -460,10 +470,11 @@ static int powernv_add_idle_states(void)
>  					  fastsleep_loop,
>  					  target_residency, exit_latency, 0, 0);
>  		} else if (has_stop_states && stops_timebase) {
> -			add_powernv_state(nr_idle_states, names[i],
> +			add_powernv_state(nr_idle_states, state->name,
>  					  CPUIDLE_FLAG_TIMER_STOP, stop_loop,
>  					  target_residency, exit_latency,
> -					  psscr_val[i], psscr_mask[i]);
> +					  state->pm_ctrl_reg_val,
> +					  state->pm_ctrl_reg_mask);
>  		}
>  #endif
>  		else
> -- 
> 2.5.5
> 

