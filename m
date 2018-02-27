Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeB0O6y convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:58:54 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57679 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754011AbeB0O6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:58:50 -0500
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Sricharan R <sricharan@codeaurora.org>
Cc: viresh.kumar@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org, linux@arm.linux.org.uk
Subject: Re: [PATCH v8 14/15] cpufreq: Add module to register cpufreq on Krait CPUs
References: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
        <1519740422-3835-15-git-send-email-sricharan@codeaurora.org>
Date: Tue, 27 Feb 2018 15:58:47 +0100
In-Reply-To: <1519740422-3835-15-git-send-email-sricharan@codeaurora.org>
        (Sricharan R.'s message of "Tue, 27 Feb 2018 19:37:01 +0530")
Message-ID: <87zi3ujx7c.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sricharan,
 
 On mar., févr. 27 2018, Sricharan R <sricharan@codeaurora.org> wrote:

> From: Stephen Boyd <sboyd@codeaurora.org>
>
> Register a cpufreq-generic device whenever we detect that a
> "qcom,krait" compatible CPU is present in DT.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> [Sricharan: updated to use dev_pm_opp_set_prop_name and
> 	    nvmem apis]
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm          |  10 ++
>  drivers/cpufreq/Makefile             |   3 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   5 +
>  drivers/cpufreq/qcom-cpufreq.c       | 183 +++++++++++++++++++++++++++++++++++
>  4 files changed, 201 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq.c
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 3a88e33..826f9e7 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -133,6 +133,16 @@ config ARM_OMAP2PLUS_CPUFREQ
>  	depends on ARCH_OMAP2PLUS
>  	default ARCH_OMAP2PLUS
>  
> +config ARM_QCOM_CPUFREQ
> +	bool "CPUfreq driver for the QCOM SoCs with KRAIT processors"
> +	depends on ARCH_QCOM
> +	select PM_OPP
> +	help
> +	  This enables the CPUFreq driver for Qualcomm SoCs with
> +	  KRAIT processors.
> +
> +	  If in doubt, say N.
> +
>  config ARM_S3C_CPUFREQ
>  	bool
>  	help
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index c60c1e1..21894f6 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -65,6 +65,9 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
>  obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ)		+= qcom-cpufreq.o

These 2 following lines don't seem related to the commit log:
> +obj-$(CONFIG_ARM_S3C24XX_CPUFREQ)	+= s3c24xx-cpufreq.o
> +obj-$(CONFIG_ARM_S3C24XX_CPUFREQ_DEBUGFS) += s3c24xx-cpufreq-debugfs.o

Gregory

>  obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
>  obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
