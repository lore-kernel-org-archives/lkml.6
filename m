Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C16C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19702148D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fyoyanpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeLZTcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:32:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45798 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbeLZTct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:32:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so7866950pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 11:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rjgvH5Ee2jfD5Pf6WL7HCbyAesfJR/ciMJhYO5Wno+0=;
        b=fyoyanpSIHV29gU+fARIsuk/VK1CDVZmv1+if0UDNFCgUzqDsmawlNJOXbrZkQ3uo7
         iB2FfQKdFKLxp2aTFdM34FBLCRXAknLaHZkwnpxveeEYk0DmUphEmtquyC50UjIPehDp
         3sqwDWFMebpZLNnPhfMQ2vFpUzosysW9uBWd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rjgvH5Ee2jfD5Pf6WL7HCbyAesfJR/ciMJhYO5Wno+0=;
        b=WL9fqbCJ6WZapY5iBguYrSAou4+jr4hfTlTUrYVTf/AzV2a1k93AAJfsLhwXntv9Ts
         YSc3/OJE6x+nqqc/rqFLRhrazj7D8fKXxpVwyXCuR/iQRwTQMYrCHpulHjCs5M6SzKeD
         w1bW7/xMPtt3Ee4G1c+w8aergjbVZERQWFnHYz1XiAIwloCR8emWCLb/fhS5y6bqtSpS
         SNi63aEHgb43iDnL4WA4fpQxDMpjepWKfsR3UJXtjws6hjqEs9UBbullkndz78d55OpV
         izPJ97Q5OmWRiiDf21Jg7p40SvVCcQV23rZfUdgCp69qH2dOoU45PWnuno9uNAGJD4f4
         mcMQ==
X-Gm-Message-State: AA+aEWZlkNxd8mH1VuVpamxhmCstAVn0MOszHJ7r++Ddexo1S2oJ63LG
        h21bR6fmXjSbXwYCgXPX1fq8GRVYVukvFw==
X-Google-Smtp-Source: AFSGD/WocS8GmCfEhAOIQMsI3IgRHsfW0m+fFlyC73L494Oc9D4+FY1GVTVHwTYn6gyCJM0w+i2ubg==
X-Received: by 2002:a62:6ec8:: with SMTP id j191mr21332666pfc.198.1545852768307;
        Wed, 26 Dec 2018 11:32:48 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b9sm51820916pfi.118.2018.12.26.11.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 11:32:47 -0800 (PST)
Date:   Wed, 26 Dec 2018 11:32:46 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        amit.kucheria@linaro.org, evgreen@google.com
Subject: Re: [PATCH v1] cpufreq: qcom: Read voltage LUT and populate OPP
Message-ID: <20181226193246.GG261387@google.com>
References: <1545415608-15163-1-git-send-email-tdas@codeaurora.org>
 <20181221205752.GD261387@google.com>
 <2977f340-cd4e-86bc-da3a-8845676e39ed@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2977f340-cd4e-86bc-da3a-8845676e39ed@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

On Mon, Dec 24, 2018 at 12:29:18AM +0530, Taniya Das wrote:
> Hello Matthias,
> 
> Thanks for your review comments.
> 
> On 12/22/2018 2:27 AM, Matthias Kaehlcke wrote:
> > Hi Taniya,
> > 
> > On Fri, Dec 21, 2018 at 11:36:48PM +0530, Taniya Das wrote:
> > > Add support to read the voltage look up table and populate OPP for all
> > > corresponding CPUS.
> > > 
> > > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > > ---
> > >   drivers/cpufreq/qcom-cpufreq-hw.c | 32 ++++++++++++++++++++++++++++++--
> > >   1 file changed, 30 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > index d83939a..7559b87 100644
> > > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > @@ -10,18 +10,21 @@
> > >   #include <linux/module.h>
> > >   #include <linux/of_address.h>
> > >   #include <linux/of_platform.h>
> > > +#include <linux/pm_opp.h>
> > >   #include <linux/slab.h>
> > > 
> > >   #define LUT_MAX_ENTRIES			40U
> > >   #define LUT_SRC				GENMASK(31, 30)
> > >   #define LUT_L_VAL			GENMASK(7, 0)
> > >   #define LUT_CORE_COUNT			GENMASK(18, 16)
> > > +#define LUT_VOLT			GENMASK(11, 0)
> > >   #define LUT_ROW_SIZE			32
> > >   #define CLK_HW_DIV			2
> > > 
> > >   /* Register offsets */
> > >   #define REG_ENABLE			0x0
> > > -#define REG_LUT_TABLE			0x110
> > > +#define REG_FREQ_LUT_TABLE		0x110
> > > +#define REG_VOLT_LUT_TABLE		0x114
> > 
> > The new names suggest that there is a LUT for frequencies and another
> > one for voltages. I don't have access to hardware documentation, but
> > from the code and offsets in this driver it seems there is a single
> > table at offset 0x110, with a 'row' of 32 bytes per OPP. Within this
> > row the frequency (and other values) is located at offset 0, the
> > voltage at offset 4.
> > 
> > I'd suggest to keep REG_LUT_TABLE, add a define LUT_OFFSET_VOLTAGE/MV
> > (or similar) and adjust the math in qcom_cpufreq_hw_read_lut() to use
 > > REG_LUT_TABLE as base offset.
> > 
> 
> These names are as per HW documentation and the math is kept as per the
> documentation for reading the voltage.

The HW documentation is confusing then and I'm not convinced this
should be carried over 1:1 to the driver. In any case this
documentation is only available to a reduced audience, why make it
harder for everyone else?

I think something like this would be preferable (removed _TABLE suffix,
since that's already part of LUT):

#define OFFSET_LUT		0x110
#define REG_FREQ_LUT		0x00
#define REG_VOLT_LUT		0x04

freq = read(OFFSET_LUT + (LUT_ROW_SIZE * i) + REG_FREQ_LUT);
volt = read(OFFSET_LUT + (LUT_ROW_SIZE * i) + REG_VOLT_LUT);

or probably better:

row_addr = OFFSET_LUT + (LUT_ROW_SIZE * i);
freq = read(row_addr + REG_FREQ_LUT);
volt = read(row_addr + REG_VOLT_LUT);

> > >   #define REG_PERF_STATE			0x920
> > > 
> > >   static unsigned long cpu_hw_rate, xo_rate;
> > > @@ -75,19 +78,26 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
> > >   				    void __iomem *base)
> > >   {
> > >   	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
> > > +	u32 volt;
> > >   	unsigned int max_cores = cpumask_weight(policy->cpus);
> > >   	struct cpufreq_frequency_table	*table;
> > > +	unsigned long cpu_r;
> > 
> > nit: why 'cpu_r' and not just 'cpu'?
> > 
> > (if it is needed at all, see my comment below)
> > 
> > > 
> > >   	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
> > >   	if (!table)
> > >   		return -ENOMEM;
> > > 
> > >   	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> > > -		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
> > > +		data = readl_relaxed(base + REG_FREQ_LUT_TABLE +
> > > +				      i * LUT_ROW_SIZE);
> > >   		src = FIELD_GET(LUT_SRC, data);
> > >   		lval = FIELD_GET(LUT_L_VAL, data);
> > >   		core_count = FIELD_GET(LUT_CORE_COUNT, data);
> > > 
> > > +		data = readl_relaxed(base + REG_VOLT_LUT_TABLE +
> > > +				      i * LUT_ROW_SIZE);
> > > +		volt = FIELD_GET(LUT_VOLT, data) * 1000;
> > > +
> > >   		if (src)
> > >   			freq = xo_rate * lval / 1000;
> > >   		else
> > > @@ -123,6 +133,10 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
> > > 
> > >   		prev_cc = core_count;
> > >   		prev_freq = freq;
> > > +
> > > +		freq *= 1000;
> > > +		for_each_cpu(cpu_r, policy->cpus)
> > > +			dev_pm_opp_add(get_cpu_device(cpu_r), freq, volt);
> > 
> > Are you sure we want to duplicate the OPP entries for all CPUs in the
> > cluster? IIUC the frequencies of the cores in a cluster can't be
> > changed individually, hence the cores should have a shared table. I
> > think dev_pm_opp_get_sharing_cpus() does what you need.
> > 
> > You currently also add OPPs for invalid frequencies. From my SDM845
> > device:
> > 
> > cat /sys/devices/system/cpu/cpufreq/policy4/scaling_available_freq
> >    => 825600 902400 979200 1056000 1209600 1286400 1363200 1459200
> >    1536000 1612800 1689600 1766400 1843200 1920000 1996800 2092800
> >    2169600 2246400 2323200 2400000 2476800 2553600 2649600
> > 
> > cat /sys/devices/system/cpu/cpufreq/policy4/scaling_boost_frequencies
> > 2803200
> > 
> > ls /sys/kernel/debug/opp/cpu4/
> > opp:1056000000  opp:1612800000  opp:2092800000  opp:2553600000  opp:825600000
> > opp:1209600000  opp:1689600000  opp:2169600000  opp:2649600000  opp:902400000
> > opp:1286400000  opp:1766400000  opp:2246400000  opp:2707200000  opp:979200000
> > opp:1363200000  opp:1843200000  opp:2323200000  opp:2764800000
> > opp:1459200000  opp:1920000000  opp:2400000000  opp:2784000000
> > opp:1536000000  opp:1996800000  opp:2476800000  opp:2803200000
> > 
> > There are OPP entries for 2707200000, 2764800000 and 2784000000 Hz,
> > however these frequencies appear neither in available_frequencies nor
> > boost_frequencies.
> > 
> > >   	}
> > > 
> 
> Could you help validating with the patch below?
> 
> > >   	table[i].frequency = CPUFREQ_TABLE_END;
> > > @@ -159,10 +173,18 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> > >   	struct device *dev = &global_pdev->dev;
> > >   	struct of_phandle_args args;
> > >   	struct device_node *cpu_np;
> > > +	struct device *cpu_dev;
> > >   	struct resource *res;
> > >   	void __iomem *base;
> > >   	int ret, index;
> > > 
> > > +	cpu_dev = get_cpu_device(policy->cpu);
> > > +	if (!cpu_dev) {
> > > +		pr_err("%s: failed to get cpu%d device\n", __func__,
> > > +		       policy->cpu);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > >   	cpu_np = of_cpu_device_node_get(policy->cpu);
> > >   	if (!cpu_np)
> > >   		return -EINVAL;
> > > @@ -205,6 +227,12 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> > >   		goto error;
> > >   	}
> > > 
> > > +	ret = dev_pm_opp_get_opp_count(cpu_dev);
> > > +	if (ret <= 0) {
> > > +		dev_err(cpu_dev, "OPP table is not ready\n");
> > > +		goto error;
> > > +	}
> > > +
> > >   	policy->fast_switch_possible = true;
> > > 
> > >   	return 0;
> > 
> > I suppose we want to remove the OPPs when the cpufreq driver is
> > unloaded, looks like dev_pm_opp_cpumask_remove_table() should do the
> > trick.
> > 
> > Cheers
> > 
> > Matthias
> > 
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c
> b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 7559b87..23338b2 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -81,7 +81,6 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>         u32 volt;
>         unsigned int max_cores = cpumask_weight(policy->cpus);
>         struct cpufreq_frequency_table  *table;
> -       unsigned long cpu_r;
> 
>         table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>         if (!table)
> @@ -110,6 +109,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>                         table[i].frequency = freq;
>                         dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
>                                 freq, core_count);
> +                       dev_pm_opp_add(get_cpu_device(policy->cpu),
> +                                       freq * 1000, volt);

nit: I'd suggest to put this before dev_dbg() or assign the table
after dev_dbg(), to keep the actual actions together instead of
splitting them unnecessarily with a debug log.

>                 }
> 
>                 /*
> @@ -126,6 +127,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>                         if (prev_cc != max_cores) {
>                                 prev->frequency = prev_freq;
>                                 prev->flags = CPUFREQ_BOOST_FREQ;
> +                               dev_pm_opp_add(get_cpu_device(policy->cpu),
> +                                               prev_freq * 1000, volt);
>                         }
> 
>                         break;
> @@ -133,12 +136,9 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
> 
>                 prev_cc = core_count;
>                 prev_freq = freq;
> -
> -               freq *= 1000;
> -               for_each_cpu(cpu_r, policy->cpus)
> -                       dev_pm_opp_add(get_cpu_device(cpu_r), freq, volt);
>         }
> 
> +       dev_pm_opp_set_sharing_cpus(get_cpu_device(policy->cpu),
> policy->cpus);

nit: since the loop above first initializes the table and then adds
the OPP it would be slightly more consistent to also finish the
table business first here and then handle the OPPs. Shouldn't make a
functional difference though, just a suggestion.

>         table[i].frequency = CPUFREQ_TABLE_END;
>         policy->freq_table = table;
> 
> @@ -245,6 +245,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct
> cpufreq_policy *policy)
>  {
>         void __iomem *base = policy->driver_data - REG_PERF_STATE;
> 
> +       dev_pm_opp_cpumask_remove_table(policy->cpus);
>         kfree(policy->freq_table);
>         devm_iounmap(&global_pdev->dev, base);
>

Looks good to me except for the nits.

Unbinding the device ("echo 17d43000.cpufreq > /sys/bus/platform/drivers/qcom-cpufreq-hw/unbind")
results in a similar lockdep spat as the one reported earlier by
Stephen (https://lore.kernel.org/patchwork/patch/1024546/#1209031),
this time involving 'dev_pm_opp_cpumask_remove_table', however I don't
think this an issue introduced by this patch.

Thanks

Matthias
