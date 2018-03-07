Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754208AbeCGJto (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 04:49:44 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:53489 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754070AbeCGJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 04:49:41 -0500
X-Google-Smtp-Source: AG47ELub+EtR8rEXdAzNChKVnPfU+uvIkL/ha89Mf7+wMXZ60K8psJidIHY92n8YK7EgTjX3CSGZLw==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: nab@linux-iscsi.org
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH] target: tcm_loop: use put_device() if device_register fail
Date: Wed,  7 Mar 2018 15:18:51 +0530
Message-Id: <4903df0f8cc170db01c65ead87d3b7af9fa269c8.1520415984.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if device_register() returned an error! Always use put_device()
to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/target/loopback/tcm_loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback/tcm_loop.c
index 9cd4ffe..5dffc55 100644
--- a/drivers/target/loopback/tcm_loop.c
+++ b/drivers/target/loopback/tcm_loop.c
@@ -412,6 +412,7 @@ static int tcm_loop_setup_hba_bus(struct tcm_loop_hba *tl_hba, int tcm_loop_host
 	ret = device_register(&tl_hba->dev);
 	if (ret) {
 		pr_err("device_register() failed for tl_hba->dev: %d\n", ret);
+		put_device(&tl_hba->dev);
 		return -ENODEV;
 	}
 
-- 
1.9.1
