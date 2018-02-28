Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519839885-2-3864031202464425499
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
    t=1519839885; b=gZ227qxDuHsT3zbxRgPsXggU9W0HQxe3LOReo3rBiCr/XfS
    C6/VCkOgzUHsoFniwh93+i4j8RvrT/DcJ6E9QFLMHzDRvYUDDI+jS7bhn/iUY56t
    TiflrzDvgQr6fHmGURQtEdWqmLTb3W4Xltu/HJEnT9Ny5s6KSmnvw5ycf8LR4SRu
    SrBv9/8TGG4wAYQF523ep5VKDrD3Ggd1K9wC0Me4gzd+D/KDgvEAcVDTf46awlht
    zF70CqARZKa5QCzLJr9sk/wkn0HD5vB+gczJ9tHHjic4rCZ9Mtp2E72vS7iNnaok
    3jSuLHvJi4hgjmiSuu1jP7A8J8yIFw8alPyBbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839885; bh=VN/6HTpl/QEbEGHc/6J
    /NVMN3qyIUvSi6qqLfQX/hiU=; b=XL5o/kuu922cV0OY8V8YggafDYfEvOwwASV
    nrltJCjuDLaakp/dt652gc+dxIvD+R+Snek0+fLi5RHWNkl9xl3/QGywCYPYp272
    sTuKm47vio0GdIqPCcR2N/GMWXPro2ZaSyOTa4XQcvCme6bmJqrqcmxe2Zw4CsaL
    J2Y+sc3mUAery8VLUVtOxeVCbUjbeRtnlmhDA9S+4Mgqkm5vmugw4Y0hTOsdOFzT
    lK4Y3XjSsKhGvLoLKt4qgKj6JqWKyyIJ5ub/HkyKFl/L1PFL0vXUr2/3e7t3PObB
    3M7mLSadqkkwT//3iHci9bfoSrKufcGyAovccuolEOk+Vb+ny1g==
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
        id S932318AbeB1Ron (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:44:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33115 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932481AbeB1PWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.739962224@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 135/140] media: v4l2-compat-ioctl32.c: copy clip  list
 in put_v4l2_window32
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

commit a751be5b142ef6bcbbb96d9899516f4d9c8d0ef4 upstream.

put_v4l2_window32() didn't copy back the clip list to userspace.
Drivers can update the clip rectangles, so this should be done.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/video/v4l2-compat-ioctl32.c | 59 +++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 19 deletions(-)

--- a/drivers/media/video/v4l2-compat-ioctl32.c
+++ b/drivers/media/video/v4l2-compat-ioctl32.c
@@ -51,6 +51,11 @@ struct v4l2_window32 {
 
 static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
 {
+	struct v4l2_clip32 __user *uclips;
+	struct v4l2_clip __user *kclips;
+	compat_caddr_t p;
+	u32 n;
+
 	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
 	    copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
 	    get_user(kp->field, &up->field) ||
@@ -60,38 +65,54 @@ static int get_v4l2_window32(struct v4l2
 		return -EFAULT;
 	if (kp->clipcount > 2048)
 		return -EINVAL;
-	if (kp->clipcount) {
-		struct v4l2_clip32 __user *uclips;
-		struct v4l2_clip __user *kclips;
-		int n = kp->clipcount;
-		compat_caddr_t p;
+	if (!kp->clipcount) {
+		kp->clips = NULL;
+		return 0;
+	}
 
-		if (get_user(p, &up->clips))
+	n = kp->clipcount;
+	if (get_user(p, &up->clips))
+		return -EFAULT;
+	uclips = compat_ptr(p);
+	kclips = compat_alloc_user_space(n * sizeof(*kclips));
+	kp->clips = kclips;
+	while (n--) {
+		if (copy_in_user(&kclips->c, &uclips->c, sizeof(uclips->c)))
 			return -EFAULT;
-		uclips = compat_ptr(p);
-		kclips = compat_alloc_user_space(n * sizeof(*kclips));
-		kp->clips = kclips;
-		while (--n >= 0) {
-			if (copy_in_user(&kclips->c, &uclips->c, sizeof(uclips->c)))
-				return -EFAULT;
-			if (put_user(n ? kclips + 1 : NULL, &kclips->next))
-				return -EFAULT;
-			uclips += 1;
-			kclips += 1;
-		}
-	} else
-		kp->clips = NULL;
+		if (put_user(n ? kclips + 1 : NULL, &kclips->next))
+			return -EFAULT;
+		uclips++;
+		kclips++;
+	}
 	return 0;
 }
 
 static int put_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
 {
+	struct v4l2_clip __user *kclips = kp->clips;
+	struct v4l2_clip32 __user *uclips;
+	u32 n = kp->clipcount;
+	compat_caddr_t p;
+
 	if (copy_to_user(&up->w, &kp->w, sizeof(kp->w)) ||
 	    put_user(kp->field, &up->field) ||
 	    put_user(kp->chromakey, &up->chromakey) ||
 	    put_user(kp->clipcount, &up->clipcount) ||
 	    put_user(kp->global_alpha, &up->global_alpha))
 		return -EFAULT;
+
+	if (!kp->clipcount)
+		return 0;
+
+	if (get_user(p, &up->clips))
+		return -EFAULT;
+	uclips = compat_ptr(p);
+	while (n--) {
+		if (copy_in_user(&uclips->c, &kclips->c, sizeof(uclips->c)))
+			return -EFAULT;
+		uclips++;
+		kclips++;
+	}
 	return 0;
 }
 
