Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06687ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66AD2083D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 18:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyHJSOSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66AD2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbeGOTHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 15:07:33 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33247 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbeGOTHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 15:07:33 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so14289769plb.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YhvenjwlpV6aPD5yc+NzG38+j1bRadFV4bwNgqwaX2E=;
        b=UyHJSOSOE6zbYnb3tJ9HMUopPCmp1Ytatncjc7N2jZkpP6nZatExz9yHlRxHiuchKU
         4QT7aoFYqdL8eEHiPaHAmJE1EZqnse3MFlWSj6PuM3hvqDyqmJcd9vDi5gUrd70s1nkB
         SFV/fpPkflW4rmPQ+LiTISp5dL2aRogRvwGbz5mrXEC4mEJtyMMg30/O1SYSw2ot5bed
         8fpwP1g2v/1ZQ1nQIeFvJ5D5MNMCLw05wCG/vaXo5+Aay7EjMZWdRtmxCwpG7z6EXpzR
         PqRuCjyAneE/zhx88Pg4KhVMulJxKyzO15w0CedKi7xL5/SXjxQdv61VSv2x8wKUw6dQ
         3C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YhvenjwlpV6aPD5yc+NzG38+j1bRadFV4bwNgqwaX2E=;
        b=DklUQhJw9MElP1HUbFWEy6UPQaLZzfh1E+Z4FG4V/wV+hMKI2JE39eu6+XCw75kfON
         B+stqr+B02C31l8vec3EUA761idtEXIryxdxjLEDzm3hlJNKe8VPUA0Bk0rvrPb7R2jP
         HD81Qn9gsOE44H12/CZrXuVoSYHKz/kG+eaelrkDbs0+GeDkzOY5MX3cmiICPUcpJevw
         l2h0TS9PiScJFf9hFlYfzZVhjWb8w8Qrf0tIQRE0BLgrPtgdjzUoBVT9AvAm9OkKvojb
         dphIzyANRmdQXxVgiUpoJUFTDVIUooTVcRLIvc6BuFLhau9yCChrQ+2VxQoxEfXLx0iS
         nArg==
X-Gm-Message-State: AOUpUlE87YGq5fQDwtGovTPpTCSxKPOPX1ppiAYDOOwotkaNlCrOWy1B
        jyJf1paxwOz+VGaIqA3Nvc8=
X-Google-Smtp-Source: AAOMgpda5yuglVBHEyJCEWLE2Cyb0RTj1ucLeMb3T8d3RCk5DEamHhCIJPgE8bxYph3Gl5wDd3fh/Q==
X-Received: by 2002:a17:902:bd4b:: with SMTP id b11-v6mr13639934plx.243.1531680224607;
        Sun, 15 Jul 2018 11:43:44 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id j1-v6sm14778535pfk.125.2018.07.15.11.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 11:43:44 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH resend] staging: gasket: convert gasket_mmap_has_permissions to bool return
Date:   Sun, 15 Jul 2018 11:43:36 -0700
Message-Id: <20180715184336.195821-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_mmap_has_permissions() should return a boolean value.

Signed-off-by: Zhongze Hu <frankhu@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 4ac239c33ea3..dd2daa2e1c31 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1232,19 +1232,19 @@ static int gasket_release(struct inode *inode, struct file *file)
  * that the provided descriptor/range is of adequate size to hold the range to
  * be mapped.
  */
-static int gasket_mmap_has_permissions(
+static bool gasket_mmap_has_permissions(
 	struct gasket_dev *gasket_dev, struct vm_area_struct *vma,
 	int bar_permissions)
 {
 	int requested_permissions;
 	/* Always allow sysadmin to access. */
 	if (capable(CAP_SYS_ADMIN))
-		return 1;
+		return true;
 
 	/* Never allow non-sysadmins to access to a dead device. */
 	if (gasket_dev->status != GASKET_STATUS_ALIVE) {
 		gasket_log_info(gasket_dev, "Device is dead.");
-		return 0;
+		return false;
 	}
 
 	/* Make sure that no wrong flags are set. */
@@ -1256,7 +1256,7 @@ static int gasket_mmap_has_permissions(
 			"Attempting to map a region with requested permissions "
 			"0x%x, but region has permissions 0x%x.",
 			requested_permissions, bar_permissions);
-		return 0;
+		return false;
 	}
 
 	/* Do not allow a non-owner to write. */
@@ -1266,10 +1266,10 @@ static int gasket_mmap_has_permissions(
 			gasket_dev,
 			"Attempting to mmap a region for write without owning "
 			"device.");
-		return 0;
+		return false;
 	}
 
-	return 1;
+	return true;
 }
 
 /*
-- 
2.18.0.203.gfac676dfb9-goog

Resending, extracted from the previous stack of patches that needs
other cleanups.
