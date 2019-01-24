Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69B1C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CFB218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357953;
	bh=1I9A8nj+YMQigtI79tfIpDY8N9crWfZv0JBJFghz2/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v1Rgy4ZEv1AF4HO4o7Tz/3biSbw6XJoiHchAFRY74sW3yqBbcnWkuomRuEDp2rc7X
	 CkdHyLelK34BH95nUV4Qu187p8h+QpSfuLRBrQf516Kthwp7YKrTGBdnVgFfjrLPod
	 OhdSaTEDlIWwC3mzi+fy31Rnec+J16b04iTJ4ne0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbfAXTZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:25:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730427AbfAXTZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:25:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF3E5218D2;
        Thu, 24 Jan 2019 19:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357942;
        bh=1I9A8nj+YMQigtI79tfIpDY8N9crWfZv0JBJFghz2/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKeFKU7ner3x9FgtDo8bBy3Z7zGOZ/UYVmT1Y3OCiClDpWzBb4kgj2Ar7dcpFjt4C
         WjLIUwnkYZ/WWSOa9qy+HngX48LtQ7GKQqSHpHMvcolX0xLdSif9NMAp5Ys8d1MQUf
         njNjmJmegUTdiPsvcIUH5OEcHXTFLHmd/4tofXYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 008/104] f2fs: remove an obsolete variable
Date:   Thu, 24 Jan 2019 20:18:57 +0100
Message-Id: <20190124190155.795525225@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit fb58ae22067e0595d974e3d856522c1ed6d2d7bf upstream.

This patch removes an obsolete variable used in add_free_nid.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Picked as dependency of commit 30a61ddf8117 "f2fs: fix race condition
 in between free nid allocator/initializer"]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/node.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1430,7 +1430,6 @@ static int add_free_nid(struct f2fs_sb_i
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i;
 	struct nat_entry *ne;
-	bool allocated = false;
 
 	if (!available_free_memory(sbi, FREE_NIDS))
 		return -1;
@@ -1444,8 +1443,6 @@ static int add_free_nid(struct f2fs_sb_i
 		ne = __lookup_nat_cache(nm_i, nid);
 		if (ne && (!get_nat_flag(ne, IS_CHECKPOINTED) ||
 				nat_get_blkaddr(ne) != NULL_ADDR))
-			allocated = true;
-		if (allocated)
 			return 0;
 	}
 


