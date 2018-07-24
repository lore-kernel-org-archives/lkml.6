Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB128C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0AD20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XNdN6HUe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XNdN6HUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0AD20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbeGXLuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:50:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388284AbeGXLuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:50:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6529C6074D; Tue, 24 Jul 2018 10:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532429061;
        bh=vabIQLySUTNUiE37Z1pVG6OeqHXFOh0SZFrTo9AjiGw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XNdN6HUeMSD+neHY/SAN21dCCygaaBZH1KXRv4uWs+It5j4G4eKWHBcho2TJMGOgf
         8/GuizgukCIgVsIT+sxvAEwHqYbngs+uT/nVPa5Npj1tDr7IVBlhbIb5fxGShiyGSh
         adseK9NvjUnKrQl5mOgrz37qhQxqfzqxQ6Fhh/x4=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B23B5602BC;
        Tue, 24 Jul 2018 10:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532429061;
        bh=vabIQLySUTNUiE37Z1pVG6OeqHXFOh0SZFrTo9AjiGw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XNdN6HUeMSD+neHY/SAN21dCCygaaBZH1KXRv4uWs+It5j4G4eKWHBcho2TJMGOgf
         8/GuizgukCIgVsIT+sxvAEwHqYbngs+uT/nVPa5Npj1tDr7IVBlhbIb5fxGShiyGSh
         adseK9NvjUnKrQl5mOgrz37qhQxqfzqxQ6Fhh/x4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B23B5602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v6 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, amit.kucheria@linaro.org,
        evgreen@google.com
References: <1531892220-2046-1-git-send-email-tdas@codeaurora.org>
 <1531892220-2046-3-git-send-email-tdas@codeaurora.org>
 <20180718054647.ysomgxiwzbuuptoc@vireshk-i7>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <d5c00072-84d3-6eda-52db-6d6dd4e313e1@codeaurora.org>
Date:   Tue, 24 Jul 2018 16:14:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718054647.ysomgxiwzbuuptoc@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh,

Thanks for your review comments.

On 7/18/2018 11:16 AM, Viresh Kumar wrote:
> On 18-07-18, 11:07, Taniya Das wrote:
>> +static int qcom_cpu_resources_init(struct platform_device *pdev,
>> +				   struct device_node *np, unsigned int cpu,
>> +				   unsigned long xo_rate)
>> +{
>> +	struct cpufreq_qcom *c;
>> +	struct resource res;
>> +	struct device *dev = &pdev->dev;
>> +	const u16 *offsets;
>> +	cpumask_t cpus_related;
>> +	int ret, i, cpu_r;
>> +	void __iomem *base;
>> +
>> +	cpumask_clear(&cpus_related);
>> +
>> +	ret = qcom_get_related_cpus(np, &cpus_related);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to get related CPUs\n", np->name);
>> +		return ret;
>> +	}
>> +
>> +	/* Related CPUs */
>> +	cpu_r = cpumask_first(&cpus_related);
>> +	if (cpu != cpu_r) {
>> +		qcom_freq_domain_map[cpu] = qcom_freq_domain_map[cpu_r];
>> +		return 0;
>> +	}
>> +
>> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
>> +	if (!c)
>> +		return -ENOMEM;
>> +
>> +	offsets = of_device_get_match_data(&pdev->dev);
>> +	if (!offsets)
>> +		return -EINVAL;
>> +
>> +	if (of_address_to_resource(np, 0, &res))
>> +		return -ENOMEM;
>> +
>> +	base = devm_ioremap_resource(dev, &res);
>> +	if (!base)
>> +		return -ENOMEM;
>> +
>> +	for (i = REG_ENABLE; i < REG_ARRAY_SIZE; i++)
>> +		c->reg_bases[i] = base + offsets[i];
>> +
>> +	/* HW should be in enabled state to proceed */
>> +	if (!(readl_relaxed(c->reg_bases[REG_ENABLE]) & 0x1)) {
>> +		dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	cpumask_copy(&c->related_cpus, &cpus_related);
>> +
>> +	c->max_cores = cpumask_weight(&c->related_cpus);
>> +	if (!c->max_cores)
>> +		return -ENOENT;
>> +
>> +	c->xo_rate = xo_rate;
>> +
>> +	ret = qcom_cpufreq_hw_read_lut(pdev, c);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to read LUT\n", np->name);
>> +		return ret;
>> +	}
>> +
>> +	qcom_freq_domain_map[cpu] = c;
> 
> Set this for all related CPUs here and then the check at the top of
> this routine will be simply:
> 
> if (qcom_freq_domain_map[cpu])
>          return 0;
> 

Please check the latest series, I have updated the code.

>> +
>> +	return 0;
>> +}
>> +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
