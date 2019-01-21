Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FF3C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510EE2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXMWVx0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfAUWpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:45:49 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45705 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfAUWpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:45:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so13161002qka.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 14:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=of6Twt2oMsj6inFLiIX6J/DxmOcSjNQvuU8+OGt+gTM=;
        b=KXMWVx0vY4whYy/t+uSseKAP65uuIEX3bdenETXEzVHsi+5W3M6eVDOLdeFsaSWbAq
         Wpv27gSO50XoLjWyG6MLtuO0tcWCbYF2YY1njNAZwvTT/OyJlmYyf1+CCgVvq7REzXaS
         Au0I1XrGV4nPq2Kb7n32/kkxvMq/CdfgoR3/x+oakUpA5+DiirPF5JT8u7a2z7TpHl85
         PLUsGQkkUfaJ9ZA9vR3RijDl6zzpa+bDOYBCcvdglAxRBQqKxjCOBwM6YobKq9A4in8k
         YJ1yi4Gc4fyKapJ7ofwOh83VfIyM7h3wUBntzXEsxY9Tj+Di9WvtSZBYSyWGHy4BAYjg
         jVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=of6Twt2oMsj6inFLiIX6J/DxmOcSjNQvuU8+OGt+gTM=;
        b=RWrnXA/gl7lY1rBcHm3rFUMWBu+BM29xBa3+AzISp+F+CAHMRhlu+LEGsRsbX7kffm
         fSXnBM71rtIdJPTdGeZLgNQVHXQvlO01b5EuN/KhjH3aKlFtCGMqWzI9eBUjd58fh8/G
         /osPjgiPRqJFGtShEWTDEcIj7dKeakmpS6u7tslg7PFU9WHPcaMPcvs5MX7gNX0+Q4fv
         WHlQEf6gu4Ib3RAk3VQBzoXW6BITlo/1u1+vkDElseZoI5OTqD60v2CpuPCUInPYrCvE
         CFqg/LykGkdU0liEXIc4owtpqBB4CpruDgEmgShvgRO0fKK8u/dmBq3TLIbTGXI5vHnn
         Gotw==
X-Gm-Message-State: AJcUuke7ughHr/TpNSUjVCmZN7VAlr+9oeVIsiZROiKuHkWqrTO2wU/+
        tKr8DeyQJTJFScB4uPaKlqAtDhqKDZ4=
X-Google-Smtp-Source: ALg8bN4sBRIvU9PuSsykRH2Coll+Q/DZ/pC3N1DMxWQPU9omzYhSX/bBn/aBZsmWHGKzLO8v2+KbEw==
X-Received: by 2002:a37:6801:: with SMTP id d1mr25505803qkc.283.1548110747999;
        Mon, 21 Jan 2019 14:45:47 -0800 (PST)
Received: from localhost.localdomain ([23.233.244.16])
        by smtp.gmail.com with ESMTPSA id c48sm70715246qtd.9.2019.01.21.14.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 14:45:47 -0800 (PST)
From:   Antoine Robertson <antoinerbrtsn@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org,
        Antoine Robertson <antoinerbrtsn@gmail.com>
Subject: [PATCH v2] tty: moxa: Fix coding style issues
Date:   Mon, 21 Jan 2019 17:45:43 -0500
Message-Id: <20190121224543.5150-1-antoinerbrtsn@gmail.com>
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

