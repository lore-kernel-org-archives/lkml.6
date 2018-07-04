Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAEDC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F41623E3C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rg3hOul8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F41623E3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeGDOkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:40:39 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34383 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbeGDOkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:40:35 -0400
Received: by mail-ua0-f194.google.com with SMTP id r10-v6so3586320uao.1;
        Wed, 04 Jul 2018 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hhTS07VxhS/Z1/hr/xP3MxTtB9G2BS1YH2wDM4fUTEY=;
        b=rg3hOul8dlTQvzK8KIkpfR3esyZXmeZl4V2Row7znKsNfyAwx/7WjVhx6Mm03mWGYe
         5IW1svksBdcX6NX6n2dY6hemBtLgRY+NMtQjDSbOHhCwwOk2m3msSYADklGqn8fEJPN8
         lQ/kNegTmrO8vfNVz6PTmPrXzuhkUekV4KkVWDcRpu9FLRw6xVeWLBaZzu6BX/0i+PVa
         TV8yiy0ge6olic0yvVFj0CguupswVu1EDk8orTdW8l+GwuLRu093f8pHHn4wKLtkBtZJ
         j3+D1D8lLdXZ/GVwB9I8LibfyJI5aeSre3BOy8D8rqmoyhJstsZIlA3vXCf2QPbB093E
         2osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hhTS07VxhS/Z1/hr/xP3MxTtB9G2BS1YH2wDM4fUTEY=;
        b=D/wizsq7kUh27Dn+L7t2sHtFdmO6/Y+RhqhGm32QhF+uLMtBx0nvRGpM03tgXpater
         RwXvthullLIhDKZHsSRLIXFz0v0F3OLrNPHMADxYHOlCew5MwACHbpQwyPERg9vne6V7
         QJEGBS9CklyjpEA+846JiGYgmsrwDDjiYS239vp2u/Gb5jbBLxT4cXZoGl3NadGsxTAs
         ee57guEIGH5rQFbC8FPBc7SUiQg63GVsvS/c2rtx/yZ/AzYcEQgFAEhK4WXhCF3PjBE8
         17/Z41bgyy6TM9xDIZfdeKfzNku9xuwEje5KhUo1WY9GowYhSUztM6jMR2jmK2kdfmDh
         WJKw==
X-Gm-Message-State: APt69E32edboCdYUi0E8qu9wRN4CCw2k+gq0TAhs01Z9ylcxiHZBiHoa
        AbVIC8JY7kSJ+jzqzM8kVR1mKW0ZoI1va7xsCHM=
X-Google-Smtp-Source: AAOMgpfqBa6hCSfCSdAoZmMz+TSTwatb5xEz/V/i7eN7uCYoT3uMl2bxAiXgSdSSJgIBExbrxtsowi2V/0TDUSg2HfY=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr1364764ual.28.1530715235124;
 Wed, 04 Jul 2018 07:40:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 07:40:34 -0700 (PDT)
In-Reply-To: <950e8d0caf9f5f55df07eba8a11b2fa8cba9f9e1.1530708691.git.nikolaus.voss@loewensteinmedical.de>
References: <950e8d0caf9f5f55df07eba8a11b2fa8cba9f9e1.1530708691.git.nikolaus.voss@loewensteinmedical.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 17:40:34 +0300
Message-ID: <CAHp75Vd2u9o50h3VQQrJZfu6fYhxydG4gRD4U5u+LuxTUScSwQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: bus.c: Let acpi_device_get_match_data() return
 DT compatibility data
To:     Nikolaus Voss <nv@vosn.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss <nv@vosn.de> wrote:
> When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
> of_device_id table "compatible" strings in DSD, a pointer to the
> corresponding DT table entry should be returned instead of a null
> pointer. An acpi_device_id match still takes precedence.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

with a caveat that this is only an improvement for a _temporary_
PRP0001 users like I2C or SPI slave devices.
Please, don't consider this change as a valid point to (ab)use PRP0001
in a cases where devices are not "hotpluggable".

> v2: improve readability (as suggested by Andy Shevchenko)
>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>  drivers/acpi/bus.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 84b4a62018eb..58575fdace78 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -832,13 +832,22 @@ EXPORT_SYMBOL_GPL(acpi_match_device);
>
>  const void *acpi_device_get_match_data(const struct device *dev)
>  {
> -       const struct acpi_device_id *match;
> +       const struct acpi_device_id *acpi_id = NULL;
> +       const struct of_device_id *of_id = NULL;
> +       const struct device_driver *drv = dev->driver;
> +       bool match;
> +
> +       match = __acpi_match_device(acpi_companion_match(dev),
> +                                   drv->acpi_match_table,
> +                                   drv->of_match_table, &acpi_id, &of_id);
>
> -       match = acpi_match_device(dev->driver->acpi_match_table, dev);
>         if (!match)
>                 return NULL;
> +
> +       if (of_id)
> +               return (const void*)of_id->data;
>
> -       return (const void *)match->driver_data;
> +       return (const void*)acpi_id->driver_data;
>  }
>  EXPORT_SYMBOL_GPL(acpi_device_get_match_data);
>
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
