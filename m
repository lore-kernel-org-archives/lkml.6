Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49dr06XJrKpGffmjSA6157tzbqGUw7QvukdL/i+sKCcGo7KyZ7K3GZj32eJY96gSYxYwzzL
ARC-Seal: i=1; a=rsa-sha256; t=1522855978; cv=none;
        d=google.com; s=arc-20160816;
        b=Zas4k2g7UMC8L1QCpz4TkpvyRw68+vidma1OgKR1ube8Fi7aLjb1o0EaeWHxRmio8z
         871GK586d4s5EqULKOnUJAdlJwPJRXQnIaX+hzo6tAguuUz+trvrhbjtqSJifsHeyO8J
         Igq7amhZnFzR30yWh0LKPMBf28m/44qObJkrxoDUb9LRAFCtYhgtdgG4/62+P9ev7aUW
         hMvEVeAO0uSrUENMYDRB2C5OMqXVAY1Lxou3156DZ9r4oiwKciOszntEaTfmYHU8Uqaj
         HHc2yLQMX5/VcTTwbip7VE88VlwpXF8TAX1TiPl17l2M+IijiZuZg75/+3n2I08KcE4b
         3+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :from:cc:to:subject:arc-authentication-results;
        bh=md20bcZgNCCdMqV2XvkuWevDnwOL6qrAk7Lk8BQRQvM=;
        b=GinBeS+09ZOp+OLxQ5fi+0VW0ZNgbkDhtJEYw3CgEP6R/yjD8/S6jChBRKuJO/utbq
         UZUABo4ap/PBebzG0a55C4H9sQ5ybo+S2sYp5elIldB+1JMABklqGvepPd6qYbqpeaTy
         yXNUG3cmFkW9WbOmS8xsR4sFf3BYPMqnF7CM7284slgrp9BVEwqAKVzdWLU9ETSlrgop
         8PbsmpBrgXrQpBvGOB38SrbgvQNQnskwJQJL+UiWnaxs7Dp38L8N+23WzwCTaF81fNoz
         3vR+UG3PZZuPHuHmOHfntEHbYeLTQ9YQH/JF/yqQ7rcoDNXAz+qcmo/Fz0BEaev/05oo
         ZapA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Subject: Patch "media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32" has been added to the 3.18-stable tree
To: mchehab@s-opensource.com,alexander.levin@microsoft.com,gregkh@linuxfoundation.org,hans.verkuil@cisco.com,linux-kernel@vger.kernel.org,linux-media@vger.kernel.org,mchehab@infradead.org,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Apr 2018 17:32:45 +0200
In-Reply-To: <6e6f38fc8542cf41fffcd3067026c4f015564544.1522260310.git.mchehab@s-opensource.com>
Message-ID: <152285596571248@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596830230583604375?=
X-GMAIL-MSGID: =?utf-8?q?1596830230583604375?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32

to the 3.18-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     media-v4l2-compat-ioctl32.c-copy-m.userptr-in-put_v4l2_plane32.patch
and it can be found in the queue-3.18 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Wed Apr  4 17:30:18 CEST 2018
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Wed, 28 Mar 2018 15:12:26 -0300
Subject: media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
To: Linux Media Mailing List <linux-media@vger.kernel.org>, stable@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Sasha Levin <alexander.levin@microsoft.com>
Message-ID: <6e6f38fc8542cf41fffcd3067026c4f015564544.1522260310.git.mchehab@s-opensource.com>

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 8ed5a59dcb47a6f76034ee760b36e089f3e82529 upstream.

The struct v4l2_plane32 should set m.userptr as well. The same
happens in v4l2_buffer32 and v4l2-compliance tests for this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |   47 +++++++++++++++-----------
 1 file changed, 28 insertions(+), 19 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -287,19 +287,24 @@ static int get_v4l2_plane32(struct v4l2_
 			 sizeof(up->data_offset)))
 		return -EFAULT;
 
-	if (memory == V4L2_MEMORY_USERPTR) {
+	switch (memory) {
+	case V4L2_MEMORY_MMAP:
+	case V4L2_MEMORY_OVERLAY:
+		if (copy_in_user(&up->m.mem_offset, &up32->m.mem_offset,
+				 sizeof(up32->m.mem_offset)))
+			return -EFAULT;
+		break;
+	case V4L2_MEMORY_USERPTR:
 		if (get_user(p, &up32->m.userptr))
 			return -EFAULT;
 		up_pln = compat_ptr(p);
 		if (put_user((unsigned long)up_pln, &up->m.userptr))
 			return -EFAULT;
-	} else if (memory == V4L2_MEMORY_DMABUF) {
+		break;
+	case V4L2_MEMORY_DMABUF:
 		if (copy_in_user(&up->m.fd, &up32->m.fd, sizeof(up32->m.fd)))
 			return -EFAULT;
-	} else {
-		if (copy_in_user(&up->m.mem_offset, &up32->m.mem_offset,
-				 sizeof(up32->m.mem_offset)))
-			return -EFAULT;
+		break;
 	}
 
 	return 0;
@@ -308,22 +313,32 @@ static int get_v4l2_plane32(struct v4l2_
 static int put_v4l2_plane32(struct v4l2_plane __user *up, struct v4l2_plane32 __user *up32,
 			    enum v4l2_memory memory)
 {
+	unsigned long p;
+
 	if (copy_in_user(up32, up, 2 * sizeof(__u32)) ||
 	    copy_in_user(&up32->data_offset, &up->data_offset,
 			 sizeof(up->data_offset)))
 		return -EFAULT;
 
-	/* For MMAP, driver might've set up the offset, so copy it back.
-	 * USERPTR stays the same (was userspace-provided), so no copying. */
-	if (memory == V4L2_MEMORY_MMAP)
+	switch (memory) {
+	case V4L2_MEMORY_MMAP:
+	case V4L2_MEMORY_OVERLAY:
 		if (copy_in_user(&up32->m.mem_offset, &up->m.mem_offset,
 				 sizeof(up->m.mem_offset)))
 			return -EFAULT;
-	/* For DMABUF, driver might've set up the fd, so copy it back. */
-	if (memory == V4L2_MEMORY_DMABUF)
+		break;
+	case V4L2_MEMORY_USERPTR:
+		if (get_user(p, &up->m.userptr) ||
+		    put_user((compat_ulong_t)ptr_to_compat((__force void *)p),
+			     &up32->m.userptr))
+			return -EFAULT;
+		break;
+	case V4L2_MEMORY_DMABUF:
 		if (copy_in_user(&up32->m.fd, &up->m.fd,
 				 sizeof(up->m.fd)))
 			return -EFAULT;
+		break;
+	}
 
 	return 0;
 }
@@ -383,6 +398,7 @@ static int get_v4l2_buffer32(struct v4l2
 	} else {
 		switch (kp->memory) {
 		case V4L2_MEMORY_MMAP:
+		case V4L2_MEMORY_OVERLAY:
 			if (get_user(kp->m.offset, &up->m.offset))
 				return -EFAULT;
 			break;
@@ -396,10 +412,6 @@ static int get_v4l2_buffer32(struct v4l2
 				kp->m.userptr = (unsigned long)compat_ptr(tmp);
 			}
 			break;
-		case V4L2_MEMORY_OVERLAY:
-			if (get_user(kp->m.offset, &up->m.offset))
-				return -EFAULT;
-			break;
 		case V4L2_MEMORY_DMABUF:
 			if (get_user(kp->m.fd, &up->m.fd))
 				return -EFAULT;
@@ -456,6 +468,7 @@ static int put_v4l2_buffer32(struct v4l2
 	} else {
 		switch (kp->memory) {
 		case V4L2_MEMORY_MMAP:
+		case V4L2_MEMORY_OVERLAY:
 			if (put_user(kp->m.offset, &up->m.offset))
 				return -EFAULT;
 			break;
@@ -463,10 +476,6 @@ static int put_v4l2_buffer32(struct v4l2
 			if (put_user(kp->m.userptr, &up->m.userptr))
 				return -EFAULT;
 			break;
-		case V4L2_MEMORY_OVERLAY:
-			if (put_user(kp->m.offset, &up->m.offset))
-				return -EFAULT;
-			break;
 		case V4L2_MEMORY_DMABUF:
 			if (put_user(kp->m.fd, &up->m.fd))
 				return -EFAULT;


Patches currently in stable-queue which might be from mchehab@s-opensource.com are

queue-3.18/media-v4l2-compat-ioctl32.c-copy-m.userptr-in-put_v4l2_plane32.patch
queue-3.18/media-v4l2-compat-ioctl32.c-avoid-sizeof-type.patch
queue-3.18/media-v4l2-compat-ioctl32.c-drop-pr_info-for-unknown-buffer-type.patch
queue-3.18/media-v4l2-compat-ioctl32-use-compat_u64-for-video-standard.patch
queue-3.18/media-v4l2-compat-ioctl32.c-add-missing-vidioc_prepare_buf.patch
queue-3.18/vb2-v4l2_buf_flag_done-is-set-after-dqbuf.patch
queue-3.18/media-v4l2-compat-ioctl32.c-refactor-compat-ioctl32-logic.patch
queue-3.18/media-v4l2-ctrls-fix-sparse-warning.patch
queue-3.18/media-v4l2-compat-ioctl32.c-fix-ctrl_is_pointer.patch
queue-3.18/media-v4l2-compat-ioctl32.c-move-helper-functions-to-__get-put_v4l2_format32.patch
queue-3.18/media-media-v4l2-ctrls-volatiles-should-not-generate-ch_value.patch
queue-3.18/media-v4l2-compat-ioctl32.c-don-t-copy-back-the-result-for-certain-errors.patch
queue-3.18/media-v4l2-compat-ioctl32.c-make-ctrl_is_pointer-work-for-subdevs.patch
queue-3.18/media-v4l2-compat-ioctl32.c-fix-the-indentation.patch
queue-3.18/media-v4l2-compat-ioctl32-copy-v4l2_window-global_alpha.patch
queue-3.18/media-v4l2-ioctl.c-don-t-copy-back-the-result-for-enotty.patch
queue-3.18/media-v4l2-compat-ioctl32.c-copy-clip-list-in-put_v4l2_window32.patch
queue-3.18/media-v4l2-compat-ioctl32-initialize-a-reserved-field.patch
