Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0B9C64EBA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37D520666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q93e5MXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37D520666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeJCCBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:01:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61576 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbeJCCAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1538507710; x=1570043710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UL8JbRBIj8Dgmic5yuT7Oytfq+yluzZfU5sZRa27+/M=;
  b=Q93e5MXgUNAW8YkPil9UZd1TY/CznqiDwT3PU1izo464x2JeWjMmCyG0
   8K4kDIcS5lKvwCJdQ9wZ8rWpyIosK12cOq9pttZSe8AsWrTu8uRvnJyec
   1EAuj//BBDEr/ZX93WiCQJ+CXHgKhijizkTA2jBfWt9ptHjxd0fdpPvut
   YWwYIsdyGkiLXSdVKHGujBkPJ8UAx2CzyuVD9M7W5amU025yYGn4GUBsc
   HKM4xoRAphxsGL9CXW7hyWdtRjxZKGDQ9kHskPI++SySMFinALf3K2xn3
   i/zim+Vtsoh3AmSH2WxaFEeVSD1dmMrA9PrdKC843uKAI2oPy+m4h9g5d
   A==;
X-IronPort-AV: E=Sophos;i="5.54,332,1534780800"; 
   d="scan'208";a="91076737"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2018 03:15:08 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 02 Oct 2018 12:00:50 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Oct 2018 12:15:09 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org, palmer@sifive.com
Cc:     anup@brainfault.org, hch@infradead.org,
        linux-kernel@vger.kernel.org, atish.patra@wdc.com
Subject: [PATCH v6 02/14] RISC-V: Don't set cacheinfo.{physical_line_partition,attributes}
Date:   Tue,  2 Oct 2018 12:14:55 -0700
Message-Id: <1538507707-22299-3-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
References: <1538507707-22299-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

These are just hard coded in the RISC-V port, which doesn't make any
sense.  We should probably be setting these from device tree entries
when they exist, but for now I think it's saner to just leave them all
as their default values.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/riscv/kernel/cacheinfo.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 0bc86e5f..cb35ffd8 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -22,13 +22,6 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 {
 	this_leaf->level = level;
 	this_leaf->type = type;
-	/* not a sector cache */
-	this_leaf->physical_line_partition = 1;
-	/* TODO: Add to DTS */
-	this_leaf->attributes =
-		CACHE_WRITE_BACK
-		| CACHE_READ_ALLOCATE
-		| CACHE_WRITE_ALLOCATE;
 }
 
 static int __init_cache_level(unsigned int cpu)
-- 
2.7.4

