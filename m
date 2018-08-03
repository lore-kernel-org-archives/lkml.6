Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A522C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8842174D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IOyJ8qHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8842174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbeHCRKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:10:15 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37107 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732219AbeHCRKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:10:15 -0400
Received: by mail-oi0-f67.google.com with SMTP id j205-v6so10426642oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 08:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mj2+cFTAaz7k1cf7oyPUZcTSKYrY0YS8QFtx86Ti4u0=;
        b=IOyJ8qHhBqVjKGTJoPcla/aZNohs/o8wKbHZBHx5GG6r7g6s2URzckazeuYAtN2bNT
         a6k/WegrkqZ2yrh69SItTu6DIDeB3KMdCzvvdw8ZZ4QBFk7Py4uuXzIYQSkwgbBNEM3c
         DhIIFe5qY1kpPupoUNE+zfOIXvaL6UNLUVnsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mj2+cFTAaz7k1cf7oyPUZcTSKYrY0YS8QFtx86Ti4u0=;
        b=pNu9NNziSRDQekU52R5fWdtQPQvKhj2T/s8dkGUJDPoH5IVIioLYYXsVnn7lsaR5fa
         MjdMC96dV9IYLWwA0LnlF9C+iJp1aU/EgwKcSuGGNPuJbi933M5wRJyLXXWQQMz6JX5a
         v3Fgm7V+hyKYeh5Xf8KRuuR02xHPjH7onFBwhDL/fTiiNRvE+UMJHBNfq1bwJ4372duK
         ZeK60nIV+9lJKQBD+qiLVG5diQi3+MYJLjdPPjW4eYtUBWPYB0aNEhA5RXx6Flfjn/da
         60sePQ9PmiYu8bjBhjeUCIXtmTgK0Dj8F9XRkLwVGQK+L8xC8rxP3G101gzR6Rn33s2e
         6n+w==
X-Gm-Message-State: AOUpUlHn98nodQZqM7wfuQeRDwsQoXDMmhNkqdRkSPEkE2/AOLtyZulw
        CWqmrP3OrXSE0j007Pa+5TPRkwdWl/B4elD8hrg8wg==
X-Google-Smtp-Source: AAOMgpfaWPacvf9x61mAevGue8dVGn+tIjhMczlawyRhUYSjHBTWotlS3J21pV4QnsYhUp4Vm5kQZNu6m6KyM+P2Ouw=
X-Received: by 2002:aca:afcc:: with SMTP id y195-v6mr3808647oie.322.1533309209620;
 Fri, 03 Aug 2018 08:13:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 08:13:28 -0700 (PDT)
In-Reply-To: <7a67a1f9-9cd1-103e-cfa1-e032f346e164@intel.com>
References: <1532931343-9499-1-git-send-email-srinath.mannam@broadcom.com>
 <1532931343-9499-3-git-send-email-srinath.mannam@broadcom.com> <7a67a1f9-9cd1-103e-cfa1-e032f346e164@intel.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 3 Aug 2018 20:43:28 +0530
Message-ID: <CABe79T7GAQybN_SCic1cQ1554vbZqpHysExbDbY+nffRcuNZ8g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: host: iproc: Add ACPI support to IPROC SDHCI
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian Hunter,

Thank you very much for your review and feedback.

I will do the change and update next patch set.

Regards,
Srinath.

On Fri, Aug 3, 2018 at 6:47 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 30/07/18 09:15, Srinath Mannam wrote:
>> Add ACPI support to all IPROC SDHCI varients
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>
> One minor comment below, otherwise:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
>> ---
>>  drivers/mmc/host/Kconfig       |  1 +
>>  drivers/mmc/host/sdhci-iproc.c | 63 +++++++++++++++++++++++++++++-------------
>>  2 files changed, 45 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 0581c19..bc6702e 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -334,6 +334,7 @@ config MMC_SDHCI_IPROC
>>       tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
>>       depends on ARCH_BCM2835 || ARCH_BCM_IPROC || COMPILE_TEST
>>       depends on MMC_SDHCI_PLTFM
>> +     depends on OF || ACPI
>>       default ARCH_BCM_IPROC
>>       select MMC_SDHCI_IO_ACCESSORS
>>       help
>> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
>> index d0e83db..abf5269 100644
>> --- a/drivers/mmc/host/sdhci-iproc.c
>> +++ b/drivers/mmc/host/sdhci-iproc.c
>> @@ -15,6 +15,7 @@
>>   * iProc SDHCI platform driver
>>   */
>>
>> +#include <linux/acpi.h>
>>  #include <linux/delay.h>
>>  #include <linux/module.h>
>>  #include <linux/mmc/host.h>
>> @@ -162,9 +163,19 @@ static void sdhci_iproc_writeb(struct sdhci_host *host, u8 val, int reg)
>>       sdhci_iproc_writel(host, newval, reg & ~3);
>>  }
>>
>> +static unsigned int sdhci_iproc_get_max_clock(struct sdhci_host *host)
>> +{
>> +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +
>> +     if (pltfm_host->clk)
>> +             return sdhci_pltfm_clk_get_max_clock(host);
>> +     else
>> +             return pltfm_host->clock;
>> +}
>> +
>>  static const struct sdhci_ops sdhci_iproc_ops = {
>>       .set_clock = sdhci_set_clock,
>> -     .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>> +     .get_max_clock = sdhci_iproc_get_max_clock,
>>       .set_bus_width = sdhci_set_bus_width,
>>       .reset = sdhci_reset,
>>       .set_uhs_signaling = sdhci_set_uhs_signaling,
>> @@ -178,7 +189,7 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
>>       .write_w = sdhci_iproc_writew,
>>       .write_b = sdhci_iproc_writeb,
>>       .set_clock = sdhci_set_clock,
>> -     .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>> +     .get_max_clock = sdhci_iproc_get_max_clock,
>>       .set_bus_width = sdhci_set_bus_width,
>>       .reset = sdhci_reset,
>>       .set_uhs_signaling = sdhci_set_uhs_signaling,
>> @@ -256,19 +267,29 @@ static const struct of_device_id sdhci_iproc_of_match[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
>>
>> +static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
>> +     { .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
>> +     { .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
>> +
>>  static int sdhci_iproc_probe(struct platform_device *pdev)
>>  {
>> -     const struct of_device_id *match;
>> -     const struct sdhci_iproc_data *iproc_data;
>> +     struct device *dev = &pdev->dev;
>> +     const struct sdhci_iproc_data *iproc_data = NULL;
>>       struct sdhci_host *host;
>>       struct sdhci_iproc_host *iproc_host;
>>       struct sdhci_pltfm_host *pltfm_host;
>>       int ret;
>>
>> -     match = of_match_device(sdhci_iproc_of_match, &pdev->dev);
>> -     if (!match)
>> -             return -EINVAL;
>> -     iproc_data = match->data;
>> +     if (dev->of_node)
>> +             iproc_data = of_device_get_match_data(dev);
>> +     else if (has_acpi_companion(dev))
>> +             iproc_data = acpi_device_get_match_data(dev);
>
> Can you use device_get_match_data() here
>
>> +
>> +     if (!iproc_data)
>> +             return -ENODEV;
>>
>>       host = sdhci_pltfm_init(pdev, iproc_data->pdata, sizeof(*iproc_host));
>>       if (IS_ERR(host))
>> @@ -280,19 +301,21 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>>       iproc_host->data = iproc_data;
>>
>>       mmc_of_parse(host->mmc);
>> -     sdhci_get_of_property(pdev);
>> +     sdhci_get_property(pdev);
>>
>>       host->mmc->caps |= iproc_host->data->mmc_caps;
>>
>> -     pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
>> -     if (IS_ERR(pltfm_host->clk)) {
>> -             ret = PTR_ERR(pltfm_host->clk);
>> -             goto err;
>> -     }
>> -     ret = clk_prepare_enable(pltfm_host->clk);
>> -     if (ret) {
>> -             dev_err(&pdev->dev, "failed to enable host clk\n");
>> -             goto err;
>> +     if (dev->of_node) {
>> +             pltfm_host->clk = devm_clk_get(dev, NULL);
>> +             if (IS_ERR(pltfm_host->clk)) {
>> +                     ret = PTR_ERR(pltfm_host->clk);
>> +                     goto err;
>> +             }
>> +             ret = clk_prepare_enable(pltfm_host->clk);
>> +             if (ret) {
>> +                     dev_err(dev, "failed to enable host clk\n");
>> +                     goto err;
>> +             }
>>       }
>>
>>       if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
>> @@ -307,7 +330,8 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>>       return 0;
>>
>>  err_clk:
>> -     clk_disable_unprepare(pltfm_host->clk);
>> +     if (dev->of_node)
>> +             clk_disable_unprepare(pltfm_host->clk);
>>  err:
>>       sdhci_pltfm_free(pdev);
>>       return ret;
>> @@ -317,6 +341,7 @@ static struct platform_driver sdhci_iproc_driver = {
>>       .driver = {
>>               .name = "sdhci-iproc",
>>               .of_match_table = sdhci_iproc_of_match,
>> +             .acpi_match_table = ACPI_PTR(sdhci_iproc_acpi_ids),
>>               .pm = &sdhci_pltfm_pmops,
>>       },
>>       .probe = sdhci_iproc_probe,
>>
>
