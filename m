Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859260-1522260948-2-15640827577423625659
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522260947; b=IVLpPqrLi/BK79NOe4l213Osc7i1R5/IubfoPGE9zbE+TwS
    c+pZ1m9kS9vyUd4hk3BKmCLgX8yfeiWzHZVVa1uMsWjAuLzUdKp+rN+kuUp202Zj
    b4G1D+0AUWDroxb94TEuLnXNJt/ijfTpg2GvlgYRBs1cfEx3WV/RrECfhCNOobV2
    l4t1SnNkh4wqyPzYuWcY6ZOo2HEPHtnzQRL4Mdlint6a8J5bsfXIh49zMTEN8OWI
    tK4WmSfBg7QG7xYB3usgW8fhDdsuaq7vRSpjiMOZgU1zwZgwfckobDe6TdBo3g8A
    axeDrV/mCM9xZaI3mL2ltjQliJOeUFWRIRjJ5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522260947; bh=yAAx/V0BmCj4oWkYtA1L4ArqOodaEHb+dwy
    7QJFmIeY=; b=PsiQestJGeHfREF5NRf8V+gNB1Gr6+jNqJBGM7Ja3IBOcViTyqu
    AgFH69xpG4eXNRUWQ9aoFXW8ZuB9ALP/JIjZXVpFiTLz5h0q9WyeTzaEiXEQy6Ir
    alSKQ+1RQ39Lnr6fURav9Zh2FHmK8fNgpsYLwp5EW0MELNlvR5vCCJ0GH+yJ6QkX
    UcBxkxGu07XLXbjPjUIGvNEmYwgP1jJx8rbzfSQMvT1pP1z8dXWfENglnyEfaEI0
    WhX1aXVho1vJrSo/xBF4akwNh3pe9zUl0h6VV6wlZoOhYUQpdTCobl0BncFcMcwt
    duxuXmKAz6EMXUIo9fSriYM/fZgll20yYCQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfOH1U1sfjkIE73VxS7bkx2l8QDMabZq0+Jm35xJgHo6aY8tg7A79k4jl0cKBFGt2XZx0oWTRNI8//Hy+UdPeNk+yQxtpkQNG9Yu0WFVJ9l03k/BHHvuS
    xhORfTvtvJz28s+yDX8SEvCV02gRGBlliIqJWe5SeYBnV/N5YUKyZjbHOFySo3pDh282D5WpiQZCF+vu4rTtb7X/5sz4yfvBIpAQaBG52y+wbLN/9ItkBW5V
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=AUd_NHdVAAAA:8
    a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=JuPKFrt893H1PuNRQ9oA:9
    a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753568AbeC1SNO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:13:14 -0400
Received: from osg.samsung.com ([64.30.133.232]:45970 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752796AbeC1SNL (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:13:11 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH for v3.18 08/18] media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
Date: Wed, 28 Mar 2018 15:12:27 -0300
Message-Id: <63df92f6981785c5e31c1d8e796e827344cc75f3.1522260310.git.mchehab@s-opensource.com>
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

commit b8c601e8af2d08f733d74defa8465303391bb930 upstream.

ctrl_is_pointer just hardcoded two known string controls, but that
caused problems when using e.g. custom controls that use a pointer
for the payload.

Reimplement this function: it now finds the v4l2_ctrl (if the driver
uses the control framework) or it calls vidioc_query_ext_ctrl (if the
driver implements that directly).

In both cases it can now check if the control is a pointer control
or not.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 57 ++++++++++++++++++---------
 1 file changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index a27fd9105948..c78462e79a0a 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -18,6 +18,8 @@
 #include <linux/videodev2.h>
 #include <linux/v4l2-subdev.h>
 #include <media/v4l2-dev.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-ctrls.h>
 #include <media/v4l2-ioctl.h>
 
 static long native_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -575,24 +577,39 @@ struct v4l2_ext_control32 {
 	};
 } __attribute__ ((packed));
 
-/* The following function really belong in v4l2-common, but that causes
-   a circular dependency between modules. We need to think about this, but
-   for now this will do. */
-
-/* Return non-zero if this control is a pointer type. Currently only
-   type STRING is a pointer type. */
-static inline int ctrl_is_pointer(u32 id)
+/* Return true if this control is a pointer type. */
+static inline bool ctrl_is_pointer(struct file *file, u32 id)
 {
-	switch (id) {
-	case V4L2_CID_RDS_TX_PS_NAME:
-	case V4L2_CID_RDS_TX_RADIO_TEXT:
-		return 1;
-	default:
-		return 0;
+	struct video_device *vdev = video_devdata(file);
+	struct v4l2_fh *fh = NULL;
+	struct v4l2_ctrl_handler *hdl = NULL;
+	struct v4l2_query_ext_ctrl qec = { id };
+	const struct v4l2_ioctl_ops *ops = vdev->ioctl_ops;
+
+	if (test_bit(V4L2_FL_USES_V4L2_FH, &vdev->flags))
+		fh = file->private_data;
+
+	if (fh && fh->ctrl_handler)
+		hdl = fh->ctrl_handler;
+	else if (vdev->ctrl_handler)
+		hdl = vdev->ctrl_handler;
+
+	if (hdl) {
+		struct v4l2_ctrl *ctrl = v4l2_ctrl_find(hdl, id);
+
+		return ctrl && ctrl->is_ptr;
 	}
+
+	if (!ops->vidioc_query_ext_ctrl)
+		return false;
+
+	return !ops->vidioc_query_ext_ctrl(file, fh, &qec) &&
+		(qec.flags & V4L2_CTRL_FLAG_HAS_PAYLOAD);
 }
 
-static int get_v4l2_ext_controls32(struct v4l2_ext_controls *kp, struct v4l2_ext_controls32 __user *up)
+static int get_v4l2_ext_controls32(struct file *file,
+				   struct v4l2_ext_controls *kp,
+				   struct v4l2_ext_controls32 __user *up)
 {
 	struct v4l2_ext_control32 __user *ucontrols;
 	struct v4l2_ext_control __user *kcontrols;
@@ -624,7 +641,7 @@ static int get_v4l2_ext_controls32(struct v4l2_ext_controls *kp, struct v4l2_ext
 			return -EFAULT;
 		if (get_user(id, &kcontrols->id))
 			return -EFAULT;
-		if (ctrl_is_pointer(id)) {
+		if (ctrl_is_pointer(file, id)) {
 			void __user *s;
 
 			if (get_user(p, &ucontrols->string))
@@ -639,7 +656,9 @@ static int get_v4l2_ext_controls32(struct v4l2_ext_controls *kp, struct v4l2_ext
 	return 0;
 }
 
-static int put_v4l2_ext_controls32(struct v4l2_ext_controls *kp, struct v4l2_ext_controls32 __user *up)
+static int put_v4l2_ext_controls32(struct file *file,
+				   struct v4l2_ext_controls *kp,
+				   struct v4l2_ext_controls32 __user *up)
 {
 	struct v4l2_ext_control32 __user *ucontrols;
 	struct v4l2_ext_control __user *kcontrols =
@@ -671,7 +690,7 @@ static int put_v4l2_ext_controls32(struct v4l2_ext_controls *kp, struct v4l2_ext
 		/* Do not modify the pointer when copying a pointer control.
 		   The contents of the pointer was changed, not the pointer
 		   itself. */
-		if (ctrl_is_pointer(id))
+		if (ctrl_is_pointer(file, id))
 			size -= sizeof(ucontrols->value64);
 		if (copy_in_user(ucontrols, kcontrols, size))
 			return -EFAULT;
@@ -884,7 +903,7 @@ static long do_video_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 	case VIDIOC_G_EXT_CTRLS:
 	case VIDIOC_S_EXT_CTRLS:
 	case VIDIOC_TRY_EXT_CTRLS:
-		err = get_v4l2_ext_controls32(&karg.v2ecs, up);
+		err = get_v4l2_ext_controls32(file, &karg.v2ecs, up);
 		compatible_arg = 0;
 		break;
 	case VIDIOC_DQEVENT:
@@ -911,7 +930,7 @@ static long do_video_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 	case VIDIOC_G_EXT_CTRLS:
 	case VIDIOC_S_EXT_CTRLS:
 	case VIDIOC_TRY_EXT_CTRLS:
-		if (put_v4l2_ext_controls32(&karg.v2ecs, up))
+		if (put_v4l2_ext_controls32(file, &karg.v2ecs, up))
 			err = -EFAULT;
 		break;
 	}
-- 
2.14.3
