Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FE2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EA820989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696196;
	bh=u1nfwmX8QGYdJ2mubzopu3dIW9gr9/sHa4ZzuAqjgAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qO5m8Q2jVNCLjjeF0d98wBZXEV4aDStE4CBLyZYKIIlDd8H8rAK2hMtwD2ObntFt6
	 3FayyYnUV7zQu8RMA9N428VzU1rX5+J4ly8SNnKb+63wzjF/hR4SK6A4QKvyWLW+mQ
	 e9RXwOyE9I0fMgutXvuIg/qjsxx9th4zNbpfUm0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbfA1RXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:23:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730562AbfA1QDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:03:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 887AD21848;
        Mon, 28 Jan 2019 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691379;
        bh=u1nfwmX8QGYdJ2mubzopu3dIW9gr9/sHa4ZzuAqjgAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Stov3nExay0QP6n5QVUajM/MuDNEJPh8+ur/5He+oc/MqiJjqnwYQHVX1AzMVbxvl
         aPwbvgqKncZTNaL4Fk0GSaunC3W704saBhQtuaVeKmIeYdAckFzS944Ay4NOrer+Gx
         Dc0u6igQlKLAblSp5TMeTO2C6dtE1NXXmHz0pDFk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 073/258] f2fs: avoid build warn of fall_through
Date:   Mon, 28 Jan 2019 10:56:19 -0500
Message-Id: <20190128155924.51521-73-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index ecb735142276..462a2fb8aa69 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2311,6 +2311,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_NEW_INODE:
 		if (set)
 			return;
+		/* fall through */
 	case FI_DATA_EXIST:
 	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
-- 
2.19.1

