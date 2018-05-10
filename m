Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2679656-1525981370-2-3890527743613654276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981369; b=DXKGS9g/CmMLQMmu6iskY59fbkORJZYT2+LoJ/Z1wFCyPZEu2o
    Wz1d5YwcE+/NoqtWas/V8EmIM2/orFM1gUk+TGa5WhnyAkDGTmtxzFdibhMnqINO
    Tv3qa3YfVrU888q5gdz4eMs9w0PZlcBGIWJGS/52Yh9kDyjIUyuNjFdXeO6QuE6f
    vus6UFu/BdIvCqcEeTFvuCru/190CPPjF/qBW/5tUsykkk08rJ5RQb1lrOgRhhH9
    kDRkdqgkn0QKhaYdSH06gazzxcwnqUVSGCC7JCox63GxaJ1upTxE2T9IMLaZ0aAi
    xZ231LCyQ+atFFSiVUiPuOvWPYdcv3ikIaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981369; bh=+h4+k
    RUNXUQeLCIkQXAm+CMOtqyxOGOQmxNfwgu6o1c=; b=SZjc21sH11+TKHiGDrP6M
    +u1HO02RMCdrSH+Dvanxxm8JQ5av/A8dhtVxI1iGAC7tzKlj/WHURnd0sAHvBiX4
    lJOYdFnHHjUh9PiaNaoHKl0lNdJj8+EhBMZZSacmDZpS9xZ5XYsAprG8u5t3diTq
    kkfwcLES7GfsRdMZs5DZI+zKI4zuPIwp9ZOe/qr1NtTtk0zh0sqqns1sa2I60KRG
    nm1SiqXv7cpkEqePJiz4nfOJtBvljLkDOf4Y7mZfjfXa05iyXasv1iJyjSrr/oJx
    tvc+8L+PUF391LV8A469F51oe1gVUqq52sfOLJmz4hOn7Ap9QF/i1kzmwaNr/lub
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJGAXRWoQl7zTWkIdPZN0mfvEzrjmSuWy4vme4o1el9Hu6QCdMhfIxE75F/YlA5EQFWNazGu9A1mTiniLjaG3ak84lAdGhtJs0Ny3rv6TIiDa2vExMtL
    EsDalsDG1Xh8fP0hRABS2BA/jLxHmJab3PVGXA6Bdler4y7ttiU2X+sERkSGbjRuwMnrM9vGSRyKu3yrIAn0lYX8KVfwfmN+O7ilRHhGIN/rtXXBfnrfN4Gr
    TeWZx6go11LNfl6R6ApQfA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=WFZIRff2AAAA:8 a=-VAfIpHNAAAA:8
    a=DDOyTI_5AAAA:8 a=isAAMIIMwHijGi9bxkoA:9 a=1-5pFQniNagNjkXq:21
    a=n1yaq1Dk7tFo4C_F:21 a=CjuIK1q_8ugA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 07/15] staging: bcm2835-camera: Remove V4L2/MMAL buffer
 remapping
Date: Thu, 10 May 2018 12:42:11 -0700
Message-Id: <20180510194220.30675-8-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510194220.30675-1-eric@anholt.net>
References: <20180510194220.30675-1-eric@anholt.net>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Eric Anholt <eric@anholt.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

The MMAL and V4L2 buffers had been disassociated, and linked on
demand.  Seeing as both are finite and low in number, and we now have
the same number of each, link them for the duration.  This removes the
complexity of maintaining lists as the struct mmal_buffer context
comes back from the VPU, so we can directly link back to the relevant
V4L2 buffer.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bcm2835-camera/bcm2835-camera.c           |   7 +-
 .../vc04_services/bcm2835-camera/mmal-vchiq.c | 109 ++++--------------
 2 files changed, 29 insertions(+), 87 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 8553b677eb08..c5ca56414139 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -299,8 +299,8 @@ static int buffer_prepare(struct vb2_buffer *vb)
 	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vb->vb2_queue);
 	unsigned long size;
 
-	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev, "%s: dev:%p\n",
-		 __func__, dev);
+	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev, "%s: dev:%p, vb %p\n",
+		 __func__, dev, vb);
 
 	BUG_ON(!dev->capture.port);
 	BUG_ON(!dev->capture.fmt);
@@ -492,7 +492,8 @@ static void buffer_queue(struct vb2_buffer *vb)
 	int ret;
 
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
-		 "%s: dev:%p buf:%p\n", __func__, dev, buf);
+		 "%s: dev:%p buf:%p, idx %u\n",
+		 __func__, dev, buf, vb2->vb2_buf.index);
 
 	ret = vchiq_mmal_submit_buffer(dev->instance, dev->capture.port, buf);
 	if (ret < 0)
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 0f1961aeb223..3a3b843fc122 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -326,16 +326,12 @@ static int bulk_receive(struct vchiq_mmal_instance *instance,
 			struct mmal_msg_context *msg_context)
 {
 	unsigned long rd_len;
-	unsigned long flags = 0;
 	int ret;
 
 	rd_len = msg->u.buffer_from_host.buffer_header.length;
 
-	/* take buffer from queue */
-	spin_lock_irqsave(&msg_context->u.bulk.port->slock, flags);
-	if (list_empty(&msg_context->u.bulk.port->buffers)) {
-		spin_unlock_irqrestore(&msg_context->u.bulk.port->slock, flags);
-		pr_err("buffer list empty trying to submit bulk receive\n");
+	if (!msg_context->u.bulk.buffer) {
+		pr_err("bulk.buffer not configured - error in buffer_from_host\n");
 
 		/* todo: this is a serious error, we should never have
 		 * committed a buffer_to_host operation to the mmal
@@ -350,13 +346,6 @@ static int bulk_receive(struct vchiq_mmal_instance *instance,
 		return -EINVAL;
 	}
 
-	msg_context->u.bulk.buffer =
-	    list_entry(msg_context->u.bulk.port->buffers.next,
-		       struct mmal_buffer, list);
-	list_del(&msg_context->u.bulk.buffer->list);
-
-	spin_unlock_irqrestore(&msg_context->u.bulk.port->slock, flags);
-
 	/* ensure we do not overrun the available buffer */
 	if (rd_len > msg_context->u.bulk.buffer->buffer_size) {
 		rd_len = msg_context->u.bulk.buffer->buffer_size;
@@ -419,31 +408,6 @@ static int inline_receive(struct vchiq_mmal_instance *instance,
 			  struct mmal_msg *msg,
 			  struct mmal_msg_context *msg_context)
 {
-	unsigned long flags = 0;
-
-	/* take buffer from queue */
-	spin_lock_irqsave(&msg_context->u.bulk.port->slock, flags);
-	if (list_empty(&msg_context->u.bulk.port->buffers)) {
-		spin_unlock_irqrestore(&msg_context->u.bulk.port->slock, flags);
-		pr_err("buffer list empty trying to receive inline\n");
-
-		/* todo: this is a serious error, we should never have
-		 * committed a buffer_to_host operation to the mmal
-		 * port without the buffer to back it up (with
-		 * underflow handling) and there is no obvious way to
-		 * deal with this. Less bad than the bulk case as we
-		 * can just drop this on the floor but...unhelpful
-		 */
-		return -EINVAL;
-	}
-
-	msg_context->u.bulk.buffer =
-	    list_entry(msg_context->u.bulk.port->buffers.next,
-		       struct mmal_buffer, list);
-	list_del(&msg_context->u.bulk.buffer->list);
-
-	spin_unlock_irqrestore(&msg_context->u.bulk.port->slock, flags);
-
 	memcpy(msg_context->u.bulk.buffer->buffer,
 	       msg->u.buffer_from_host.short_data,
 	       msg->u.buffer_from_host.payload_in_message);
@@ -463,6 +427,9 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 	struct mmal_msg m;
 	int ret;
 
+	if (!port->enabled)
+		return -EINVAL;
+
 	pr_debug("instance:%p buffer:%p\n", instance->handle, buf);
 
 	/* get context */
@@ -476,7 +443,7 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 	/* store bulk message context for when data arrives */
 	msg_context->u.bulk.instance = instance;
 	msg_context->u.bulk.port = port;
-	msg_context->u.bulk.buffer = NULL;	/* not valid until bulk xfer */
+	msg_context->u.bulk.buffer = buf;
 	msg_context->u.bulk.buffer_used = 0;
 
 	/* initialise work structure ready to schedule callback */
@@ -526,43 +493,6 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 	return ret;
 }
 
-/* submit a buffer to the mmal sevice
- *
- * the buffer_from_host uses size data from the ports next available
- * mmal_buffer and deals with there being no buffer available by
- * incrementing the underflow for later
- */
-static int port_buffer_from_host(struct vchiq_mmal_instance *instance,
-				 struct vchiq_mmal_port *port)
-{
-	int ret;
-	struct mmal_buffer *buf;
-	unsigned long flags = 0;
-
-	if (!port->enabled)
-		return -EINVAL;
-
-	/* peek buffer from queue */
-	spin_lock_irqsave(&port->slock, flags);
-	if (list_empty(&port->buffers)) {
-		spin_unlock_irqrestore(&port->slock, flags);
-		return -ENOSPC;
-	}
-
-	buf = list_entry(port->buffers.next, struct mmal_buffer, list);
-
-	spin_unlock_irqrestore(&port->slock, flags);
-
-	/* issue buffer to mmal service */
-	ret = buffer_from_host(instance, port, buf);
-	if (ret) {
-		pr_err("adding buffer header failed\n");
-		/* todo: how should this be dealt with */
-	}
-
-	return ret;
-}
-
 /* deals with receipt of buffer to host message */
 static void buffer_to_host_cb(struct vchiq_mmal_instance *instance,
 			      struct mmal_msg *msg, u32 msg_len)
@@ -1420,7 +1350,14 @@ static int port_disable(struct vchiq_mmal_instance *instance,
 	ret = port_action_port(instance, port,
 			       MMAL_MSG_PORT_ACTION_TYPE_DISABLE);
 	if (ret == 0) {
-		/* drain all queued buffers on port */
+		/*
+		 * Drain all queued buffers on port. This should only
+		 * apply to buffers that have been queued before the port
+		 * has been enabled. If the port has been enabled and buffers
+		 * passed, then the buffers should have been removed from this
+		 * list, and we should get the relevant callbacks via VCHIQ
+		 * to release the buffers.
+		 */
 		spin_lock_irqsave(&port->slock, flags);
 
 		list_for_each_safe(buf_head, q, &port->buffers) {
@@ -1449,7 +1386,7 @@ static int port_enable(struct vchiq_mmal_instance *instance,
 		       struct vchiq_mmal_port *port)
 {
 	unsigned int hdr_count;
-	struct list_head *buf_head;
+	struct list_head *q, *buf_head;
 	int ret;
 
 	if (port->enabled)
@@ -1475,7 +1412,7 @@ static int port_enable(struct vchiq_mmal_instance *instance,
 	if (port->buffer_cb) {
 		/* send buffer headers to videocore */
 		hdr_count = 1;
-		list_for_each(buf_head, &port->buffers) {
+		list_for_each_safe(buf_head, q, &port->buffers) {
 			struct mmal_buffer *mmalbuf;
 
 			mmalbuf = list_entry(buf_head, struct mmal_buffer,
@@ -1484,6 +1421,7 @@ static int port_enable(struct vchiq_mmal_instance *instance,
 			if (ret)
 				goto done;
 
+			list_del(buf_head);
 			hdr_count++;
 			if (hdr_count > port->current_buffer.num)
 				break;
@@ -1696,12 +1634,15 @@ int vchiq_mmal_submit_buffer(struct vchiq_mmal_instance *instance,
 			     struct mmal_buffer *buffer)
 {
 	unsigned long flags = 0;
+	int ret;
 
-	spin_lock_irqsave(&port->slock, flags);
-	list_add_tail(&buffer->list, &port->buffers);
-	spin_unlock_irqrestore(&port->slock, flags);
-
-	port_buffer_from_host(instance, port);
+	ret = buffer_from_host(instance, port, buffer);
+	if (ret == -EINVAL) {
+		/* Port is disabled. Queue for when it is enabled. */
+		spin_lock_irqsave(&port->slock, flags);
+		list_add_tail(&buffer->list, &port->buffers);
+		spin_unlock_irqrestore(&port->slock, flags);
+	}
 
 	return 0;
 }
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
