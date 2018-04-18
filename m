Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeDRKF3 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:05:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43519 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbeDRKF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:05:26 -0400
X-Google-Smtp-Source: AIpwx48wbqnf8zhg6MIoZUlvtRha843rzQxaUv4WE4TpYXZcZFK4K79ksE9sdmRfEwHvvBfU9GdOLw==
MIME-Version: 1.0
In-Reply-To: <20180418084535.lqdvjgcbxtnwqwri@flea>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-2-mylene.josserand@bootlin.com> <CAGb2v67VL70yqTF7xq4T3_9zA9T3UT2AV0gGarh1mqvC17r3Mg@mail.gmail.com>
 <20180417111737.6dous6eiuvjn33jf@flea> <CAGb2v67qvk=T7u7bOjVZ7q_qsjJuEOM6iarw7by42ga=EYuYDg@mail.gmail.com>
 <20180418084535.lqdvjgcbxtnwqwri@flea>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 18 Apr 2018 18:05:03 +0800
X-Gmail-Original-Message-ID: <CAGb2v64UCA825xC=wvBZ6n0K-c=vsOO15F7S6Bn=i9c=eAqYww@mail.gmail.com>
Message-ID: <CAGb2v64UCA825xC=wvBZ6n0K-c=vsOO15F7S6Bn=i9c=eAqYww@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] ARM: sunxi: smp: Move assembly code into a file
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Simon <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:ARM/SHMOBILE ARM..." <linux-renesas-soc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 4:45 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Apr 17, 2018 at 07:25:15PM +0800, Chen-Yu Tsai wrote:
>> On Tue, Apr 17, 2018 at 7:17 PM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>> > On Tue, Apr 17, 2018 at 11:12:41AM +0800, Chen-Yu Tsai wrote:
>> >> On Tue, Apr 17, 2018 at 5:50 AM, Mylène Josserand
>> >> <mylene.josserand@bootlin.com> wrote:
>> >> > Move the assembly code for cluster cache enabling and resuming
>> >> > into an assembly file instead of having it directly in C code.
>> >> >
>> >> > Remove the CFLAGS because we are using the ARM directive "arch"
>> >> > instead.
>> >> >
>> >> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
>> >> > ---
>> >> >  arch/arm/mach-sunxi/Makefile  |  4 +--
>> >> >  arch/arm/mach-sunxi/headsmp.S | 80 +++++++++++++++++++++++++++++++++++++++++
>> >> >  arch/arm/mach-sunxi/mc_smp.c  | 82 +++----------------------------------------
>> >> >  3 files changed, 85 insertions(+), 81 deletions(-)
>> >> >  create mode 100644 arch/arm/mach-sunxi/headsmp.S
>> >>
>> >> I'm still not convinced about this whole "move ASM to separate
>> >> file" thing, especially now that you aren't actually adding any
>> >> sunxi-specific ASM code beyond a simple function call.
>> >>
>> >> Could you drop this for now?
>> >
>> > I'd really like to have this merged actually. There's a significant
>> > readibility improvement, so even if there's no particular functional
>> > improvement, I'd still call it a win.
>>
>> What parts do you consider hard to read? The extra quotes? Trailing
>> newline? Or perhaps the __stringify bits?
>
> All of this, plus the clobbers and operands.

Ok. Lets move it then.

The kbuild reports indicate this still needs some work though.

ChenYu
