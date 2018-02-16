Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757521AbeBPJDt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:03:49 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37466 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757437AbeBPJDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:03:47 -0500
X-Google-Smtp-Source: AH8x224bwRidI1J2N4JTPS5yvPThKTpfoGlnwit8jImSYRxq4YNOOjXAfzeoEqGtLtrcLveY/kC6E7boLIgEbs0ySaI=
MIME-Version: 1.0
In-Reply-To: <20180215153110.zq2zosepbxmpa3kb@verge.net.au>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-3-git-send-email-jacopo+renesas@jmondi.org> <20180215153110.zq2zosepbxmpa3kb@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2018 10:03:45 +0100
X-Google-Sender-Auth: c9OQImZoAGda03Y0UOgBkVqDeIA
Message-ID: <CAMuHMdUJ8p99MF4sh5OGHbKc-Pz-fhpTx=gr1UvhYLTWHn53DA@mail.gmail.com>
Subject: Re: [PATCH 02/15] clk: renesas: cpg-msr: Add support for R-Car M3-N
To: Simon Horman <horms@verge.net.au>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Thu, Feb 15, 2018 at 4:31 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Feb 13, 2018 at 10:45:49AM +0100, Jacopo Mondi wrote:
>> Initial support for R-Car M3-N (r8a77965), including core and module
>> clocks.
>>
>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> ---
>>  .../devicetree/bindings/clock/renesas,cpg-mssr.txt |   1 +
>>  drivers/clk/renesas/Kconfig                        |   5 +
>>  drivers/clk/renesas/Makefile                       |   1 +
>>  drivers/clk/renesas/r8a77965-cpg-mssr.c            | 333 +++++++++++++++++++++
>>  drivers/clk/renesas/renesas-cpg-mssr.c             |   6 +
>>  drivers/clk/renesas/renesas-cpg-mssr.h             |   1 +
>>  include/dt-bindings/clock/r8a77965-cpg-mssr.h      |  62 ++++
>>  7 files changed, 409 insertions(+)
>>  create mode 100644 drivers/clk/renesas/r8a77965-cpg-mssr.c
>>  create mode 100644 include/dt-bindings/clock/r8a77965-cpg-mssr.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
>> index f1890d0..246ab63 100644
>> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
>> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
>> @@ -22,6 +22,7 @@ Required Properties:
>>        - "renesas,r8a7794-cpg-mssr" for the r8a7794 SoC (R-Car E2)
>>        - "renesas,r8a7795-cpg-mssr" for the r8a7795 SoC (R-Car H3)
>>        - "renesas,r8a7796-cpg-mssr" for the r8a7796 SoC (R-Car M3-W)
>> +      - "renesas,r8a77965-cpg-mssr" for the r8a77965 SoC (R-Car M3-N)
>>        - "renesas,r8a77970-cpg-mssr" for the r8a77970 SoC (R-Car V3M)
>>        - "renesas,r8a77995-cpg-mssr" for the r8a77995 SoC (R-Car D3)
>>
>
> Its up to Geert, but would it be better if the bindings documentation
> and driver changes where in separate patches?

I don't care that much anymore.
It used to be a good idea when the bindings header went in separately,
as it was a dependency for both driver and DTS. But now we use hardcoded
constants in the first version of the DTS, so it doesn't matter anymore.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
