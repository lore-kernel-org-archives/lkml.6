Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751470AbeDEJHN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:07:13 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40424 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeDEJHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:07:11 -0400
X-Google-Smtp-Source: AIpwx49vQsWp3JHAwNzy67jYsfk/DhFFCn4/0eCpkulSNEoGxHV2kddxu4u7AHWqcY9WHw0MXJFrStGjm8+7GPA30UI=
MIME-Version: 1.0
In-Reply-To: <20180404171222.GH5700@atomide.com>
References: <20180404102550.3692501-1-arnd@arndb.de> <20180404171222.GH5700@atomide.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 11:07:09 +0200
X-Google-Sender-Auth: gvlo9k48LOjyCGFbhXfQn-dIdXM
Message-ID: <CAK8P3a113KzqRU7_qY96YGTz28+hMuyrMvJJVxOcL7cJogkpKQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: omap2: fix am43xx build without L2X0
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>, Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 7:12 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Arnd Bergmann <arnd@arndb.de> [180404 10:27]:
>> When CONFIG_CACHE_L2X0 is disabled, the am43xx specific suspend
>> implemnentation fails to link:
>>
>> arch/arm/mach-omap2/sleep43xx.o: In function `get_l2cache_base':
>> (.text+0x180): undefined reference to `omap4_get_l2cache_base'
>>
>> This adds an #ifdef protection around the code, like we do for am44xx.
>>
>> Fixes: 41d37e61372f ("ARM: OMAP2+: Introduce low-level suspend code for AM43XX")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks, looks OK to me:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Applied to next/soc.

     Arnd
