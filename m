Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC9BECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA39221486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qko/V2et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA39221486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJSUCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:02:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34616 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJSUCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:02:45 -0400
Received: by mail-qt1-f195.google.com with SMTP id o17-v6so37962493qtr.1;
        Fri, 19 Oct 2018 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lzd5byMeV2j0yu5naG+w6QIxCuXPAvx7FmVStL3e3s=;
        b=qko/V2et6fv8Jh+Ba5g4mQvHjLVC1x/9B9S/GoC3cCBKjrdfZgV66rU9Br9QiiS9zA
         lIdhfLw7CPvyf4VpMgnFO2Fxm/gPggQLpBwgdq3s09ybrdZet9ljknPJSaAD+MrgedEn
         SXCDfB/26kRPpTeGeiZB7zpcEPe11Dj/a6jXgXMbEpKyBZV+vxrjrKCBVZk+yZ/itd5/
         +AE8H8OHsMNeEqW60YMrCXlodjRd9o3OoVWB2UKId2dwARewmnikfnLA4gfMxY2HRLsn
         OgmWSJvtonyI1TVym9HLx9ts6MAQWNMl16W7T2oXPQRx6Ye5ImAGwXQkap/RBRIeJkhp
         T0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lzd5byMeV2j0yu5naG+w6QIxCuXPAvx7FmVStL3e3s=;
        b=QwQh4XCs3xzklnvK9b6Ks6bN9DR7RLnmKFZrIGi1Lbjwzypf0jzeumwTCyVThRwVvP
         F1NeeKrJQ5dBi2spasfhYiUR6HHvBW2BiyHFIUwEs6F/COKAgTdIGcECOP58sYKSzdlQ
         4LPcNESktI0RAgwH+7d5RDa/3qNFYR7zc7M4OG4/RfKgL1RdhYYeAKCdJ/ObWLujmkUS
         sCAF/i7UbeHdU326jtJ0XAm9nCQCgGvCKTa9a5e8xJ4ZCQdmUdEmudDzu6peIUhUo9td
         s8bvVXKg5My6lUJC38i4c1wecI8U/gu24HrILSgfaBBoRkLwVmUWjsRG98a5sQuymidj
         ZXoQ==
X-Gm-Message-State: ABuFfoiEhS6xsctmGTGexlnvAYLC2SbEz0QPqEHc+wxrnNpr2A8TZaz6
        pdgEjS6kB6IMzzwsqreG4kvT2QMepuAHaRDlJzlHG9sF
X-Google-Smtp-Source: ACcGV60KSG12T66ipCqV5uQWfhWl3cRwFHCxJAvT4o5e57TbsKBqAuODP0ZJVC/uNKvLPQJfdofMgvglnRMHA/9FKU4=
X-Received: by 2002:a0c:aa06:: with SMTP id d6-v6mr33992893qvb.26.1539950218914;
 Fri, 19 Oct 2018 04:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181004123445.17497-1-hdegoede@redhat.com>
In-Reply-To: <20181004123445.17497-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 14:56:47 +0300
Message-ID: <CAHp75VepsK+3o5qH9i8x=uvCABt-QOuBq2WNiqGAQYVSFOqTyA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the Trekstor
 Primebook C11 convertible
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ahormann@gmx.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 3:35 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add touchscreen info for the Trekstor Primebook C11 convertible.
>

Applied, thanks!

> Cc: Alicia Hormann <ahormann@gmx.net>
> Suggested-by: Alicia Hormann <ahormann@gmx.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index f30337d68007..4e6fdc1fbfdf 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -421,6 +421,22 @@ static const struct ts_dmi_data teclast_x98plus2_data = {
>         .properties     = teclast_x98plus2_props,
>  };
>
> +static const struct property_entry trekstor_primebook_c11_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1970),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1530),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name",
> +                             "gsl1680-trekstor-primebook-c11.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data trekstor_primebook_c11_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = trekstor_primebook_c11_props,
> +};
> +
>  static const struct property_entry trekstor_primebook_c13_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 2624),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 1920),
> @@ -706,6 +722,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "X98 Plus II"),
>                 },
>         },
> +       {
> +               /* Trekstor Primebook C11 */
> +               .driver_data = (void *)&trekstor_primebook_c11_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Primebook C11"),
> +               },
> +       },
>         {
>                 /* Trekstor Primebook C13 */
>                 .driver_data = (void *)&trekstor_primebook_c13_data,
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
