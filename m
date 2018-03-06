Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753944AbeCFQ4s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:56:48 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34861 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753831AbeCFQ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:56:43 -0500
X-Google-Smtp-Source: AG47ELt/MRC09aVMry4DZdMls+0QllmNYASINO5dDqXcZTo5vP4XX2cRFlqSdKmhRWGtdwiCGm65KpdKCR6pkgc+A3c=
MIME-Version: 1.0
In-Reply-To: <20180306163035.GE13586@sirena.org.uk>
References: <20180305231246.GB5799@atomide.com> <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 6 Mar 2018 13:56:42 -0300
Message-ID: <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
Subject: Re: Regulator regression in next-20180305
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Maciej Purski <m.purski@samsung.com>,
        linux-omap@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Mar 6, 2018 at 1:30 PM, Mark Brown <broonie@kernel.org> wrote:

> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index e685f8b94acf..2c5b20a97f51 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -159,7 +159,7 @@ static void regulator_lock_supply(struct regulator_dev *rdev)
>  {
>         int i;
>
> -       for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
> +       for (i = 1000; rdev; rdev = rdev_get_supply(rdev), i++)
>                 mutex_lock_nested(&rdev->mutex, i);

With this change the log is a bit different, but still get a kernel hang:
https://pastebin.com/eF08TnuT

Thanks
