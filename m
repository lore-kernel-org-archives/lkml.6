Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC8EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F5420BEC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERKmyB5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F5420BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933863AbeGDKgJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:36:09 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:32882 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753295AbeGDKgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:36:05 -0400
Received: by mail-ua0-f194.google.com with SMTP id g18-v6so3160663uak.0;
        Wed, 04 Jul 2018 03:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Rw30GbvtcIm1GUQdzvA/7DYGLWz5chvWddEClUCty98=;
        b=ERKmyB5dqtlMUuGZ7dfJb9UrF7TRJnNZJGHD4GwRo8n2h1+8doKqHVZ3b375tMxr6G
         uuidtoaf5SKcV+uXsqT00cfDYssroh6Nkbww75KE8lNLJR4mnPmA2HJunn/g5bz8685w
         HVfYPOUxovJZsARRUYeoDM1rGGal+RwcOXxdWp9f+HxgGLr3LC2b9j210pkdJZngbJSr
         Kh1KOKIlEuCtds5Wv5qVVrmxDUL0P380pb97eg3xXKu/X7Vz/eJ/26t/F/C2xGrk1JXm
         WZa1n07A/LfvutNOvKpDnxdkHxvCbGdZOueaSZ+LKSY+QDql9BE39qvt5ClYzgbA3CVc
         jwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Rw30GbvtcIm1GUQdzvA/7DYGLWz5chvWddEClUCty98=;
        b=BJHtN6WdIPMiO3xLVFWMpg09GIkQLWpGg0GEP8hGdZVYVKiMKst1rq1pLUSo5iNObJ
         DT0eV/Ng9K9gAuaEEKj3eRvWYMM7PM5ZBVKywKoxlU5dSlJGjYWSSYvXwHpWStLpEO8I
         s+59tGB2J7vtDl57fcw8/28rEFchlToKlbnAfynFkvl1er0jU78tRrLTWpIxjI5rH6r6
         xd0I2cgWmWXCB3FpaPWecNUFIMk2Q3QHkqcyTHOi3F0++/fPLmxRpwdkPI8XPEKYL8hH
         abWR8b/OacZPbYCyVCY4ex6VBq/VkGacJSN6vRv2Tb8nCLiw3jMxupbmJidkrcM6k3q1
         7wbQ==
X-Gm-Message-State: APt69E0Dhb4BpESF38BbCIaMwFNzqh7+GvTTEbzWXEIywYdL5AyirS9K
        fXRELQh9GD4DdbsyPppUn/1Hz6HBnhDCbywbLJM=
X-Google-Smtp-Source: AAOMgpeZPR5znlIWXY9NmJHMHlhjNoZCt9WBpZpoFbXklDZJd7xXW6/9PGG5Ff7CD2NA24JBhU+rkuO8CV8uFJmNBbA=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr813050uae.12.1530700564714;
 Wed, 04 Jul 2018 03:36:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 03:36:04 -0700 (PDT)
In-Reply-To: <20180704102240.2C00942D43@mail.steuer-voss.de>
References: <20180704102240.2C00942D43@mail.steuer-voss.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 13:36:04 +0300
Message-ID: <CAHp75VcQQSbA3rdHqg=NiUJS8c4QO70FywcWkeoxpcXAFRZjOA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus.c: Let acpi_device_get_match_data() return DT
 compatibility data
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>, nv@vosn.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 9:09 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> When using ACPI with ACPI_DT_NAMESPACE_HID/ PRP0001 HID and referring to
> of_device_id table "compatible" strings in DSD, a pointer to the
> corresponding DT table entry should be returned instead of a null
> pointer. An acpi_device_id match still takes precedence.

AFAIU it's just bounce for new comers to the discussion.
The patch is in its original form and didn't incorporate any review
comments so far.

> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>  drivers/acpi/bus.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 84b4a62018eb..c2deffea842e 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -832,13 +832,18 @@ EXPORT_SYMBOL_GPL(acpi_match_device);
>
>  const void *acpi_device_get_match_data(const struct device *dev)
>  {
> -       const struct acpi_device_id *match;
> +       const struct acpi_device_id *acpi_id = NULL;
> +       const struct of_device_id *of_id = NULL;
> +       const struct device_driver *drv = dev->driver;
>
> -       match = acpi_match_device(dev->driver->acpi_match_table, dev);
> -       if (!match)
> +       __acpi_match_device(acpi_companion_match(dev), drv->acpi_match_table,
> +                           drv->of_match_table, &acpi_id, &of_id);
> +       if (acpi_id)
> +               return (const void*)acpi_id->driver_data;
> +       else if (of_id)
> +               return (const void*)of_id->data;
> +       else
>                 return NULL;
> -
> -       return (const void *)match->driver_data;
>  }
>  EXPORT_SYMBOL_GPL(acpi_device_get_match_data);
>
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
