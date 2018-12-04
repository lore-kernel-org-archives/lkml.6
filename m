Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D67C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF7B214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wOtS4LyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF7B214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeLDLCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:02:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbeLDLCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69DC02146D;
        Tue,  4 Dec 2018 11:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921363;
        bh=nmTklXzd1IAB7WxyavY8WHHLdTMDoUzEqYuyAxQVdeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wOtS4LyJY6Eu0qy9bLWSqK9D/4Ayz1yYYYl/I/YTM0+vieiD8RO5igF0i2S9APREW
         +3taddjC7GQwIF/veGxeZzm3dWCqYCFcZmL0HmRk9Zj0xqqa61CaCj1NKvTYbHSPwL
         pK96dk/nWUE8ImyK9WwpzZZb9G/GqQy1VO6agueM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 043/146] btrfs: tree-checker: Fix misleading group system information
Date:   Tue,  4 Dec 2018 11:48:49 +0100
Message-Id: <20181204103728.593587894@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index fa8f64119e6f..f206aec1525d 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -399,7 +399,7 @@ static int check_block_group_item(struct btrfs_fs_info *fs_info,
 	    type != (BTRFS_BLOCK_GROUP_METADATA |
 			   BTRFS_BLOCK_GROUP_DATA)) {
 		block_group_err(fs_info, leaf, slot,
-"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llu or 0x%llx",
+"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx or 0x%llx",
 			type, hweight64(type),
 			BTRFS_BLOCK_GROUP_DATA, BTRFS_BLOCK_GROUP_METADATA,
 			BTRFS_BLOCK_GROUP_SYSTEM,
-- 
2.17.1



