Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeCIKvy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:51:54 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:42288 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeCIKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:51:52 -0500
X-Google-Smtp-Source: AG47ELvuSXEEFbAw31YtN95ADF8woQk9KXMA2FcivS0TSzvB/s0LHxjMTsVqaNzPBiWSNLgqtQVABg==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        richard@nod.at, cyrille.pitchen@wedev4u.fr, dedekind1@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH 2/2] mtd: ubi: use put_device() if device_register fail
Date: Fri,  9 Mar 2018 16:20:49 +0530
Message-Id: <5d9b08afdad2fbc65bac48d8ae22f4925bb80512.1520592440.git.arvind.yadav.cs@gmail.com>
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
 drivers/mtd/ubi/vmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 3fd8d7f..db85b68 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -609,6 +609,7 @@ int ubi_add_volume(struct ubi_device *ubi, struct ubi_volume *vol)
 	return err;
 
 out_cdev:
+	put_device(&vol->dev);
 	cdev_del(&vol->cdev);
 	return err;
 }
-- 
1.9.1
