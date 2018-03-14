Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeCNFKI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 01:10:08 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33867 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbeCNFKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 01:10:06 -0400
X-Google-Smtp-Source: AG47ELufpy6Qurox/wH4QIufMmF0X1l4iYnXSYh0tPztIr555vkGze6khJENsyTzJHaFyJdiR0drCg==
Date: Wed, 14 Mar 2018 10:40:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: scmi: add thermal dependency
Message-ID: <20180314051004.GF15832@vireshk-i7>
References: <20180313114607.2061209-1-arnd@arndb.de>
 <20180313114607.2061209-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313114607.2061209-2-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-03-18, 12:45, Arnd Bergmann wrote:
> A built-in scmi cpufreq driver cannot link against a modular
> thermal framework:
> 
> drivers/cpufreq/scmi-cpufreq.o: In function `scmi_cpufreq_ready':
> scmi-cpufreq.c:(.text+0x40): undefined reference to `of_cpufreq_cooling_register'
> drivers/cpufreq/scmi-cpufreq.o: In function `scmi_cpufreq_exit':
> scmi-cpufreq.c:(.text+0x88): undefined reference to `cpufreq_cooling_unregister'
> 
> This adds a Kconfig dependency that makes sure this configuration
> is not possible, while allowing all configurations that can work.
> Note that disabling CPU_THERMAL means we don't care about the
> THERMAL dependency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index d9457d1e535c..7f56fe5183f2 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -242,6 +242,7 @@ config ARM_SA1110_CPUFREQ
>  config ARM_SCMI_CPUFREQ
>  	tristate "SCMI based CPUfreq driver"
>  	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
> +	depends on !CPU_THERMAL || THERMAL
>  	select PM_OPP
>  	help
>  	  This adds the CPUfreq driver support for ARM platforms using SCMI

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
