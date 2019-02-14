Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C48FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC1921902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M/tnFJl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393306AbfBNCQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:16:16 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52566 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfBNCQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:16:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1E2F5Pj084907;
        Wed, 13 Feb 2019 20:15:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550110505;
        bh=6Al0eS7yQJ+jJsKXGi1dKC4sRx+0zaRNojaq+uUVyk0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=M/tnFJl7hzQPs7ehgBTLgD+2Cri+EBhgpNHbZA6OBsUoGPWAz/IixNodcXyedP3Rv
         GNyIBzrAo5WSTHPlhF09BF3qgYwDlo7YeIaauG4PkyZU0Z6uEFMtNFDjgktCyOPIt1
         74Zs1vpu54lA72LbOos4KruMaok5DWcMugZyvg4A=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1E2F4H0004910
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 20:15:04 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 20:15:04 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 20:15:04 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1E2F3KQ031484;
        Wed, 13 Feb 2019 20:15:03 -0600
Subject: Re: [PATCH v2 04/14] irqchip: pruss: Add a PRUSS irqchip driver for
 PRUSS interrupts
To:     Roger Quadros <rogerq@ti.com>, "Andrew F. Davis" <afd@ti.com>,
        <tony@atomide.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC:     <david@lechnology.com>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-5-git-send-email-rogerq@ti.com>
 <57e5b54e-430e-daa1-4b5d-f61827095606@ti.com> <5C585B33.4030505@ti.com>
 <5C594E82.8040601@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <931e03a9-45da-9752-f511-c8aa2a681e20@ti.com>
Date:   Wed, 13 Feb 2019 20:15:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5C594E82.8040601@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 2:51 AM, Roger Quadros wrote:
> +Rob
> 
> Andrew,
> 
> On 04/02/19 17:33, Roger Quadros wrote:
>> On 04/02/19 17:11, Andrew F. Davis wrote:
>>> On 2/4/19 8:22 AM, Roger Quadros wrote:
>>>> From: "Andrew F. Davis" <afd@ti.com>
>>>>
>>>
>>> [...]
>>>
>>>> +static const struct pruss_intc_match_data am437x_pruss_intc_data = {
>>>> +	.no_host7_intr = true,
>>>
>>> Like done for the PRUSS driver with 'has_no_sharedram' becoming a DT
>>> flag the same could be done here, then all this match data stuff could
>>> be dropped.
>>
>> Agreed.
>>
> 
> Going back and looking at code here is a different perspective.
> 
> The has_no_sharedram case was a an odd duck because the 2 ICSSG instances
> within the same SoC (AM437x) had differences. So we couldn't use
> the compatible to differentiate there. The DT flag makes sense there.
> 
> In the no_host7_intr case, it SoC specific so we can use the compatible to
> differentiate. And AM6 SoC has different number of system_events and host_interrupts
> so that could come in macth_data as well. See below.
> 
> static const struct pruss_intc_match_data am335x_am57xx_pruss_intc_data = {
>         .num_system_events = 64,
>         .num_host_intrs = 10,
>         .no_host7_intr = false,
> };
> 
> static const struct pruss_intc_match_data am437x_k2g_pruss_intc_data = {
>         .num_system_events = 64,
>         .num_host_intrs = 10,
>         .no_host7_intr = true,
> };
> 
> static const struct pruss_intc_match_data am6x_icssg_intc_data = {
>         .num_system_events = 160,
>         .num_host_intrs = 20,
>         .no_host7_intr = false,
> };
> 
> Alternatively, we add a DT property each for all 3 of them and get rid
> of match_data entirely.
> 
> Which is a better approach?

I prefer to retain the current reliance of using of_match_data, rather
than having to add additional DT properties and parse them and define
variables to store them. This has served well in terms of scaling up and
get the variable storage for free.

Rob, what is your recommendation here?

regards
Suman

> 
> cheers,
> -roger
> 
> 
>>>
>>>> +};
>>>> +
>>>> +static const struct of_device_id pruss_intc_of_match[] = {
>>>> +	{
>>>> +		.compatible = "ti,am3356-pruss-intc",
>>>> +		.data = NULL,
>>>> +	},
>>>> +	{
>>>> +		.compatible = "ti,am4376-pruss-intc",
>>>> +		.data = &am437x_pruss_intc_data,
>>>> +	},
>>>> +	{
>>>> +		.compatible = "ti,am5728-pruss-intc",
>>>> +		.data = NULL,
>>>> +	},
>>>> +	{ /* sentinel */ },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, pruss_intc_of_match);
>>>> +
>>>> +static struct platform_driver pruss_intc_driver = {
>>>> +	.driver = {
>>>> +		.name = "pruss-intc",
>>>> +		.of_match_table = pruss_intc_of_match,
>>>> +	},
>>>> +	.probe  = pruss_intc_probe,
>>>> +	.remove = pruss_intc_remove,
>>>> +};
>>>> +module_platform_driver(pruss_intc_driver);
>>>> +
>>>> +MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
>>>> +MODULE_AUTHOR("Suman Anna <s-anna@ti.com>");
>>>> +MODULE_DESCRIPTION("PRU-ICSS INTC Driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/include/linux/irqchip/irq-pruss-intc.h b/include/linux/irqchip/irq-pruss-intc.h
>>>> new file mode 100644
>>>> index 0000000..4538a0b
>>>> --- /dev/null
>>>> +++ b/include/linux/irqchip/irq-pruss-intc.h
>>>> @@ -0,0 +1,94 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/**
>>>> + * irq-pruss-intc.h - PRU-ICSS INTC management
>>>
>>> Filename not needed.
>>
>> OK.
>>
>> cheers,
>> -roger
>>
>>>
>>> Andrew
>>>
>>>> + *
>>>> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
>>>> + */
>>>> +
>>>> +#ifndef __INCLUDE_LINUX_IRQCHIP_IRQ_PRUSS_INTC_H
>>>> +#define __INCLUDE_LINUX_IRQCHIP_IRQ_PRUSS_INTC_H
>>>> +
>>>> +/* maximum number of system events */
>>>> +#define MAX_PRU_SYS_EVENTS	64
>>>> +
>>>> +/* maximum number of interrupt channels */
>>>> +#define MAX_PRU_CHANNELS	10
>>>> +
>>>> +/**
>>>> + * struct pruss_intc_config - INTC configuration info
>>>> + * @sysev_to_ch: system events to channel mapping information
>>>> + * @ch_to_host: interrupt channel to host interrupt information
>>>> + */
>>>> +struct pruss_intc_config {
>>>> +	s8 sysev_to_ch[MAX_PRU_SYS_EVENTS];
>>>> +	s8 ch_to_host[MAX_PRU_CHANNELS];
>>>> +};
>>>> +
>>>> +#if IS_ENABLED(CONFIG_TI_PRUSS)
>>>> +
>>>> +/**
>>>> + * pruss_intc_configure() - configure the PRUSS INTC
>>>> + * @dev: device
>>>> + * @intc_config: PRU core-specific INTC configuration
>>>> + *
>>>> + * Configures the PRUSS INTC with the provided configuration from
>>>> + * a PRU core. Any existing event to channel mappings or channel to
>>>> + * host interrupt mappings are checked to make sure there are no
>>>> + * conflicting configuration between both the PRU cores. The function
>>>> + * is intended to be used only by the PRU remoteproc driver.
>>>> + *
>>>> + * Returns 0 on success, or a suitable error code otherwise
>>>> + */
>>>> +int pruss_intc_configure(struct device *dev,
>>>> +			 struct pruss_intc_config *intc_config);
>>>> +
>>>> +/**
>>>> + * pruss_intc_unconfigure() - unconfigure the PRUSS INTC
>>>> + * @dev: device
>>>> + * @intc_config: PRU core specific INTC configuration
>>>> + *
>>>> + * Undo whatever was done in pruss_intc_configure() for a PRU core.
>>>> + * It should be sufficient to just mark the resources free in the
>>>> + * global map and disable the host interrupts and sysevents.
>>>> + */
>>>> +int pruss_intc_unconfigure(struct device *dev,
>>>> +			   struct pruss_intc_config *intc_config);
>>>> +/**
>>>> + * pruss_intc_trigger() - trigger a PRU system event
>>>> + * @irq: linux IRQ number associated with a PRU system event
>>>> + *
>>>> + * Trigger an interrupt by signalling a specific PRU system event.
>>>> + * This can be used by PRUSS client users to raise/send an event to
>>>> + * a PRU or any other core that is listening on the host interrupt
>>>> + * mapped to that specific PRU system event. The @irq variable is the
>>>> + * Linux IRQ number associated with a specific PRU system event that
>>>> + * a client user/application uses. The interrupt mappings for this is
>>>> + * provided by the PRUSS INTC irqchip instance.
>>>> + *
>>>> + * Returns 0 on success, or an error value upon failure.
>>>> + */
>>>> +int pruss_intc_trigger(unsigned int irq);
>>>> +
>>>> +#else
>>>> +
>>>> +static inline int pruss_intc_configure(struct device *dev,
>>>> +				       struct pruss_intc_config *intc_config)
>>>> +{
>>>> +	return -ENOTSUPP;
>>>> +}
>>>> +
>>>> +static inline int pruss_intc_unconfigure(struct device *dev,
>>>> +					 struct pruss_intc_config *intc_config)
>>>> +{
>>>> +	return -ENOTSUPP;
>>>> +}
>>>> +
>>>> +static inline int pruss_intc_trigger(unsigned int irq)
>>>> +{
>>>> +	return -ENOTSUPP;
>>>> +}
>>>> +
>>>> +#endif	/* CONFIG_TI_PRUSS */
>>>> +
>>>> +#endif /* __INCLUDE_LINUX_IRQCHIP_IRQ_OMAP_INTC_H */
>>>> +
>>>>
>>
> 

