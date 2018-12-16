Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D41C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 02:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092B22084D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 02:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbeLPCUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 21:20:42 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:52588 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeLPCUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 21:20:42 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 696D172CC59;
        Sun, 16 Dec 2018 05:20:40 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 59D0C96500D; Sun, 16 Dec 2018 05:20:40 +0300 (MSK)
Date:   Sun, 16 Dec 2018 05:20:40 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: linux/fs.h: update comment about reserved ioctl numbers
Message-ID: <20181216022040.GA14873@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit 72cd87576d1d8 ("block: Introduce BLKGETZONESZ ioctl") and
commit 65e4e3eee83d7 ("block: Introduce BLKGETNRZONES ioctl") added
two more ioctls of type 0x12, update the comment about ioctl numbers
reserved for zoned block devices.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index a441ea1bfe6d..2af9da218c33 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -228,7 +228,7 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 /*
- * A jump here: 130-131 are reserved for zoned block devices
+ * A jump here: 130-133 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
  */
 
-- 
ldv
