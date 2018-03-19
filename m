Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELt9y2rIF4TSw2hVZSD4nmQ76IdqCBZ6uRcXJoSHB3Kc4AoyqlKo/VUZgslL9hwtbcyFzQLd
ARC-Seal: i=1; a=rsa-sha256; t=1521455378; cv=none;
        d=google.com; s=arc-20160816;
        b=oD2VeQREup42KKpn/7gR7b/D1SgnDN5T9ubUAq4cP2V1+RPY969DAf9w8/Sy8swRVm
         JZ2Ccr+fAoVZ7sewZ2AlH2CWgVCcQGPmOHss2Lh0dEWpDO49LZfp4qiVmPsMnnyklwm9
         NnrgbobI1LJBj5haI1mP3PZEVx1IViqn5V6sT9vRku9PWjW5Owq0uC9l/d9FO+wwTHYQ
         3tb0Fqul6uEwmJg889cT2gZxq4JZV74bmHEpXHBzIHIBpwiMTeUMrwfPZ+IrV6zBaUD3
         vno12aBeC7iYEYHsK/Oc1SdUweiNVSjyBUSdnbgXbq9dhWAb9pEbLZufnz5uf87cK+3E
         KhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=/uZvAWY8rZtHVyDSBAs6gkRcXm91JlUf70o05VOguGE=;
        b=yCmTGaGPFO6//+fqsUHfdj0ejslzswZZoOKyebZgq1imHUffsPHF+Pxw5ODfDwIoIR
         Ueax7Kr1dYvC8hLhEcvBzOkB9XRv25A2GUS5pe+PFufucF9WdoixkZ0xg565QBrPUyo8
         V8elrXzWZ5JF6z2bBxTRacArPnxw+lBACHag9mlsIdjINHyG9u6IrME0xPPx35BvdnQC
         bjBNP82EBPl7u2HyCZS3H7P8Y506rtdCbn4dQxaDV7xs5iQUep2QkN2LbNgJgysTjCEz
         HKyQ6MMYGbojgkdwrSvswSkyFaRh0lIEClvvDkf987SB5SS84Z0ogKay05snwCbzTmOJ
         oKHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180319100810.262396736@linutronix.de>
User-Agent: quilt/0.63-1
Date: Mon, 19 Mar 2018 11:04:42 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 "H. Peter Anvin" <hpa@zytor.com>, John Stultz <john.stultz@linaro.org>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Stephen Boyd <sboyd@codeaurora.org>, Colin Cross <ccross@android.com>,
 David Riley <davidriley@chromium.org>
Subject: [patch 01/3] time: Remove useless filenames in top level comments
References: <20180319100441.809595337@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=time--Remove-useless-filenames-in-top-level-comments.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595361595377894755?=
X-GMAIL-MSGID: =?utf-8?q?1595361595377894755?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove the pointless filenames in the top level comments. They have no
value at all and just occupy space. While at it tidy up some of the
comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hrtimer.h      |    2 --
 kernel/time/clockevents.c    |    2 --
 kernel/time/clocksource.c    |    5 -----
 kernel/time/hrtimer.c        |   14 +++-----------
 kernel/time/jiffies.c        |    2 --
 kernel/time/posix-clock.c    |    2 +-
 kernel/time/posix-timers.c   |    4 ----
 kernel/time/sched_clock.c    |    4 ++--
 kernel/time/tick-broadcast.c |    2 --
 kernel/time/tick-common.c    |    2 --
 kernel/time/tick-oneshot.c   |    2 --
 kernel/time/tick-sched.c     |    2 --
 kernel/time/time.c           |   12 ++++--------
 kernel/time/timecounter.c    |    5 +----
 kernel/time/timekeeping.c    |    7 ++-----
 kernel/time/timer.c          |    2 --
 kernel/time/timer_list.c     |    2 --
 17 files changed, 13 insertions(+), 58 deletions(-)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -1,6 +1,4 @@
 /*
- *  include/linux/hrtimer.h
- *
  *  hrtimers - High-resolution kernel timers
  *
  *   Copyright(C) 2005, Thomas Gleixner <tglx@linutronix.de>
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/clockevents.c
- *
  * This file contains functions which manage clock event devices.
  *
  * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/clocksource.c
- *
  * This file contains the functions which manage clocksource drivers.
  *
  * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
@@ -18,9 +16,6 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * TODO WishList:
- *   o Allow clocksource drivers to be unregistered
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1,21 +1,13 @@
 /*
- *  linux/kernel/hrtimer.c
- *
  *  Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  *  Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  *  Copyright(C) 2006-2007  Timesys Corp., Thomas Gleixner
  *
  *  High-resolution kernel timers
  *
- *  In contrast to the low-resolution timeout API implemented in
- *  kernel/timer.c, hrtimers provide finer resolution and accuracy
- *  depending on system configuration and capabilities.
- *
- *  These timers are currently used for:
- *   - itimers
- *   - POSIX timers
- *   - nanosleep
- *   - precise in-kernel timing
+ *  In contrast to the low-resolution timeout API, aka timer wheel,
+ *  hrtimers provide finer resolution and accuracy depending on system
+ *  configuration and capabilities.
  *
  *  Started by: Thomas Gleixner and Ingo Molnar
  *
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -1,6 +1,4 @@
 /***********************************************************************
-* linux/kernel/time/jiffies.c
-*
 * This file contains the jiffies based clocksource.
 *
 * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -1,5 +1,5 @@
 /*
- * posix-clock.c - support for dynamic clock devices
+ * Support for dynamic clock devices
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  *
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1,10 +1,6 @@
 /*
- * linux/kernel/posix-timers.c
- *
- *
  * 2002-10-15  Posix Clocks & timers
  *                           by George Anzinger george@mvista.com
- *
  *			     Copyright (C) 2002 2003 by MontaVista Software.
  *
  * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -1,6 +1,6 @@
 /*
- * sched_clock.c: Generic sched_clock() support, to extend low level
- *                hardware time counters to full 64-bit ns values.
+ * Generic sched_clock() support, to extend low level hardware time
+ * counters to full 64-bit ns values.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/tick-broadcast.c
- *
  * This file contains functions which emulate a local clock-event
  * device via a broadcast event source.
  *
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/tick-common.c
- *
  * This file contains the base functions to manage periodic tick
  * related events.
  *
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -1,6 +1,4 @@
 /*
- * linux/kernel/time/tick-oneshot.c
- *
  * This file contains functions which manage high resolution tick
  * related events.
  *
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1,6 +1,4 @@
 /*
- *  linux/kernel/time/tick-sched.c
- *
  *  Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  *  Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  *  Copyright(C) 2006-2007  Timesys Corp., Thomas Gleixner
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -1,14 +1,10 @@
 /*
- *  linux/kernel/time.c
- *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
- *  This file contains the interface functions for the various
- *  time related system calls: time, stime, gettimeofday, settimeofday,
- *			       adjtime
- */
-/*
- * Modification history kernel/time.c
+ *  This file contains the interface functions for the various time related
+ *  system calls: time, stime, gettimeofday, settimeofday, adjtime
+ *
+ * Modification history:
  *
  * 1993-09-02    Philip Gladstone
  *      Created file with time related functions from sched/core.c and adjtimex()
--- a/kernel/time/timecounter.c
+++ b/kernel/time/timecounter.c
@@ -1,8 +1,5 @@
 /*
- * linux/kernel/time/timecounter.c
- *
- * based on code that migrated away from
- * linux/kernel/time/clocksource.c
+ * based on code that migrated away from linux/kernel/time/clocksource.c
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1,11 +1,8 @@
 /*
- *  linux/kernel/time/timekeeping.c
- *
  *  Kernel timekeeping code and accessor functions
  *
- *  This code was moved from linux/kernel/timer.c.
- *  Please see that file for copyright and history logs.
- *
+ *  This code was moved from linux/kernel/timer.c. Please see that file for
+ *  copyright and history logs.
  */
 
 #include <linux/timekeeper_internal.h>
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1,6 +1,4 @@
 /*
- *  linux/kernel/timer.c
- *
  *  Kernel internal timers
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -1,6 +1,4 @@
 /*
- * kernel/time/timer_list.c
- *
  * List pending timers
  *
  * Copyright(C) 2006, Red Hat, Inc., Ingo Molnar
