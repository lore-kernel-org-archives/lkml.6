Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198BBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 08:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD902173B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 08:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="UTb3Q001"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbeLYIeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 03:34:06 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:45666 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeLYIeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 03:34:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id CDDF7643
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 08:34:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zls59Jv4YSRi for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 02:34:04 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 9F724622
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 02:34:04 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id o22so16061010iob.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 00:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UbGeaRooo9Dx+m8Gey/ma2eXxbCOVIVyfMiBlwjCMno=;
        b=UTb3Q001x11lYuzfkOlcGoiwO3iDi3XpV3xJg1+HWJ2g2Et8b9bz7l2B+8O55s6+5I
         YNhid2EOQo2Pktk8C/40U1l3dDo7On2UtQwzMg9JObIXPfqhIa58lfmIAmHOpeNTkMgY
         hcU8FbJD8O9WKZFWe+CfEUk2nmJW7vbRslEHmSX9xnBFAwL9cyjxcM7Ue0XMQyMkHH9L
         dJ9jvsiNLRJxf6SwXh4LtgFxQ3+XLmSuNkKmZswNOZ/XCFRv0tlsnoxZxL2DFHR/WUWB
         rss2qQ4wPDg2i1Duo8IhFG7DZ1owSt/CngPqHZh1cKaEJ0ZTTYcrCF/MGlE0f0NX8n/3
         udKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UbGeaRooo9Dx+m8Gey/ma2eXxbCOVIVyfMiBlwjCMno=;
        b=livUQFsM3bP3y8RR9kFcb4kI1TX/7XEP4rx7P5d69pWhmaWvkwh9u+bdWG42O1BPq4
         iulTpPgV+JcD3QwIDUkN/PGm2Fxd29hoIDZD53xS+dqdwXiCsf7QwbilryF8lG17RUhs
         b0UQbgQqZVyizdwN13lOgwBrZkD36U+sxPOqkexz5qJTOjyf5q/okWuzpjP24t1gpG7/
         sH4uDp49uGb7h0GgA6yjcu5mpnEGJB+do94mweVGw0J343n/tUpMnpyMsikGLLzNt/iz
         oEYs/uxQHKZt9lC9ELIADq30UY43lHrUIjAtaJryRFuKHweLd56Rtua4c05p9HSKpVhS
         QHuA==
X-Gm-Message-State: AA+aEWZOsjpiFjdgrS4r9Kbwgj7VLg6T8AaTGO/URFj8ctyHdbRdIeK3
        NMfOEje3hW3PZQUSYb3/7oYkM7H0n29LL97myhYPls8YzujnDnNYA6yuQo7CCftRjoUELX3MBo2
        ZRmfcN7c9uN9nkPN8pGKDdoUyOITk
X-Received: by 2002:a24:edc4:: with SMTP id r187mr11330775ith.158.1545726844190;
        Tue, 25 Dec 2018 00:34:04 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UJx4pxFpPmmuAiQP2jlYlCzxL0yw03lFNcpttm/FQuvdRwIjH/vWxzeEYekFDZwkri+i0l5Q==
X-Received: by 2002:a24:edc4:: with SMTP id r187mr11330762ith.158.1545726843959;
        Tue, 25 Dec 2018 00:34:03 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id 196sm10890258itu.33.2018.12.25.00.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 00:34:03 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Aymen Qader <qader.aymen@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rts5208: fix a missing check of the status of sd_init_power
Date:   Tue, 25 Dec 2018 02:33:32 -0600
Message-Id: <20181225083334.68473-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sd_init_power() could fail. The fix inserts a check of its status. If it
fails, returns STATUS_FAIL.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/staging/rts5208/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index ff1a9aa152ce..8c3fd885a4f3 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -2352,7 +2352,9 @@ static int reset_sd(struct rtsx_chip *chip)
 				break;
 			}
 
-			sd_init_power(chip);
+			retval = sd_init_power(chip);
+			if (retval != STATUS_SUCCESS)
+				goto status_fail;
 
 			sd_dummy_clock(chip);
 		}
-- 
2.17.2 (Apple Git-113)

