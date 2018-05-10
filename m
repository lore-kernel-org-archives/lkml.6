Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2676370-1525981367-2-9273455147994918489
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525981366; b=hvOAhko1v/fDe1vbZpf93nXKbg9noQXrp+gPzthZRr7mmNeZ0o
    el0aZ69hk6aKrrXV3RYddRJ6d9/MNCqDLbCA4uxTE9lh/l7aIZW46jTyr0IpTRNv
    LAWs7uh4a0UzWLhWT+wtxn2l4BjZTngumV4QGOoizK9oZNyZLSz35uXHxVH6mSR4
    Zm1q6RRnvZ1edeGvYzegagB1RuoJTbWjdh+9TBCA9bZud/gBQvo4xM9fcnOQ56qt
    3Djx0lXHTEP7kp+JZnX9ffEgJFejkE9vayCT78FNcMGnSuC9Ulk2aPkh9rwFx1cb
    ELgjlifYId0PcPTpZhjICvXa9LGe0kNMKqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525981366; bh=qao+s
    Iz0TBIBsBhLSHUh/UC9oQtAYyFNTfQTqUOPawA=; b=ZugCEewxo2uKTQihZDDNY
    tLDJlN91w4goZSkz94RpEdusq1gNakUO10r7yo6+Lx7aosw5BFIXj1p9/3CqfMMF
    Qvmea4ND7KLBnRTM2eT571TGntNnw6k0G6N3FIjfJ6y/YtsRUkZcKwdJKDKlDObx
    xi4lUwtXCDGAscTLZLcot3U0gOQqT8y86id1yapaF4ecNS7LhB4S/k4tdMnqWWJv
    tGn4H83iPr3sXT62wv5mOLs++2oJxHk3F8QOQ8nYTxTIjod8cUwB4ngUfVJlc8zh
    tTX1FPTa1G7MYkPYh183saKq8KSzjiKayyH2gNm6Nk06Dr5DVwJw603Euhzi1EAq
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfJRGhxY6PqHN3bI6wQ35dED6JJEpdmpjyfHriechol7reRS18Q9+X7JQaOnQAWKkhrn89OLdLlW15y4FZ3VER2fTL+O9YkTq2QEmbTwRw0LX1EpmD0he
    Yv6lgeNyMqVg5HKrKUGHk+VsVjnY45V5yhmFm0Vvzn4FS6Fe9cjljFCs6NkSOBB9qlvkL6dFY4W1E7DGT+nCSzHHwchUAa3GZEp9iCwAQIe0q+FSYwGlI3pU
    EqzVI/HYy+QBl070+NCMVw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=WFZIRff2AAAA:8 a=-VAfIpHNAAAA:8
    a=DDOyTI_5AAAA:8 a=wBpaVf9PQ3uuvB7-36QA:9 a=kUQxAbrDQ1du1lFW:21
    a=RlQX-ZrPfKMgNLcZ:21 a=CjuIK1q_8ugA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 05/15] staging: bcm2835-camera: Remove bulk_mutex as it is not
 required
Date: Thu, 10 May 2018 12:42:09 -0700
Message-Id: <20180510194220.30675-6-eric@anholt.net>
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

There is no requirement to serialise bulk transfers as that is all
done in VCHI, and if a second MMAL_MSG_TYPE_BUFFER_TO_HOST happened
before the VCHI_CALLBACK_BULK_RECEIVED, then the service_callback
thread is deadlocked.

Remove the bulk_mutex so that multiple receives can be scheduled at a
time.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../vc04_services/bcm2835-camera/mmal-vchiq.c | 48 +------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 037c68b83df9..d6950226551f 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -162,9 +162,6 @@ struct vchiq_mmal_instance {
 	/* ensure serialised access to service */
 	struct mutex vchiq_mutex;
 
-	/* ensure serialised access to bulk operations */
-	struct mutex bulk_mutex;
-
 	/* vmalloc page to receive scratch bulk xfers into */
 	void *bulk_scratch;
 
@@ -332,13 +329,6 @@ static int bulk_receive(struct vchiq_mmal_instance *instance,
 	unsigned long flags = 0;
 	int ret;
 
-	/* bulk mutex stops other bulk operations while we have a
-	 * receive in progress - released in callback
-	 */
-	ret = mutex_lock_interruptible(&instance->bulk_mutex);
-	if (ret != 0)
-		return ret;
-
 	rd_len = msg->u.buffer_from_host.buffer_header.length;
 
 	/* take buffer from queue */
@@ -357,8 +347,6 @@ static int bulk_receive(struct vchiq_mmal_instance *instance,
 		 * waiting bulk receive?
 		 */
 
-		mutex_unlock(&instance->bulk_mutex);
-
 		return -EINVAL;
 	}
 
@@ -399,11 +387,6 @@ static int bulk_receive(struct vchiq_mmal_instance *instance,
 
 	vchi_service_release(instance->handle);
 
-	if (ret != 0) {
-		/* callback will not be clearing the mutex */
-		mutex_unlock(&instance->bulk_mutex);
-	}
-
 	return ret;
 }
 
@@ -413,13 +396,6 @@ static int dummy_bulk_receive(struct vchiq_mmal_instance *instance,
 {
 	int ret;
 
-	/* bulk mutex stops other bulk operations while we have a
-	 * receive in progress - released in callback
-	 */
-	ret = mutex_lock_interruptible(&instance->bulk_mutex);
-	if (ret != 0)
-		return ret;
-
 	/* zero length indicates this was a dummy transfer */
 	msg_context->u.bulk.buffer_used = 0;
 
@@ -435,11 +411,6 @@ static int dummy_bulk_receive(struct vchiq_mmal_instance *instance,
 
 	vchi_service_release(instance->handle);
 
-	if (ret != 0) {
-		/* callback will not be clearing the mutex */
-		mutex_unlock(&instance->bulk_mutex);
-	}
-
 	return ret;
 }
 
@@ -494,18 +465,11 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 
 	pr_debug("instance:%p buffer:%p\n", instance->handle, buf);
 
-	/* bulk mutex stops other bulk operations while we
-	 * have a receive in progress
-	 */
-	if (mutex_lock_interruptible(&instance->bulk_mutex))
-		return -EINTR;
-
 	/* get context */
 	if (!buf->msg_context) {
 		pr_err("%s: msg_context not allocated, buf %p\n", __func__,
 		       buf);
-		ret = -EINVAL;
-		goto unlock;
+		return -EINVAL;
 	}
 	msg_context = buf->msg_context;
 
@@ -559,9 +523,6 @@ buffer_from_host(struct vchiq_mmal_instance *instance,
 
 	vchi_service_release(instance->handle);
 
-unlock:
-	mutex_unlock(&instance->bulk_mutex);
-
 	return ret;
 }
 
@@ -685,9 +646,6 @@ static void buffer_to_host_cb(struct vchiq_mmal_instance *instance,
 static void bulk_receive_cb(struct vchiq_mmal_instance *instance,
 			    struct mmal_msg_context *msg_context)
 {
-	/* bulk receive operation complete */
-	mutex_unlock(&msg_context->u.bulk.instance->bulk_mutex);
-
 	/* replace the buffer header */
 	port_buffer_from_host(msg_context->u.bulk.instance,
 			      msg_context->u.bulk.port);
@@ -703,9 +661,6 @@ static void bulk_abort_cb(struct vchiq_mmal_instance *instance,
 {
 	pr_err("%s: bulk ABORTED msg_context:%p\n", __func__, msg_context);
 
-	/* bulk receive operation complete */
-	mutex_unlock(&msg_context->u.bulk.instance->bulk_mutex);
-
 	/* replace the buffer header */
 	port_buffer_from_host(msg_context->u.bulk.instance,
 			      msg_context->u.bulk.port);
@@ -2042,7 +1997,6 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 		return -ENOMEM;
 
 	mutex_init(&instance->vchiq_mutex);
-	mutex_init(&instance->bulk_mutex);
 
 	instance->bulk_scratch = vmalloc(PAGE_SIZE);
 
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
