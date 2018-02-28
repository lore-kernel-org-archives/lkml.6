Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835978-2-9044402708217494175
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835977; b=F2+8kaapMwwPVt3nlA4AzOaJwrwpxevqXKrMXbvMp/0M+/C
    l4k4clExxSL/lIfm+XOU6evwHObhK/IqXldjJwNqkgr0+gxs222cYx5lJ3QT77qo
    RyPcn1grPMkkFKBlvAPGFanidChpwMA0xk25kZ0+UjOyu95RXE+HkOFCGNn46bBA
    Zj1I8i0dY+7gaIfuTxyBk1bilsiUtFy0VOMVOB33uDTXOAVZJ9BnxylY9bXRm10R
    6gw5v5YdLoACZhcZAnOg6mqJWutW9D7Mq0Z98ncO3qucEkGhnF4jot4naGhGjHOV
    RlQxm8m6n8V54RpHAovlE55bd/GHHzHxEoGeodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835977; bh=CEhQRX9B5jwdKhWFRPM
    sCDHXRl325mSgud8mGZDm47M=; b=enxaM2xUFxO/abtDq3SiXGiHa357wVAg8X1
    WC//7khMK3DJ7uwbtvwwdIS6ZKctr6T1/f2UmYH6sB0bpMit9MfRcGGGDHyJ8ZRz
    n3COjAJrN0Uamz1yjCaQYRGDfAHhnaTJN8ykPHs+tsX9WWPQNln8mS8ANnTq3f9q
    qzF+1kbNB/yhDHu6sAbbCYfJVY8vUI7UKo8z3C1fUyFzb5DTqBTDcEc8UpZ3S/Z5
    O7q+Kzp6B7KON1GYYT/ml55qEnHDhxhGsFV57pPY1jypC43NkKmS5R3WBn6Ud5oM
    8lO/ZZx+ZjiI4G56Qh5Uvf3Q5KGwC4SyI2D54vVQzbRstizZ+0g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbeB1QjQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:39:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34798 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932287AbeB1QED (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:03 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.258043780@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 245/254] media: v4l2-compat-ioctl32.c: avoid
 sizeof(type)
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 333b1e9f96ce05f7498b581509bb30cde03018bf upstream.

Instead of doing sizeof(struct foo) use sizeof(*up). There even were
cases where 4 * sizeof(__u32) was used instead of sizeof(kp->reserved),
which is very dangerous when the size of the reserved array changes.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
[bwh: Rebased on top of some earlier fixes]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -47,7 +47,7 @@ struct v4l2_window32 {
 
 static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
 {
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_window32)) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
 	    get_user(kp->field, &up->field) ||
 	    get_user(kp->chromakey, &up->chromakey) ||
@@ -64,7 +64,7 @@ static int get_v4l2_window32(struct v4l2
 		if (get_user(p, &up->clips))
 			return -EFAULT;
 		uclips = compat_ptr(p);
-		kclips = compat_alloc_user_space(n * sizeof(struct v4l2_clip));
+		kclips = compat_alloc_user_space(n * sizeof(*kclips));
 		kp->clips = kclips;
 		while (--n >= 0) {
 			if (copy_in_user(&kclips->c, &uclips->c, sizeof(uclips->c)))
@@ -152,14 +152,14 @@ static int __get_v4l2_format32(struct v4
 
 static int get_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 __user *up)
 {
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_format32)))
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)))
 		return -EFAULT;
 	return __get_v4l2_format32(kp, up);
 }
 
 static int get_v4l2_create32(struct v4l2_create_buffers *kp, struct v4l2_create_buffers32 __user *up)
 {
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_create_buffers32)) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    copy_from_user(kp, up, offsetof(struct v4l2_create_buffers32, format)))
 		return -EFAULT;
 	return __get_v4l2_format32(&kp->format, &up->format);
@@ -199,14 +199,14 @@ static int __put_v4l2_format32(struct v4
 
 static int put_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_format32)))
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)))
 		return -EFAULT;
 	return __put_v4l2_format32(kp, up);
 }
 
 static int put_v4l2_create32(struct v4l2_create_buffers *kp, struct v4l2_create_buffers32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_create_buffers32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format)) ||
 	    copy_to_user(up->reserved, kp->reserved, sizeof(kp->reserved)))
 		return -EFAULT;
@@ -225,7 +225,7 @@ struct v4l2_standard32 {
 static int get_v4l2_standard32(struct v4l2_standard *kp, struct v4l2_standard32 __user *up)
 {
 	/* other fields are not set by the user, nor used by the driver */
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_standard32)) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    get_user(kp->index, &up->index))
 		return -EFAULT;
 	return 0;
@@ -233,13 +233,13 @@ static int get_v4l2_standard32(struct v4
 
 static int put_v4l2_standard32(struct v4l2_standard *kp, struct v4l2_standard32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_standard32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    put_user(kp->index, &up->index) ||
 	    put_user(kp->id, &up->id) ||
-	    copy_to_user(up->name, kp->name, 24) ||
+	    copy_to_user(up->name, kp->name, sizeof(up->name)) ||
 	    copy_to_user(&up->frameperiod, &kp->frameperiod, sizeof(kp->frameperiod)) ||
 	    put_user(kp->framelines, &up->framelines) ||
-	    copy_to_user(up->reserved, kp->reserved, 4 * sizeof(__u32)))
+	    copy_to_user(up->reserved, kp->reserved, sizeof(kp->reserved)))
 		return -EFAULT;
 	return 0;
 }
@@ -287,7 +287,7 @@ static int get_v4l2_plane32(struct v4l2_
 
 	if (copy_in_user(up, up32, 2 * sizeof(__u32)) ||
 	    copy_in_user(&up->data_offset, &up32->data_offset,
-			 sizeof(__u32)))
+			 sizeof(up->data_offset)))
 		return -EFAULT;
 
 	if (memory == V4L2_MEMORY_USERPTR) {
@@ -297,11 +297,11 @@ static int get_v4l2_plane32(struct v4l2_
 		if (put_user((unsigned long)up_pln, &up->m.userptr))
 			return -EFAULT;
 	} else if (memory == V4L2_MEMORY_DMABUF) {
-		if (copy_in_user(&up->m.fd, &up32->m.fd, sizeof(int)))
+		if (copy_in_user(&up->m.fd, &up32->m.fd, sizeof(up32->m.fd)))
 			return -EFAULT;
 	} else {
 		if (copy_in_user(&up->m.mem_offset, &up32->m.mem_offset,
-				 sizeof(__u32)))
+				 sizeof(up32->m.mem_offset)))
 			return -EFAULT;
 	}
 
@@ -313,19 +313,19 @@ static int put_v4l2_plane32(struct v4l2_
 {
 	if (copy_in_user(up32, up, 2 * sizeof(__u32)) ||
 	    copy_in_user(&up32->data_offset, &up->data_offset,
-			 sizeof(__u32)))
+			 sizeof(up->data_offset)))
 		return -EFAULT;
 
 	/* For MMAP, driver might've set up the offset, so copy it back.
 	 * USERPTR stays the same (was userspace-provided), so no copying. */
 	if (memory == V4L2_MEMORY_MMAP)
 		if (copy_in_user(&up32->m.mem_offset, &up->m.mem_offset,
-				 sizeof(__u32)))
+				 sizeof(up->m.mem_offset)))
 			return -EFAULT;
 	/* For DMABUF, driver might've set up the fd, so copy it back. */
 	if (memory == V4L2_MEMORY_DMABUF)
 		if (copy_in_user(&up32->m.fd, &up->m.fd,
-				 sizeof(int)))
+				 sizeof(up->m.fd)))
 			return -EFAULT;
 
 	return 0;
@@ -339,7 +339,7 @@ static int get_v4l2_buffer32(struct v4l2
 	int num_planes;
 	int ret;
 
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_buffer32)) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    get_user(kp->index, &up->index) ||
 	    get_user(kp->type, &up->type) ||
 	    get_user(kp->flags, &up->flags) ||
@@ -351,8 +351,7 @@ static int get_v4l2_buffer32(struct v4l2
 		if (get_user(kp->bytesused, &up->bytesused) ||
 		    get_user(kp->field, &up->field) ||
 		    get_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
-		    get_user(kp->timestamp.tv_usec,
-			     &up->timestamp.tv_usec))
+		    get_user(kp->timestamp.tv_usec, &up->timestamp.tv_usec))
 			return -EFAULT;
 
 	if (V4L2_TYPE_IS_MULTIPLANAR(kp->type)) {
@@ -369,13 +368,13 @@ static int get_v4l2_buffer32(struct v4l2
 
 		uplane32 = compat_ptr(p);
 		if (!access_ok(VERIFY_READ, uplane32,
-			       num_planes * sizeof(struct v4l2_plane32)))
+			       num_planes * sizeof(*uplane32)))
 			return -EFAULT;
 
 		/* We don't really care if userspace decides to kill itself
 		 * by passing a very big num_planes value */
 		uplane = compat_alloc_user_space(num_planes *
-						 sizeof(struct v4l2_plane));
+						 sizeof(*uplane));
 		kp->m.planes = (__force struct v4l2_plane *)uplane;
 
 		while (--num_planes >= 0) {
@@ -423,7 +422,7 @@ static int put_v4l2_buffer32(struct v4l2
 	int num_planes;
 	int ret;
 
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_buffer32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    put_user(kp->index, &up->index) ||
 	    put_user(kp->type, &up->type) ||
 	    put_user(kp->flags, &up->flags) ||
@@ -434,7 +433,7 @@ static int put_v4l2_buffer32(struct v4l2
 	    put_user(kp->field, &up->field) ||
 	    put_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
 	    put_user(kp->timestamp.tv_usec, &up->timestamp.tv_usec) ||
-	    copy_to_user(&up->timecode, &kp->timecode, sizeof(struct v4l2_timecode)) ||
+	    copy_to_user(&up->timecode, &kp->timecode, sizeof(kp->timecode)) ||
 	    put_user(kp->sequence, &up->sequence) ||
 	    put_user(kp->reserved2, &up->reserved2) ||
 	    put_user(kp->reserved, &up->reserved) ||
@@ -493,7 +492,7 @@ static int get_v4l2_framebuffer32(struct
 {
 	u32 tmp;
 
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_framebuffer32)) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    get_user(tmp, &up->base) ||
 	    get_user(kp->capability, &up->capability) ||
 	    get_user(kp->flags, &up->flags) ||
@@ -507,7 +506,7 @@ static int put_v4l2_framebuffer32(struct
 {
 	u32 tmp = (u32)((unsigned long)kp->base);
 
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_framebuffer32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    put_user(tmp, &up->base) ||
 	    put_user(kp->capability, &up->capability) ||
 	    put_user(kp->flags, &up->flags) ||
@@ -532,14 +531,14 @@ struct v4l2_input32 {
    Otherwise it is identical to the 32-bit version. */
 static inline int get_v4l2_input32(struct v4l2_input *kp, struct v4l2_input32 __user *up)
 {
-	if (copy_from_user(kp, up, sizeof(struct v4l2_input32)))
+	if (copy_from_user(kp, up, sizeof(*up)))
 		return -EFAULT;
 	return 0;
 }
 
 static inline int put_v4l2_input32(struct v4l2_input *kp, struct v4l2_input32 __user *up)
 {
-	if (copy_to_user(up, kp, sizeof(struct v4l2_input32)))
+	if (copy_to_user(up, kp, sizeof(*up)))
 		return -EFAULT;
 	return 0;
 }
@@ -587,7 +586,7 @@ static int get_v4l2_ext_controls32(struc
 	int n;
 	compat_caddr_t p;
 
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_ext_controls32)) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    get_user(kp->ctrl_class, &up->ctrl_class) ||
 	    get_user(kp->count, &up->count) ||
 	    get_user(kp->error_idx, &up->error_idx) ||
@@ -601,10 +600,9 @@ static int get_v4l2_ext_controls32(struc
 	if (get_user(p, &up->controls))
 		return -EFAULT;
 	ucontrols = compat_ptr(p);
-	if (!access_ok(VERIFY_READ, ucontrols,
-		       n * sizeof(struct v4l2_ext_control32)))
+	if (!access_ok(VERIFY_READ, ucontrols, n * sizeof(*ucontrols)))
 		return -EFAULT;
-	kcontrols = compat_alloc_user_space(n * sizeof(struct v4l2_ext_control));
+	kcontrols = compat_alloc_user_space(n * sizeof(*kcontrols));
 	kp->controls = (__force struct v4l2_ext_control *)kcontrols;
 	while (--n >= 0) {
 		u32 id;
@@ -636,7 +634,7 @@ static int put_v4l2_ext_controls32(struc
 	int n = kp->count;
 	compat_caddr_t p;
 
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_ext_controls32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    put_user(kp->ctrl_class, &up->ctrl_class) ||
 	    put_user(kp->count, &up->count) ||
 	    put_user(kp->error_idx, &up->error_idx) ||
@@ -648,8 +646,7 @@ static int put_v4l2_ext_controls32(struc
 	if (get_user(p, &up->controls))
 		return -EFAULT;
 	ucontrols = compat_ptr(p);
-	if (!access_ok(VERIFY_WRITE, ucontrols,
-		       n * sizeof(struct v4l2_ext_control32)))
+	if (!access_ok(VERIFY_WRITE, ucontrols, n * sizeof(*ucontrols)))
 		return -EFAULT;
 
 	while (--n >= 0) {
@@ -686,7 +683,7 @@ struct v4l2_event32 {
 
 static int put_v4l2_event32(struct v4l2_event *kp, struct v4l2_event32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_event32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    put_user(kp->type, &up->type) ||
 	    copy_to_user(&up->u, &kp->u, sizeof(kp->u)) ||
 	    put_user(kp->pending, &up->pending) ||
@@ -694,7 +691,7 @@ static int put_v4l2_event32(struct v4l2_
 	    put_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
 	    put_user(kp->timestamp.tv_nsec, &up->timestamp.tv_nsec) ||
 	    put_user(kp->id, &up->id) ||
-	    copy_to_user(up->reserved, kp->reserved, 8 * sizeof(__u32)))
+	    copy_to_user(up->reserved, kp->reserved, sizeof(kp->reserved)))
 		return -EFAULT;
 	return 0;
 }
@@ -711,7 +708,7 @@ static int get_v4l2_edid32(struct v4l2_e
 {
 	u32 tmp;
 
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_edid32)) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    get_user(kp->pad, &up->pad) ||
 	    get_user(kp->start_block, &up->start_block) ||
 	    get_user(kp->blocks, &up->blocks) ||
@@ -726,7 +723,7 @@ static int put_v4l2_edid32(struct v4l2_e
 {
 	u32 tmp = (u32)((unsigned long)kp->edid);
 
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_edid32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    put_user(kp->pad, &up->pad) ||
 	    put_user(kp->start_block, &up->start_block) ||
 	    put_user(kp->blocks, &up->blocks) ||
