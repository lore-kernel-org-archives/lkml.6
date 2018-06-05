Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeFENmV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:42:21 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34077 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbeFENmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:42:19 -0400
X-Google-Smtp-Source: ADUXVKKwLYAXoyS4KafOGxpqnu2XVRBvrDDY+6JuC5EsVHK170HNTOMwnRBgSKWjiDnH5SOFlCC5dRboUgglxRNxsW8=
MIME-Version: 1.0
In-Reply-To: <20180529131014.18641-19-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com> <20180529131014.18641-19-ricardo.ribalda@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 16:42:18 +0300
Message-ID: <CAHp75VfFTtysSBvYfmCMoKZz8BpHb73qh=Zy-gpn6RKO2DE-5Q@mail.gmail.com>
Subject: Re: [PATCH 18/19] serdev: ttydev: Serdev driver that creates an
 standard TTY port
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 4:10 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> Standard TTY port that can be loaded/unloaded via serdev sysfs. This
> serdev driver can only be used by serdev controllers that are compatible
> with ttyport.

> +config SERIAL_DEV_CTRL_TTYDEV
> +       tristate "TTY port dynamically loaded by the Serial Device Bus"
> +       help
> +         Say Y here if you want to create a bridge driver between the Serial
> +         device bus and the TTY chardevice. This driver can be dynamically
> +         loaded/unloaded by the Serial Device Bus.
> +
> +         If unsure, say Y.
> +       depends on SERIAL_DEV_CTRL_TTYPORT

> +       default m

Hmm... Can't we survive w/o this by default?

> +static int __init ttydev_serdev_init(void)
> +{
> +       return serdev_device_driver_register(&ttydev_serdev_driver);
> +}
> +module_init(ttydev_serdev_init);
> +
> +static void __exit ttydev_serdev_exit(void)
> +{
> +       return serdev_device_driver_unregister(&ttydev_serdev_driver);
> +}
> +module_exit(ttydev_serdev_exit);

Isn't above is just a macro in serdev.h?
I.e. module_serdev_device_driver().

-- 
With Best Regards,
Andy Shevchenko
