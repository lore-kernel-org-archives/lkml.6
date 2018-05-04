Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeEDTUt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:20:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46904 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeEDTUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:20:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95A4B6055D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: <ilialin@codeaurora.org>
To: "'Viresh Kumar'" <viresh.kumar@linaro.org>
Cc: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <rjw@rjwysocki.net>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <andy.gross@linaro.org>,
        <david.brown@linaro.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-soc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <rnayak@codeaurora.org>, <amit.kucheria@linaro.org>,
        <nicolas.dechesne@linaro.org>, <celster@codeaurora.org>,
        <tfinkel@codeaurora.org>
References: <1525348355-25471-1-git-send-email-ilialin@codeaurora.org> <1525348355-25471-13-git-send-email-ilialin@codeaurora.org> <20180504060827.7bddb53ln2ogwcvv@vireshk-i7> <002a01d3e373$6b6ee410$424cac30$@codeaurora.org> <20180504065709.62kacfext6bbprlo@vireshk-i7>
In-Reply-To: <20180504065709.62kacfext6bbprlo@vireshk-i7>
Subject: RE: [PATCH v5 12/14] cpufreq: Add Kryo CPU scaling driver
Date: Fri, 4 May 2018 22:20:17 +0300
Message-ID: <007601d3e3dc$f7454a60$e5cfdf20$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIw4YufeDUO1xSdYb5xrMmiursktAKqm3zYAYB5uIMCqLXAuQHA6QnsoyFQp7A=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Friday, May 4, 2018 09:57
> To: ilialin@codeaurora.org
> Cc: mturquette@baylibre.com; sboyd@kernel.org; robh@kernel.org;
> mark.rutland@arm.com; rjw@rjwysocki.net; lgirdwood@gmail.com;
> broonie@kernel.org; andy.gross@linaro.org; david.brown@linaro.org;
> catalin.marinas@arm.com; will.deacon@arm.com; linux-clk@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> pm@vger.kernel.org; linux-arm-msm@vger.kernel.org; linux-
> soc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> rnayak@codeaurora.org; amit.kucheria@linaro.org;
> nicolas.dechesne@linaro.org; celster@codeaurora.org;
> tfinkel@codeaurora.org
> Subject: Re: [PATCH v5 12/14] cpufreq: Add Kryo CPU scaling driver
> 
> On 04-05-18, 09:44, ilialin@codeaurora.org wrote:
> >
> >
> > > -----Original Message-----
> > > From: Viresh Kumar <viresh.kumar@linaro.org>
> > > Sent: Friday, May 4, 2018 09:08
> > > To: Ilia Lin <ilialin@codeaurora.org>
> > > Cc: mturquette@baylibre.com; sboyd@kernel.org; robh@kernel.org;
> > > mark.rutland@arm.com; rjw@rjwysocki.net; lgirdwood@gmail.com;
> > > broonie@kernel.org; andy.gross@linaro.org; david.brown@linaro.org;
> > > catalin.marinas@arm.com; will.deacon@arm.com;
> > > linux-clk@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-kernel@vger.kernel.org; linux- pm@vger.kernel.org;
> > > linux-arm-msm@vger.kernel.org; linux- soc@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org;
> > > rnayak@codeaurora.org; amit.kucheria@linaro.org;
> > > nicolas.dechesne@linaro.org; celster@codeaurora.org;
> > > tfinkel@codeaurora.org
> > > Subject: Re: [PATCH v5 12/14] cpufreq: Add Kryo CPU scaling driver
> > >
> > > On 03-05-18, 14:52, Ilia Lin wrote:
> > > > In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO
> > > > processors, the CPU ferequencies subset and voltage value of each
> > > > OPP varies based on the silicon variant in use. Qualcomm Process
> > > > Voltage Scaling Tables defines the voltage and frequency value
> > > > based on the msm-id in SMEM and speedbin blown in the efuse
> combination.
> > > > The qcom-cpufreq-kryo driver reads the msm-id and efuse value from
> > > > the SoC to provide the OPP framework with required information.
> > > > This is used to determine the voltage and frequency value for each
> > > > OPP of
> > > > operating-points-v2 table when it is parsed by the OPP framework.
> > > >
> > > > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > > > ---
> > > >  drivers/cpufreq/Kconfig.arm          |  11 +++
> > > >  drivers/cpufreq/Makefile             |   1 +
> > > >  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
> > > >  drivers/cpufreq/qcom-cpufreq-kryo.c  | 153
> > > > +++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 168 insertions(+)  create mode 100644
> > > > drivers/cpufreq/qcom-cpufreq-kryo.c
> > > >
> > > > diff --git a/drivers/cpufreq/Kconfig.arm
> > > > b/drivers/cpufreq/Kconfig.arm index de55c7d..f9da18c 100644
> > > > --- a/drivers/cpufreq/Kconfig.arm
> > > > +++ b/drivers/cpufreq/Kconfig.arm
> > > > @@ -124,6 +124,17 @@ config ARM_OMAP2PLUS_CPUFREQ
> > > >  	depends on ARCH_OMAP2PLUS
> > > >  	default ARCH_OMAP2PLUS
> > > >
> > > > +config ARM_QCOM_CPUFREQ_KRYO
> > > > +	tristate "Qualcomm Technologies, Inc. Kryo based CPUFreq"
> > >
> > > I don't see any reply to Sricharan's query on this being tristate.
> >
> > Why shouldn't we leave possibility to compile the cpufreq-dt built-in,
> > and the qcom-cpufreq-kryo module?
> 
> I was not saying this is incorrect, all I am saying is that you never
replied to a
> comment from one of the reviewers.
> 
> And I don't see a reason why this should be a tristate really.
> cpufreq-dt is already capable of being a module, all your driver does is
that it
> creates the cpufreq-dt platform device after setting the OPP hw
properties..
> 
> Over that, have you ever tried inserting, then removing and inserting the
> driver module again? I feel it will fail.
> 
> The reason is that you never provided an exit routine which can get rid of
the
> platform device created in the first place.

Convinced. I'll change it to bool.

> 
> > > > +	depends on QCOM_QFPROM
> > > > +	depends on QCOM_SMEM
> > > > +	select PM_OPP
> > > > +	help
> > > > +	  This adds the CPUFreq driver for
> > > > +	  Qualcomm Technologies, Inc. Kryo SoC based boards.
> > > > +
> > > > +	  If in doubt, say N.
> > > > +
> > > >  config ARM_S3C_CPUFREQ
> > > >  	bool
> > > >  	help
> > > > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > > > index 8d24ade..fb4a2ec 100644
> > > > --- a/drivers/cpufreq/Makefile
> > > > +++ b/drivers/cpufreq/Makefile
> > > > @@ -65,6 +65,7 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+=
> > > mvebu-cpufreq.o
> > > >  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
> > > >  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
> > > >  obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
> > > > +obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+= qcom-cpufreq-
> > > kryo.o
> > > >  obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+= s3c2410-cpufreq.o
> > > >  obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+= s3c2412-cpufreq.o
> > > >  obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
> > > > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> > > > b/drivers/cpufreq/cpufreq-dt-platdev.c
> > > > index 3b585e4..77d6ab8 100644
> > > > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > > > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > > > @@ -118,6 +118,9 @@
> > > >
> > > >  	{ .compatible = "nvidia,tegra124", },
> > > >
> > > > +	{ .compatible = "qcom,apq8096", },
> > > > +	{ .compatible = "qcom,msm8996", },
> > > > +
> > > >  	{ .compatible = "st,stih407", },
> > > >  	{ .compatible = "st,stih410", },
> > > >
> > > > diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c
> > > > b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > > > new file mode 100644
> > > > index 0000000..32371cc
> > > > --- /dev/null
> > > > +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > > > @@ -0,0 +1,153 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
> > >
> > > Incorrect multi line comment.
> >
> > This was done as per Bjorn's instruction.
> 
> You haven't followed him correctly.
> 
> What he asked for is:
> 
> // SPDX...
> /*
>  * XXXX
>  */
> 
> What you have done is:
> 
> // SPDX...
> /* XXXX
>  */

OK. Got you. Will fix.

> 
> --
> viresh
