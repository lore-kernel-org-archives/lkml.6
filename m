Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2676370-1525981359-2-6481674442562510622
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981357; b=bj+NwfAjIFn7sQcNssg6wboViuLYRusgs6/aypMKF+2Kq/h3IH
    H5ySnREJ3/5oIzqHyxL6HehOsLBb4TcRNx/jHsFq/uXW0Q7rzi2+n0EwAAX/Fpb9
    96h/k2UvirVPYRipvcfL5PqelnVGSL5bBlc6OxvhRNImDgKwcM5Os0mBeMltt62n
    aVtmio14Z5JIiOPSgOLeUh2UcU2pqRR3lwxcnAVHSyPdCpOj0VEndD6eBOo85YtP
    M6wfYJhfAm01Dh2wbW78tTMaocWnH9Pf9Nxt428Q5B9ZD/0EqUUCJuayYEv2jmNC
    UCWvaCjY5wgTWCylaMsTbMtnX4Bq5aJWmqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981357; bh=QpXcz
    7olYWtQPCHIwTQGhmtFU7S9Q42PS6WMkIuiO1E=; b=JR/DKm4YJ6H8/KGL6PEFb
    8sMZ4JNdyr4KYhniJN3eQZ7IG0hPNx8W+nQQP6OEyyBG6juS2hq1ILoywh2h94Rb
    VbCc7Gnr9o4C2dXx+SUgxCvV7cxpthIIKrZprd5BeZMymIbNqGGlQHzy32pc8W37
    yL51poNK2At/BFVFopqI5TEepU/SmrneZmkBCdSHMaaQYpaQls9cc8ugJDCnBuGg
    juATIlKY3eP0EGSZVhpVrO2Pkl7rGvkgGP3SSG5K18mBrnruPUKTzB4P7dTWkdX7
    XgmZgsizXF/HgiV00+ca4jh4rAPikt71KRRd0n4+79Cd5ucky95rjR3ewlwMx6qn
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfDLh3CEhWV7YlgZCOxlIreRHshKdhqQetwTPJ97LPHsfYHi2RH9XV9G3G+miTd/6YqCWkCEiWvrrnlnGGunNRl+bLKaYvgYPY0G7RI9BRC9JVkPI2Cs5
    PnJ0YARqeg+3be/a6edAo87e+wWZHgINw1ky3NSm3dpmmpfhuHyZbfB+XrmV4mdPXNd/ZbbZ5qNEozv3txCT4Bvm7hYzIsoWG+UN6HZOKp/zUozeMULFVcPg
    eN5HOZ6UGb20Lnz5YMTc2Q==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=WFZIRff2AAAA:8 a=-VAfIpHNAAAA:8
    a=DDOyTI_5AAAA:8 a=cPnG7trEE0XDhgrGWNYA:9 a=CjuIK1q_8ugA:10
    a=srlwD-8ojaedGGhPAyx8:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 04/15] staging: bcm2835-camera: Allocate context once per
 buffer
Date: Thu, 10 May 2018 12:42:08 -0700
Message-Id: <20180510194220.30675-5-eric@anholt.net>
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

The struct mmal_msg_context was being allocated for every message
being sent to the VPU, and freed when it came back.  Whilst that is
required behaviour for some messages (mainly the synchronous ones), it
is wasteful for the video buffers that make up the majority of the
traffic.

Add to the buffer_init/cleanup hooks that it allocates/frees the
msg_context required.

v2: changes by anholt from the downstream tree: clean up indentation,
    pass an error value through, forward-declare the struct so we have
    less void *

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bcm2835-camera/bcm2835-camera.c           | 30 +++++++++++++--
 .../bcm2835-camera/mmal-common.h              |  4 ++
 .../vc04_services/bcm2835-camera/mmal-vchiq.c | 38 ++++++++++++++-----
 .../vc04_services/bcm2835-camera/mmal-vchiq.h |  3 ++
 4 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 7b32c3a93873..dc1c2775bc0b 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -278,6 +278,20 @@ static int queue_setup(struct vb2_queue *vq,
 	return 0;
 }
 
+static int buffer_init(struct vb2_buffer *vb)
+{
+	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vb2 = to_vb2_v4l2_buffer(vb);
+	struct mmal_buffer *buf = container_of(vb2, struct mmal_buffer, vb);
+
+	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev, "%s: dev:%p, vb %p\n",
+		 __func__, dev, vb);
+	buf->buffer = vb2_plane_vaddr(&buf->vb.vb2_buf, 0);
+	buf->buffer_size = vb2_plane_size(&buf->vb.vb2_buf, 0);
+
+	return mmal_vchi_buffer_init(dev->instance, buf);
+}
+
 static int buffer_prepare(struct vb2_buffer *vb)
 {
 	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vb->vb2_queue);
@@ -300,6 +314,17 @@ static int buffer_prepare(struct vb2_buffer *vb)
 	return 0;
 }
 
+static void buffer_cleanup(struct vb2_buffer *vb)
+{
+	struct bm2835_mmal_dev *dev = vb2_get_drv_priv(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vb2 = to_vb2_v4l2_buffer(vb);
+	struct mmal_buffer *buf = container_of(vb2, struct mmal_buffer, vb);
+
+	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev, "%s: dev:%p, vb %p\n",
+		 __func__, dev, vb);
+	mmal_vchi_buffer_cleanup(buf);
+}
+
 static inline bool is_capturing(struct bm2835_mmal_dev *dev)
 {
 	return dev->capture.camera_port ==
@@ -467,9 +492,6 @@ static void buffer_queue(struct vb2_buffer *vb)
 	v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
 		 "%s: dev:%p buf:%p\n", __func__, dev, buf);
 
-	buf->buffer = vb2_plane_vaddr(&buf->vb.vb2_buf, 0);
-	buf->buffer_size = vb2_plane_size(&buf->vb.vb2_buf, 0);
-
 	ret = vchiq_mmal_submit_buffer(dev->instance, dev->capture.port, buf);
 	if (ret < 0)
 		v4l2_err(&dev->v4l2_dev, "%s: error submitting buffer\n",
@@ -632,7 +654,9 @@ static void bm2835_mmal_unlock(struct vb2_queue *vq)
 
 static const struct vb2_ops bm2835_mmal_video_qops = {
 	.queue_setup = queue_setup,
+	.buf_init = buffer_init,
 	.buf_prepare = buffer_prepare,
+	.buf_cleanup = buffer_cleanup,
 	.buf_queue = buffer_queue,
 	.start_streaming = start_streaming,
 	.stop_streaming = stop_streaming,
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-common.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-common.h
index e68ca1bf7222..fe079d054174 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-common.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-common.h
@@ -19,6 +19,8 @@
 /** Special value signalling that time is not known */
 #define MMAL_TIME_UNKNOWN (1LL<<63)
 
+struct mmal_msg_context;
+
 /* mapping between v4l and mmal video modes */
 struct mmal_fmt {
 	char  *name;
@@ -43,6 +45,8 @@ struct mmal_buffer {
 
 	void *buffer; /* buffer pointer */
 	unsigned long buffer_size; /* size of allocated buffer */
+
+	struct mmal_msg_context *msg_context;
 };
 
 /* */
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index a91ef6ea29ce..037c68b83df9 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -321,8 +321,6 @@ static void buffer_work_cb(struct work_struct *work)
 					    msg_context->u.bulk.dts,
 					    msg_context->u.bulk.pts);
 
-	/* release message context */
-	release_msg_context(msg_context);
 }
 
 /* enqueue a bulk receive for a given message context */
@@ -503,11 +501,13 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 		return -EINTR;
 
 	/* get context */
-	msg_context = get_msg_context(instance);
-	if (IS_ERR(msg_context)) {
-		ret = PTR_ERR(msg_context);
+	if (!buf->msg_context) {
+		pr_err("%s: msg_context not allocated, buf %p\n", __func__,
+		       buf);
+		ret = -EINVAL;
 		goto unlock;
 	}
+	msg_context = buf->msg_context;
 
 	/* store bulk message context for when data arrives */
 	msg_context->u.bulk.instance = instance;
@@ -557,11 +557,6 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 					sizeof(struct mmal_msg_header) +
 					sizeof(m.u.buffer_from_host));
 
-	if (ret != 0) {
-		release_msg_context(msg_context);
-		/* todo: is this correct error value? */
-	}
-
 	vchi_service_release(instance->handle);
 
 unlock:
@@ -1775,6 +1770,29 @@ int vchiq_mmal_submit_buffer(struct vchiq_mmal_instance *instance,
 	return 0;
 }
 
+int mmal_vchi_buffer_init(struct vchiq_mmal_instance *instance,
+			  struct mmal_buffer *buf)
+{
+	struct mmal_msg_context *msg_context = get_msg_context(instance);
+
+	if (IS_ERR(msg_context))
+		return (PTR_ERR(msg_context));
+
+	buf->msg_context = msg_context;
+	return 0;
+}
+
+int mmal_vchi_buffer_cleanup(struct mmal_buffer *buf)
+{
+	struct mmal_msg_context *msg_context = buf->msg_context;
+
+	if (msg_context)
+		release_msg_context(msg_context);
+	buf->msg_context = NULL;
+
+	return 0;
+}
+
 /* Initialise a mmal component and its ports
  *
  */
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
index b1f22b6dca10..dadf47fe1bdc 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
@@ -168,4 +168,7 @@ int vchiq_mmal_submit_buffer(struct vchiq_mmal_instance *instance,
 			     struct vchiq_mmal_port *port,
 			     struct mmal_buffer *buf);
 
+int mmal_vchi_buffer_init(struct vchiq_mmal_instance *instance,
+			  struct mmal_buffer *buf);
+int mmal_vchi_buffer_cleanup(struct mmal_buffer *buf);
 #endif /* MMAL_VCHIQ_H */
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
