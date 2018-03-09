Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbeCIKvw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:51:52 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:41080 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeCIKvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:51:49 -0500
X-Google-Smtp-Source: AG47ELvhash6vQ4/bZjBbiZOKoWNiyk8QQz5B7XJFsHfmbfPr5KMSS0FvDgKYJb4NWtNZoxztG2rZw==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        richard@nod.at, cyrille.pitchen@wedev4u.fr, dedekind1@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 1/2] mtd: use put_device() if device_register fail
Date: Fri,  9 Mar 2018 16:20:48 +0530
Message-Id: <39c4af723ea37cd05976a17cb9c1fbc975496ffd.1520592440.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1520592440.git.arvind.yadav.cs@gmail.com>
References: <cover.1520592440.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520592440.git.arvind.yadav.cs@gmail.com>
References: <cover.1520592440.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if device_register() returned an error! Always use put_device()
to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mtd/mtdcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 28553c8..4d77ca2 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -586,6 +586,7 @@ int add_mtd_device(struct mtd_info *mtd)
 	return 0;
 
 fail_added:
+	put_device(&mtd->dev);
 	of_node_put(mtd_get_of_node(mtd));
 	idr_remove(&mtd_idr, i);
 fail_locked:
-- 
1.9.1
