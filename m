Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-30389-1526056527-2-9344136033338785755
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526056526; b=BjZiHRwWEDK0+suq/GyuRRfV0I2F5ROhU2OpT0ffdYPgIJRXDj
    hz5ESdBNsHuvjXKX/OwHV42H+J8urZuIuzBUzbSU6f6sntBSFx6/B1j2zQAMALBq
    JqCzf7EnVSZQshmpbz3JXBb55MherUWV+xDymi0v5Kla4C0B06CKqTNBGjjcIlT9
    w/mNJblh6QOWWU54fnZQjPZRCnP9D/rSE3Vy2T0iw5WGujKpCJRni4BeTyRMofqP
    Ap50ksqnJrdGoLRk1zkbvGZ0wmt8M2Dn0jOexSLNPISTSTteyFmfx2/XTDd0V1z7
    8BlA1FGpziH4hJmMZASvThRAbR/hmJAUmM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526056526; bh=uRk1p
    yEM1owk6Bbzd3xV8F3gtaOcfMeKRYEm7wnZtoA=; b=ELdVAUQsUKEgtffCY5W0c
    g/mSSJxLbbKuU73rDaqzdVuBYNBKZbD4wItwqaX5xR0fASo9VpWP+UKSsZAFjmAN
    JU+AKxT3Znnnmj2MSgNedZYi1Qq+zOiVpteSvMFR3HlJdcwfhOnHNSze6LlOhg8s
    prYjgggCdJzl+cxvc1b5rIUjh/tMxWpS33JB+ruEy9rjwy9KA4zor2Mn5HJhiRRm
    omd6/gOAyRRcllbsN4z8kk/OIdiL6/+OnJul8ngiGcEU8guqAKQkIaBQj7PaNWke
    l75CqoSSEcMZ6AKm6zr+BIRDFILGUhNJZ2CTQK1UOoCR+iqna0YoMFKbWMd/i/JF
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
X-CM-Envelope: MS4wfDFBcEYJZAA6fyJuePDQWM2U5OujEIO/GUI4zpTqpkKvN9gBDYbvhuITSLOqd9kr2MKxN4o78IPXZ3XQmdm0XOqFCgoJ9wVrw5GfMMNNt2PBE4jS9Lil
    vrx4EvkHok3K6w4SIjap4wAeEQT40mTdGXJyJGtDbgQMY5IxZDk71KGzLeSixvey5++h935Ls+ecmc6XGMXatj218x2gUL8rTXkiR4pK1uf/V+1BrVfaWL1W
    DTuG9ldDWiJEenirjqsm9w==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=-VAfIpHNAAAA:8 a=DDOyTI_5AAAA:8
    a=kZUX5tHZYDj883ZmAdEA:9 a=CjuIK1q_8ugA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Eric Anholt <eric@anholt.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH v2] staging: bcm2835-camera: Replace open-coded idr with a
 struct idr.
Date: Fri, 11 May 2018 09:35:15 -0700
Message-Id: <20180511163515.29836-1-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
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
Cc: Eric Anholt <eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We just need some integer handles that can map back to our message
struct when we're handling a reply, which struct idr is perfect for.

v2: Fix error check to look at the right variable.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 .../vc04_services/bcm2835-camera/mmal-vchiq.c | 135 ++++--------------
 1 file changed, 31 insertions(+), 104 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 3a3b843fc122..f5b5ead6347c 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/vmalloc.h>
-#include <linux/btree.h>
 #include <asm/cacheflush.h>
 #include <media/videobuf2-vmalloc.h>
 
@@ -111,7 +110,11 @@ struct vchiq_mmal_instance;
 /* normal message context */
 struct mmal_msg_context {
 	struct vchiq_mmal_instance *instance;
-	u32 handle;
+
+	/* Index in the context_map idr so that we can find the
+	 * mmal_msg_context again when servicing the VCHI reply.
+	 */
+	int handle;
 
 	union {
 		struct {
@@ -149,13 +152,6 @@ struct mmal_msg_context {
 
 };
 
-struct vchiq_mmal_context_map {
-	/* ensure serialized access to the btree(contention should be low) */
-	struct mutex lock;
-	struct btree_head32 btree_head;
-	u32 last_handle;
-};
-
 struct vchiq_mmal_instance {
 	VCHI_SERVICE_HANDLE_T handle;
 
@@ -165,92 +161,19 @@ struct vchiq_mmal_instance {
 	/* vmalloc page to receive scratch bulk xfers into */
 	void *bulk_scratch;
 
-	/* mapping table between context handles and mmal_msg_contexts */
-	struct vchiq_mmal_context_map context_map;
+	struct idr context_map;
+	spinlock_t context_map_lock;
 
 	/* component to use next */
 	int component_idx;
 	struct vchiq_mmal_component component[VCHIQ_MMAL_MAX_COMPONENTS];
 };
 
-static int __must_check
-mmal_context_map_init(struct vchiq_mmal_context_map *context_map)
-{
-	mutex_init(&context_map->lock);
-	context_map->last_handle = 0;
-	return btree_init32(&context_map->btree_head);
-}
-
-static void mmal_context_map_destroy(struct vchiq_mmal_context_map *context_map)
-{
-	mutex_lock(&context_map->lock);
-	btree_destroy32(&context_map->btree_head);
-	mutex_unlock(&context_map->lock);
-}
-
-static u32
-mmal_context_map_create_handle(struct vchiq_mmal_context_map *context_map,
-			       struct mmal_msg_context *msg_context,
-			       gfp_t gfp)
-{
-	u32 handle;
-
-	mutex_lock(&context_map->lock);
-
-	while (1) {
-		/* just use a simple count for handles, but do not use 0 */
-		context_map->last_handle++;
-		if (!context_map->last_handle)
-			context_map->last_handle++;
-
-		handle = context_map->last_handle;
-
-		/* check if the handle is already in use */
-		if (!btree_lookup32(&context_map->btree_head, handle))
-			break;
-	}
-
-	if (btree_insert32(&context_map->btree_head, handle,
-			   msg_context, gfp)) {
-		/* probably out of memory */
-		mutex_unlock(&context_map->lock);
-		return 0;
-	}
-
-	mutex_unlock(&context_map->lock);
-	return handle;
-}
-
-static struct mmal_msg_context *
-mmal_context_map_lookup_handle(struct vchiq_mmal_context_map *context_map,
-			       u32 handle)
-{
-	struct mmal_msg_context *msg_context;
-
-	if (!handle)
-		return NULL;
-
-	mutex_lock(&context_map->lock);
-
-	msg_context = btree_lookup32(&context_map->btree_head, handle);
-
-	mutex_unlock(&context_map->lock);
-	return msg_context;
-}
-
-static void
-mmal_context_map_destroy_handle(struct vchiq_mmal_context_map *context_map,
-				u32 handle)
-{
-	mutex_lock(&context_map->lock);
-	btree_remove32(&context_map->btree_head, handle);
-	mutex_unlock(&context_map->lock);
-}
-
 static struct mmal_msg_context *
 get_msg_context(struct vchiq_mmal_instance *instance)
 {
 	struct mmal_msg_context *msg_context;
+	int handle;
 
 	/* todo: should this be allocated from a pool to avoid kzalloc */
 	msg_context = kzalloc(sizeof(*msg_context), GFP_KERNEL);
@@ -258,32 +181,40 @@ get_msg_context(struct vchiq_mmal_instance *instance)
 	if (!msg_context)
 		return ERR_PTR(-ENOMEM);
 
-	msg_context->instance = instance;
-	msg_context->handle =
-		mmal_context_map_create_handle(&instance->context_map,
-					       msg_context,
-					       GFP_KERNEL);
+	/* Create an ID that will be passed along with our message so
+	 * that when we service the VCHI reply, we can look up what
+	 * message is being replied to.
+	 */
+	spin_lock(&instance->context_map_lock);
+	handle = idr_alloc(&instance->context_map, msg_context,
+			   0, 0, GFP_KERNEL);
+	spin_unlock(&instance->context_map_lock);
 
-	if (!msg_context->handle) {
+	if (handle < 0) {
 		kfree(msg_context);
-		return ERR_PTR(-ENOMEM);
+		return ERR_PTR(handle);
 	}
 
+	msg_context->instance = instance;
+	msg_context->handle = handle;
+
 	return msg_context;
 }
 
 static struct mmal_msg_context *
-lookup_msg_context(struct vchiq_mmal_instance *instance, u32 handle)
+lookup_msg_context(struct vchiq_mmal_instance *instance, int handle)
 {
-	return mmal_context_map_lookup_handle(&instance->context_map,
-		handle);
+	return idr_find(&instance->context_map, handle);
 }
 
 static void
 release_msg_context(struct mmal_msg_context *msg_context)
 {
-	mmal_context_map_destroy_handle(&msg_context->instance->context_map,
-					msg_context->handle);
+	struct vchiq_mmal_instance *instance = msg_context->instance;
+
+	spin_lock(&instance->context_map_lock);
+	idr_remove(&instance->context_map, msg_context->handle);
+	spin_unlock(&instance->context_map_lock);
 	kfree(msg_context);
 }
 
@@ -1860,7 +1791,7 @@ int vchiq_mmal_finalise(struct vchiq_mmal_instance *instance)
 
 	vfree(instance->bulk_scratch);
 
-	mmal_context_map_destroy(&instance->context_map);
+	idr_destroy(&instance->context_map);
 
 	kfree(instance);
 
@@ -1922,12 +1853,8 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 
 	instance->bulk_scratch = vmalloc(PAGE_SIZE);
 
-	status = mmal_context_map_init(&instance->context_map);
-	if (status) {
-		pr_err("Failed to init context map (status=%d)\n", status);
-		kfree(instance);
-		return status;
-	}
+	spin_lock_init(&instance->context_map_lock);
+	idr_init_base(&instance->context_map, 1);
 
 	params.callback_param = instance;
 
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
