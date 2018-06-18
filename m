Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F372C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC7C2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aLz2z4tW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YcbzGKMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC7C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935752AbeFRUV4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:21:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933834AbeFRUVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:21:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4B4AB60B11; Mon, 18 Jun 2018 20:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529353313;
        bh=/v2ySN9trXowUfxWwirp1WpGhHakkJ4/U1vlsd8fwPk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aLz2z4tWQ+QmBNKttcc/54U/e8EPhRaNahqRqiasHpe4tTVrMx/2UnsWyE4Ja7GCT
         3ukcky8QpVXFdvHDo8bH+We3ZHIk5MpMk7p/SoKC0iBxroXXd6M2Z+zSOx24Jh8gzA
         LCizeNQqaOGDW/ok4WL8iuDrEguLMFKlt5SNp9YU=
Received: from [10.226.58.143] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pprakash@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 503E0602FC;
        Mon, 18 Jun 2018 20:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529353312;
        bh=/v2ySN9trXowUfxWwirp1WpGhHakkJ4/U1vlsd8fwPk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YcbzGKMGK5XULLniPvAQjTOp6cc8Ukdh+TNGqmAucHvG4skzl4RptrvMlKqCZov/l
         3OodrcQWDD7layJL5cQrueObcPIe/TRHNwkCBSHjJ4/WF3BgN9Cscmj5qA/RN8VkDe
         5pKG989cWMKxClWBqwt3RSLNBLf/sWAqA6kHu540=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 503E0602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pprakash@codeaurora.org
Subject: Re: [PATCH v2] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
To:     George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net
References: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
From:   "Prakash, Prashanth" <pprakash@codeaurora.org>
Message-ID: <67822500-0c9d-ac24-71bc-2717831ab29d@codeaurora.org>
Date:   Mon, 18 Jun 2018 14:21:51 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On 6/15/2018 4:03 AM, George Cherian wrote:
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
>  drivers/cpufreq/cppc_cpufreq.c | 71 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 3464580..3fe7625 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -296,10 +296,81 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
> +	if (fb_ctrs_t1.reference > fb_ctrs_t0.reference) {
> +		delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
> +	} else {
There should be another if () here to check if the reference counters are equal.
We cannot assume, there was a overflow when the counters are equal. As I
mentioned on last patch, the counters *may* pause in idle states.
> +		/*
> +		 * Counters would have wrapped-around
> +		 * We also need to find whether the low level fw
> +		 * maintains 32 bit or 64 bit counters, to calculate
> +		 * the correct delta.
> +		 */
> +		if (fb_ctrs_t0.reference > (~(u32)0))
> +			delta_reference  = (~((u64)0) - fb_ctrs_t0.reference) +
> +					fb_ctrs_t1.reference;
> +		else
> +			delta_reference  = (~((u32)0) - fb_ctrs_t0.reference) +
> +					fb_ctrs_t1.reference;
> +	}
> +
> +	if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered) {
> +		delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
> +	} else {
> +		/*
> +		 * Counters would have wrapped-around
> +		 * We also need to find whether the low level fw
> +		 * maintains 32 bit or 64 bit counters, to calculate
> +		 * the correct delta.
> +		 */
> +		if (fb_ctrs_t0.delivered > (~(u32)0))
> +			delta_delivered  = (~((u64)0) - fb_ctrs_t0.delivered) +
> +					fb_ctrs_t1.delivered;
> +		else
> +			delta_delivered  = (~((u32)0) - fb_ctrs_t0.delivered) +
> +					fb_ctrs_t1.delivered;
> +	}
> +
> +	if (delta_reference)  /* Check to avoid divide-by zero */
> +		delivered_perf = (reference_perf * delta_delivered) /
> +					delta_reference;
> +	else
> +		delivered_perf = reference_perf;

If we cannot compute delivered performance then we should return
desired/requested perf and not reference_perf.

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

Thanks,
Prashanth
