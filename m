Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5F8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665CB204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfARKuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:50:05 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49057 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfARKuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:50:05 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkRio-0004JG-Sz; Fri, 18 Jan 2019 11:49:59 +0100
Date:   Fri, 18 Jan 2019 11:49:58 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     Shannon Nelson <shannon.nelson@oracle.com>,
        Zhu Yanjun <yanjun.zhu@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH] net: sun: cassini: Cleanup license conflict
Message-ID: <alpine.DEB.2.21.1901181147160.1647@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent addition of SPDX license identifiers to the files in
drivers/net/ethernet/sun created a licensing conflict.

The cassini driver files contain a proper license notice:

  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
  * published by the Free Software Foundation; either version 2 of the
  * License, or (at your option) any later version.

but the SPDX change added:

   SPDX-License-Identifier: GPL-2.0

So the file got tagged GPL v2 only while in fact it is licensed under GPL
v2 or later.

It's nice that people care about the SPDX tags, but they need to be more
careful about it. Not everything under (the) sun belongs to ...

Fix up the SPDX identifier and remove the boiler plate text as it is
redundant.

Fixes: c861ef83d771 ("sun: Add SPDX license tags to Sun network drivers")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Shannon Nelson <shannon.nelson@oracle.com>
Cc: Zhu Yanjun <yanjun.zhu@oracle.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/sun/cassini.c |   15 +--------------
 drivers/net/ethernet/sun/cassini.h |   15 +--------------
 2 files changed, 2 insertions(+), 28 deletions(-)

--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -1,22 +1,9 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
 /* cassini.c: Sun Microsystems Cassini(+) ethernet driver.
  *
  * Copyright (C) 2004 Sun Microsystems Inc.
  * Copyright (C) 2003 Adrian Sun (asun@darksunrising.com)
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * This driver uses the sungem driver (c) David Miller
  * (davem@redhat.com) as its basis.
  *
--- a/drivers/net/ethernet/sun/cassini.h
+++ b/drivers/net/ethernet/sun/cassini.h
@@ -1,23 +1,10 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0+ */
 /* $Id: cassini.h,v 1.16 2004/08/17 21:15:16 zaumen Exp $
  * cassini.h: Definitions for Sun Microsystems Cassini(+) ethernet driver.
  *
  * Copyright (C) 2004 Sun Microsystems Inc.
  * Copyright (c) 2003 Adrian Sun (asun@darksunrising.com)
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of the
- * License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  * vendor id: 0x108E (Sun Microsystems, Inc.)
  * device id: 0xabba (Cassini)
  * revision ids: 0x01 = Cassini
