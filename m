Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720057-2-9206060277036928487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720056; b=UQnPd1a/PEEGBJtptUS+/02uJBoy0AjYdzTmdF0P0QXPUdZ
    0nd7kRKU+y4G0X+7FFhQW5vUpmakdpQK5+wHayqfUkiop9hNTsjMXfNmwfOx3o72
    iIDZfO+SaFBgPpZTZ2PTZLAM/AfV602B/oGVHdcc/5aRNXzlBUdJh4tABq1YaCcW
    ODmD2rV3vM6t1mZ2QsWPzIheRdKq1+sm/jLW8kwfpLCZdZ9kLKNOSIkTXhPIwq5E
    GGAYeuHJXeHV8R2GZuuc5VZ4+xFqMgJt5iovLt3+I3ZOUqhmsV1gBS6kT5siNHI7
    h1Rzsqb1hy35v88z07c6TDJLfDEymyXQPeRHHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720056; bh=RPTdfB79ahmXQD2J3dKJ6sdOJ1
    STXGr843uWSCL25l4=; b=CDilLh5klmfY709pe21X4UhapPOmUJv24xxSWzCiqv
    /NIDcQN6Chp8AcR2G+xWFSvLpcMB/UY87I3kntt7IQ518gw1o7JD9ncAyjHY3y0h
    Dbu9QbXLuG/eKJdqfB6mvZxGGXNhwcnZuQglZiTtnInFh+DpYbZmLoO3Hn9vDpVO
    wUkrZey07qKtwxq6o7Cpubqo7NZHrWWb5M0SL0Cj3cNWhAqcsBDAG60cLJP2XSGW
    lWRJo2TmUUtV8uSjaX0wplacQJ+Dvq0kNIpSjlCNnYYkLNFlj+tK+s+r1LUoMB6h
    Us7DKTkwEi1xGFvFccT8V5wt+4fNlYVV6b4IgxS9CL1w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166752AbeBOSka (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:40:30 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162754AbeBOPXs (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:48 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.4 074/108] media: v4l2-compat-ioctl32.c: fix the indentation
Date: Thu, 15 Feb 2018 16:17:11 +0100
Message-Id: <20180215151232.631983233@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit b7b957d429f601d6d1942122b339474f31191d75 upstream.

The indentation of this source is all over the place. Fix this.
This patch only changes whitespace.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |  208 +++++++++++++-------------
 1 file changed, 104 insertions(+), 104 deletions(-)

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
@@ -218,7 +218,7 @@ static int __get_v4l2_format32(struct v4
 		return get_v4l2_sdr_format(&kp->fmt.sdr, &up->fmt.sdr);
 	default:
 		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-								kp->type);
+			kp->type);
 		return -EINVAL;
 	}
 }
@@ -265,7 +265,7 @@ static int __put_v4l2_format32(struct v4
 		return put_v4l2_sdr_format(&kp->fmt.sdr, &up->fmt.sdr);
 	default:
 		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-								kp->type);
+			kp->type);
 		return -EINVAL;
 	}
 }
@@ -299,7 +299,7 @@ static int get_v4l2_standard32(struct v4
 {
 	/* other fields are not set by the user, nor used by the driver */
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_standard32)) ||
-		get_user(kp->index, &up->index))
+	    get_user(kp->index, &up->index))
 		return -EFAULT;
 	return 0;
 }
@@ -307,13 +307,13 @@ static int get_v4l2_standard32(struct v4
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
 
@@ -353,14 +353,14 @@ struct v4l2_buffer32 {
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
@@ -374,7 +374,7 @@ static int get_v4l2_plane32(struct v4l2_
 			return -EFAULT;
 	} else {
 		if (copy_in_user(&up->m.mem_offset, &up32->m.mem_offset,
-					sizeof(__u32)))
+				 sizeof(__u32)))
 			return -EFAULT;
 	}
 
@@ -382,23 +382,23 @@ static int get_v4l2_plane32(struct v4l2_
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
@@ -413,19 +413,19 @@ static int get_v4l2_buffer32(struct v4l2
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
@@ -442,13 +442,13 @@ static int get_v4l2_buffer32(struct v4l2
 
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
@@ -466,12 +466,12 @@ static int get_v4l2_buffer32(struct v4l2
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
@@ -497,22 +497,22 @@ static int put_v4l2_buffer32(struct v4l2
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
@@ -576,11 +576,11 @@ static int get_v4l2_framebuffer32(struct
 	u32 tmp;
 
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_framebuffer32)) ||
-		get_user(tmp, &up->base) ||
-		get_user(kp->capability, &up->capability) ||
-		get_user(kp->flags, &up->flags) ||
-		copy_from_user(&kp->fmt, &up->fmt, sizeof(up->fmt)))
-			return -EFAULT;
+	    get_user(tmp, &up->base) ||
+	    get_user(kp->capability, &up->capability) ||
+	    get_user(kp->flags, &up->flags) ||
+	    copy_from_user(&kp->fmt, &up->fmt, sizeof(up->fmt)))
+		return -EFAULT;
 	kp->base = (__force void *)compat_ptr(tmp);
 	return 0;
 }
@@ -590,11 +590,11 @@ static int put_v4l2_framebuffer32(struct
 	u32 tmp = (u32)((unsigned long)kp->base);
 
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_framebuffer32)) ||
-		put_user(tmp, &up->base) ||
-		put_user(kp->capability, &up->capability) ||
-		put_user(kp->flags, &up->flags) ||
-		copy_to_user(&up->fmt, &kp->fmt, sizeof(up->fmt)))
-			return -EFAULT;
+	    put_user(tmp, &up->base) ||
+	    put_user(kp->capability, &up->capability) ||
+	    put_user(kp->flags, &up->flags) ||
+	    copy_to_user(&up->fmt, &kp->fmt, sizeof(up->fmt)))
+		return -EFAULT;
 	return 0;
 }
 
@@ -669,12 +669,12 @@ static int get_v4l2_ext_controls32(struc
 	compat_caddr_t p;
 
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_ext_controls32)) ||
-		get_user(kp->ctrl_class, &up->ctrl_class) ||
-		get_user(kp->count, &up->count) ||
-		get_user(kp->error_idx, &up->error_idx) ||
-		copy_from_user(kp->reserved, up->reserved,
-			       sizeof(kp->reserved)))
-			return -EFAULT;
+	    get_user(kp->ctrl_class, &up->ctrl_class) ||
+	    get_user(kp->count, &up->count) ||
+	    get_user(kp->error_idx, &up->error_idx) ||
+	    copy_from_user(kp->reserved, up->reserved,
+			   sizeof(kp->reserved)))
+		return -EFAULT;
 	n = kp->count;
 	if (n == 0) {
 		kp->controls = NULL;
@@ -684,7 +684,7 @@ static int get_v4l2_ext_controls32(struc
 		return -EFAULT;
 	ucontrols = compat_ptr(p);
 	if (!access_ok(VERIFY_READ, ucontrols,
-			n * sizeof(struct v4l2_ext_control32)))
+		       n * sizeof(struct v4l2_ext_control32)))
 		return -EFAULT;
 	kcontrols = compat_alloc_user_space(n * sizeof(struct v4l2_ext_control));
 	kp->controls = (__force struct v4l2_ext_control *)kcontrols;
@@ -719,11 +719,11 @@ static int put_v4l2_ext_controls32(struc
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
 
@@ -731,7 +731,7 @@ static int put_v4l2_ext_controls32(struc
 		return -EFAULT;
 	ucontrols = compat_ptr(p);
 	if (!access_ok(VERIFY_WRITE, ucontrols,
-			n * sizeof(struct v4l2_ext_control32)))
+		       n * sizeof(struct v4l2_ext_control32)))
 		return -EFAULT;
 
 	while (--n >= 0) {
@@ -769,15 +769,15 @@ struct v4l2_event32 {
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
 
@@ -794,12 +794,12 @@ static int get_v4l2_edid32(struct v4l2_e
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
@@ -809,12 +809,12 @@ static int put_v4l2_edid32(struct v4l2_e
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
 
