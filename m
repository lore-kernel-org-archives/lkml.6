Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7385DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF3E223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRXN5GyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF3E223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbeKLU62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:58:28 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37854 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbeKLU62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:58:28 -0500
Received: by mail-io1-f65.google.com with SMTP id c6-v6so4939741iok.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 03:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4jtXtR41UkigQ8glqAfYCztzz/U6KcjZmXCIwgGfBGo=;
        b=GRXN5GyZpUZwAEb0iXAmMLs6lZ71A+pZT0LvybRXVIFIJHFK7OOow14+EWCdLH4K4X
         Di/R6N9v3I/8wI3cSyv8KtTYkowLFjMJY4VdSETU0EgLHQEzZ88Uj9NZYCTZu9m8X+Or
         C7xVhCtAY+2EQMddmzAz9MF4CoM3VvMVQKu9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4jtXtR41UkigQ8glqAfYCztzz/U6KcjZmXCIwgGfBGo=;
        b=bbPUYoiNC1zm+a8HElUl+8j6gZAIHRs28bs4VePdEg4HSV2zVMhs+N59Msr78zosuk
         CAVqcgdvVFtsNmkl0TSlwK0MXV4R+64wo8l1kUzY3XnTB4rFv8L2AFsRLdo0Bu22+Gm7
         vOw4zDRYalQaGg8Jh/KqgvNc3cyiKQRKk9tz3IStcu/0qZZR6sVStE9m9DfwOT7H5Qzz
         scyc/NlH5ZQiJLpNkgsNJl/tgyi4AmvSJnHCcFXu7UOyW6rm4I46xMtyL1iggsZFVlfw
         xlNS0IMU/1YSl6kBQneMdTIa0Nw8k+mL16g8FN7SpfRamkNS1sIqP47b+qlhrBUgrg2w
         YTyg==
X-Gm-Message-State: AGRZ1gK1DvHvMt5aoFsG7osnEvKIAla4TbOtRTyUqld84qrzLF7VxEQ4
        4ApBcUxRQRa5oKWGzMEh3DcqKazsDb2TgpGHa4l4mw==
X-Google-Smtp-Source: AJdET5fqbZXfxbPNSD6WNXCSCwalA7csAW4eqLO1qU1DQ+/BlcCDrPv9znd0BGUthpat4qYXOEHJVv+RIxHS/5fk83c=
X-Received: by 2002:a6b:2c92:: with SMTP id s140mr321414ios.218.1542020742064;
 Mon, 12 Nov 2018 03:05:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:38d:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 03:05:01 -0800 (PST)
In-Reply-To: <20181029221701.51376-1-rajatja@google.com>
References: <CAA93t1oaZ5zkv+BsGnYZg6pqKv0DzXi3j8oZHUyTyffUWHtHug@mail.gmail.com>
 <20181029221701.51376-1-rajatja@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Nov 2018 12:05:01 +0100
Message-ID: <CAPDyKFpqzpxUzZe-ekfwg1Nqeg1RFB1bdbSNwrGPwtfNds4p0w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
To:     Rajat Jain <rajatja@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 October 2018 at 23:17, Rajat Jain <rajatja@google.com> wrote:
> Problem:
>
> The card detect IRQ does not work with modern BIOS (that want
> to use _DSD to provide the card detect GPIO to the driver).
>
> Details:
>
> The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
> request the gpio descriptor for the "card detect" pin.
> This pin is specified in the ACPI for the SDHC device:
>
>  * Either as a resource using _CRS. This is a method used by legacy BIOS.
>    (The driver needs to tell which resource index).
>
>  * Or as a named property ("cd-gpios"/"cd-gpio") in _DSD (which internally
>    points to an entry in _CRS). This way, the driver can lookup using a
>    string. This is what modern BIOS prefer to use.
>
> This API finally results in a call to the following code:
>
> struct gpio_desc *acpi_find_gpio(..., const char *con_id,...)
> {
> ...
>    /* Lookup gpio (using "<con_id>-gpio") in the _DSD */
> ...
>    if (!acpi_can_fallback_to_crs(adev, con_id))
>           return ERR_PTR(-ENOENT);
> ...
>    /* Falling back to _CRS is allowed, Lookup gpio in the _CRS */
> ...
> }
>
> Note that this means that if the ACPI has _DSD properties, the kernel
> will never use _CRS for the lookup (Because acpi_can_fallback_to_crs()
> will always be false for any device hat has _DSD entries).
>
> The SDHCI driver is thus currently broken on a modern BIOS, even if
> BIOS provides both _CRS (for index based lookup) and _DSD entries (for
> string based lookup). Ironically, none of these will be used for the
> lookup currently because:
>
> * Since the con_id is NULL, acpi_find_gpio() does not find a matching
>   entry in DSDT. (The _DSDT entry has the property name = "cd-gpios")
>
> * Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
>   returns false (because device properties have been populated from
>   _DSD), thus the _CRS is never used for the lookup.
>
> Fix:
>
> Try "cd" for lookup in the _DSD before falling back to using NULL so
> as to try looking up in the _CRS.
>
> I've tested this patch successfully with both Legacy BIOS (that
> provide only _CRS method) as well as modern BIOS (that provide both
> _CRS and _DSD). Also the use of "cd" appears to be fairly consistent
> across other users of this API (other MMC host controller drivers).
>
> Link: https://lkml.org/lkml/2018/9/25/1113
> Signed-off-by: Rajat Jain <rajatja@google.com>

Applied for fixes, thanks!

Should I add a stable tag to this as well?

Kind regards
Uffe

> ---
> v2: Fix the commit log to take care of Andy's comments.
>
>  drivers/mmc/host/sdhci-pci-core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 7bfd366d970d..e53333c695b3 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1762,8 +1762,13 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>                 device_init_wakeup(&pdev->dev, true);
>
>         if (slot->cd_idx >= 0) {
> -               ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
> +               ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>                                            slot->cd_override_level, 0, NULL);
> +               if (ret && ret != -EPROBE_DEFER)
> +                       ret = mmc_gpiod_request_cd(host->mmc, NULL,
> +                                                  slot->cd_idx,
> +                                                  slot->cd_override_level,
> +                                                  0, NULL);
>                 if (ret == -EPROBE_DEFER)
>                         goto remove;
>
> --
> 2.19.1.568.g152ad8e336-goog
>
