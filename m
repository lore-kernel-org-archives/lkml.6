Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbeDZJGP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:06:15 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:39556 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754592AbeDZJGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:06:06 -0400
X-Google-Smtp-Source: AB8JxZoLofqYy7dFYMSzeWirk7QRbhJgDqNy1UBIT/CW+Te9cxT5EN7DEMFZL0DUXZHbxGXlqr7qlGWnojLY6vXcMZE=
MIME-Version: 1.0
In-Reply-To: <20180405120012.7671-1-colin.king@canonical.com>
References: <20180405120012.7671-1-colin.king@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Apr 2018 11:06:05 +0200
Message-ID: <CACRpkdZ2zRJfcSWbi_zwvtMnu_eGqAi684Wh3qWfjMazJqNsUA@mail.gmail.com>
Subject: Re: [PATCH] gpio: 104-dio-48e: make array 'ports' static, shrinks
 object size
To: Colin King <colin.king@canonical.com>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 2:00 PM, Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate the const read-only array 'ports' on the stack but instead
> make it static. Makes the object code smaller by over 100 buytes:
>
> Before:
>    text    data     bss     dec     hex filename
>   10959    4952     832   16743    4167 drivers/gpio/gpio-104-dio-48e.o
>
> After:
>    text    data     bss     dec     hex filename
>   10790    5008     832   16630    40f6 drivers/gpio/gpio-104-dio-48e.o
>
> (gcc version 7.2.0 x86_64)
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied with William's ACK.

Yours,
Linus Walleij
