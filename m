Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955B5C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9092175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uG2asTB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfBESTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:19:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35080 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfBESTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:19:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so1852273pfi.2;
        Tue, 05 Feb 2019 10:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ob/913vVtKICvDhVRY3lWY4X8+wJmKbxnPup5h15D8=;
        b=uG2asTB5QP9zNC9bQ65paLhxsGzu2HwE2NT7H6QZ3vTAI8BB4R+OIdpPNI5Lv+lqK7
         WRJhpYd0YtCGQaPOmGW09sEifwuPFpXkUMUECcP6rrZJWwoKazZzOLPCLObi87JRmh/K
         Ca7rGWuusQ9gK16V6J0HaOIghiu8udJXLGm/m63n1phIfviur41J8iFN1cfL7ccUPlR8
         nKPdI0ingRf0LynvrYIoKv5DM1mCYAB+ZTZItwujOAjuuF4xOcG5AnhBlhQgj32cmRIt
         n3z0ZmgLLmdpt+4dKYTbC+GGWBsgAn6ThdZ4I7vtLjqDbsGJO6mZRFsVZDgznnZR1DEI
         Ah9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ob/913vVtKICvDhVRY3lWY4X8+wJmKbxnPup5h15D8=;
        b=gtoK1vCFkde4OXpqzlhX0aDVguCG5uaMWK7DVop4Lf6l+CQ3F3KjUKv4md13vXUNtf
         9czxb7ikvTzwUGc+radtj1pDj6sRDrprG6A9V5w8Q+++Pc0pyG6Or83EW4BNuG5j5vwB
         0fErBk6gl0OpH0jfUlAWvvPmTajpD1uwH60w/8hXVBaL0MWnzTq+C7As71dFRrqgqGOd
         7dZTHMr8KvHWT7AibAWHAt6tlGdGTHGSCjKKHo4dIRuRCtdz0cP9TNP0ZswfK4XwcKjc
         BgIcNpQy0hHRbTpi1vrSJjaAvd81rwmuTU5+8Yzc0tXCnHrNbVkfsUoXyubW4+X5Twv/
         PC3g==
X-Gm-Message-State: AHQUAuZ36KhrqxdJX74l0ZoXDaV08EF9X+sEnYd3mUR8OKMbjtZTur9q
        eL2B+uD0h2uxGahZ6FAfJ8RAtJmSLh3bKT5PcWteWMXO
X-Google-Smtp-Source: AHgI3IbjFeseSsbd2nLOwVYeUoo9TMXQYKyvpgbjJujLBhD8IQOtHyNxD3oREnNRc+3l5vVc93fq4v50Ed2cK8bmqzU=
X-Received: by 2002:a62:5793:: with SMTP id i19mr6310985pfj.49.1549390749369;
 Tue, 05 Feb 2019 10:19:09 -0800 (PST)
MIME-Version: 1.0
References: <20190203183423.7661-1-k.renzig@gmail.com>
In-Reply-To: <20190203183423.7661-1-k.renzig@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Feb 2019 20:18:58 +0200
Message-ID: <CAHp75Ve5BgpwqRrhfQixZRjMzGR5k6W02q_wFuira3Z0NW6-kw@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: silead_dmi: Add touchscreen platform
 data for the Chuwi Hi8 Air tablet
To:     Kai Renzig <k.renzig@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-input <linux-input@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 3, 2019 at 8:34 PM Kai Renzig <k.renzig@gmail.com> wrote:
>
> Add touchscreen platform data for the Chuwi Hi8 Air tablet.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Kai Renzig <k.renzig@gmail.com>
> ---
> Changes in v2:
>  - Fix the firmware filename to match the actual touchscreen controller.
>
>  drivers/platform/x86/touchscreen_dmi.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 8c5d47c0aea6..1f66405928a9 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -41,6 +41,20 @@ static const struct ts_dmi_data chuwi_hi8_data = {
>         .properties     = chuwi_hi8_props,
>  };
>
> +static const struct property_entry chuwi_hi8_air_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
> +       PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl3676-chuwi-hi8-air.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       { }
> +};
> +
> +static const struct ts_dmi_data chuwi_hi8_air_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = chuwi_hi8_air_props,
> +};
> +
>  static const struct property_entry chuwi_hi8_pro_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-min-x", 6),
>         PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
> @@ -497,6 +511,15 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_BIOS_VERSION, "H1D_S806_206"),
>                 },
>         },
> +       {
> +               /* Chuwi Hi8 Air (CWI543) */
> +               .driver_data = (void *)&chuwi_hi8_air_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "Default string"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Hi8 Air"),
> +               },
> +       },
>         {
>                 /* Chuwi Hi8 Pro (CWI513) */
>                 .driver_data = (void *)&chuwi_hi8_pro_data,
> --
> 2.19.1
>


-- 
With Best Regards,
Andy Shevchenko
