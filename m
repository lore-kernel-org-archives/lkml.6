Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C176C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43524208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkF/Pgs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43524208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeGaNM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:12:27 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:39793 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbeGaNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:12:26 -0400
Received: by mail-vk0-f66.google.com with SMTP id e139-v6so7299220vkf.6;
        Tue, 31 Jul 2018 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TEVdj7bf5r50Cz8BK5t2k5i2P0w+IATNBY+8RJ96nlw=;
        b=IkF/Pgs2X5df3JIP3Mb8DANezh6BDrnHdx3wd8COExhlE7wTppNIrXyyVo7AyBiXfb
         yFchQlTc5W8yoneEMOf+MhG6MDjUlnn6Xqfz7sH7iZ0ih3iyhrhSF/v6VbnTVbNPYwkP
         LVqWQa6RYYjChLwO/tEXEwmmK7fwSn4DOIiKxD5+HM6fa8zO2ASZMxdlmJDB1F/BRVM+
         afr3i8q3KdVBir3ueEKTHAIpeR9DXqnQRYmW8TmQYnbq4ZW8LipmcmpNdyPBKoHQZ41z
         tstxQI+VhMR5G6BNTqtyTw+jP/zusynDsbWcrp3S9YBUFmm9RWWpQ+cpdidJJt5gDXx5
         XHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TEVdj7bf5r50Cz8BK5t2k5i2P0w+IATNBY+8RJ96nlw=;
        b=hN6Q7UXxR75F2/517x2cLxuCXcZlDJREjh8V/nZWSIYnS0eDRTJp3yZywboZbcFFhW
         MhkKN3Ju3gFXTQAAt5yKl3FMfzMrEKeuyTd2ssoDuyiHAP4erZhr0U4pFZUtKLTapvfR
         N+WtadFEcvxApb5pYwDCrGn0vWjUaI9tQPKCq1CluXygGbJKo61mQhiFzxiYQVH5ymi7
         E1IIHZFSzGmZ5HYzY5WtvjBoQgNCSFScg8mwxDXNh6T4YuK1mvQpuocOSNurjzT/TX0U
         syfP8+qCcduu+z+jdgPzJOjyuwcIt/bpWPKFXIYFVwZwo00oyNffzXNfsL75qfWOTN8c
         5iqw==
X-Gm-Message-State: AOUpUlGz9XPEuMLQ8kg56y259y5RghX+tVsbME23HxqpiltpYNvfaTiR
        6kuW2sSKpQKFq1KDI3nneiQ9MN0syNmbDpwDaJY=
X-Google-Smtp-Source: AAOMgpeN/kgIrEOCEzF5USxDKyr2dtq3josjM+ioCA7yZGQtV/zk+bk3Sd4aLTviT/1aqaag4/CkRZGjm1/FQlQyooU=
X-Received: by 2002:a1f:920b:: with SMTP id u11-v6mr13035298vkd.58.1533036752571;
 Tue, 31 Jul 2018 04:32:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 04:32:32
 -0700 (PDT)
In-Reply-To: <20180731093256.30533-1-youling257@gmail.com>
References: <20180731093256.30533-1-youling257@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Jul 2018 14:32:32 +0300
Message-ID: <CAHp75Vfp+EZjt_bg3iieKG0NPBvqzURXKh97D4=ULrKnbE4mvQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for the Cube
 KNote i1101 tablet
To:     youling257 <youling257@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:32 PM, youling257 <youling257@gmail.com> wrote:
> Add touchscreen info for the Cube KNote i1101 tablet.
>

Thanks for the patch.
Unfortunately I can't take it w/o SoB line. If Hans volunteering to
give a such again, I guess we're fine.

> Reported-and-tested-by: lkongl <lkongl@163.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 85e425420da2..cb204f973491 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -117,6 +117,22 @@ static const struct ts_dmi_data cube_iwork8_air_data = {
>         .properties     = cube_iwork8_air_props,
>  };
>
> +static const struct property_entry cube_knote_i1101_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-min-x", 20),
> +       PROPERTY_ENTRY_U32("touchscreen-min-y",  22),
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1961),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1513),
> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-cube-knote-i1101.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data cube_knote_i1101_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = cube_knote_i1101_props,
> +};
> +
>  static const struct property_entry dexp_ursus_7w_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 890),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 630),
> @@ -458,6 +474,16 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
>                 },
>         },
> +       {
> +               /* Cube KNote i1101 */
> +               .driver_data = (void *)&cube_knote_i1101_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "L1W6_I1101"),
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ALLDOCUBE"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "i1101"),
> +               },
> +       },
>         {
>                 /* DEXP Ursus 7W */
>                 .driver_data = (void *)&dexp_ursus_7w_data,
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
