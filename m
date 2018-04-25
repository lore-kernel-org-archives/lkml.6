Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754504AbeDYOR0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:17:26 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36412 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753283AbeDYORW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:17:22 -0400
X-Google-Smtp-Source: AB8JxZqXsjOmMZQb3zPfRlgiUUVfXdsgDUwYahb9Z54ewfV2hp7uQaeQVT5boE9A1U5idoRKdjj0W2fHrua+17hkrH4=
MIME-Version: 1.0
In-Reply-To: <20180424131543.2761-1-luc.vanoostenryck@gmail.com>
References: <20180424131543.2761-1-luc.vanoostenryck@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 25 Apr 2018 17:17:21 +0300
Message-ID: <CAHp75VcrmckbbkvGZ+B74DQXOkZddQog-D++iEeVVNCrDKUWww@mail.gmail.com>
Subject: Re: [PATCH] apple-gmux: fix gmux_get_client_id()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 4:15 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The method struct vga_switcheroo_handler::get_client_id() is defined
> as returning an 'enum vga_switcheroo_client_id' but the implementation
> in this driver, gmux_get_client_id(), returns an 'int'.
>
> Fix this by returning 'enum vga_switcheroo_client_id' in this driver too.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/platform/x86/apple-gmux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 7c4eb86c8..fd2ffebc8 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -495,7 +495,7 @@ static int gmux_set_power_state(enum vga_switcheroo_client_id id,
>         return gmux_set_discrete_state(apple_gmux_data, state);
>  }
>
> -static int gmux_get_client_id(struct pci_dev *pdev)
> +static enum vga_switcheroo_client_id gmux_get_client_id(struct pci_dev *pdev)
>  {
>         /*
>          * Early Macbook Pros with switchable graphics use nvidia
> --
> 2.17.0
>



-- 
With Best Regards,
Andy Shevchenko
