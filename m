Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B4BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB2920844
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NpwDDoXD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NpwDDoXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB2920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933496AbeGIQmg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:42:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeGIQme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:42:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A3035607DC; Mon,  9 Jul 2018 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531154553;
        bh=jFrJY5haILeeWIxDEUhOnxFavgZKxIkfkQlMs3n34Mg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NpwDDoXDA16e+jpsc7axsy6bqS7tfpWbsbTW2SUUqfQ8RrNcsCnp+8w7Oyb6FvKBs
         tkJUdJnbnj/fVRZKbzdU6KxZfThYRW2iKotEs6B1ImwHznPx/ne52rgYNlfS2fUMZp
         hYCORXsO+SkG46adqIEDV29yPVSSjSR7G4W0bBZU=
Received: from [10.226.58.143] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pprakash@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5B35602AE;
        Mon,  9 Jul 2018 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531154553;
        bh=jFrJY5haILeeWIxDEUhOnxFavgZKxIkfkQlMs3n34Mg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NpwDDoXDA16e+jpsc7axsy6bqS7tfpWbsbTW2SUUqfQ8RrNcsCnp+8w7Oyb6FvKBs
         tkJUdJnbnj/fVRZKbzdU6KxZfThYRW2iKotEs6B1ImwHznPx/ne52rgYNlfS2fUMZp
         hYCORXsO+SkG46adqIEDV29yPVSSjSR7G4W0bBZU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5B35602AE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pprakash@codeaurora.org
Subject: Re: [PATCH v3] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To:     George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net
References: <1531131048-60762-1-git-send-email-george.cherian@cavium.com>
From:   "Prakash, Prashanth" <pprakash@codeaurora.org>
Message-ID: <802dd310-a26c-3baa-696e-15393d6e1516@codeaurora.org>
Date:   Mon, 9 Jul 2018 10:42:32 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <1531131048-60762-1-git-send-email-george.cherian@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,


On 7/9/2018 4:10 AM, George Cherian wrote:
> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
> feedback via set of performance counters. To determine the actual
> performance level delivered over time, OSPM may read a set of
> performance counters from the Reference Performance Counter Register
> and the Delivered Performance Counter Register.
>
> OSPM calculates the delivered performance over a given time period by
> taking a beginning and ending snapshot of both the reference and
> delivered performance counters, and calculating:
>
> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
>
> Implement the above and hook this to the cpufreq->get method.
>
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index a9d3eec..61132e8 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -296,10 +296,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	return ret;
>  }
>  
> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
> +				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
> +				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
> +{
> +	u64 delta_reference, delta_delivered;
> +	u64 reference_perf, delivered_perf;
> +
> +	reference_perf = fb_ctrs_t0.reference_perf;
> +
> +	delta_reference = (u32)fb_ctrs_t1.reference -
> +				(u32)fb_ctrs_t0.reference;
> +	delta_delivered = (u32)fb_ctrs_t1.delivered -
> +				(u32)fb_ctrs_t0.delivered;
Why (u32)? These registers can be 64bits and that's why cppc_perf_fb_ctrs
have 64b fields for reference and delivered counters.

Moreover, the integer math is incorrect. You can run into a scenario where
t1.ref/del < t0.ref/del,  thus setting a negative number to u64! The likelihood
of this is very high especially when you throw away the higher 32bits.

To keep things simple, do something like below:

if (t1.reference <= t0.reference || t1.delivered <= t0.delivered) {
     /* Atleast one of them should have overflowed */
     return desired_perf;
}
else {
     compute the delivered perf using the counters.
}

> +
> +	/* Check to avoid divide-by zero */
> +	if (delta_reference || delta_delivered)
> +		delivered_perf = (reference_perf * delta_delivered) /
> +					delta_reference;
> +	else
> +		delivered_perf = cpu->perf_ctrls.desired_perf;
> +
> +	return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
> +}
> +
> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> +{
> +	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> +	struct cppc_cpudata *cpu = all_cpu_data[cpunum];
> +	int ret;
> +
> +	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
> +	if (ret)
> +		return ret;
> +
> +	udelay(2); /* 2usec delay between sampling */
> +
> +	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
> +	if (ret)
> +		return ret;
> +
> +	return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
> +}
> +
>  static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.flags = CPUFREQ_CONST_LOOPS,
>  	.verify = cppc_verify_policy,
>  	.target = cppc_cpufreq_set_target,
> +	.get = cppc_cpufreq_get_rate,
>  	.init = cppc_cpufreq_cpu_init,
>  	.stop_cpu = cppc_cpufreq_stop_cpu,
>  	.name = "cppc_cpufreq",

