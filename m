Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B54C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B3220846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ac+b5mBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B3220846
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933399AbeFUPSX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:18:23 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:35477 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933277AbeFUPSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:18:21 -0400
Received: by mail-vk0-f74.google.com with SMTP id d134-v6so1409901vkf.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 08:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=fd3RD7cjuYUZNJRvBnWqOKvcW146LuGjoL139TL5knc=;
        b=Ac+b5mBziZ0hF5aseIufrVN6o000IIp6EKbsw67gK/cqA6tp8brPRX9gj3BwYlIsTJ
         NhHXyqplDUkk5nJkndpaF4amylxcaQfQVC7YJgCTlwSto9PGL2oZlooHMeVhcLg0nGam
         Z1zBTrfUyf1yYgXnckQhWOxIoYYZcSdEoS6jC3/Wf+tJuc4ukfMPZvFqnUofa2glK8NA
         0GW8c+t/0+mXYErHvHj3Kuhqqd4iFQxCSKR6TzPPwwjIg8iBgJPJkQy2g3VKRMYJhU/8
         UW2xywD7tYrYPIx/41dgmQZWjCQ0UkNAALZezqb+w6lPxlCJTEDtYHC5A84rDlTRJyUw
         f94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=fd3RD7cjuYUZNJRvBnWqOKvcW146LuGjoL139TL5knc=;
        b=e9RYDlfD9QmRcaZiJ2AWoBC7ecchlpkgmTOM1CihnE7g5GjnGeEPHwhWd7NfHW134W
         hXbhbzPJqRgH2TSjJUA6oEtgV9wz+qN7ENxd46pG9G8vjLzGCIaLCuyx4CiimgFITSPU
         MEPOzaVEW0SVC1qz3a3Dfz2dWoPfWUuOxpWoFgSiAaVflZdmmwcrPglOlWr7IB47A/jh
         f27xS8xJ/RfEmgt98+wqTFGEEQXz43GOT+SH41iYvYzzagmk+8O9O8h2CtkAqEkT2S0F
         EKTe6wZYvnFMRvXK3bCHI2q3+fCpWyRf/vFJhOqx38gGZgrM0v/x897r8eAmDTQn2x96
         Y9Dg==
X-Gm-Message-State: APt69E0TjqBnPJE/MMzNNxdxcQOZoVILNdYo9TuNMPQrfgCYAzHTIjKh
        4iwDAiY3Wy7YSXN2xwM16wiPz0OT4Q==
X-Google-Smtp-Source: ADUXVKLR2X1gg4YQJOx9op/hi1ilmoDRk5F1BnlWsGi1ZnPKd0R0DntIaZcv7splwOKyDkCEgeIOvQcWdQ==
MIME-Version: 1.0
X-Received: by 2002:a1f:44e:: with SMTP id 75-v6mr11727726vke.121.1529594300030;
 Thu, 21 Jun 2018 08:18:20 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:18:09 +0200
Message-Id: <20180621151809.10921-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2] sg: mitigate read/write abuse
From:   Jann Horn <jannh@google.com>
To:     Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        kernel-hardening@lists.openwall.com, security@kernel.org,
        Benjamin Block <bblock@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Al Viro noted in commit 128394eff343 ("sg_write()/bsg_write() is not fit
to be called under KERNEL_DS"), sg improperly accesses userspace memory
outside the provided buffer, permitting kernel memory corruption via
splice().
But it doesn't just do it on ->write(), also on ->read().

As a band-aid, make sure that the ->read() and ->write() handlers can not
be called in weird contexts (kernel context or credentials different from
file opener), like for ib_safe_file_access().

If someone needs to use these interfaces from different security contexts,
a new interface should be written that goes through the ->ioctl() handler.

I've mostly copypasted ib_safe_file_access() over as sg_safe_file_access()
because I couldn't find a good common header - please tell me if you know a
better way.
The duplicate pr_err_once() calls are so that each of them fires once;
otherwise, this would probably have to be a macro.

changed in v2:
 - remove the bsg parts per Christoph Hellwig's request

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/scsi/sg.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 53ae52dbff84..51b685192646 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -51,6 +51,7 @@ static int sg_version_num = 30536;	/* 2 digits for each component */
 #include <linux/atomic.h>
 #include <linux/ratelimit.h>
 #include <linux/uio.h>
+#include <linux/cred.h> /* for sg_safe_file_access() */
 
 #include "scsi.h"
 #include <scsi/scsi_dbg.h>
@@ -209,6 +210,23 @@ static void sg_device_destroy(struct kref *kref);
 	sdev_prefix_printk(prefix, (sdp)->device,		\
 			   (sdp)->disk->disk_name, fmt, ##a)
 
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
+static inline bool sg_safe_file_access(struct file *filp)
+{
+	return filp->f_cred == current_cred() && !uaccess_kernel();
+}
+
 static int sg_allow_access(struct file *filp, unsigned char *cmd)
 {
 	struct sg_fd *sfp = filp->private_data;
@@ -393,6 +411,12 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 	struct sg_header *old_hdr = NULL;
 	int retval = 0;
 
+	if (!sg_safe_file_access(filp)) {
+		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
+			__func__, task_tgid_vnr(current), current->comm);
+		return -EINVAL;
+	}
+
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
 	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
@@ -581,8 +605,11 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 	sg_io_hdr_t *hp;
 	unsigned char cmnd[SG_MAX_CDB_SIZE];
 
-	if (unlikely(uaccess_kernel()))
+	if (!sg_safe_file_access(filp)) {
+		pr_err_once("%s: process %d (%s) changed security contexts after opening file descriptor, this is not allowed.\n",
+			__func__, task_tgid_vnr(current), current->comm);
 		return -EINVAL;
+	}
 
 	if ((!(sfp = (Sg_fd *) filp->private_data)) || (!(sdp = sfp->parentdp)))
 		return -ENXIO;
-- 
2.18.0.rc1.244.gcf134e6275-goog

