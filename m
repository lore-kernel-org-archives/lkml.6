Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 655BFC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0526A204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fA4OYevW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0526A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935368AbeFMLdA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:33:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44507 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935188AbeFMLc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:32:58 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so1260010pfk.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CXStFszA5EJ+fiscSQaTb6bZ4aiPyPz8h16IhbL+vSg=;
        b=fA4OYevWDrNWlMUG+/AdeAhs+dwcdFUnIkJgiTlQQzDPY1IqCXNUJ7xxUyVN7/P4NX
         BaJMKDMhVRkhW/z1LbgkQbPTeiZmukfmy3+PHjBG66hmMD04fVWMhGUobP0Ii6thnAPi
         9DnnGpAJbmbcLS+64CnK637m3pNK9tuDii3cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CXStFszA5EJ+fiscSQaTb6bZ4aiPyPz8h16IhbL+vSg=;
        b=HT7Ncpan916MeG0QdmvKjn3TfNMiKDXTehgzl79kfWV70kw8rfUXHTI0mP/8flGZcH
         pM8Wd6eh8/yskkbvYigltjFdI5pcocIRiTVqznbBYul8AKlk8fRCXUToEZ1TB7kiqx4Z
         FRlI3p6Bji7yPZPv8TUBxK4Q4kJj+lfwx/2xXxzEGtYQI3f9Uv5Y28Z25vHgoN1sm6zE
         WCSCI878w6tlxBJBR8MChd0xdCcisrIe469tMm0eYHdRUSmObFJVkDfShm9T+7AMzH5j
         0IR57Tyf7uXk7dQhzNc+PxJoRKaTgwTdlhBv79H3VH+ySz1D7q71UbqWj/zM7YnEAXTO
         RxAg==
X-Gm-Message-State: APt69E2Q+maFM3HdfZpNt7d6XGgno/k/tiE/aJVUejE2bpvhqLEv231V
        W1X90qewFqBHHlvhO/El1aRQ4A==
X-Google-Smtp-Source: ADUXVKLTiRW/N0ayNFW3Suq0KX0t2DkpL5loYrfnQmMJbl68CGC3+7rhP+/Uh5Dq/joFss6C94tJ6A==
X-Received: by 2002:a65:4c87:: with SMTP id m7-v6mr3863953pgt.364.1528889577733;
        Wed, 13 Jun 2018 04:32:57 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h8-v6sm2745370pgq.35.2018.06.13.04.32.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 04:32:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     tglx@linutronix.de, john.stultz@linaro.org,
        daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com,
        aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com,
        marc.zyngier@arm.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org,
        paulmck@linux.vnet.ibm.com, mlichvar@redhat.com,
        rdunlap@infradead.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de,
        linus.walleij@linaro.org, viresh.kumar@linaro.org,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        douly.fnst@cn.fujitsu.com, len.brown@intel.com,
        rajvi.jingar@intel.com, alexandre.belloni@bootlin.com,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 0/8] Add persistent clock support
Date:   Wed, 13 Jun 2018 19:32:27 +0800
Message-Id: <cover.1528878545.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We will meet below issues when compensating the suspend time for the timekeeping.

1. We have too many different ways of dealing with persistent timekeeping
across architectures, so it is hard for one driver to be compatible with
different architectures. For example, we should register register_persistent_clock()
on arm architecture, but we should set x86_platform.get_wallclock() on x86
architecture, and we should implement the read_persistent_clock64() on arm64
architecture and so on.

2. On some platforms (such as Spreadtrum platform), we registered the high
resolution timer as one clocksource to update the OS time, but the high
resolution timer will be stopped when system goes into suspend state.
So we use another one always-on timer (but low resolution) to calculate
the suspend time to compensate the OS time. Though we can register the
always-on timer as one clocksource, we need re-calculate the mult/shift
with one larger conversion range to calculate the suspend time and need
update the clock in case of running over the always-on timer. 

More duplicate code will be added if other platforms meet this case.

3. Now we have 3 sources that could be used to compensate the OS time:
Nonstop clocksource during suspend, persistent clock and rtc device,
which is complicated. Another hand is that the nonstop clocksource can
risk wrapping if the system suspend time is too long, so we need one
mechanism to wake up the system before the nonstop clocksource wrapping.

According to above issues, we can introduce one common persistent clock
framework to be compatible with different architectures, in future we will
remove the persistent clock implementation for each architecture. Also
this framework will implement common code to help drivers to register easily.
Moreover if we converted all SUSPEND_NONSTOP clocksource to register to
be one persistent clock, we can remove the SUSPEND_NONSTOP clocksource
accounting in timekeeping, which means we can only compensate the OS time
from persistent clock and RTC.

Will be appreciated for any comments. Thank you all.

Arnd posted some comments as below last time, but we did not get a general
consensus, so I post them again. Arnd said:

"I was planning to discuss this with Daniel and John during Linaro Connect,
but that didn't happen, so I'd like to bring up the bigger picture here again.

Today, we have a number of subsystem-type interfaces that deal with
time keeping in the wider sense (I might be missing some):
 - clock source
 - clock event
 - sched clock
 - real time clock
 - ptp clock
 - persistent clock

The first five have separate registration interfaces and may all refer
to different hardware blocks, or (more commonly) have some overlap
in the hardware. The fifth one is generalized by your series, without it
it's really architecture specific (as the other ones were one one point).

Are we happy with that structure in the long run? One of my earlier
comments on this series was that I thought it should be combined with
the clocksource registration, but upon talking to Baolin about it more,
I realized that this just follows the same structure that we have for the
others.

In theory, we could have a more abstract way of registering a clock
hardware that interfaces with any combination of the six subsystems
I mentioned above, with a superset of the subsystem specific structures
and a set of flags that indicate what a particular device is usable for.

Combining all six might be a bit too much (in particular rtc, though
it clearly overlaps the persistent-clk case), but what your general
ideas on where we should be heading? Is it worth reworking the
core kernel portion of the subsystems to simplify the individual
drivers?"

John also posted some important comments for this patch set, that I quite
agree with his points. John said:

"For context, these abstractions have grown out of the need for using
different hardware components for all of these. It was quite common
for x86 hardware to use the acpi_pm for clocksource, lapic/PIT for
clockevent, tsc for sched_clock and CMOS RTC for persistent clock.
While some of these could be backed by the same hardware, it wasn't
common. However, hardware with less restrictions have allowed in some
cases for these to be more unified, but I'm not sure if its particularly common.

Another part of the reason that we don't combine the above
abstractions, even when they are backed by the same hardware, is
because some of the fields used for freq conversion (mult/shift) have
different needs for the different types of accounting.

For instance, with a clocksource, we are very focused on avoiding
error to keep timekeeing accurate, thus we want to use as large a
shift (and thus mult) as possible (and do our shifting as late as
possible in our accounting). However, that then shrinks the amount of
time that can be accumulated in one go w/o causing an overflow.

Where as with sched_clock, we don't worry as much as about accuracy,
so we can use smaller shifts (and thus mults), and thus can go for
longer periods of time between accumulating without worrying.

Similarly for the persistent clock case we don't need need to worry as
much about accuracy, so we can can use smaller shifts, but we are not
in as much of a hot patch, so we can also"

Changes since RFC V1:
 - Move the alarmtimer starting into alarmtimer.c.
 - Export persistent_clock_start_alarmtimer().
 - Add one memeber to indicate if the alarmtimer was initialized.
 - Fix build issues.

Baolin Wang (8):
  time: Add persistent clock support
  clocksource: sprd: Add one persistent timer for Spreadtrum platform
  arm: time: Remove the persistent clock support for ARM architecture
  clocksource: arm_arch_timer: Register the persistent clock
  clocksource: timer-ti-32k: Register the persistent clock
  clocksource: time-pistachio: Register the persistent clock
  x86: tsc: Register the persistent clock
  time: timekeeping: Remove time compensating from nonstop clocksources

 arch/arm/include/asm/mach/time.h     |    4 -
 arch/arm/kernel/time.c               |   36 -------
 arch/arm/plat-omap/Kconfig           |    1 +
 arch/arm/plat-omap/counter_32k.c     |   44 ++------
 arch/x86/Kconfig                     |    1 +
 arch/x86/kernel/tsc.c                |   21 ++++
 drivers/clocksource/Kconfig          |    4 +
 drivers/clocksource/arm_arch_timer.c |   10 ++
 drivers/clocksource/tegra20_timer.c  |   12 ++-
 drivers/clocksource/time-pistachio.c |    3 +
 drivers/clocksource/timer-sprd.c     |   80 +++++++++++++++
 drivers/clocksource/timer-ti-32k.c   |    4 +
 include/linux/persistent_clock.h     |   23 +++++
 kernel/time/Kconfig                  |    4 +
 kernel/time/Makefile                 |    1 +
 kernel/time/alarmtimer.c             |    4 +
 kernel/time/persistent_clock.c       |  184 ++++++++++++++++++++++++++++++++++
 kernel/time/timekeeping.c            |   19 +---
 18 files changed, 360 insertions(+), 95 deletions(-)
 create mode 100644 include/linux/persistent_clock.h
 create mode 100644 kernel/time/persistent_clock.c

-- 
1.7.9.5

