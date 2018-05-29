Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966799AbeE2UfS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:35:18 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43748 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966480AbeE2UfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:35:15 -0400
X-Google-Smtp-Source: ADUXVKJsjPIzGEE8vnbu1mRKjZj2jy1aO3w4tQS39RZ0GixTD/0jV6Xkee1lwAYfixO3OKJ5kklXZSbim0ulupWmnoI=
MIME-Version: 1.0
In-Reply-To: <20180529131014.18641-8-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com> <20180529131014.18641-8-ricardo.ribalda@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 29 May 2018 23:35:13 +0300
Message-ID: <CAHp75Ve_=euX83qVfArU+ZbcU2Z_PnBdtQGi7XbA7AVfM1XO-w@mail.gmail.com>
Subject: Re: [PATCH 07/19] serdev: Allows dynamic creation of devices via sysfs
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
> Allow creating and deleting devices via sysfs. Devices created will be
> matched to serdev drivers via modalias (the string provided by the user)
> and deleted via their name.

> +       int err;
> +       char *nline;

Better to read in reversed order.

> +       nline = strchr(buf, '\n');
> +       if (nline)
> +               *nline = '\0';

strim() / strstrip() ?

> +       nline = strchr(buf, '\n');
> +       if (nline)
> +               *nline = '\0';

Ditto.

> +static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, 0200, NULL,
> +                                 delete_device_store);

Perhaps leave it on one line?

-- 
With Best Regards,
Andy Shevchenko
