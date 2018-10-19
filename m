Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FFECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823B721486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoPun1SX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823B721486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJSU4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:56:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39748 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeJSU4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:56:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id e21-v6so1875549qtp.6;
        Fri, 19 Oct 2018 05:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRLfH+zFWyRmA+m82P30majiknJm0Q6QJEbapEMu4yU=;
        b=KoPun1SXU0gtcybYINsTkKg3/0uDFPdS5+Ry5XJuzG1BGX1ASL0jTqA1009vf71R17
         A73wszEClJG/aI/B7boh6w+LfZ3Yr17h4mTBHVcgWQ0YbpA06JHAaqtU4u+fcqjlhWxN
         hmfgxGkMLXpJYs/9CaC1ofFBPUbCjZXhioj5UfA+aI0FJOTNiDQ9fFdrGMi9y6FEH8pV
         OPkob7OaqhHMySOVTcQ7xXCrjwzXN0vCKEnhvt1SwbXaErC91s+ZefejiMI3Sf/oD75j
         oUNTMAdkXpLWzX7mbD8y55XdxzzBkLPjilGq+ixX+n1OdqoMTg8/OQjgkV3/7Ikv3Hsu
         uMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRLfH+zFWyRmA+m82P30majiknJm0Q6QJEbapEMu4yU=;
        b=cIPraLzlP2QJV/LddIGkjCBWSmzjqbdnO7hMSqFMEiOxtqIAFXry+Sr4XXX9aWFxxM
         smG+BDUgo93L45M5wVl82P8erMY6yUAIcPnMsyj6UaOhU0EWRuAHPBAhkds0E0jpsnZT
         um65sGrxcawraVminybmeR9JOZyBQkVnH637dDWBH4jGEf6iT8uI26WjqoVFfxECveW5
         E2oFGPR76lfWhU4MEUTECHvJXilzlUDLI9q973iksCe6ZDDgwuA3vAA0dDgDaApvy1WL
         CFaG65d3kFlBrd5BUyvKzLwR0Sb1o/k+q/NKqUtkogFY8cAqYXU34E8Ki7wVjA3fim6x
         1h0g==
X-Gm-Message-State: ABuFfohmmR+Hn539FGNZhCDaeH4+SkwSlfoN6/NrTOA+OJIhnawH+oqC
        +KDP4+2dcxiHWzc2PSRC6rUfKKbX124Mgq0ETCRz14m96cA=
X-Google-Smtp-Source: ACcGV60mc3jFXVK8pqnMrcjGXbtp5W3AOdWj1Mv7k+MwnbPuh1WgUpsO+UAygY1BzLn4hXOMrvkGMk14Yu5KvGz84yY=
X-Received: by 2002:ac8:6784:: with SMTP id b4-v6mr33352712qtp.373.1539953442882;
 Fri, 19 Oct 2018 05:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181010131640.27440-1-hdegoede@redhat.com>
In-Reply-To: <20181010131640.27440-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 15:50:31 +0300
Message-ID: <CAHp75Vd74JJxyiqE4KV4h-uxaGDaVvEZKQykznhdKe5zp1xz4w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the Onda V80
 Plus v3 tablet
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 4:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add touchscreen platform data for the Onda V80 Plus v3 tablet.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 4e6fdc1fbfdf..00b5e54f09cc 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -282,6 +282,24 @@ static const struct ts_dmi_data onda_obook_20_plus_data = {
>         .properties     = onda_obook_20_plus_props,
>  };
>
> +static const struct property_entry onda_v80_plus_v3_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 22),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 15),
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1698),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
> +       PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name",
> +                             "gsl3676-onda-v80-plus-v3.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data onda_v80_plus_v3_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = onda_v80_plus_v3_props,
> +};
> +
>  static const struct property_entry onda_v820w_32g_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1665),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
> @@ -637,6 +655,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "OBOOK 20 PLUS"),
>                 },
>         },
> +       {
> +               /* ONDA V80 plus v3 (P80PSBG9V3A01501) */
> +               .driver_data = (void *)&onda_v80_plus_v3_data,
> +               .matches = {
> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONDA"),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "V80 PLUS")
> +               },
> +       },
>         {
>                 /* ONDA V820w DualOS */
>                 .driver_data = (void *)&onda_v820w_32g_data,
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
