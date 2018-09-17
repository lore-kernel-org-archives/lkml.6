Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA92ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F74214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="Yts2m2n7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F74214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbeIRBkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:20 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44508 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbeIRBkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:18 -0400
Received: by mail-qt0-f196.google.com with SMTP id k38-v6so16530923qtk.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfsFRrZ6KAlLBf436Eo8OYltlmn/LipQqbccNRty++w=;
        b=Yts2m2n77dGljb6WCOErVh4iagfMKclnA17JeB6GN8Yw9gOnrK4AOiHd/gS/d0kOeD
         qWBNSEKhnY+V7oamoTO2ZsCHx+1fMVi/AMl/1A4YAQSP/5XdKMIL+7kwN2f4hnY2lEDQ
         uNDPmSTTeoYC56BjfTRiE8M3PWpxVPyQP5HBQk5c+D/Scrbw0huPZIC51lGKkVAyQFZ4
         Icxmhg1YZ+NxCVbn+T0EV80D1HwsVJiueslpA8C9a4WEPn+410N58KeBXSp0hZeBwcgX
         9qZYDbFw+t7mhj8bQjZ+9/0Y0OWVS3az0upIVvn9ih7gXl8NyccOBN+fgY1NErYaxaJk
         yDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfsFRrZ6KAlLBf436Eo8OYltlmn/LipQqbccNRty++w=;
        b=DjaJnBOp1TLbvkClKxWLqufzTeidf26TYJbcy8efsDbpmfbqUTBTCnaZYqhaug+Q7i
         Nj/6Fnz42WDWpw+FBe018PemZL9IOV/YZRO0sekTBVvmJDbcAn2L3bZqqIBsozRPtfnz
         G5qn/Y9yENxSbvcJhMkU/Fzo3yiXRv6aJhZJdci3RRfoMjmAJG7C7GK6ltlVxgy8yHms
         f7puJzWSSkRxmdCpymaispugKme2dBz3scngnekH4avhqawBrr0bwKE2+zYKt4VGBqkO
         XQtpyQ2RdY/0tKMKkevgr38ciNtC/4t1LVI8hX29MnJRmnh8gm+psEALo3SNYK3mMO1d
         Kffw==
X-Gm-Message-State: APzg51DLx02eBQimpvfZOAahFsiiy+zK59dYKgd8TmBVlYOK6eO/6GK7
        R0rFPoBVCoK7pqkJHgIUyu26jdgHBDAmwOTO
X-Google-Smtp-Source: ANB0VdZkRvLHdFOU5BpYc2IKKsDUVhAs/zvaeYgC/TQN2jlxFOabZDhWa0r/3drv4eFU6HsVxPjSlg==
X-Received: by 2002:aed:31a6:: with SMTP id 35-v6mr19220080qth.26.1537215086365;
        Mon, 17 Sep 2018 13:11:26 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:25 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 15/17] orangefs: avoid fsync service operation on flush
Date:   Mon, 17 Sep 2018 20:10:52 +0000
Message-Id: <20180917201054.3530-16-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, an fsync call is sent to the server even if no data
changed.  This resulted in a rather severe (50%) performance regression
under certain metadata-heavy workloads.

In the past, everything was direct IO.  Nothing happend on a close call.
An explicit fsync call would send an fsync request to the server which
in turn fsynced the underlying file.

Now there are cached writes.  Then fsync began writing out dirty pages
in addition to making an fsync request to the server, and close began
calling fsync.

With this commit, close only writes out dirty pages, and does not make
the fsync request.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/file.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 5eda483263ae..d5ecfea3288a 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -596,7 +596,24 @@ static int orangefs_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 int orangefs_flush(struct file *file, fl_owner_t id)
 {
-	return vfs_fsync(file, 0);
+	/*
+	 * This is vfs_fsync_range(file, 0, LLONG_MAX, 0) without the
+	 * service_operation in orangefs_fsync.
+	 *
+	 * Do not send fsync to OrangeFS server on a close.  Do send fsync
+	 * on an explicit fsync call.  This duplicates historical OrangeFS
+	 * behavior.
+	 */
+	struct inode *inode = file->f_mapping->host;
+
+	if (inode->i_state & I_DIRTY_TIME) {
+		spin_lock(&inode->i_lock);
+		inode->i_state &= ~I_DIRTY_TIME;
+		spin_unlock(&inode->i_lock);
+		mark_inode_dirty_sync(inode);
+	}
+
+	return filemap_write_and_wait_range(file->f_mapping, 0, LLONG_MAX);
 }
 
 /** ORANGEFS implementation of VFS file operations */
-- 
2.19.0

