Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeDJUbM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:31:12 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42995 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeDJUbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:31:10 -0400
X-Google-Smtp-Source: AIpwx49Pmp/Wpbs82nU2zELzqMd7zbyhsjL7RHog856mMt8ttZA7Ns8t2squHddI28pm4dF0rX7Lxf4aHJnO8o/r74g=
MIME-Version: 1.0
In-Reply-To: <201804110047.jKfmWBhd%fengguang.wu@intel.com>
References: <20180410124029.2915-1-brgl@bgdev.pl> <201804110047.jKfmWBhd%fengguang.wu@intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 10 Apr 2018 22:31:09 +0200
Message-ID: <CAMRc=Md+GEKbWV3gOkOMkLe0Rn0kbcvohQecCXE8u74uqgRoGQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: add hogs support for machine code
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-10 19:05 GMT+02:00 kbuild test robot <lkp@intel.com>:
> Hi Bartosz,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on gpio/for-next]
> [also build test ERROR on v4.16 next-20180410]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/gpiolib-add-hogs-support-for-machine-code/20180410-232047
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
> config: i386-randconfig-a0-201814 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers//mfd/sm501.c:23:0:
>>> include/linux/gpio/machine.h:56:19: error: field 'dflags' has incomplete type
>      enum gpiod_flags dflags;
>                       ^
>
> vim +/dflags +56 include/linux/gpio/machine.h
>
>     41
>     42  /**
>     43   * struct gpiod_hog - GPIO line hog table
>     44   * @chip_label: name of the chip the GPIO belongs to
>     45   * @chip_hwnum: hardware number (i.e. relative to the chip) of the GPIO
>     46   * @line_name: consumer name for the hogged line
>     47   * @lflags: mask of GPIO lookup flags
>     48   * @dflags: GPIO flags used to specify the direction and value
>     49   */
>     50  struct gpiod_hog {
>     51          struct list_head list;
>     52          const char *chip_label;
>     53          u16 chip_hwnum;
>     54          const char *line_name;
>     55          enum gpio_lookup_flags lflags;
>   > 56          enum gpiod_flags dflags;
>     57  };
>     58
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

Superseded by v2.
