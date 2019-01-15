Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D119DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D8120675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570352;
	bh=GFRLipEkRrX6uppitMy2XAUe4goycFeKaWURbInAUfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sr5prJGI6csj6O1zjAgS/D14REpYMtQPGlLdQxzj5CRM54juLrJLrUIAfsD+ZbPOb
	 0MJ7wbqtwyjsFkChBGXQmYqpgzDWF2kIM24fdtwJVtGEf5vgQeNDwjVGjD1i+CHjGq
	 xGlIqrZpGhfd6nfNURcfqhMp5txbrl54MtaVRlsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbfAOQjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732225AbfAOQjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:39:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 981B320859;
        Tue, 15 Jan 2019 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570347;
        bh=GFRLipEkRrX6uppitMy2XAUe4goycFeKaWURbInAUfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXHCOk6o7mZppOtK5shw3b+tNeXPw2Y8DuKhL4Nt+SVL4LZspMf/pxD3eePpkg5of
         u06SlBDxGqx7AN30T449engIFYtgtJAYhEobE85eA6VLVyAnvPx5mQ31ZSJT3y2xIc
         FrtpRdueMvDJL8LSacAhQDBArlJS7ptIQ0/CKMig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 24/51] btrfs: tree-checker: use %zu format string for size_t
Date:   Tue, 15 Jan 2019 17:35:20 +0100
Message-Id: <20190115154850.065567596@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 7cfad65297bfe0aa2996cd72d21c898aa84436d9 upstream.

The return value of sizeof() is of type size_t, so we must print it
using the %z format modifier rather than %l to avoid this warning
on some architectures:

fs/btrfs/tree-checker.c: In function 'check_dir_item':
fs/btrfs/tree-checker.c:273:50: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'u32' {aka 'unsigned int'} [-Werror=format=]

Fixes: 005887f2e3e0 ("btrfs: tree-checker: Add checker for dir item")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-checker.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -223,7 +223,7 @@ static int check_dir_item(struct btrfs_r
 		/* header itself should not cross item boundary */
 		if (cur + sizeof(*di) > item_size) {
 			dir_item_err(root, leaf, slot,
-		"dir item header crosses item boundary, have %lu boundary %u",
+		"dir item header crosses item boundary, have %zu boundary %u",
 				cur + sizeof(*di), item_size);
 			return -EUCLEAN;
 		}


