Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbeC0L7I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:59:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33626 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeC0L7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:59:05 -0400
X-Google-Smtp-Source: AG47ELvP8eTaWYglegDvyMv7anO6arFhDIKKvKCxYaJS51XPPHeFo2reJT33UlhWac1LniEmbgKx+/leYpiO9npMkQk=
MIME-Version: 1.0
In-Reply-To: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 13:59:04 +0200
Message-ID: <CACRpkdbCqYF-OsmsHFrY5H56oS=FepVFJRqvCM7yj9Ox4E6SEA@mail.gmail.com>
Subject: Re: [RFC 0/4] gpio-backlight: remove platform data support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 11:41 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This series attempts to remove platform data support from gpio_blackllist
> driver

We really need a GPIO blacklist driver in the kernel, but for
not let's fix backlight :D :D

> and switch it over to generic device properties/GPIO tables.

This series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> Please note that I do not have the hardware (do we even care about
> ecovec24? I'd like to rip out platform data support from tsc2007 as
> well, but ecovec24 is using custom pendown handler and GPIOs have
> to be switched off from interrupt mode to GPIO and back in that
> pendown handler, which is all quite messy. If we do not care about
> this board I'd much rather removed that custom pendown).

I am also struggling with refactoring of board files, all over the place.
At least Arnd deleted the Blackfin stuff now, but the misc ARM board
and MIPS stuff still give me the creeps sometimes.

I guess if maintainers of the boards are not there to even ACK
patches we can propose patches to simply delete them.

Yours,
Linus Walleij
