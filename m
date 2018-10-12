Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406CBC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AAD2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IF1XvR3O";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IF1XvR3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AAD2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJMBfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:35:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34092 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJMBfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:35:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A826760881; Fri, 12 Oct 2018 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539367325;
        bh=/jtK+y1ptudfq7gW2ChVlItLEgL8epSAc5jq1vY2es4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IF1XvR3OUC38G8gEVM6a744JuNg8DZwGbgC+K1Z4KIgsf6ORje5e3qIUoHNvwnIur
         zBA2+eGSypTpuZHe4io/QPu2ApRCkFxA2CETcq7NLe2f9eABLaOLWzSGcJauFf/zBa
         OwHNAiUdocdry4Lfzf4KM81vu8ZddcVdNMg3Tbp0=
Received: from [192.168.1.3] (unknown [183.83.77.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ABFA960866;
        Fri, 12 Oct 2018 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539367325;
        bh=/jtK+y1ptudfq7gW2ChVlItLEgL8epSAc5jq1vY2es4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IF1XvR3OUC38G8gEVM6a744JuNg8DZwGbgC+K1Z4KIgsf6ORje5e3qIUoHNvwnIur
         zBA2+eGSypTpuZHe4io/QPu2ApRCkFxA2CETcq7NLe2f9eABLaOLWzSGcJauFf/zBa
         OwHNAiUdocdry4Lfzf4KM81vu8ZddcVdNMg3Tbp0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ABFA960866
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
Subject: Re: [PATCH RFC v1 4/8] drivers: qcom: cpu_pd: add cpu power domain
 support using genpd
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        ulf.hansson@linaro.org, khilman@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-5-git-send-email-rplsssn@codeaurora.org>
 <20181012143350.GG3401@e107155-lin>
From:   Raju P L S S S N <rplsssn@codeaurora.org>
Message-ID: <e56b6fd6-dc48-9eb0-83b2-4621b2e14f44@codeaurora.org>
Date:   Fri, 12 Oct 2018 23:31:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181012143350.GG3401@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 8:03 PM, Sudeep Holla wrote:
> On Thu, Oct 11, 2018 at 02:50:51AM +0530, Raju P.L.S.S.S.N wrote:
>> RPMH based targets require that the sleep and wake state request votes
>> be sent during system low power mode entry. The votes help reduce the
>> power consumption when the AP is not using them. The votes sent by the
>> clients are cached in RPMH controller and needs to be flushed when the
>> last cpu enters low power mode. So add cpu power domain using Linux
>> generic power domain infrastructure to perform necessary tasks as part
>> of domain power down.
>>
>> Suggested-by: Lina Iyer <ilina@codeaurora.org>
>> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
>> ---
>>   drivers/soc/qcom/Kconfig  |   9 ++++
>>   drivers/soc/qcom/Makefile |   1 +
>>   drivers/soc/qcom/cpu_pd.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 114 insertions(+)
>>   create mode 100644 drivers/soc/qcom/cpu_pd.c
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index ba79b60..91e8b3b 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -95,6 +95,7 @@ config QCOM_RMTFS_MEM
>>   config QCOM_RPMH
>>   	bool "Qualcomm RPM-Hardened (RPMH) Communication"
>>   	depends on ARCH_QCOM && ARM64 && OF || COMPILE_TEST
>> +	select QCOM_CPU_PD
>>   	help
>>   	  Support for communication with the hardened-RPM blocks in
>>   	  Qualcomm Technologies Inc (QTI) SoCs. RPMH communication uses an
>> @@ -102,6 +103,14 @@ config QCOM_RPMH
>>   	  of hardware components aggregate requests for these resources and
>>   	  help apply the aggregated state on the resource.
>>
>> +config QCOM_CPU_PD
>> +    bool "Qualcomm cpu power domain driver"
>> +    depends on QCOM_RPMH && PM_GENERIC_DOMAINS || COMPILE_TEST
>> +    help
>> +	  Support for QCOM platform cpu power management to perform tasks
>> +	  necessary while application processor votes for deeper modes so that
>> +	  the firmware can enter SoC level low power modes to save power.
>> +
>>   config QCOM_SMEM
>>   	tristate "Qualcomm Shared Memory Manager (SMEM)"
>>   	depends on ARCH_QCOM
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index f25b54c..57a1b0e 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
>>   obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
>>   qcom_rpmh-y			+= rpmh-rsc.o
>>   qcom_rpmh-y			+= rpmh.o
>> +obj-$(CONFIG_QCOM_CPU_PD) += cpu_pd.o
>>   obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
>>   obj-$(CONFIG_QCOM_SMEM) +=	smem.o
>>   obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
>> diff --git a/drivers/soc/qcom/cpu_pd.c b/drivers/soc/qcom/cpu_pd.c
>> new file mode 100644
>> index 0000000..565c510
>> --- /dev/null
>> +++ b/drivers/soc/qcom/cpu_pd.c
>> @@ -0,0 +1,104 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/of_platform.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/slab.h>
>> +
>> +#include <soc/qcom/rpmh.h>
>> +
>> +static struct device *cpu_pd_dev;
>> +
> 
> This doesn't scale if you have 2 instances.

There would be one instance of this driver for this platform.
This platform has single cluster & single power domain which includes 
all the cpus. Even if there are more than one cluster (lets say, later 
on) the top level grouping of all the clusters will be considered as a 
domain. In this case, if hierarchical topological representation is 
needed, the driver probe needs to be modified. The naming might have led 
to the confusion. Should I change it to something like top_level_pd_dev 
? Another way is to define the compatible flag as SoC specific like 
"qcom,cpu-pm-domain-sdm845" but then there will be multiple SoCs based 
on single cluster. For each of them, compatible flag needs to be added.




> 
>> +static int cpu_pd_power_off(struct generic_pm_domain *domain)
>> +{
>> +	if (rpmh_ctrlr_idle(cpu_pd_dev)) {
> 
> How is this expected to compile ? I couldn't find any instance of this.
> 
>> +		/* Flush the sleep/wake sets */
>> +		rpmh_flush(cpu_pd_dev);
> 
> So it's just flushing the pending requests on the controller. The function
> implementation carries a note that it's assumed to be called only from
> system PM and we may call it in cpu idle path here. Is that fine ?
> If so, may be the comment needs to be dropped.

Sure. we will change the comment.
When RPMh driver was being developed, it named the top level power 
domain which includes all the cpus as system PM.


> 
> Also, where exactly this voting for CPU is happening in this path ?
> 

This SoC uses PC mode and we are not voting for CPU's idle state here.. 
We are just doing power domain activities that are needed when all the 
cpus are down.



>> +	} else {
>> +		pr_debug("rpmh controller is busy\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int cpu_pm_domain_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct generic_pm_domain *cpu_pd;
>> +	int ret = -EINVAL, cpu;
>> +
>> +	if (!np) {
>> +		dev_err(dev, "device tree node not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (!of_find_property(np, "#power-domain-cells", NULL)) {
>> +		pr_err("power-domain-cells not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	cpu_pd_dev = &pdev->dev;
>> +	if (IS_ERR_OR_NULL(cpu_pd_dev))
> 
> Isn't this too late to check ? You would have crashed on dev->of_node.
> So sounds pretty useless

Agree. I will change this.


> 
>> +		return PTR_ERR(cpu_pd_dev);
>> +
>> +	cpu_pd = devm_kzalloc(dev, sizeof(*cpu_pd), GFP_KERNEL);
>> +	if (!cpu_pd)
>> +		return -ENOMEM;
>> +
>> +	cpu_pd->name = kasprintf(GFP_KERNEL, "%s", np->name);
>> +	if (!cpu_pd->name)
>> +		goto free_cpu_pd;
>> +	cpu_pd->name = kbasename(cpu_pd->name);
>> +	cpu_pd->power_off = cpu_pd_power_off;
> 
> If some kind of voting is done in off, why is there nothing to take care
> of that in pd_power_on  if it's per EL(linux/hyp/secure).
Both sleep state votes (which would be applied while powering down)and 
wake state votes (which would be applied while powering on) are applied 
in hardware. Software is expected to write both these types of votes to 
RPM while powering down only. As hardware takes care of applying the 
votes, no need for any pd_power_on operations.


Thanks a lot for your time & review Sudeep. Happy weekend.

- Raju.



> 
> --
> Regards,
> Sudeep
> 
