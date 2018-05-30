Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968529AbeE3HKd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 03:10:33 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43343 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935905AbeE3HK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 03:10:28 -0400
X-Google-Smtp-Source: ADUXVKKMIfePK/tsMg43dRnL3pJhl3+u4crLPfk95ObHbKt0P2mOzcChnQyBW8gHjwSmk/hnbHy2oZM6WGh6l9cshc0=
MIME-Version: 1.0
In-Reply-To: <CAHp75VewkgrvLDheJUvB=8vMjfaoaV6cOgsROqqWSMTrZJ4g7g@mail.gmail.com>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180526100243.GA1564@sirena.org.uk> <CGME20180528112908eucas1p2946a9b6385fcaf6c19921c9767420405@eucas1p2.samsung.com>
 <CACRpkdZFrFuNnP=uJyREckr8EXW6L2ku+=QwVA7Tva3CpfrpCQ@mail.gmail.com>
 <2026891.KGZ2uNuXyI@amdc3058> <CAHp75VewkgrvLDheJUvB=8vMjfaoaV6cOgsROqqWSMTrZJ4g7g@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 30 May 2018 09:10:27 +0200
Message-ID: <CACRpkdau+=rcyWaL_Ahd9RzcTwk88kKQ-UF_dwzgos60UhnEew@mail.gmail.com>
Subject: Re: [PATCH 10/19 v3] regulator: s2mps11: Pass descriptor instead of
 GPIO number
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 2:26 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, May 28, 2018 at 2:29 PM, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>
>> -       s2mps11->ext_control_gpiod = devm_kmalloc(&pdev->dev,
>> +       s2mps11->ext_control_gpiod = devm_kzalloc(&pdev->dev,
>>                         sizeof(*s2mps11->ext_control_gpiod) * rdev_num,
>>                         GFP_KERNEL);
>
> devm_kcalloc() I would rather use.

The patch replace kmalloc with kzalloc amd kcalloc does not initialize
memory to zero.

We don't have demv_kzcalloc() I'm afraid, I wonder it even makes
sense to add?

Yours,
Linus Walleij
