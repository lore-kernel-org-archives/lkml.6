Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754092AbeE1Ile (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:41:34 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36656 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753986AbeE1Ild (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:41:33 -0400
X-Google-Smtp-Source: ADUXVKILjP2jZxVnpVFJRUBUcInSU8KrBF7He8BsK5xHO8WcPzO2YHKGrCX4T3mJuOOhLHxWTihwhTpy9A4gAgsRs+0=
MIME-Version: 1.0
In-Reply-To: <20180526100243.GA1564@sirena.org.uk>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-11-linus.walleij@linaro.org> <20180526100243.GA1564@sirena.org.uk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 May 2018 10:41:31 +0200
Message-ID: <CACRpkdZFrFuNnP=uJyREckr8EXW6L2ku+=QwVA7Tva3CpfrpCQ@mail.gmail.com>
Subject: Re: [PATCH 10/19 v3] regulator: s2mps11: Pass descriptor instead of
 GPIO number
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 12:02 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, May 14, 2018 at 10:06:31AM +0200, Linus Walleij wrote:
>> Instead of passing a global GPIO number for the enable GPIO, pass
>> a descriptor looked up with the standard devm_gpiod_get_optional()
>> call.
>>
>> This regulator supports passing platform data, but enable/sleep
>> regulators are looked up from the device tree exclusively, so
>> we can need not touch other files.
>
> This seems to have broken the boot on Odroid XU3 so I'm going to revert
> it:
>
> https://storage.kernelci.org/next/master/v4.17-rc6-9523-g47b9cef0672d/arm/multi_v7_defconfig/lab-baylibre-seattle/boot-exynos5422-odroidxu3.html

How annoying. I will check with a colleague who might have this
board so I can test it on hardware.

Yours,
Linus Walleij
