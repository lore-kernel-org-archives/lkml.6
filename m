Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094B7C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CCF2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIR3XLkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfASWwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:52:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41742 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfASWwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 17:52:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so10081606qkj.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 14:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=of6Twt2oMsj6inFLiIX6J/DxmOcSjNQvuU8+OGt+gTM=;
        b=FIR3XLklnrFmqvWGV+dIfwo+rYQKEkfkAdJ0swQfTGSPX3iZ2d+SgdL+8mc8AWuyHL
         MyTbtTpBZ2cR0b8+dEZOiGwyB5mn92tcHsg/St6gfBbCzUC0zE13RGV07Tx/6QyOMm1v
         biogl2CwWEl9gkFweEkWhGCV2rV+aedYnR/u7bi1FXCnP2rNgEukx1wHKeNTpCThRJkb
         rLJCMz65XWsh6GRyiLVKAT1mXXlfWW3cNPsZjZId3AW10y2sycZNMC3X2PrQwPaal1J8
         gunue7spp0IWVXiOcvkDHO57+cmS8vgw8qBVJqYvSJF86TNBlLXJ8oapUjTgSI/Wyylq
         gClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=of6Twt2oMsj6inFLiIX6J/DxmOcSjNQvuU8+OGt+gTM=;
        b=JBD/+xwg6LlUiGq6xFv7tjp6S8ylZgzHFSv8E9n6bqvQ0qEpfTsac4CYZ5naWLMV6+
         IW9Le8AE/QMxuayrewwcwu/6C8f8DwUCvfOguzw1oTNSd5eBbHn6JM4AFyPv4quFtnZb
         wlH53+Tdwyv3wiUdreaWIHb447BxD+BwRcuSbV06azL6xoelUjMqZXs5bGObW7VZdTST
         jST6QXBrF2Fau1GPbNeJ5ReDjJ3j4T3ohl8ljBAwIjrP/AML+yc7YscIr/lnhJvKkqOA
         bjGr42QCmd9ueQ5IJzZOXahZdPmN4VrmozCSd7UcgWJdlvTwNiGNDIt8CCrRERAUk69A
         CGDA==
X-Gm-Message-State: AJcUukdDLBhzg4rG1V++LaLzYoJJeqZVqDon3gF5PIqZwQH3/eDoabY7
        BD3MftIqmvfB4IUNPVHS5JxqtprcCko=
X-Google-Smtp-Source: ALg8bN66Esabej+8hipI7VSuj/0w2TjIqbR/ItFStyC3vtAtB5+XN16D3jfXQgyiUgTC/9OiijPEBQ==
X-Received: by 2002:a37:2c02:: with SMTP id s2mr19924081qkh.59.1547938338696;
        Sat, 19 Jan 2019 14:52:18 -0800 (PST)
Received: from localhost.localdomain ([23.233.244.16])
        by smtp.gmail.com with ESMTPSA id r56sm61146714qtj.30.2019.01.19.14.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 14:52:18 -0800 (PST)
From:   Antoine Robertson <antoinerbrtsn@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Antoine Robertson <antoinerbrtsn@gmail.com>
Subject: [PATCH v2] tty: moxa: Fix coding style issues
Date:   Sat, 19 Jan 2019 17:52:05 -0500
Message-Id: <20190119225205.11179-1-antoinerbrtsn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style issues

Signed-off-by: Antoine Robertson <antoinerbrtsn@gmail.com>
---
 drivers/tty/moxa.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 3a1a5e0ee93f..9b6dcb4f7905 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -42,7 +42,7 @@
 #include <linux/slab.h>
 #include <linux/ratelimit.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/uaccess.h>
 
 #include "moxa.h"
@@ -74,8 +74,7 @@ enum {
 	MOXA_BOARD_CP204J,
 };
 
-static char *moxa_brdname[] =
-{
+static const char * const moxa_brdname[] = {
 	"C218 Turbo PCI series",
 	"C218 Turbo ISA series",
 	"C320 Turbo PCI series",
@@ -1159,9 +1158,8 @@ static int moxa_open(struct tty_struct *tty, struct file *filp)
 	int port;
 
 	port = tty->index;
-	if (port == MAX_PORTS) {
+	if (port == MAX_PORTS)
 		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
-	}
 	if (mutex_lock_interruptible(&moxa_openlock))
 		return -ERESTARTSYS;
 	brd = &moxa_boards[port / MAX_PORTS_PER_BOARD];
@@ -1357,9 +1355,9 @@ static void moxa_new_dcdstate(struct moxa_port *p, u8 dcd)
         	spin_unlock_irqrestore(&p->port.lock, flags);
 		if (!dcd)
 			tty_port_tty_hangup(&p->port, true);
-	}
-	else
+	} else {
 		spin_unlock_irqrestore(&p->port.lock, flags);
+	}
 }
 
 static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
@@ -1625,10 +1623,10 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
  *      Syntax:
  *      void MoxaPortFlushData(int port, int mode);
  *           int port           : port number (0 - 127)
- *           int mode    
- *                      0       : flush the Rx buffer 
- *                      1       : flush the Tx buffer 
- *                      2       : flush the Rx and Tx buffer 
+ *           int mode
+ *                      0       : flush the Rx buffer
+ *                      1       : flush the Tx buffer
+ *                      2       : flush the Rx and Tx buffer
  *
  *
  *      Function 20:    Write data.
-- 
2.17.1

