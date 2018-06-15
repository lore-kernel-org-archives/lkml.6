Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 42B7FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE15D208E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VK+4JD5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE15D208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936327AbeFOPX5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:23:57 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:49969 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936293AbeFOPXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:23:55 -0400
Received: by mail-qk0-f202.google.com with SMTP id w203-v6so8086704qkb.16
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=Xr2wc0g51Kk8BfEnfM9vv/KIVvwwAP6g6vvGloA/aFk=;
        b=VK+4JD5o6BGY0FO8o6GwScRoAKSu//oiH8+Z2t5apGuG5hf6d81OJwYxEg4CNvsvpF
         MenZ39gp4RwhiUX6gif85m8eggY9UNdcNVn+5kuBYSMgjyZZAXzcsFqgwUM/kYgQ2y20
         vYSSFGFa2irvdOT3RkoxlOMEi/sCj8iUbM5G1sXFTEg/2OlPS1tEujUUhtw/OSNGCuO6
         zl765O/D8tnEwdb7RJmH/VF9ZxLbimq1yopnLL3swwglwXo/O9waAnEtcxp0tChDcOjC
         Xjvvt2Vfa+7JJTciMtqxxzY0+pmmIRQr1mCrL5l7IBQw4/IcEgnbi9Am5rO2ywC1Y811
         f42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=Xr2wc0g51Kk8BfEnfM9vv/KIVvwwAP6g6vvGloA/aFk=;
        b=GMb7DNJvKdfnjwjADzdXYsSuYyYlnY+rXOi9Hkf5utYGwjN7qnKAUZEqHNmILnLXXG
         knWlkPNN06LuSJGf+PLU6z80TCzT5JF5sq2j3wbktG77FgwOgsLyIHtWNuYD214F8HiL
         b2Hf+0rb8RF4fg9GuQGMRixkIDI6Gu+y1oRTuI2wE+HfNBUBvs3JSQm+ztDllcDhlr2l
         YHyikAoxQ0pQptEI5N34Y7bRTwvfa5jpb7ya/yHWWWt/sgbuiFZ7yGbf5/inbZndM3by
         Dk/cAEr+FpFqljdEcjXtonxMYsw44LRSnZ9Zws4xi817mZLIDLHfrWZgSKeAvg4Xk9DT
         DsNA==
X-Gm-Message-State: APt69E3G0PtH9eAgYFNGZapmb5VLAcRFz8a0qHvOXKiH06KLVooEPNxO
        DizVIfEsAG/OW2ueyw6boEQNGe1M0g==
X-Google-Smtp-Source: ADUXVKIo4Y4VePaJ6AVswSHgn5ERJyCzmU5dSHk6WMfhpM+Xq5W37kdMPT/8mEq//6lzX3D6c8uwTDDQUA==
MIME-Version: 1.0
X-Received: by 2002:a37:ab0e:: with SMTP id u14-v6mr1045868qke.46.1529076234580;
 Fri, 15 Jun 2018 08:23:54 -0700 (PDT)
Date:   Fri, 15 Jun 2018 17:23:35 +0200
Message-Id: <20180615152335.208202-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH] sg, bsg: mitigate read/write abuse, block uaccess in release
From:   Jann Horn <jannh@google.com>
To:     Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        kernel-hardening@lists.openwall.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Al Viro noted in commit 128394eff343 ("sg_write()/bsg_write() is not fit
to be called under KERNEL_DS"), sg and bsg improperly access userspace
memory outside the provided buffer, permitting kernel memory corruption via
splice().
But they don't just do it on ->write(), also on ->read() and (in the case
of bsg) even on ->release().

As a band-aid, make sure that the ->read() and ->write() handlers can not
be called in weird contexts (kernel context or credentials different from
file opener), like for ib_safe_file_access().
Also, completely prevent user memory accesses from ->release().

If someone needs to use these interfaces from different security contexts,
a new interface should be written that goes through the ->ioctl() handler.

I've mostly copypasted ib_safe_file_access() over as
scsi_safe_file_access() because I couldn't find a good common header -
please tell me if you know a better way.
The duplicate pr_err_once() calls are so that each of them fires once;
otherwise, this would probably have to be a macro.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---

I'm CC-ing security@ on this patch in case someone cares a lot, but
since you already need to have some pretty high privileges to use these
devices in the first place, I think this can be handled publicly.

In case anyone is interested in how I found these: I was looking at a
reverse callgraph of __might_fault and spotted the ->release handler of
block/bsg.c in there.

 block/bsg-lib.c          |  5 ++++-
 block/bsg.c              | 29 +++++++++++++++++++++--------
 drivers/scsi/sg.c        | 11 ++++++++++-
 include/linux/bsg.h      |  3 ++-
 include/scsi/scsi_cmnd.h | 19 +++++++++++++++++++
 5 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 9419def8c017..cf5d4fdddbeb 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -53,7 +53,8 @@ static int bsg_transport_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
 	return 0;
 }
 
-static int bsg_transport_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
+static int bsg_transport_complete_rq(struct request *rq, struct sg_io_v4 *hdr,
+		bool cleaning_up)
 {
 	struct bsg_job *job = blk_mq_rq_to_pdu(rq);
 	int ret = 0;
@@ -79,6 +80,8 @@ static int bsg_transport_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
 	if (job->reply_len && hdr->response) {
 		int len = min(hdr->max_response_len, job->reply_len);
 
+		if (unlikely(cleaning_up))
+			ret = -EINVAL;
 		if (copy_to_user(uptr64(hdr->response), job->reply, len))
 			ret = -EFAULT;
 		else
diff --git a/block/bsg.c b/block/bsg.c
index 132e657e2d91..e64ef807d2d0 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -159,7 +159,8 @@ static int bsg_scsi_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
 	return 0;
 }
 
-static int bsg_scsi_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
+static int bsg_scsi_complete_rq(struct request *rq, struct sg_io_v4 *hdr,
+		bool cleaning_up)
 {
 	struct scsi_request *sreq = scsi_req(rq);
 	int ret = 0;
@@ -179,7 +180,9 @@ static int bsg_scsi_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
 		int len = min_t(unsigned int, hdr->max_response_len,
 					sreq->sense_len);
 
-		if (copy_to_user(uptr64(hdr->response), sreq->sense, len))
+		if (cleaning_up)
+			ret = -EINVAL;
+		else if (copy_to_user(uptr64(hdr->response), sreq->sense, len))
 			ret = -EFAULT;
 		else
 			hdr->response_len = len;
@@ -383,11 +386,12 @@ static struct bsg_command *bsg_get_done_cmd(struct bsg_device *bd)
 }
 
 static int blk_complete_sgv4_hdr_rq(struct request *rq, struct sg_io_v4 *hdr,
-				    struct bio *bio, struct bio *bidi_bio)
+				    struct bio *bio, struct bio *bidi_bio,
+				    bool cleaning_up)
 {
 	int ret;
 
-	ret = rq->q->bsg_dev.ops->complete_rq(rq, hdr);
+	ret = rq->q->bsg_dev.ops->complete_rq(rq, hdr, cleaning_up);
 
 	if (rq->next_rq) {
 		blk_rq_unmap_user(bidi_bio);
@@ -453,7 +457,7 @@ static int bsg_complete_all_commands(struct bsg_device *bd)
 			break;
 
 		tret = blk_complete_sgv4_hdr_rq(bc->rq, &bc->hdr, bc->bio,
-						bc->bidi_bio);
+						bc->bidi_bio, true);
 		if (!ret)
 			ret = tret;
 
@@ -488,7 +492,7 @@ __bsg_read(char __user *buf, size_t count, struct bsg_device *bd,
 		 * bsg_complete_work() cannot do that for us
 		 */
 		ret = blk_complete_sgv4_hdr_rq(bc->rq, &bc->hdr, bc->bio,
-					       bc->bidi_bio);
+					       bc->bidi_bio, false);
 
 		if (copy_to_user(buf, &bc->hdr, sizeof(bc->hdr)))
 			ret = -EFAULT;
@@ -532,6 +536,12 @@ bsg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	int ret;
 	ssize_t bytes_read;
 
+	if (!scsi_safe_file_access(file)) {
+		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
+			__func__, task_tgid_vnr(current), current->comm);
+		return -EINVAL;
+	}
+
 	bsg_dbg(bd, "read %zd bytes\n", count);
 
 	bsg_set_block(bd, file);
@@ -608,8 +618,11 @@ bsg_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 
 	bsg_dbg(bd, "write %zd bytes\n", count);
 
-	if (unlikely(uaccess_kernel()))
+	if (!scsi_safe_file_access(file)) {
+		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
+			__func__, task_tgid_vnr(current), current->comm);
 		return -EINVAL;
+	}
 
 	bsg_set_block(bd, file);
 
@@ -859,7 +872,7 @@ static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 		at_head = (0 == (hdr.flags & BSG_FLAG_Q_AT_TAIL));
 		blk_execute_rq(bd->queue, NULL, rq, at_head);
-		ret = blk_complete_sgv4_hdr_rq(rq, &hdr, bio, bidi_bio);
+		ret = blk_complete_sgv4_hdr_rq(rq, &hdr, bio, bidi_bio, false);
 
 		if (copy_to_user(uarg, &hdr, sizeof(hdr)))
 			return -EFAULT;
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 53ae52dbff84..997e06a22527 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -393,6 +393,12 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 	struct sg_header *old_hdr = NULL;
 	int retval = 0;
 
+	if (!scsi_safe_file_access(filp)) {
+		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
+			__func__, task_tgid_vnr(current), current->comm);
+		return -EINVAL;
+	}
+
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
 	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
@@ -581,8 +587,11 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 	sg_io_hdr_t *hp;
 	unsigned char cmnd[SG_MAX_CDB_SIZE];
 
-	if (unlikely(uaccess_kernel()))
+	if (!scsi_safe_file_access(filp)) {
+		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
+			__func__, task_tgid_vnr(current), current->comm);
 		return -EINVAL;
+	}
 
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
diff --git a/include/linux/bsg.h b/include/linux/bsg.h
index dac37b6e00ec..c22bc359552a 100644
--- a/include/linux/bsg.h
+++ b/include/linux/bsg.h
@@ -11,7 +11,8 @@ struct bsg_ops {
 	int	(*check_proto)(struct sg_io_v4 *hdr);
 	int	(*fill_hdr)(struct request *rq, struct sg_io_v4 *hdr,
 				fmode_t mode);
-	int	(*complete_rq)(struct request *rq, struct sg_io_v4 *hdr);
+	int	(*complete_rq)(struct request *rq, struct sg_io_v4 *hdr,
+				bool cleaning_up);
 	void	(*free_rq)(struct request *rq);
 };
 
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index aaf1e971c6a3..d22118a38aa4 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -8,6 +8,8 @@
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/scatterlist.h>
+#include <linux/cred.h> /* for scsi_safe_file_access() */
+#include <linux/fs.h> /* for scsi_safe_file_access() */
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_request.h>
 
@@ -363,4 +365,21 @@ static inline unsigned scsi_transfer_length(struct scsi_cmnd *scmd)
 	return xfer_len;
 }
 
+/*
+ * The SCSI interfaces that use read() and write() as an asynchronous variant of
+ * ioctl(..., SG_IO, ...) are fundamentally unsafe, since there are lots of ways
+ * to trigger read() and write() calls from various contexts with elevated
+ * privileges. This can lead to kernel memory corruption (e.g. if these
+ * interfaces are called through splice()) and privilege escalation inside
+ * userspace (e.g. if a process with access to such a device passes a file
+ * descriptor to a SUID binary as stdin/stdout/stderr).
+ *
+ * This function provides protection for the legacy API by restricting the
+ * calling context.
+ */
+static inline bool scsi_safe_file_access(struct file *filp)
+{
+	return filp->f_cred == current_cred() && !uaccess_kernel();
+}
+
 #endif /* _SCSI_SCSI_CMND_H */
-- 
2.18.0.rc1.244.gcf134e6275-goog

