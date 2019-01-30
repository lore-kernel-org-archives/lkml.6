Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C57C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA9A20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfA3XPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:15:48 -0500
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:26763
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbfA3XPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:15:48 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AKAADVL1Jc/zin0HYNVhsBAQEBAwE?=
 =?us-ascii?q?BAQcDAQEBgVEGAQEBCwEBgmmBKoQDiBqMRQaBEIlZiUuFDoF7KIRMAwKDKzQ?=
 =?us-ascii?q?JDQEDAQEBAQEBAoEJTgEBBAsBhHknBFIoAQwCJgJJFhODI4F0q35xfDMaih2?=
 =?us-ascii?q?BC4FziVl4gQeBRIppglcCkGo5kTUJhy6LHAwCgi6IEQOHYgEtgnGaCoIOTS4?=
 =?us-ascii?q?KgycJjFGED2WCUYR8iDMBAQ?=
X-IPAS-Result: =?us-ascii?q?A2AKAADVL1Jc/zin0HYNVhsBAQEBAwEBAQcDAQEBgVEGA?=
 =?us-ascii?q?QEBCwEBgmmBKoQDiBqMRQaBEIlZiUuFDoF7KIRMAwKDKzQJDQEDAQEBAQEBA?=
 =?us-ascii?q?oEJTgEBBAsBhHknBFIoAQwCJgJJFhODI4F0q35xfDMaih2BC4FziVl4gQeBR?=
 =?us-ascii?q?IppglcCkGo5kTUJhy6LHAwCgi6IEQOHYgEtgnGaCoIOTS4KgycJjFGED2WCU?=
 =?us-ascii?q?YR8iDMBAQ?=
X-IronPort-AV: E=Sophos;i="5.56,542,1539619200"; 
   d="scan'208";a="140645227"
Received: from unknown (HELO [192.168.1.228]) ([118.208.167.56])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 31 Jan 2019 07:15:29 +0800
Subject: [PATCH] autofs - use seq_puts() for simple strings in
 autofs_show_options()
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Thu, 31 Jan 2019 07:15:26 +0800
Message-ID: <154889012613.4863.12231175554744203482.stgit@pluto-themaw-net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.sh WARNING about the use of seq_printf() to print simple
strings in autofs_show_options(), use seq_puts() in this case.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 8647ecaa89fc..80597b88718b 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -82,20 +82,20 @@ static int autofs_show_options(struct seq_file *m, struct dentry *root)
 	seq_printf(m, ",maxproto=%d", sbi->max_proto);
 
 	if (autofs_type_offset(sbi->type))
-		seq_printf(m, ",offset");
+		seq_puts(m, ",offset");
 	else if (autofs_type_direct(sbi->type))
-		seq_printf(m, ",direct");
+		seq_puts(m, ",direct");
 	else
-		seq_printf(m, ",indirect");
+		seq_puts(m, ",indirect");
 	if (sbi->flags & AUTOFS_SBI_STRICTEXPIRE)
-		seq_printf(m, ",strictexpire");
+		seq_puts(m, ",strictexpire");
 	if (sbi->flags & AUTOFS_SBI_IGNORE)
-		seq_printf(m, ",ignore");
+		seq_puts(m, ",ignore");
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	if (sbi->pipe)
 		seq_printf(m, ",pipe_ino=%ld", file_inode(sbi->pipe)->i_ino);
 	else
-		seq_printf(m, ",pipe_ino=-1");
+		seq_puts(m, ",pipe_ino=-1");
 #endif
 	return 0;
 }

