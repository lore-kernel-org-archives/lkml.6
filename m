Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754528AbeCGNpe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:45:34 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:35766 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754423AbeCGNov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:44:51 -0500
X-Google-Smtp-Source: AG47ELvKeokPpWFhnHpbFTXl+YjJKuwbhFOTrPaq6rr2+rKf2g4TBk3nXFg0CAY2LMZ6hgNQeJX6gs9CTg8rznCSPwM=
MIME-Version: 1.0
In-Reply-To: <20180306000832.GL4197@saruman>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
 <20170927151527.25570-4-prasannatsmkumar@gmail.com> <20180306000832.GL4197@saruman>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Wed, 7 Mar 2018 19:14:49 +0530
Message-ID: <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com>
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
To: James Hogan <jhogan@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Dominik Peklo <dom.peklo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thanks for reviewing this.

On 6 March 2018 at 05:38, James Hogan <jhogan@kernel.org> wrote:
> On Wed, Sep 27, 2017 at 08:45:26PM +0530, PrasannaKumar Muralidharan wrote:
>> Add initial Ingenic X1000 SoC support. Provide minimum necessary
>> information to boot kernel to an initramfs userspace.
>>
>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>> ---
>>  arch/mips/boot/dts/ingenic/x1000.dtsi | 93 +++++++++++++++++++++++++++++++++++
>>  arch/mips/jz4740/Kconfig              |  6 +++
>>  arch/mips/jz4740/time.c               |  2 +-
>>  3 files changed, 100 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/mips/boot/dts/ingenic/x1000.dtsi
>
> arch/mips/jz4780/setup.c, specifically get_board_mach_type() and
> get_system_type() will need updating too.

Missed it. Will make necessary changes.

> Does X1000 use a different PRID, or is it basically just a JZ4780 core
> with different SoC peripherals?

Yes X1000 does have a different PRID (PRID = 0x2ed1024f). X1000 has
single CPU core so it is definitely not JZ4780.

>> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
>> new file mode 100644
>> index 0000000..abbb9ec
>> --- /dev/null
>> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
>> @@ -0,0 +1,93 @@
>> +/*
>> + * Copyright (C) 2016 PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>
> (these will need updating to use SPDX identifiers if you respin)

Sure. Will take care while submitting next version.

>> +     cgu: jz4780-cgu@10000000 {
>
> not sure jz4780 is appropriate here.

No, it is not. Copy pasted from jz4780.dtsi but missed updating this.

>> +             compatible = "ingenic,x1000-cgu";
>> +             reg = <0x10000000 0x100>;
>> +
>> +             clocks = <&ext>, <&rtc>;
>> +             clock-names = "ext", "rtc";
>> +
>> +             #clock-cells = <1>;
>> +     };
>
> Cheers
> James

I used to get my code tested from Domink but I could not reach him for
quite some time. Before buying the development board myself I would
like to see if anyone can help me in testing. Do you have any contact
with Ingenic who can help in testing this?

Thanks,
PrasannaKumar
