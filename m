Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeBEXDi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 18:03:38 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:34887 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeBEXD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 18:03:28 -0500
X-Google-Smtp-Source: AH8x224aNbFM1nhGXQhrr58yUxY1tkkDw/D89NCguoKwSeDuNRKi4xCGO9GOMCK0M87p611+b58o4/QJMle6oRvtAXE=
MIME-Version: 1.0
In-Reply-To: <20180205190858.GA22699@ulmo>
References: <20180205124750.19305-1-thierry.reding@gmail.com>
 <20180205125436.24005-1-thierry.reding@gmail.com> <CA+55aFy--bQRDZEUsBfiWhyP+Of3+s4zEcKo1T8cCoAMXBrwsw@mail.gmail.com>
 <20180205175906.GA8237@ulmo> <CACRpkdYrG6=qwJgOTW2ccyq-UBSOkH+EBBui54PtGqJF7CMRDw@mail.gmail.com>
 <20180205190858.GA22699@ulmo>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 6 Feb 2018 00:03:26 +0100
Message-ID: <CACRpkdbKF5-A63_-U62OcAyy5Juntuym9N96nkicqHtc2TUC+Q@mail.gmail.com>
Subject: Re: [PATCH] net: mediatek: Explicitly include pinctrl headers
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-gpio@vger.kernel.org, linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 8:08 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Mon, Feb 05, 2018 at 08:02:40PM +0100, Linus Walleij wrote:
>> On Mon, Feb 5, 2018 at 6:59 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
>>
>> > Anyway, I think going with the pinctrl/devinfo.h include only is fine
>> > for now. If it turns out that the Mediatek ethernet and Rockchip LVDS
>> > drivers can just omit the bits fiddling with struct dev_pin_info, we can
>> > swap out the pinctrl/devinfo.h include for pinctrl/consumer.h at that
>> > time.
>> >
>> > LinusW: what are your thoughts on the struct dev_pin_info usage by these
>> > drivers? Does their code seem redundant to you, too?
>>
>> I don't think they should use struct dev_pin_info at all,
>> that thing is for the device core only.
>>
>> I like to think that <linux/pinctrl/consumer.h> is for drivers that
>> explicitly grab and control pin control states so this driver should
>> only include <linux/pinctrl/consumer.h>.
>>
>> Torvalds: can you do it like that instead? Either way will
>> make the compile work again, we can also tidy it up later.
>> (i.e. I will grep for includes of pinctrl/dev_info.h and replace
>> it with consumer.h) at some point.
>
> That won't work, unfortunately, because these drivers actually try to
> dereference pointers to struct dev_pin_info and hence need that include
> for the structure's definition. Those are the only two drivers I can see
> that access this structure directly (other than the device core).

Grrr OK I thought I was aiming for encapsulation here but then
what can I do, sigh.

Yours,
Linus Walleij
