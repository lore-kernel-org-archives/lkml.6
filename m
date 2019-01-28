Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E80C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409DD20881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697576;
	bh=IVKk5xWO+nAh0Eu4mNo5PS6NOKrWEJ/nDEWCYkQxLkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mifbfHfqNEIWSUUaOKJ/WZk42MzYz4M9WVVRKHIUFxpmyQbcCy0mRbz8tUif5nE9q
	 uPqfJJ49ldWRwZ87j7FUjQndrBn7zZ4m66pcm/t7UF71bvBxhrz2SlizETfVV7JtPs
	 CtJeqOqrgS3E8jo0HOYUPQ6WzAaQGvZxSHIB7REg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfA1RqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbfA1PrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:47:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3397A21741;
        Mon, 28 Jan 2019 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690439;
        bh=IVKk5xWO+nAh0Eu4mNo5PS6NOKrWEJ/nDEWCYkQxLkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5UPXSGIbhV5jCDklMjHfmc0NK965e+eFVQ6zZ78sJ/ie8tSv2MVcuk7QrGwgNkdB
         jD2xNmysnTI16CRKNHhWpi8dRmAygJ7VVQbqP8UkHVeAJNems54gqTtYvysn117SLj
         pHtGtMopOt8mXtGl5TA7sJ3XSDoeWRz2HYrA0+Bg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.20 087/304] f2fs: avoid build warn of fall_through
Date:   Mon, 28 Jan 2019 10:40:04 -0500
Message-Id: <20190128154341.47195-87-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit f5d5510e7389fa264337fb524346bac9eb93adc8 ]

After merging the f2fs tree, today's linux-next build
 (x86_64_allmodconfig) produced this warning:

 In file included from fs/f2fs/dir.c:11:
 fs/f2fs/f2fs.h: In function '__mark_inode_dirty_flag':
 fs/f2fs/f2fs.h:2388:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (set)
       ^
 fs/f2fs/f2fs.h:2390:2: note: here
   case FI_DATA_EXIST:
   ^~~~

 Exposed by my use of -Wimplicit-fallthrough

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1e031971a466..ebad864c031c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2370,6 +2370,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_NEW_INODE:
 		if (set)
 			return;
+		/* fall through */
 	case FI_DATA_EXIST:
 	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
-- 
2.19.1

