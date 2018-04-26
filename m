Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756730AbeDZXDP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:03:15 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43250 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754336AbeDZXDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:03:13 -0400
X-Google-Smtp-Source: AIpwx4+8iOwKVFUuDrCMfE8PY/1l2grB4q9/hhO9HOIyEw8hhtMJ/U1mmWzI9O70HoR1sGI11oejdyhaEQsiCBeAa0s=
MIME-Version: 1.0
In-Reply-To: <20180418172634.14734-1-colin.king@canonical.com>
References: <20180418172634.14734-1-colin.king@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Apr 2018 01:03:12 +0200
Message-ID: <CACRpkdYq-xLFXi8vLkbSsnaAboJjS5rDVWPHeNRdo=FrmsagaQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: make several const arrays static, shrinks object size
To: Colin King <colin.king@canonical.com>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 7:26 PM, Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate the const read-only arrays 'port' on the stack but
> instead make them static. Makes the object code smaller:
>
> Before:
>   text    data     bss     dec    hex filename
>   8542    4088     672   13302   33f6 drivers/gpio/gpio-gpio-mm.o
>  10959    4952     832   16743   4167 drivers/gpio/gpio-104-dio-48e.o
>   9022    5064    1408   15494   3c86 drivers/gpio/gpio-104-idi-48.o
>
> After:
>   text    data     bss     dec    hex filename
>   8372    4144     672   13188   3384 drivers/gpio/gpio-gpio-mm.o
>  10790    5008     832   16630   40f6 drivers/gpio/gpio-104-dio-48e.o
>   8853    5152    1408   15413   3c35 linux/drivers/gpio/gpio-104-idi-48.o
>
> (gcc version 7.2.0 x86_64)
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I had already applied some part of the patch.

Dropped patches to one file for this reason.

Please check the result.

Patch applied!

Yours,
Linus Walleij
