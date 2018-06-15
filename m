Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8AE72C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3272E208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="Gv41Cijc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3272E208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verdurent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756106AbeFOMCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:02:33 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36709 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755749AbeFOMCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:02:31 -0400
Received: by mail-ot0-f196.google.com with SMTP id c15-v6so10715991otl.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 05:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u47249t3hRFJOtVhFhgfZY7bb2nmJQsQ72//v+XKSYg=;
        b=Gv41Cijcc1J5zM1cqdH/il1sh9ZC9YhzfINXLYNeKPhkbSgkP8XWrFhC3Bt6JSyA9d
         dyipAhMN+92xPQbSdZjiyB6hAkFQDuqG2kOx0cs77CtoXgmaVbenBfE0PVvdYm1MIiBb
         5sx8wH0vOfzs4W4o1EOD8wU1b5whgTS7Dg4sZXub5dBnGyX5FD+/BvW/2TLKb4R2IELG
         7GxPtnDJI5yF1pTry6hY0ov4rzJQizUO3xg3L83FoJ9dGC8AcWYfQE+MzgL1ZUXPK4Yi
         43047eKr1yZ9fAPqPRhtCXwcjEdnbBZKAt+vX6HbvSdHl5bltBgCHDPuPzvnP8mRUOQv
         xpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u47249t3hRFJOtVhFhgfZY7bb2nmJQsQ72//v+XKSYg=;
        b=Hbo4C0Iz8JGTLV+CwVs76FFqlb4lR05ZXmLp0wZwKa6bGyd1BkW5KXiliM+mpksUW1
         CLB4eemxUKOSKJIgsA0wiL9nC0VMrCYISDRePdyhMwIbwo8kdQKPmffNmU2/lasjl1H7
         gIyaUN2WyoeHu6doyKYik8EKOM0obIIT51UcXc5iui9lYeEAT7IgBlqjpvCV5W6cEPmk
         Oe3VaEEBwZl5H/5g/sKF1TUpYVw6+xz6Z0BySBIWuF24sDJONqguTuxrEn2O+eUf0Hqp
         jfbfl9tfBToXZECVXHxkZevt7trc25eWTwnEiQUvrwoMx9jUBgFZq9xmI0tC0c/mocfW
         FBCQ==
X-Gm-Message-State: APt69E3RIJ8S3ai6tmUuiRMOB+GfNxXLPmsCg8qW0gQrOAga+GZnYZqB
        FlWik6olBvg1bEf5xSh3ZoYZYDyAoZ+BHeM7PdjteQ==
X-Google-Smtp-Source: ADUXVKLJp21CwXYGMTVZmqESnarC/ScqXz5ViTT6EOEYlKIFKNRYvwrmbnJDH36fHAqFgHhYgcfVW5JHS1hsjZZ9qzs=
X-Received: by 2002:a9d:52a8:: with SMTP id f40-v6mr767861oth.0.1529064151154;
 Fri, 15 Jun 2018 05:02:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:99ab:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 05:02:30
 -0700 (PDT)
In-Reply-To: <1528801355-18719-3-git-send-email-tdas@codeaurora.org>
References: <1528801355-18719-1-git-send-email-tdas@codeaurora.org> <1528801355-18719-3-git-send-email-tdas@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 15 Jun 2018 15:02:30 +0300
Message-ID: <CAHLCerNeWjBY=ZHyrA7RYW6_qSk9SZoxE7P6fr43Z8-pTv-c4Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cpufreq: qcom-fw: Add support for QCOM cpufreq FW driver
To:     Taniya Das <tdas@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <skannan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 2:02 PM, Taniya Das <tdas@codeaurora.org> wrote:
> The CPUfreq FW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this firmware.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |   9 +
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-fw.c | 336 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-fw.c
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 52f5f1a..2683716 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -312,3 +312,12 @@ config ARM_PXA2xx_CPUFREQ
>           This add the CPUFreq driver support for Intel PXA2xx SOCs.
>
>           If in doubt, say N.
> +
> +config ARM_QCOM_CPUFREQ_FW
> +       bool "QCOM CPUFreq FW driver"
> +       help
> +        Support for the CPUFreq FW driver.
> +        The CPUfreq FW preset in some QCOM chipsets offloads the steps

s/preset/present

> +        necessary for changing the frequency of CPUs. The driver

I'd rephrase this a bit to address Sudeep's comment. Something like:

"Some QCOM chipsets have a HW engine to offload the steps necessary
for changing the frequency of the CPUs. Firmware loaded in this engine
exposes a programming interface to the high-level OS. This driver
exposes a cpufreq abstraction for this HW engine. Say Y ....."

> +        implements the cpufreq driver interface for this firmware.
> +        Say Y if you want to support CPUFreq FW.
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index fb4a2ec..34691a2 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -86,6 +86,7 @@ obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)    += tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)     += tegra186-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)           += ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ) += vexpress-spc-cpufreq.o
> +obj-$(CONFIG_ARM_QCOM_CPUFREQ_FW)      += qcom-cpufreq-fw.o
>

<snip>

> +static const struct of_device_id match_table[] = {
> +       { .compatible = "qcom,cpufreq-fw" },
> +       {}
> +};
> +
> +static struct platform_driver qcom_cpufreq_fw_driver = {
> +       .probe = qcom_cpufreq_fw_driver_probe,
> +       .driver = {
> +               .name = "qcom-cpufreq-fw",
> +               .of_match_table = match_table,
> +               .owner = THIS_MODULE,
> +       },
> +};
> +
> +static int __init qcom_cpufreq_fw_init(void)
> +{
> +       return platform_driver_register(&qcom_cpufreq_fw_driver);
> +}
> +subsys_initcall(qcom_cpufreq_fw_init);
> +
> +MODULE_DESCRIPTION("QCOM CPU Frequency FW");

This can be a bit more descriptive, e.g.

"QCOM firmware-based CPU Frequency  driver"

> +MODULE_LICENSE("GPL v2");
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
>
