Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74348C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4167020821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEZndf3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbfAIJRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:17:16 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46169 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbfAIJRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:17:15 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so6645389edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QT0+8EtvT8XyIkLazk8pXkyPSXlhPOgzMJ6VTGqFFn4=;
        b=LEZndf3rA55oBn2MHsQQsCknYrAhykahNV27P7bFVOEDLEEVJkFSgLOmkbuCdecxU1
         kjrCuji3oSHkIBXZD8gIi6ANGi8RyY+0Z9sz/K5vjiz9I5wslf1ighJYUoH8heRtRTnQ
         A24/EwwzgkXHa/mwLuQhisIqgZle+WsLiVrndpStmwOkw9cq6MrXaXFRgddb9nEOPNzO
         kMZfR0Rr0/euHWgM9C5mISmlxRd7Zsn8NQlygTiR2AUpZBfOssPzI8MeXxETmLxLwxiv
         DzM0n2WnFGDIUeEDvVK1QzIoCTbi85gRZqP+Kyu6IOhib7YMsTdfcGkmqm2Y1Dd4igb2
         dziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QT0+8EtvT8XyIkLazk8pXkyPSXlhPOgzMJ6VTGqFFn4=;
        b=uUuqStdcmFgKu/XiM7s9Jn3lLdiNj9TDmCJVsIgAk9dNDLpngZMACD7jtcqxdRrLzQ
         LNaFW1U/NMhqXF8WJjv9T92GdMvqwCMRvw7yrkHn927HY6uOufVVEkLsB14ix+ARakJK
         RjVsiSoGNwjTtJp8OwcKCQ3olKkXz4n/9NgDQdZbx9Awp67p2XXN7iea0AqFuLaTCtqT
         gtIEeLVyTIK+rBPzmMIEX4YaKfnHhjpX3QCDpQ7iRgCVpZPUdI+3768rGzC/408M2GMU
         y3qr+kxuwAJUBowKaHOyUKMYkedXvpjiLabrkbDKBT5YrFjHyQNoeidDVF2Bj551WQOt
         mTsw==
X-Gm-Message-State: AJcUukcdNSJE4o/fTqlbKaQ4RHvUk5FeCJHvysZOHRWOXaw4Ctjio1iE
        ZrY384KYeX7fyQUvw4ZHopU=
X-Google-Smtp-Source: ALg8bN6ARRaBRxOgVML9Huk7PFElCQFbaARWGvD229/9j2RA1+pDqJ7dhyWvsmD2MLjWHn436Obi6g==
X-Received: by 2002:a50:9784:: with SMTP id e4mr5199184edb.165.1547025433847;
        Wed, 09 Jan 2019 01:17:13 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id a13-v6sm547972ejt.69.2019.01.09.01.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 01:17:13 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, linux-kernel@vger.kernel.org,
        joe@perches.com, yuzibode@126.com
Subject: [PATCH V5 1/2] kobject: to repalce printk with pr_* style
Date:   Wed,  9 Jan 2019 04:17:00 -0500
Message-Id: <99e9edd31414bd240286b5b63b39140fc74e6ca5.1547024167.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1547024167.git.tsu.yubo@gmail.com>
References: <cover.1547024167.git.tsu.yubo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repalce printk with pr_warn in kobject_synth_uevent and replace
printk with pr_err in uevent_net_init to make both consistent with
other code in kobject_uevent.c

Signed-off-by: Bo YU <tsu.yubo@gmail.com>

---
Changes in V2:
Improve the commit log, doing as the patch did.
---
 lib/kobject_uevent.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 27c6118afd1c..c87a96c4800e 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
 out:
 	if (r) {
 		devpath = kobject_get_path(kobj, GFP_KERNEL);
-		printk(KERN_WARNING "synth uevent: %s: %s",
+		pr_warn("synth uevent: %s: %s",
 		       devpath ?: "unknown device",
 		       msg ?: "failed to send uevent");
 		kfree(devpath);
@@ -765,8 +765,7 @@ static int uevent_net_init(struct net *net)
 
 	ue_sk->sk = netlink_kernel_create(net, NETLINK_KOBJECT_UEVENT, &cfg);
 	if (!ue_sk->sk) {
-		printk(KERN_ERR
-		       "kobject_uevent: unable to create netlink socket!\n");
+		pr_err("kobject_uevent: unable to create netlink socket!\n");
 		kfree(ue_sk);
 		return -ENODEV;
 	}
-- 
2.11.0

