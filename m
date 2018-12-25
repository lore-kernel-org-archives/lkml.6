Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299CAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 18:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C787F21736
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 18:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="WuIwWSLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeLYS6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 13:58:49 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:53422 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeLYS6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 13:58:49 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 0614CB23
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 18:58:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bkYyWi40A1aA for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 12:58:47 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id CA24D6A1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 12:58:47 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id n124so16721695itb.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 10:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XPnXcy7TnL4VBmeDBsDoZgntLGyaaI3u7ypY1sutQ68=;
        b=WuIwWSLs87VliaLSGUJaxX+M4VIP2iidK2aA7cOB20/SoCKAnO8eezxEluzPWVajYX
         SrGac/KyCqgwYtaZNiH4DnCza7tI5yjGIxPz6dDpKyuzlqWEo3LVHdPv0WwhNDe7EUNt
         bVTl4Ev+TU/RPGmIbAwNe3j0GvtaiLYGNgk9K0xahRWCqljMnF3D5xjRI6suzsBhtYIz
         xGDKtu24OcjLCvPKhVuwsLfAqAlzi6IFk7Jni7Z3N9kw9owfa/17EOw/TJelPdZq86BO
         fdY/gkMh0OUm2f5YUqOVdu5qyYT+HAh6+gzLL509hQoM+2dAgJHHMmvb39GxGELFjEIZ
         ujEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XPnXcy7TnL4VBmeDBsDoZgntLGyaaI3u7ypY1sutQ68=;
        b=HPtlYYDqaGTWjKJu8+Hu7m7BKPNIsHKSke2njMISTwlyDEWyZXQsRAOXNIocQuupVM
         ia8u3AUjf8IBLYmoO42XY3rehEUuSHYU+M7P0+quv/D63iwKdwJA0FWz+1m+K1c5sLni
         qv+QB04Chiafad4dyODR2qNDd3epyQl/viK8Ux8TyBA9+u/q88WQwrXqzgCFSIdvTZDs
         My/Jmo+v01j+GaeyDdRZNdXpgKfQfPS8SXP5XkZYipG7yG7w7f2eDRpC0I1zKj0ST4/U
         DRIA+cWZEbHBHvG0nBqFJCEZVSMGE1GKJIHFV3nmt7C2FPolsKwfODgMvxmzgcNJaYPr
         oaKg==
X-Gm-Message-State: AA+aEWaBWHEY1i5tOcOF1BN+uWpuXf1wk37PmzHxk+nZP9yYF4APO7kn
        DTRJXhJLPHsadGLgVb75LH8TocCOvsVyWDSCEQ+gxlbb3m80eVMqiHiUMx5CWHm7D1nfYWRsYzS
        fkFYGZXr6CUD+GdqpbaqfRg1k6D/4
X-Received: by 2002:a02:6:: with SMTP id 6mr10699221jaa.19.1545764327327;
        Tue, 25 Dec 2018 10:58:47 -0800 (PST)
X-Google-Smtp-Source: AFSGD/Ub+Wo4ai7zfdywgV2vMe/tCwO2oXRdRXm2giCgT4bg//cQsi76Hfo59I12He8x5cxAUHITIQ==
X-Received: by 2002:a02:6:: with SMTP id 6mr10699214jaa.19.1545764327011;
        Tue, 25 Dec 2018 10:58:47 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id t69sm5436104itb.26.2018.12.25.10.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 10:58:45 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jan Harkes <jaharkes@cs.cmu.edu>,
        coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: coda: fix a double-fetch case in coda_psdev_write
Date:   Tue, 25 Dec 2018 12:58:14 -0600
Message-Id: <20181225185814.69047-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"hdr" has been copied in from user space and "hdr.opcode" is checked.
The code copies it again. User space data between the two copies is
subject to modification if the user-space code is multithreaded and
malicious. The modification may invalidate the check. In the original
code, "hdr.opcode" is not used after the second copy, so it is actually
safe with the current code. However, in case future code may use
"hdr.opcode", let's avoid copying the header from user space again.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 fs/coda/psdev.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index c5234c21b539..fb4d1c654773 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -97,35 +97,38 @@ static long coda_psdev_ioctl(struct file * filp, unsigned int cmd, unsigned long
 static ssize_t coda_psdev_write(struct file *file, const char __user *buf, 
 				size_t nbytes, loff_t *off)
 {
-        struct venus_comm *vcp = (struct venus_comm *) file->private_data;
-        struct upc_req *req = NULL;
-        struct upc_req *tmp;
+	struct venus_comm *vcp = (struct venus_comm *) file->private_data;
+	struct upc_req *req = NULL;
+	struct upc_req *tmp;
 	struct list_head *lh;
 	struct coda_in_hdr hdr;
 	ssize_t retval = 0, count = 0;
 	int error;
 
-        /* Peek at the opcode, uniquefier */
+	/* Peek at the opcode, uniquefier */
 	if (copy_from_user(&hdr, buf, 2 * sizeof(u_long)))
-	        return -EFAULT;
+		return -EFAULT;
 
-        if (DOWNCALL(hdr.opcode)) {
+	if (DOWNCALL(hdr.opcode)) {
 		union outputArgs *dcbuf;
 		int size = sizeof(*dcbuf);
 
 		if  ( nbytes < sizeof(struct coda_out_hdr) ) {
 			pr_warn("coda_downcall opc %d uniq %d, not enough!\n",
-				hdr.opcode, hdr.unique);
+					hdr.opcode, hdr.unique);
 			count = nbytes;
 			goto out;
 		}
 		if ( nbytes > size ) {
 			pr_warn("downcall opc %d, uniq %d, too much!",
-				hdr.opcode, hdr.unique);
-		        nbytes = size;
+					hdr.opcode, hdr.unique);
+			nbytes = size;
 		}
 		CODA_ALLOC(dcbuf, union outputArgs *, nbytes);
-		if (copy_from_user(dcbuf, buf, nbytes)) {
+		*((struct coda_in_hdr *)dcbuf) = hdr;
+		if (copy_from_user(dcbuf + sizeof(hdr),
+					buf + sizeof(hdr),
+					nbytes - sizeof(hdr))) {
 			CODA_FREE(dcbuf, nbytes);
 			retval = -EFAULT;
 			goto out;
@@ -137,14 +140,14 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 		CODA_FREE(dcbuf, nbytes);
 		if (error) {
 			pr_warn("%s: coda_downcall error: %d\n",
-				__func__, error);
+					__func__, error);
 			retval = error;
 			goto out;
 		}
 		count = nbytes;
 		goto out;
 	}
-        
+
 	/* Look for the message on the processing queue. */
 	mutex_lock(&vcp->vc_mutex);
 	list_for_each(lh, &vcp->vc_processing) {
@@ -159,19 +162,19 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 
 	if (!req) {
 		pr_warn("%s: msg (%d, %d) not found\n",
-			__func__, hdr.opcode, hdr.unique);
+				__func__, hdr.opcode, hdr.unique);
 		retval = -ESRCH;
 		goto out;
 	}
 
-        /* move data into response buffer. */
+	/* move data into response buffer. */
 	if (req->uc_outSize < nbytes) {
 		pr_warn("%s: too much cnt: %d, cnt: %ld, opc: %d, uniq: %d.\n",
-			__func__, req->uc_outSize, (long)nbytes,
-			hdr.opcode, hdr.unique);
+				__func__, req->uc_outSize, (long)nbytes,
+				hdr.opcode, hdr.unique);
 		nbytes = req->uc_outSize; /* don't have more space! */
 	}
-        if (copy_from_user(req->uc_data, buf, nbytes)) {
+	if (copy_from_user(req->uc_data, buf, nbytes)) {
 		req->uc_flags |= CODA_REQ_ABORT;
 		wake_up(&req->uc_sleep);
 		retval = -EFAULT;
@@ -191,9 +194,9 @@ static ssize_t coda_psdev_write(struct file *file, const char __user *buf,
 			outp->fh = fget(outp->fd);
 	}
 
-        wake_up(&req->uc_sleep);
+	wake_up(&req->uc_sleep);
 out:
-        return(count ? count : retval);  
+	return(count ? count : retval);
 }
 
 /*
-- 
2.17.2 (Apple Git-113)

