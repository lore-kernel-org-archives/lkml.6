Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AECC6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAC02088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAC02088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeILUQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:16:18 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40949 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeILUQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:16:18 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LpCLN-1fNUgH3Q5F-00f8lu; Wed, 12 Sep 2018 17:04:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Haverkamp <haver@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Felipe Balbi <balbi@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v2 03/17] compat_ioctl: use correct compat_ptr() translation in drivers
Date:   Wed, 12 Sep 2018 17:01:04 +0200
Message-Id: <20180912150142.157913-3-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180912150142.157913-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
X-Provags-ID: V03:K1:Z2CTzqEkt4HdLE2EjGa/Ika1rXYEIKdgR2bTCK0LQ9WjlxscpKT
 aNUhO8nKrgK/wJHTqtnR0VyEr8WZP3EQYU/Pg5ehH1deYUrKPYdbPQihCvwz/hI9AUQsClQ
 fmjXr9BhT+8ikXAHj96SZKAt0sfaCdDmLpWVI1Q/jzPRoBg7hbVMWVsxj6WVzgs4D1OkQO4
 dJrjM+ckbo+nKRlWHz/6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TdSteWb+VTo=:I97HlKO/MRPUDbPzVoq7Dd
 hIQRC0gjyl56ZgE1pS1Xrgdu4ZegOkIaB4QGKl+9Ac+QxJxibUoysUTj9hwUJtW0TzFTOK2GE
 cC6KGuh2sIPBXj+1vne8lQrwW39Ef9MrrI9QGtzT6kXfnxgkmjKqpKMqdpKwNW6dirFznmGd2
 Xj+aqJyGF+G7slTDBMIakfplzD4MQS+xvHLNNHHdqjhofdyMcZA/IDDVnotVpibctHkWKVV3y
 6C7r4Zps9yvq5WbxPJOn/ynQaSBobMJJSlKMCTCs7LS6v/sS1dyEWt03dopXNgv1ziyhrVvBd
 /OAHVHpb6s5Nnu0TM38pev484Uhipza3VTQuc+AGrZKVZ0RToVKAkvxNV2M6x76dky0zsXzL4
 z3Zq6UmAkpiwV+03Y9m7kpuT+CMu+yU7EqjAF9utjeMrifcSgZwKqa39+RRXLuJO9mug/FHHm
 w8blwzTi/U0zqzmDDpC0UzYf7eVPSzdU63CF9qvvvwjWezBx9keV8x07MdI06XQEk2mb4STVW
 nhTLj4pqy9j07d3GGtly3psG/W3PVydjt4GwionBNB8xDCqWPULUG+r1aXS5JVPg57xTArEYk
 7KktqZXnoNiSj7X+6kKysSdWiZanAKoPnvqTowLUAeBNUcE3aLuhSNxWhaip4NEeMIBRg/sYx
 nq6H0imrl/X8x6U4J6pcqnwEOJ6ywhpO+hkjK83RblafMPS5bj1xWtOLnVfb86ihk42M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A handful of drivers all have a trivial wrapper around their ioctl
handler, but don't call the compat_ptr() conversion function at the
moment. In practice this does not matter, since none of them are used
on the s390 architecture and for all other architectures, compat_ptr()
does not do anything, but using the new generic_compat_ioctl_ptrarg
helper makes it more correct in theory, and simplifies the code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/cxl/flash.c            |  8 +-------
 drivers/misc/genwqe/card_dev.c      | 23 +----------------------
 drivers/scsi/megaraid/megaraid_mm.c | 28 +---------------------------
 drivers/usb/gadget/function/f_fs.c  | 12 +-----------
 4 files changed, 4 insertions(+), 67 deletions(-)

diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
index 43917898fb9a..acd362498f8c 100644
--- a/drivers/misc/cxl/flash.c
+++ b/drivers/misc/cxl/flash.c
@@ -473,12 +473,6 @@ static long device_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return -EINVAL;
 }
 
-static long device_compat_ioctl(struct file *file, unsigned int cmd,
-				unsigned long arg)
-{
-	return device_ioctl(file, cmd, arg);
-}
-
 static int device_close(struct inode *inode, struct file *file)
 {
 	struct cxl *adapter = file->private_data;
@@ -514,7 +508,7 @@ static const struct file_operations fops = {
 	.owner		= THIS_MODULE,
 	.open		= device_open,
 	.unlocked_ioctl	= device_ioctl,
-	.compat_ioctl	= device_compat_ioctl,
+	.compat_ioctl	= generic_compat_ioctl_ptrarg,
 	.release	= device_close,
 };
 
diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index f453ab82f0d7..6e73df9b3788 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -1220,34 +1220,13 @@ static long genwqe_ioctl(struct file *filp, unsigned int cmd,
 	return rc;
 }
 
-#if defined(CONFIG_COMPAT)
-/**
- * genwqe_compat_ioctl() - Compatibility ioctl
- *
- * Called whenever a 32-bit process running under a 64-bit kernel
- * performs an ioctl on /dev/genwqe<n>_card.
- *
- * @filp:        file pointer.
- * @cmd:         command.
- * @arg:         user argument.
- * Return:       zero on success or negative number on failure.
- */
-static long genwqe_compat_ioctl(struct file *filp, unsigned int cmd,
-				unsigned long arg)
-{
-	return genwqe_ioctl(filp, cmd, arg);
-}
-#endif /* defined(CONFIG_COMPAT) */
-
 static const struct file_operations genwqe_fops = {
 	.owner		= THIS_MODULE,
 	.open		= genwqe_open,
 	.fasync		= genwqe_fasync,
 	.mmap		= genwqe_mmap,
 	.unlocked_ioctl	= genwqe_ioctl,
-#if defined(CONFIG_COMPAT)
-	.compat_ioctl   = genwqe_compat_ioctl,
-#endif
+	.compat_ioctl   = generic_compat_ioctl_ptrarg,
 	.release	= genwqe_release,
 };
 
diff --git a/drivers/scsi/megaraid/megaraid_mm.c b/drivers/scsi/megaraid/megaraid_mm.c
index 8428247015db..00daa1547783 100644
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -45,10 +45,6 @@ static int mraid_mm_setup_dma_pools(mraid_mmadp_t *);
 static void mraid_mm_free_adp_resources(mraid_mmadp_t *);
 static void mraid_mm_teardown_dma_pools(mraid_mmadp_t *);
 
-#ifdef CONFIG_COMPAT
-static long mraid_mm_compat_ioctl(struct file *, unsigned int, unsigned long);
-#endif
-
 MODULE_AUTHOR("LSI Logic Corporation");
 MODULE_DESCRIPTION("LSI Logic Management Module");
 MODULE_LICENSE("GPL");
@@ -72,9 +68,7 @@ static wait_queue_head_t wait_q;
 static const struct file_operations lsi_fops = {
 	.open	= mraid_mm_open,
 	.unlocked_ioctl = mraid_mm_unlocked_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl = mraid_mm_compat_ioctl,
-#endif
+	.compat_ioctl = generic_compat_ioctl_ptrarg,
 	.owner	= THIS_MODULE,
 	.llseek = noop_llseek,
 };
@@ -228,7 +222,6 @@ mraid_mm_unlocked_ioctl(struct file *filep, unsigned int cmd,
 {
 	int err;
 
-	/* inconsistent: mraid_mm_compat_ioctl doesn't take the BKL */
 	mutex_lock(&mraid_mm_mutex);
 	err = mraid_mm_ioctl(filep, cmd, arg);
 	mutex_unlock(&mraid_mm_mutex);
@@ -1233,25 +1226,6 @@ mraid_mm_init(void)
 }
 
 
-#ifdef CONFIG_COMPAT
-/**
- * mraid_mm_compat_ioctl	- 32bit to 64bit ioctl conversion routine
- * @filep	: file operations pointer (ignored)
- * @cmd		: ioctl command
- * @arg		: user ioctl packet
- */
-static long
-mraid_mm_compat_ioctl(struct file *filep, unsigned int cmd,
-		      unsigned long arg)
-{
-	int err;
-
-	err = mraid_mm_ioctl(filep, cmd, arg);
-
-	return err;
-}
-#endif
-
 /**
  * mraid_mm_exit	- Module exit point
  */
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 3ada83d81bda..f4af64b4cb36 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1276,14 +1276,6 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-static long ffs_epfile_compat_ioctl(struct file *file, unsigned code,
-		unsigned long value)
-{
-	return ffs_epfile_ioctl(file, code, value);
-}
-#endif
-
 static const struct file_operations ffs_epfile_operations = {
 	.llseek =	no_llseek,
 
@@ -1292,9 +1284,7 @@ static const struct file_operations ffs_epfile_operations = {
 	.read_iter =	ffs_epfile_read_iter,
 	.release =	ffs_epfile_release,
 	.unlocked_ioctl =	ffs_epfile_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl = ffs_epfile_compat_ioctl,
-#endif
+	.compat_ioctl = generic_compat_ioctl_ptrarg,
 };
 
 
-- 
2.18.0

