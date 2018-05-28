Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423074AbeE1MMm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:12:42 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36185 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164879AbeE1MMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:12:38 -0400
X-Google-Smtp-Source: ADUXVKIwn4vWKVEajqLvUm4+xGi0NTjw+MdsUuQvME0whEng39VzIORgU9Hlq/eG0gt2S0MGDE3KhooWqEcdB4MoYd0=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2AGu4Lec1pwi87gb4QYn9QTy7mG2i9kWtfAR=An+k-7g@mail.gmail.com>
References: <20180525210752.1794502-1-arnd@arndb.de> <CAPDyKFoyBZ=k5UQyTmgkPd+30Htymw99Xeh3C+bDPo+VGyjrNw@mail.gmail.com>
 <CAK8P3a2AGu4Lec1pwi87gb4QYn9QTy7mG2i9kWtfAR=An+k-7g@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 May 2018 15:12:37 +0300
Message-ID: <CAHp75VffA5Q2VxgkQqT6M_iLwZtv46Gy5Fz4Fx7PA9CvRnX0Ag@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi: mark PM functions as __maybe_unused
To: Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Jean

On Mon, May 28, 2018 at 2:13 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, May 28, 2018 at 1:04 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 25 May 2018 at 23:07, Arnd Bergmann <arnd@arndb.de> wrote:
>>> The newly added runtime-pm functions cause a harmless warning
>>> when CONFIG_PM is disabled:
>>>
>>> drivers/mmc/host/sunxi-mmc.c:1452:12: error: 'sunxi_mmc_runtime_suspend' defined but not used [-Werror=unused-function]
>>>  static int sunxi_mmc_runtime_suspend(struct device *dev)
>>>             ^~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/mmc/host/sunxi-mmc.c:1435:12: error: 'sunxi_mmc_runtime_resume' defined but not used [-Werror=unused-function]
>>>  static int sunxi_mmc_runtime_resume(struct device *dev)
>>>
>>> This marks them as __maybe_unused to shut up the warning.
>>
>> Most mmc drivers uses #ifdef CONFIG_PM instead of the __maybe_unused() option.
>>
>> It's not a big deal, but consistency is always good. Would you mind changing?
>
> I'd prefer not to. Most uses of #ifdef CONFIG_PM that get introduced are wrong,
> and cause additional randconfig warnings that I end up having to fix,
> so I always
> do it with __maybe_unused.

Some of the maintainers have strong objection against such changes.
http://lkml.iu.edu/hypermail/linux/kernel/1805.1/06100.html

It seems we might have a split in the opinions, which is not good in
this case (consistency for PM callbacks overall will be broken).

-- 
With Best Regards,
Andy Shevchenko
