Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E34C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7B02085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mdc0F66A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfAUPaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:30:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42171 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfAUPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:30:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so10272717pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3FZTJRhHraH2sht5J7M4ww/ZLZethTP7fTLSl2ZY/0g=;
        b=Mdc0F66Ah6ijv1dc0t6Fvw7WHqUBxvTDJE8l6DAZYv1DCiraSMqcHMp2TlKP/6x/n6
         7iRjuSkM9WCgyt/1aKmR33sLuEQAi4efth0Zzg6CZ51/lfm0nvv24rwqtll5/oYDXghY
         8p2Np3t9/AfADH5U7GCputik5bksG/TV5Lg6I/P7/EuKa1BvTw0e064PE3Y5EjfzU7Bv
         UOz7g/3I1y4nCHCU4cBWPmGvx+qTEd4HNSed2vB5S5et/5OsuIDS/RbPKJO90KBnIZ3o
         4j0Ud1JXnbrxYj5SeNEzgvOtSm0ZzK4QbDa0j57jAB9zWHqUeh0KjY/Sset9mf+4QUIB
         pr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3FZTJRhHraH2sht5J7M4ww/ZLZethTP7fTLSl2ZY/0g=;
        b=q0XxDNe/zDuOrPhzN/imkjah2GQk/SrMZuLysxTy+OTF156aXyq9cYlbDrDDtporRC
         xMYVA7/ELvcIzMzsE+/z5BC8hsIhEVKJc4icu7okTNdVtXqjDf0mpkiks8m7xb1S1pm0
         ciqN6NrSPj/k3RjMy6CE2A2eLS0bcgcri1C0b48CHLivDGaMD+V/F2Si41z2RIed5tdU
         ZZ8R5mbmeRiON1KF+hNiYUEV98GMqnVQD5BMTQAcUI4XbLHxsQ3KI9GJtIQUtO8NL7bx
         y7DmahVw+kcu4o+wFT9jSbH4nQuJQxZELiMW1UpEZJ7TiBWYcx32cFao6r8WJaKo6bIr
         QORA==
X-Gm-Message-State: AJcUukchiwe53SfQhd3dc8Psf9OW+u5YRqGKGQkeGVkKkTgGSsaq4Gc0
        hlCfC2my50NW84CBV+An/SU=
X-Google-Smtp-Source: ALg8bN5/pnYFKlr5W+yqZT0EJagHQBEdIRMicYDcBuY2uREpH6AiHSdzTv+lj3UyworhtfvuxjPjyQ==
X-Received: by 2002:a65:448a:: with SMTP id l10mr28500159pgq.387.1548084616544;
        Mon, 21 Jan 2019 07:30:16 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v5sm26063752pgn.5.2019.01.21.07.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:30:15 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clockevents: decrement reference count when device_register() fail
Date:   Mon, 21 Jan 2019 10:30:13 -0500
Message-Id: <20190121153013.24681-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_register() may fail, use put_device() giving up the refconut
to avoid refcount leak.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 kernel/time/clockevents.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 5e77662dd2d9..7b691dc97349 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -719,7 +719,9 @@ static __init int tick_broadcast_init_sysfs(void)
 {
 	int err = device_register(&tick_bc_dev);
 
-	if (!err)
+	if (err)
+		put_device(&tick_bc_dev);
+	else
 		err = device_create_file(&tick_bc_dev, &dev_attr_current_device);
 	return err;
 }
@@ -746,8 +748,10 @@ static int __init tick_init_sysfs(void)
 			err = device_create_file(dev, &dev_attr_current_device);
 		if (!err)
 			err = device_create_file(dev, &dev_attr_unbind_device);
-		if (err)
+		if (err) {
+			put_device(dev);
 			return err;
+		}
 	}
 	return tick_broadcast_init_sysfs();
 }
-- 
2.17.0

