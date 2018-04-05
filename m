Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeDENoL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:44:11 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34145 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeDENoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:44:07 -0400
X-Google-Smtp-Source: AIpwx48ATevR4LjvFdvBLCXWGpzeY5qKbGW9/sXVj4Fr4m38++J7FUBAR4nI9fo8bXFEd8BywcDSj7Du/JvoqezZ66A=
MIME-Version: 1.0
In-Reply-To: <a4d84be0-e3d3-4e39-40f9-cae9006cb6ee@ti.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-13-git-send-email-david@lechnology.com> <CAMRc=MfQuqTK+mDT0Gawa6J-3d1z6djLutaHREKfVm+3hATEqQ@mail.gmail.com>
 <CAEG3pND6Cu0P_t3y_VM9Sm-GCb3yW0Pa8q4cRUOXYxa5=2nWUQ@mail.gmail.com> <a4d84be0-e3d3-4e39-40f9-cae9006cb6ee@ti.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 5 Apr 2018 15:44:06 +0200
Message-ID: <CAMRc=Mc228JAxxBXcObmokh2h-toojG8OHrmbunm_ORqbGWUnA@mail.gmail.com>
Subject: Re: [PATCH v5 12/44] clk: davinci: Add platform information for TI
 DA850 PSC
To: Sekhar Nori <nsekhar@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
        David Lechner <david@lechnology.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-05 15:09 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
> Hi Bartosz,
>
> On Friday 09 February 2018 10:18 PM, Michael Turquette wrote:
>> On Fri, Feb 9, 2018 at 8:22 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>> 2018-01-08 3:17 GMT+01:00 David Lechner <david@lechnology.com>:
>
>>> Hi David,
>>>
>>> I've been working on moving the genpd code from its own driver to the
>>> psc one. I couldn't get the system to boot though and problems
>>> happened very early in the boot sequence. I struggled to figure out
>>> what's happening, but eventually I noticed that psc uses
>>> CLK_OF_DECLARE() to initialize clocks. The functions registered this
>>> way are called very early in the boot sequence, way before
>>> late_initcall() in which the genpd framework is initialized. This of
>
> late_initcall() is too late for genpd to be initialized. As you may have
> seen with the latest set of patches, we have problems with timer
> initialization. After converting to platform devices, PSC and PLL clocks
> get initialized post time_init(). We are working that around using
> fixed-clocks, which hopefully will work (I still need to test many of
> the affected platforms).
>
> Can you please reply with the exact issue you faced with genpd framework
> initialization so we do have that on record.
>

The exact issue manifested itself in a NULL-pointer dereference panic
when I tried moving the genpd code I had initially implemented as a
separate platform driver to what I believe was v6 or v7 of David's
series (before the psc driver became a platform driver, when it was
still using CLK_OF_DECLARE()). When I had tested a simple conversion
of that version to a platform_driver, genpd worked fine.

I don't have the stack traces from these panics, but I recall some
debugfs functions being involved and the genpd late_initcalls are
related to debugfs. Looking at it now I don't see how exactly it could
fail though.

Best regards,
Bartosz
