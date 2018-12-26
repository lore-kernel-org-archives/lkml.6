Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFF6218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gtWENrzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeLZGFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:05:47 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:53460 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLZGFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:05:46 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 2505AB11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 06:05:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YoOvGUQT9OeK for <linux-kernel@vger.kernel.org>;
        Wed, 26 Dec 2018 00:05:45 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id ED1D2B03
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 00:05:44 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id g7so18936576itg.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VdD+UO+ILrngC0Nbw5DEj9TXjoZuW1rQgF8800XPhTs=;
        b=gtWENrzsMyUYEQYz34N7JKbHOgLYlczkgcOsN1T7AkOjSt3GG1gCe+hUSR009pS/Np
         2Xg6SDbOjf3xZD8kxTLt08zrVTZa3K2Xg2jmy6tmaCc7RTrPwkvbnmKl5dn48qPYJsj4
         RGi6MlnTJ2Focw5VR4Sztf/hJ8OTg4FQetSv/JSlXKvAeU5019Tki0OVF5eTLPC/baSR
         LImAze1/XPxLfqdyS/cGgdN+A9G794D3l+Rtl7yfvtN9Mgcq1aCYkH+xag9tdeYIwnZf
         UGzJ6aaola60F1J9IihzYwXOoYOHVkcFrszeGSt3GNNI7mv1qsEEIXiKDqwA5nWM6dK0
         mtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VdD+UO+ILrngC0Nbw5DEj9TXjoZuW1rQgF8800XPhTs=;
        b=HHmF+i3wknKlboTaRZGFf9k8a0QPMMW2mvU/4IeWGpO9Ih3uLGUM0Z6dvujX3KZcmk
         tCQBwiPsRHJBESJZuL3nEiDGliNl5BsPueVQuJu+jhoc4iAUKSHBVC13Y5MB9xaVRAbk
         /aciHx4BpeEYU0t/hKMJj/JDY+ZSSM4qlV7KCJzO0JZojj1qvu6fjz83cZTPYRrx+kL7
         +v+M0+3RFsLbPaUBuQ/2f44LcSIhV3zhNObCUlfkYkKrUrj8rJ6rwqMvOymVISr5SpW1
         XN2uxTejvTnyv/bl94n+RdDaSIlopozmM0P+kMLwxAFYj4ZzFeWjMw5Tgnrw3IFXIhO2
         vb0w==
X-Gm-Message-State: AJcUukeA6URzRIxS/TQGDzzzwaV0453c0njM8LkumF+dGsKpNR9E8k+o
        0QiN9dOux3wpr06jjibn0Z9bGx9vj46ortG0K4YEVaQrhl9KlXJfJtIh3w3WA/qHKFQaqvYZ19j
        L/cz67J8HhpV2DakwOYi8JYmbQCDZ
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr13325995ioa.266.1545804344595;
        Tue, 25 Dec 2018 22:05:44 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6OEE5yHfZE/46d/cfROAlYVVCCuSoQ1CW858/EVvBWKGRreuwdA96MTEcxACN9HTCOzVSARg==
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr13325984ioa.266.1545804344360;
        Tue, 25 Dec 2018 22:05:44 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id c25sm15604439ioa.86.2018.12.25.22.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 22:05:43 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xfs: add a check for xfs_trans_commit
Date:   Wed, 26 Dec 2018 00:05:16 -0600
Message-Id: <20181226060516.75103-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfs_trans_commit could fails. The checks issues an error message upon
its failure.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 fs/xfs/xfs_super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d3e6cd063688..8ec2e3c8e946 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1010,6 +1010,7 @@ xfs_fs_dirty_inode(
 	struct xfs_inode		*ip = XFS_I(inode);
 	struct xfs_mount		*mp = ip->i_mount;
 	struct xfs_trans		*tp;
+	int error;
 
 	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
 		return;
@@ -1021,7 +1022,10 @@ xfs_fs_dirty_inode(
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_TIMESTAMP);
-	xfs_trans_commit(tp);
+	error = xfs_trans_commit(tp);
+	if (error)
+		xfs_err(mp,
+				"Error in xfs_trans_commit: %d\n", error);
 }
 
 /*
-- 
2.17.2 (Apple Git-113)

