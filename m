Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163031AbeBNTaM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:30:12 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33628 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162976AbeBNT3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:29:30 -0500
X-Google-Smtp-Source: AH8x225/qbDdx3fhdpEE18AC20wK5NKMtRcTvZ53JkGuXs9pae/+D1qad5vU+AIG31XDKW7wZrWEDwp07lGA3kLPbJg=
MIME-Version: 1.0
In-Reply-To: <1518340729-12463-1-git-send-email-aaron.ma@canonical.com>
References: <1518340729-12463-1-git-send-email-aaron.ma@canonical.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2018 21:29:29 +0200
Message-ID: <CAHp75VenHdg3-1ZXsJEMLO5zcspwqJeGObq1E75muLgvF6jyHw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Increase timeout to wait
 for EC answer
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Ike Panhc <ike.pan@canonical.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 11:18 AM, Aaron Ma <aaron.ma@canonical.com> wrote:
> Lenovo E41-20 needs more time than 100ms to read VPC,
> the funtion keys always failed responding.
> Increase timeout to get the value from VPC, then
> the funtion keys like mic mute key work well.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/platform/x86/ideapad-laptop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 5b6f18b18801..535199c9e6bc 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -113,7 +113,7 @@ MODULE_PARM_DESC(no_bt_rfkill, "No rfkill for bluetooth.");
>  /*
>   * ACPI Helpers
>   */
> -#define IDEAPAD_EC_TIMEOUT (100) /* in ms */
> +#define IDEAPAD_EC_TIMEOUT (200) /* in ms */
>
>  static int read_method_int(acpi_handle handle, const char *method, int *val)
>  {
> --
> 2.14.3
>



-- 
With Best Regards,
Andy Shevchenko
