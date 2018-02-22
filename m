Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932578AbeBVNSz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:18:55 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45946 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932494AbeBVNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:18:54 -0500
X-Google-Smtp-Source: AH8x227kwEkYdpWTmg33YoUZwlnGZ+fDC6bCFk5yZT9ni2RcehTcnSwHZfGRjfIJ9dJ0ogt1piHZtBNddvdCPwKAg1w=
MIME-Version: 1.0
In-Reply-To: <20180222101838.3675-1-hdegoede@redhat.com>
References: <20180222101838.3675-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2018 15:18:52 +0200
Message-ID: <CAHp75VfhkeWsKzL20z_kYoxp5KQ0QPfVR9UrT+xbywS=YAZiMw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: silead_dmi: Add DMI match for the I.T.Works
 TW701 tablet
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 12:18 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> The I.T.Works TW701 7" tablet is a differently branded version of the
> same generic 7" Windows tablet as the Trekstor ST70416-6. Add a DMI
> match-table entry for it pointing to the Trekstor's touchscreen info.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/silead_dmi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/platform/x86/silead_dmi.c b/drivers/platform/x86/silead_dmi.c
> index 3a624090191d..1091539fa230 100644
> --- a/drivers/platform/x86/silead_dmi.c
> +++ b/drivers/platform/x86/silead_dmi.c
> @@ -446,6 +446,15 @@ static const struct dmi_system_id silead_ts_dmi_table[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "X3 Plus"),
>                 },
>         },
> +       {
> +               /* I.T.Works TW701 */
> +               .driver_data = (void *)&surftab_wintron70_st70416_6_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "i71c"),
> +                       DMI_MATCH(DMI_BIOS_VERSION, "itWORKS.G.WI71C.JGBMRB"),
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
