Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F634C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091D920652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091D920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966617AbeFSPWV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:22:21 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42681 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965599AbeFSPWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:22:19 -0400
Received: by mail-vk0-f67.google.com with SMTP id s187-v6so36449vke.9;
        Tue, 19 Jun 2018 08:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttpLxZC1KiR+QgbX3cdSBKAtZ5vW9fxtGC6X+qHpRGA=;
        b=cilqzxNMygWN0g5WtUtlcyjiosSCIw7NbRHCAOkfuESKARB8ufhDUqHJggEV+Ypf5L
         D6kHmhUeTW9zg5wtmMkEUr4J0rpoxPHKZ8Xoren7OJi7kEQlX6o4VQZ2htEbLE5V09Gw
         OpJYyyF/hpUYoWnBKnsZvhw+FFDFKK2bcz4yL+vyf0kj4cHJ2pQy7PtxGseBkez9LVEn
         r98QacGm6ZPc2RlGrFHXVqbg9vBULChdOpnW1TOOh5eXv1VoEXGkAm+6KqanLMETtne0
         ANRSjbxx5/QVQwQnYXBdyUCD2O3uQy4vjXEfrOHIMT6hFpzS9tVPryC4spZpRaLgpg89
         r1Bw==
X-Gm-Message-State: APt69E3UmmEYrE1M1RCNd+vLXD5ST8XBfFXydJZtWzWPbLULwmeu1nEC
        pTsWfGIz/B2JwBwFHaKkpeM789yKBqROAqGrrQg=
X-Google-Smtp-Source: ADUXVKLhHUazeadbvhUKS0pske0Xy9L/WCW5A7dP0+eSNVYAbk4NoIKXkbInbsOLRpo1sqwUiITFDKrk95fZkchN5l8=
X-Received: by 2002:a1f:8307:: with SMTP id f7-v6mr9837428vkd.3.1529421737795;
 Tue, 19 Jun 2018 08:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180619135518.8990-1-geert+renesas@glider.be>
 <20180619135518.8990-2-geert+renesas@glider.be> <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jun 2018 17:22:06 +0200
Message-ID: <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, Jun 19, 2018 at 4:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Jun 19, 2018 at 3:55 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Add a callback to inform a device that its wake-up setting has been
> > changed.  This allows a device to synchronize device configuration with
> > an external user action.
> >
> > E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
> > switch, the system suspend/resume procedure is:
> >   1. Configure PMIC for DDR backup mode (by software), which changes the
> >      role of the accessory power switch from a power to a wake-up
> >      switch,
> >   2. Switch accessory power switch off (manually), to prepare for system
> >      suspend,
> >   3. Suspend system (by software),
> >   4. Switch accessory power switch on (manually), to wake up the system.
> >
> > As step 2 involves a manual operation, step 1 cannot be combined
> > with step 3 and performed in the PMIC's suspend callback (unlike on
> > systems with a momentary power switch).
> >
> > Adding the new callback allows to move step 1 to the new callback, to be
> > performed in response to the user writing "enabled" to the PMIC's
> > "wakeup" virtual file in sysfs.
>
> I still don't quite understand this TBH.
>
> In particular, why do you want a write to "wakeup" trigger this
> instead of having a special sysfs attr for that exposed by your PMIC
> driver?

In v1 (https://patchwork.kernel.org/patch/9996567/), I had a
driver-specific "backup_mode" sysfs file.
In v2 and later of the driver series (https://lkml.org/lkml/2018/4/18/345),
I changed that to use the standard "wakeup" file in sysfs, in response to
a comment from Mark Brown.

> Writing "enabled" to "wakeup" for the PMIC should enable the PMIC
> itself to wake up the system, which isn't quite the case, or is it?

Actually the PMIC cannot wake up the system if backup mode is not enabled.
When suspending the system (PSCI suspend) without enabling backup mode
first, the system will just crash (which cannot be distinguished from being
suspended, as PSCI doesn't support any other wake-up sources anyway[*] ;-)
So in that sense writing "enabled" to the "wakeup" file does enable the
PMIC to wake up the system.

Do you still prefer a driver-specific sysfs file?
Thanks!

[*] Perhaps you remember my ill-received attempt to prevent the system from
    using PSCI system suspend when any other wake-up sources were enabled?
    ("[PATCH/RFC 0/6] PSCI: Fix non-PMIC wake-up if SYSTEM_SUSPEND cuts
     power", https://lkml.org/lkml/2017/2/20/566).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
