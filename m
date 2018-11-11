Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193EFC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72D7208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72D7208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeKKLIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 06:08:49 -0500
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:49434 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726478AbeKKLIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 06:08:49 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 394C6180A8CBF;
        Sun, 11 Nov 2018 01:21:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: roll88_2d43c84fc043d
X-Filterd-Recvd-Size: 1509
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sun, 11 Nov 2018 01:21:50 +0000 (UTC)
Message-ID: <7302f4a13c1cbf62b07f636878ce25fcca84b6c4.camel@perches.com>
Subject: [PATCH] xfs: Remove noinline from #define STATIC
From:   Joe Perches <joe@perches.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 10 Nov 2018 17:21:49 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce total object size quite a bit (~32KB) and presumably
improve performance at the same time.

Total object size old vs new (x86-64 defconfig with xfs)

    text	   data	    bss	    dec	    hex	filename
- 959351	 165573	    632	1125556	 112cb4	(TOTALS) (old)
+ 924683	 165669	    632	1090984	 10a5a8	(TOTALS) (new)

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/xfs/xfs_linux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index edbd5a210df2..f33c8b626bca 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -242,7 +242,7 @@ static inline uint64_t howmany_64(uint64_t x, uint32_t y)
 #endif /* XFS_WARN */
 #endif /* DEBUG */
 
-#define STATIC static noinline
+#define STATIC static
 
 #ifdef CONFIG_XFS_RT
 

