Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64303C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1388920673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ArSdUyf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1388920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbeHNPae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:30:34 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36510 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeHNPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:30:34 -0400
Received: by mail-oi0-f68.google.com with SMTP id n21-v6so33303332oig.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZSv+OcmanZWINuOdHF9tvsww4H12yPfqoOGoIWYLElU=;
        b=ArSdUyf/1CSKRubHZBm6Y8EnlQ41/3I13IYbdFvs6oXEof/zcsZn+DXfJlI79xVb0+
         pn28q2Rg8wLGEabzSQ7QWWticte3bIypekaBlu+CBaOtER7HdWdokYWkYpVzUMGvltAa
         i3Wpas9VFpqpKX3nJcM9hj/hgj8yLaWMk8XMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZSv+OcmanZWINuOdHF9tvsww4H12yPfqoOGoIWYLElU=;
        b=GdiuINqTJsnHBbIALfbggk34QuH/F3t1AZAOrenRqlnPwhxj81RbE77VSRX+a0r6rJ
         DOQEvZKmqja0LStW8rrsM2nSQpfdm8NUPV3sGxzIM8eErUh9pOJttiAGsv0/iZMYZoCt
         7P8jeA/XR0JKk/yRGh6MjWgL1WgJPpZEnOPWmYiWqgTixmHkk+U2Ai714A5gIB3Pf2Jl
         54uk05QbtZKfIzYD2ZSFeKEjcmzrpQaHCkPut735kXnhKUMAvpUyomuNZwjiDOpe2LMZ
         FrzyTDwT3yJFO0XF4cXUXvv5DX+JPzKpCtZRbdhJHvNZXqZoLhh7GzryOhPHAhDAoUTr
         20Mw==
X-Gm-Message-State: AOUpUlEHNmDeInmaCFV3Yoa2MYF8EhwliGvLT4Ag2y/w5yVlrvvGLYhn
        9jqvf4cJHe/+MEc4j6aIB3gk7s0vCE4MPKCTfM5+Fg==
X-Google-Smtp-Source: AA+uWPwZp/FG5s9tABKyyltZs5YzGoR6C107RlkJfYtedlBaCJtnLVq2KcpYYT20tZEXPJFSw8NpU5Ep4Zl2cOm7ck0=
X-Received: by 2002:aca:37c2:: with SMTP id e185-v6mr20992481oia.326.1534250612679;
 Tue, 14 Aug 2018 05:43:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 05:43:32
 -0700 (PDT)
In-Reply-To: <363DA0ED52042842948283D2FC38E4649C1A8354@IRSMSX106.ger.corp.intel.com>
References: <1533455572-22012-1-git-send-email-srinath.mannam@broadcom.com>
 <1533455572-22012-3-git-send-email-srinath.mannam@broadcom.com> <363DA0ED52042842948283D2FC38E4649C1A8354@IRSMSX106.ger.corp.intel.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 14 Aug 2018 18:13:32 +0530
Message-ID: <CABe79T7jQMbtn1SXZis7gNj2KqqPjdX6-VXdQPCWcRxmZa-hKA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mmc: host: iproc: Add ACPI support to IPROC SDHCI
To:     "Hunter, Adrian" <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "vikram.prakash@broadcom.com" <vikram.prakash@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf Hansson,

Please kindly provide your inputs.

Regards,
Srinath.

On Mon, Aug 6, 2018 at 12:13 PM, Hunter, Adrian <adrian.hunter@intel.com> wrote:
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
>> -----Original Message-----
>> From: Srinath Mannam [mailto:srinath.mannam@broadcom.com]
>> Sent: Sunday, August 5, 2018 10:53 AM
>> To: Ulf Hansson <ulf.hansson@linaro.org>; Hunter, Adrian
>> <adrian.hunter@intel.com>; Ray Jui <rjui@broadcom.com>; Scott Branden
>> <sbranden@broadcom.com>; vikram.prakash@broadcom.com
>> Cc: bcm-kernel-feedback-list@broadcom.com; linux-mmc@vger.kernel.org;
>> linux-kernel@vger.kernel.org; Srinath Mannam
>> <srinath.mannam@broadcom.com>
>> Subject: [PATCH v4 2/2] mmc: host: iproc: Add ACPI support to IPROC SDHCI
>>
>> Add ACPI support to all IPROC SDHCI varients
>>
>> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> Reviewed-by: Vladimir Olovyannikov
>> <vladimir.olovyannikov@broadcom.com>
>> ---
>>  drivers/mmc/host/Kconfig       |  1 +
>>  drivers/mmc/host/sdhci-iproc.c | 59 ++++++++++++++++++++++++++++----
>> ----------
>>  2 files changed, 41 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig index
>> 0581c19..bc6702e 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -334,6 +334,7 @@ config MMC_SDHCI_IPROC
>>       tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
>>       depends on ARCH_BCM2835 || ARCH_BCM_IPROC ||
>> COMPILE_TEST
>>       depends on MMC_SDHCI_PLTFM
>> +     depends on OF || ACPI
>>       default ARCH_BCM_IPROC
>>       select MMC_SDHCI_IO_ACCESSORS
>>       help
>> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
>> index d0e83db..0db9905 100644
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
>> @@ -162,9 +163,19 @@ static void sdhci_iproc_writeb(struct sdhci_host
>> *host, u8 val, int reg)
>>       sdhci_iproc_writel(host, newval, reg & ~3);  }
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
>>       .set_uhs_signaling = sdhci_set_uhs_signaling, @@ -178,7 +189,7 @@
>> static const struct sdhci_ops sdhci_iproc_32only_ops = {
>>       .write_w = sdhci_iproc_writew,
>>       .write_b = sdhci_iproc_writeb,
>>       .set_clock = sdhci_set_clock,
>> -     .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>> +     .get_max_clock = sdhci_iproc_get_max_clock,
>>       .set_bus_width = sdhci_set_bus_width,
>>       .reset = sdhci_reset,
>>       .set_uhs_signaling = sdhci_set_uhs_signaling, @@ -256,19 +267,25
>> @@ static const struct of_device_id sdhci_iproc_of_match[] = {  };
>> MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
>>
>> +static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
>> +     { .id = "BRCM5871", .driver_data =
>> (kernel_ulong_t)&iproc_cygnus_data },
>> +     { .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
>> +
>>  static int sdhci_iproc_probe(struct platform_device *pdev)  {
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
>> +     iproc_data = device_get_match_data(dev);
>> +     if (!iproc_data)
>> +             return -ENODEV;
>>
>>       host = sdhci_pltfm_init(pdev, iproc_data->pdata,
>> sizeof(*iproc_host));
>>       if (IS_ERR(host))
>> @@ -280,19 +297,21 @@ static int sdhci_iproc_probe(struct platform_device
>> *pdev)
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
>>       if (iproc_host->data->pdata->quirks &
>> SDHCI_QUIRK_MISSING_CAPS) { @@ -307,7 +326,8 @@ static int
>> sdhci_iproc_probe(struct platform_device *pdev)
>>       return 0;
>>
>>  err_clk:
>> -     clk_disable_unprepare(pltfm_host->clk);
>> +     if (dev->of_node)
>> +             clk_disable_unprepare(pltfm_host->clk);
>>  err:
>>       sdhci_pltfm_free(pdev);
>>       return ret;
>> @@ -317,6 +337,7 @@ static struct platform_driver sdhci_iproc_driver = {
>>       .driver = {
>>               .name = "sdhci-iproc",
>>               .of_match_table = sdhci_iproc_of_match,
>> +             .acpi_match_table = ACPI_PTR(sdhci_iproc_acpi_ids),
>>               .pm = &sdhci_pltfm_pmops,
>>       },
>>       .probe = sdhci_iproc_probe,
>> --
>> 2.7.4
>
