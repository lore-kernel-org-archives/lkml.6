Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeDRRky (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:40:54 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35180 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbeDRRkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:40:51 -0400
X-Google-Smtp-Source: AIpwx4+P9bLOsQHbHaDj8vgAD9tioTQ/xGN4vKTJwm8KmUueyBJUW9H/MaHO15PVaZgv2Zpafhagtw==
Date: Wed, 18 Apr 2018 13:40:43 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Colin King <colin.king@canonical.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: make several const arrays static, shrinks object
 size
Message-ID: <20180418174043.GA15833@sophia>
References: <20180418172634.14734-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180418172634.14734-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 06:26:34PM +0100, Colin King wrote:
>From: Colin Ian King <colin.king@canonical.com>
>
>Don't populate the const read-only arrays 'port' on the stack but
>instead make them static. Makes the object code smaller:
>
>Before:
>  text    data     bss     dec    hex filename
>  8542    4088     672   13302   33f6 drivers/gpio/gpio-gpio-mm.o
> 10959    4952     832   16743   4167 drivers/gpio/gpio-104-dio-48e.o
>  9022    5064    1408   15494   3c86 drivers/gpio/gpio-104-idi-48.o
>
>After:
>  text    data     bss     dec    hex filename
>  8372    4144     672   13188   3384 drivers/gpio/gpio-gpio-mm.o
> 10790    5008     832   16630   40f6 drivers/gpio/gpio-104-dio-48e.o
>  8853    5152    1408   15413   3c35 linux/drivers/gpio/gpio-104-idi-48.o
>
>(gcc version 7.2.0 x86_64)
>
>Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
