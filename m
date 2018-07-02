Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A449C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA89F255A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA89F255A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753599AbeGBHOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:14:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51842 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeGBHOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:14:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZt28-0000vh-6d; Mon, 02 Jul 2018 07:14:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     Richard Russon <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>,
        linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] partitions/ldm: remove redundant pointer dgrp
Date:   Mon,  2 Jul 2018 08:13:59 +0100
Message-Id: <20180702071359.6534-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer dgrp is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'dgrp' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/partitions/ldm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 0417937dfe99..16766f267559 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -830,7 +830,6 @@ static bool ldm_parse_dgr4 (const u8 *buffer, int buflen, struct vblk *vb)
 {
 	char buf[64];
 	int r_objid, r_name, r_id1, r_id2, len;
-	struct vblk_dgrp *dgrp;
 
 	BUG_ON (!buffer || !vb);
 
@@ -853,8 +852,6 @@ static bool ldm_parse_dgr4 (const u8 *buffer, int buflen, struct vblk *vb)
 	if (len != get_unaligned_be32(buffer + 0x14))
 		return false;
 
-	dgrp = &vb->vblk.dgrp;
-
 	ldm_get_vstr (buffer + 0x18 + r_objid, buf, sizeof (buf));
 	return true;
 }
-- 
2.17.1

