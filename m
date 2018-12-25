Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0EDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 20:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2450F2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 20:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbeLYUZZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 15:25:25 -0500
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:48090 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbeLYUZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 15:25:24 -0500
Received: from [73.183.111.55] (helo=[10.0.0.231])
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.91)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1gbtGU-0001oX-18; Tue, 25 Dec 2018 15:25:22 -0500
Date:   Tue, 25 Dec 2018 15:25:20 -0500
In-Reply-To: <20181225185814.69047-1-kjlu@umn.edu>
References: <20181225185814.69047-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Autocrypt: addr=jaharkes@cs.cmu.edu; keydata=
 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
Subject: Re: [PATCH] fs: coda: fix a double-fetch case in coda_psdev_write
To:     Kangjie Lu <kjlu@umn.edu>, kjlu@umn.edu
CC:     pakki001@umn.edu, linux-kernel@vger.kernel.org
From:   Jan Harkes <jaharkes@cs.cmu.edu>
Message-ID: <81E76C6E-91C7-4BD6-8255-318DCAE66BAA@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has come up before, and as you noticed nothing in that header is looked at after that second copy.

Also if the user space cache manager was trying to be malicious it wouldn't have to resort to multi-threaded race conditions. It could make a setuid root shell appear, or many other things a file system can do.

Jan

On December 25, 2018 2:03:51 PM EST, Kangjie Lu <kjlu@umn.edu> wrote:
>"hdr" has been copied in from user space and "hdr.opcode" is checked.
>The code copies it again. User space data between the two copies is
>subject to modification if the user-space code is multithreaded and
>malicious. The modification may invalidate the check. In the original
>code, "hdr.opcode" is not used after the second copy, so it is actually
>safe with the current code. However, in case future code may use
>"hdr.opcode", let's avoid copying the header from user space again.
>
>Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>---
> fs/coda/psdev.c | 41 ++++++++++++++++++++++-------------------
> 1 file changed, 22 insertions(+), 19 deletions(-)
>
>diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
>index c5234c21b539..fb4d1c654773 100644
>--- a/fs/coda/psdev.c
>+++ b/fs/coda/psdev.c
>@@ -97,35 +97,38 @@ static long coda_psdev_ioctl(struct file * filp,
>unsigned int cmd, unsigned long
>static ssize_t coda_psdev_write(struct file *file, const char __user
>*buf, 
> 				size_t nbytes, loff_t *off)
> {
>-        struct venus_comm *vcp = (struct venus_comm *)
>file->private_data;
>-        struct upc_req *req = NULL;
>-        struct upc_req *tmp;
>+	struct venus_comm *vcp = (struct venus_comm *) file->private_data;
>+	struct upc_req *req = NULL;
>+	struct upc_req *tmp;
> 	struct list_head *lh;
> 	struct coda_in_hdr hdr;
> 	ssize_t retval = 0, count = 0;
> 	int error;
> 
>-        /* Peek at the opcode, uniquefier */
>+	/* Peek at the opcode, uniquefier */
> 	if (copy_from_user(&hdr, buf, 2 * sizeof(u_long)))
>-	        return -EFAULT;
>+		return -EFAULT;
> 
>-        if (DOWNCALL(hdr.opcode)) {
>+	if (DOWNCALL(hdr.opcode)) {
> 		union outputArgs *dcbuf;
> 		int size = sizeof(*dcbuf);
> 
> 		if  ( nbytes < sizeof(struct coda_out_hdr) ) {
> 			pr_warn("coda_downcall opc %d uniq %d, not enough!\n",
>-				hdr.opcode, hdr.unique);
>+					hdr.opcode, hdr.unique);
> 			count = nbytes;
> 			goto out;
> 		}
> 		if ( nbytes > size ) {
> 			pr_warn("downcall opc %d, uniq %d, too much!",
>-				hdr.opcode, hdr.unique);
>-		        nbytes = size;
>+					hdr.opcode, hdr.unique);
>+			nbytes = size;
> 		}
> 		CODA_ALLOC(dcbuf, union outputArgs *, nbytes);
>-		if (copy_from_user(dcbuf, buf, nbytes)) {
>+		*((struct coda_in_hdr *)dcbuf) = hdr;
>+		if (copy_from_user(dcbuf + sizeof(hdr),
>+					buf + sizeof(hdr),
>+					nbytes - sizeof(hdr))) {
> 			CODA_FREE(dcbuf, nbytes);
> 			retval = -EFAULT;
> 			goto out;
>@@ -137,14 +140,14 @@ static ssize_t coda_psdev_write(struct file
>*file, const char __user *buf,
> 		CODA_FREE(dcbuf, nbytes);
> 		if (error) {
> 			pr_warn("%s: coda_downcall error: %d\n",
>-				__func__, error);
>+					__func__, error);
> 			retval = error;
> 			goto out;
> 		}
> 		count = nbytes;
> 		goto out;
> 	}
>-        
>+
> 	/* Look for the message on the processing queue. */
> 	mutex_lock(&vcp->vc_mutex);
> 	list_for_each(lh, &vcp->vc_processing) {
>@@ -159,19 +162,19 @@ static ssize_t coda_psdev_write(struct file
>*file, const char __user *buf,
> 
> 	if (!req) {
> 		pr_warn("%s: msg (%d, %d) not found\n",
>-			__func__, hdr.opcode, hdr.unique);
>+				__func__, hdr.opcode, hdr.unique);
> 		retval = -ESRCH;
> 		goto out;
> 	}
> 
>-        /* move data into response buffer. */
>+	/* move data into response buffer. */
> 	if (req->uc_outSize < nbytes) {
> 		pr_warn("%s: too much cnt: %d, cnt: %ld, opc: %d, uniq: %d.\n",
>-			__func__, req->uc_outSize, (long)nbytes,
>-			hdr.opcode, hdr.unique);
>+				__func__, req->uc_outSize, (long)nbytes,
>+				hdr.opcode, hdr.unique);
> 		nbytes = req->uc_outSize; /* don't have more space! */
> 	}
>-        if (copy_from_user(req->uc_data, buf, nbytes)) {
>+	if (copy_from_user(req->uc_data, buf, nbytes)) {
> 		req->uc_flags |= CODA_REQ_ABORT;
> 		wake_up(&req->uc_sleep);
> 		retval = -EFAULT;
>@@ -191,9 +194,9 @@ static ssize_t coda_psdev_write(struct file *file,
>const char __user *buf,
> 			outp->fh = fget(outp->fd);
> 	}
> 
>-        wake_up(&req->uc_sleep);
>+	wake_up(&req->uc_sleep);
> out:
>-        return(count ? count : retval);  
>+	return(count ? count : retval);
> }
> 
> /*
