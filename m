Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0CCC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 01:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C924206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 01:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbeLPBtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 20:49:55 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:60414 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeLPBty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 20:49:54 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9CC2472CC59;
        Sun, 16 Dec 2018 04:49:52 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8F8AB964F90; Sun, 16 Dec 2018 04:49:52 +0300 (MSK)
Date:   Sun, 16 Dec 2018 04:49:52 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: linux/blkzoned.h: fix BLKGETZONESZ and BLKGETNRZONES
 definitions
Message-ID: <20181216014951.GA14229@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the documentation in include/uapi/asm-generic/ioctl.h,
_IOW means userspace is writing and kernel is reading, and
_IOR means userspace is reading and kernel is writing.

In case of these two ioctls, kernel is writing and userspace is reading,
so they have to be _IOR instead of _IOW.

Fixes: 72cd87576d1d8 ("block: Introduce BLKGETZONESZ ioctl")
Fixes: 65e4e3eee83d7 ("block: Introduce BLKGETNRZONES ioctl")
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Since both ioctls were introduced after 4.19,
please make sure they are fixed in 4.20.
Thanks.

 include/uapi/linux/blkzoned.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 8f08ff9bdea0..6fa38d001d84 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -141,7 +141,7 @@ struct blk_zone_range {
  */
 #define BLKREPORTZONE	_IOWR(0x12, 130, struct blk_zone_report)
 #define BLKRESETZONE	_IOW(0x12, 131, struct blk_zone_range)
-#define BLKGETZONESZ	_IOW(0x12, 132, __u32)
-#define BLKGETNRZONES	_IOW(0x12, 133, __u32)
+#define BLKGETZONESZ	_IOR(0x12, 132, __u32)
+#define BLKGETNRZONES	_IOR(0x12, 133, __u32)
 
 #endif /* _UAPI_BLKZONED_H */
-- 
ldv
