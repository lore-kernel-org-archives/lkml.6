Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4659EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E532075D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/RcOSd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfBEPxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:53:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36672 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBEPxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:53:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so1672907plo.3;
        Tue, 05 Feb 2019 07:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9v1eEu7EePsBEixk25cph6OzGD0+WqGFpykfRTqeSkI=;
        b=I/RcOSd2xb6HWrIgw2WsytuwtD4GNexJgc8A3+MQ3mM8zOKzSXAYlp5rdzG9D5AbiC
         cNhC3y7ykgR3EyCradMIkpTMrHE6w0knhNQRmEGdk31OKQTGhB9UNjyeTj5LU6VM3At3
         irWV55ErzBUN1oPfW49411Ja2db9e/6euwhHIpWPcGf+B3FOC48YwstOm24Q/xenbbxi
         uT24handVJXn0ePNaX83zZ/bdGZTuyNAvW2voJ4mPVspLHxpVuzTmAqO88w8R3aoC+5d
         lxJcZK82WCm/VFoOFE3Et+9igG+Y/n4awF6+S0biijeLz4mwHHoc7Gw3hZbK1CGgY80i
         RMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9v1eEu7EePsBEixk25cph6OzGD0+WqGFpykfRTqeSkI=;
        b=kZt5+mHmJHChqu6rgwoqgoLrj7+AjhTbontcBz3EXofGW4Onu5QDSsXtYnJW9HN3b3
         cw5YIiOioWjcVOLw92fmzcmUP7aHG3R4FTCNquFyzU9M2bAkVf9RVbGOmmTgtTp+TUui
         bhFHtf/a2ab3hwiFQjY9dOh4gz7pUlBMVBzfpv6Fk+hp+F3E092gzJszRKsdQGrslDTo
         aZC9uD+AnOGuqNJ9wOt3Ktr9Dhsot29beuZBmYOtrCbYIH84Fbs/tq/YYOK0sgMhfrm3
         fq1SzeTY7mva3SkPKyOnSV4S1KCScnZeXER/6SULxWWnlUiqzGuc9EBDNsVq9dOh5saS
         XrNA==
X-Gm-Message-State: AHQUAuaNr33m4NFA4TblvYOT0yr92FFYFjx2EPAdvgiGMWk7ECl2Yj1t
        ysfc0BlpNQyCSPsYaK4dV7G5EiMEqE0couPB1Hw=
X-Google-Smtp-Source: AHgI3IZ53JjjaQ4JaZgpSEZWiRDeJZb5pSJYTD1fyhB2LTdwF54eQGf+qjtzUtD6DB8VS4bZ0FX2fJfarp7cWnhBuEs=
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr5612841pla.144.1549382030187;
 Tue, 05 Feb 2019 07:53:50 -0800 (PST)
MIME-Version: 1.0
References: <20181220212150.1427-1-hdegoede@redhat.com>
In-Reply-To: <20181220212150.1427-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Feb 2019 17:53:39 +0200
Message-ID: <CAHp75Vf9=-9G=E=v_wp2zCXW9fZt+aXsMB9KA2EzDKZ5_eO57Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the PoV
 Wintab P1006w (v1.0) tablet
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

On Thu, Dec 20, 2018 at 11:22 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add touchscreen info for the Point of View Wintab P1006w (v1.0) tablet.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 29 ++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index ac20797af9b1..7936fd72c50a 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -432,6 +432,24 @@ static const struct ts_dmi_data pov_mobii_wintab_p800w_v21_data = {
>         .properties     = pov_mobii_wintab_p800w_v21_props,
>  };
>
> +static const struct property_entry pov_mobii_wintab_p1006w_v10_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 1),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y", 3),
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1984),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1520),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name",
> +                             "gsl3692-pov-mobii-wintab-p1006w-v10.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data pov_mobii_wintab_p1006w_v10_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = pov_mobii_wintab_p1006w_v10_props,
> +};
> +
>  static const struct property_entry teclast_x3_plus_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
> @@ -778,6 +796,17 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_BIOS_DATE, "08/22/2014"),
>                 },
>         },
> +       {
> +               /* Point of View mobii wintab p1006w (v1.0) */
> +               .driver_data = (void *)&pov_mobii_wintab_p1006w_v10_data,
> +               .matches = {
> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
> +                       /* Note 105b is Foxcon's USB/PCI vendor id */
> +                       DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "105B"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "0E57"),
> +               },
> +       },
>         {
>                 /* Teclast X3 Plus */
>                 .driver_data = (void *)&teclast_x3_plus_data,
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
