Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AG47ELtcfrbG8MhpMJvQ9iPl1UzLJnm5/c2MDRAmXSRey4EwvTWEt5cPZs4UFSgGQvhTTKVTQVeb
ARC-Seal: i=1; a=rsa-sha256; t=1521455378; cv=none;
        d=google.com; s=arc-20160816;
        b=vGp6Q1F4LO6TXfbh9rsvbZh0+CR+VLcJZkZIvdG3isjKaC3bOrMDkp70eYjeU+63BJ
         T9E/nabdkIr50+B8XQ+Tz6rLqHqEijvMfVh6/EnCGYf0OztCb6jASIB73Mwvr5sDLZ/7
         xkZdK4KjTGOAavV9dnXGEnEYrIw7NC4bJqO0LDHKJNTNLG1CzgyiIaFplaqpWOb+Qrqe
         jF4nNjmvNIgYY/S+onp0b8TJny8Br/hTXZBZFo/Kn9d4ongPGlM33we8dX77U6SWy+0f
         GEXWXxHMLkAn4ZMaXgOturu3ZSEAXzOt+S1qzAkXzqHswUluCARLJ+AEhkjft1vtI5q7
         bX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=QADyL92OODjInJUOZT2RvTMwa6OuktScqjROihv/+4w=;
        b=0maBjYKNss/ofxEh2RL0c3yy7jgVAuh3aAeiPnYFeG/3+NWc5UNxG9iN6ke25gJWXM
         Cfbvc4JA9DxGkc/6hlt0rQ3Us5VN3k4m2okR1cmfzNBB+86kzEExnKbMsyzHl5y7pEvJ
         g+L5s4KsrETJocTcv7TO8BNSvwcVJuyVkPAFqCnuZ7sDxQTaE5ARtB9JA7aks1ulyBXz
         DZqthWH/n7EaLbUx6rveDm5r3BoCVrHQsVq2wpkdeEG67OqbOyv3pRMNpYhOLAS59xND
         PnU7q9fGizDpV3Kf9jWLUIUKyTyYo7Pu96sqB9xTQ6db/5bCeCybsFU1WPNq9AsaFwIx
         9wTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180319100810.428470014@linutronix.de>
User-Agent: quilt/0.63-1
Date: Mon, 19 Mar 2018 11:04:44 +0100
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
Subject: [patch 03/3] time: Remove license boilerplates and sloppy references
References: <20180319100441.809595337@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=time--Remove-license-boilerplates-and-sloppy-references.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595361594861917893?=
X-GMAIL-MSGID: =?utf-8?q?1595361594861917893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that the SPDX tag is in all time(r) core files, that identifies the
license in a specific and legally-defined manner.  So the extra GPL text
wording can be removed as it is no longer needed at all.
    
This is done on a quest to remove the 700+ different ways that files in the
kernel describe the GPL license text.  And there's unneeded stuff like the
address (sometimes incorrect) for the FSF or other entities which is never
needed.
    
No copyright headers or other non-license-description text was removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hrtimer.h         |    2 --
 kernel/time/alarmtimer.c        |    4 ----
 kernel/time/clockevents.c       |    3 ---
 kernel/time/clocksource.c       |   14 --------------
 kernel/time/hrtimer.c           |    2 --
 kernel/time/jiffies.c           |   25 +++++--------------------
 kernel/time/posix-clock.c       |   14 --------------
 kernel/time/posix-stubs.c       |    4 ----
 kernel/time/posix-timers.c      |   20 +-------------------
 kernel/time/sched_clock.c       |    4 ----
 kernel/time/test_udelay.c       |    9 ---------
 kernel/time/tick-broadcast.c    |    3 ---
 kernel/time/tick-common.c       |    3 ---
 kernel/time/tick-oneshot.c      |    3 ---
 kernel/time/tick-sched.c        |    2 --
 kernel/time/timeconv.c          |   17 -----------------
 kernel/time/timecounter.c       |   10 ----------
 kernel/time/timekeeping_debug.c |   10 ----------
 kernel/time/timer_list.c        |    4 ----
 19 files changed, 6 insertions(+), 147 deletions(-)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -8,8 +8,6 @@
  *  data type definitions, declarations, prototypes
  *
  *  Started by: Thomas Gleixner and Ingo Molnar
- *
- *  For licencing details see kernel-base/COPYING
  */
 #ifndef _LINUX_HRTIMER_H
 #define _LINUX_HRTIMER_H
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -11,10 +11,6 @@
  * Copyright (C) 2010 IBM Corperation
  *
  * Author: John Stultz <john.stultz@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/time.h>
 #include <linux/hrtimer.h>
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -5,9 +5,6 @@
  * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  * Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  * Copyright(C) 2006-2007, Timesys Corp., Thomas Gleixner
- *
- * This code is licenced under the GPL version 2. For details see
- * kernel-base/COPYING.
  */
 
 #include <linux/clockchips.h>
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -3,20 +3,6 @@
  * This file contains the functions which manage clocksource drivers.
  *
  * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -20,8 +20,6 @@
  *
  *	George Anzinger, Andrew Morton, Steven Rostedt, Roman Zippel
  *	et. al.
- *
- *  For licencing details see kernel-base/COPYING
  */
 
 #include <linux/cpu.h>
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -1,24 +1,9 @@
 // SPDX-License-Identifier: GPL2.0+
-/***********************************************************************
-* This file contains the jiffies based clocksource.
-*
-* Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
-*
-* This program is free software; you can redistribute it and/or modify
-* it under the terms of the GNU General Public License as published by
-* the Free Software Foundation; either version 2 of the License, or
-* (at your option) any later version.
-*
-* This program is distributed in the hope that it will be useful,
-* but WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-* GNU General Public License for more details.
-*
-* You should have received a copy of the GNU General Public License
-* along with this program; if not, write to the Free Software
-* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*
-************************************************************************/
+/*
+ * This file contains the jiffies based clocksource.
+ *
+ * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
+ */
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -3,20 +3,6 @@
  * Support for dynamic clock devices
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/device.h>
 #include <linux/export.h>
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -4,10 +4,6 @@
  *
  * Created by:  Nicolas Pitre, July 2016
  * Copyright:   (C) 2016 Linaro Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/linkage.h>
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -7,25 +7,7 @@
  * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
  *			     Copyright (C) 2004 Boris Hu
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
- * General Public License for more details.
-
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * MontaVista Software | 1237 East Arques Avenue | Sunnyvale | CA 94085 | USA
- */
-
-/* These are all the functions necessary to implement
- * POSIX clocks & timers
+ * These are all the functions necessary to implement POSIX clocks & timers
  */
 #include <linux/mm.h>
 #include <linux/interrupt.h>
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -2,10 +2,6 @@
 /*
  * Generic sched_clock() support, to extend low level hardware time
  * counters to full 64-bit ns values.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/clocksource.h>
 #include <linux/init.h>
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -8,15 +8,6 @@
  * Specifying usecs of 0 or negative values will run multiples tests.
  *
  * Copyright (C) 2014 Google, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/debugfs.h>
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -6,9 +6,6 @@
  * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  * Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  * Copyright(C) 2006-2007, Timesys Corp., Thomas Gleixner
- *
- * This code is licenced under the GPL version 2. For details see
- * kernel-base/COPYING.
  */
 #include <linux/cpu.h>
 #include <linux/err.h>
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -6,9 +6,6 @@
  * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  * Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  * Copyright(C) 2006-2007, Timesys Corp., Thomas Gleixner
- *
- * This code is licenced under the GPL version 2. For details see
- * kernel-base/COPYING.
  */
 #include <linux/cpu.h>
 #include <linux/err.h>
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -6,9 +6,6 @@
  * Copyright(C) 2005-2006, Thomas Gleixner <tglx@linutronix.de>
  * Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  * Copyright(C) 2006-2007, Timesys Corp., Thomas Gleixner
- *
- * This code is licenced under the GPL version 2. For details see
- * kernel-base/COPYING.
  */
 #include <linux/cpu.h>
 #include <linux/err.h>
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -7,8 +7,6 @@
  *  No idle tick implementation for low and high resolution timers
  *
  *  Started by: Thomas Gleixner and Ingo Molnar
- *
- *  Distribute under GPLv2.
  */
 #include <linux/cpu.h>
 #include <linux/err.h>
--- a/kernel/time/timeconv.c
+++ b/kernel/time/timeconv.c
@@ -4,23 +4,6 @@
  * This file is part of the GNU C Library.
  * Contributed by Paul Eggert (eggert@twinsun.com).
  *
- * The GNU C Library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Library General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * The GNU C Library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Library General Public License for more details.
- *
- * You should have received a copy of the GNU Library General Public
- * License along with the GNU C Library; see the file COPYING.LIB.  If not,
- * write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 02111-1307, USA.
- */
-
-/*
  * Converts the calendar time to broken-down time representation
  * Based on code from glibc-2.6
  *
--- a/kernel/time/timecounter.c
+++ b/kernel/time/timecounter.c
@@ -1,16 +1,6 @@
 // SPDX-License-Identifier: GPL2.0+
 /*
  * based on code that migrated away from linux/kernel/time/clocksource.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/export.h>
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -3,16 +3,6 @@
  * debugfs file to track time spent in suspend
  *
  * Copyright (c) 2011, Google, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 
 #include <linux/debugfs.h>
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -3,10 +3,6 @@
  * List pending timers
  *
  * Copyright(C) 2006, Red Hat, Inc., Ingo Molnar
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/proc_fs.h>
