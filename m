Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753568AbeCPLLr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 07:11:47 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42736 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeCPLLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 07:11:45 -0400
X-Google-Smtp-Source: AG47ELvuizPKckP0YrgKxuXPrFbxO7ermGxszL/Wbvbe/q+sONX7Kxp72f1RUpGX/9ltCdS79A/OvA==
Date: Fri, 16 Mar 2018 11:11:40 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC 0/4] gpio-backlight: remove platform data support
Message-ID: <20180316111140.ez6lmyx4ntf2nbxz@holly.lan>
References: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 03:41:58PM -0700, Dmitry Torokhov wrote:
> Hi,
> 
> This series attempts to remove platform data support from gpio_blackllist
> driver and switch it over to generic device properties/GPIO tables.
> The only user of platform data was SuperH Ecovec24 board; please take a
> look at patch #2 that tries to only register backlight when the board is
> using LDC and not DVI.

Can't comment on patch #2 but, from the backlight side of things I have
no objections.


Daniel.

> 
> Please note that I do not have the hardware (do we even care about
> ecovec24? I'd like to rip out platform data support from tsc2007 as
> well, but ecovec24 is using custom pendown handler and GPIOs have
> to be switched off from interrupt mode to GPIO and back in that
> pendown handler, which is all quite messy. If we do not care about
> this board I'd much rather removed that custom pendown).
> 
> Thanks!
> 
> Dmitry Torokhov (4):
>   backlight: gpio_backlight: use generic device properties
>   sh: ecovec24: conditionally register backlight device
>   sh: ecovec24: convert backlight to use device properties
>   backlight: gpio_backlight: remove platform data support
> 
>  arch/sh/boards/mach-ecovec24/setup.c         | 47 ++++++----
>  drivers/video/backlight/gpio_backlight.c     | 93 +++-----------------
>  include/linux/platform_data/gpio_backlight.h | 20 -----
>  3 files changed, 46 insertions(+), 114 deletions(-)
>  delete mode 100644 include/linux/platform_data/gpio_backlight.h
> 
> -- 
> Dmitry
> 
