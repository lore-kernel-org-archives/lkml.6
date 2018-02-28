Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835721-2-14378809725417580084
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
    t=1519835720; b=kRsFUOhI4onyln+le/Tu00JbGDtWAcscVdiOAtY7d+1Snev
    ouyIWbf0b08obFMN6I0c33fjcb6qq+ZxWmaCFsD+08CUXdUSutOGJEVjgTZU8J0G
    LyKAU/3dI78mMGHkdEcLSU8LnFA9bQjUuqVhU+mc1rweIvVSAJwI2rOMyDUKRiZd
    jAwIHkNKOPjYCg6kSTcv32X/cQ06Yxd1sWjN8Ai9TLTGNaP1ZXTGBs6eXlFGTcNZ
    604XlqS700F+yxplRMjmHkj5q6089IC08wSvCBN56Ct4ke6RlSnIx4hxd1UzO7VA
    oerx0IqVllDWKQOHEiXE4kR24kT7OagIS6+PKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835720; bh=uJgmslzfLUptuMf7uk8
    Y5GMCLtdsf9goq1spyTjwIew=; b=FnbGc81ik9biwp7bfYhRaKP078v4XdWY/Dd
    wvNdveZ0sbqHvfwQiRNLXxWk2DrfeD9iXRompzPJA/idHKOEti0bKnA9czNI/P6Z
    iMRKz6FqbsAvTYqorNj08ntt+qPUhQu62/mcLlMirLFsKw0ejJgWPECz71MH/WOO
    siMBXAfZqv5o0Hu62gAlhfxKNkQvbsavfY2IrA2jU8THgQN7oUbhIdxHRy7NadBA
    f63AgCYCaU2COF8cN9XDxyIbQ0Xb3boOSn5qi9JS+e6ngVSk4S5WlzEFR2Ee7oTv
    m5gnTW2V3R8D2P8D5TxfX9XQX3DXYnPANd/o2uaNWSSs/PPfzYw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934646AbeB1QOB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:14:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35079 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932383AbeB1QN4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:13:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        "Hans Verkuil" <hans.verkuil@cisco.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.868507428@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 243/254] media: v4l2-compat-ioctl32.c: fix the
 indentation
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

commit b7b957d429f601d6d1942122b339474f31191d75 upstream.

The indentation of this source is all over the place. Fix this.
This patch only changes whitespace.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
[bwh: Rebased on top of some earlier fixes]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -48,11 +48,11 @@ struct v4l2_window32 {
 static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
 {
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_window32)) ||
-		copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
-		get_user(kp->field, &up->field) ||
-		get_user(kp->chromakey, &up->chromakey) ||
-		get_user(kp->clipcount, &up->clipcount))
-			return -EFAULT;
+	    copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
+	    get_user(kp->field, &up->field) ||
+	    get_user(kp->chromakey, &up->chromakey) ||
+	    get_user(kp->clipcount, &up->clipcount))
+		return -EFAULT;
 	if (kp->clipcount > 2048)
 		return -EINVAL;
 	if (kp->clipcount) {
@@ -82,10 +82,10 @@ static int get_v4l2_window32(struct v4l2
 static int put_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
 {
 	if (copy_to_user(&up->w, &kp->w, sizeof(kp->w)) ||
-		put_user(kp->field, &up->field) ||
-		put_user(kp->chromakey, &up->chromakey) ||
-		put_user(kp->clipcount, &up->clipcount))
-			return -EFAULT;
+	    put_user(kp->field, &up->field) ||
+	    put_user(kp->chromakey, &up->chromakey) ||
+	    put_user(kp->clipcount, &up->clipcount))
+		return -EFAULT;
 	return 0;
 }
 
@@ -97,7 +97,7 @@ static inline int get_v4l2_pix_format(st
 }
 
 static inline int get_v4l2_pix_format_mplane(struct v4l2_pix_format_mplane *kp,
-				struct v4l2_pix_format_mplane __user *up)
+					     struct v4l2_pix_format_mplane __user *up)
 {
 	if (copy_from_user(kp, up, sizeof(struct v4l2_pix_format_mplane)))
 		return -EFAULT;
@@ -112,7 +112,7 @@ static inline int put_v4l2_pix_format(st
 }
 
 static inline int put_v4l2_pix_format_mplane(struct v4l2_pix_format_mplane *kp,
-				struct v4l2_pix_format_mplane __user *up)
+					     struct v4l2_pix_format_mplane __user *up)
 {
 	if (copy_to_user(up, kp, sizeof(struct v4l2_pix_format_mplane)))
 		return -EFAULT;
@@ -200,7 +200,7 @@ static int __get_v4l2_format32(struct v4
 		return get_v4l2_sliced_vbi_format(&kp->fmt.sliced, &up->fmt.sliced);
 	default:
 		printk(KERN_INFO "compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-								kp->type);
+		       kp->type);
 		return -EINVAL;
 	}
 }
@@ -244,7 +244,7 @@ static int __put_v4l2_format32(struct v4
 		return put_v4l2_sliced_vbi_format(&kp->fmt.sliced, &up->fmt.sliced);
 	default:
 		printk(KERN_INFO "compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-								kp->type);
+		       kp->type);
 		return -EINVAL;
 	}
 }
@@ -278,7 +278,7 @@ static int get_v4l2_standard32(struct v4
 {
 	/* other fields are not set by the user, nor used by the driver */
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_standard32)) ||
-		get_user(kp->index, &up->index))
+	    get_user(kp->index, &up->index))
 		return -EFAULT;
 	return 0;
 }
@@ -286,13 +286,13 @@ static int get_v4l2_standard32(struct v4
 static int put_v4l2_standard32(struct v4l2_standard *kp, struct v4l2_standard32 __user *up)
 {
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_standard32)) ||
-		put_user(kp->index, &up->index) ||
-		put_user(kp->id, &up->id) ||
-		copy_to_user(up->name, kp->name, 24) ||
-		copy_to_user(&up->frameperiod, &kp->frameperiod, sizeof(kp->frameperiod)) ||
-		put_user(kp->framelines, &up->framelines) ||
-		copy_to_user(up->reserved, kp->reserved, 4 * sizeof(__u32)))
-			return -EFAULT;
+	    put_user(kp->index, &up->index) ||
+	    put_user(kp->id, &up->id) ||
+	    copy_to_user(up->name, kp->name, 24) ||
+	    copy_to_user(&up->frameperiod, &kp->frameperiod, sizeof(kp->frameperiod)) ||
+	    put_user(kp->framelines, &up->framelines) ||
+	    copy_to_user(up->reserved, kp->reserved, 4 * sizeof(__u32)))
+		return -EFAULT;
 	return 0;
 }
 
@@ -332,14 +332,14 @@ struct v4l2_buffer32 {
 };
 
 static int get_v4l2_plane32(struct v4l2_plane __user *up, struct v4l2_plane32 __user *up32,
-				enum v4l2_memory memory)
+			    enum v4l2_memory memory)
 {
 	void __user *up_pln;
 	compat_long_t p;
 
 	if (copy_in_user(up, up32, 2 * sizeof(__u32)) ||
-		copy_in_user(&up->data_offset, &up32->data_offset,
-				sizeof(__u32)))
+	    copy_in_user(&up->data_offset, &up32->data_offset,
+			 sizeof(__u32)))
 		return -EFAULT;
 
 	if (memory == V4L2_MEMORY_USERPTR) {
@@ -353,7 +353,7 @@ static int get_v4l2_plane32(struct v4l2_
 			return -EFAULT;
 	} else {
 		if (copy_in_user(&up->m.mem_offset, &up32->m.mem_offset,
-					sizeof(__u32)))
+				 sizeof(__u32)))
 			return -EFAULT;
 	}
 
@@ -361,23 +361,23 @@ static int get_v4l2_plane32(struct v4l2_
 }
 
 static int put_v4l2_plane32(struct v4l2_plane __user *up, struct v4l2_plane32 __user *up32,
-				enum v4l2_memory memory)
+			    enum v4l2_memory memory)
 {
 	if (copy_in_user(up32, up, 2 * sizeof(__u32)) ||
-		copy_in_user(&up32->data_offset, &up->data_offset,
-				sizeof(__u32)))
+	    copy_in_user(&up32->data_offset, &up->data_offset,
+			 sizeof(__u32)))
 		return -EFAULT;
 
 	/* For MMAP, driver might've set up the offset, so copy it back.
 	 * USERPTR stays the same (was userspace-provided), so no copying. */
 	if (memory == V4L2_MEMORY_MMAP)
 		if (copy_in_user(&up32->m.mem_offset, &up->m.mem_offset,
-					sizeof(__u32)))
+				 sizeof(__u32)))
 			return -EFAULT;
 	/* For DMABUF, driver might've set up the fd, so copy it back. */
 	if (memory == V4L2_MEMORY_DMABUF)
 		if (copy_in_user(&up32->m.fd, &up->m.fd,
-					sizeof(int)))
+				 sizeof(int)))
 			return -EFAULT;
 
 	return 0;
@@ -392,19 +392,19 @@ static int get_v4l2_buffer32(struct v4l2
 	int ret;
 
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_buffer32)) ||
-		get_user(kp->index, &up->index) ||
-		get_user(kp->type, &up->type) ||
-		get_user(kp->flags, &up->flags) ||
-		get_user(kp->memory, &up->memory) ||
-		get_user(kp->length, &up->length))
-			return -EFAULT;
+	    get_user(kp->index, &up->index) ||
+	    get_user(kp->type, &up->type) ||
+	    get_user(kp->flags, &up->flags) ||
+	    get_user(kp->memory, &up->memory) ||
+	    get_user(kp->length, &up->length))
+		return -EFAULT;
 
 	if (V4L2_TYPE_IS_OUTPUT(kp->type))
 		if (get_user(kp->bytesused, &up->bytesused) ||
-			get_user(kp->field, &up->field) ||
-			get_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
-			get_user(kp->timestamp.tv_usec,
-					&up->timestamp.tv_usec))
+		    get_user(kp->field, &up->field) ||
+		    get_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
+		    get_user(kp->timestamp.tv_usec,
+			     &up->timestamp.tv_usec))
 			return -EFAULT;
 
 	if (V4L2_TYPE_IS_MULTIPLANAR(kp->type)) {
@@ -421,13 +421,13 @@ static int get_v4l2_buffer32(struct v4l2
 
 		uplane32 = compat_ptr(p);
 		if (!access_ok(VERIFY_READ, uplane32,
-				num_planes * sizeof(struct v4l2_plane32)))
+			       num_planes * sizeof(struct v4l2_plane32)))
 			return -EFAULT;
 
 		/* We don't really care if userspace decides to kill itself
 		 * by passing a very big num_planes value */
 		uplane = compat_alloc_user_space(num_planes *
-						sizeof(struct v4l2_plane));
+						 sizeof(struct v4l2_plane));
 		kp->m.planes = (__force struct v4l2_plane *)uplane;
 
 		while (--num_planes >= 0) {
@@ -445,12 +445,12 @@ static int get_v4l2_buffer32(struct v4l2
 			break;
 		case V4L2_MEMORY_USERPTR:
 			{
-			compat_long_t tmp;
+				compat_long_t tmp;
 
-			if (get_user(tmp, &up->m.userptr))
-				return -EFAULT;
+				if (get_user(tmp, &up->m.userptr))
+					return -EFAULT;
 
-			kp->m.userptr = (unsigned long)compat_ptr(tmp);
+				kp->m.userptr = (unsigned long)compat_ptr(tmp);
 			}
 			break;
 		case V4L2_MEMORY_OVERLAY:
@@ -476,22 +476,22 @@ static int put_v4l2_buffer32(struct v4l2
 	int ret;
 
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_buffer32)) ||
-		put_user(kp->index, &up->index) ||
-		put_user(kp->type, &up->type) ||
-		put_user(kp->flags, &up->flags) ||
-		put_user(kp->memory, &up->memory))
-			return -EFAULT;
+	    put_user(kp->index, &up->index) ||
+	    put_user(kp->type, &up->type) ||
+	    put_user(kp->flags, &up->flags) ||
+	    put_user(kp->memory, &up->memory))
+		return -EFAULT;
 
 	if (put_user(kp->bytesused, &up->bytesused) ||
-		put_user(kp->field, &up->field) ||
-		put_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
-		put_user(kp->timestamp.tv_usec, &up->timestamp.tv_usec) ||
-		copy_to_user(&up->timecode, &kp->timecode, sizeof(struct v4l2_timecode)) ||
-		put_user(kp->sequence, &up->sequence) ||
-		put_user(kp->reserved2, &up->reserved2) ||
-		put_user(kp->reserved, &up->reserved) ||
-		put_user(kp->length, &up->length))
-			return -EFAULT;
+	    put_user(kp->field, &up->field) ||
+	    put_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
+	    put_user(kp->timestamp.tv_usec, &up->timestamp.tv_usec) ||
+	    copy_to_user(&up->timecode, &kp->timecode, sizeof(struct v4l2_timecode)) ||
+	    put_user(kp->sequence, &up->sequence) ||
+	    put_user(kp->reserved2, &up->reserved2) ||
+	    put_user(kp->reserved, &up->reserved) ||
+	    put_user(kp->length, &up->length))
+		return -EFAULT;
 
 	if (V4L2_TYPE_IS_MULTIPLANAR(kp->type)) {
 		num_planes = kp->length;
@@ -546,10 +546,10 @@ static int get_v4l2_framebuffer32(struct
 	u32 tmp;
 
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_framebuffer32)) ||
-		get_user(tmp, &up->base) ||
-		get_user(kp->capability, &up->capability) ||
-		get_user(kp->flags, &up->flags))
-			return -EFAULT;
+	    get_user(tmp, &up->base) ||
+	    get_user(kp->capability, &up->capability) ||
+	    get_user(kp->flags, &up->flags))
+		return -EFAULT;
 	kp->base = (__force void *)compat_ptr(tmp);
 	get_v4l2_pix_format(&kp->fmt, &up->fmt);
 	return 0;
@@ -560,10 +560,10 @@ static int put_v4l2_framebuffer32(struct
 	u32 tmp = (u32)((unsigned long)kp->base);
 
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_framebuffer32)) ||
-		put_user(tmp, &up->base) ||
-		put_user(kp->capability, &up->capability) ||
-		put_user(kp->flags, &up->flags))
-			return -EFAULT;
+	    put_user(tmp, &up->base) ||
+	    put_user(kp->capability, &up->capability) ||
+	    put_user(kp->flags, &up->flags))
+		return -EFAULT;
 	put_v4l2_pix_format(&kp->fmt, &up->fmt);
 	return 0;
 }
@@ -597,11 +597,11 @@ static inline int put_v4l2_input32(struc
 }
 
 struct v4l2_ext_controls32 {
-       __u32 ctrl_class;
-       __u32 count;
-       __u32 error_idx;
-       __u32 reserved[2];
-       compat_caddr_t controls; /* actually struct v4l2_ext_control32 * */
+	__u32 ctrl_class;
+	__u32 count;
+	__u32 error_idx;
+	__u32 reserved[2];
+	compat_caddr_t controls; /* actually struct v4l2_ext_control32 * */
 };
 
 struct v4l2_ext_control32 {
@@ -640,11 +640,11 @@ static int get_v4l2_ext_controls32(struc
 	compat_caddr_t p;
 
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_ext_controls32)) ||
-		get_user(kp->ctrl_class, &up->ctrl_class) ||
-		get_user(kp->count, &up->count) ||
-		get_user(kp->error_idx, &up->error_idx) ||
-		copy_from_user(kp->reserved, up->reserved, sizeof(kp->reserved)))
-			return -EFAULT;
+	    get_user(kp->ctrl_class, &up->ctrl_class) ||
+	    get_user(kp->count, &up->count) ||
+	    get_user(kp->error_idx, &up->error_idx) ||
+	    copy_from_user(kp->reserved, up->reserved, sizeof(kp->reserved)))
+		return -EFAULT;
 	n = kp->count;
 	if (n == 0) {
 		kp->controls = NULL;
@@ -654,7 +654,7 @@ static int get_v4l2_ext_controls32(struc
 		return -EFAULT;
 	ucontrols = compat_ptr(p);
 	if (!access_ok(VERIFY_READ, ucontrols,
-			n * sizeof(struct v4l2_ext_control32)))
+		       n * sizeof(struct v4l2_ext_control32)))
 		return -EFAULT;
 	kcontrols = compat_alloc_user_space(n * sizeof(struct v4l2_ext_control));
 	kp->controls = (__force struct v4l2_ext_control *)kcontrols;
@@ -689,11 +689,11 @@ static int put_v4l2_ext_controls32(struc
 	compat_caddr_t p;
 
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_ext_controls32)) ||
-		put_user(kp->ctrl_class, &up->ctrl_class) ||
-		put_user(kp->count, &up->count) ||
-		put_user(kp->error_idx, &up->error_idx) ||
-		copy_to_user(up->reserved, kp->reserved, sizeof(up->reserved)))
-			return -EFAULT;
+	    put_user(kp->ctrl_class, &up->ctrl_class) ||
+	    put_user(kp->count, &up->count) ||
+	    put_user(kp->error_idx, &up->error_idx) ||
+	    copy_to_user(up->reserved, kp->reserved, sizeof(up->reserved)))
+		return -EFAULT;
 	if (!kp->count)
 		return 0;
 
@@ -701,7 +701,7 @@ static int put_v4l2_ext_controls32(struc
 		return -EFAULT;
 	ucontrols = compat_ptr(p);
 	if (!access_ok(VERIFY_WRITE, ucontrols,
-			n * sizeof(struct v4l2_ext_control32)))
+		       n * sizeof(struct v4l2_ext_control32)))
 		return -EFAULT;
 
 	while (--n >= 0) {
@@ -739,15 +739,15 @@ struct v4l2_event32 {
 static int put_v4l2_event32(struct v4l2_event *kp, struct v4l2_event32 __user *up)
 {
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_event32)) ||
-		put_user(kp->type, &up->type) ||
-		copy_to_user(&up->u, &kp->u, sizeof(kp->u)) ||
-		put_user(kp->pending, &up->pending) ||
-		put_user(kp->sequence, &up->sequence) ||
-		put_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
-		put_user(kp->timestamp.tv_nsec, &up->timestamp.tv_nsec) ||
-		put_user(kp->id, &up->id) ||
-		copy_to_user(up->reserved, kp->reserved, 8 * sizeof(__u32)))
-			return -EFAULT;
+	    put_user(kp->type, &up->type) ||
+	    copy_to_user(&up->u, &kp->u, sizeof(kp->u)) ||
+	    put_user(kp->pending, &up->pending) ||
+	    put_user(kp->sequence, &up->sequence) ||
+	    put_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
+	    put_user(kp->timestamp.tv_nsec, &up->timestamp.tv_nsec) ||
+	    put_user(kp->id, &up->id) ||
+	    copy_to_user(up->reserved, kp->reserved, 8 * sizeof(__u32)))
+		return -EFAULT;
 	return 0;
 }
 
@@ -764,12 +764,12 @@ static int get_v4l2_edid32(struct v4l2_e
 	u32 tmp;
 
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_edid32)) ||
-		get_user(kp->pad, &up->pad) ||
-		get_user(kp->start_block, &up->start_block) ||
-		get_user(kp->blocks, &up->blocks) ||
-		get_user(tmp, &up->edid) ||
-		copy_from_user(kp->reserved, up->reserved, sizeof(kp->reserved)))
-			return -EFAULT;
+	    get_user(kp->pad, &up->pad) ||
+	    get_user(kp->start_block, &up->start_block) ||
+	    get_user(kp->blocks, &up->blocks) ||
+	    get_user(tmp, &up->edid) ||
+	    copy_from_user(kp->reserved, up->reserved, sizeof(kp->reserved)))
+		return -EFAULT;
 	kp->edid = (__force u8 *)compat_ptr(tmp);
 	return 0;
 }
@@ -779,12 +779,12 @@ static int put_v4l2_edid32(struct v4l2_e
 	u32 tmp = (u32)((unsigned long)kp->edid);
 
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_edid32)) ||
-		put_user(kp->pad, &up->pad) ||
-		put_user(kp->start_block, &up->start_block) ||
-		put_user(kp->blocks, &up->blocks) ||
-		put_user(tmp, &up->edid) ||
-		copy_to_user(up->reserved, kp->reserved, sizeof(up->reserved)))
-			return -EFAULT;
+	    put_user(kp->pad, &up->pad) ||
+	    put_user(kp->start_block, &up->start_block) ||
+	    put_user(kp->blocks, &up->blocks) ||
+	    put_user(tmp, &up->edid) ||
+	    copy_to_user(up->reserved, kp->reserved, sizeof(up->reserved)))
+		return -EFAULT;
 	return 0;
 }
 
