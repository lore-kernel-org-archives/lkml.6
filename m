Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D360DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17A620866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd/c9TYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfAVWbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:31:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46331 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfAVWbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:31:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so169204qtm.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 14:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aqkwhvhtc1ZItWmnLr/PqWmKvFRVIVA2CkzxtMEZDQU=;
        b=Dd/c9TYyg9rmEtj1bpGK6gPMl08sq1EyXyO6B6BUI1Jbgy/4jh0gJxNdiZ8R4i+yR+
         ldRy3n3exXrCpGvebhdCm7d054SygNnB4s5QatO2aTRZuXb89fTK7tvyw8VmFkA6qJHb
         ej8bzLSY1l3q0Tg7lSKMdRsrGeyI6VgykFaEskdHbk3UDsiD7MFv5vk+lc+igaOaKfXH
         eOYGEMk3ntPxpmhbs+p81hVSZKxO6JiBNdKtLEkfK0q3GHqXDsGqFA+RDFo13wmUvppN
         rgUqKqk89DdY1nH8H6xcHaRi6XW+tT3FGrFxbbTGDWdnamG1g+tqdupmVbOCQ8o2kPZb
         WBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aqkwhvhtc1ZItWmnLr/PqWmKvFRVIVA2CkzxtMEZDQU=;
        b=EKxaaYfpEAEgPnLyuJyKrsf/uJkz9Oxm+96F87O5t7r0MlgEbT+YMeSFKnziid4Of7
         dC+pCrJ7InkdNzowV66/wOFsqL3K4ds2Rb8iL+aeKbB3/dLjYOnlKzLRCk1YI5C367es
         C5iWF9jglhwAd17X3s7y7OKzqjp2rVLs+azBPCsRh2GzLUbJW+OpCqMpVRsOKrx6bby6
         LpK8iQC+W+Uw4QAc73wN0y19A3+O6VH3nQWEj4zjtsAaZaRqWetq0HY6nzIgKdt+ssFn
         InWukNjCvXQf9KEVDDZsNvDETzbl9V0libB7j4FAVCtkLikjDgOnfqdToLI7yAuVOQxF
         Maog==
X-Gm-Message-State: AJcUukcxgyIhCUyobRvQu0l/QXV534F0LdleNsYmv3FoQKaNDkomc8Ah
        9gUyDuMsnOPoLD4r+CPnCzU=
X-Google-Smtp-Source: ALg8bN5ZeV9OG22W1s7zFw/PaYqLbhgq7KL2JQKCezRcnVu2D2T0dC704avgcy8LAqXkEiq+lfdOgQ==
X-Received: by 2002:ac8:32b2:: with SMTP id z47mr32575605qta.209.1548196260175;
        Tue, 22 Jan 2019 14:31:00 -0800 (PST)
Received: from localhost.localdomain ([23.233.244.16])
        by smtp.gmail.com with ESMTPSA id l4sm27154498qtf.22.2019.01.22.14.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 14:30:59 -0800 (PST)
From:   Antoine Robertson <antoinerbrtsn@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org,
        Antoine Robertson <antoinerbrtsn@gmail.com>
Subject: [PATCH v3] tty: moxa: Fix coding style issues
Date:   Tue, 22 Jan 2019 17:30:55 -0500
Message-Id: <20190122223055.6877-1-antoinerbrtsn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style issues

Signed-off-by: Antoine Robertson <antoinerbrtsn@gmail.com>
---

[V3]: Added what changed from v1 and v2 below the ---
[V2]: Changed moxa_brdname[] to const and fixed brackets on an else statement

 drivers/tty/moxa.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 3a1a5e0ee93f..68d56a42a69b 100644
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
@@ -1159,9 +1158,9 @@ static int moxa_open(struct tty_struct *tty, struct file *filp)
 	int port;
 
 	port = tty->index;
-	if (port == MAX_PORTS) {
+	if (port == MAX_PORTS)
 		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
-	}
+
 	if (mutex_lock_interruptible(&moxa_openlock))
 		return -ERESTARTSYS;
 	brd = &moxa_boards[port / MAX_PORTS_PER_BOARD];
@@ -1357,9 +1356,9 @@ static void moxa_new_dcdstate(struct moxa_port *p, u8 dcd)
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
@@ -1625,10 +1624,10 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
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

