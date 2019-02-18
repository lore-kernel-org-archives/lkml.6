Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92481C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E8C218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 06:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0wYuFCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfBRGQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 01:16:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35178 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfBRGQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 01:16:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id j5so3506249pfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 22:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7HmJzfmEj9xsQYL5N418Naa1i0UMoglBgv9NHMmbkso=;
        b=u0wYuFCrQ3JpIshn7VtaCh9AO/+vjnQRnM+3SBXbL8JssbeCcgD9IXKVyfNz0uGYPp
         xaB/Lfcy7QYOH83IZHbos0EmyCUxk6QgSfmMPuZsRjm4bQ53Y4zdOitf6ldq3i95szAl
         1AwUDn6PLT5h1ONdIx6wfmaVbff/yd8tX0E/P80cYejQbxByLKnf52GO3Z0ah2twOKTe
         ZWOYZcKq0nKFLH7oh85WY0razVknpZfGUXrIFp21GhSYgJgjbcjuD9JeOPDijvF+jWrW
         9Lrvigo3WkpIcDnyl7n8PODNGh70i8gklKtlo32G5H1a/3oHr2DcDbJLg+SUgmCMnC74
         GDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7HmJzfmEj9xsQYL5N418Naa1i0UMoglBgv9NHMmbkso=;
        b=Z6c0W4iW8aOwH0kdD8/LcE5EKdt2y/3fewOoUD9Yd/1viZmaLkJtPwqMIbMV/w3xFj
         Skm8dYZat6g1y/w5VbheYVnwa6fjiTHbGjeYOnumzTvlPtQV70/tIK1iOBF0UGX7U65h
         jXCnVcjplRPbXnwtkOb67d+epi/Pw51beAz3nbrhH9RNotwEneBqitqybplaPCdH75mA
         +6pZONUWMP155jM7dDzPyrFSWodQ67xbscBSSJneQgpF+w7Rdsadx3BIVVigbg/Zwf0A
         /Wsd2d7jG6HSFhg73ebKKJxhdS+38/TC/1wgF72v99FKGOuat7GurqoYuTLLYB+ge/OF
         kVCA==
X-Gm-Message-State: AHQUAubXyB6hindhqGf1yT/WB7H49buafU2SL8YV+SeRdEeEMs/mBIQO
        vTYp05w/IoAu/ECFiwDwCcWKBw==
X-Google-Smtp-Source: AHgI3IaFZ0aCjQk8ePhCtVb1GFZ4f398NUPYKnOhFYn5oY1LZ0Ma65w9Rcm9u7fs0oTIqzQWrf486g==
X-Received: by 2002:a62:b286:: with SMTP id z6mr22587501pfl.106.1550470573467;
        Sun, 17 Feb 2019 22:16:13 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id o6sm5219529pgo.27.2019.02.17.22.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 22:16:12 -0800 (PST)
Date:   Mon, 18 Feb 2019 11:46:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] cpufreq: davinci: move configuration to
 include/linux/platform_data
Message-ID: <20190218061610.cwvwij7aoemi2gbe@vireshk-i7>
References: <20190214170505.27251-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214170505.27251-1-brgl@bgdev.pl>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-19, 18:05, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The header containing the configuration structure for davinci cpufreq
> driver lives in mach-davinci/include/mach/. This is fine for now but
> if we want to make davinci part of the multi_v5 build, no code external
> to mach-davinci should include machine-specific headers.
> 
> Move the configuration structure to include/linux/platform_data.
> 
> While we're at it: convert the GPL-2.0 boilerplate to a proper SPDX
> license identifier.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/mach-davinci/da850.c                 |  2 +-
>  arch/arm/mach-davinci/include/mach/cpufreq.h  | 26 -------------------
>  drivers/cpufreq/davinci-cpufreq.c             |  5 +---
>  include/linux/platform_data/davinci-cpufreq.h | 19 ++++++++++++++
>  4 files changed, 21 insertions(+), 31 deletions(-)
>  delete mode 100644 arch/arm/mach-davinci/include/mach/cpufreq.h
>  create mode 100644 include/linux/platform_data/davinci-cpufreq.h
> 
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index e7b78df2bfef..a02ff431ba47 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -21,6 +21,7 @@
>  #include <linux/mfd/da8xx-cfgchip.h>
>  #include <linux/platform_data/clk-da8xx-cfgchip.h>
>  #include <linux/platform_data/clk-davinci-pll.h>
> +#include <linux/platform_data/davinci-cpufreq.h>
>  #include <linux/platform_data/gpio-davinci.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -29,7 +30,6 @@
>  #include <asm/mach/map.h>
>  
>  #include <mach/common.h>
> -#include <mach/cpufreq.h>
>  #include <mach/cputype.h>
>  #include <mach/da8xx.h>
>  #include <mach/irqs.h>
> diff --git a/arch/arm/mach-davinci/include/mach/cpufreq.h b/arch/arm/mach-davinci/include/mach/cpufreq.h
> deleted file mode 100644
> index 3c089cfb6cd6..000000000000
> --- a/arch/arm/mach-davinci/include/mach/cpufreq.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/*
> - * TI DaVinci CPUFreq platform support.
> - *
> - * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation version 2.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -#ifndef _MACH_DAVINCI_CPUFREQ_H
> -#define _MACH_DAVINCI_CPUFREQ_H
> -
> -#include <linux/cpufreq.h>
> -
> -struct davinci_cpufreq_config {
> -	struct cpufreq_frequency_table *freq_table;
> -	int (*set_voltage) (unsigned int index);
> -	int (*init) (void);
> -};
> -
> -#endif
> diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
> index d54a27c99121..940fe85db97a 100644
> --- a/drivers/cpufreq/davinci-cpufreq.c
> +++ b/drivers/cpufreq/davinci-cpufreq.c
> @@ -23,13 +23,10 @@
>  #include <linux/init.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> +#include <linux/platform_data/davinci-cpufreq.h>
>  #include <linux/platform_device.h>
>  #include <linux/export.h>
>  
> -#include <mach/hardware.h>
> -#include <mach/cpufreq.h>
> -#include <mach/common.h>
> -
>  struct davinci_cpufreq {
>  	struct device *dev;
>  	struct clk *armclk;
> diff --git a/include/linux/platform_data/davinci-cpufreq.h b/include/linux/platform_data/davinci-cpufreq.h
> new file mode 100644
> index 000000000000..3fbf9f2793b5
> --- /dev/null
> +++ b/include/linux/platform_data/davinci-cpufreq.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * TI DaVinci CPUFreq platform support.
> + *
> + * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
> + */
> +
> +#ifndef _MACH_DAVINCI_CPUFREQ_H
> +#define _MACH_DAVINCI_CPUFREQ_H
> +
> +#include <linux/cpufreq.h>
> +
> +struct davinci_cpufreq_config {
> +	struct cpufreq_frequency_table *freq_table;
> +	int (*set_voltage)(unsigned int index);
> +	int (*init)(void);
> +};
> +
> +#endif /* _MACH_DAVINCI_CPUFREQ_H */

Applied. Thanks.

-- 
viresh
