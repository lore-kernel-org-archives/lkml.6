Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAEEC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A65920671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+4/N2NP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A65920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbeG0KaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:30:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34789 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbeG0KaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:30:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so2884073pgv.1;
        Fri, 27 Jul 2018 02:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S8F4PyGtjzxna3EN2fSm5kRt7F5RmE4FXrj42Uz2lBc=;
        b=G+4/N2NPbFW45ODFNueFs4jyCwuj7yfSaUcLbQdrgbTwFv1flaqoto/BgYu423JwZh
         324NPNAdp75nMy6RXOPv/PQDfMxtdtWYKE/L3/O2zTkkjSbg2fSO9zrVg/8QLHVw8pYz
         XZCXrrwdfO+60lOMhFIMd897lgiuBQOrrQzyxC2NO6Z+thcbskYeCxvVZNY6se20ME74
         6FJB4ykQRwhNPjGm1cC07EvnHwxdNYYHxe7B+66hr20viilUiHTJK4hcxFSqYD191mbk
         Yw0szi1Z+aVF09wnGRDZjVpfovVKI0l4Nq+EzRWA9uDn0QNgZ57TSPEzAqkKD88BFK2I
         DjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S8F4PyGtjzxna3EN2fSm5kRt7F5RmE4FXrj42Uz2lBc=;
        b=cOPTKIcv7r1cUwLobIY7QC5Kp6L2Ws8WdITzbx+y8ra26zxta+W8Dz3jN6OIUt5qZQ
         rZO+vna342cEoC8tJQNKROd7iYc6eTFNY49ekMu3J2kKU7m25v1/YZNGHLnx3cxL9ncJ
         dnAtgepI9e7ALpknTEygC7o+Vqzmr2LxN6/j3R/fkE7l7wokkVlpNWyBWzA2HHeINpSe
         E0qD626KUEH+c6d5KhmxCQ2vQS0IDWbfD6P0RDL45z3LTHCBZzjULmEcjeEJMBg30Mv3
         rOMh4y9rEiYBnuC/lEWfp/mmw3d9LntyQxMzYAMLCO8fBL/NI3B1P3OLOYQ4NR4uVhjn
         z+Hg==
X-Gm-Message-State: AOUpUlHfGvvFHkAHtinOBrKWlhqBBUgEue1OWdYyzqUxc70jog2uBZGw
        gt2kP9qKeBd8CF3pUSGmoJ5YgbLZD1E=
X-Google-Smtp-Source: AAOMgpcFkCJL2qQWDuKAmf06m3yLUd5sZRS6LOY8S5nrSRaVh2d+Le3gKcD5Ft2YA1pu+7f/9WepIw==
X-Received: by 2002:a62:9cd7:: with SMTP id u84-v6mr5831274pfk.90.1532682561824;
        Fri, 27 Jul 2018 02:09:21 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id 14-v6sm6202614pft.93.2018.07.27.02.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 02:09:21 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] scsi: a100u2w: Replace mdelay() with msleep()
Date:   Fri, 27 Jul 2018 17:09:13 +0800
Message-Id: <20180727090913.6870-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_chip_ready() and wait_firmware_ready() are never 
called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/scsi/a100u2w.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index 8086bd0ac9fd..358dfeb1a9c2 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -143,7 +143,7 @@ static u8 wait_chip_ready(struct orc_host * host)
 	for (i = 0; i < 10; i++) {	/* Wait 1 second for report timeout     */
 		if (inb(host->base + ORC_HCTRL) & HOSTSTOP)	/* Wait HOSTSTOP set */
 			return 1;
-		mdelay(100);
+		msleep(100);
 	}
 	return 0;
 }
@@ -155,7 +155,7 @@ static u8 wait_firmware_ready(struct orc_host * host)
 	for (i = 0; i < 10; i++) {	/* Wait 1 second for report timeout     */
 		if (inb(host->base + ORC_HSTUS) & RREADY)		/* Wait READY set */
 			return 1;
-		mdelay(100);	/* wait 100ms before try again  */
+		msleep(100);	/* wait 100ms before try again  */
 	}
 	return 0;
 }
-- 
2.17.0

