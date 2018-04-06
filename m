Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021255-2-9139658790945081136
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021254; b=hPZFXSmAAiMTOoFSOe2bk/L0gkmBPk08/XBifhxsQshalJlRVu
    TPQ3ObiPZ3dReJCi+0I6IYeff+qcz2Mr/HdeFA9YW+leiFNLZ2qnwJk0Fr259/+f
    qvzvbXGUj1nZxP1VYb8qD0+LkHd14LFm2hF4pG31qIXSxnV24GsuVtALrgMi6bDQ
    P+KRN6h6SHVZBxeyUqyYVEEJtLYdz8E9mf+wXfXXkLQ1xbHhW4rDMX7usiONlOEW
    Dvl3Jx5bo2IrNUx9nApnHLSFz7PcPqaIiufAT29/ODtEkAP+Iu13CanhsFsLIq2h
    DxB4qjKfUi0plONEaHtlkeYdqlHb+qAQKw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021254; bh=wHTDNXeKpBrhC+ZJkDi3TfHAcu/TnW
    WGWnB+B1OxJ0c=; b=clr/86d8ZTgO5aYqlDGydPes+6dDGDH1ZuW/Pjl7EErYUI
    AphXcSuO5Y84sOURoZD/eDLiD5sDKnqlXuD7KMju42VEvexn607yyhD6BBlxlMk8
    oK+CvPzDANZYUgrNtFtU75EeKIGr0PyufK7iKcQh+1sg/jtTDpyKw3aF5AHe3Alu
    hNfqkWnkBuqBIieMZKvmSty3uMu1DRsOBsc2MXmzPt5L8xL2weYDEPIVt2m7OATs
    VliZntK5LW6Ou9NT9tvRzufU1YvAX+xj1LOtE85J6OT6zVkv5UTBuAAechjh1FKn
    FwUzxsek6xdInIvVYbgYtoROYm3klS1FqKH1Nf5g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ0iFyR/ncdh7iHLElLhZDXI5R4hZkfl9NmA1mLY1TWaWiafZ4I+WZO6NHWhCyWHH+gIIagSo1t0nZd/CowO1bmHWWdCcZQwgQUManV+h96Ht93vrUl0
    j3/CCO9Fj078dQIzG4njZBYyLksEWaJaxF6Ai9Pqvf767O20IxqJUhTzosMJNi0iBAmYVujrDsfq7O2sDPq5B4NBJe7TZPqoRESE/yn5Br4OZB8WFqaQ2PaV
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AUd_NHdVAAAA:8 a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=yJ7v755ftugiIl7VU9MA:9 a=G1L7UgUj3ZdnX_x4:21
    a=jtTHvJjkdYJBv-fE:21 a=QEXdDO2ut3YA:10 a=NGXS0kB0m_rannUenejW:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbeDFN1c (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:27:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55020 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753623AbeDFN13 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:27:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 62/93] media: v4l2-compat-ioctl32.c: avoid sizeof(type)
Date: Fri,  6 Apr 2018 15:23:31 +0200
Message-Id: <20180406084227.609368921@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 333b1e9f96ce05f7498b581509bb30cde03018bf upstream.

Instead of doing sizeof(struct foo) use sizeof(*up). There even were
cases where 4 * sizeof(__u32) was used instead of sizeof(kp->reserved),
which is very dangerous when the size of the reserved array changes.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |   80 ++++++++++++--------------
 1 file changed, 38 insertions(+), 42 deletions(-)

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
@@ -196,17 +196,17 @@ static int __put_v4l2_format32(struct v4
 
 static int put_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_format32)) ||
-		put_user(kp->type, &up->type))
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)))
 		return -EFAULT;
 	return __put_v4l2_format32(kp, up);
 }
 
 static int put_v4l2_create32(struct v4l2_create_buffers *kp, struct v4l2_create_buffers32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_create_buffers32)) ||
-	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format.fmt)))
-			return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
+	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format)) ||
+	    copy_to_user(up->reserved, kp->reserved, sizeof(kp->reserved)))
+		return -EFAULT;
 	return __put_v4l2_format32(&kp->format, &up->format);
 }
 
@@ -222,7 +222,7 @@ struct v4l2_standard32 {
 static int get_v4l2_standard32(struct v4l2_standard *kp, struct v4l2_standard32 __user *up)
 {
 	/* other fields are not set by the user, nor used by the driver */
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_standard32)) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    get_user(kp->index, &up->index))
 		return -EFAULT;
 	return 0;
@@ -230,13 +230,13 @@ static int get_v4l2_standard32(struct v4
 
 static int put_v4l2_standard32(struct v4l2_standard *kp, struct v4l2_standard32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_standard32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    put_user(kp->index, &up->index) ||
 	    copy_to_user(up->id, &kp->id, sizeof(__u64)) ||
-	    copy_to_user(up->name, kp->name, 24) ||
+	    copy_to_user(up->name, kp->name, sizeof(up->name)) ||
 	    copy_to_user(&up->frameperiod, &kp->frameperiod, sizeof(kp->frameperiod)) ||
 	    put_user(kp->framelines, &up->framelines) ||
-	    copy_to_user(up->reserved, kp->reserved, 4 * sizeof(__u32)))
+	    copy_to_user(up->reserved, kp->reserved, sizeof(kp->reserved)))
 		return -EFAULT;
 	return 0;
 }
@@ -284,7 +284,7 @@ static int get_v4l2_plane32(struct v4l2_
 
 	if (copy_in_user(up, up32, 2 * sizeof(__u32)) ||
 	    copy_in_user(&up->data_offset, &up32->data_offset,
-			 sizeof(__u32)))
+			 sizeof(up->data_offset)))
 		return -EFAULT;
 
 	if (memory == V4L2_MEMORY_USERPTR) {
@@ -294,11 +294,11 @@ static int get_v4l2_plane32(struct v4l2_
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
 
@@ -310,19 +310,19 @@ static int put_v4l2_plane32(struct v4l2_
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
@@ -336,7 +336,7 @@ static int get_v4l2_buffer32(struct v4l2
 	int num_planes;
 	int ret;
 
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_buffer32)) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    get_user(kp->index, &up->index) ||
 	    get_user(kp->type, &up->type) ||
 	    get_user(kp->flags, &up->flags) ||
@@ -348,8 +348,7 @@ static int get_v4l2_buffer32(struct v4l2
 		if (get_user(kp->bytesused, &up->bytesused) ||
 		    get_user(kp->field, &up->field) ||
 		    get_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
-		    get_user(kp->timestamp.tv_usec,
-			     &up->timestamp.tv_usec))
+		    get_user(kp->timestamp.tv_usec, &up->timestamp.tv_usec))
 			return -EFAULT;
 
 	if (V4L2_TYPE_IS_MULTIPLANAR(kp->type)) {
@@ -366,13 +365,12 @@ static int get_v4l2_buffer32(struct v4l2
 
 		uplane32 = compat_ptr(p);
 		if (!access_ok(VERIFY_READ, uplane32,
-			       num_planes * sizeof(struct v4l2_plane32)))
+			       num_planes * sizeof(*uplane32)))
 			return -EFAULT;
 
 		/* We don't really care if userspace decides to kill itself
 		 * by passing a very big num_planes value */
-		uplane = compat_alloc_user_space(num_planes *
-						 sizeof(struct v4l2_plane));
+		uplane = compat_alloc_user_space(num_planes * sizeof(*uplane));
 		kp->m.planes = (__force struct v4l2_plane *)uplane;
 
 		while (--num_planes >= 0) {
@@ -420,7 +418,7 @@ static int put_v4l2_buffer32(struct v4l2
 	int num_planes;
 	int ret;
 
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_buffer32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    put_user(kp->index, &up->index) ||
 	    put_user(kp->type, &up->type) ||
 	    put_user(kp->flags, &up->flags) ||
@@ -431,7 +429,7 @@ static int put_v4l2_buffer32(struct v4l2
 	    put_user(kp->field, &up->field) ||
 	    put_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
 	    put_user(kp->timestamp.tv_usec, &up->timestamp.tv_usec) ||
-	    copy_to_user(&up->timecode, &kp->timecode, sizeof(struct v4l2_timecode)) ||
+	    copy_to_user(&up->timecode, &kp->timecode, sizeof(kp->timecode)) ||
 	    put_user(kp->sequence, &up->sequence) ||
 	    put_user(kp->reserved2, &up->reserved2) ||
 	    put_user(kp->reserved, &up->reserved) ||
@@ -499,7 +497,7 @@ static int get_v4l2_framebuffer32(struct
 {
 	u32 tmp;
 
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_framebuffer32)) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    get_user(tmp, &up->base) ||
 	    get_user(kp->capability, &up->capability) ||
 	    get_user(kp->flags, &up->flags) ||
@@ -513,7 +511,7 @@ static int put_v4l2_framebuffer32(struct
 {
 	u32 tmp = (u32)((unsigned long)kp->base);
 
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_framebuffer32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    put_user(tmp, &up->base) ||
 	    put_user(kp->capability, &up->capability) ||
 	    put_user(kp->flags, &up->flags) ||
@@ -537,14 +535,14 @@ struct v4l2_input32 {
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
@@ -592,7 +590,7 @@ static int get_v4l2_ext_controls32(struc
 	int n;
 	compat_caddr_t p;
 
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_ext_controls32)) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    get_user(kp->ctrl_class, &up->ctrl_class) ||
 	    get_user(kp->count, &up->count) ||
 	    get_user(kp->error_idx, &up->error_idx) ||
@@ -606,10 +604,9 @@ static int get_v4l2_ext_controls32(struc
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
@@ -641,7 +638,7 @@ static int put_v4l2_ext_controls32(struc
 	int n = kp->count;
 	compat_caddr_t p;
 
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_ext_controls32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    put_user(kp->ctrl_class, &up->ctrl_class) ||
 	    put_user(kp->count, &up->count) ||
 	    put_user(kp->error_idx, &up->error_idx) ||
@@ -653,8 +650,7 @@ static int put_v4l2_ext_controls32(struc
 	if (get_user(p, &up->controls))
 		return -EFAULT;
 	ucontrols = compat_ptr(p);
-	if (!access_ok(VERIFY_WRITE, ucontrols,
-		       n * sizeof(struct v4l2_ext_control32)))
+	if (!access_ok(VERIFY_WRITE, ucontrols, n * sizeof(*ucontrols)))
 		return -EFAULT;
 
 	while (--n >= 0) {
@@ -690,7 +686,7 @@ struct v4l2_event32 {
 
 static int put_v4l2_event32(struct v4l2_event *kp, struct v4l2_event32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_event32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    put_user(kp->type, &up->type) ||
 	    copy_to_user(&up->u, &kp->u, sizeof(kp->u)) ||
 	    put_user(kp->pending, &up->pending) ||
@@ -698,7 +694,7 @@ static int put_v4l2_event32(struct v4l2_
 	    put_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
 	    put_user(kp->timestamp.tv_nsec, &up->timestamp.tv_nsec) ||
 	    put_user(kp->id, &up->id) ||
-	    copy_to_user(up->reserved, kp->reserved, 8 * sizeof(__u32)))
+	    copy_to_user(up->reserved, kp->reserved, sizeof(kp->reserved)))
 		return -EFAULT;
 	return 0;
 }
@@ -715,7 +711,7 @@ static int get_v4l2_edid32(struct v4l2_e
 {
 	u32 tmp;
 
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_edid32)) ||
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    get_user(kp->pad, &up->pad) ||
 	    get_user(kp->start_block, &up->start_block) ||
 	    get_user(kp->blocks, &up->blocks) ||
@@ -730,7 +726,7 @@ static int put_v4l2_edid32(struct v4l2_e
 {
 	u32 tmp = (u32)((unsigned long)kp->edid);
 
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_edid32)) ||
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
 	    put_user(kp->pad, &up->pad) ||
 	    put_user(kp->start_block, &up->start_block) ||
 	    put_user(kp->blocks, &up->blocks) ||
