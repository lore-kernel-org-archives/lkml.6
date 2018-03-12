Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbeCLWf2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:35:28 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:55432 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeCLWf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:35:26 -0400
X-Google-Smtp-Source: AG47ELuW/G7FeeDGcBZlnIzf2qzO63DT0+aTR9MP5F4GE/ouKWzo5OCG49nsACjZW1SFcrIcoQAfaw==
Date: Mon, 12 Mar 2018 23:35:21 +0100
From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: linux-next on thinkpad x60: full battery is indicated as battery
 error in mate
Message-ID: <20180312223521.vzccevf6z7ik5ysf@thinkpad>
References: <20180312194715.GA3992@amd>
 <20180312194944.GA3979@amd>
 <CAJZ5v0gWd7OCy+P41CFWJ1E9Tzw++Ok=YmjQwLk+iSZutBzphA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gWd7OCy+P41CFWJ1E9Tzw++Ok=YmjQwLk+iSZutBzphA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 11:29:56PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 12, 2018 at 8:49 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Mon 2018-03-12 20:47:15, Pavel Machek wrote:
> >> Hi!
> >>
> >> Did something change recently with battery reporting?
> 
> Yes, it did, and specifically for Thinkpads.


> 
> >> Fully charged
> >> battery shows as empty battery with red "x" in Mate desktop. After
> >> reboot to recent mainline problem goes away. Tooltip says "battery
> >> waiting to charge".
> >>

For the MATE bug see:
https://github.com/mate-desktop/mate-power-manager/pull/251

The problem is in the new composite battery system in UPower, it
"merges" two external batteries into a single one for reporting. That
battery does not understand "Not Charging" inside the MATE Power
Manager. The above patch fixes that in MATE.

> >> /proc/acpi/battery/BAT0/state looks ok:
> >> present:                 yes
> >> capacity state:          ok
> >> charging state:          charged
> >> present rate:            0 mW
> >> remaining capacity:      41240 mWh
> >> present voltage:         16495 mV
> >>
> >> Linux amd 4.16.0-rc3-next-20180302 #30 SMP Fri Mar 2 10:28:44 CET 2018
> >> i686 GNU/Linux
> >> pavel@amd:~$ cat /sys/class/power_supply/BAT0/status
> >> Not charging
> >
> > Reboot to mainline:
> >
> > pavel@amd:~$ uname -a
> > Linux amd 4.16.0-rc4+ #509 SMP Thu Mar 8 15:28:06 CET 2018 i686
> > GNU/Linux
> > pavel@amd:~$ cat /sys/class/power_supply/BAT0/status
> > Unknown
> >
> > Mate shows it as "laptop battery is fully charged".
> >
> >> Thinkpad X60.
> 
> Please try to revert commits fa93854f7a7e..a20136a67a99 from
> linux-next and see if that helps.
