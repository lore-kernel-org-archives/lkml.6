Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E60ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997A721486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhBVjpl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 997A721486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeJSUya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:54:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41973 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbeJSUy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:54:29 -0400
Received: by mail-qt1-f194.google.com with SMTP id l41-v6so38033057qtl.8;
        Fri, 19 Oct 2018 05:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JO0X4jAE6sjmhH0264v3gJOCzG29MQ+Fq7fZuMbTvds=;
        b=fhBVjpl3srHPVgRbtERkggE4kWdmARQSY0wd5jAt6X/lgknp73HVA6ReMagG26XuoC
         J0ZtRJjKtqvSY2WzjDSA2xdymWDqYA36PE12HTlXRc7an7JVFIgvihymlK2PkxiPb+b0
         VxevwAyBgRE+k9nN7q9egVdTgiISJ5yhWdu4zKUg7CQNOa8qLFKSZkUEx6dOcdW6pUag
         JW75V3xVUrj3farsKB+jv5is1c3Gujtg4XeK7Dp0KhJUroMNccUxD3sDVp8YrkdxZuhN
         5KanMczuW3HuhPlGeB5D4VlNvxULmv2eaMLEHY8ihb0kvJ9u0ne79kBXhMwcr4ANkqjB
         8PhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JO0X4jAE6sjmhH0264v3gJOCzG29MQ+Fq7fZuMbTvds=;
        b=WTTvb1aQJ1ZW7jtxmBzJXZcEr3REYOuttZk+AU+0H+hA6dXAdHDbu4dSO/CiiwjwpN
         0lFm6fbgEcvn8OriSvieztznJlLshfn8ayLTjqR+sEdRpv1zrsUpd//xMe6qvqrPdYK2
         W0dGSMK9mWFdhx5difvCvibb0yYxFeNFsLjYQv082TOxaftFVLpSdvyCcs9SJvC+oi06
         z8j9Z9+kKfCslmFRkDYPJo/qc1t7Xz73tNi1Fb/ER2pzbG83UTvmb3Iz4aG6J3rQzi/y
         qBf4DT0A6h354HLIDOSx4eXwzo54ilhO0C/G0gBO1f8D+m4T1cYpcBIRcxgaoyaB162W
         SssQ==
X-Gm-Message-State: AGRZ1gIuSn6Cv+d4vwXnqEzZpu6z11UPGJ6Gbu7jJZvKIP03J4KaDPqU
        jJX/3pJ+Ef2CGvpwMG7VP5qmohp912yXIKCXODg=
X-Google-Smtp-Source: ACcGV60wzCuniYFXXeEWmNoKkJRwPl543x0q23CCY3sgkcxOhcJUGD0d1BUJyGI1iY/OLQtIrW+0bdM66hblf7s/qPE=
X-Received: by 2002:aed:3e46:: with SMTP id m6-v6mr1833808qtf.99.1539953310384;
 Fri, 19 Oct 2018 05:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181008072505.GA8334@mcepok-pc>
In-Reply-To: <20181008072505.GA8334@mcepok-pc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Oct 2018 15:48:19 +0300
Message-ID: <CAHp75Ve=n6oFRr7zoDfHMUGOACmgk1XbqU_q0n+j0D3D+6B0sg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the Trekstor
 Primetab T13B tablet
To:     marian.cepok@gmail.com
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

On Mon, Oct 8, 2018 at 10:25 AM Marian Cepok <marian.cepok@gmail.com> wrote:
>
> Add touchscreen info for the Trekstor Primetab T13B tablet.
>

Pushed to my review and testing queue, thanks!

> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Marian Cepok <marian.cepok@gmail.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index cb204f973491..c07954f0efc6 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -381,6 +381,22 @@ static const struct ts_dmi_data trekstor_primebook_c13_data = {
>         .properties     = trekstor_primebook_c13_props,
>  };
>
> +static const struct property_entry trekstor_primetab_t13b_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 2500),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1900),
> +       PROPERTY_ENTRY_STRING("firmware-name",
> +                             "gsl1680-trekstor-primetab-t13b.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data trekstor_primetab_t13b_data = {
> +       .acpi_name  = "MSSL1680:00",
> +       .properties = trekstor_primetab_t13b_props,
> +};
> +
>  static const struct property_entry trekstor_surftab_twin_10_1_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1900),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 1280),
> @@ -648,6 +664,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "Primebook C13"),
>                 },
>         },
> +       {
> +               /* Trekstor Primetab T13B */
> +               .driver_data = (void *)&trekstor_primetab_t13b_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Primetab T13B"),
> +               },
> +       },
>         {
>                 /* TrekStor SurfTab twin 10.1 ST10432-8 */
>                 .driver_data = (void *)&trekstor_surftab_twin_10_1_data,
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
