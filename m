Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225mL0sy6jv7Zq6meU1B7bb3av/6EXDMTPrYGPfzeoTDqzB2bWybN+POHE9Z2YhG9siOgyE+
ARC-Seal: i=1; a=rsa-sha256; t=1518708956; cv=none;
        d=google.com; s=arc-20160816;
        b=Cy2XmHnPtwe9i7AUL74UwdsQHyiQ9YDItwBQz1g6sHfK0vfNPnlSW1ilJonuu0fAQ9
         w1iausjg0PlIvpEeGxiw+CWZwAmvGsjuBLUvKwoTMR0WR5M2NlY+IhQXlszfH+oU2VU8
         n5x5dEwqo0olu/LYuFVr0lb/I53BjnvB1518devWWxI+RsZhJrXgGZENJ6LsEfq6Rsuz
         qgejrasKIGJxR2abOtrUew4t+9/xCg+VDIZXqX5w1fZ1vx/BXNcWuyso2PGMF/Gs1a3Q
         YsBPCpK7lijKcyOQe33XenwzcCuJYqeyo2ENhPaprTI9yigIw82+cCjhO2a+rhkQ5Adn
         iggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FuXod7NzVCw8/icKw/+6bRVsqxKAMtViH0NG/raayno=;
        b=RpGLW835FkF8MRTDq6I82F0xE3RqtMAkV6R5eSUkL72As18oM3A5XVorCh1EgUSKHM
         vcaws6smJegWmn5zs8I6nHV/a7XHYmulaXeITi1rqCCNIBD+qt/tzNqI8CXm40uzkTTz
         F+2hSH8pv5592G+hQS2XkYAoQygLZKhPfYoy/ASzcTHnsqet/46EMAj7DUg93aU8Vr8c
         yXeDFcOOkijBRHEAmXL+APuYHbDh8HNqm2iBvivvsjBPWGGr3QufObKX49D2DRftLWeG
         W/qjXZin5TwBpBvlSFgAlJacP7UQ5tmRaq3xaWBFViN7QF/2jeQtRJ0wH89D+qZcYjij
         yeXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.14 123/195] media: v4l2-compat-ioctl32.c: fix the indentation
Date: Thu, 15 Feb 2018 16:16:54 +0100
Message-Id: <20180215151711.863337675@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481000596788101?=
X-GMAIL-MSGID: =?utf-8?q?1592481763002093504?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |  212 +++++++++++++-------------
 1 file changed, 107 insertions(+), 105 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -49,12 +49,12 @@ struct v4l2_window32 {
 static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
 {
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_window32)) ||
-		copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
-		get_user(kp->field, &up->field) ||
-		get_user(kp->chromakey, &up->chromakey) ||
-		get_user(kp->clipcount, &up->clipcount) ||
-		get_user(kp->global_alpha, &up->global_alpha))
-			return -EFAULT;
+	    copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
+	    get_user(kp->field, &up->field) ||
+	    get_user(kp->chromakey, &up->chromakey) ||
+	    get_user(kp->clipcount, &up->clipcount) ||
+	    get_user(kp->global_alpha, &up->global_alpha))
+		return -EFAULT;
 	if (kp->clipcount > 2048)
 		return -EINVAL;
 	if (kp->clipcount) {
@@ -84,11 +84,11 @@ static int get_v4l2_window32(struct v4l2
 static int put_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
 {
 	if (copy_to_user(&up->w, &kp->w, sizeof(kp->w)) ||
-		put_user(kp->field, &up->field) ||
-		put_user(kp->chromakey, &up->chromakey) ||
-		put_user(kp->clipcount, &up->clipcount) ||
-		put_user(kp->global_alpha, &up->global_alpha))
-			return -EFAULT;
+	    put_user(kp->field, &up->field) ||
+	    put_user(kp->chromakey, &up->chromakey) ||
+	    put_user(kp->clipcount, &up->clipcount) ||
+	    put_user(kp->global_alpha, &up->global_alpha))
+		return -EFAULT;
 	return 0;
 }
 
@@ -100,7 +100,7 @@ static inline int get_v4l2_pix_format(st
 }
 
 static inline int get_v4l2_pix_format_mplane(struct v4l2_pix_format_mplane *kp,
-				struct v4l2_pix_format_mplane __user *up)
+					     struct v4l2_pix_format_mplane __user *up)
 {
 	if (copy_from_user(kp, up, sizeof(struct v4l2_pix_format_mplane)))
 		return -EFAULT;
@@ -115,7 +115,7 @@ static inline int put_v4l2_pix_format(st
 }
 
 static inline int put_v4l2_pix_format_mplane(struct v4l2_pix_format_mplane *kp,
-				struct v4l2_pix_format_mplane __user *up)
+					     struct v4l2_pix_format_mplane __user *up)
 {
 	if (copy_to_user(up, kp, sizeof(struct v4l2_pix_format_mplane)))
 		return -EFAULT;
@@ -238,7 +238,7 @@ static int __get_v4l2_format32(struct v4
 		return get_v4l2_meta_format(&kp->fmt.meta, &up->fmt.meta);
 	default:
 		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-								kp->type);
+			kp->type);
 		return -EINVAL;
 	}
 }
@@ -287,7 +287,7 @@ static int __put_v4l2_format32(struct v4
 		return put_v4l2_meta_format(&kp->fmt.meta, &up->fmt.meta);
 	default:
 		pr_info("compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-								kp->type);
+			kp->type);
 		return -EINVAL;
 	}
 }
@@ -321,7 +321,7 @@ static int get_v4l2_standard32(struct v4
 {
 	/* other fields are not set by the user, nor used by the driver */
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_standard32)) ||
-		get_user(kp->index, &up->index))
+	    get_user(kp->index, &up->index))
 		return -EFAULT;
 	return 0;
 }
@@ -329,13 +329,14 @@ static int get_v4l2_standard32(struct v4
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
+	    copy_to_user(&up->frameperiod, &kp->frameperiod,
+			 sizeof(kp->frameperiod)) ||
+	    put_user(kp->framelines, &up->framelines) ||
+	    copy_to_user(up->reserved, kp->reserved, 4 * sizeof(__u32)))
+		return -EFAULT;
 	return 0;
 }
 
@@ -375,14 +376,14 @@ struct v4l2_buffer32 {
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
@@ -396,7 +397,7 @@ static int get_v4l2_plane32(struct v4l2_
 			return -EFAULT;
 	} else {
 		if (copy_in_user(&up->m.mem_offset, &up32->m.mem_offset,
-					sizeof(__u32)))
+				 sizeof(__u32)))
 			return -EFAULT;
 	}
 
@@ -404,23 +405,23 @@ static int get_v4l2_plane32(struct v4l2_
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
@@ -434,19 +435,19 @@ static int get_v4l2_buffer32(struct v4l2
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
@@ -466,7 +467,7 @@ static int get_v4l2_buffer32(struct v4l2
 
 		uplane32 = compat_ptr(p);
 		if (!access_ok(VERIFY_READ, uplane32,
-				kp->length * sizeof(struct v4l2_plane32)))
+			       kp->length * sizeof(struct v4l2_plane32)))
 			return -EFAULT;
 
 		/* We don't really care if userspace decides to kill itself
@@ -490,12 +491,12 @@ static int get_v4l2_buffer32(struct v4l2
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
@@ -521,22 +522,23 @@ static int put_v4l2_buffer32(struct v4l2
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
+	    copy_to_user(&up->timecode, &kp->timecode,
+			 sizeof(struct v4l2_timecode)) ||
+	    put_user(kp->sequence, &up->sequence) ||
+	    put_user(kp->reserved2, &up->reserved2) ||
+	    put_user(kp->reserved, &up->reserved) ||
+	    put_user(kp->length, &up->length))
+		return -EFAULT;
 
 	if (V4L2_TYPE_IS_MULTIPLANAR(kp->type)) {
 		num_planes = kp->length;
@@ -600,11 +602,11 @@ static int get_v4l2_framebuffer32(struct
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
@@ -614,11 +616,11 @@ static int put_v4l2_framebuffer32(struct
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
 
@@ -694,12 +696,12 @@ static int get_v4l2_ext_controls32(struc
 	compat_caddr_t p;
 
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_ext_controls32)) ||
-		get_user(kp->which, &up->which) ||
-		get_user(kp->count, &up->count) ||
-		get_user(kp->error_idx, &up->error_idx) ||
-		copy_from_user(kp->reserved, up->reserved,
-			       sizeof(kp->reserved)))
-			return -EFAULT;
+	    get_user(kp->which, &up->which) ||
+	    get_user(kp->count, &up->count) ||
+	    get_user(kp->error_idx, &up->error_idx) ||
+	    copy_from_user(kp->reserved, up->reserved,
+			   sizeof(kp->reserved)))
+		return -EFAULT;
 	if (kp->count == 0) {
 		kp->controls = NULL;
 		return 0;
@@ -710,7 +712,7 @@ static int get_v4l2_ext_controls32(struc
 		return -EFAULT;
 	ucontrols = compat_ptr(p);
 	if (!access_ok(VERIFY_READ, ucontrols,
-			kp->count * sizeof(struct v4l2_ext_control32)))
+		       kp->count * sizeof(struct v4l2_ext_control32)))
 		return -EFAULT;
 	kcontrols = compat_alloc_user_space(kp->count *
 					    sizeof(struct v4l2_ext_control));
@@ -746,11 +748,11 @@ static int put_v4l2_ext_controls32(struc
 	compat_caddr_t p;
 
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_ext_controls32)) ||
-		put_user(kp->which, &up->which) ||
-		put_user(kp->count, &up->count) ||
-		put_user(kp->error_idx, &up->error_idx) ||
-		copy_to_user(up->reserved, kp->reserved, sizeof(up->reserved)))
-			return -EFAULT;
+	    put_user(kp->which, &up->which) ||
+	    put_user(kp->count, &up->count) ||
+	    put_user(kp->error_idx, &up->error_idx) ||
+	    copy_to_user(up->reserved, kp->reserved, sizeof(up->reserved)))
+		return -EFAULT;
 	if (!kp->count)
 		return 0;
 
@@ -758,7 +760,7 @@ static int put_v4l2_ext_controls32(struc
 		return -EFAULT;
 	ucontrols = compat_ptr(p);
 	if (!access_ok(VERIFY_WRITE, ucontrols,
-			n * sizeof(struct v4l2_ext_control32)))
+		       n * sizeof(struct v4l2_ext_control32)))
 		return -EFAULT;
 
 	while (--n >= 0) {
@@ -796,15 +798,15 @@ struct v4l2_event32 {
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
 
@@ -821,12 +823,12 @@ static int get_v4l2_edid32(struct v4l2_e
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
@@ -836,12 +838,12 @@ static int put_v4l2_edid32(struct v4l2_e
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
 
