Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967328AbeEYQk3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 12:40:29 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41612 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967260AbeEYQk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 12:40:27 -0400
X-Google-Smtp-Source: ADUXVKIVEFEAeqw2hUeXyYDh3/czEViN9d0V+388WaWTcgixHfsXrWdIrJlVVjqO3Urxq2o1rr6Mfng5/wqJT3utVHE=
MIME-Version: 1.0
In-Reply-To: <20180525153118.3015806-1-arnd@arndb.de>
References: <20180525153118.3015806-1-arnd@arndb.de>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 25 May 2018 18:40:26 +0200
Message-ID: <CAO-hwJL6BnUY6TONLSCpsPvt00FnawMa0xDZcLD_fTcdnp5Q6Q@mail.gmail.com>
Subject: Re: [PATCH] HID: steam: select CONFIG_POWER_SUPPLY
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Kosina <jikos@kernel.org>,
        Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 5:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Using the power supply APIs requires selecting the appropriate
> Kconfig symbol, otherwise we get this build failure:
>
> drivers/hid/hid-steam.o: In function `steam_unregister':
> hid-steam.c:(.text+0x1cc): undefined reference to `power_supply_unregister'
> drivers/hid/hid-steam.o: In function `steam_battery_get_property':
> hid-steam.c:(.text+0x2d2): undefined reference to `power_supply_get_drvdata'
> drivers/hid/hid-steam.o: In function `steam_raw_event':
> hid-steam.c:(.text+0xcba): undefined reference to `power_supply_changed'
> drivers/hid/hid-steam.o: In function `steam_register':
> hid-steam.c:(.text+0x13e3): undefined reference to `power_supply_register'
> hid-steam.c:(.text+0x13fe): undefined reference to `power_supply_powers'
>
> Fixes: f82719790751 ("HID: steam: add battery device.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

> ---
>  drivers/hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 8a865e3ccea6..a49a10437c40 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -848,6 +848,7 @@ config HID_SPEEDLINK
>  config HID_STEAM
>         tristate "Steam Controller support"
>         depends on HID
> +       select POWER_SUPPLY
>         ---help---
>         Say Y here if you have a Steam Controller if you want to use it
>         without running the Steam Client. It supports both the wired and
> --
> 2.9.0
>
