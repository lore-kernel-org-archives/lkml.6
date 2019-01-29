Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E505C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E7C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762037;
	bh=5RP86Ww4c/RixVFhmUd+0P0F+WZVmxiX43vb8zLmB0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LZZdx1c3s2HNv1/Ou6cScmLvZvJXjjZ7JkcaUBKNDdZ9K8P/ns6s5V2JMy0Md0lLS
	 AaHMGxfWwcPk+PK/itXqRBs5yriUmJmnP5umvPnzVKwxUtmhNldVYETD1L4Ww7H4bY
	 fXiWVYiSOGrGzZIfe+6dl0g21lHwqCutzCoReSdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfA2Lkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:40:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbfA2Lkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:40:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FE720857;
        Tue, 29 Jan 2019 11:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762032;
        bh=5RP86Ww4c/RixVFhmUd+0P0F+WZVmxiX43vb8zLmB0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENRaIoyX/8vA4bYEvCSbbtyZihOGKvX64tTmB7flTjNF88WdJ6ZWY1FY/peDqJ0t0
         VWqHvmk8Spdy6Sk+MVfXk8NKmgPPG/xg+MPFDACMLO+sr7bIpb7CHAQwtSrW0gKOXa
         p3RA5qGa2IN+7tqq9ou0EStaBVpX5BaBdGMZCY/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Shannon Nelson <shannon.nelson@oracle.com>,
        Zhu Yanjun <yanjun.zhu@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Shannon Nelson <shannon.lee.nelson@gmail.com>
Subject: [PATCH 4.20 085/117] net: sun: cassini: Cleanup license conflict
Date:   Tue, 29 Jan 2019 12:35:36 +0100
Message-Id: <20190129113211.667227894@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 56cb4e5034998b5522a657957321ca64ca2ea0a0 upstream.

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
Acked-by: Shannon Nelson <shannon.lee.nelson@gmail.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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


