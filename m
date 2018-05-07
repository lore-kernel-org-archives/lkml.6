Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeEGOI4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:08:56 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41117 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeEGOIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:08:39 -0400
X-Google-Smtp-Source: AB8JxZoT/cNwERTHMqmToubZKA+M2xppJrXsnk9TafSReo/32S4xe/qmSik58fkjkod0NAkHNFEdxPgz+8kqGyfVrTo=
MIME-Version: 1.0
In-Reply-To: <20180427215021.2120-1-antonio.intilisano@gmail.com>
References: <20180427215021.2120-1-antonio.intilisano@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 7 May 2018 17:08:38 +0300
Message-ID: <CAHp75VdQegkRceJ10_QLoHvj++FUOYTnmOD2WAYEDRUG2iL4bQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: add another KEY_POWER keycode
To: Antonio Rosario Intilisano <antonio.intilisano@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gianfranco Costamagna <locutusofborg@debian.org>,
        Chris Chiu <chiu@endlessm.com>, Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 12:50 AM, Antonio Rosario Intilisano
<antonio.intilisano@gmail.com> wrote:
>     Now that we have informed the firmware that the Power Button driver is
>     active, laptops such as the Acer Swift 3 will generate
>     a WMI key event with code 0x87 when the power button key is
>     pressed.
>
>     Add this keycode to the table so that it is converted to an appropriate
>     input event.

I pushed it to my review and testing queue, thanks!

Though, see below.

>
> Signed-off-by: Antonio Rosario Intilisano <antonio.intilisano@gmail.com>
> Acked-by: Gianfranco Costamagna <locutusofborg@debian.org>
> Tested-by: Antonio Rosario Intilisano <antonio.intilisano@gmail.com>
> Cc: Chris Chiu <chiu@endlessm.com>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ---
>  drivers/platform/x86/acer-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 1be71f956d5c..8952173dd380 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -129,6 +129,7 @@ static const struct key_entry acer_wmi_keymap[] __initconst = {     {KE_IGNORE, 0x83, {KEY_TOUCHPAD_TOGGLE} },

This is malformed patch. It states 6 lines for context, though only 4
provided. Please, fix your tools.

>         {KE_KEY, 0x85, {KEY_TOUCHPAD_TOGGLE} },
>         {KE_KEY, 0x86, {KEY_WLAN} },
> +       {KE_KEY, 0x87, {KEY_POWER} },
>         {KE_END, 0}
>  };
>
> --
> 2.15.1
>



-- 
With Best Regards,
Andy Shevchenko
