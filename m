Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeBPFhq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 00:37:46 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:52856 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752727AbeBPFho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 00:37:44 -0500
X-Google-Smtp-Source: AH8x227MgXm7af6fqN52VuDKDt9t7DmX3jKVptR2wIFmB6GtP1dnLzJtleJw2POGhMXx/K0h36V+6A==
MIME-Version: 1.0
In-Reply-To: <CAGb2v67WeUPx2X0aJev0ezu5aO6TYsZMuxM2njictxPHRePPYA@mail.gmail.com>
References: <20180117084654.8234-1-wens@csie.org> <CAGb2v67WeUPx2X0aJev0ezu5aO6TYsZMuxM2njictxPHRePPYA@mail.gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Fri, 16 Feb 2018 13:37:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v64STu=qsWO2aZqqngVjqpN94hwt=ASgA-8C499Gkkh47w@mail.gmail.com>
Message-ID: <CAGb2v64STu=qsWO2aZqqngVjqpN94hwt=ASgA-8C499Gkkh47w@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] ARM: sun9i: SMP and CPU hotplug support
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 4:15 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi Nicolas, Dave,
>
> On Wed, Jan 17, 2018 at 4:46 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>> This is v4 of my sun9i SMP/hotplug support series which was started
>> over two years ago [1]. We've tried to implement PSCI for both the A80
>> and A83T. Results were not promising. The issue is that these two chips
>> have a broken security extensions implementation. If a specific bit is
>> not burned in its e-fuse, most if not all security protections don't
>> work [2]. Even worse, non-secure access to the GIC become secure. This
>> requires a crazy workaround in the GIC driver which probably doesn't work
>> in all cases [3].
>>
>> Version 3 completely did away with the MCPM framework, instead just
>> implementing a set of smp_ops. Most of the code from the previous
>> version was reused, so the structure still has some traces of MCPM.
>> As our hardware has CCI-400, we still need some sort of MMU/cache
>> disabled trampoline code to enable cache coherency. Code for this
>> was adapted from the MCPM framework. This and the entry code are done
>> in inline assembly. Most of the other sunxi-specific code is derived
>> from Allwinner code and documentation, with some references to the
>> other MCPM implementations, as well as the Cortex's Technical Reference
>> Manuals for the power sequencing stuff.
>>
>> In version 4, all traces of MCPM have been removed, except in the
>> comments for atttributing code sources. Thumb2 mode is also fixed.
>> It failed due to an unaligned word access.
>
> Any more comments on this series? Or is it OK for you guys now that
> there are no traces of MCPM? :)
>
> We'll merge this series later this week for 4.17 if nothing else.

Merged for 4.17.

Thanks
