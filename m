Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60831C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E33E2238C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1XIe6n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E33E2238C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeHIUhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:37:17 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43089 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeHIUhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:37:16 -0400
Received: by mail-pl0-f66.google.com with SMTP id x6-v6so2870909plv.10;
        Thu, 09 Aug 2018 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kM+SE/GanJfI/Ih58/7lkGHceeH98C7iNNYae6MdgJg=;
        b=Z1XIe6n1fc4wP/Mgd54n7clah+FZowPBAoU/23bYMsdQiiKBNILFO7kkkSbPwopHo4
         T8a4MSKnbIR4t62E8VGtUnucT2QekgMElMxjfkRk2qADp5H1dj2JjbqVWdPWiTPolUL2
         tMlOSLACPs5xMDNX+ul21b5CyURDb4rJygSPVsioGbKBr9T411/z7eHLg5Z2CU9rFqf1
         6tQKRfPe2M5af8wx1anfVH6Xjzr/w1LHApwgOl9s7HR7KzD0I1twE6EMEdbHrbp2PcTh
         Z6GKMW9L8wzqh4EJi4oLDtVWG5bzS0uTC7AwHZmD2EiSk4GAfFzftsUdjtUt4sKKkjkS
         OrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=kM+SE/GanJfI/Ih58/7lkGHceeH98C7iNNYae6MdgJg=;
        b=h9gXxOeQHML9S+JBoxcILqMR8waiQq8bUkRjGILnOPCKwgQJhLay3EiaSJmciX3MwB
         cbEPgJseweKRoiyYf5NJAvHxOEhPhwbYZPQ3hn4iirGR2ZBNKUzcTBfjQb978TxFQepF
         zcsshu4QL5pf3BVUQy0TV5FSWQHqQ2eNNFKu6mIflREufINUKau0JF4I1Iw2mokrBsu+
         H6+/A5yu2l5gg1ICgPddYNjGN+hansQAnSTTUfuOhsOn8f7GpoEqXypHGgO5AWkT/xhq
         SVYWf88/a+gSF9Bww6QrsSwhXFFF5r9zHx6CppiMEIVvsr5KJzZsI1MadFWIcg3ErOi/
         aZSA==
X-Gm-Message-State: AOUpUlFFeFPpBjQug5ybOHsmtAG6UjnoOVfo7ditw7uxNoqo0GfhTSPy
        aIWYvuPoFt8Rqplx1K2+Kjk=
X-Google-Smtp-Source: AA+uWPydeaX1uhq+jJ+sHsyiskd+4NFLI7HQ1kkmYZikKMlReQWloKs9Z0OrQDCbk+6P7HfoBRpEwg==
X-Received: by 2002:a17:902:8482:: with SMTP id c2-v6mr3012007plo.45.1533838275970;
        Thu, 09 Aug 2018 11:11:15 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id w70-v6sm13850086pgd.18.2018.08.09.11.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:11:15 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 03/12] btrfs-progs: add new HMZONED feature flag
Date:   Fri, 10 Aug 2018 03:10:56 +0900
Message-Id: <20180809181105.12856-3-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809181105.12856-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
 <20180809181105.12856-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this feature enabled, a zoned block device aware btrfs allocates block
groups aligned to the device zones and always write in sequential zones at
the zone write pointer position.

Enabling this feature also force disable conversion from ext4 volumes.

Note: this flag can be moved to COMPAT_RO, so that older kernel can read
but not write zoned block devices formatted with btrfs.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 cmds-inspect-dump-super.c | 3 ++-
 ctree.h                   | 4 +++-
 fsfeatures.c              | 8 ++++++++
 fsfeatures.h              | 2 +-
 libbtrfsutil/btrfs.h      | 1 +
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/cmds-inspect-dump-super.c b/cmds-inspect-dump-super.c
index e965267c..4e365ead 100644
--- a/cmds-inspect-dump-super.c
+++ b/cmds-inspect-dump-super.c
@@ -228,7 +228,8 @@ static struct readable_flag_entry incompat_flags_array[] = {
 	DEF_INCOMPAT_FLAG_ENTRY(EXTENDED_IREF),
 	DEF_INCOMPAT_FLAG_ENTRY(RAID56),
 	DEF_INCOMPAT_FLAG_ENTRY(SKINNY_METADATA),
-	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES)
+	DEF_INCOMPAT_FLAG_ENTRY(NO_HOLES),
+	DEF_INCOMPAT_FLAG_ENTRY(HMZONED)
 };
 static const int incompat_flags_num = sizeof(incompat_flags_array) /
 				      sizeof(struct readable_flag_entry);
diff --git a/ctree.h b/ctree.h
index 4719962d..6d805ecd 100644
--- a/ctree.h
+++ b/ctree.h
@@ -489,6 +489,7 @@ struct btrfs_super_block {
 #define BTRFS_FEATURE_INCOMPAT_RAID56		(1ULL << 7)
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 10)
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
@@ -509,7 +510,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_RAID56 |		\
 	 BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
-	 BTRFS_FEATURE_INCOMPAT_NO_HOLES)
+	 BTRFS_FEATURE_INCOMPAT_NO_HOLES |		\
+	 BTRFS_FEATURE_INCOMPAT_HMZONED)
 
 /*
  * A leaf is full of items. offset and size tell us where to find
diff --git a/fsfeatures.c b/fsfeatures.c
index 7d85d60f..53396dd4 100644
--- a/fsfeatures.c
+++ b/fsfeatures.c
@@ -86,6 +86,14 @@ static const struct btrfs_fs_feature {
 		VERSION_TO_STRING2(4,0),
 		NULL, 0,
 		"no explicit hole extents for files" },
+#ifdef BTRFS_ZONED
+	{ "hmzoned", BTRFS_FEATURE_INCOMPAT_HMZONED,
+		"hmzoned",
+		NULL, 0,
+		NULL, 0,
+		NULL, 0,
+		"support Host-Managed Zoned devices" },
+#endif
 	/* Keep this one last */
 	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
 };
diff --git a/fsfeatures.h b/fsfeatures.h
index 3cc9452a..0918ee1a 100644
--- a/fsfeatures.h
+++ b/fsfeatures.h
@@ -25,7 +25,7 @@
 		| BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
 
 /*
- * Avoid multi-device features (RAID56) and mixed block groups
+ * Avoid multi-device features (RAID56), mixed block groups, and hmzoned device
  */
 #define BTRFS_CONVERT_ALLOWED_FEATURES				\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF			\
diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index c293f6bf..c6a60fbc 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -268,6 +268,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID56		(1ULL << 7)
 #define BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA	(1ULL << 8)
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 10)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.18.0

