Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D47ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BA62146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BA62146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbeIREmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:42:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50836 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732001AbeIREmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:42:22 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4DCECC49;
        Mon, 17 Sep 2018 23:12:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 081/158] f2fs: fix defined but not used build warnings
Date:   Tue, 18 Sep 2018 00:41:51 +0200
Message-Id: <20180917211714.965796467@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit cb15d1e43db0a6341c1e26ac6a2c74e61b74f1aa ]

Fix build warnings in f2fs when CONFIG_PROC_FS is not enabled
by marking the unused functions as __maybe_unused.

../fs/f2fs/sysfs.c:519:12: warning: 'segment_info_seq_show' defined but not used [-Wunused-function]
../fs/f2fs/sysfs.c:546:12: warning: 'segment_bits_seq_show' defined but not used [-Wunused-function]
../fs/f2fs/sysfs.c:570:12: warning: 'iostat_info_seq_show' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/sysfs.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -9,6 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/compiler.h>
 #include <linux/proc_fs.h>
 #include <linux/f2fs_fs.h>
 #include <linux/seq_file.h>
@@ -516,7 +517,8 @@ static struct kobject f2fs_feat = {
 	.kset	= &f2fs_kset,
 };
 
-static int segment_info_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused segment_info_seq_show(struct seq_file *seq,
+						void *offset)
 {
 	struct super_block *sb = seq->private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -543,7 +545,8 @@ static int segment_info_seq_show(struct
 	return 0;
 }
 
-static int segment_bits_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused segment_bits_seq_show(struct seq_file *seq,
+						void *offset)
 {
 	struct super_block *sb = seq->private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -567,7 +570,8 @@ static int segment_bits_seq_show(struct
 	return 0;
 }
 
-static int iostat_info_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
+					       void *offset)
 {
 	struct super_block *sb = seq->private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);


