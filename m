Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED387C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A362920871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A362920871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753475AbeFTExG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:53:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751753AbeFTExB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:53:01 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5K4n9AG014356
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 00:53:00 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jqe9tuscr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 00:53:00 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 20 Jun 2018 00:53:00 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Jun 2018 00:52:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5K4qv2815466804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Jun 2018 04:52:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48944B2067;
        Wed, 20 Jun 2018 00:52:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7340B2064;
        Wed, 20 Jun 2018 00:52:45 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jun 2018 00:52:45 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 212DB2E2E13; Wed, 20 Jun 2018 10:22:55 +0530 (IST)
Date:   Wed, 20 Jun 2018 10:22:55 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au
Subject: Re: [PATCH 2/3] cpuidle/powernv: Change platform init to avoid
 reparsing dt
Reply-To: ego@linux.vnet.ibm.com
References: <1529384668-27548-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1529384668-27548-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529384668-27548-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
x-cbid: 18062004-0040-0000-0000-00000442AC35
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009224; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01049559; UDB=6.00537801; IPR=6.00828532;
 MB=3.00021751; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-20 04:52:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062004-0041-0000-0000-00000848BBDB
Message-Id: <20180620045255.GB21984@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akshay,


On Tue, Jun 19, 2018 at 10:34:27AM +0530, Akshay Adiga wrote:
> The required data is accessible from cpuidle_states structure and
> nr_cpu_idle_states. This patch makes changes to avoid reparsing and use
> data from these structures.
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 37 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 07be984..0a62611 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -624,8 +624,7 @@ int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
>   * @dt_idle_states: Number of idle state entries
>   * Returns 0 on success
>   */
> -static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
> -					int dt_idle_states)
> +static int __init pnv_power9_idle_init(void)
>  {
>  	u64 max_residency_ns = 0;
>  	int i;
> @@ -644,7 +643,7 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>  	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
>  	 */
>  	pnv_first_deep_stop_state = MAX_STOP_STATE;
> -	for (i = 0; i < dt_idle_states; i++) {
> +	for (i = 0; i < nr_pnv_idle_states; i++) {
>  		int err;
>  		struct pnv_idle_states_t *state = &pnv_idle_states[i];
>  		u64 psscr_rl = state->pm_ctrl_reg_val & PSSCR_RL_MASK;

These above two hunks could be folded into the first patch.

> @@ -704,41 +703,21 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
>   */
>  static void __init pnv_probe_idle_states(void)

Can we move the remaining content of this function into the calling
function pnv_init_idle_states() ? That way...

>  {
> -	struct device_node *np;
> -	int dt_idle_states;
> -	u32 *flags = NULL;
>  	int i;
> 
> -	np = of_find_node_by_path("/ibm,opal/power-mgt");
> -	if (!np) {
> -		pr_warn("opal: PowerMgmt Node not found\n");
> -		goto out;
> -	}
> -	dt_idle_states = of_property_count_u32_elems(np,
> -			"ibm,cpu-idle-state-flags");
> -	if (dt_idle_states < 0) {
> +	if (nr_pnv_idle_states < 0) {

... This reduntant check can be removed. Because nr_pnv_idle_states is initialized to
zero) and if there is an error in parsing the device tree we don't set
up this value. If there is no error, then nr_pnv_idle_states is a
positive value. 



>  		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
> -		goto out;
> -	}
> -
> -	flags = kcalloc(dt_idle_states, sizeof(*flags),  GFP_KERNEL);
> -
> -	if (of_property_read_u32_array(np,
> -			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
> -		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
> -		goto out;
> +		return;
>  	}
> 
>  	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> -		if (pnv_power9_idle_init(np, flags, dt_idle_states))
> -			goto out;
> +		if (pnv_power9_idle_init())

There cannot any longer be a failure in pnv_power9_idle_init() after
the first patch, since we always return a 0. So  this if condition can be removed.

> +			return;
>  	}
> 
> -	for (i = 0; i < dt_idle_states; i++)
> -		supported_cpuidle_states |= flags[i];
> +	for (i = 0; i < nr_pnv_idle_states; i++)
> +		supported_cpuidle_states |= pnv_idle_states[i].flags;

Ideally we should be setting the supported_cpuidle_states flags after
all the validatations have been done, including the ones for stop-api
initialization.

> 
> -out:
> -	kfree(flags);
>  }
> 
>  /*
> -- 
> 2.5.5
> 

