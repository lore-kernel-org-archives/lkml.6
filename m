Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754185AbeEUWAf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:00:35 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41420 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbeEUWAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:00:25 -0400
X-Google-Smtp-Source: AB8JxZp5g2Fl9IFrvsXeAEfErIj3T0DaXmS8omkd1SHQ+2xhUkUAaZzUcD1PygvGzc+T18OLs16ekogH7x7zWmz6iS4=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-20-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-20-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:00:23 +0300
Message-ID: <CAHp75VfqEdoDZydwFmQaLiUN8cVtH3MbFHf3qixU8xUHXMwt1g@mail.gmail.com>
Subject: Re: [PATCH 19/33] thermal: db8500: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

> +       i = match_string((const char **)trip_point->cdev_name,

Casting looks ugly. You need to constify the variable itself.

> +                        COOLING_DEV_MAX, cdev->type);
>
> -       return -ENODEV;
> +       return (i < 0) ? -ENODEV : 0;

I would rather go with

if (ret < 0)
 return -ENODEV;

return 0;

-- 
With Best Regards,
Andy Shevchenko
