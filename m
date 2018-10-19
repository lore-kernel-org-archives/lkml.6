Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A79FECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328A02064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328A02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=skynet.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbeJSQZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:25:20 -0400
Received: from mailrelay101.isp.belgacom.be ([195.238.20.128]:36172 "EHLO
        mailrelay101.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727366AbeJSQZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:25:19 -0400
X-Belgacom-Dynamic: yes
IronPort-PHdr: =?us-ascii?q?9a23=3AFTLfSxfCLYXT9hgsbdMGYWx+lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcWzZx7h7PlgxGXEQZ/co6odzbaO7Oa4ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTahY75+Ngm6oRnMvcQKnIVuLbo8xA?=
 =?us-ascii?q?HUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2QrxeFzQmLn?=
 =?us-ascii?q?s65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD?=
 =?us-ascii?q?+v6bpgRh31hycdLzM38H/ZhNF+gqxYpxyupRJ/zpXIbI2JLvdyYrnQcc8GSW?=
 =?us-ascii?q?dHQ81fVzZBAoS5b4YXD+QOJ/1Xr4jnqFsIsBCwBROsC/3yxTBWnH/23LE10+?=
 =?us-ascii?q?c8GgzB0gwvBckBsHrPodXuN6cTUea1w7fUzTnZdPxZxy7w5Y7VeR4iufGBRb?=
 =?us-ascii?q?F9fMjLxUQuFg7JlFedpIj/Mz+I1ekAvW6W5Pd6W+21kW4osQRxryCqxscrl4?=
 =?us-ascii?q?bGmJoYykvB9SVl2IY1IsC4SFJjbd6kDpRQsyaaOpNyQsMlX25noiI6yr0BuZ?=
 =?us-ascii?q?6gYCgG0pAnxxnDZPOdd4iH/xXjVOOLLjd5gnJpYLO/hxCs/ki80uDxVcu53E?=
 =?us-ascii?q?xLoydEiNXBtHQA2wbO5sWERPZx5kKh1iyO1wDX5OFEO0c0la/DJp4v2LE/jZ?=
 =?us-ascii?q?QTvF/YHi/1mET2irGZdlk+9uez9evreq/mqYOEN49olgH+Nbwjlda8AeQgNw?=
 =?us-ascii?q?gDRGyb+eW61L3+8kz1WbtKjvorkqnfrZ/VP9gbpq++Aw9TyIoj7Ay/Dzi+2t?=
 =?us-ascii?q?QCgXYHNE5FeA6Aj4XxOVHBOvD4Au2lg1Svjjhr3OvLMaH6ApnXMnfDlarhca?=
 =?us-ascii?q?xj5EFB1Qo51cpf6I5MCrEdPPLzXVf8u8DfDhAkKQO52ProCM5n2owCXGKPH7?=
 =?us-ascii?q?WVP73Pvl+V/ugvOfWDZJcJuDbhLPgo//rujX4/mV8AcqilxJUXaGulEft4PU?=
 =?us-ascii?q?WWf37sj8wfEWcFoAU+VvbmiF6cXj5JYXa9QaY86is8CIK8AofJXpqtj6CZ3C?=
 =?us-ascii?q?enAp1WYXhLClSNEXfuaoWFVO4AaCGMLc97lDwLS7yhRpQ/1RGhqgD60aBrLu?=
 =?us-ascii?q?nK9S0Cs5Lsytx16/fUlREo+jx+F96d3H2VT2FogmMIQCc73K5lrkNmxFeOyr?=
 =?us-ascii?q?N4g/9YFNxV+fxJTh02OoXCwL8yN9enUwHZe/+NSVC7UpCoBiw3QtstwtgIJU?=
 =?us-ascii?q?FnFIaMlBfGigSjCb4ckfSlHpE4/7jd1Hu5c8h0wXjuz6owiVQ6BMFCYz71zp?=
 =?us-ascii?q?Vj/hTeUtaa236SkLynIPwR?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AQAACMkslb/7dPQldjGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUQYBAQELAYEIfIFTEiiMDV+NfgGIUI4JgXo4AYRAAoUDIjQNDQE?=
 =?us-ascii?q?DAQECAQECAWwogjYigmIGJy8jEFE5HhmDIYF1EadaM4N9hieHLIQ6gUE/gRG?=
 =?us-ascii?q?NagKIbZVUCYYhiksCFZApmBU4gVVNIBiDJ4ImF44cPTCBAwE9AYoyAQE?=
X-IPAS-Result: =?us-ascii?q?A2AQAACMkslb/7dPQldjGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYEIfIFTEiiMDV+NfgGIUI4JgXo4AYRAAoUDIjQNDQEDAQECAQECAWwog?=
 =?us-ascii?q?jYigmIGJy8jEFE5HhmDIYF1EadaM4N9hieHLIQ6gUE/gRGNagKIbZVUCYYhi?=
 =?us-ascii?q?ksCFZApmBU4gVVNIBiDJ4ImF44cPTCBAwE9AYoyAQE?=
Received: from 183.79-66-87.adsl-dyn.isp.belgacom.be (HELO localhost.localdomain) ([87.66.79.183])
  by relay.skynet.be with ESMTP; 19 Oct 2018 10:20:14 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     akpm@linux-foundation.org
Cc:     jaharkes@cs.cmu.edu, coda@cs.cmu.edu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fabf@skynet.be
Subject: [PATCH 7/7 linux-next] coda: ftoc validity check integration
Date:   Fri, 19 Oct 2018 10:19:33 +0200
Message-Id: <1539937173-26260-8-git-send-email-fabf@skynet.be>
X-Mailer: git-send-email 2.4.11
In-Reply-To: <1539937173-26260-1-git-send-email-fabf@skynet.be>
References: <1539937173-26260-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves cfi check in coda_ftoc() instead of repeating
it in the wild.

Module size
   text	   data	    bss	    dec	    hex	filename
  28297	   1040	    700	  30037	   7555	fs/coda/coda.ko.before
  28263	    980	    700	  29943	   74f7	fs/coda/coda.ko.after

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/coda/cnode.c     | 10 ++++++++++
 fs/coda/coda_fs_i.h |  3 +--
 fs/coda/dir.c       |  6 ++----
 fs/coda/file.c      | 17 +++++------------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index c42d340..36414438 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -148,6 +148,16 @@ struct inode *coda_fid_to_inode(struct CodaFid *fid, struct super_block *sb)
 	return inode;
 }
 
+struct coda_file_info *coda_ftoc(struct file *file)
+{
+	struct coda_file_info *cfi = file->private_data;
+
+	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+
+	return cfi;
+
+}
+
 /* the CONTROL inode is made without asking attributes from Venus */
 struct inode *coda_cnode_makectl(struct super_block *sb)
 {
diff --git a/fs/coda/coda_fs_i.h b/fs/coda/coda_fs_i.h
index d702ba1a..c99d574 100644
--- a/fs/coda/coda_fs_i.h
+++ b/fs/coda/coda_fs_i.h
@@ -42,8 +42,6 @@ struct coda_file_info {
 	unsigned int	   cfi_mapcount;  /* nr of times this file is mapped */
 };
 
-#define CODA_FTOC(file) ((struct coda_file_info *)((file)->private_data))
-
 /* flags */
 #define C_VATTR       0x1   /* Validity of vattr in inode */
 #define C_FLUSH       0x2   /* used after a flush */
@@ -54,6 +52,7 @@ struct inode *coda_cnode_make(struct CodaFid *, struct super_block *);
 struct inode *coda_iget(struct super_block *sb, struct CodaFid *fid, struct coda_vattr *attr);
 struct inode *coda_cnode_makectl(struct super_block *sb);
 struct inode *coda_fid_to_inode(struct CodaFid *fid, struct super_block *sb);
+struct coda_file_info *coda_ftoc(struct file *file);
 void coda_replace_fid(struct inode *, struct CodaFid *, struct CodaFid *);
 
 #endif
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 00876dd..3e80770 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -356,8 +356,7 @@ static int coda_venus_readdir(struct file *coda_file, struct dir_context *ctx)
 	ino_t ino;
 	int ret;
 
-	cfi = CODA_FTOC(coda_file);
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+	cfi = coda_ftoc(coda_file);
 	host_file = cfi->cfi_container;
 
 	cii = ITOC(file_inode(coda_file));
@@ -426,8 +425,7 @@ static int coda_readdir(struct file *coda_file, struct dir_context *ctx)
 	struct file *host_file;
 	int ret;
 
-	cfi = CODA_FTOC(coda_file);
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+	cfi = coda_ftoc(coda_file);
 	host_file = cfi->cfi_container;
 
 	if (host_file->f_op->iterate || host_file->f_op->iterate_shared) {
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 1cbc1f2..55c22e2 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -31,9 +31,7 @@ static ssize_t
 coda_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *coda_file = iocb->ki_filp;
-	struct coda_file_info *cfi = CODA_FTOC(coda_file);
-
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+	struct coda_file_info *cfi = coda_ftoc(coda_file);
 
 	return vfs_iter_read(cfi->cfi_container, to, &iocb->ki_pos, 0);
 }
@@ -43,12 +41,10 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *coda_file = iocb->ki_filp;
 	struct inode *coda_inode = file_inode(coda_file);
-	struct coda_file_info *cfi = CODA_FTOC(coda_file);
+	struct coda_file_info *cfi = coda_ftoc(coda_file);
 	struct file *host_file;
 	ssize_t ret;
 
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
-
 	host_file = cfi->cfi_container;
 	file_start_write(host_file);
 	inode_lock(coda_inode);
@@ -69,8 +65,7 @@ coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
 	struct file *host_file;
 	struct inode *coda_inode, *host_inode;
 
-	cfi = CODA_FTOC(coda_file);
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+	cfi = coda_ftoc(coda_file);
 	host_file = cfi->cfi_container;
 
 	if (!host_file->f_op->mmap)
@@ -142,8 +137,7 @@ int coda_release(struct inode *coda_inode, struct file *coda_file)
 	struct inode *host_inode;
 	int err;
 
-	cfi = CODA_FTOC(coda_file);
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+	cfi = coda_ftoc(coda_file);
 
 	err = venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
 			  coda_flags, coda_file->f_cred->fsuid);
@@ -185,8 +179,7 @@ int coda_fsync(struct file *coda_file, loff_t start, loff_t end, int datasync)
 		return err;
 	inode_lock(coda_inode);
 
-	cfi = CODA_FTOC(coda_file);
-	BUG_ON(!cfi || cfi->cfi_magic != CODA_MAGIC);
+	cfi = coda_ftoc(coda_file);
 	host_file = cfi->cfi_container;
 
 	err = vfs_fsync(host_file, datasync);
-- 
2.4.11

