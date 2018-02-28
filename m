Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-678564-1519839469-2-1169411437774745347
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839468; b=jayhvev9E0vrWixm5cD0FO2qBiQ9klsNry+ycGEfgZ+LHKI
    NEtn7CXIFlOB19kzIDcGwEIwAfBPqVFM0X2S8hi2LDDG7ZoWxkh1A85QIHnYs5r3
    r72jlaDDe1aIXcRoeCcgCECns4HmMMTLbGJWcagYNqhoiutHtRQxOzP5T0WyfJR1
    wcuMZGHBpEjFIXj38hPAdn20AO0OMkbIvfY+aotLkjbQ17in13oZzNXXLgz0bYMC
    Z9X31Btiteowpiw9nE0ZOyYlOC000mamsETnSD3+YfxLOOZPbTqkfz1Pj7JcWM4w
    gfsfqj5YRC7JCJYgDAJYbmFQQG4LROLVRk/lFzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839468; bh=+VmN0zJr49jBJojtZZp
    w9XQYNeuB9zV97bejMOi0mvc=; b=B0mqd2a7bVEPllr8T7m+BHnJ47iv1ok6hyE
    uI3mmaQi4P7/bDSZuVYnAZUffclFQeNV2RhPeaoagIAMKQ95MQbNAoBBPjdutNkT
    lB4Q9uanVEmBcG4+zVngBCSL9C/b1k+PxeRefUDyWUyuiBwc1JLblGBOS4agA9io
    CST16vQv3IQDzvmSpr7TcPJxHrVI74uOLmcpUGMxMMW9zhmJuPJJrqcSHQWC/ivl
    2Rw6jOw1JhdhrjWnF9ifWZdOsFged0mE6nSKrKV2gV4A6+IgvNf7YlHdT7fXv7Xk
    5CmsglrdON+bkmSM0pOYLiVxkESMIqkJnTgRBB68MOlo8QaBW1w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeB1Rg1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:36:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33185 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932540AbeB1PWO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <m.chehab@samsung.com>,
        "Hans Verkuil" <hans.verkuil@cisco.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.234714968@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 122/140] [media] v4l2-compat-ioctl32: fix sparse warnings
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 8ae632b11775254c5e555ee8c42b7d19baeb1473 upstream.

A lot of these warnings are caused by the fact that we don't generally use
__user in videodev2.h. Normally the video_usercopy function will copy anything
pointed to by pointers into kernel space, so having __user in the struct will only
cause lots of warnings in the drivers. But the flip side of that is that you
need to add __force casts here.

drivers/media/v4l2-core/v4l2-compat-ioctl32.c:337:26: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:337:30: warning: incorrect type in argument 2 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:338:31: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:338:49: warning: incorrect type in argument 2 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:343:21: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:346:21: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:349:35: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:349:46: warning: incorrect type in argument 2 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:352:35: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:352:54: warning: incorrect type in argument 2 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:363:26: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:363:32: warning: incorrect type in argument 2 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:364:31: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:364:51: warning: incorrect type in argument 2 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:371:35: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:371:56: warning: incorrect type in argument 2 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:376:35: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:376:48: warning: incorrect type in argument 2 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:430:30: warning: incorrect type in assignment (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:433:48: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:433:56: warning: incorrect type in argument 2 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:501:24: warning: incorrect type in assignment (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:507:48: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:507:56: warning: incorrect type in argument 2 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:565:18: warning: incorrect type in assignment (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:670:22: warning: incorrect type in assignment (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:680:29: warning: incorrect type in assignment (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:692:55: warning: incorrect type in initializer (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:773:18: warning: incorrect type in assignment (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:786:30: warning: incorrect type in argument 1 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:786:44: warning: incorrect type in argument 2 (different address spaces)
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:674:37: warning: dereference of noderef expression
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:718:37: warning: dereference of noderef expression

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
[bwh: Backported to 3.2:
 - Drop changes in {get,put}_v4l2_edid32()
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/media/video/v4l2-compat-ioctl32.c
+++ b/drivers/media/video/v4l2-compat-ioctl32.c
@@ -334,7 +334,7 @@ struct v4l2_buffer32 {
 	__u32			reserved;
 };
 
-static int get_v4l2_plane32(struct v4l2_plane *up, struct v4l2_plane32 *up32,
+static int get_v4l2_plane32(struct v4l2_plane __user *up, struct v4l2_plane32 __user *up32,
 				enum v4l2_memory memory)
 {
 	void __user *up_pln;
@@ -360,7 +360,7 @@ static int get_v4l2_plane32(struct v4l2_
 	return 0;
 }
 
-static int put_v4l2_plane32(struct v4l2_plane *up, struct v4l2_plane32 *up32,
+static int put_v4l2_plane32(struct v4l2_plane __user *up, struct v4l2_plane32 __user *up32,
 				enum v4l2_memory memory)
 {
 	if (copy_in_user(up32, up, 2 * sizeof(__u32)) ||
@@ -426,7 +426,7 @@ static int get_v4l2_buffer32(struct v4l2
 		 * by passing a very big num_planes value */
 		uplane = compat_alloc_user_space(num_planes *
 						sizeof(struct v4l2_plane));
-		kp->m.planes = uplane;
+		kp->m.planes = (__force struct v4l2_plane *)uplane;
 
 		while (--num_planes >= 0) {
 			ret = get_v4l2_plane32(uplane, uplane32, kp->memory);
@@ -493,7 +493,7 @@ static int put_v4l2_buffer32(struct v4l2
 		if (num_planes == 0)
 			return 0;
 
-		uplane = kp->m.planes;
+		uplane = (__force struct v4l2_plane __user *)kp->m.planes;
 		if (get_user(p, &up->m.planes))
 			return -EFAULT;
 		uplane32 = compat_ptr(p);
@@ -543,7 +543,7 @@ static int get_v4l2_framebuffer32(struct
 		get_user(kp->capability, &up->capability) ||
 		get_user(kp->flags, &up->flags))
 			return -EFAULT;
-	kp->base = compat_ptr(tmp);
+	kp->base = (__force void *)compat_ptr(tmp);
 	get_v4l2_pix_format(&kp->fmt, &up->fmt);
 	return 0;
 }
@@ -649,11 +649,15 @@ static int get_v4l2_ext_controls32(struc
 			n * sizeof(struct v4l2_ext_control32)))
 		return -EFAULT;
 	kcontrols = compat_alloc_user_space(n * sizeof(struct v4l2_ext_control));
-	kp->controls = kcontrols;
+	kp->controls = (__force struct v4l2_ext_control *)kcontrols;
 	while (--n >= 0) {
+		u32 id;
+
 		if (copy_in_user(kcontrols, ucontrols, sizeof(*ucontrols)))
 			return -EFAULT;
-		if (ctrl_is_pointer(kcontrols->id)) {
+		if (get_user(id, &kcontrols->id))
+			return -EFAULT;
+		if (ctrl_is_pointer(id)) {
 			void __user *s;
 
 			if (get_user(p, &ucontrols->string))
@@ -671,7 +675,8 @@ static int get_v4l2_ext_controls32(struc
 static int put_v4l2_ext_controls32(struct v4l2_ext_controls *kp, struct v4l2_ext_controls32 __user *up)
 {
 	struct v4l2_ext_control32 __user *ucontrols;
-	struct v4l2_ext_control __user *kcontrols = kp->controls;
+	struct v4l2_ext_control __user *kcontrols =
+		(__force struct v4l2_ext_control __user *)kp->controls;
 	int n = kp->count;
 	compat_caddr_t p;
 
@@ -693,11 +698,14 @@ static int put_v4l2_ext_controls32(struc
 
 	while (--n >= 0) {
 		unsigned size = sizeof(*ucontrols);
+		u32 id;
 
+		if (get_user(id, &kcontrols->id))
+			return -EFAULT;
 		/* Do not modify the pointer when copying a pointer control.
 		   The contents of the pointer was changed, not the pointer
 		   itself. */
-		if (ctrl_is_pointer(kcontrols->id))
+		if (ctrl_is_pointer(id))
 			size -= sizeof(ucontrols->value64);
 		if (copy_in_user(ucontrols, kcontrols, size))
 			return -EFAULT;
