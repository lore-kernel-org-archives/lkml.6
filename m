Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806E7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4597220645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571675;
	bh=TeGd1e5ZfDxwdJdkHapUww5LNibYh5hXyI35TNUlU3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jxofWVzTEmdmREGVgejTMHXfeWQk9/iEiQsCL8wO14dwlaNIGHkuwi/1mwE0EwmrW
	 Qia1wX7ik38kbzQc37xJQQY8vwZpGeg5RfMp5WCZKUmk7Fv7zwG++Dkl6v/nJrwJl3
	 EUhEuz0Q9fw3lAPAk5RQkzZ+MRd3w2DFNj2IGB1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbfAOQh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731932AbfAOQhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3BB020859;
        Tue, 15 Jan 2019 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570272;
        bh=TeGd1e5ZfDxwdJdkHapUww5LNibYh5hXyI35TNUlU3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgGfn4sGRbZ/6kjJqfTXulx61mAYaq/nq2wHH6Q6QfDRO6fR5bOY4vUbb1vkNjXdL
         j2F1JFP33gcgW5qMyvUgbrMnZKk3Lzss4Dy0ciZ38ZBVPO8U/+s99HPfavFZaLU0yp
         wyyZSEJrAXOJhj32cigaOL8QHm77MAAp6azdP9Pg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 32/51] btrfs: tree-checker: Fix misleading group system information
Date:   Tue, 15 Jan 2019 17:35:28 +0100
Message-Id: <20190115154851.202160834@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
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

From: Shaokun Zhang <zhangshaokun@hisilicon.com>

commit 761333f2f50ccc887aa9957ae829300262c0d15b upstream.

block_group_err shows the group system as a decimal value with a '0x'
prefix, which is somewhat misleading.

Fix it to print hexadecimal, as was intended.

Fixes: fce466eab7ac6 ("btrfs: tree-checker: Verify block_group_item")
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-checker.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -399,7 +399,7 @@ static int check_block_group_item(struct
 	    type != (BTRFS_BLOCK_GROUP_METADATA |
 			   BTRFS_BLOCK_GROUP_DATA)) {
 		block_group_err(fs_info, leaf, slot,
-"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llu or 0x%llx",
+"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx or 0x%llx",
 			type, hweight64(type),
 			BTRFS_BLOCK_GROUP_DATA, BTRFS_BLOCK_GROUP_METADATA,
 			BTRFS_BLOCK_GROUP_SYSTEM,


