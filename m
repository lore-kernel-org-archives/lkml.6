Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40536C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E9420851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="alIzSAYl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y46p9fPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E9420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLDJ1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:27:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54694 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeLDJ1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:27:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 669B46130A; Tue,  4 Dec 2018 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543915650;
        bh=GQlyJYtScwIswUqB6lsPvoF5YSo9l8iOXkHqArIfrC0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=alIzSAYlqm1YSYz774LpP38fCLRIPiXKrLXe9AfNYBTR6zgIC2zwO16L6UXIh2m24
         pjiA0fy8T6TeKaMG35CzAW0Kof/jSI+RY7YCmQuESyE9GJOHHxpowyAujlFS4cMLd+
         zP8rlm5iw6jnqvQPGUQzmICZQNDiDgeMFE5E1om4=
Received: from [192.168.225.247] (unknown [49.33.209.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30928607B5;
        Tue,  4 Dec 2018 09:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543915649;
        bh=GQlyJYtScwIswUqB6lsPvoF5YSo9l8iOXkHqArIfrC0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y46p9fPABLSpCudOVmznEp7MudlNnK4l4Pexuo5ONbbxCAU8T0TocL5ibnWfXRTGI
         n9r8dhxQID+yM6o18uQicRUrF40hG5pVA7DPAwLSHU0ESKZT9y/AUxYHM2fzrJ011K
         F1Wdc/dOlQxvtqcGQMzHgUgvmK8HQss/WManGeMI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30928607B5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Stephen Boyd <swboyd@chromium.org>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
 <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <99d25f02-e595-d4e8-25c4-3c4c206f79a6@codeaurora.org>
Date:   Tue, 4 Dec 2018 14:57:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh,

On 12/4/2018 10:42 AM, Viresh Kumar wrote:
> Hi Taniya,
> 
> Sorry that I haven't been reviewing it much from last few iterations as I was
> letting others get this into a better shape. Thanks for your efforts..
> 
> On 02-12-18, 09:25, Taniya Das wrote:
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> 
>> +struct cpufreq_qcom {
>> +	struct cpufreq_frequency_table *table;
>> +	void __iomem *perf_state_reg;
>> +	cpumask_t related_cpus;
>> +};
>> +
>> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];
> 
> Now that the code is much more simplified, I am not sure if you need this
> per-cpu structure at all. The only place where you are using it is in
> qcom_cpufreq_hw_cpu_init() and probe(). Why not merge qcom_cpu_resources_init()
> completely into qcom_cpufreq_hw_cpu_init() and get rid of this structure
> entirely ?
> 

Yes, we still would require the per-cpu.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
