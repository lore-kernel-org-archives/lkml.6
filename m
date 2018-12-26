Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DB9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 04:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40440214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 04:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ixJSBtk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeLZEfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 23:35:16 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:54802 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeLZEfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 23:35:15 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 75AA198E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 04:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VUVRbKlH3GDt for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 22:35:14 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 40EB897B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:35:14 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id t13so12806726ioi.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=a1zTTyAyiXIBr/5NtOxbdTp1FWPdqY8wn2FVQPX+AKA=;
        b=ixJSBtk+xRuzntySWv32XCcDFRGj4wUaxqGqFd7YTgr9P9A1KE6B71yMCaacS63v3D
         JDRf/MKBrTdPPYP1GE+PZzLDYVgV4/kFzv3qBJkKYE+vMR+Aux4NIjJm3uYj7OsFTQvi
         uvwylXzoPRRFFXt8zXZ/3ZTMilp9A6iTX48i+AExrFUdYqHj6cOJPn5axo4rHYVQVzxX
         uNDrljnZFGNaxVeRfusDSb1i6xWPkTI5CsdHVZ7OzZojXXrcvgzUGMdq5wPmZhe5CK1c
         FOB5Ps7cEFy0SpFnvIN3FkKJ/Xk/2tokazQc8VBJ5hY3/OBZqusWiwaIaXHbG2n2rv2D
         q54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a1zTTyAyiXIBr/5NtOxbdTp1FWPdqY8wn2FVQPX+AKA=;
        b=jtZgwswoE9+DqeE/00XjAnUGnS4/TSusP7a9wEDZpaRO+3+TkbfzKAwcXUEVFE8sMg
         /doaFcV1uSYGViCarcrn3n7vvQ3qu8koOUIw6iWcvGlbyNyn2Tw8JRQx/S9q5jecZ3se
         s9S8B7VLZWQsEUDVDC/VSGZS4HilCjbWE9ekAJcwHGDhJfoRFChM7z6Y7/83fRqkA7/R
         F9mJvJKzsD+QPLR49HE3DyKND9d1+ju+z1BGegWsQSoaaFgx/vKp87jjV94PbEHhu0QI
         Tk+ZaeXYS31vuOvPj+C6gyTgd/SbbiH3Ind1qO5XiWG90/owDqnipIhApDSdD5ubifmR
         r9/Q==
X-Gm-Message-State: AJcUukehiVIjRHmDoAxlH0ml4StJXuiINtq2gxVJ3AVL8E3Tk7OgwwX5
        avOnggcvlgX/volqZHyJJWMiZQXwYI5EpYU/1fugg/La989BLN4N0+aXD48OXuIc3oOrAAp9Dmz
        45dzlW2IOTpuG/SOdU9o1H0h9pPab
X-Received: by 2002:a24:b610:: with SMTP id g16mr11368359itf.3.1545798913008;
        Tue, 25 Dec 2018 20:35:13 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WTZ2q8d6ZqEeawPQEs/e0ska0/FyqlbgWU3U8NJeTa6vyaAj8xJbH90GqavhkITjpTJI0sOQ==
X-Received: by 2002:a24:b610:: with SMTP id g16mr11368354itf.3.1545798912786;
        Tue, 25 Dec 2018 20:35:12 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id w186sm12085573itb.15.2018.12.25.20.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 20:35:12 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wan: fix a missing check of spi_write_then_read
Date:   Tue, 25 Dec 2018 22:34:41 -0600
Message-Id: <20181226043443.74229-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When spi_write_then_read() fails, "data" can be uninitialized and thus
may contain a random value; the following execution checks "data" with a
mask, the result could be random.

The fix inserts a check of spi_write_then_read(): if it fails, always
returns -1.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/wan/slic_ds26522.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/slic_ds26522.c b/drivers/net/wan/slic_ds26522.c
index 1f6bc8791d51..89681910d875 100644
--- a/drivers/net/wan/slic_ds26522.c
+++ b/drivers/net/wan/slic_ds26522.c
@@ -64,8 +64,9 @@ static u8 slic_read(struct spi_device *spi, u16 addr)
 	temp[0] = (u8)(((addr >> 8) & 0x7f) | 0x80);
 	temp[1] = (u8)(addr & 0xfe);
 
-	spi_write_then_read(spi, &temp[0], SLIC_TWO_LEN, &data,
-			    SLIC_TRANS_LEN);
+	if (spi_write_then_read(spi, &temp[0], SLIC_TWO_LEN, &data,
+			    SLIC_TRANS_LEN))
+		return -1;
 
 	data = bitrev8(data);
 	return data;
-- 
2.17.2 (Apple Git-113)

