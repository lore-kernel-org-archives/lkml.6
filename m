Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE30FC6786F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828732075D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=steffenvogel.de header.i=@steffenvogel.de header.b="W6SYfhFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828732075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=steffenvogel.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbeJ2L6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:58:31 -0400
Received: from nag.0l.de ([207.154.252.120]:44732 "EHLO nag.0l.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbeJ2L6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:58:31 -0400
From:   Steffen Vogel <post@steffenvogel.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RwaI2px3qcrWUiQYHGzq1U0xEI4oQ6wBNdr0kEkEepY=;
        b=W6SYfhFuvNX5to3wsDS2lj4YbnUq9QE1FIgMLIIpqq3Cr+9c4p4/RqdUeK9fgbUilf7KOV
        ADqgHJUC7YVd+GHzgZXXH66994GyT5YbdMdnj1+dhsUx16YPD1dUcQVrGBusW/49/QMLFP
        jXI14FBgfXIUSGpjfodFiVpm8v6+SAs5EQ49PKIDkWxtBoe56k6aPDqcUH1Tqxq5F5XwHM
        Y/xIn9QUKEcFlwkSjqIEvgs0arBfj0G2WN3b37aFrktq07bxX4Bg5Wbj4B+4O/PHRYwlHA
        ivYBj+UMX9TajXxMFd6RtJmeNm/p2xrvtsH0tnzj9RSQd98RTtadh6sj4bl+GA==
To:     linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>, Joe Perches <joe@perches.com>,
        Steffen Vogel <post@steffenvogel.de>
Subject: [PATCH v2 01/12] w1: add SPDX identifiers
Date:   Mon, 29 Oct 2018 04:03:31 +0100
Message-Id: <7443f63427a2f9b4afbba649e1ce393177a7eaa8.1540782140.git.post@steffenvogel.de>
In-Reply-To: <cover.1540782140.git.post@steffenvogel.de>
References: <cover.1540782140.git.post@steffenvogel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=steffenvogel.de;
        s=2017; t=1540782275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RwaI2px3qcrWUiQYHGzq1U0xEI4oQ6wBNdr0kEkEepY=;
        b=N96zrqF5/6h9TxMqSLvhgT3NuwZeiq9/ng/tIkMF+RdiCAERo+mmLDgiVBdbqnG3SSvH8l
        ii9WWrfePg99euK1xV/oVChr6K3/InYVJbYb77Z7SpJbnpccuz4zkE/a7mZydh9d6gEQ9U
        bPGH5FJUthw1I8EEfEqez2j/9U9we6/UWWewsq1PzUGNnPKoCjunqQr9XTV7rmqfN+TDpz
        Ythf9vEtfD7w9iJ2Bl9+r8tWzsgJve4RBcqRMTqNBDPKeyosDwkb92CWppZjINy/c8J32+
        pQ/kVXsPmuvBy69Nk8VMozwJqsMswzwKaSfh+2sLmFqV8O0F8+vX+L2DUhAILQ==
ARC-Seal: i=1; s=2017; d=steffenvogel.de; t=1540782275; a=rsa-sha256;
        cv=none;
        b=vcA6dtLzlhDDuHEWpd+3kctuyP4WBgv7NJRj0oXtqq9lcjxovPADi26+F+x/5cwJMGzuC6t2B6WqBjWcCnmma+Hdv/tYB2ngtcZniaOJgt9INwrXOceGR2gBqAR1O6/6z/lmzxk9NnIL1xWJYkGefSvbQoDxTaiSWuE9z07t/iiGaXppclXhTrq4441CwlB6qzUPQx0/0jKZCMRkXedhl2LYJqUqPGl0zvSwtYwZ9hh/JhK4Ft8+Y1kb3tETT1+9tLSPpbMtmwG5d9Y5RZ7H+Lze+8MaKiEcS3Sz5AyofdbvwUXnayVrLm5MY+aZ99J3jpwlSeGPAVqdy/3RVTGwlQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=stv0g@0l.de smtp.mailfrom=post@steffenvogel.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This satisfies a checkpatch warning and is the preferred
method for notating the license.

The SPDX identifier is a legally binding shorthand, which
can be used instead of the full boiler plate text.

Signed-off-by: Steffen Vogel <post@steffenvogel.de>
---
 drivers/w1/masters/ds1wm.c     |  5 +----
 drivers/w1/masters/ds2482.c    |  7 ++-----
 drivers/w1/masters/ds2490.c    | 16 +---------------
 drivers/w1/masters/matrox_w1.c | 16 +---------------
 drivers/w1/masters/mxc_w1.c    | 10 +---------
 drivers/w1/masters/omap_hdq.c  |  7 ++-----
 drivers/w1/masters/w1-gpio.c   |  5 +----
 drivers/w1/slaves/w1_ds2405.c  | 12 +-----------
 drivers/w1/slaves/w1_ds2406.c  |  4 +---
 drivers/w1/slaves/w1_ds2408.c  |  4 +---
 drivers/w1/slaves/w1_ds2413.c  |  4 +---
 drivers/w1/slaves/w1_ds2423.c  | 15 +--------------
 drivers/w1/slaves/w1_ds2431.c  |  4 +---
 drivers/w1/slaves/w1_ds2433.c  |  4 +---
 drivers/w1/slaves/w1_ds2438.c  |  4 +---
 drivers/w1/slaves/w1_ds2780.c  |  6 +-----
 drivers/w1/slaves/w1_ds2781.c  |  6 +-----
 drivers/w1/slaves/w1_ds2805.c  |  4 +---
 drivers/w1/slaves/w1_ds28e04.c |  4 +---
 drivers/w1/slaves/w1_ds28e17.c |  4 +---
 drivers/w1/slaves/w1_smem.c    | 16 +---------------
 drivers/w1/slaves/w1_therm.c   | 16 +---------------
 drivers/w1/w1.c                | 11 +----------
 drivers/w1/w1_family.c         | 11 +----------
 drivers/w1/w1_int.c            | 11 +----------
 drivers/w1/w1_internal.h       | 11 +----------
 drivers/w1/w1_io.c             | 11 +----------
 drivers/w1/w1_netlink.c        | 11 +----------
 drivers/w1/w1_netlink.h        | 11 +----------
 29 files changed, 31 insertions(+), 219 deletions(-)

diff --git a/drivers/w1/masters/ds1wm.c b/drivers/w1/masters/ds1wm.c
index f661695fb589..83a991a3e3bd 100644
--- a/drivers/w1/masters/ds1wm.c
+++ b/drivers/w1/masters/ds1wm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * 1-wire busmaster driver for DS1WM and ASICs with embedded DS1WMs
  * such as HP iPAQs (including h5xxx, h2200, and devices with ASIC3
@@ -5,10 +6,6 @@
  *
  * Copyright (c) 2004-2005, Szabolcs Gyurko <szabolcs.gyurko@tlt.hu>
  * Copyright (c) 2004-2007, Matt Reimer <mreimer@vpop.net>
- *
- * Use consistent with the GNU GPL is permitted,
- * provided that this copyright notice is
- * preserved in its entirety in all copies and derived works.
  */
 
 #include <linux/module.h>
diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index 8b5e598ffdb3..d9bb021eca7e 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -1,4 +1,5 @@
-/**
+// SPDX-License-Identifier: GPL-2.0
+/*
  * ds2482.c - provides i2c to w1-master bridge(s)
  * Copyright (C) 2005  Ben Gardner <bgardner@wabtec.com>
  *
@@ -7,10 +8,6 @@
  * There are two variations: -100 and -800, which have 1 or 8 1-wire ports.
  * The complete datasheet can be obtained from MAXIM's website at:
  *   http://www.maxim-ic.com/quick_view2.cfm/qv_pk/4382
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/module.h>
diff --git a/drivers/w1/masters/ds2490.c b/drivers/w1/masters/ds2490.c
index 0f4ecfcdb549..7bd9862ef337 100644
--- a/drivers/w1/masters/ds2490.c
+++ b/drivers/w1/masters/ds2490.c
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	ds2490.c  USB to one wire bridge
  *
  * Copyright (c) 2004 Evgeniy Polyakov <zbr@ioremap.net>
- *
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #include <linux/module.h>
diff --git a/drivers/w1/masters/matrox_w1.c b/drivers/w1/masters/matrox_w1.c
index d83d7c99d81d..be131c04ee63 100644
--- a/drivers/w1/masters/matrox_w1.c
+++ b/drivers/w1/masters/matrox_w1.c
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	matrox_w1.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <zbr@ioremap.net>
- *
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #include <asm/types.h>
diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index 50b46c4399ea..8168008e352e 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2005-2008 Freescale Semiconductor, Inc. All Rights Reserved.
  * Copyright 2008 Luotao Fu, kernel@pengutronix.de
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 83fc9aab34e8..39419a562388 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/w1/masters/omap_hdq.c
  *
  * Copyright (C) 2007,2012 Texas Instruments, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
  */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index 55e11bf8ebaf..110c04e5c9c4 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * w1-gpio - GPIO w1 bus master driver
  *
  * Copyright (C) 2007 Ville Syrjala <syrjala@sci.fi>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2
- * as published by the Free Software Foundation.
  */
 
 #include <linux/init.h>
diff --git a/drivers/w1/slaves/w1_ds2405.c b/drivers/w1/slaves/w1_ds2405.c
index 42a1e81060ce..713f3db87324 100644
--- a/drivers/w1/slaves/w1_ds2405.c
+++ b/drivers/w1/slaves/w1_ds2405.c
@@ -1,19 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	w1_ds2405.c
  *
  * Copyright (c) 2017 Maciej S. Szmigiero <mail@maciej.szmigiero.name>
  * Based on w1_therm.c copyright (c) 2004 Evgeniy Polyakov <zbr@ioremap.net>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the therms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/device.h>
diff --git a/drivers/w1/slaves/w1_ds2406.c b/drivers/w1/slaves/w1_ds2406.c
index fac266366ca3..7fdade7ee9b8 100644
--- a/drivers/w1/slaves/w1_ds2406.c
+++ b/drivers/w1/slaves/w1_ds2406.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * w1_ds2406.c - w1 family 12 (DS2406) driver
  * based on w1_ds2413.c by Mariusz Bialonczyk <manio@skyboo.net>
  *
  * Copyright (c) 2014 Scott Alfter <scott@alfter.us>
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2. See the file COPYING for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
index b535d5ec35b6..ce8ee403e719 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -1,10 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	w1_ds2408.c - w1 family 29 (DS2408) driver
  *
  * Copyright (c) 2010 Jean-Francois Dagenais <dagenaisj@sonatest.com>
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2. See the file COPYING for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/w1/slaves/w1_ds2413.c b/drivers/w1/slaves/w1_ds2413.c
index 492e3d010321..6325785ccd8a 100644
--- a/drivers/w1/slaves/w1_ds2413.c
+++ b/drivers/w1/slaves/w1_ds2413.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * w1_ds2413.c - w1 family 3a (DS2413) driver
  * based on w1_ds2408.c by Jean-Francois Dagenais <dagenaisj@sonatest.com>
  *
  * Copyright (c) 2013 Mariusz Bialonczyk <manio@skyboo.net>
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2. See the file COPYING for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/w1/slaves/w1_ds2423.c b/drivers/w1/slaves/w1_ds2423.c
index 050407c53b16..910c2f9b01a0 100644
--- a/drivers/w1/slaves/w1_ds2423.c
+++ b/drivers/w1/slaves/w1_ds2423.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	w1_ds2423.c
  *
@@ -6,20 +7,6 @@
  * This driver will read and write the value of 4 counters to w1_slave file in
  * sys filesystem.
  * Inspired by the w1_therm and w1_ds2431 drivers.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the therms of the GNU General Public License as published by
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/w1/slaves/w1_ds2431.c b/drivers/w1/slaves/w1_ds2431.c
index 5adecd3face1..6fa7dc822f57 100644
--- a/drivers/w1/slaves/w1_ds2431.c
+++ b/drivers/w1/slaves/w1_ds2431.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * w1_ds2431.c - w1 family 2d (DS2431) driver
  *
  * Copyright (c) 2008 Bernhard Weirich <bernhard.weirich@riedel.net>
  *
  * Heavily inspired by w1_DS2433 driver from Ben Gardner <bgardner@wabtec.com>
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2. See the file COPYING for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 75ad70cfe8e8..798371ffd92f 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -1,10 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	w1_ds2433.c - w1 family 23 (DS2433) driver
  *
  * Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2. See the file COPYING for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index bf641a191d07..8e1a2bbd6d0c 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -1,10 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * 1-Wire implementation for the ds2438 chip
  *
  * Copyright (c) 2017 Mariusz Bialonczyk <manio@skyboo.net>
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2. See the file COPYING for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/w1/slaves/w1_ds2780.c b/drivers/w1/slaves/w1_ds2780.c
index a60528131154..5b2babe2d57b 100644
--- a/drivers/w1/slaves/w1_ds2780.c
+++ b/drivers/w1/slaves/w1_ds2780.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * 1-Wire implementation for the ds2780 chip
  *
@@ -6,11 +7,6 @@
  * Author: Clifton Barnes <cabarnes@indesign-llc.com>
  *
  * Based on w1-ds2760 driver
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/w1/slaves/w1_ds2781.c b/drivers/w1/slaves/w1_ds2781.c
index 645be6e0b24a..3031b8b7ea85 100644
--- a/drivers/w1/slaves/w1_ds2781.c
+++ b/drivers/w1/slaves/w1_ds2781.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * 1-Wire implementation for the ds2781 chip
  *
  * Author: Renata Sayakhova <renata@oktetlabs.ru>
  *
  * Based on w1-ds2780 driver
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/w1/slaves/w1_ds2805.c b/drivers/w1/slaves/w1_ds2805.c
index 29348d283a65..cc2af1da77c3 100644
--- a/drivers/w1/slaves/w1_ds2805.c
+++ b/drivers/w1/slaves/w1_ds2805.c
@@ -1,10 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * w1_ds2805 - w1 family 0d (DS28E05) driver
  *
  * Copyright (c) 2016 Andrew Worsley amworsley@gmail.com
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2. See the file COPYING for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
index ec234b846eb3..641e69f47c3e 100644
--- a/drivers/w1/slaves/w1_ds28e04.c
+++ b/drivers/w1/slaves/w1_ds28e04.c
@@ -1,10 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	w1_ds28e04.c - w1 family 1C (DS28E04) driver
  *
  * Copyright (c) 2012 Markus Franke <franke.m@sebakmt.com>
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2. See the file COPYING for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/w1/slaves/w1_ds28e17.c b/drivers/w1/slaves/w1_ds28e17.c
index e78b63ea4daf..fa26a1f1a6e4 100644
--- a/drivers/w1/slaves/w1_ds28e17.c
+++ b/drivers/w1/slaves/w1_ds28e17.c
@@ -1,10 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	w1_ds28e17.c - w1 family 19 (DS28E17) driver
  *
  * Copyright (c) 2016 Jan Kandziora <jjj@gmx.de>
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2. See the file COPYING for more details.
  */
 
 #include <linux/crc16.h>
diff --git a/drivers/w1/slaves/w1_smem.c b/drivers/w1/slaves/w1_smem.c
index e556b0caff71..88cd893e6619 100644
--- a/drivers/w1/slaves/w1_smem.c
+++ b/drivers/w1/slaves/w1_smem.c
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	w1_smem.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <zbr@ioremap.net>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the smems of the GNU General Public License as published by
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #include <asm/types.h>
diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 3c350dfbcd0b..d741b56422a9 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	w1_therm.c
  *
  * Copyright (c) 2004 Evgeniy Polyakov <zbr@ioremap.net>
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the therms of the GNU General Public License as published by
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #include <asm/types.h>
diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 890c038c25f8..2c64655b603c 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2004 Evgeniy Polyakov <zbr@ioremap.net>
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
 
 #include <linux/delay.h>
diff --git a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
index f14ab0b340b5..ee90a6733472 100644
--- a/drivers/w1/w1_family.c
+++ b/drivers/w1/w1_family.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2004 Evgeniy Polyakov <zbr@ioremap.net>
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
 
 #include <linux/spinlock.h>
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 1c776178f598..507eea535d43 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2004 Evgeniy Polyakov <zbr@ioremap.net>
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
 
 #include <linux/kernel.h>
diff --git a/drivers/w1/w1_internal.h b/drivers/w1/w1_internal.h
index 1623e2fdccc7..977c68fac431 100644
--- a/drivers/w1/w1_internal.h
+++ b/drivers/w1/w1_internal.h
@@ -1,15 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2004 Evgeniy Polyakov <zbr@ioremap.net>
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
 
 #ifndef __W1_H
diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index 0364d3329c52..bc7d1f7a1222 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2004 Evgeniy Polyakov <zbr@ioremap.net>
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
 
 #include <asm/io.h>
diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index f2f099caeb77..0f2c6ed94b0f 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2003 Evgeniy Polyakov <zbr@ioremap.net>
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
 
 #include <linux/slab.h>
diff --git a/drivers/w1/w1_netlink.h b/drivers/w1/w1_netlink.h
index f876772c0fb4..08cbf08f3649 100644
--- a/drivers/w1/w1_netlink.h
+++ b/drivers/w1/w1_netlink.h
@@ -1,15 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (c) 2003 Evgeniy Polyakov <zbr@ioremap.net>
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
 
 #ifndef __W1_NETLINK_H
-- 
2.11.0

