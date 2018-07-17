Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66741ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106FC20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lKHvyC4f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gnPyJhUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106FC20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbeGQD3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 23:29:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbeGQD3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 23:29:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7C4286060A; Tue, 17 Jul 2018 02:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531796353;
        bh=zjaDhQu6d7hnVcUwMpjdprDMWZZfBNBYHCqoG9lHb2Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lKHvyC4fe2L7VOCEbEYZLxYdO7QqRsu7VApZt+ywzHMQ06oW/94skoH8/yuPWOiOp
         skIgDBjNQE6glhx6cQlqjfXB9Qm0y1rM8qPG/ZOGa+C7nobiuGi/GqkYX4SajKcI/W
         W/p5Nflti+hwYhwVrpyrPGCmzCEZQeUDuLhA11J0=
Received: from [10.4.34.47] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 31A40603AF;
        Tue, 17 Jul 2018 02:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531796352;
        bh=zjaDhQu6d7hnVcUwMpjdprDMWZZfBNBYHCqoG9lHb2Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gnPyJhUilqn80MM/QJiywjeKg4v3ymBJdCg7SJ8HVF0EmCBI3cPQf70+U9eNiNofG
         F9N17IHzTsRc7gXq5Lg36kjBkGrRkqyFbIe30N/YbmmRdrDSDVgYKZgWUt8DEmog/D
         PpVHwr+6eaWndJbt4lLI+ZmCPm53JRkIQRiTPsD8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31A40603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v5 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
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
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
 <20180716051219.36rdvxux3lz3rjed@vireshk-i7>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <3163a20a-31ca-15a0-56e2-38e977b21ae2@codeaurora.org>
Date:   Tue, 17 Jul 2018 08:29:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716051219.36rdvxux3lz3rjed@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/2018 10:42 AM, Viresh Kumar wrote:
> On 12-07-18, 23:35, Taniya Das wrote:
>> +static int qcom_cpu_resources_init(struct platform_device *pdev,
>> +				   struct device_node *np, unsigned int cpu)
>> +{
>> +	struct cpufreq_qcom *c;
>> +	struct resource res;
>> +	struct device *dev = &pdev->dev;
>> +	unsigned int offset, cpu_r;
>> +	int ret;
>> +
>> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
>> +	if (!c)
>> +		return -ENOMEM;
>> +
>> +	c->reg_offset = of_device_get_match_data(&pdev->dev);
>> +	if (!c->reg_offset)
>> +		return -EINVAL;
>> +
>> +	if (of_address_to_resource(np, 0, &res))
>> +		return -ENOMEM;
>> +
>> +	c->base = devm_ioremap(dev, res.start, resource_size(&res));
>> +	if (!c->base) {
>> +		dev_err(dev, "Unable to map %s base\n", np->name);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	offset = c->reg_offset[REG_ENABLE];
>> +
>> +	/* HW should be in enabled state to proceed */
>> +	if (!(readl_relaxed(c->base + offset) & 0x1)) {
>> +		dev_err(dev, "%s cpufreq hardware not enabled\n", np->name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	ret = qcom_get_related_cpus(np, &c->related_cpus);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to get related CPUs\n", np->name);
>> +		return ret;
>> +	}
>> +
>> +	c->max_cores = cpumask_weight(&c->related_cpus);
>> +	if (!c->max_cores)
>> +		return -ENOENT;
>> +
>> +	ret = qcom_read_lut(pdev, c);
>> +	if (ret) {
>> +		dev_err(dev, "%s failed to read LUT\n", np->name);
>> +		return ret;
>> +	}
>> +
>> +	qcom_freq_domain_map[cpu] = c;
>> +
>> +	/* Related CPUs to keep a single copy */
>> +	cpu_r = cpumask_first(&c->related_cpus);
>> +	if (cpu != cpu_r) {
>> +		qcom_freq_domain_map[cpu] = qcom_freq_domain_map[cpu_r];
>> +		devm_kfree(dev, c);
>> +	}
> 
> Sorry about missing this, you have actually worked on my comments.
> 
> But I think this isn't the clever way of doing it. You allocate the
> structures, fill everything and then finally free them because we were
> related. Why can't we have similar check at the top of this routine
> and skip everything then ?
> 

Thanks Viresh, I actually replied to all the reviewers with the changes 
I have made in v5 series, sorry for not replying individually to all 
reviewers. Yes, I agree I should have put this check at the beginning of 
the function.

Please help review of the new series[v5] which takes care of the below.

- Remove mapping different register regions of perf/lut/enable,
   instead map the entire HW region.
- Add reg_offset/cpufreq_qcom_std_offsets to be supplied as device data.
- Check of src == 0 during lut read.
- Add of_node_put(cpu_np) in qcom_get_related_cpus
- Update the qcom_cpu_resources_init for register offset data,
   and cleanup the related cpus to keep a single copy of CPUfreq.
- Replace FW with HW, update Kconfig, rename filename qcom-cpufreq-hw.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
