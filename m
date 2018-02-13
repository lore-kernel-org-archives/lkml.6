Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754252AbeBMTMX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 14:12:23 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39219 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753798AbeBMTMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 14:12:21 -0500
X-Google-Smtp-Source: AH8x227SVxARujG10k9/5Onoy8Q2AgqN/EQdroIIzlXdY1J9H4o+TS1VHclYPdnS9eTcq9uyOuAhZQaCdrxsSV41bHE=
MIME-Version: 1.0
In-Reply-To: <CAKKbWA6Otc1ZO_yHpfhxPjbgvvn-QXcXG9sy5=3FZDY8d_20rw@mail.gmail.com>
References: <20180205235757.246758-1-brendanhiggins@google.com>
 <20180205235757.246758-3-brendanhiggins@google.com> <CAK8P3a0SJTAkv7_QtDW1sDWFDYHw8tFWZqO6EMwpZ_5KPbhq3Q@mail.gmail.com>
 <CAKKbWA6Otc1ZO_yHpfhxPjbgvvn-QXcXG9sy5=3FZDY8d_20rw@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 13 Feb 2018 11:12:19 -0800
Message-ID: <CAFd5g44iHgSoPfko6hgMjz=QMm6ZUScUWbnho1w0bL_brTCjrA@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] arm: dts: add Nuvoton NPCM750 device tree
To: Avi Fishman <avifishman70@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 1:29 AM, Avi Fishman <avifishman70@gmail.com> wrote:
> On Tue, Feb 13, 2018 at 10:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tue, Feb 6, 2018 at 12:57 AM, Brendan Higgins
>> <brendanhiggins@google.com> wrote:
>>> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
>>> specific device tree for the NPCM750 (Poleg) evaluation board.
>>>
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>> Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
>>> Reviewed-by: Avi Fishman <avifishman70@gmail.com>
>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Tested-by: Tomer Maimon <tmaimon77@gmail.com>
>>> Tested-by: Avi Fishman <avifishman70@gmail.com>
>> ...
>>> +               enable-method = "nuvoton,npcm7xx-smp";
>>
>> I see this has already been reviewed quite a bit, but I'm curious
>> about the 'npcm7xx'
>> part here. Shouldn't that be a real chip name rather than a wildcard?
>>
>>        Arnd
>
> There is a family of npcm7xx, some with SMP and some without.
> For those who has it, it is common for all to use the same
> "nuvoton,npcm7xx-smp".

I think Arnd is right. In this case it should be "nuvoton,npcm750-smp". We can
use CPU_METHOD_OF_DECLARE to alias to as many compatible properties as needed.

Although everything in the 7xx family currently is either single core or has the
same SMP behavior, you could paint yourself into a corner if you were to make
one SMP device in the 7xx family which behaves differently from all other
devices and then need to come up with new compatible string names just for that.

>
> Avi
