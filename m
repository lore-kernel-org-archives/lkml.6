Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754337AbeDBVFe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:05:34 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38432 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeDBVFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:05:32 -0400
X-Google-Smtp-Source: AIpwx4+9w3hO4r4y5KIfc6TrzCFnLfU3wAdNSVEFxHyaNYEEMu1kX/vLijVN4hjUnVT6D4HXVI5niA==
Date: Mon, 2 Apr 2018 14:05:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Sony Vaio VGN-CS31S touch sensor buttons breaking touchpad
Message-ID: <20180402210529.GA62080@dtor-ws>
References: <201804012321.56423.linux@rainbow-software.org>
 <201804022239.59370.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201804022239.59370.linux@rainbow-software.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 10:39:59PM +0200, Ondrej Zary wrote:
> On Sunday 01 April 2018 23:21:55 Ondrej Zary wrote:
> > Hello,
> > I got a Sony Vaio VGN-CS31S laptop with Synaptics touchpad that exhibits
> > weird behavior. It seems to work until I touch the "Touch Sensor Buttons"
> > bar above the keyboard - then the buttons start to act weirdly: click or
> > remain pressed (sometimes it breaks even without touching the bar).
> >
> > It seems to be a known problem with VGN-CS series:
> > https://bugs.launchpad.net/ubuntu/+source/xserver-xorg-input-synaptics/+bug
> >/774877 https://wiki.freegeekvancouver.org/article/Laptop_Troubleshooting
> > (mentions nasty partial workaround: psmouse.resetafter=1)
> >
> > Many models of the VGN-CS series have the Touch Sensor Buttons:
> > ftp://124.40.41.224/PUB/MANUALS/SWT/Z009/Z009690111.PDF
> >
> > From the hardware side (can be found in MBX-196 Quanta GD2 schematic), the
> > touch bar is a separate PS/2 device connected to third PS/2 port of the EC
> > (Embedded Controller) WPC775L. The touchpad is on the 1st PS/2 port, 2nd
> > port is unused. However, the i8042 does not seem to support multiplexing,
> > the firmware probably combines the data internally somehow.
> 
> Good news: it supports multiplexing but i8042_nomux is set because of:
>                 /*
>                  * Most (all?) VAIOs do not have external PS/2 ports nor
>                  * they implement active multiplexing properly, and
>                  * MUX discovery usually messes up keyboard/touchpad.
>                  */
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
>                         DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
>                 },
> in drivers/input/serio/i8042-x86ia64io.h
> (How can this be modified to exclude VGN-CS series?)

I guess we'd need a whitelist for MUXes, because older VAIOs would
behave really really badly when one tried to probe for active
multiplexing...

If you enable MUX, does it survive suspend/resume?

Thanks.

-- 
Dmitry
