Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859260-1522261012-2-10315040914595116894
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
    t=1522261011; b=oyP1mUJXTLHMOs7ou2gy7na6Vsq8tm2Uw/g8fHN7r/k7eNN
    T9kjxKiBTLHZFU4FlYANQeH2NXsupi2Z46z/KLUgPwIQIafHsxLyzSRDYWsChq71
    m4kjVnUtJA50a8eHMP6eB7He3hSB2JC+YtSnui8O20KHxtc3GqMVF9R3KYJy7SNz
    V5iKpmHqRaCRUe4ZnluBEUuzkUozF6wd/0RpH6ZwwbRX/JgKO6R0VK+1WVE4zUYm
    WmrUubRlz6DD1XnbhrCW7Vnjj7Wn2bp4PAaoTmKsEU+7zpuNWVkApvFqf+aNO+Ci
    6DfN9ChCYqjJ29vOVQZM6wBuLYzDSutBnIX0f1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522261011; bh=XdoEccHos5iYCK0Dvf83yzRb+6eOqZncyHf
    xzyegB9U=; b=Imy7Oz603xO9rzvhrCKvZ9ugSqmFUGS/FWeYh4uUtVSD5KRxWa4
    X58vbxKexzIQKKP7cx053YspBnIK3nLvYrzGoivczj4ISTzfYtluGpi4Sf6d56fi
    YUXAZpigsQZ7dxy23K4BWubXYwxQbbaSi8aOBBmwfkqJLN54a3Vt/0rSVBbbdiqk
    P1f1gtaAWA7H9rCZmYO8J5ueOtSx/DnFDLOpt0R8PpgpLaMDGTFUc/AGA3GB5QxR
    PBAph4tDvyQeXIDnTv9/p3M4I/I1Yk9d7XqlWElhKKZl9h62qHcTNsZqF9EUvbLL
    hw8Jxo5Tgah2iMxEwJ10psI6205KTtnHp6g==
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
X-CM-Envelope: MS4wfMADn3BTXrqe9AmgLZXBdfA4WezYkN9WcKzQZngLIs3dPvhB+YNcIX9a+54tO6ECMSOfOqvPLcQWxAhmxYjPsYqM047IWEMB//66g2cJON7p6mJIt7bg
    DzSBkgWP9h4dzMLA+qWC0vyR18WDeJT0crK4HQpeqSMPNbxxeyzYYopKQdGHt8Zais5K8EuyxzNTMCIJy+0WMdSbazXd38iQ4nn+LTwWpVFkFZVkAz+DJbd5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=AUd_NHdVAAAA:8
    a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=HmFkGaIbrh1Njhl5kuoA:9
    a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeC1SQe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:16:34 -0400
Received: from osg.samsung.com ([64.30.133.232]:43875 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753531AbeC1SND (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:13:03 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH for v3.18 11/18] media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
Date: Wed, 28 Mar 2018 15:12:30 -0300
Message-Id: <b203ca17a23bf02398ef39e8f123d30b74df3523.1522260310.git.mchehab@s-opensource.com>
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

commit a751be5b142ef6bcbbb96d9899516f4d9c8d0ef4 upstream.

put_v4l2_window32() didn't copy back the clip list to userspace.
Drivers can update the clip rectangles, so this should be done.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 61 ++++++++++++++++++---------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index fd32c9ccc2bb..8a5c93ce4348 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -50,6 +50,11 @@ struct v4l2_window32 {
 
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
@@ -59,38 +64,54 @@ static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user
 		return -EFAULT;
 	if (kp->clipcount > 2048)
 		return -EINVAL;
-	if (kp->clipcount) {
-		struct v4l2_clip32 __user *uclips;
-		struct v4l2_clip __user *kclips;
-		int n = kp->clipcount;
-		compat_caddr_t p;
-
-		if (get_user(p, &up->clips))
-			return -EFAULT;
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
+	if (!kp->clipcount) {
 		kp->clips = NULL;
+		return 0;
+	}
+
+	n = kp->clipcount;
+	if (get_user(p, &up->clips))
+		return -EFAULT;
+	uclips = compat_ptr(p);
+	kclips = compat_alloc_user_space(n * sizeof(*kclips));
+	kp->clips = kclips;
+	while (n--) {
+		if (copy_in_user(&kclips->c, &uclips->c, sizeof(uclips->c)))
+			return -EFAULT;
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
 
-- 
2.14.3
