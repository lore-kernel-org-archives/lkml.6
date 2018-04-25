Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbeDYJ0w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:26:52 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:46911 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbeDYJ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:26:48 -0400
X-Google-Smtp-Source: AB8JxZqRsXZCUDEmNkQbj4WZ19CDJhLnyhR8+J0Qucmho/zFVnMwc9ruY2slhMhRPejixzjgdo+2lUpKrZ1wh/my98Q=
MIME-Version: 1.0
In-Reply-To: <7055b7b9-2a55-73e7-0d82-6d291556accd@ti.com>
References: <20180417102917.7794-1-brgl@bgdev.pl> <20180417102917.7794-5-brgl@bgdev.pl>
 <7055b7b9-2a55-73e7-0d82-6d291556accd@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 25 Apr 2018 11:26:46 +0200
Message-ID: <CAMRc=Mes-JfzRw2ukdQ21S86HA_iH4fu8cjq0OmJOsO5DPirYg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 4/4] ARM: davinci: use aemif platform driver in
 legacy mode for da850-evm
To: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-17 16:12 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> On Tuesday 17 April 2018 03:59 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> We now support board files in aemif. Use the platform driver instead
>> of the handcrafted API in da850-evm.
>>
>> Note: the id of davinci_nand is changed to 0 in order to make it work
>> with the new common-clock framework based psc driver.
>
> Is this now needed after applying my patch dropping clock acquisition
> from DaVinci NAND driver?
>

Now that I realized that pdev->id matters for the driver as well, I'm
thinking this may have broken the support. Unfortunately we don't have
the nand extension for da850-evm to test it. I'll revert it to the
previous value.

Bart
