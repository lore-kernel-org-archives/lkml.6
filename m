Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521213873-2-9833653826147099526
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521213872; b=omuKZbaAeW3TYs52FIQ4Yb7PCMrbl1sSWpVlGjZzEf9TLw7
    XwbF3W/4vwOSLhKWji7hv5sgYEQWORClrmjAf6mGQPx3frdggHcRc2uzEfzdWv0Z
    mRTizJmN5BNHH9fInOkSTBTN1WfLxZiJ2pigqGrXAv3yBFr/P2aTcz1CtMNIX3sZ
    qlbhICV6gu+u1m3ssmXX9vnpUZZMyzd4OAFYyzncDpK155AZpsuOwb4MUEZFdVwm
    aZvJ8UCvFaKUiaFoG6aexUph6s7ii7Y0JE0MABEIZ6CMR0SZ1c8Yk30QccbIHcfn
    MeyLa+tZ/zgKEdJKXIIe8aW6EXCc8FjlKC+FLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521213872; bh=CYBJtluh8AH8GNzixlqmX2IdMt
    iEyxQ0TTev/MiUuHM=; b=mrS2Xv6p8kVe30OvadRiP95WXk/SlVlg6+rCjfoedB
    eVFI8ytBK7IvFX0WNfM279gdJ1OLTEeMFumIcYFQzjPqvbuUHs62gT+PCh54mZxe
    RBmpA1rN5n7yLrURkX/lfUAF4IMbeiAs881AkcYgUrTCzOO2KWowlnZ/5RBxwEPS
    lbM8LLrf9iYYE2twS8KH9sbZmPTEbfWZ6K7AAMp/s3mBsbO0Mc3JIecl2WFuB7HO
    mCMc0HoW9NADJU4zvB7oDBnRRtr73whEBwLhQ19UDNAfUi/jfeOJg3sj6l+5xNjv
    V6BE3qWSQLh6ePs1lvEPmIhgzAJQ8qTK4UC1AQLL0qfQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754021AbeCPPYB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:24:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33352 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753937AbeCPPX7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:23:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fredrik Noring <noring@nocrew.org>,
        Pete Zaitcev <zaitcev@redhat.com>
Subject: [PATCH 3.18 23/25] usb: usbmon: Read text within supplied buffer size
Date: Fri, 16 Mar 2018 16:23:10 +0100
Message-Id: <20180316152233.694601635@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pete Zaitcev <zaitcev@kotori.zaitcev.us>

commit a5f596830e27e15f7a0ecd6be55e433d776986d8 upstream.

This change fixes buffer overflows and silent data corruption with the
usbmon device driver text file read operations.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/mon/mon_text.c |  124 +++++++++++++++++++++++++++------------------
 1 file changed, 77 insertions(+), 47 deletions(-)

--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -82,6 +82,8 @@ struct mon_reader_text {
 
 	wait_queue_head_t wait;
 	int printf_size;
+	size_t printf_offset;
+	size_t printf_togo;
 	char *printf_buf;
 	struct mutex printf_lock;
 
@@ -373,75 +375,103 @@ err_alloc:
 	return rc;
 }
 
-/*
- * For simplicity, we read one record in one system call and throw out
- * what does not fit. This means that the following does not work:
- *   dd if=/dbg/usbmon/0t bs=10
- * Also, we do not allow seeks and do not bother advancing the offset.
- */
+static ssize_t mon_text_copy_to_user(struct mon_reader_text *rp,
+    char __user * const buf, const size_t nbytes)
+{
+	const size_t togo = min(nbytes, rp->printf_togo);
+
+	if (copy_to_user(buf, &rp->printf_buf[rp->printf_offset], togo))
+		return -EFAULT;
+	rp->printf_togo -= togo;
+	rp->printf_offset += togo;
+	return togo;
+}
+
+/* ppos is not advanced since the llseek operation is not permitted. */
 static ssize_t mon_text_read_t(struct file *file, char __user *buf,
-				size_t nbytes, loff_t *ppos)
+    size_t nbytes, loff_t *ppos)
 {
 	struct mon_reader_text *rp = file->private_data;
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
+	ssize_t ret;
 
-	ep = mon_text_read_wait(rp, file);
-	if (IS_ERR(ep))
-		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
-	ptr.cnt = 0;
-	ptr.pbuf = rp->printf_buf;
-	ptr.limit = rp->printf_size;
-
-	mon_text_read_head_t(rp, &ptr, ep);
-	mon_text_read_statset(rp, &ptr, ep);
-	ptr.cnt += snprintf(ptr.pbuf + ptr.cnt, ptr.limit - ptr.cnt,
-	    " %d", ep->length);
-	mon_text_read_data(rp, &ptr, ep);
 
-	if (copy_to_user(buf, rp->printf_buf, ptr.cnt))
-		ptr.cnt = -EFAULT;
+	if (rp->printf_togo == 0) {
+
+		ep = mon_text_read_wait(rp, file);
+		if (IS_ERR(ep)) {
+			mutex_unlock(&rp->printf_lock);
+			return PTR_ERR(ep);
+		}
+		ptr.cnt = 0;
+		ptr.pbuf = rp->printf_buf;
+		ptr.limit = rp->printf_size;
+
+		mon_text_read_head_t(rp, &ptr, ep);
+		mon_text_read_statset(rp, &ptr, ep);
+		ptr.cnt += snprintf(ptr.pbuf + ptr.cnt, ptr.limit - ptr.cnt,
+		    " %d", ep->length);
+		mon_text_read_data(rp, &ptr, ep);
+
+		rp->printf_togo = ptr.cnt;
+		rp->printf_offset = 0;
+
+		kmem_cache_free(rp->e_slab, ep);
+	}
+
+	ret = mon_text_copy_to_user(rp, buf, nbytes);
 	mutex_unlock(&rp->printf_lock);
-	kmem_cache_free(rp->e_slab, ep);
-	return ptr.cnt;
+	return ret;
 }
 
+/* ppos is not advanced since the llseek operation is not permitted. */
 static ssize_t mon_text_read_u(struct file *file, char __user *buf,
-				size_t nbytes, loff_t *ppos)
+    size_t nbytes, loff_t *ppos)
 {
 	struct mon_reader_text *rp = file->private_data;
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
+	ssize_t ret;
 
-	ep = mon_text_read_wait(rp, file);
-	if (IS_ERR(ep))
-		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
-	ptr.cnt = 0;
-	ptr.pbuf = rp->printf_buf;
-	ptr.limit = rp->printf_size;
 
-	mon_text_read_head_u(rp, &ptr, ep);
-	if (ep->type == 'E') {
-		mon_text_read_statset(rp, &ptr, ep);
-	} else if (ep->xfertype == USB_ENDPOINT_XFER_ISOC) {
-		mon_text_read_isostat(rp, &ptr, ep);
-		mon_text_read_isodesc(rp, &ptr, ep);
-	} else if (ep->xfertype == USB_ENDPOINT_XFER_INT) {
-		mon_text_read_intstat(rp, &ptr, ep);
-	} else {
-		mon_text_read_statset(rp, &ptr, ep);
+	if (rp->printf_togo == 0) {
+
+		ep = mon_text_read_wait(rp, file);
+		if (IS_ERR(ep)) {
+			mutex_unlock(&rp->printf_lock);
+			return PTR_ERR(ep);
+		}
+		ptr.cnt = 0;
+		ptr.pbuf = rp->printf_buf;
+		ptr.limit = rp->printf_size;
+
+		mon_text_read_head_u(rp, &ptr, ep);
+		if (ep->type == 'E') {
+			mon_text_read_statset(rp, &ptr, ep);
+		} else if (ep->xfertype == USB_ENDPOINT_XFER_ISOC) {
+			mon_text_read_isostat(rp, &ptr, ep);
+			mon_text_read_isodesc(rp, &ptr, ep);
+		} else if (ep->xfertype == USB_ENDPOINT_XFER_INT) {
+			mon_text_read_intstat(rp, &ptr, ep);
+		} else {
+			mon_text_read_statset(rp, &ptr, ep);
+		}
+		ptr.cnt += snprintf(ptr.pbuf + ptr.cnt, ptr.limit - ptr.cnt,
+		    " %d", ep->length);
+		mon_text_read_data(rp, &ptr, ep);
+
+		rp->printf_togo = ptr.cnt;
+		rp->printf_offset = 0;
+
+		kmem_cache_free(rp->e_slab, ep);
 	}
-	ptr.cnt += snprintf(ptr.pbuf + ptr.cnt, ptr.limit - ptr.cnt,
-	    " %d", ep->length);
-	mon_text_read_data(rp, &ptr, ep);
 
-	if (copy_to_user(buf, rp->printf_buf, ptr.cnt))
-		ptr.cnt = -EFAULT;
+	ret = mon_text_copy_to_user(rp, buf, nbytes);
 	mutex_unlock(&rp->printf_lock);
-	kmem_cache_free(rp->e_slab, ep);
-	return ptr.cnt;
+	return ret;
 }
 
 static struct mon_event_text *mon_text_read_wait(struct mon_reader_text *rp,
