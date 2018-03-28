Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2888441-1522260769-2-1047871371567645808
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522260768; b=LYEDJCnuQrW7Kp1D3M4V8S0B9OV9PLNdsJI8WhREQaXakUh
    HNDL12V+HU8W4MR7iHiQfAmJu/xBk87CAycRgGVSgeAWd3JtSklzU36Kvf9I4+jY
    gFYzU3KIby0uYJBaDuYdGnIE2M+ULO/H1xF8vVwzViqLSduUMnsYPYBO3kLlGqdZ
    7XgFJmHP5CMgO4HI6N4a+woDgVDFI3XFefWVuaAd8Ow18TEAY6OkCZYIouQ/jfWi
    DKxSYRiwzbYoq0ryabei3Zfn8AJ358EYita7iriDG5bRxyhFeiS2zullZX28ngq1
    +9YQEXcUTjbkMcp7NhZoRDBdNTxYqGDUKKJNPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522260768; bh=nBqJ3uYJd/XArunoPy5x2+aC5xNRvVMJz8W
    3ubjGz+8=; b=cGNSTyAimc8HB4m2yUFzrQPPl9uaPLRyhKXPdoBa/3bMthqjUy9
    0YVOvTMAor3KtFNmSdq/hdgwcXn+hAIgnP0xZkkobv10heDc9Veu3nPZodcuLX5k
    lnm94QOTuFoFFn7pCFLJGksAHl/Z+hWpy3ihp7P5KHQaot7h0OeR2NryMfdRXTLe
    4vvRP7wGW3HpNOFCq+oQ9Apg29gdZe+qZHlqaGQtVuFKuejTIwZyY/q/AhodDO51
    ragzwk9yvaUyMFp5qPE3hANRRDfcysshhjN3vtELHODVxCUE++oOmj8Pm1/JSbHQ
    HVI5rGMRow3rEuAAnKHad8RmhxvYLcnOeXA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNKLrDrcMjFKlMgWUiArDI71nxjc264yEpCbREtn0EPAo+n52ggYxfzawN3FUm6Pn5IF4MPuPRXu4XmWfNZFeM/sJaWkDRDezioXuFI8Fg1KR6keO4ps
    c8WjqQp3u37twJMSC4rxx4ckYIhmKVoTDYClUCqHLHjOzRW/c8jMgljVnAXc2/nXeDAsAShrKrUZ2kvZazOwUXcKzLSoCiZ8mNlV2NuGnSQNJe9pE6bhenlC
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=AUd_NHdVAAAA:8
    a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=nyPMeuHwuaWql16yYm4A:9
    a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeC1SMr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:12:47 -0400
Received: from osg.samsung.com ([64.30.133.232]:42241 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752318AbeC1SMq (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:12:46 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH for v3.18 07/18] media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
Date: Wed, 28 Mar 2018 15:12:26 -0300
Message-Id: <6e6f38fc8542cf41fffcd3067026c4f015564544.1522260310.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 8ed5a59dcb47a6f76034ee760b36e089f3e82529 upstream.

The struct v4l2_plane32 should set m.userptr as well. The same
happens in v4l2_buffer32 and v4l2-compliance tests for this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 47 ++++++++++++++++-----------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index b7dd98168a68..a27fd9105948 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -287,19 +287,24 @@ static int get_v4l2_plane32(struct v4l2_plane __user *up, struct v4l2_plane32 __
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
@@ -308,22 +313,32 @@ static int get_v4l2_plane32(struct v4l2_plane __user *up, struct v4l2_plane32 __
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
@@ -383,6 +398,7 @@ static int get_v4l2_buffer32(struct v4l2_buffer *kp, struct v4l2_buffer32 __user
 	} else {
 		switch (kp->memory) {
 		case V4L2_MEMORY_MMAP:
+		case V4L2_MEMORY_OVERLAY:
 			if (get_user(kp->m.offset, &up->m.offset))
 				return -EFAULT;
 			break;
@@ -396,10 +412,6 @@ static int get_v4l2_buffer32(struct v4l2_buffer *kp, struct v4l2_buffer32 __user
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
@@ -456,6 +468,7 @@ static int put_v4l2_buffer32(struct v4l2_buffer *kp, struct v4l2_buffer32 __user
 	} else {
 		switch (kp->memory) {
 		case V4L2_MEMORY_MMAP:
+		case V4L2_MEMORY_OVERLAY:
 			if (put_user(kp->m.offset, &up->m.offset))
 				return -EFAULT;
 			break;
@@ -463,10 +476,6 @@ static int put_v4l2_buffer32(struct v4l2_buffer *kp, struct v4l2_buffer32 __user
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
-- 
2.14.3
