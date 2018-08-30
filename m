Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C472C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAEA2073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHpqB7Ac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAEA2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeH3NN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:13:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46947 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeH3NN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:13:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id a4-v6so3561850plm.13;
        Thu, 30 Aug 2018 02:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7gz6NYYEAen5wkJR7iq4KQ64/ir6y1XMGwdqDdDUtv4=;
        b=NHpqB7AcW1iZAHV8GWpD+vW5/g+yKMNKOry2sO0dTrFuoUT4+TXq66i3HrQxuAPOCk
         SbmCH9Sys0bHrMEqljWs7Ru4zZk7bIp9OcX10+y8A2tTnldbEKPHzo7CqdAvzTz3O4Qi
         6ZZGsVcFZYZDxg/lmKLJp3LsrP9e+eFtfnXmNP+eph1CJlrgbV7Smdhn0vBSr1vJ1bdz
         +DXLg8gEsByJxrIxdoml57Vcb89Ed06aJQ2pGRBne9CoM0Il4c0Xfh1MyKaXpdj5o9RS
         O12wuXCgjOV8pRVUb8+XkTznAss2n11mGQ00B7tr96r5pJflDvu8Xs4UINRK09fvPzD3
         KWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7gz6NYYEAen5wkJR7iq4KQ64/ir6y1XMGwdqDdDUtv4=;
        b=BPIrwrJsT/uDmbCzCLOEcX0dc6/l2jxVgKnmu9ENI2Cir+S/jIJ6AGFX6yJC47AD5s
         IBikJZZWbJj5bWF+AYnh7SDC3D0oNFx9cxq8A2lysgupK6dNTMlljTgj/ZwQ6tXIFOfN
         TIR2MyOQ+OJ5xVWkTBxLf3e0E4EH1Pff/4pZUonmaUKQ0Pvh152uhZAGChd33ajttnSc
         0x4vSLeKZ+TkQ5/tfiADKMQJu24llO/O6qk4W+2uUALMS8P/k9Hk5NpeOSZI+cyfdVJR
         1tqlovDXevRmP5wkMeQMsyE0ed3XwI7g9TyYEVNgECZAvTfFUOaByx2vvRaxvnmsQIUX
         AbSg==
X-Gm-Message-State: APzg51DaFQXD0Rrnj7zCjveGYT2w6+yV7PtB4cpVsU7Ub9QNWcf7klLm
        geiV6FITahezw+5aGNH4Tql853oyYR88ug==
X-Google-Smtp-Source: ANB0VdZDcGLAimHAWd26tRjW4aCpFPwm8EBNvGH4Flru8kvyoDaVWjFTaypC6GJ1BW/aTxgVGsOBzg==
X-Received: by 2002:a17:902:f20f:: with SMTP id gn15mr9294496plb.173.1535620338469;
        Thu, 30 Aug 2018 02:12:18 -0700 (PDT)
Received: from suh.localdomain ([119.40.32.42])
        by smtp.gmail.com with ESMTPSA id l6-v6sm8787858pfl.169.2018.08.30.02.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 02:12:17 -0700 (PDT)
From:   Su Hua <suhua.tanke@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Su Hua <suhua.tanke@gmail.com>
Subject: [PATCH] block: Add a check for fdisk
Date:   Thu, 30 Aug 2018 17:11:27 +0800
Message-Id: <1535620287-27189-1-git-send-email-suhua.tanke@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a block device is acquired in the form of FMODE_EXCL, I think it
should not be allowed to perform partition operations, similar to when
mount is executed.

Signed-off-by: Su Hua <suhua.tanke@gmail.com>
---
 block/partition-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 5a8975a..a8daa31 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -440,7 +440,7 @@ static int drop_partitions(struct gendisk *disk, struct block_device *bdev)
 	struct hd_struct *part;
 	int res;
 
-	if (bdev->bd_part_count || bdev->bd_super)
+	if (bdev->bd_part_count || bdev->bd_super || bdev->bd_holders)
 		return -EBUSY;
 	res = invalidate_partition(disk, 0);
 	if (res)
-- 
2.7.4

