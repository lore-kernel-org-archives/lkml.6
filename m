Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD62C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E0D20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dp5Kgz/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E0D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeJXM5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:57:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37802 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeJXM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:57:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh10-v6so1654452plb.4;
        Tue, 23 Oct 2018 21:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9HEy+JpVDrqHTtVwbWj1AV96zTNQiQmnitvlf06EDk=;
        b=dp5Kgz/Ew1FiDmoWunQvzK6lvfWDP81FICZ6LO5gqpkPG5GYtJaij7SFP/AMxKiDMY
         1Ph0MgvsMNFY4RVtEra3GNqQgq1kkw6XHKKQsiL51tfW80CWtpHlwCX9MpUW37C4lxZC
         ElV9DAjup+ShDx/c6FwhQf+HTR5IkgchoE02yLI0KigC9WBu2GOrMo6KyDq9pxoi1+z9
         oERZPqzNTRr3nRXttIEUDJGCPlRvX2yHIyV9rjjg2jutiIMm4uXw/tJ9vCUSwgZmjGjT
         uXG7Gs379sCel/ByTWxRz/w9R4WxFfOnyV2+vulfs2owzlS1CzHOBMgWjf1bykeG+BWy
         UNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V9HEy+JpVDrqHTtVwbWj1AV96zTNQiQmnitvlf06EDk=;
        b=mhPRLGwnFPZNny264iVPWNCXFXUGdkGd7cmXgsSWON9xfvsT+cHkaAr3r+Dt/61luV
         whEjOhqEJ3Ef4ZYKsYApmfEjJYzumD1BP5AEeVn0zXor+WsK2YGIx8ve52wgXAFKRviZ
         uZ1yL+R+pPqqld1QxEWRG4ZCwFy8dk2UzouyMeLBTvqCiG7PNxwbuYVeRSSwr9VQj8St
         HSIw6IikvifOCWq7tiHBFwPjfSiaSLWrDVPqHiAj1F6YIfM0oVRdWJIH3wnz410KFjuf
         BEn+VzOwwoWeq9gDaTrzHnhJXJEkta8clThk/OlneAbQLDAKwZ7sbEeTal0GvA3KLw0Z
         eoXw==
X-Gm-Message-State: AGRZ1gKGcpDa2YcoW431Z6GXELpLntFDDH5d6oNEQrtsAtIL4/T8c7Ty
        ePt9ujLNWnSKIVwOzkVfsUE=
X-Google-Smtp-Source: AJdET5c5AQQ1wCnMjGWL8arUPOUwWniLVA09Ztx1MeGVWX8EdB+IK8qlpY5DYhlAAU0hCfMP7AG8Nw==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61-v6mr1035664plb.139.1540355459881;
        Tue, 23 Oct 2018 21:30:59 -0700 (PDT)
Received: from localhost.localdomain ([39.7.47.81])
        by smtp.gmail.com with ESMTPSA id r81-v6sm11228163pfa.110.2018.10.23.21.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 21:30:58 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()
Date:   Wed, 24 Oct 2018 13:30:48 +0900
Message-Id: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk() without oops_in_progress set is potentially dangerous.
it will attempt to call into console driver, so if oops happened
while console driver port->lock spin_lock was locked on the same
CPU (NMI oops or oops from console driver), then re-entering
console driver from bust_spinlocks() will deadlock the system.

Some serial drivers have are re-entrant from oops path:

static void serial_console_write(struct console *co, const char *s,
                                 unsigned count)
{
...
        if (port->sysrq)
                locked = 0;
        else if (oops_in_progress)
                locked = spin_trylock_irqsave(&port->lock, flags);
        else
                spin_lock_irqsave(&port->lock, flags);
...

        uart_console_write(port, s, count, serial_console_putchar);
...
        if (locked)
                spin_unlock_irqrestore(&port->lock, flags);
}

So it's OK to call printk() or console_unblank() and re-enter
serial console drivers when oops_in_progress set. But once we
clear oops_in_progress serial consoles become non-reentrant.

From the comment it seems that s390 wants to just poke klogd.
There is wake_up_klogd() for this purpose, so we can replace
that printk(" ").

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/s390/mm/fault.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2b8f32f56e0c..244993dc3c70 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -93,15 +93,10 @@ void bust_spinlocks(int yes)
 	} else {
 		int loglevel_save = console_loglevel;
 		console_unblank();
-		oops_in_progress = 0;
-		/*
-		 * OK, the message is on the console.  Now we call printk()
-		 * without oops_in_progress set so that printk will give klogd
-		 * a poke.  Hold onto your hats...
-		 */
-		console_loglevel = 15;
-		printk(" ");
 		console_loglevel = loglevel_save;
+
+		oops_in_progress = 0;
+		wake_up_klogd();
 	}
 }
 
-- 
2.19.1

