Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 41018C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FC7208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nR9eWbO8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JTAQbHjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2FC7208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754580AbeFNGzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:55:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35916 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeFNGzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:55:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3E1ED60159; Thu, 14 Jun 2018 06:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528959304;
        bh=VHzarlwE8JKB/FK1mP4eYbM6rDF8F8wrySH7ULVkj1U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nR9eWbO8rrdNLZFilSbpe5Cvtn7YyuQ/575RW1yNjrxzrl48UqeFx5UaTH9LUrIt9
         te9PyB/DQ347eImQht3k2r1HuswvKw5uVf4HIOcdiRvUr7EfVfWUGxs4BLxJf3gmKP
         2yaNaJ0AvC8paDHb21Ak37KaQeCia/R8wROxsKpY=
Received: from [10.79.40.88] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C405602B8;
        Thu, 14 Jun 2018 06:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528959302;
        bh=VHzarlwE8JKB/FK1mP4eYbM6rDF8F8wrySH7ULVkj1U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JTAQbHjy2tBYQZq8hBy/38T50LlPDvzZB/C2PSqak0dS7ugGB4mA3OQ2pJz8n4gap
         mR5pj8rz8FIQXDBdZkEbzk4tOO9F4KRTDkk8Bd5dkLS3ULlvuDiOknOnzTMMr5otG7
         Ng6QLxBFD3rNgvc2T+45mis5+/fhkZY5qdCm35Bk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C405602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 6/7] soc: qcom: Add RPMh Power domain driver
To:     David Collins <collinsd@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180612044052.4402-1-rnayak@codeaurora.org>
 <20180612044052.4402-7-rnayak@codeaurora.org>
 <d438946d-3d6f-4436-27c7-3eae4559ec53@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <f6b166ee-538f-c8b7-3be5-57c20a599d47@codeaurora.org>
Date:   Thu, 14 Jun 2018 12:24:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d438946d-3d6f-4436-27c7-3eae4559ec53@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 06/14/2018 06:02 AM, David Collins wrote:
> Hello Rajendra,
> 
> On 06/11/2018 09:40 PM, Rajendra Nayak wrote:
>> The RPMh Power domain driver aggregates the corner votes from various
>> consumers for the ARC resources and communicates it to RPMh.
>>
>> We also add data for all power domains on sdm845 SoC as part of the patch.
>> The driver can be extended to support other SoCs which support RPMh
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  drivers/soc/qcom/Kconfig                |   9 +
>>  drivers/soc/qcom/Makefile               |   1 +
>>  drivers/soc/qcom/rpmhpd.c               | 427 ++++++++++++++++++++++++
>>  include/dt-bindings/power/qcom-rpmhpd.h |  31 ++
>>  4 files changed, 468 insertions(+)
>>  create mode 100644 drivers/soc/qcom/rpmhpd.c
>>  create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h
> 
> This DT header file should be included in a DT binding patch that is
> separate from the driver patch.
> 
> 
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 5c54931a7b99..7cb7eba2b997 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -74,6 +74,15 @@ config QCOM_RMTFS_MEM
>>  
>>  	  Say y here if you intend to boot the modem remoteproc.
>>  
>> +config QCOM_RPMHPD
>> +	tristate "Qualcomm RPMh Power domain driver"
>> +	depends on QCOM_RPMH && QCOM_COMMAND_DB
>> +	help
>> +	  QCOM RPMh Power domain driver to support power-domains with
>> +	  performance states. The driver communicates a performance state
>> +	  value to RPMh which then translates it into corresponding voltage
>> +	  for the voltage rail.
>> +
>>  config QCOM_RPMPD
>>  	tristate "Qualcomm RPM Power domain driver"
>>  	depends on MFD_QCOM_RPM && QCOM_SMD_RPM
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 9550c170de93..499513f63bef 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -16,3 +16,4 @@ obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
>>  obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
>>  obj-$(CONFIG_QCOM_APR) += apr.o
>>  obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>> +obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
>> new file mode 100644
>> index 000000000000..7083ec1590ff
>> --- /dev/null
>> +++ b/drivers/soc/qcom/rpmhpd.c
>> @@ -0,0 +1,427 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved.*/
>> +
>> +#include <linux/err.h>
>> +#include <linux/export.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/slab.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_opp.h>
>> +#include <soc/qcom/cmd-db.h>
>> +#include <soc/qcom/rpmh.h>
>> +#include <dt-bindings/power/qcom-rpmhpd.h>
>> +
>> +#define domain_to_rpmhpd(domain) container_of(domain, struct rpmhpd, pd)
>> +
>> +#define DEFINE_RPMHPD_AO(_platform, _name, _active)			\
>> +	static struct rpmhpd _platform##_##_active;			\
>> +	static struct rpmhpd _platform##_##_name = {			\
>> +		.pd = {	.name = #_name,	},				\
>> +		.peer = &_platform##_##_active,				\
>> +		.res_name = #_name".lvl",				\
>> +		.valid_state_mask = (BIT(RPMH_ACTIVE_ONLY_STATE) |	\
>> +					BIT(RPMH_WAKE_ONLY_STATE) |	\
>> +					BIT(RPMH_SLEEP_STATE)),		\
>> +	};								\
>> +	static struct rpmhpd _platform##_##_active = {			\
>> +		.pd = { .name = #_active, },				\
>> +		.peer = &_platform##_##_name,				\
>> +		.active_only = true,					\
>> +		.res_name = #_name".lvl",				\
>> +		.valid_state_mask = (BIT(RPMH_ACTIVE_ONLY_STATE) |	\
>> +					BIT(RPMH_WAKE_ONLY_STATE) |	\
>> +					BIT(RPMH_SLEEP_STATE)),		\> +	}
>> +
>> +#define DEFINE_RPMHPD(_platform, _name)					\
>> +	static struct rpmhpd _platform##_##_name = {			\
>> +		.pd = { .name = #_name, },				\
>> +		.res_name = #_name".lvl",				\
>> +		.valid_state_mask = BIT(RPMH_ACTIVE_ONLY_STATE),	\
>> +	}
>> +
>> +/*
>> + * This is the number of bytes used for each command DB aux data entry of an
>> + * ARC resource.
>> + */
>> +#define RPMH_ARC_LEVEL_SIZE	2
>> +#define RPMH_ARC_MAX_LEVELS	16
>> +
> 
> 
> Would you mind adding a kernel-doc comment for here for struct rpmhpd?  I
> think that would make the code clearer.  It would be good to mention the
> numbering spaces for 'corner' and 'level' elements as well as the usage of
> 'peer' and 'active_only' elements.

yes, I will, there were comments from others as well that the need for 'peer'
and when to use 'active_only' etc wasn't clear.

> 
>> +struct rpmhpd {
>> +	struct device	*dev;
>> +	struct generic_pm_domain pd;
>> +	struct rpmhpd	*peer;
>> +	const bool	active_only;
>> +	unsigned int	corner;
>> +	unsigned int	active_corner> +	u32		level[RPMH_ARC_MAX_LEVELS];
>> +	int		level_count;
>> +	bool		enabled;
>> +	const char	*res_name;
>> +	u32		addr;
>> +	u8		valid_state_mask;
>> +};
>> +
>> +struct rpmhpd_desc {
>> +	struct rpmhpd **rpmhpds;
>> +	size_t num_pds;
>> +};
>> +
>> +static DEFINE_MUTEX(rpmhpd_lock);
>> +
>> +/* sdm845 RPMh Power domains */
>> +DEFINE_RPMHPD(sdm845, ebi);
>> +DEFINE_RPMHPD_AO(sdm845, mx, mx_ao);
>> +DEFINE_RPMHPD_AO(sdm845, cx, cx_ao);
>> +DEFINE_RPMHPD(sdm845, lmx);
>> +DEFINE_RPMHPD(sdm845, lcx);
>> +DEFINE_RPMHPD(sdm845, gfx);
>> +DEFINE_RPMHPD(sdm845, mss);
>> +
>> +static struct rpmhpd *sdm845_rpmhpds[] = {
>> +	[SDM845_EBI] = &sdm845_ebi,
>> +	[SDM845_MX] = &sdm845_mx,
>> +	[SDM845_MX_AO] = &sdm845_mx_ao,
>> +	[SDM845_CX] = &sdm845_cx,
>> +	[SDM845_CX_AO] = &sdm845_cx_ao,
>> +	[SDM845_LMX] = &sdm845_lmx,
>> +	[SDM845_LCX] = &sdm845_lcx,
>> +	[SDM845_GFX] = &sdm845_gfx,
>> +	[SDM845_MSS] = &sdm845_mss,
>> +};
>> +
>> +static const struct rpmhpd_desc sdm845_desc = {
>> +	.rpmhpds = sdm845_rpmhpds,
>> +	.num_pds = ARRAY_SIZE(sdm845_rpmhpds),
>> +};
>> +
>> +static const struct of_device_id rpmhpd_match_table[] = {
>> +	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, rpmhpd_match_table);
>> +
>> +static int rpmhpd_send_corner(struct rpmhpd *pd, int state,
>> +			      unsigned int corner, bool sync)
>> +{
>> +	struct tcs_cmd cmd = {
>> +		.addr = pd->addr,
>> +		.data = corner,
>> +	};
>> +
>> +	if (sync)
>> +		return rpmh_write(pd->dev, state, &cmd, 1);
>> +	else
>> +		return rpmh_write_async(pd->dev, state, &cmd, 1);
>> +}
>> +
>> +static int rpmhpd_send_corner_sync(struct rpmhpd *pd, int state,
>> +				   unsigned int corner)
>> +{
>> +	return rpmhpd_send_corner(pd, state, corner, true);
>> +}
>> +
>> +static int rpmhpd_send_corner_async(struct rpmhpd *pd, int state,
>> +				    unsigned int corner)
>> +{
>> +	return rpmhpd_send_corner(pd, state, corner, false);
>> +};
> 
> I'm not sure about the need for rpmhpd_send_corner_sync() and
> rpmhpd_send_corner_async().  They are adding lines that aren't strictly
> needed since rpmhpd_send_corner() could be called directly instead.  Doing
> that could actually save some more lines in rpmhpd_aggregate_corner()
> below as 'active_corner > pd->active_corner' could be passed as the 'sync'
> argument so that the if statement isn't needed.  However, I also see the
> utility in not having a magic bool in the calls below.  Let's see if other
> reviewers have a preference about it one way or the other.

sure, I like what you are suggesting. I will change it unless someone else
complains.

> 
> 
>> +static void to_active_sleep(struct rpmhpd *pd, unsigned int corner,
>> +			    unsigned int *active, unsigned int *sleep)
>> +{
>> +	*active = corner;
>> +
>> +	if (pd->active_only)
>> +		*sleep = 0;
>> +	else
>> +		*sleep = *active;
>> +}
>> +
>> +/*
>> + * This function is used to aggregate the votes across the active only
>> + * resources and its peers. The aggregated votes are send to RPMh as
>> + * ACTIVE_ONLY votes (which take effect immediately), as WAKE_ONLY votes
>> + * (applied by RPMh on system wakeup) and as SLEEP votes (applied by RPMh
>> + * on system sleep).
>> + * We send ACTIVE_ONLY votes for resources without any peers. For others,
>> + * which have an active only peer, all 3 Votes are sent.
>> + */
>> +static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
>> +{
>> +	int ret = -EINVAL;
>> +	struct rpmhpd *peer = pd->peer;
>> +	unsigned int active_corner, sleep_corner;
>> +	unsigned int this_active_corner = 0, this_sleep_corner = 0;
>> +	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
>> +
>> +	to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
>> +
>> +	if (peer && peer->enabled)
>> +		to_active_sleep(peer, peer->corner, &peer_active_corner,
>> +				&peer_sleep_corner);
>> +
>> +	active_corner = max(this_active_corner, peer_active_corner);
>> +
>> +	if (pd->valid_state_mask & BIT(RPMH_ACTIVE_ONLY_STATE)) {
> 
> This condition will always be true, so this check can be removed.
> 
> 
>> +		/*
>> +		 * Wait for an ack only when we are increasing the
>> +		 * perf state of the power domain
>> +		 */
>> +		if (active_corner > pd->active_corner)
>> +			ret = rpmhpd_send_corner_sync(pd,
>> +						      RPMH_ACTIVE_ONLY_STATE,
>> +						      active_corner);
>> +		else
>> +			ret = rpmhpd_send_corner_async(pd,
>> +						       RPMH_ACTIVE_ONLY_STATE,
>> +						       active_corner);
>> +		if (ret)
>> +			return ret;
>> +		pd->active_corner = active_corner;
>> +		if (peer)
>> +			peer->active_corner = active_corner;
>> +	}
>> +
>> +	if (pd->valid_state_mask & BIT(RPMH_WAKE_ONLY_STATE)) {
> 
> This check and the one below could be changed to simply:
> 
>     if (pd->peer) {
> 
> That way, the valid_state_mask element can be removed from struct rpmhpd
> and the two if blocks can be consolidated together.  I think that
> valid_state_mask is making the code more confusing at this point than it
> is at verbosely describing the aggregation semantics.

makes sense

> 
> 
>> +		ret = rpmhpd_send_corner_async(pd, RPMH_WAKE_ONLY_STATE,
>> +					       active_corner);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	sleep_corner = max(this_sleep_corner, peer_sleep_corner);
>> +
>> +	if (pd->valid_state_mask & BIT(RPMH_SLEEP_STATE))
>> +		ret = rpmhpd_send_corner_async(pd, RPMH_SLEEP_STATE,
>> +					       sleep_corner);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rpmhpd_power_on(struct generic_pm_domain *domain)
>> +{
>> +	struct rpmhpd *pd = domain_to_rpmhpd(domain);
>> +	int ret = 0;
>> +
>> +	mutex_lock(&rpmhpd_lock);
>> +
>> +	pd->enabled = true;
> 
> It would probably be better to remove this line and add the following
> after the rpmhpd_aggregate_corner() call:
> 
> if (!ret)
> 	pd->enabled = true;
> 
> Only the peer 'enabled' value is checked in rpmhpd_aggregate_corner() so
> architecturally, it doesn't matter if the value is configured before or
> after the call.

agree, a failure to communicate with rpmh would then keep it in disabled state.
 
> 
> 
>> +
>> +	if (pd->corner)
>> +		ret = rpmhpd_aggregate_corner(pd, pd->corner);
>> +
>> +	mutex_unlock(&rpmhpd_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rpmhpd_power_off(struct generic_pm_domain *domain)
>> +{
>> +	struct rpmhpd *pd = domain_to_rpmhpd(domain);
>> +	int ret = 0;
>> +
>> +	mutex_lock(&rpmhpd_lock);
>> +
>> +	if (pd->level[0] == 0)
>> +		ret = rpmhpd_aggregate_corner(pd, 0);
> 
> I'm not sure that we want to have the 'pd->level[0] == 0' check,
> especially when considering aggregation with the peer pd.  I understand
> its intention to try to keep enable state and level setting orthogonal.
> However, as it stands now, the final request sent to hardware would differ
> depending upon the order of calls.  Consider the following example.
> 
> Initial state:
> pd->level[0] == 0
> pd->corner = 5, pd->enabled = true, pd->active_only = false
> pd->peer->corner = 7, pd->peer->enabled = true, pd->peer->active_only = true
> 
> Outstanding requests:
> RPMH_ACTIVE_ONLY_STATE = 7, RPMH_WAKE_ONLY_STATE = 7, RPMH_SLEEP_STATE = 5
> 
> Case A:
> 	1. set pd->corner = 6
> 		--> new value request: RPMH_SLEEP_STATE = 6
> 		--> duplicate value requests: RPMH_ACTIVE_ONLY_STATE = 7,
> 			RPMH_WAKE_ONLY_STATE = 7
> 	2. power_off pd->peer
> 		--> no requests

I am not sure why there would be no requests, since we do end up aggregating
with pd->peer->corner = 0.
So the final state would be

RPMH_ACTIVE_ONLY_STATE = max(6, 0) = 6
RPMH_WAKE_ONLY_STATE = 6
RPMH_SLEEP_STATE = max(6, 0) = 6

> 
> 	Final state:
> 	RPMH_ACTIVE_ONLY_STATE = 7
> 	RPMH_WAKE_ONLY_STATE = 7
> 	RPMH_SLEEP_STATE = 6
> 
> Case B:
> 	1. power_off pd->peer
> 		--> no requests

Here it would be again be aggregation based on pd->peer->corner = 0
so,
RPMH_ACTIVE_ONLY_STATE = max(5, 0) = 5
RPMH_WAKE_ONLY_STATE = 5
RPMH_SLEEP_STATE = max(5, 0) = 5

> 	2. set pd->corner = 6
> 		--> new value requests: RPMH_ACTIVE_ONLY_STATE = 6,
> 		       RPMH_WAKE_ONLY_STATE = 6, RPMH_SLEEP_STATE = 6
> 
> 	Final state:
> 	RPMH_ACTIVE_ONLY_STATE = 6
> 	RPMH_WAKE_ONLY_STATE = 6
> 	RPMH_SLEEP_STATE = 6

correct,
RPMH_ACTIVE_ONLY_STATE = max(6, 0) = 6
RPMH_WAKE_ONLY_STATE = 6
RPMH_SLEEP_STATE = max(6, 0) = 6

> 
> Without the check, Linux would vote for the lowest supported level when
> power_off is called.  This seems semantically reasonable given that the
> consumer is ok with the power domain going fully off and that would be the
> closest that we can get.

So are you suggesting I replace

>> +	if (pd->level[0] == 0)
>> +		ret = rpmhpd_aggregate_corner(pd, 0);

with

>> +	ret = rpmhpd_aggregate_corner(pd, pd->level[0]);

I can see what you said above makes sense but if its
> Initial state:
> pd->level[0] != 0

Was that what you meant?

I can't seem to see any ARC resources on 845 which seem to 
have a 'pd->level[0] != 0' but looks like thats certainly a
possibility we need to handle?

> 
> 
>> +
>> +	if (!ret)
>> +		pd->enabled = false;
>> +
>> +	mutex_unlock(&rpmhpd_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int rpmhpd_set_performance(struct generic_pm_domain *domain,
>> +				  unsigned int state)
> 
> The code might be a bit more readable if 'state' is changed to 'level'.
> 
> Also, is there a particular reason that this is named
> rpmhpd_set_performance() instead of rpmhpd_set_performance_state()?

no, i will change both.

> 
> 
>> +{
>> +	struct rpmhpd *pd = domain_to_rpmhpd(domain);
>> +	int ret = 0, i;
>> +
>> +	mutex_lock(&rpmhpd_lock);
>> +
>> +	for (i = 0; i < pd->level_count; i++)
>> +		if (state <= pd->level[i])
>> +			break;
>> +
>> +	if (i == pd->level_count) {
>> +		ret = -EINVAL;
>> +		dev_err(pd->dev, "invalid state=%u for domain %s",
>> +			state, pd->pd.name);
>> +			goto out;
> 
> One level of indentation should be removed from this line.

right

> 
> 
>> +	}
>> +
>> +	pd->corner = i;
>> +
>> +	if (!pd->enabled)
>> +		goto out;
>> +
>> +	ret = rpmhpd_aggregate_corner(pd, i);
> 
> Would it be worthwhile to roll back the pd->corner value in the case of an
> error?

yes, makes sense

> 
> 
>> +out:
>> +	mutex_unlock(&rpmhpd_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static unsigned int rpmhpd_get_performance(struct generic_pm_domain *genpd,
>> +					   struct dev_pm_opp *opp)
> 
> Is there a particular reason that this is named rpmhpd_get_performance()
> instead of rpmhpd_get_performance_state()?

nop, will change

> 
> 
>> +{
>> +	struct device_node *np;
>> +	unsigned int corner = 0;
> 
> Please change 'corner' to 'level' for consistency.  In this driver "level"
> values are in the vlvl RPMH_REGULATOR_LEVEL_* numbering space and "corner"
> values are in the hlvl 0-15 numbering space.

right, i will change things to be more consistent and less confusing

> 
> 
>> +
>> +	np = dev_pm_opp_get_of_node(opp);
>> +	if (of_property_read_u32(np, "qcom,level", &corner)) {
>> +		pr_err("%s: missing 'qcom,level' property\n", __func__);
>> +		return 0;
>> +	}
>> +
>> +	of_node_put(np);
>> +
>> +	return corner;
>> +}
>> +
>> +static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>> +{
>> +	int i, j, len, ret;
>> +	u8 buf[RPMH_ARC_MAX_LEVELS * RPMH_ARC_LEVEL_SIZE];
> 
> Minor: It might look better to list buf[] first.

sure

> 
> 
>> +
>> +	len = cmd_db_read_aux_data_len(rpmhpd->res_name);
>> +	if (len <= 0)
>> +		return len;
>> +
>> +	if (len > RPMH_ARC_MAX_LEVELS * RPMH_ARC_LEVEL_SIZE)
>> +		return -EINVAL;
> 
> 'else if' could be used here.

okay

> 
> 
>> +
>> +	ret = cmd_db_read_aux_data(rpmhpd->res_name, buf, len);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	rpmhpd->level_count = len / RPMH_ARC_LEVEL_SIZE;
>> +
>> +	for (i = 0; i < rpmhpd->level_count; i++) {
>> +		rpmhpd->level[i] = 0;
>> +		for (j = 0; j < RPMH_ARC_LEVEL_SIZE; j++)
>> +			rpmhpd->level[i] |=
>> +				buf[i * RPMH_ARC_LEVEL_SIZE + j] << (8 * j);
>> +
>> +		/*
>> +		 * The AUX data may be zero padded.  These 0 valued entries at
>> +		 * the end of the map must be ignored.
>> +		 */
>> +		if (i > 0 && rpmhpd->level[i] == 0) {
>> +			rpmhpd->level_count = i;
>> +			break;
>> +		}
>> +		pr_dbg("%s: ARC hlvl=%2d --> vlvl=%4u\n", rpmhpd->res_name, i,
>> +		       rpmhpd->level[i]);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rpmhpd_probe(struct platform_device *pdev)
>> +{
>> +	int i, ret;
>> +	size_t num;
>> +	struct genpd_onecell_data *data;
>> +	struct rpmhpd **rpmhpds;
>> +	const struct rpmhpd_desc *desc;
>> +
>> +	desc = of_device_get_match_data(&pdev->dev);
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	rpmhpds = desc->rpmhpds;
>> +	num = desc->num_pds;
>> +
>> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->domains = devm_kcalloc(&pdev->dev, num, sizeof(*data->domains),
>> +				     GFP_KERNEL);
>> +	data->num_domains = num;
>> +
>> +	ret = cmd_db_ready();
>> +	if (ret) {
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(&pdev->dev, "Command DB unavailable, ret=%d\n",
>> +				ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < num; i++) {
>> +		if (!rpmhpds[i]) {
>> +			dev_warn(&pdev->dev, "rpmhpds[] with empty entry at index=%d\n",
>> +				 i);
> 
> Minor: This could be simplified to:
> 
> dev_warn(&pdev->dev, "rpmhpds[%d] is empty\n", i);

will do

> 
> 
>> +			continue;
>> +		}
>> +
>> +		rpmhpds[i]->dev = &pdev->dev;
>> +		rpmhpds[i]->addr = cmd_db_read_addr(rpmhpds[i]->res_name);
>> +		if (!rpmhpds[i]->addr) {
>> +			dev_err(&pdev->dev, "Could not find RPMh address for resource %s\n",
>> +				rpmhpds[i]->res_name);
>> +			return -ENODEV;
>> +		}
>> +
>> +		ret = cmd_db_read_slave_id(rpmhpds[i]->res_name);
>> +		if (ret != CMD_DB_HW_ARC) {
>> +			dev_err(&pdev->dev, "RPMh slave ID mismatch\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		ret = rpmhpd_update_level_mapping(rpmhpds[i]);
>> +		if (ret)
>> +			return ret;
>> +
>> +		rpmhpds[i]->pd.power_off = rpmhpd_power_off;
>> +		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
>> +		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance;
>> +		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance;
>> +		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
>> +
>> +		data->domains[i] = &rpmhpds[i]->pd;
>> +	}
>> +
>> +	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
>> +}
>> +
>> +static int rpmhpd_remove(struct platform_device *pdev)
>> +{
>> +	of_genpd_del_provider(pdev->dev.of_node);
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver rpmhpd_driver = {
>> +	.driver = {
>> +		.name = "qcom-rpmhpd",
>> +		.of_match_table = rpmhpd_match_table,
>> +	},
>> +	.probe = rpmhpd_probe,
>> +	.remove = rpmhpd_remove,
>> +};
>> +
>> +static int __init rpmhpd_init(void)
>> +{
>> +	return platform_driver_register(&rpmhpd_driver);
>> +}
>> +core_initcall(rpmhpd_init);
>> +
>> +static void __exit rpmhpd_exit(void)
>> +{
>> +	platform_driver_unregister(&rpmhpd_driver);
>> +}
>> +module_exit(rpmhpd_exit);
>> +
>> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPMh Power Domain Driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:qcom-rpmhpd");
>> diff --git a/include/dt-bindings/power/qcom-rpmhpd.h b/include/dt-bindings/power/qcom-rpmhpd.h
>> new file mode 100644
>> index 000000000000..b01ae2452603
>> --- /dev/null
>> +++ b/include/dt-bindings/power/qcom-rpmhpd.h
>> @@ -0,0 +1,31 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
>> +
>> +#ifndef _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>> +#define _DT_BINDINGS_POWER_QCOM_RPMHPD_H
>> +
>> +/* SDM845 Power Domain Indexes */
>> +#define SDM845_EBI	0
>> +#define SDM845_MX	1
>> +#define SDM845_MX_AO	2
>> +#define SDM845_CX	3
>> +#define SDM845_CX_AO	4
>> +#define SDM845_LMX	5
>> +#define SDM845_LCX	6
>> +#define SDM845_GFX	7
>> +#define SDM845_MSS	8
>> +
>> +/* SDM845 Power Domain performance levels */
>> +#define RPMH_REGULATOR_LEVEL_OFF	0
> 
> Do you really want to specify 0 as a performance level?  This would allow
> an OFF request to be sent by setting the performance state and without
> disabling the power domain.  I would suggest removing it.
> 
> It will also lead to rpmhpd_get_performance() returning 0 in a non-error case.

yes, I'll drop it. Thanks again for taking a look at these patches.

thanks,
Rajendra


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
