Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1387311-1523021270-2-14331005554975757563
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021269; b=SSa3AQ1iXHdeiOF7X1An1Ull51cXDzis73KTeoblpG89+O3Vrk
    QQ+VpwWhrCLfwp5OctnSETFnhJlC1USjSvBkA8XmcQz30NTlH/QbNGQZoVSsHcaK
    mSPjOv498JT373gPc67eVs2GQF/NVRd9XZifiSuP7qUyejM3HJkRXiuPNO5yRsOV
    FQvt1UOQPo6AnEE+kOvY21xqelEsAf7HeKbK1UOqhwYjP/8J/JJWpY/6JJf8nt1D
    ugzXchpq3HZgmViM6v+e9twRWKq+Y+0I5wC88o9KRS3X8BA2zZMkZa3qp9q+Yz95
    knfZnmMmd4Jquu2l3kc+IXNf/pyyJIumq7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021269; bh=QQRpD0uBv5ABIMADyABqhOqQKUBqj1
    RD7MLVf0JdXdo=; b=Y79QJnLWCUWW1hiwGH5+1FVt34TWAMyP+SHFKCh/gK8shJ
    VWPtw5/NkABAGlGsyh2xZAZHHjDoNKOSp7C2+dV9qfIGpZhjI9JIkF9VApreO8U1
    8jH3pF1ZtH8klBO6nfS3j9AIeJ7lv+P08rehL5m3TKgI6Y0iDbCoNMxPOUepTQey
    GoSo6jiSveBfg6rbCVvB4LNejrckG3oclEfagzROWArvkW5/F5avez7RtPT4vlPA
    cB7Z/6ojQzsChAjbHtUhJvkrLlORQXC2QQBoIS+d+VT4vAhfdwXdA2n/JAAanNd2
    dgCzdmBjYhoLLvxoRwb4eyfEYPsh8Vxz+V9UXCww==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfLGPS38TICMhWlc0MaigcpPgLxuXxv+qQizI81zmWfkd1ZOU+d5jHRH9aUpf4+Ii0opgZPh2rs34EMovQyxXA0KjBtqABoz1r8b/cHgrzErqbEWNMuCT
    zBNrAEh5X0C6D8xvzEhq73jPji3e4VAmOrCvs8uzgae6rgKGHRiwN0tFWoY/7Lew/jZhHjyI6rxfq9Lt9rzSSoaWZpGBvmOsLeOpT4WDRoA1FdaTattCIGOt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AUd_NHdVAAAA:8 a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=2ZXKIj1bwk7JC2v9oDAA:9 a=QEXdDO2ut3YA:10
    a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753032AbeDFN1r (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:27:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753061AbeDFN1p (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:27:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 67/93] media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
Date: Fri,  6 Apr 2018 15:23:36 +0200
Message-Id: <20180406084227.916453468@linuxfoundation.org>
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

commit a751be5b142ef6bcbbb96d9899516f4d9c8d0ef4 upstream.

put_v4l2_window32() didn't copy back the clip list to userspace.
Drivers can update the clip rectangles, so this should be done.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |   59 +++++++++++++++++---------
 1 file changed, 40 insertions(+), 19 deletions(-)

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
@@ -59,38 +64,54 @@ static int get_v4l2_window32(struct v4l2
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
 
