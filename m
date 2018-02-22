Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933150AbeBVPqi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:46:38 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45609 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933020AbeBVPqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:46:36 -0500
X-Google-Smtp-Source: AG47ELsdQlzS8GL65rPUQeHwfkJ8IQi7VWFqR5/JWVJlLUT3XUUm/4gmfzq5j08T9QpKJESnU/z2ocP1gwMQmRMBf00=
MIME-Version: 1.0
In-Reply-To: <20180222153823.62bd7xfh7gj75x5j@verge.net.au>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-10-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdVDCga8htL+UD3P0Kzt9-OQ6hof+szGOiV9d0gwxGExqQ@mail.gmail.com>
 <20180221171504.dac7yikrqfnjiiog@verge.net.au> <CAK8P3a30pgOXvLLHe3Hb-ubPz6QeUiZKFqMZLm8Qp_7KRr7QuA@mail.gmail.com>
 <CAMuHMdXJcHLee3mn56pSpUkFie_rQFZEPf=+6MWHe+W-+bMxgQ@mail.gmail.com> <20180222153823.62bd7xfh7gj75x5j@verge.net.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 16:46:34 +0100
X-Google-Sender-Auth: 2SeaYIz30Zhh9VJ5jyf1LvzlBeY
Message-ID: <CAK8P3a2tNdsx-Zpq8w+dKW1EMwZ0fT4Q++zb_j_heGwemeO36g@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] ARM64: dts: Add R-Car Salvator-x M3-N support
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 4:38 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Feb 22, 2018 at 02:28:46PM +0100, Geert Uytterhoeven wrote:

>> Removing the .dts file removes the ability to boot the newly added board...
>>
>> The issue here is that we are sharing board .dtsi for boards that can be
>> equipped with different pin-compatible SiPs (Ri-Car H3, M3-W, M3-N), while
>> not all SoC support has been enabled and/or tested. As the board .dtsi
>> references on-SoC devices using phandles, the new r8a77965.dtsi declares
>> placeholders for the devices that are not yet enabled/tested.
>> This worked fine for r8a7796.dtsi before, but causes dtc warnings due to
>> recent improvements in DT validation.
>>
>> I think the simplest way to fix this is to add reg properties to the
>> placeholders, as Simon did for the last two placeholders in r8a7796.dtsi in
>> commit 4316989537a6ed53 ("arm64: dts: renesas: r8a7796: add reg properties to
>> pciec[01] nodes").
>
> I think the best solution is an incremental patch on top of the renesas
> devel branch to, as Geert suggests, add reg properties to the placeholders.
>
> I've asked Jacopo to prepare such a patch.

Sounds good, thanks a lot for the quick reply!

     Arnd
