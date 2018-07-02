Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0B9C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FBA25460
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwWED+gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FBA25460
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752571AbeGBMYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:24:45 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40440 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbeGBMYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:24:40 -0400
Received: by mail-ua0-f195.google.com with SMTP id j17-v6so9924768uap.7;
        Mon, 02 Jul 2018 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wnMYc95g/oSGah+FWT1pvlzC7Em2u8FDOsZjHBIun38=;
        b=pwWED+gkOotVOa5HGCR+ZcpPZars0S/3Jg5DX3o1d+SvTMC+fQQKtaPlRf7dF1SDAC
         Ax2oH96OnMvQNNLyxAIOGkBntjlx78vSE9nhmTiqawP9RdlP+KRTVZA4bEgHKt31PkwI
         ATPT3fQFmorgfBZ6kkYrPbfSm0zP04geOUy2qYYOF2+L9yf+SaeXuNsXS+4fZyq8KCYE
         z7nJirrqHHuaxNQ/T/0IOE/orRYgMEMxfR/buroWu88OlLFTW/K72V9ty/qgVAbffLvC
         qwQDxRpbqkxygHj7lfKI7M37RwltEnupT7btYvCtIBlDGLIKliVWBYTrnTY8gYl6rhAY
         Vj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wnMYc95g/oSGah+FWT1pvlzC7Em2u8FDOsZjHBIun38=;
        b=XLrrqT76EkS4vCLtrPssEtzevR2YbBjk9VrkpECI1554kNdEAfMsuajF/YDM5E3TR6
         ZfA7hZApTrhr5c2qnWYudW40DxG2Q6OcaS4hjZTXSwEaW9JUXumqF5cNvbaxK3B8dMvx
         cdjpY8AbLlopArreBMLjzmh7BLc8OL5R+zE1CmXDLvjpNni5kmQERTagxBrgY/R/zDGR
         Tu00OzC7D1/k1+n+mH62RRz99xbpEUQfIWAAbGPkGh0h5OqvVeHXxPn0Vo8ftthqJ9vL
         Sa9HDTeaJah1cprZ4ZDYhOSg7i/HjkBt3bpj0YB5F2+1qeYh8qPz9x1Bj/wDrNkY+Ey9
         6U8g==
X-Gm-Message-State: APt69E0YJP7x7mfbeBz4VnaD2THB5qJo4RPd8YZLVcAzdb/j1cqx51mK
        /mReNRs5vM43pl9bqBRoqcqpseL3E0x21VUUJtqmDW05
X-Google-Smtp-Source: AAOMgpdq5REDzW8wj2UGab7chqZ/3WmvvlyFCsj8v4SsRnixwNhA9ao8MWTgqhpvZ38hiNWEbOrwR9+Jdd+Uf9LK3Bs=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr15699153uae.12.1530534278395;
 Mon, 02 Jul 2018 05:24:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 05:24:37 -0700 (PDT)
In-Reply-To: <20180701214714.2522-1-jambonmcyeah@gmail.com>
References: <20180701214714.2522-1-jambonmcyeah@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 2 Jul 2018 15:24:37 +0300
Message-ID: <CAHp75Ve6GAWFdAU9DNzvjiH6mM00M9Q7V4qZiEOf_Ng3Q=QErA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add touchscreen platform
 data for the Onda V820w tablet
To:     Jun Bo Bi <jambonmcyeah@gmail.com>
Cc:     linux-input <linux-input@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 12:47 AM, Jun Bo Bi <jambonmcyeah@gmail.com> wrote:
> Add touchscreen platform data for the Onda V820w tablet
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Jun Bo Bi <jambonmcyeah@gmail.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 6284946cb0d1..a8e083db0369 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -204,6 +204,22 @@ static const struct ts_dmi_data onda_obook_20_plus_data = {
>         .properties     = onda_obook_20_plus_props,
>  };
>
> +static const struct property_entry onda_v820w_32g_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1665),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
> +       PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name",
> +                             "gsl1680-onda-v820w-32g.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct silead_ts_dmi_data onda_v820w_32g_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = onda_v820w_32g_props,
> +};
> +
>  static const struct property_entry onda_v891w_v1_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-min-x", 46),
>         PROPERTY_ENTRY_U32("touchscreen-min-y",  8),
> @@ -470,6 +486,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "OBOOK 20 PLUS"),
>                 },
>         },
> +       {
> +               /* ONDA V820w DualOS */
> +               .driver_data = (void *)&onda_v820w_32g_data,
> +               .matches = {
> +                       DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "ONDA"),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "V820w DualOS")
> +               },
> +       },
>         {
>                 /* ONDA V891w revision P891WBEBV1B00 aka v1 */
>                 .driver_data = (void *)&onda_v891w_v1_data,
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
