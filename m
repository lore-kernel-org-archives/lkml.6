Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806B3C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403802184C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx+sZARH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfAYHHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:07:47 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39003 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfAYHHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:07:47 -0500
Received: by mail-qk1-f195.google.com with SMTP id c21so4868197qkl.6;
        Thu, 24 Jan 2019 23:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtmRuc5Q7t0P7XtCdhqDORsl/U63/ajmY37PWV9vxqM=;
        b=gx+sZARHlajSN3GefUdBT4F4PCa8rjTvs99GBxUHeeeTQ/lOreGCQZvePG+Q1uSuA8
         Ud7zPL99YRq25ahwieMNZtlKIAZ4AfZCQ+seysGkrgQpKKVa9lxUTavdt6Jjz7+AdN8l
         FItbQWt/oBomKhIjLmmK4pYHeyhp2CLmKpi9or3tVedvCYqr2DaTYUIoOg2k9siH0KDN
         iF+B0rWQZk5S6DpMqA3URYSWCYH0T6g/rh9QCR/YncEluwqvKCc4DGzAkGKr7mWGKaU5
         x1aaZtzF1an5XVc8cDUHpsxiNwVIMLXliaZ8brD1aNDAja4vnm0rJu1y1deazXXUBwSb
         w1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtmRuc5Q7t0P7XtCdhqDORsl/U63/ajmY37PWV9vxqM=;
        b=lNHi83P8u6jKO+eS6YACN15888AilsgLkyiCvJdbRPw7Nl5v2bcP8xhw6h2adWF9GW
         zx0btk4+y6KaSNfE36qv0JinO2bh9Dc5ldyT9HNzLEx4RjL2grjn7KYFiO8Gqg6ywR+w
         jahfphaO/IU5nS+wwI/BPWye7gzT6s5THW6rR1tojmtNvcVt2jO4ooTzwJ+sFW/qi6hB
         ix19qWHBaTuV+zEbF9r9GYd/hkKLSPqGHVnM7IRRUWIruO1Y7fsBRMjvBmfejRvrALHd
         LlLCc5h65Y1cweGi/IYpYppVl2cIiIP4+OEiXdzaJUmOQ9zabu1E/f3B07+BmJDfdpyr
         5ozw==
X-Gm-Message-State: AJcUukfwC+6oUr3pcOzSBEI6iSfpV35DC6FXonpXw/R22ZxQkzVGrec6
        OF/IJW3vU5Cam8Hhimph3S/V99HAp5hLnH4hthU=
X-Google-Smtp-Source: ALg8bN6O4zvlfJ9ntfUPuBLDnoc6bPNNL6bg7KqMgJFTlwLjmY0CfpLSZ8mwLMsbJimYTP0qN/swVQLheINo/qaXxHo=
X-Received: by 2002:a37:6e43:: with SMTP id j64mr8156537qkc.278.1548400065734;
 Thu, 24 Jan 2019 23:07:45 -0800 (PST)
MIME-Version: 1.0
References: <1547722811-18052-1-git-send-email-wangxiongfeng2@huawei.com> <20190124065614.gnnwd6lhbyjiph2e@vireshk-i7>
In-Reply-To: <20190124065614.gnnwd6lhbyjiph2e@vireshk-i7>
From:   George Cherian <gcherianv@gmail.com>
Date:   Fri, 25 Jan 2019 12:37:34 +0530
Message-ID: <CABYS093CQdhNBb8KqfV+3FfNCGcgW7DE+KsQ=DAJnRFQq74Piw@mail.gmail.com>
Subject: Re: [RFC PATCH] cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        George Cherian <george.cherian@cavium.com>,
        Prashanth Prakash <pprakash@codeaurora.org>,
        robert.moore@intel.com, lenb@kernel.org, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, guohanjun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On Thu, Jan 24, 2019 at 12:27 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> +George/Prashanth.
>
> Guys please see if you have any objections to this patch. I am not
> very familiar with this stuff and it would be good to get some
> feedback from you guys.
>
> @Rafael: Do you have any comments on this ?
>
> On 17-01-19, 19:00, Xiongfeng Wang wrote:
> > Hisilicon chips do not support delivered performance counter register
> > and reference performance counter register. But the platform can
> > calculate the real performance using its own method. This patch provide
> > a workaround for this problem, and other platforms can also use this
> > workaround framework. We reuse the desired performance register to
> > store the real performance calculated by the platform. After the
> > platform finished the frequency adjust, it gets the real performance and
> > writes it into desired performance register. OS can use it to calculate
> > the real frequency.
Does your platform support Autonomous Selection mode?
This register is not valid when autonomous mode is enabled. In such case
how are you calculating the frequency?
> >
> > Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > ---
> >  drivers/acpi/cppc_acpi.c       | 29 ++++++++++++++++++++
> >  drivers/cpufreq/Kconfig.arm    |  7 +++++
> >  drivers/cpufreq/cppc_cpufreq.c | 62 ++++++++++++++++++++++++++++++++++++++++++
> >  include/acpi/cppc_acpi.h       |  4 +++
> >  4 files changed, 102 insertions(+)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 217a782..0cdaf7e 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -1050,6 +1050,35 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
> >       return ret_val;
> >  }
> >
> > +#ifdef CONFIG_HISILICON_CPPC_CPUFREQ_WORKAROUND
> > +/*
> > + * We reuse the desired performance register to store the real performance
> > + * calculated by the platform.
> > + */
> > +u64 hisi_cppc_get_real_perf(unsigned int cpunum)
> > +{
> > +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> > +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> > +     struct cpc_register_resource *desired_reg;
> > +     u64 desired_perf;
> > +     int ret;
> > +
> > +     /*
> > +      * Make sure the platform has finished the frequency adjust
> > +      * and wrote the real performance in desired performance register
> > +      */
> > +     ret = check_pcc_chan(pcc_ss_id, false);
> > +     if (ret)
> > +             return 0;
If there is a pending command in the channel then returning zero
will give bogus frequency value. You may return the previous written value.
> > +
> > +     desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
> > +     cpc_read(cpunum, desired_reg, &desired_perf);
> > +
> > +     return desired_perf;
> > +}
> > +EXPORT_SYMBOL_GPL(hisi_cppc_get_real_perf);
> > +#endif
> > +
> >  /**
> >   * cppc_get_perf_caps - Get a CPUs performance capabilities.
> >   * @cpunum: CPU from which to get capabilities info.
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 688f102..236bd07 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -18,6 +18,13 @@ config ACPI_CPPC_CPUFREQ
> >
> >         If in doubt, say N.
> >
> > +config HISILICON_CPPC_CPUFREQ_WORKAROUND
> > +     bool "Workaround for Hisilicon CPPC Cpufreq"
> > +     default y
> > +     depends on ACPI_CPPC_CPUFREQ && ARM64
Do you really want this to be applied to all ARM64? or just only
for affected HISI platforms?
> > +     help
> > +       This option enables a workaround for Hisilicon CPPC Cpufreq.
> > +
> >  config ARM_ARMADA_37XX_CPUFREQ
> >       tristate "Armada 37xx CPUFreq support"
> >       depends on ARCH_MVEBU && CPUFREQ_DT
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index fd25c21c..b910e84 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -33,6 +33,13 @@
> >  /* Offest in the DMI processor structure for the max frequency */
> >  #define DMI_PROCESSOR_MAX_SPEED  0x14
> >
> > +struct cppc_get_rate_workaround_info {
If your intention is to make a generic framework for future extensions
then you might need to name it differently. Something like
struct cppc_workaround_info, so that you can extend the same for any
future workarounds.
> > +     char oem_id[ACPI_OEM_ID_SIZE +1];
> > +     char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> > +     u32 oem_revision;
> > +     unsigned int (*get)(unsigned int cpu);
This can be  unsigned int (*get_rate)(unsigned int cpu);
> > +};
> > +
> >  /*
> >   * These structs contain information parsed from per CPU
> >   * ACPI _CPC structures.
> > @@ -357,6 +364,59 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> >       .name = "cppc_cpufreq",
> >  };
> >
> > +#ifdef CONFIG_HISILICON_CPPC_CPUFREQ_WORKAROUND
> > +/*
> > + * When the platform does not support delivered performance counter or
> > + * reference performance counter, it can calculate the performance using the
> > + * platform specific mechanism. We reuse the desired performance register to
> > + * store the real performance calculated by the platform.
> > + */
> > +static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
> > +{
> > +     struct cppc_cpudata *cpu = all_cpu_data[cpunum];
> > +     u64 desired_perf = hisi_cppc_get_real_perf(cpunum);
> > +
> > +     return cppc_cpufreq_perf_to_khz(cpu, desired_perf);
> > +}
> > +#endif
> > +
> > +static struct cppc_get_rate_workaround_info wa_info[] = {
> > +#ifdef CONFIG_HISILICON_CPPC_CPUFREQ_WORKAROUND
> > +     {
> > +             .oem_id         = "HISI  ",
> > +             .oem_table_id   = "HIP07   ",
> > +             .oem_revision   = 0,
> > +             .get = hisi_cppc_cpufreq_get_rate,
> > +     },
> > +     {
>
> This should be:
>
>         }, {
>
> > +             .oem_id         = "HISI  ",
> > +             .oem_table_id   = "HIP08   ",
> > +             .oem_revision   = 0,
> > +             .get = hisi_cppc_cpufreq_get_rate,
> > +     },
> > +#endif
> > +     {},
> > +};
> > +
> > +static void cppc_check_get_rate_workaround(struct cpufreq_driver *cppc_cpufreq_driver)
This function can be renamed to cppc_check_workaround to make it
generic also can have a
proper return value so that the caller can validate.
> > +{
> > +     struct acpi_table_header *tbl;
> > +     acpi_status status = AE_OK;
> > +     int i;
> > +
> > +     status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
> > +     if (ACPI_FAILURE(status) || !tbl)
> > +             return;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(wa_info) - 1; i++) {
> > +             if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
> > +                 !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
> > +                 wa_info[i].oem_revision == tbl->oem_revision) {
> > +                     cppc_cpufreq_driver->get = wa_info[i].get;
> > +                     return;
> > +             }
> > +     }
> > +}
> >  static int __init cppc_cpufreq_init(void)
> >  {
> >       int i, ret = 0;
> > @@ -386,6 +446,8 @@ static int __init cppc_cpufreq_init(void)
> >               goto out;
> >       }
> >
> > +     cppc_check_get_rate_workaround(&cppc_cpufreq_driver);
> > +
> >       ret = cpufreq_register_driver(&cppc_cpufreq_driver);
> >       if (ret)
> >               goto out;
> > diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> > index 4f34734..be7400b 100644
> > --- a/include/acpi/cppc_acpi.h
> > +++ b/include/acpi/cppc_acpi.h
> > @@ -146,4 +146,8 @@ struct cppc_cpudata {
> >  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
> >  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> >
> > +#ifdef CONFIG_HISILICON_CPPC_CPUFREQ_WORKAROUND
> > +u64 hisi_cppc_get_real_perf(unsigned int cpunum);
> > +#endif
> > +
> >  #endif /* _CPPC_ACPI_H*/
> > --
> > 1.7.12.4
>
> --
> viresh
-George
