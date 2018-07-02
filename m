Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17E2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B8D25460
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO+I/h5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B8D25460
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeGBMYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:24:23 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:37999 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbeGBMYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:24:21 -0400
Received: by mail-vk0-f65.google.com with SMTP id b77-v6so9037250vkb.5;
        Mon, 02 Jul 2018 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PdJCjz9zUVuHa5ACpKV59OlYM/hEZuTBb5WJPb0L82E=;
        b=MO+I/h5JHECleSNxXYpbdbumQg08+zvPhtW9RZ+PAF2qS/DeK9iRWFKwkQ8sYchLSq
         56ZmZC/9b/z22G+AuvuvtJdhwcQPMCHUR8m4QlfsYIDKjy5tTcY67zZgxssnEY1JVrQH
         AqTidMMMQtdGqAimBCZdEU8zFA0NrybPfuMEYEU4fd7Du2NGy/DoMYI0aQoFDJh3BOtr
         5hnbu/AJMMXU7DJhsJ9/1yYoyT/pCgGcE1YP2FKY96e/1DKlv4xKH63KM/uJkwxg/8gU
         y1MzE40/HkYjD3g35tmENBIeCurHdwNuXKSafvlLbP0yR9mRyXgD/ti7k9LmuadUyI8H
         pkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PdJCjz9zUVuHa5ACpKV59OlYM/hEZuTBb5WJPb0L82E=;
        b=nt0vXcPWROCBTHhbTOyBynpDF614LHohHjKiSgMSNVG1L3wlTep7rG/pCfhJedmSPl
         6T3VQbgglR37uzWaacLyBCxB3UlRJi8VwvoEai+p8+iN0t5v5cNYngHYsbsaqU9DH3Aw
         kYEtvdmylwuIrffbGk/KK8w1aWMl2CubSoqCxW7I6Wqn/+L+7/9kIw+zI1da/LAvfzrC
         iZG2Q8Fz7KBRf8dKq7UKyz/8ahHO9Dhu7mqiwylLWfcfriwGWtCwLoEP0nx1WbCJrZoW
         96/4y3d2LP9puE40YwLbv9YRm3IqTMs30mtDm8rvrJP6OZggUxpIlPDk4f6VizlcuGo/
         dJKw==
X-Gm-Message-State: APt69E3q/rWu6nYC3Mt/Fy5XZVVuYMc+m2I3h93CqZKhtCuwHeMqTzmV
        4mR//7ipeKDLVLk1AED2t5Ug+Aa4W65ZTp8fpsI=
X-Google-Smtp-Source: AAOMgpdtQPtyl6jo2ywtxVUyc25chCpDbZDEPXx3iecTx4ghckKLg1uyIbc9sbYwd8mGPQ7xwxnHV2rEEIGfMr7bj4M=
X-Received: by 2002:a1f:6742:: with SMTP id m2-v6mr318274vki.129.1530534260475;
 Mon, 02 Jul 2018 05:24:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 05:24:19 -0700 (PDT)
In-Reply-To: <20180701093256.7043-2-hdegoede@redhat.com>
References: <20180701093256.7043-1-hdegoede@redhat.com> <20180701093256.7043-2-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Jul 2018 15:24:19 +0300
Message-ID: <CAHp75VeTumJKZA5P6U9pU8m11WSUc5PMxDzmntxuzyRapc6zTQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the "Connect
 Tablet 9" tablet
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

On Sun, Jul 1, 2018 at 12:32 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add touchscreen info for the "Connect Tablet 9" tablet. This appears to be
> a variant of the same hardware as the ITworks TW891 tablet, but it needs
> different firmware for the touchscreen to fonction properly.
>

Pushed to my review and testing queue, thanks!

P.S. Renaming now in our for-next branch.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 8578f9e28ee0..8086e01e069e 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -119,6 +119,23 @@ static const struct ts_dmi_data chuwi_vi10_data = {
>         .properties     = chuwi_vi10_props,
>  };
>
> +static const struct property_entry connect_tablet9_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 9),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 8),
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1664),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 878),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +       PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-connect-tablet9.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       { }
> +};
> +
> +static const struct ts_dmi_data connect_tablet9_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = connect_tablet9_props,
> +};
> +
>  static const struct property_entry cube_iwork8_air_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1660),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 900),
> @@ -470,6 +487,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "S165"),
>                 },
>         },
> +       {
> +               /* Connect Tablet 9 */
> +               .driver_data = (void *)&connect_tablet9_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Connect"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Tablet 9"),
> +               },
> +       },
>         {
>                 /* CUBE iwork8 Air */
>                 .driver_data = (void *)&cube_iwork8_air_data,
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
