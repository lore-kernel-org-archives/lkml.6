Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FA0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AB8218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfBRCrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:47:07 -0500
Received: from SMTPBG357.QQ.COM ([183.61.51.175]:60228 "EHLO SMTPBG357.QQ.COM"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbfBRCrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:47:06 -0500
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Feb 2019 21:47:05 EST
X-QQ-mid: bizesmtp20t1550457587tuv3gfrq
Received: from Macbook.Pro (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 18 Feb 2019 10:39:46 +0800 (CST)
X-QQ-SSF: 01400000000000P0TL50B00A0000000
X-QQ-FEAT: 9MsTBLS6yXFMFVA+TA6wpjC0SxHpTPzkPmjtMJBmt4CiRjJrsbmatQjcIxeIe
        LMJqZGfQ8Wwk2lknwNsgiTLySXe3Dd3iPsoTii1IC3STWyrdvfG8gZfBRi2hgs+urt3jFKO
        zQz/7/3+r2q1+Z2msNHUgWE5dDy9WVEu2dAyWGTpiwWML+IeNb3C/DJetTCzhtzpK5Yrylw
        ijBM/Ppxohr92tGcHnidAorYbYdHBfvhS65kPHtfi1Tj7nH8h3tmlxU6QNN3YaqVaEgmZ45
        ye0xrOFNfFy1A6GlSEwV5LCoaOCFDoNQRw5yD6gRSe8Qns
X-QQ-GoodBg: 1
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     kieran.bingham@linaro.org
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH] script/gdb: replace flags (MS_xyz -> SB_xyz)
Date:   Mon, 18 Feb 2019 10:39:21 +0800
Message-Id: <20190218023921.1882-1-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit (1751e8a6cb935e555fcdbcb9ab4f0446e322ca3e)
Rename superblock flags (MS_xyz -> SB_xyz). script/gdb
need replace MS_xyz to SB_xyz.

Fix following problem:

root@localhost:/data# gdb -q vmlinux
Reading symbols from vmlinux...done.
Traceback (most recent call last):
  File "/data/vmlinux-gdb.py", line 32, in <module>
    import linux.proc
  File "/data/scripts/gdb/linux/proc.py", line 15, in <module>
    from linux import constants
  File "/data/scripts/gdb/linux/constants.py", line 2, in <module>
    LX_SB_RDONLY = MS_RDONLY
NameError: name 'MS_RDONLY' is not defined
(gdb)

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 scripts/gdb/linux/constants.py.in | 12 ++++++------
 scripts/gdb/linux/proc.py         | 10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 7aad82406422..d3319a80788a 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -37,12 +37,12 @@
 import gdb
 
 /* linux/fs.h */
-LX_VALUE(MS_RDONLY)
-LX_VALUE(MS_SYNCHRONOUS)
-LX_VALUE(MS_MANDLOCK)
-LX_VALUE(MS_DIRSYNC)
-LX_VALUE(MS_NOATIME)
-LX_VALUE(MS_NODIRATIME)
+LX_VALUE(SB_RDONLY)
+LX_VALUE(SB_SYNCHRONOUS)
+LX_VALUE(SB_MANDLOCK)
+LX_VALUE(SB_DIRSYNC)
+LX_VALUE(SB_NOATIME)
+LX_VALUE(SB_NODIRATIME)
 
 /* linux/mount.h */
 LX_VALUE(MNT_NOSUID)
diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 0aebd7565b03..cdc9c3e76c55 100644
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -114,11 +114,11 @@ def info_opts(lst, opt):
     return opts
 
 
-FS_INFO = {constants.LX_MS_SYNCHRONOUS: ",sync",
-           constants.LX_MS_MANDLOCK: ",mand",
-           constants.LX_MS_DIRSYNC: ",dirsync",
-           constants.LX_MS_NOATIME: ",noatime",
-           constants.LX_MS_NODIRATIME: ",nodiratime"}
+FS_INFO = {constants.LX_SB_SYNCHRONOUS: ",sync",
+           constants.LX_SB_MANDLOCK: ",mand",
+           constants.LX_SB_DIRSYNC: ",dirsync",
+           constants.LX_SB_NOATIME: ",noatime",
+           constants.LX_SB_NODIRATIME: ",nodiratime"}
 
 MNT_INFO = {constants.LX_MNT_NOSUID: ",nosuid",
             constants.LX_MNT_NODEV: ",nodev",
-- 
2.20.1



