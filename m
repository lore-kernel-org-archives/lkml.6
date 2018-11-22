Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57B5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C9020685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZbt5L/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C9020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395511AbeKWBFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:05:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46002 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388795AbeKWBFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:05:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so9335281plm.12;
        Thu, 22 Nov 2018 06:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/2FQipLjfEG4na7CrddqYMj4I93hdSyt+i9eHE3UFwo=;
        b=JZbt5L/w9ToDRXZ7H/SIF0QAZtAiiL3GiMaXh2Eq7nI19S0fTNmQRN1bb3NQ3Oo/nk
         RCPGncwi3Yr/FluCLvw5YTDQx3USmPO72BgVxkei3anA6HAXY1RcHK8WLdm9Wpwe72h6
         b1XdzpfU6iVbXcnwW8EUlaX86cSJ7m+agz0r49LWGi/89KMGvToWT5947UuJLlLLUeew
         qe8ppO++C4jJZKl1kn5Dl9qeFayKOaBB2mTZ/NFi7acvpA3aqHt/U7AcEE1W9X6snesh
         k3Pm7mCDInXhFKOm0NHN4t18xFkr4YncKDppwFJcAoq+9z+Sz6wzUOXmwgPivzjXILCj
         T2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/2FQipLjfEG4na7CrddqYMj4I93hdSyt+i9eHE3UFwo=;
        b=KhMvGuFr1jx5p5wNG8xsi0NxiXjGkvHrQyoG1uNuHdHy6jUhtJzQaCSdcz1jUlDYm3
         Ds+FSRyWLjbvLltMPX94xRdPAU6dIbWjZ2rRHLozi3njNCpXcBQUdaZVozZHleNAxpnR
         TtP3KpDHV9l1Fg800lx7RlTRp3LxmYPaFepAOiSv32bgCj9xvP9a30lj5H1Sqa3H0wva
         7cZI2G3bXkpGw2p9hFsZqlKfSTyQsfnk728j/jEv2A7KnBph6cVF4XERWH5K+uTr9tZ9
         6ipBWVFhXuNeISl7Ke/LPC3q/KH7G4BQQvrDf5GFxuQkoTqIJQkjXUtqeKd65kg8ZL9q
         U1eA==
X-Gm-Message-State: AA+aEWaCimWnWzH8AufAYbrNVC5yaxqQtJr56mkD5wz7nuMGNFG5gCoM
        0Zs1pDskZ3+yl0FX/yJj+1M=
X-Google-Smtp-Source: AFSGD/XZBRjASsezwfUoQNIEbQbsYGnSPh5oupRsd1m96jhpbYvBaQ13yhKGNWfWqSjfduWUgKIKSw==
X-Received: by 2002:a17:902:6848:: with SMTP id f8mr11254854pln.300.1542896754440;
        Thu, 22 Nov 2018 06:25:54 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id z7sm42537609pga.6.2018.11.22.06.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 06:25:53 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     sre@kernel.org, hdegoede@redhat.com, wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] power: supply: axp288_fuel_gauge: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Thu, 22 Nov 2018 09:25:51 -0500
Message-Id: <20181122142551.25367-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 084c8ba9749d..9ff2461820d8 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -307,22 +307,12 @@ static int fuel_gauge_debug_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int debug_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, fuel_gauge_debug_show, inode->i_private);
-}
-
-static const struct file_operations fg_debug_fops = {
-	.open       = debug_open,
-	.read       = seq_read,
-	.llseek     = seq_lseek,
-	.release    = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fuel_gauge_debug);
 
 static void fuel_gauge_create_debugfs(struct axp288_fg_info *info)
 {
 	info->debug_file = debugfs_create_file("fuelgauge", 0666, NULL,
-		info, &fg_debug_fops);
+		info, &fuel_gauge_debug_fops);
 }
 
 static void fuel_gauge_remove_debugfs(struct axp288_fg_info *info)
-- 
2.17.0

