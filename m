Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB01C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8FD20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0nAAZJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8FD20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeLCOfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:35:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44062 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeLCOf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:35:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so5780483pgr.11;
        Mon, 03 Dec 2018 06:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sSUiumMEKrKTjI9G5AoYNM+aWoBPu6gHpRnhBTlnW1Q=;
        b=U0nAAZJWD16c8V1ZRkMOlM8XQr97XpEA0uzJHheLqmVb9Ska4edePYevd0ZcKzI62p
         jiRchBmAceN92iBYIfJMddI+kcLYBzfFoj+XYl5Yy0zyXAlaMwicU3dRoeN9sWMjGUjl
         5B5QVDa+mwDTcqjLX49YxU9jmJCPsz3JA/6Dx2RX9szJ35lCue1HYn1YH93VYt7JKPws
         J0TeUaSfk3sv0vi1ooTcjQGPZn2a9uD6N9QtRPTCiTf80txrhjtoHe2sWv+G/rl6IQGw
         neWHbVdCJadv7/tXeLp5gpAnCtuZfrWpwU0IzuquxeN6y4BRgZR0MATzzO5vUt0VTQy4
         UcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sSUiumMEKrKTjI9G5AoYNM+aWoBPu6gHpRnhBTlnW1Q=;
        b=P+I8PQvdxejBk281EIK2BF8Jjq4E78ueTLHgDAAqPeNM/V4qmbzrJ3bUlP0/vOFXuw
         aPpty+ORJavHWtzDus+Ko72HougmrYZdhXzh2iWEq2u5vewv98rtt17Z9OgpwsddJvN7
         PKf6vY7b3rArXoy8CXXGLoZuexQQLXsQQaJSWJqWBgsxgb+FxZDE+9vxA9LSojE4llUx
         knmkA0vAX+BEBtJAExCBRnp0zA2avw7BZGRkKRMHpUqEpCksIcpidfzBElfqWnRUenQE
         hXqIOSjHV5bXECQJhqiQEDXYBG5ASNKu5w+fVF6MOH5d68FwiHLlnFi9laTRnpccpyAB
         HaBQ==
X-Gm-Message-State: AA+aEWZPqkl3PVBdbJnuG8CpovdW056lvCTkfXZH5edVEjBfor0+TFuI
        yByI/LPwz2N+Kty5DTY2cSk=
X-Google-Smtp-Source: AFSGD/VNBEXLkjOqmwYa7WGJ9dmRI9yTBX7M7OUm9ua4M6EFuk1YSc4syFxsXB+9z3OLfh8cg7j19g==
X-Received: by 2002:a62:6d47:: with SMTP id i68mr16098546pfc.185.1543847654112;
        Mon, 03 Dec 2018 06:34:14 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v76sm37978873pfj.145.2018.12.03.06.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 06:34:13 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     mlindner@marvell.com, stephen@networkplumber.org,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] net: marvell: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Mon,  3 Dec 2018 09:34:11 -0500
Message-Id: <20181203143411.13294-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/net/ethernet/marvell/skge.c | 14 +-------------
 drivers/net/ethernet/marvell/sky2.c | 14 +-------------
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/marvell/skge.c b/drivers/net/ethernet/marvell/skge.c
index 9c08c3650c02..04fd1f135011 100644
--- a/drivers/net/ethernet/marvell/skge.c
+++ b/drivers/net/ethernet/marvell/skge.c
@@ -3732,19 +3732,7 @@ static int skge_debug_show(struct seq_file *seq, void *v)
 
 	return 0;
 }
-
-static int skge_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, skge_debug_show, inode->i_private);
-}
-
-static const struct file_operations skge_debug_fops = {
-	.owner		= THIS_MODULE,
-	.open		= skge_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(skge_debug);
 
 /*
  * Use network device events to create/remove/rename
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 697d9b374f5e..f4aa01ab3580 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -4623,19 +4623,7 @@ static int sky2_debug_show(struct seq_file *seq, void *v)
 	napi_enable(&hw->napi);
 	return 0;
 }
-
-static int sky2_debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, sky2_debug_show, inode->i_private);
-}
-
-static const struct file_operations sky2_debug_fops = {
-	.owner		= THIS_MODULE,
-	.open		= sky2_debug_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(sky2_debug);
 
 /*
  * Use network device events to create/remove/rename
-- 
2.17.0

