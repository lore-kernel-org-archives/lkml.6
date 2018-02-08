Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeBHOUh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:20:37 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41587 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHOUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:20:35 -0500
X-Google-Smtp-Source: AH8x225jjsJECC6Ru/+TBanx+dZWYdYbBeXJYYFQGw4+JJc+LQNEYAnn8ti6HrV9FDgykE0nrUxe0Ycf9f/vI4XNjtk=
MIME-Version: 1.0
In-Reply-To: <20180207221226.11345-1-alexander.n.abrosimov@gmail.com>
References: <20180207221226.11345-1-alexander.n.abrosimov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 8 Feb 2018 16:20:34 +0200
Message-ID: <CAHp75Vcg-GAVrXvqgvr7z+Nr0n7=O7O-PRSfUFcUt=9SdeJ3dQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Removed duplicates in DMI whitelist
To: Alexander Abrosimov <alexander.n.abrosimov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 12:12 AM, Alexander Abrosimov
<alexander.n.abrosimov@gmail.com> wrote:
> Fixed a mistake in which several entries were duplicated in the DMI list
> from the below commit
> fe486138 platform/x86: dell-laptop: Add 2-in-1 devices to the DMI whitelist
>

Pushed to my review and testing queue, thanks!

(Would be material for v4.17 cycle)

> Signed-off-by: Alexander Abrosimov <alexander.n.abrosimov@gmail.com>
> ---
>  drivers/platform/x86/dell-laptop.c | 18 ------------------
>  1 file changed, 18 deletions(-)
>
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> index a7b141992cb3..a66a6a6e47b9 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -125,28 +125,10 @@ static const struct dmi_system_id dell_device_table[] __initconst = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>                         DMI_MATCH(DMI_CHASSIS_TYPE, "32"), /*Detachable*/
>                 },
>         },
>         {
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -                       DMI_MATCH(DMI_CHASSIS_TYPE, "30"), /*Tablet*/
> -               },
> -       },
> -       {
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -                       DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /*Convertible*/
> -               },
> -       },
> -       {
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -                       DMI_MATCH(DMI_CHASSIS_TYPE, "32"), /*Detachable*/
> -               },
> -       },
> -       {
>                 .ident = "Dell Computer Corporation",
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "Dell Computer Corporation"),
>                         DMI_MATCH(DMI_CHASSIS_TYPE, "8"),
>                 },
> --
> 2.13.6
>



-- 
With Best Regards,
Andy Shevchenko
