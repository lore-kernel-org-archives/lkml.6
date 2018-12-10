Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3711C65BB3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8471A20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AndqsnWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8471A20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeLJPqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:46:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45958 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeLJPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:46:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so5568980pfd.12;
        Mon, 10 Dec 2018 07:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lnno+lVdM9X6FPuf758z+yCTWSPy6peMEff47OWZdBQ=;
        b=AndqsnWaukAYeToVozR/xBTTZUkT19WgedL6plsLt9mBLxtwlc4ZabDJOOgsQn3NG4
         qB2mkF9Kb7m5P0s82AQFk4SGUQZCQNp/yyU2tDwsay1s9MhTQf7IATE3ee4cEiyvUU2n
         F4q+OI7NWXdJVkfbyAL8h2yaUa0yJ3fCyC0D2Wa6GEesp2qLOM3Y7dlpLhuJrWUAhHBT
         h2etLC82IdrpRDT4n1Ys2VNIEfUy1ytK9b6L3WmlwGomqPYq8491BhEpDeBeKJu1Z7z8
         j4UKWwmXpU4JeBC9ns/mZlghG9Pb6e75y61RzqBDGh/rUTPctnYjCQPh7KeRzKQWnPtC
         KxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lnno+lVdM9X6FPuf758z+yCTWSPy6peMEff47OWZdBQ=;
        b=bA/fj50z1nux9V+mTKriBcjIp/RXoZWQbYEsoGW9RJahbDIc1E5iP82rNRs+9sic66
         Xe9yidRiwUvdxZYgu1SNGJlXVrxms2Tb/vrod7ccTAI2SYQA5MvmVC6bXM44uKbh1GtC
         /47m5vOS3ea+CY7D2+t+F8CUuF9EERDC5opx6B9kCeArvRZ+1uWdoeabyd9Guz1Z23Nl
         lb1txRz9jt99FHkiFL7H93ntzoo/cfd2P61kcaNHglJt6xCp1XHnyqSw153SykVy5eeb
         8H4s0Fl9LMdZI85gpz5WB63W4uiw9nyPx7yzqOPXNYWTV8AisG15pbZkXXS4SfLIKQBD
         tytg==
X-Gm-Message-State: AA+aEWbuWlM77AZSqA9uz2cvzxZhNSyOK+US7TQbIyqJDN1MYieVp723
        MEM2vgFoYpSCFLH2zprqTL7AuSf2opo=
X-Google-Smtp-Source: AFSGD/U6KDWNHYdpsaq9hH9vCZLpy3yOQC9lgLdMb37Cx09UsjS44rIqNGtU2rAPr0cUBSsrKgeT9w==
X-Received: by 2002:a63:77ce:: with SMTP id s197mr11222565pgc.89.1544456777475;
        Mon, 10 Dec 2018 07:46:17 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id m65sm24973173pfg.180.2018.12.10.07.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 07:46:16 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     alex.aring@gmail.com, stefan@datenfreihafen.org,
        davem@davemloft.net
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ieee802154: at86rf230: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Mon, 10 Dec 2018 10:46:03 -0500
Message-Id: <20181210154603.20520-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/net/ieee802154/at86rf230.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 3d9e91579866..0253eb502153 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -1632,18 +1632,7 @@ static int at86rf230_stats_show(struct seq_file *file, void *offset)
 	seq_printf(file, "INVALID:\t\t%8llu\n", lp->trac.invalid);
 	return 0;
 }
-
-static int at86rf230_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, at86rf230_stats_show, inode->i_private);
-}
-
-static const struct file_operations at86rf230_stats_fops = {
-	.open		= at86rf230_stats_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(at86rf230_stats);
 
 static int at86rf230_debugfs_init(struct at86rf230_local *lp)
 {
-- 
2.17.0

