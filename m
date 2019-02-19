Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4217C21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/U6+ctg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfBSHrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:47:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46353 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBSHrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:47:20 -0500
Received: by mail-pf1-f194.google.com with SMTP id g6so9820011pfh.13;
        Mon, 18 Feb 2019 23:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ewn3qcr792Cyc0izeDpCIoh/T4ye1x21hf99ENaCdxA=;
        b=u/U6+ctgxecaX5OERcO3SrJKFvAWj8YgmGSAf1D2NevSdayXe+9hC4RbQ1cORt4cn9
         moC+KNKDUlREYxnZidrwz+tj1w9PSJpEv1BngPZthna1p4GZ/1wQOQkiKb3nJwzAnKyb
         hF7oIAldXzC2oVXs7tXVdcupMudd+AySdQjiYELlHQsXcBjixbMhPI0upyBVg4d7wZDu
         kXU7drSQddqFKdND5ztrrrGBFKMFYzefbR/b4t7Z8i2jJAJgPY8ZmDxxgAUNBq+rbopI
         3MQC7BIuHWuSS2kXQ1Dv1eN646vIIhsClvMydAxgxyQN0zH22Tj2cpRHu6x6s1QyAnLd
         BNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ewn3qcr792Cyc0izeDpCIoh/T4ye1x21hf99ENaCdxA=;
        b=jeVCpMb8CoQqPto6HavSBYIBieammmldgiEvRy/XCxp5OwC36RtIRtaJIjexi0FZKw
         T/X+on04odekB+xgHAKNRpej4zXZAXdjk5SjC7Lao45JuSDVIyVCoVftlX1SBwuiUxfl
         ip2Lbp3FKQp4zrllbgaMsn3kP3KHcJKRdTB9QBWqKbCVPS5xORlHaNidCc/ZnoySFmkV
         CbbKiCi4PgrY4r1Gqt3s8Xt75ofWqzKiebkc2sUKkqWXvVNwfpjiiCBDhRjVel5jqxin
         cs5abGL+bQQ6TyxWq5wag8BnzTWECUAeAJUtL9Kx43A1I5w6Iyid/RdZCBSKqPwjn42o
         WU4Q==
X-Gm-Message-State: AHQUAuY3iat0o6SVxYXp2/1VHNAEO+6s/ynu93t4RbIT8Lg/xSRMya9y
        jhfJhMOpAihA1YMAgu1DxjEnif5EjdY=
X-Google-Smtp-Source: AHgI3Ib+KCpmBmwd4mkn0DodrccUkoBBDvBz1Vtmiez77djYp7YpsuYm9y46apORDeXuAzNYK/EK0g==
X-Received: by 2002:a63:5d5f:: with SMTP id o31mr22792746pgm.414.1550562439969;
        Mon, 18 Feb 2019 23:47:19 -0800 (PST)
Received: from ubuntu14_04.bitmain.com (61-220-100-83.HINET-IP.hinet.net. [61.220.100.83])
        by smtp.gmail.com with ESMTPSA id o2sm19049671pgq.29.2019.02.18.23.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 23:47:19 -0800 (PST)
From:   pierre Kuo <vichy.kuo@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pierre Kuo <vichy.kuo@gmail.com>
Subject: [PATCH 1/1] of: reserved_mem: fix reserve memory leak
Date:   Tue, 19 Feb 2019 15:45:00 +0800
Message-Id: <20190219074500.16454-1-vichy.kuo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __reserved_mem_init_node will call region specific reserved memory
init codes, but once all compatibled init codes failed, the memory region
will left in memory.reserved and cause leakage.

Take cma reserve memory DTS for example, if user declare 1MB size,
which is not align to (PAGE_SIZE << max(MAX_ORDER - 1,
pageblock_order)), rmem_cma_setup will return -EINVAL.
Meanwhile, rmem_dma_setup will also return -EINVAL since "reusable"
property is not set. If finally there is no reserved memory init pick up
this memory, kernel will left the 1MB leak in memory.reserved.

This patch will remove this kind of memory from memory.reserved, only
when __reserved_mem_init_node return neither 0 nor -ENOENT.

Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
---
 drivers/of/of_reserved_mem.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1977ee0adcb1..d3bde057ec46 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -181,6 +181,7 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
 {
 	extern const struct of_device_id __reservedmem_of_table[];
 	const struct of_device_id *i;
+	int ret = -ENOENT;
 
 	for (i = __reservedmem_of_table; i < &__rmem_of_table_sentinel; i++) {
 		reservedmem_of_init_fn initfn = i->data;
@@ -189,13 +190,14 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
 		if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
 			continue;
 
-		if (initfn(rmem) == 0) {
+		ret = initfn(rmem);
+		if (ret == 0) {
 			pr_info("initialized node %s, compatible id %s\n",
 				rmem->name, compat);
-			return 0;
+			break;
 		}
 	}
-	return -ENOENT;
+	return ret;
 }
 
 static int __init __rmem_cmp(const void *a, const void *b)
@@ -255,7 +257,9 @@ void __init fdt_init_reserved_mem(void)
 		int len;
 		const __be32 *prop;
 		int err = 0;
+		int nomap;
 
+		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 		prop = of_get_flat_dt_prop(node, "phandle", &len);
 		if (!prop)
 			prop = of_get_flat_dt_prop(node, "linux,phandle", &len);
@@ -265,8 +269,16 @@ void __init fdt_init_reserved_mem(void)
 		if (rmem->size == 0)
 			err = __reserved_mem_alloc_size(node, rmem->name,
 						 &rmem->base, &rmem->size);
-		if (err == 0)
-			__reserved_mem_init_node(rmem);
+		if (err == 0) {
+			err = __reserved_mem_init_node(rmem);
+			if (err != 0 && err != -ENOENT) {
+				pr_info("node %s compatible matching fail\n",
+					rmem->name);
+				memblock_free(rmem->base, rmem->size);
+				if (nomap)
+					memblock_add(rmem->base, rmem->size);
+			}
+		}
 	}
 }
 
-- 
2.17.1

