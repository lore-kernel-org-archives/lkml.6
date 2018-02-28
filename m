Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519839820-2-4453504360291099535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839818; b=GQnIvCpoXHmqHWAE9Y9QDKf15/5kK1YtiAN/tacAoDhl236
    wlgXrYCFR6gU/YxfGQyXGOa6jG0AaEq7tknI4e2VC2O+Py/1OFr4e2okd9SqFxqx
    9/PgGaOgFqRhV74BuoeSbx3MxuXa3SLnFVbRh4NK+xhzUbxdiK2vbLlED87Tu5Hd
    WOWrlWl3MEkgY4+9JluH/0RATaGQR8hzxiFjLZE//WCwt03W9BeaVqeJgY+BD6/Z
    N6qgTLtjyDDPT6b50/1IR01pQm4ByzAo6yPa0nXvCTh/VuJ/KpqC5bgtl3rvR0eV
    YqlLqpV4a7q7JV/k0lZKuAyp3ZVv70QFkGSU7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839818; bh=N1hjD3GWoMsKD+sXUhp
    3tshBgmW6hdp8D8RtBNIutbU=; b=dXC0tMuTp2BVnAhn8sZw7FQBtTlRzr5tTqq
    wawZkpU4HG0PeAFSq4435UyCsg0RE86KhOQbzeMlTDQpvF/KZjIiBmQta9kl33Ro
    UmHj2yUU7JDT6gE4zMpWiQTEsnQ0tCTaLS/aXvxFjF/Zwmm2Dui2rBHo61F/01w2
    ocmqAbSPZFtXNQaCsoECLBb5/emyTK3hP63SE7admmwdbtWbahFsYXEurXhGrDtM
    pYmTpOjmR0TR0AYcMrd/YfS+Hd3/LfTJbQbWrI23Wdo37dwIoKLFQJTtiWnn8FM4
    7PemuezNMrXx537NgE50Gcn5atbw62Xerxh6fr1e8dRCYt5P7pg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeB1Rke (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:40:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33151 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932529AbeB1PWN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:13 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.300113266@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 130/140] media: v4l2-compat-ioctl32.c: move 'helper'
 functions to __get/put_v4l2_format32
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

commit 486c521510c44a04cd756a9267e7d1e271c8a4ba upstream.

These helper functions do not really help. Move the code to the
__get/put_v4l2_format32 functions.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
[bwh: Rebased on top of some earlier fixes]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/media/video/v4l2-compat-ioctl32.c
+++ b/drivers/media/video/v4l2-compat-ioctl32.c
@@ -89,64 +89,6 @@ static int put_v4l2_window32(struct v4l2
 	return 0;
 }
 
-static inline int get_v4l2_pix_format(struct v4l2_pix_format *kp, struct v4l2_pix_format __user *up)
-{
-	if (copy_from_user(kp, up, sizeof(struct v4l2_pix_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int get_v4l2_pix_format_mplane(struct v4l2_pix_format_mplane *kp,
-					     struct v4l2_pix_format_mplane __user *up)
-{
-	if (copy_from_user(kp, up, sizeof(struct v4l2_pix_format_mplane)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int put_v4l2_pix_format(struct v4l2_pix_format *kp, struct v4l2_pix_format __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_pix_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int put_v4l2_pix_format_mplane(struct v4l2_pix_format_mplane *kp,
-					     struct v4l2_pix_format_mplane __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_pix_format_mplane)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int get_v4l2_vbi_format(struct v4l2_vbi_format *kp, struct v4l2_vbi_format __user *up)
-{
-	if (copy_from_user(kp, up, sizeof(struct v4l2_vbi_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int put_v4l2_vbi_format(struct v4l2_vbi_format *kp, struct v4l2_vbi_format __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_vbi_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int get_v4l2_sliced_vbi_format(struct v4l2_sliced_vbi_format *kp, struct v4l2_sliced_vbi_format __user *up)
-{
-	if (copy_from_user(kp, up, sizeof(struct v4l2_sliced_vbi_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int put_v4l2_sliced_vbi_format(struct v4l2_sliced_vbi_format *kp, struct v4l2_sliced_vbi_format __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_sliced_vbi_format)))
-		return -EFAULT;
-	return 0;
-}
-
 struct v4l2_format32 {
 	enum v4l2_buf_type type;
 	union {
@@ -184,20 +126,23 @@ static int __get_v4l2_format32(struct v4
 	switch (kp->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
-		return get_v4l2_pix_format(&kp->fmt.pix, &up->fmt.pix);
+		return copy_from_user(&kp->fmt.pix, &up->fmt.pix,
+				      sizeof(kp->fmt.pix)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		return get_v4l2_pix_format_mplane(&kp->fmt.pix_mp,
-						  &up->fmt.pix_mp);
+		return copy_from_user(&kp->fmt.pix_mp, &up->fmt.pix_mp,
+				      sizeof(kp->fmt.pix_mp)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
-		return get_v4l2_window32(&kp->fmt.win, &up->fmt.win);
+ 		return get_v4l2_window32(&kp->fmt.win, &up->fmt.win);
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 	case V4L2_BUF_TYPE_VBI_OUTPUT:
-		return get_v4l2_vbi_format(&kp->fmt.vbi, &up->fmt.vbi);
+		return copy_from_user(&kp->fmt.vbi, &up->fmt.vbi,
+				      sizeof(kp->fmt.vbi)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
 	case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
-		return get_v4l2_sliced_vbi_format(&kp->fmt.sliced, &up->fmt.sliced);
+		return copy_from_user(&kp->fmt.sliced, &up->fmt.sliced,
+				      sizeof(kp->fmt.sliced)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_PRIVATE:
 		if (copy_from_user(kp, up, sizeof(kp->fmt.raw_data)))
 			return -EFAULT;
@@ -232,20 +177,23 @@ static int __put_v4l2_format32(struct v4
 	switch (kp->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
-		return put_v4l2_pix_format(&kp->fmt.pix, &up->fmt.pix);
+		return copy_to_user(&up->fmt.pix, &kp->fmt.pix,
+				    sizeof(kp->fmt.pix)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		return put_v4l2_pix_format_mplane(&kp->fmt.pix_mp,
-						  &up->fmt.pix_mp);
+		return copy_to_user(&up->fmt.pix_mp, &kp->fmt.pix_mp,
+				    sizeof(kp->fmt.pix_mp)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
 		return put_v4l2_window32(&kp->fmt.win, &up->fmt.win);
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 	case V4L2_BUF_TYPE_VBI_OUTPUT:
-		return put_v4l2_vbi_format(&kp->fmt.vbi, &up->fmt.vbi);
+		return copy_to_user(&up->fmt.vbi, &kp->fmt.vbi,
+				    sizeof(kp->fmt.vbi)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
 	case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
-		return put_v4l2_sliced_vbi_format(&kp->fmt.sliced, &up->fmt.sliced);
+		return copy_to_user(&up->fmt.sliced, &kp->fmt.sliced,
+				    sizeof(kp->fmt.sliced)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_PRIVATE:
 		if (copy_to_user(up, kp, sizeof(up->fmt.raw_data)))
 			return -EFAULT;
@@ -544,10 +492,10 @@ static int get_v4l2_framebuffer32(struct
 	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_framebuffer32)) ||
 	    get_user(tmp, &up->base) ||
 	    get_user(kp->capability, &up->capability) ||
-	    get_user(kp->flags, &up->flags))
+	    get_user(kp->flags, &up->flags) ||
+	    copy_from_user(&kp->fmt, &up->fmt, sizeof(up->fmt)))
 		return -EFAULT;
 	kp->base = (__force void *)compat_ptr(tmp);
-	get_v4l2_pix_format(&kp->fmt, &up->fmt);
 	return 0;
 }
 
@@ -558,9 +506,9 @@ static int put_v4l2_framebuffer32(struct
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_framebuffer32)) ||
 	    put_user(tmp, &up->base) ||
 	    put_user(kp->capability, &up->capability) ||
-	    put_user(kp->flags, &up->flags))
+	    put_user(kp->flags, &up->flags) ||
+	    copy_to_user(&up->fmt, &kp->fmt, sizeof(up->fmt)))
 		return -EFAULT;
-	put_v4l2_pix_format(&kp->fmt, &up->fmt);
 	return 0;
 }
 
