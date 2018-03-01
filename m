Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967547AbeCAKuk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 05:50:40 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34071 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965992AbeCAKuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 05:50:37 -0500
X-Google-Smtp-Source: AG47ELui5QtxnOThDs+5l1XQiXVGwm9AmhupIri/S+aMc68t0PE2uueogF7Q6WVoUTesElsOvm1dAlOzktOVmfUReWk=
MIME-Version: 1.0
In-Reply-To: <62ac821e-290a-6b7c-ef6e-9c5e4c49de36@infradead.org>
References: <62ac821e-290a-6b7c-ef6e-9c5e4c49de36@infradead.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 12:50:36 +0200
Message-ID: <CAHp75Vdh-KonisDC7MeTLHnZKqZo+kURS9og22GvJdp0SCJR2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] auxdisplay: fix broken menu
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 4:33 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Having the CHARLCD Kconfig symbol between "menuconfig AUXDISPLAY"
> and "if AUXDISPLAY" breaks the AUXDISPLAY submenus, so move the
> CHARLCD Kconfig symbol near the end of the file so that the menu
> display is continuous.
>
> Also include ARM_CHARLCD inside of the if AUXDISPLAY/endif block.
> Geert says that it should be there.
>
> Fixes: 39f8ea46724e ("auxdisplay: charlcd: Extract character LCD core from misc/panel")
>
> Cc: stable@vger.kernel.org # v4.12
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  drivers/auxdisplay/Kconfig |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> --- linux-next-20180228.orig/drivers/auxdisplay/Kconfig
> +++ linux-next-20180228/drivers/auxdisplay/Kconfig
> @@ -14,9 +14,6 @@ menuconfig AUXDISPLAY
>
>           If you say N, all options in this submenu will be skipped and disabled.
>
> -config CHARLCD
> -       tristate "Character LCD core support" if COMPILE_TEST
> -
>  if AUXDISPLAY
>
>  config HD44780
> @@ -157,8 +154,6 @@ config HT16K33
>           Say yes here to add support for Holtek HT16K33, RAM mapping 16*8
>           LED controller driver with keyscan.
>
> -endif # AUXDISPLAY
> -
>  config ARM_CHARLCD
>         bool "ARM Ltd. Character LCD Driver"
>         depends on PLAT_VERSATILE
> @@ -169,6 +164,8 @@ config ARM_CHARLCD
>           line and the Linux version on the second line, but that's
>           still useful.
>
> +endif # AUXDISPLAY
> +
>  config PANEL
>         tristate "Parallel port LCD/Keypad Panel support"
>         depends on PARPORT
> @@ -448,3 +445,6 @@ config PANEL_BOOT_MESSAGE
>           printf()-formatted message is valid with newline and escape codes.
>
>  endif # PANEL
> +
> +config CHARLCD
> +       tristate "Character LCD core support" if COMPILE_TEST
>
>



-- 
With Best Regards,
Andy Shevchenko
