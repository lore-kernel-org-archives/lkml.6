Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2676370-1525981374-2-15540686899286289467
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981374; b=BfFkjQbZe6h7uFvsojdSnT+BZA8tSk6Y4masn4q0CnGMUu2vAM
    qpLniToBoqzOy7HOE+IHojbypuotzvNmsPGiJk4I/Ckr4GQBMotLcOGBsI1f9V75
    Ij9IYVnRVSYLcRE9g5bIBqYhb8NXn4Tfnt6XTWb00QnYnv2F23GhTMlAE8N+zquJ
    ll7G/U+UdmdpUi9ZadERfevVC1F5vd9zJMT4z7qE87Po76K1yWTrBTbypmB1Nz19
    05J5jpgnVf1aROc+Y1969DcbKVwE0cM6oGcHJ9a9mpIaEPOjb/L01LxBMukmUDMA
    2j8Z39gyKU2yl3gJNWwwnjNE8nh3sPGPkWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981374; bh=bBS+j
    I0MjHX2n9Wak5uyNxqlgO7PAQGQ93t+sqk+42U=; b=eTeXUlJr/8xuuivVqNZZG
    3pShAu4hQPxcWa+KOu37bxLYdg34nd96k+nir/oZJu5Nq4vWxeCrOZx4pQvA43rm
    AGlqVoR6vMfvfOcVGgni9DBG0wtsp/njG7H3KbnZOoAGaEMs+tTEy08hOatT8Ztf
    ws81InvkNbcY0LO6CT9LYDxAF7z4eIeRFY9zb+gp4gysjKEdLSSMyCzNbYhR54fu
    CmoSXwZ9QvkjZlSX/aB6Wh5vG0PVN6HZUbEWdnVgqENJ1XZqE03u2UjcvM2OuOnF
    lDb4AESugeirlJdzuDYJ5lc1vWh64NLcdyNJQar1MdK/Oi4aAH/HJTyz9/4r5pwA
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=anholt.net;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
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
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=anholt.net header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIG0WkvzOLkThDZe4ZwYWNyv18iseXtGW5lKu2UHo9vxSXfeLxg3krI12IsqSyWWKSdMDxo4iMGuvArCBymfuAa+0l5lUbYesOEcFSlvxNob52t2Qknu
    d1GeFNwCVueaNuyi2pLAdEhZlhY2kwyM5JUdftmoQAVeJFe4qbVwE+Tcc31Hsd+5U35HpuS+/WFWjmfmw8REtJGfXFeCHM6pEZHmaS+rM9PT19kMOyZMDqvc
    2RJNLOjIW/ON6BSuTARJqQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=WFZIRff2AAAA:8 a=-VAfIpHNAAAA:8
    a=DDOyTI_5AAAA:8 a=ahRXuR5nUfPsMiTnCiMA:9 a=zIA4z0u7Ssv4q3y8:21
    a=zBof9SqIcVGBi4ow:21 a=CjuIK1q_8ugA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 06/15] staging: bcm2835-camera: Match MMAL buffer count to
 V4L2.
Date: Thu, 10 May 2018 12:42:10 -0700
Message-Id: <20180510194220.30675-7-eric@anholt.net>
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

For historical reasons, the number of buffers passed to the VPU over
MMAL did not match that passed from V4L2.  That is a silly situation
as the driver has to duplicate serialisation and other functions that
have already been implemented in V4L2/videobuf2.

As we had more V4L2 buffers than MMAL ones, the MMAL buffer headers
were returned to the VPU immediately on being filled, which is now
invalid.

Match the number of buffers notified in queue_setup with that used in
MMAL.  Return buffers only when we get them from V4L2.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../bcm2835-camera/bcm2835-camera.c           |  6 ++++--
 .../vc04_services/bcm2835-camera/mmal-vchiq.c | 21 +------------------
 .../vc04_services/bcm2835-camera/mmal-vchiq.h |  4 ----
 3 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index dc1c2775bc0b..8553b677eb08 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -260,8 +260,10 @@ static int queue_setup(struct vb2_queue *vq,
 		return -EINVAL;
 	}
 
-	if (*nbuffers < (dev->capture.port->current_buffer.num + 2))
-		*nbuffers = (dev->capture.port->current_buffer.num + 2);
+	if (*nbuffers < dev->capture.port->minimum_buffer.num)
+		*nbuffers = dev->capture.port->minimum_buffer.num;
+
+	dev->capture.port->current_buffer.num = *nbuffers;
 
 	*nplanes = 1;
 
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index d6950226551f..0f1961aeb223 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -545,7 +545,6 @@ static int port_buffer_from_host(struct vchiq_mmal_instance *instance,
 	/* peek buffer from queue */
 	spin_lock_irqsave(&port->slock, flags);
 	if (list_empty(&port->buffers)) {
-		port->buffer_underflow++;
 		spin_unlock_irqrestore(&port->slock, flags);
 		return -ENOSPC;
 	}
@@ -636,9 +635,6 @@ static void buffer_to_host_cb(struct vchiq_mmal_instance *instance,
 		    msg->u.buffer_from_host.payload_in_message;
 	}
 
-	/* replace the buffer header */
-	port_buffer_from_host(instance, msg_context->u.bulk.port);
-
 	/* schedule the port callback */
 	schedule_work(&msg_context->u.bulk.work);
 }
@@ -646,10 +642,6 @@ static void buffer_to_host_cb(struct vchiq_mmal_instance *instance,
 static void bulk_receive_cb(struct vchiq_mmal_instance *instance,
 			    struct mmal_msg_context *msg_context)
 {
-	/* replace the buffer header */
-	port_buffer_from_host(msg_context->u.bulk.instance,
-			      msg_context->u.bulk.port);
-
 	msg_context->u.bulk.status = 0;
 
 	/* schedule the port callback */
@@ -661,10 +653,6 @@ static void bulk_abort_cb(struct vchiq_mmal_instance *instance,
 {
 	pr_err("%s: bulk ABORTED msg_context:%p\n", __func__, msg_context);
 
-	/* replace the buffer header */
-	port_buffer_from_host(msg_context->u.bulk.instance,
-			      msg_context->u.bulk.port);
-
 	msg_context->u.bulk.status = -EINTR;
 
 	schedule_work(&msg_context->u.bulk.work);
@@ -1713,14 +1701,7 @@ int vchiq_mmal_submit_buffer(struct vchiq_mmal_instance *instance,
 	list_add_tail(&buffer->list, &port->buffers);
 	spin_unlock_irqrestore(&port->slock, flags);
 
-	/* the port previously underflowed because it was missing a
-	 * mmal_buffer which has just been added, submit that buffer
-	 * to the mmal service.
-	 */
-	if (port->buffer_underflow) {
-		port_buffer_from_host(instance, port);
-		port->buffer_underflow--;
-	}
+	port_buffer_from_host(instance, port);
 
 	return 0;
 }
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
index dadf47fe1bdc..0ab9f660b822 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
@@ -79,10 +79,6 @@ struct vchiq_mmal_port {
 	struct list_head buffers;
 	/* lock to serialise adding and removing buffers from list */
 	spinlock_t slock;
-	/* count of how many buffer header refils have failed because
-	 * there was no buffer to satisfy them
-	 */
-	int buffer_underflow;
 	/* callback on buffer completion */
 	vchiq_mmal_buffer_cb buffer_cb;
 	/* callback context */
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
