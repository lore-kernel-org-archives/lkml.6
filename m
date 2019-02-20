Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABBBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EEC2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxT48tE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfBTQ0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:26:53 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37753 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfBTQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:26:53 -0500
Received: by mail-qt1-f195.google.com with SMTP id a48so27851084qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 08:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eozX9FP7k9coPJlrRTh06AeTbiW+jXWRV5fsGGgST9g=;
        b=YxT48tE1HsY6La1HstaM8C55H9xwQEH/uhsOSnowvBOgRChQvtSdzJdUWkFuXu6HmJ
         Kmoq2EnwwM+szkFoFDMKM9oCQa62ejBn5YiK6fGRyGKzeEK5noxlmi/gh1cIJ8at5nrr
         gpqx9BSKwfhDHh1s7sdrqD85YxWBh8m/PLxJRjJCPoYRCEisRaLC/31jpxTf5kVjNyzG
         s9Hb8HJ3qhk9s4ev/Ceyu06Evx46XSNDVoyrOMCo1bwTpxWB8qW0icsAelO10KdlAYzk
         lD2Rc4FAUlQne51LyZsp0AZ7TF5ewQPyi0z30RhR+Td7w0DDZo78e2crcLMHsla6rnif
         GTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eozX9FP7k9coPJlrRTh06AeTbiW+jXWRV5fsGGgST9g=;
        b=aienl+OFQYXCJn15uclqmzZH/n2PDjwHX1C9dVz8FCFo7775iS7e66RaPpYAoraBP/
         BVRWxETGP5oqdZlyUk0FBpz0K2USlHslzlk1nfjnyBUb5UX6E8zCPFH+Q5SnxvaJBVL7
         VJyOwVHCcmBKIcJPzt8V/F2cGGsF/XuYO59xFntyiEwwK3xgofqCk0/WC+92+LIVUYQR
         gEKCWSY8CxKdK7/znocMcjVqrPyxdxSEjpADpnRfyTLCmBuTrLqQWYuqfFZYfTkjU6fP
         MONjdHhFH1d3WphX3BpSBQuaIuDMkh0lgX3z3LmCkHGgqS8p/XY+u295OQqxKQqPTvfv
         pHAw==
X-Gm-Message-State: AHQUAua+OyNfSBUbh10MDvKUsM3M+YuOPOryJw2IRclwZIjxUU7/abLP
        JBRL8Gyf9EzqKreUK4txlw+0pjmNRHm733c9smcfJA==
X-Google-Smtp-Source: AHgI3IamgebrUZ0MqQEo3Q3h+CVE+cDu0cNp7nKiHxkjvSrTwXQHIrz5DoeNZrtvDb7VZVIwoAbkLDP+q1+WMDpA0Jw=
X-Received: by 2002:ac8:35eb:: with SMTP id l40mr8426232qtb.207.1550680011986;
 Wed, 20 Feb 2019 08:26:51 -0800 (PST)
MIME-Version: 1.0
References: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
In-Reply-To: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 20 Feb 2019 21:56:40 +0530
Message-ID: <CAP245DWuJTXfAc3QyqXjePqy32GHQsEqHbuSvjiS4EE3-TV1PA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: kyro: Reduce frame-size of qcom_cpufreq_kryo_probe()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 4:44 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> With the introduction of commit 846a415bf440 ("arm64: default NR_CPUS to
> 256"), we have started getting following compilation warning:
>
> qcom-cpufreq-kryo.c:168:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>
> Fix that by dynamically allocating opp_tables and freeing it later.
>
> Compile tested only.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 1c8583cc06a2..6888cb6db2ef 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -75,7 +75,7 @@ static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
>
>  static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>  {
> -       struct opp_table *opp_tables[NR_CPUS] = {0};
> +       struct opp_table **opp_tables;
>         enum _msm8996_version msm8996_version;
>         struct nvmem_cell *speedbin_nvmem;
>         struct device_node *np;
> @@ -133,6 +133,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>         }
>         kfree(speedbin);
>
> +       opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
> +       if (!opp_tables)
> +               return -ENOMEM;
> +

Perhaps add a comment above that that actual opp_table is allocated in
the loop below because of dev_pm_opp_set_supported_hw?

I was staring at this for a few minutes wondering why you needed this
kcalloc before I realised that opp_tables (missed the 's') is a
temporary array of pointers. :-)

Otherwise,

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

>         for_each_possible_cpu(cpu) {
>                 cpu_dev = get_cpu_device(cpu);
>                 if (NULL == cpu_dev) {
> @@ -149,6 +153,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       kfree(opp_tables);
> +
>         cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
>                                                           NULL, 0);
>         if (!IS_ERR(cpufreq_dt_pdev))
> @@ -163,6 +169,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>                         break;
>                 dev_pm_opp_put_supported_hw(opp_tables[cpu]);
>         }
> +       kfree(opp_tables);
>
>         return ret;
>  }
> --
> 2.21.0.rc0.269.g1a574e7a288b
>
