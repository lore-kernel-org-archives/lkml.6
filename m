Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932326AbeCLW37 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:29:59 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:46372 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeCLW35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:29:57 -0400
X-Google-Smtp-Source: AG47ELtVElpsDJ31lvTaxPwNP45C2MCDOU0b2o8EQ3qUNH9vRZtG3CSrVucFHg3TQtx5Jp6IgHS9zZ26lX3ma37FnAk=
MIME-Version: 1.0
In-Reply-To: <20180312194944.GA3979@amd>
References: <20180312194715.GA3992@amd> <20180312194944.GA3979@amd>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Mar 2018 23:29:56 +0100
X-Google-Sender-Auth: PodgB2yuQgunHudu6N7wh4ZoVC0
Message-ID: <CAJZ5v0gWd7OCy+P41CFWJ1E9Tzw++Ok=YmjQwLk+iSZutBzphA@mail.gmail.com>
Subject: Re: linux-next on thinkpad x60: full battery is indicated as battery
 error in mate
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Reichel <sre@kernel.org>, Ognjen Galic <smclt30p@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 8:49 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2018-03-12 20:47:15, Pavel Machek wrote:
>> Hi!
>>
>> Did something change recently with battery reporting?

Yes, it did, and specifically for Thinkpads.

>> Fully charged
>> battery shows as empty battery with red "x" in Mate desktop. After
>> reboot to recent mainline problem goes away. Tooltip says "battery
>> waiting to charge".
>>
>> /proc/acpi/battery/BAT0/state looks ok:
>> present:                 yes
>> capacity state:          ok
>> charging state:          charged
>> present rate:            0 mW
>> remaining capacity:      41240 mWh
>> present voltage:         16495 mV
>>
>> Linux amd 4.16.0-rc3-next-20180302 #30 SMP Fri Mar 2 10:28:44 CET 2018
>> i686 GNU/Linux
>> pavel@amd:~$ cat /sys/class/power_supply/BAT0/status
>> Not charging
>
> Reboot to mainline:
>
> pavel@amd:~$ uname -a
> Linux amd 4.16.0-rc4+ #509 SMP Thu Mar 8 15:28:06 CET 2018 i686
> GNU/Linux
> pavel@amd:~$ cat /sys/class/power_supply/BAT0/status
> Unknown
>
> Mate shows it as "laptop battery is fully charged".
>
>> Thinkpad X60.

Please try to revert commits fa93854f7a7e..a20136a67a99 from
linux-next and see if that helps.
