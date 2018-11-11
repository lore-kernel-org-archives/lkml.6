Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03150C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF83220818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF83220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeKLFsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50194 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730223AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsc-0000l8-A6; Sun, 11 Nov 2018 19:58:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001qA-Ka; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Yan, Zheng" <zyan@redhat.com>,
        "Bryan Henderson" <bryanh@giraffe-data.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.776626136@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 324/366] ceph: fix llistxattr on symlink
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Yan, Zheng" <zyan@redhat.com>

commit 0abb43dcacb52145aa265f82c914375d59dfe2da upstream.

only regular file and directory have vxattrs.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
Cc: Bryan Henderson <bryanh@giraffe-data.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ceph/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -284,8 +284,7 @@ static size_t ceph_vxattrs_name_size(str
 		return ceph_dir_vxattrs_name_size;
 	if (vxattrs == ceph_file_vxattrs)
 		return ceph_file_vxattrs_name_size;
-	BUG();
-
+	BUG_ON(vxattrs);
 	return 0;
 }
 

