Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbeDWKbk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:31:40 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33939 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754466AbeDWKbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:31:33 -0400
X-Google-Smtp-Source: AIpwx4+PbVOo2U8a9OqPp2zeW7PNtg5j/beXCqNxP0BwTa5g0kk6CFMi827onkYU7FrTbqHAMRbIzvV1uS8DGvp2pVM=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW5LkOhTbiZVRG41QgBYk8JnjK1caSSN-gmJ9c02R0BWw@mail.gmail.com>
References: <0ca46228311ec615947e199def9fed62d70c1f07.1524118799.git.baolin.wang@linaro.org>
 <CAK8P3a15stj5Yurd7rM7278cYPtM6kufs=QL2GihCOxRUCHRSQ@mail.gmail.com>
 <CAMz4kuKPH5Byv0bsdO_Jg-FhZNH6qMgixzM4Q988KnbQrF3qeQ@mail.gmail.com> <CAMuHMdW5LkOhTbiZVRG41QgBYk8JnjK1caSSN-gmJ9c02R0BWw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 23 Apr 2018 18:31:32 +0800
Message-ID: <CAMz4kuLQ2a8FxVB+OuQ2oS2efBuDn5SC-hW5JU4ZMhqowPs57A@mail.gmail.com>
Subject: Re: [PATCH] m68k: Remove read_persistent_clock()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        linux-m68k <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 23 April 2018 at 17:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Baolin,
>
> On Mon, Apr 23, 2018 at 4:08 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On 20 April 2018 at 23:22, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Thu, Apr 19, 2018 at 8:22 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>>>> The read_persistent_clock() uses a timespec, which is not year 2038 safe
>>>> on 32bit systems. Moreover on m68k architecture, we have implemented generic
>>>> RTC drivers that can be used to compensate the system suspend time. So
>>>> we can remove the obsolete read_persistent_clock().
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>>
>>> I'm not sure about this one: it's still possible to turn off
>>> CONFIG_RTC_DRV_GENERIC
>>> on M68KCLASSIC, and in that case we still need a read_persistent_clock64()
>>> implementation. Or we use your patch but make CONFIG_RTC_DRV_GENERIC
>>> mandatory.
>>
>> OK. Thanks for fixing the issue with your patch.
>
> Can I consider that an Acked-by?

I will add one reviewed-by tag in Arnd's new patch.

-- 
Baolin.wang
Best Regards
