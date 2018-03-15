Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeCOWmL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:42:11 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41679 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932522AbeCOWmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:42:07 -0400
X-Google-Smtp-Source: AG47ELvmFpbseocJJktJSb0zFAGLP1aNr7uLH/pALMDqOxiAc7EOX+o3kclr4rUapGEL6g2ZSO9lNA==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [RFC 0/4] gpio-backlight: remove platform data support
Date: Thu, 15 Mar 2018 15:41:58 -0700
Message-Id: <20180315224202.96668-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series attempts to remove platform data support from gpio_blackllist
driver and switch it over to generic device properties/GPIO tables.
The only user of platform data was SuperH Ecovec24 board; please take a
look at patch #2 that tries to only register backlight when the board is
using LDC and not DVI.

Please note that I do not have the hardware (do we even care about
ecovec24? I'd like to rip out platform data support from tsc2007 as
well, but ecovec24 is using custom pendown handler and GPIOs have
to be switched off from interrupt mode to GPIO and back in that
pendown handler, which is all quite messy. If we do not care about
this board I'd much rather removed that custom pendown).

Thanks!

Dmitry Torokhov (4):
  backlight: gpio_backlight: use generic device properties
  sh: ecovec24: conditionally register backlight device
  sh: ecovec24: convert backlight to use device properties
  backlight: gpio_backlight: remove platform data support

 arch/sh/boards/mach-ecovec24/setup.c         | 47 ++++++----
 drivers/video/backlight/gpio_backlight.c     | 93 +++-----------------
 include/linux/platform_data/gpio_backlight.h | 20 -----
 3 files changed, 46 insertions(+), 114 deletions(-)
 delete mode 100644 include/linux/platform_data/gpio_backlight.h

-- 
Dmitry
