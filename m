Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643E7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FB52148D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 03:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bDK7+8ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbeLZDqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 22:46:37 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:52818 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbeLZDqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 22:46:36 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 325C6C18
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 03:46:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5P1QBGeq0mc8 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 21:46:35 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 0246BBE7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:46:35 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id s3so12527466iob.15
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 19:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TtSxfEQF5LcUD9sDnfZ8/Cq5qwU6OBjp2xesuZJmp30=;
        b=bDK7+8ulXPDCF6xXIo6GnyvOvEnaYz0RspwPrgXlrsxIcPGUnpcBJTxTCuo2XBuWzF
         2ocJRH8TAjz9guxrdXXXX8OanvnzZkH7o2IBjzK7kbPwQzdmFLVodA0qRN+ChXPwWAkz
         tip3Nbdht8ccBJdrFBqZeZO4dOUaIv8mNK/2I5L9lQmz2DWj2AcODoyEk34waVfv8Zv7
         ofhhLf4Zwiaf1QKVYGuZfBOg0WFjhqHXX2ZIz4ePqT2S0/JjK4x2MH8Sc1RQME052HRl
         Z4tJJO63qQ8MbIq5UOosYu0Rp56F03HnirRMG69cTrEboAASp9Kx8H6hs3EoNH8meLbi
         Sb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TtSxfEQF5LcUD9sDnfZ8/Cq5qwU6OBjp2xesuZJmp30=;
        b=M3LT2HrNh1JZQG4PbmFQd24DF9EuqyCwqoycUvGf9waxAN8zbuY95Rwlp2ByCeB9nn
         Re4EJ4ei6bvEoxL3xLZOeJM3AB+Tn+uCFpcHblDWV2luPdVajHMVlbC3qMXvuKwotLCn
         JF0UOeepC//jNebpZYAwxGCaXFdVzUqLixWSXiQzG9Lt+OpW/34CWaFqacfpSnDoqL6Y
         swenYdUOmT/CWE5f3sJArtQWQ/zxhtQOexMdPQ8kL6/8oP+en4BYpJJHsT8+KkJ0Xcjv
         bLFtLeS1n6KDgbaQ/mmCC1mmsjXEuAjySft9VGbSUMshNclBoXf7LxPBGlsGFC02ePHl
         Voqw==
X-Gm-Message-State: AJcUukctOkMw//y0POdqLeZCaMTvw5aUjAyGbNOtQnZa9WlyMbfsYfgn
        grB9e8ONehAMPXQSzqOgbi5WhWvVEr2bM8y1DzVe8JBu+ZbINP2cwzaoetlPGgx84c0utWEXzjh
        3Qu7hs94wf5k5ZhnhSpKjsjawMImb
X-Received: by 2002:a6b:1807:: with SMTP id 7mr11823312ioy.167.1545795993972;
        Tue, 25 Dec 2018 19:46:33 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5ai2uAQEIacv8zjvRRrDGodWoIrj/VDxN35dP5YyRZ3O1o6xK1rwPNNSob0wxHSopDuJ9OIQ==
X-Received: by 2002:a6b:1807:: with SMTP id 7mr11823304ioy.167.1545795993728;
        Tue, 25 Dec 2018 19:46:33 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id r21sm15723976ioc.18.2018.12.25.19.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 19:46:33 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: add a check for sysfs_create_group
Date:   Tue, 25 Dec 2018 21:46:06 -0600
Message-Id: <20181226034607.73523-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case sysfs_create_group fails, let's check its return value and
issues an error message.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 fs/btrfs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 3717c864ba23..62529153a51a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -889,6 +889,8 @@ void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 	 */
 	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
 	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
+	if (ret)
+		pr_err("failed to create btrfs_feature_attr_group.\n");
 }
 
 static int btrfs_init_debugfs(void)
-- 
2.17.2 (Apple Git-113)

