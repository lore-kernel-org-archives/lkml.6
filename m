Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754432AbeDWJHx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:07:53 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38130 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbeDWJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:07:50 -0400
X-Google-Smtp-Source: AIpwx4+lmdyHq9UQ/9CYrFaT9QlH47Ur2mnua/QY72Em0W6S6DbliSTKnT27dAJEaV8D8wi+Dv3FQP5xXVbEqXYg0kA=
MIME-Version: 1.0
In-Reply-To: <CAMz4kuKPH5Byv0bsdO_Jg-FhZNH6qMgixzM4Q988KnbQrF3qeQ@mail.gmail.com>
References: <0ca46228311ec615947e199def9fed62d70c1f07.1524118799.git.baolin.wang@linaro.org>
 <CAK8P3a15stj5Yurd7rM7278cYPtM6kufs=QL2GihCOxRUCHRSQ@mail.gmail.com> <CAMz4kuKPH5Byv0bsdO_Jg-FhZNH6qMgixzM4Q988KnbQrF3qeQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Apr 2018 11:07:49 +0200
X-Google-Sender-Auth: nE3hIehRGeMapc4p3kIaEKYpXVY
Message-ID: <CAMuHMdW5LkOhTbiZVRG41QgBYk8JnjK1caSSN-gmJ9c02R0BWw@mail.gmail.com>
Subject: Re: [PATCH] m68k: Remove read_persistent_clock()
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On Mon, Apr 23, 2018 at 4:08 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> On 20 April 2018 at 23:22, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thu, Apr 19, 2018 at 8:22 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>>> The read_persistent_clock() uses a timespec, which is not year 2038 safe
>>> on 32bit systems. Moreover on m68k architecture, we have implemented generic
>>> RTC drivers that can be used to compensate the system suspend time. So
>>> we can remove the obsolete read_persistent_clock().
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>
>> I'm not sure about this one: it's still possible to turn off
>> CONFIG_RTC_DRV_GENERIC
>> on M68KCLASSIC, and in that case we still need a read_persistent_clock64()
>> implementation. Or we use your patch but make CONFIG_RTC_DRV_GENERIC
>> mandatory.
>
> OK. Thanks for fixing the issue with your patch.

Can I consider that an Acked-by?

Thanks!

>> See below for a version I did a while ago (but never submitted as I got
>> distracted).
>>
>>        Arnd
>>
>> commit 13ddf5a33a195e9b7a7a6ed10481363b5259c1d4
>> Author: Arnd Bergmann <arnd@arndb.de>
>> Date:   Thu Jan 25 15:30:50 2018 +0100
>>
>>     m68k: use read_persistent_clock64 consistently

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
