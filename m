Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756268AbeDZNIa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:08:30 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40693 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755979AbeDZNI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:08:27 -0400
X-Google-Smtp-Source: AB8JxZoMvYCOcnTg60Us9GHxSo5b+h3i4uUW9K29sK47d7AI29H1SnFjaOoOiAbFZmw2BrHtStHGI/Yvx1SzIzJaDcY=
MIME-Version: 1.0
In-Reply-To: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
References: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Apr 2018 15:08:24 +0200
Message-ID: <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
Subject: Re: [PATCH] gpio: zynq: Setup chip->base based on alias ID
To: Michal Simek <michal.simek@xilinx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 3:55 PM, Michal Simek <michal.simek@xilinx.com> wrote:

Thanks for your patch!

> In past Xilinx gpio-zynq driver was setting up gpio chip->base as 0
> which was chagned to autodetection when driver was upstreamed. Older
> systems, which were using this old version, setup SW stack which expects
> zynq gpio base as 0 and right now there is no way how to set this up.
>
> The patch is adding an option to setup chip->base based on aliases which
> is something what some other drivers are doing too.
> It means when gpio0 alias is setup then chip->base is 0. When gpio alias
> is not setup gpiochip_find_base() set it up properly which is current
> behavior.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

In general, we stopped any controlling of the GPIO base.

Also this use would have to be OK with the DT maintainers
as I never saw this use of alias before.

Please describe the use case for this.

The only use case which I can think about is userspace sysfs
and then I would really like to know why these userspace
users cannot use the character device that is nowadays
supported by libgpiod and there is even patches for some
IoT libraries to use it. The character device makes the
GPIO Linux "base" irrelevant for userspace.

GPIO sysfs is deprecated and moved to the obsolete ABI.

If there are legacy applications that use this I would have
to consider it, but since this has been -1 since the driver
was merged I find that unlikely.

Yours,
Linus Walleij
