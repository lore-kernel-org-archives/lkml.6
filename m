Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9773C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD9521720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEnARfrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbeLTOT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:19:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36858 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731279AbeLTOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:19:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so1947954wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 06:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hq5fNvnqcKLZYKprqkFMFjWqTZS/AiLTdVGUsHsuR8c=;
        b=aEnARfrRojPdKsQyHVTrmsOAbJWqTAaLrlOEb8nUgjsrKcHOoFWwyr7SeEIQumz11d
         0ibw4KZA/OD+/YQHPY4ZROW9oMUT0cPGR2AnMm1e85Cd/jjSp+Hbq/qp7xJE6Mr5ynyd
         tSO1CgMX6RSlXUUvn+cgzvzH9xT76fFJKDHwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hq5fNvnqcKLZYKprqkFMFjWqTZS/AiLTdVGUsHsuR8c=;
        b=oGfZMGIOXZLUc69mLFY8TYQlS3Vz3X505WaAttvK6mPY5RoOrT6BXoidRcToInHK92
         jlC4hvaQiUQNyhxvQTwtA1KkikHUmkUIPyoPPCPcuWxBXjPBwKS9wJIINpHq7jRQT+Ah
         yBCcjzToM733q8qtca8Io+VDIVHL7vl5aYejay5yayef/bQTS6DAEH5pylfzqx/99jcR
         mhihKVnELM7kcJycG1ODAvzabKcoHpBZ5wUYxemrKpglxzcHtDhQO9T8N9kjOB9/IGLM
         YzuFRS5qghU6dvq6G7WDOWn1RpBq5AVDIEsby5FDdsxLULtkXt4/Wtp2AodTSPj39sTK
         vLUA==
X-Gm-Message-State: AA+aEWaDr3lmGAEXtN3aSPBSIfbLpAxqJkou1BnztHnqe+rHYxLVKgmt
        Kd4OiKqJ1qNUOW8W72gOzdAarDRJMkY=
X-Google-Smtp-Source: AFSGD/X01KB/Wa9mN5zcuhWpx8jI3g8+zWAoQUQvBzzGLN2WfFGxkDWqPSUAxQN4JcCJs+h0LHKA0A==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr24704743wrn.185.1545315565566;
        Thu, 20 Dec 2018 06:19:25 -0800 (PST)
Received: from [192.168.0.40] (55.183.88.92.rev.sfr.net. [92.88.183.55])
        by smtp.googlemail.com with ESMTPSA id h129sm18428162wma.0.2018.12.20.06.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 06:19:24 -0800 (PST)
Subject: Re: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM
 domains
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-18-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
Date:   Thu, 20 Dec 2018 15:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129174700.16585-18-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> Following changes are about to implement support for PM domains to PSCI.
> Those changes are mainly going to be implemented in a new separate file,
> hence a couple of the internal PSCI functions needs to be shared to be
> accessible. So, let's do that via adding new PSCI header file.
> 
> Moreover, the changes deploying support for PM domains, needs to be able to
> switch the PSCI FW into the OS initiated mode. For that reason, let's add a
> new function that deals with this and share it via the new PSCI header
> file.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v10:
> 	- New patch. Re-places the earlier patch: "drivers: firmware: psci:
> 	  Share a few internal PSCI functions".
> 
> ---
>  drivers/firmware/psci/psci.c | 28 +++++++++++++++++++++-------
>  drivers/firmware/psci/psci.h | 14 ++++++++++++++
>  2 files changed, 35 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/firmware/psci/psci.h
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 8dbcdecc2ae4..623591b541a4 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -34,6 +34,8 @@
>  #include <asm/smp_plat.h>
>  #include <asm/suspend.h>
>  
> +#include "psci.h"
> +
>  /*
>   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
>   * calls it is necessary to use SMC64 to pass or return 64-bit values.
> @@ -90,23 +92,35 @@ static u32 psci_function_id[PSCI_FN_MAX];
>  static DEFINE_PER_CPU(u32, domain_state);
>  static u32 psci_cpu_suspend_feature;
>  
> -static inline u32 psci_get_domain_state(void)
> +u32 psci_get_domain_state(void)
>  {
>  	return __this_cpu_read(domain_state);
>  }
>
> -static inline void psci_set_domain_state(u32 state)
> +void psci_set_domain_state(u32 state)
>  {
>  	__this_cpu_write(domain_state, state);
>  }
>  
> +bool psci_set_osi_mode(void)
> +{
> +	int ret;
> +
> +	ret = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
> +			PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
> +	if (ret)
> +		pr_warn("failed to enable OSI mode: %d\n", ret);
> +
> +	return !ret;
> +}

Please keep the convention with the error code (0 => success)

In the next patch it can be called:

if (psci_has_osi_support())
	osi_mode_enabled = psci_set_osi_mode() ? false : true;

> +
>  static inline bool psci_has_ext_power_state(void)
>  {
>  	return psci_cpu_suspend_feature &
>  				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
>  }
>  
> -static inline bool psci_has_osi_support(void)
> +bool psci_has_osi_support(void)
>  {
>  	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
>  }
> @@ -285,10 +299,7 @@ static int __init psci_features(u32 psci_func_id)
>  			      psci_func_id, 0, 0);
>  }
>  
> -#ifdef CONFIG_CPU_IDLE
> -static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> -
> -static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> +int psci_dt_parse_state_node(struct device_node *np, u32 *state)
>  {
>  	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
>  
> @@ -305,6 +316,9 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_CPU_IDLE

It would be nicer if you can remove the CONFIG_CPU_IDLE by replacing it
with a specific one (eg. CONFIG_PSCI_IDLE) and make it depend on
CONFIG_CPU_IDLE, so the config options stay contained in their
respective subsystems directory.

> +static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> +
>  static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>  			struct device_node *cpu_node, int cpu)
>  {
> diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
> new file mode 100644
> index 000000000000..7d9d38fd57e1
> --- /dev/null
> +++ b/drivers/firmware/psci/psci.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __PSCI_H
> +#define __PSCI_H
> +
> +struct device_node;
> +
> +bool psci_set_osi_mode(void);
> +u32 psci_get_domain_state(void);
> +void psci_set_domain_state(u32 state);
> +bool psci_has_osi_support(void);
> +int psci_dt_parse_state_node(struct device_node *np, u32 *state);
> +
> +#endif /* __PSCI_H */
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

