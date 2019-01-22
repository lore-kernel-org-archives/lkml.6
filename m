Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D33BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D286020861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXgoI3OH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfAVIZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:25:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36394 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbfAVIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:25:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so11115209plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 00:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MEZ/KI+mhuj3h0ZRrhGQdNJohbrmkbWZ1UJkGQBfUak=;
        b=DXgoI3OHLnA9RWXeffj89lm52RX5bRr7TphFN/4lk5qeZjTUOKhAlosKEuc3Ipjjh0
         UjOtAcVf4wWog3LHzy4KYr7zCK/edOrDGHssTEllKZxBUdS33k49ivBlFxNCMQm62iwL
         f82ZZCLX44jjJLOYqcmMjWna1ZkXEPSeKZtd9sEa7CVMmh97/kwbbIGYCZkYwMlCPLLM
         vdfxOgFBi5lcf+Zlzqu8ii9I2XMSRCXTKliox6YgnjleL/105GcaiTbtL0b0Ih6jzYl5
         eBf3LPP7AMDvQJU/O0o8xEe1dGiB9Uu7rxIWR0HaLJ8dgm8t0ArAHAcr9krbewEDrdON
         SBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MEZ/KI+mhuj3h0ZRrhGQdNJohbrmkbWZ1UJkGQBfUak=;
        b=QDMJosiznmkyAgHNROHmJlcwGPzGkOF6KQfkiAFRpJ+9tYMjE7VC38Oy5QcdUFfvHw
         hkzYjgnsx5yy8KJ88mKyyIDTVMya2Glts6JXH+mXAzohGIjDGFTBWXQe97cGFfjlTH0k
         Le2RPttrTZ55Z5fRFfebw7dtwCadjKSwbxvdphmmbIW/ImrMsKXPsHUPRyCHVH6aifcY
         9GXKxuziA4h7MjfomJMZrdJC/gmPkq1y+Xp6fmLDi/nVoA3mQAsmEHNs/jzC/DiYe1IN
         EipzNEK9Z2GaOTfPW6aV/aXJB/kyBhPq2VvK890w2wtO788xPBJHzRBm2MxaiUomoGUh
         c7Xg==
X-Gm-Message-State: AJcUukcOFoOfY8Zkbti9hAskbaECgJ+ytrvIHY03YARzmZJLBK8qEvDU
        rRxBV08AMnsOlnddKoocoWVz81hZ
X-Google-Smtp-Source: ALg8bN4ZqfQ5qDXmNxtGFwBnaIrCmuufrP5ZP3l2WmPmeKewtTUT9az4XrPr9CtYVtdxb4CcFVB3fg==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr33472720plr.15.1548145530052;
        Tue, 22 Jan 2019 00:25:30 -0800 (PST)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id w88sm34018844pfk.11.2019.01.22.00.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 00:25:29 -0800 (PST)
From:   parna.naveenkumar@gmail.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH] efirtc: remove unnecessary code efi_rtc_open & efi_rtc_close
Date:   Tue, 22 Jan 2019 13:55:10 +0530
Message-Id: <20190122082510.10136-1-parna.naveenkumar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>

There is no advantage to keep 'struct file_operations.open & .close'
API's. So removed the unnecessary code efi_rtc_open & efi_rtc_close.

Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
---
 drivers/char/efirtc.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/char/efirtc.c b/drivers/char/efirtc.c
index d9aab643997e..11781ebffbf7 100644
--- a/drivers/char/efirtc.c
+++ b/drivers/char/efirtc.c
@@ -254,27 +254,6 @@ static long efi_rtc_ioctl(struct file *file, unsigned int cmd,
 	return -ENOTTY;
 }
 
-/*
- *	We enforce only one user at a time here with the open/close.
- *	Also clear the previous interrupt data on an open, and clean
- *	up things on a close.
- */
-
-static int efi_rtc_open(struct inode *inode, struct file *file)
-{
-	/*
-	 * nothing special to do here
-	 * We do accept multiple open files at the same time as we
-	 * synchronize on the per call operation.
-	 */
-	return 0;
-}
-
-static int efi_rtc_close(struct inode *inode, struct file *file)
-{
-	return 0;
-}
-
 /*
  *	The various file operations we support.
  */
@@ -282,8 +261,6 @@ static int efi_rtc_close(struct inode *inode, struct file *file)
 static const struct file_operations efi_rtc_fops = {
 	.owner		= THIS_MODULE,
 	.unlocked_ioctl	= efi_rtc_ioctl,
-	.open		= efi_rtc_open,
-	.release	= efi_rtc_close,
 	.llseek		= no_llseek,
 };
 
-- 
2.17.1

