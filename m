Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936142AbeEYOCd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:02:33 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:41972 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934496AbeEYOC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:02:28 -0400
X-Google-Smtp-Source: ADUXVKIuAHYynIHWaotT0KdTvwxq1gPj7vFjpIVGsl+5k2UC9qr2cSihPDPgOnbifUFk2q10WzMeXj/QVyfv1IHPG9c=
MIME-Version: 1.0
In-Reply-To: <e72ed1b1-1225-2782-e207-1af6af347810@kleine-koenig.org>
References: <20180502151108.GA25970@taurus.defre.kleine-koenig.org>
 <CAEB7QLBcLnv4JYphjxqESqofTbGyVWOd6QYKzfvdEZyDXH9LLQ@mail.gmail.com> <e72ed1b1-1225-2782-e207-1af6af347810@kleine-koenig.org>
From: Tomas Hlavacek <tomas.hlavacek@nic.cz>
Date: Fri, 25 May 2018 16:02:27 +0200
X-Google-Sender-Auth: DSFI1FWT4NuIhYoAfH0pQkOiUkM
Message-ID: <CAEB7QLA3hs+Wa_UD4tUXN1JB535dWJxtBLo_jveKkGkyKyGAJQ@mail.gmail.com>
Subject: Re: Turris Omnia firmware possibilities [Was: Re: led: hw-trigger,
 global brightness and multi-colored leds]
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4PE2bAH026568

On Fri, May 25, 2018 at 8:08 AM, Uwe Kleine-König <uwe@kleine-koenig.org> wrote:
> Hello Tomas,
>
> On 05/25/2018 12:08 AM, Tomas Hlavacek wrote:
>> But I also have good news: The FW of the MCU is also OSS (see the repo
>> in the link (1)). There is a method for flashing the MCU over I2C from
>> Linux and there is JTAG connector for the MCU, in case un-bricking is
>> needed. Therefore the LED protocol can be changed to be more sensible
>> and/or it is even possible to emulate some existing HW LED driver chip
>> in Omnia MCU and reuse OSS driver for that chip.
>
> Yeah, I noticed, but when we start replacing the firmware, we'd need to
> detect somehow when a machine has an old (or only different) firmware.
> That would imply a versioning scheme and a generic way to read out the
> firmware version. (CMD_GET_FW_VERSION_BOOT is already a start, but this
> doesn't help me if I find an unknown hash.) So a CMD_GET_FW_SOMETHING
> that yields a version string that is similar to the soname of a library
> would be great.

Oh yes, I was actually trying to push rewrite of the FW before the
production started, but it looked like a redundant work and I rather
implemented the mentioned rule-breaking LED driver. Another good news
is that all the produced boards had the same FW image and there were
no (official and automated) updates so far. I think that in this
situation it is possible to re-write the firmware it if proves to be
the best solution for LED driver and fixing other glitches perhaps.
The only thing we need regarding versions we need is to either check
that we are upgrading the original version and/or consent from the
user to rewrite any other version that we might encounter. (If there
are some user-customized boards around.)

>
> Talking about firmware, I wonder if there is firmware supported needed
> to solve
> https://wiki.debian.org/InstallingDebianOn/TurrisOmnia#Power_Management
> . Didn't look into that deeply yet and probably not high prio given that
> normally the Turris Omnia will just run 7x24h.

That's right, there is no power-down signalization from the CPU right
now. Btw. is there any mechanism in kernel to signal over arbitrary
bus (like I2C) that the host is shutting down and the power can/should
be cut to CPU in N seconds?

Tomas
