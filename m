Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19599C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5281222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550141945;
	bh=avSSnsVp0AzU4QfsW85GemTYSnJT8c+DQXweCdcC46s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j5JFuv4jJiAyLyj35X2/g+CLGz4MAniKolTJ+wSZWmuMbC0248gybIR/0y7XPIN8o
	 orn4qSoSkJkYF0HN55ReDLAzN/LDciBD1uwRepdeNZBiseHa1cWxr6xyKsycMArhXj
	 eEVr1L4FYCan/5qK/ma+GV5u+KPovoNstOKm0kQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438451AbfBNK7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:59:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45576 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbfBNK7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:59:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so9698514ota.12;
        Thu, 14 Feb 2019 02:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XoVfC9xFl1utiQR/0Z9FxzmWijbTYASyvpir0lmcRc=;
        b=dmQC0GKYWJYHwMpRfeclbtSK5ySD95GXETFNTPmq6PVr1f476HvRNM9YwW1rgdSTo+
         GtGHMk+o13AKKWzB0VrG0Vw/VXZnIL2JVWcdwqT14aGCYvN8nMokKQIw+CL9SawT9r3W
         PbuvKreIbshqHQPas1OcvaxqLG6RGGu82uM8iWfww0ue1hAMZPjR9ceMA4KQDOthJ9r/
         lSfnyG7i8wMwyQWGNqyoR3OnumalMvIlPE4cDqWMylpCUjgVTBTUySHP/Y3Nlevibze3
         YTwvfbzg+sEJb1a3THi96+N1KywzEETcfq8YgSO5yzc4iYXq4dZNbA/86pLUQ4OdyplX
         VY4w==
X-Gm-Message-State: AHQUAubqPBIo0YcSXlm9DJj/vlnXDuz69j3l3Tuj+3GJ0OqORqCzqS7P
        SS2tuDucwst1DxUmvDisFOqxSz5A1RAYm6jAxPQ=
X-Google-Smtp-Source: AHgI3IasxO2a3+X8CsbWTwePe1T4+NMCT1flH33DsU61ze2DQ76++QL9/XpodiO05X9bEpAobtg5nbXesXG+80pApnk=
X-Received: by 2002:aca:f4d3:: with SMTP id s202mr1911937oih.178.1550141942347;
 Thu, 14 Feb 2019 02:59:02 -0800 (PST)
MIME-Version: 1.0
References: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com> <1550130368-60513-3-git-send-email-wangxiongfeng2@huawei.com>
In-Reply-To: <1550130368-60513-3-git-send-email-wangxiongfeng2@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Feb 2019 11:58:51 +0100
Message-ID: <CAJZ5v0j03Dj7XSbTNcu7Ew2SekdpTw2hrWT_L+5ZcdRUep7ppw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, gcherianv@gmail.com,
        Prashanth Prakash <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 8:46 AM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> Hisilicon chips do not support delivered performance counter register
> and reference performance counter register. But the platform can
> calculate the real performance using its own method. This patch provide
> a workaround for this problem, and other platforms can also use this
> workaround framework. We reuse the desired performance register to
> store the real performance calculated by the platform. After the
> platform finished the frequency adjust, it gets the real performance and
> writes it into desired performance register. OS can use it to calculate
> the real frequency.
>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index fd25c21c..da96fec 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -33,6 +33,16 @@
>  /* Offest in the DMI processor structure for the max frequency */
>  #define DMI_PROCESSOR_MAX_SPEED  0x14
>
> +struct cppc_workaround_info {
> +       char oem_id[ACPI_OEM_ID_SIZE +1];
> +       char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
> +       u32 oem_revision;
> +       unsigned int (*get_rate)(unsigned int cpu);
> +};
> +
> +/* CPPC workaround for get_rate callback */
> +unsigned int (*cppc_wa_get_rate)(unsigned int cpu);
> +

First off, please don't split the workaround material into two parts.
IOW, the other new function added below can go here just fine IMO.

>  /*
>   * These structs contain information parsed from per CPU
>   * ACPI _CPC structures.
> @@ -334,6 +344,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>         struct cppc_cpudata *cpu = all_cpu_data[cpunum];
>         int ret;
>
> +       if (cppc_wa_get_rate)
> +               return cppc_wa_get_rate(cpunum);

Second, what is the value of using the function pointer above?

All we need for now is a flag to indicate whether or not to call
hisi_cppc_cpufreq_get_rate() here and return its return value.

> +
>         ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
>         if (ret)
>                 return ret;
> @@ -357,6 +370,61 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
>         .name = "cppc_cpufreq",
>  };
>
> +/*
> + * HISI platform does not support delivered performance counter and
> + * reference performance counter. It can calculate the performance using the
> + * platform specific mechanism. We reuse the desired performance register to
> + * store the real performance calculated by the platform.
> + */
> +static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
> +{
> +       struct cppc_cpudata *cpudata = all_cpu_data[cpunum];
> +       u64 desired_perf;
> +       int ret;
> +
> +       ret = cppc_get_desired_perf(cpunum, &desired_perf);
> +       if (ret < 0)
> +               return -EIO;
> +
> +       return cppc_cpufreq_perf_to_khz(cpudata, desired_perf);
> +}
> +
> +static struct cppc_workaround_info wa_info[] = {
> +       {
> +               .oem_id         = "HISI  ",
> +               .oem_table_id   = "HIP07   ",
> +               .oem_revision   = 0,
> +               .get_rate = hisi_cppc_cpufreq_get_rate,
> +       }, {
> +               .oem_id         = "HISI  ",
> +               .oem_table_id   = "HIP08   ",
> +               .oem_revision   = 0,
> +               .get_rate = hisi_cppc_cpufreq_get_rate,
> +       }
> +};
> +
> +static int cppc_check_workaround(void)

And this function can be a void one.


> +{
> +       struct acpi_table_header *tbl;
> +       acpi_status status = AE_OK;
> +       int i;
> +
> +       status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
> +       if (ACPI_FAILURE(status) || !tbl)
> +               return -EINVAL;
> +
> +       for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
> +               if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
> +                   !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
> +                   wa_info[i].oem_revision == tbl->oem_revision) {
> +                       cppc_wa_get_rate = wa_info[i].get_rate;
> +                       return 0;
> +               }
> +       }
> +
> +       return -ENODEV;
> +}
> +
>  static int __init cppc_cpufreq_init(void)
>  {
>         int i, ret = 0;
> @@ -386,6 +454,8 @@ static int __init cppc_cpufreq_init(void)
>                 goto out;
>         }
>
> +       cppc_check_workaround();
> +
>         ret = cpufreq_register_driver(&cppc_cpufreq_driver);
>         if (ret)
>                 goto out;
> --
