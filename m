Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ldp6YvO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B527605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbeFFG6h (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 02:58:37 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45498 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932310AbeFFG6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 02:58:34 -0400
X-Google-Smtp-Source: ADUXVKIJvjjnb1OOldNTb4JdfhLn/SpTNToW59zq723DDhLvG4zIhdb+edVb8oy7Zv4r8UZ7smM86V1ZdWRb1fkvZM0=
MIME-Version: 1.0
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-19-ricardo.ribalda@gmail.com> <CAHp75VfFTtysSBvYfmCMoKZz8BpHb73qh=Zy-gpn6RKO2DE-5Q@mail.gmail.com>
In-Reply-To: <CAHp75VfFTtysSBvYfmCMoKZz8BpHb73qh=Zy-gpn6RKO2DE-5Q@mail.gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Wed, 6 Jun 2018 08:58:15 +0200
Message-ID: <CAPybu_0zByhDeVf6_Tv_PwU0WL_y6bkVPn0ha+VBvPcxWV4rLA@mail.gmail.com>
Subject: Re: [PATCH 18/19] serdev: ttydev: Serdev driver that creates an
 standard TTY port
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy
On Tue, Jun 5, 2018 at 3:42 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, May 29, 2018 at 4:10 PM, Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
> > Standard TTY port that can be loaded/unloaded via serdev sysfs. This
> > serdev driver can only be used by serdev controllers that are compatible
> > with ttyport.
>
> > +config SERIAL_DEV_CTRL_TTYDEV
> > +       tristate "TTY port dynamically loaded by the Serial Device Bus"
> > +       help
> > +         Say Y here if you want to create a bridge driver between the Serial
> > +         device bus and the TTY chardevice. This driver can be dynamically
> > +         loaded/unloaded by the Serial Device Bus.
> > +
> > +         If unsure, say Y.
> > +       depends on SERIAL_DEV_CTRL_TTYPORT
>
> > +       default m
>
> Hmm... Can't we survive w/o this by default?

If this module is not available and serdev is enabled the user would
miss his /dev/ttyS* nodes, so I rather leave this on.

>
> > +static int __init ttydev_serdev_init(void)
> > +{
> > +       return serdev_device_driver_register(&ttydev_serdev_driver);
> > +}
> > +module_init(ttydev_serdev_init);
> > +
> > +static void __exit ttydev_serdev_exit(void)
> > +{
> > +       return serdev_device_driver_unregister(&ttydev_serdev_driver);
> > +}
> > +module_exit(ttydev_serdev_exit);
>
> Isn't above is just a macro in serdev.h?
> I.e. module_serdev_device_driver().

ACK, thanks!
>
> --
> With Best Regards,
> Andy Shevchenko

Best regards

-- 
Ricardo Ribalda
