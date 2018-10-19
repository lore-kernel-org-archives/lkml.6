Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A22EECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEBE20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 09:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzQmMMOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABEBE20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeJSRSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 13:18:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34033 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJSRSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 13:18:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id o17-v6so37558567qtr.1;
        Fri, 19 Oct 2018 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjkhtnZXlORa9jpt4NPlWTyaIGde8zW2/vaHprMs4h0=;
        b=dzQmMMOyxlrGhumx+pbnpUJEPOoy8e56DAvX7sFaBFElWTBq6+tkwsFUh2unqhFjV3
         wMuGQ65Hnbfk8JLqJzofcyipV+QZ/V+JKTq2MAMysEuotP8xDe0HjQyzLjkssWxRkmWg
         6nTq8hZMgr/PKC8vbepjlkwAvU8AsqpLRzhql+NrTLdAw9JtP9w98Vv3W+0t/HqQ4RL0
         j4v/ZnnBCPfFeSRI+oZpJkeRkIC13K6umSJo31LBlaE3/axIf4erH80CZ6wbAnJgKYVk
         zIjFFT+xlH7SEMC10ykYQvWqDI/u3J96jknoEf18eZfCOif9JCav3Gx/e+VuCkrph9My
         yjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjkhtnZXlORa9jpt4NPlWTyaIGde8zW2/vaHprMs4h0=;
        b=KHbRt8dCFZS3CHB5nO5xWNEJmn6/mB9dUzqgHU0L3lAlKSEiafpt/Hziz2xndVvNi0
         10vET2SltobMKgpbEuUVAZkjvQLYS5wPc08O+rXL9ryw0ChKjVzXI6AdKxf6YhuEEgYv
         k0mJpS1dPPhNdWYh1yUx0L0hgrjEt93YHNp3Vb1BUjFsDcC4l9U4WHMeUbG4OkSjgvY+
         Apk98AYIC9wjHmfeH5DrTrm54m7m7sCnW3IJELKgNjPsVY4TiMkaUm30qvqAs7UtJeha
         HXPYPSEj7h7d/McvOP/E1mHPWNRrdaqfphmiYm8X0QInpzaamOS7nu7A/4KzeDQW5ovQ
         iOgQ==
X-Gm-Message-State: ABuFfoiE2rLCYKkWfuQkaA3uXhixeUMBvU/rtitiZwwBUDAwE4SB6poM
        kTjwS/XRAh/EU5gbL62WJZBFpNmMDjkNjXOfVAQ=
X-Google-Smtp-Source: ACcGV627NZqatPnfgltvZ4TKIHtZXNdxqG8s+UNA+B9CZWBf2MQf2/plhYZOh7wQAVUASscEBOFheFzYcc5izK4PMr8=
X-Received: by 2002:a0c:819c:: with SMTP id 28mr34285479qvd.7.1539940415754;
 Fri, 19 Oct 2018 02:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
 <20181018215101.169847-1-rajatja@google.com>
In-Reply-To: <20181018215101.169847-1-rajatja@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 12:13:24 +0300
Message-ID: <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
To:     Rajat Jain <rajatja@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 12:53 AM Rajat Jain <rajatja@google.com> wrote:
>
> Problem:
>
> The card detect IRQ does not work with modern BIOS (that want
> to use DSD to provide the card detect GPIO to the driver).
>
> Details:
>

> (Discussion: https://lkml.org/lkml/2018/9/25/1113)

We have a Link tag for such references.

> The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
> request the gpio descriptor for the "card detect" (or carrier detect?) pin.

card detect is a right term.

> This pin is specified in the ACPI for the SDHC device:
>
>  * Either as a resource using _CRS. This is a method used by legacy BIOS.
>    (The driver needs to tell which resource index).
>
>  * Or as a named property ("cd-gpio") in DSD (which may internally point

cd-gpios (gpio suffix is a legacy).

>    to an entry in _CRS). This way, the driver can lookup using a string.
>    This is what modern BIOS prefer to use.
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
> The SDHCI driver is thus currently broken on a modern BIOS

> (even if
> BIOS provides both _CRS and DSD entries, either of which could be used for

_DSD

> a successful lookup).

This is incorrect. _DSD for GPIOs without any accompanying _CRS
doesn't make any sense.

> Ironically, none of these will be used for the
> lookup currently because:
>
> * Since the con_id is NULL, acpi_find_gpio() does not find a matching
>   entry in DSDT. (The DSDT entry has the property name = "cd-gpio")

cd-gpios

>
> * Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
>   returns false (because device properties have been populated from
>   DSD), thus the _CRS is never used for the lookup.

_DSD

>
> Fix:
>
> Try "cd" for lookup in the _DSD before falling back to using NULL so
> as to try looking up in the _CRS.
>
> I've tested this patch successfully with both Legacy BIOS (that
> provide only _CRS method) as well as modern BIOS (that provide both
> _CRS and DSD). Also the use of "cd" also appears to be farly consistent

_DSD
fairly

> across other users of this API (other MMC host controller drivers).

>         if (slot->cd_idx >= 0) {
> -               ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
> +               ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>                                            slot->cd_override_level, 0, NULL);

Yes.

> +               if (ret && ret != -EPROBE_DEFER)
> +                       ret = mmc_gpiod_request_cd(host->mmc, NULL,
> +                                                  slot->cd_idx,
> +                                                  slot->cd_override_level,
> +                                                  0, NULL);

And no. Instead of this part you need to provide an ACPI GPIO mapping table.

See examples, like
net/rfkill/rfkill-gpio.c

(look for acpi_rfkill_default_gpios)

>                 if (ret == -EPROBE_DEFER)
>                         goto remove;

-- 
With Best Regards,
Andy Shevchenko
