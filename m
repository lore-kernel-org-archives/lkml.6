Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424562AbeE1Lfa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:35:30 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36822 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424250AbeE1LNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:13:30 -0400
X-Google-Smtp-Source: ADUXVKKuVdlC1JO97EOSOuSTfR0I0AEcsgARvKG2EQpGsD3QpRicbWEHi5j7A/hGi4fPOjtvENk66j/+wSnoM9D82P8=
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoyBZ=k5UQyTmgkPd+30Htymw99Xeh3C+bDPo+VGyjrNw@mail.gmail.com>
References: <20180525210752.1794502-1-arnd@arndb.de> <CAPDyKFoyBZ=k5UQyTmgkPd+30Htymw99Xeh3C+bDPo+VGyjrNw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 28 May 2018 13:13:29 +0200
X-Google-Sender-Auth: fNEC2i2lObtTzXVyJT1jxucTatU
Message-ID: <CAK8P3a2AGu4Lec1pwi87gb4QYn9QTy7mG2i9kWtfAR=An+k-7g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: mark PM functions as __maybe_unused
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 1:04 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 25 May 2018 at 23:07, Arnd Bergmann <arnd@arndb.de> wrote:
>> The newly added runtime-pm functions cause a harmless warning
>> when CONFIG_PM is disabled:
>>
>> drivers/mmc/host/sunxi-mmc.c:1452:12: error: 'sunxi_mmc_runtime_suspend' defined but not used [-Werror=unused-function]
>>  static int sunxi_mmc_runtime_suspend(struct device *dev)
>>             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sunxi-mmc.c:1435:12: error: 'sunxi_mmc_runtime_resume' defined but not used [-Werror=unused-function]
>>  static int sunxi_mmc_runtime_resume(struct device *dev)
>>
>> This marks them as __maybe_unused to shut up the warning.
>
> Most mmc drivers uses #ifdef CONFIG_PM instead of the __maybe_unused() option.
>
> It's not a big deal, but consistency is always good. Would you mind changing?

I'd prefer not to. Most uses of #ifdef CONFIG_PM that get introduced are wrong,
and cause additional randconfig warnings that I end up having to fix,
so I always
do it with __maybe_unused.

I don't mind if you treat my patch as a bug report and decide to fix
it differently
yourself, but you won't get that patch from me ;-)

       Arnd
