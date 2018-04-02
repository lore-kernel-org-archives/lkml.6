Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDBOfh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:35:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40163 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbeDBOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:35:33 -0400
X-Google-Smtp-Source: AIpwx492Bk/68HTQhd48bvYQX78AahTF8Qs9qhhAg+ncXR9dSawzvV4neHyF0IHvSfUv0HrhaWOheYrUa2Pk1xG6BF0=
MIME-Version: 1.0
In-Reply-To: <20180309140358.11432-1-hdegoede@redhat.com>
References: <20180309140358.11432-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 2 Apr 2018 17:35:31 +0300
Message-ID: <CAHp75VcAir59zB_pKjyt8=rRGchokvr_6=YhxBOwxTKWWvqtKg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: silead_dmi: Add entry for the Yours Y8W81 tablet
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 4:03 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add an entry with touchscreen info for the Yours Y8W81 8" tablet.
>
> This tablet has the same case and mostly the same internals as the Chuwi
> Vi8. Both seem to be from an ODM called inet-tek. Both are labelled:
> "INET-I86M-REVxx" on the PCB, with the Chuwi Vi8 being REV03 (and having
> an ALC5640 audio codec) and the Yours Y8W81 being REV21 (and having an
> ALC5651 audio codec). The wifi, accelerometer and touchscreen are
> identical on both.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/silead_dmi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
> index 1091539fa230..452aacabaa8e 100644
> --- a/drivers/platform/x86/silead_dmi.c
> +++ b/drivers/platform/x86/silead_dmi.c
> @@ -455,6 +455,14 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
>                         DMI_MATCH(DMI_BIOS_VERSION, "itWORKS.G.WI71C.JGBMRB"),
>                 },
>         },
> +       {
> +               /* Yours Y8W81, same case and touchscreen as Chuwi Vi8 */
> +               .driver_data = (void *)&chuwi_vi8_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "YOURS"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Y8W81"),
> +               },
> +       },
>         { },
>  };
>
> --
> 2.14.3
>



-- 
With Best Regards,
Andy Shevchenko
