Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519833271-2-8929732907612983995
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833271; b=ElF+D6RHzK2G1R8ovxoTn2ldjcr1OA78VAsptPHFMNSVlxv
    dk5F8Hgvov3B5cd77RUlQGHZpYAQrZc6I8B7YR/lOWrs82oujlZ6ffUBWNR+oCJJ
    Q3jPsjw0rOsFbqcMSh9eVHmKDojoYeiTeeSbg/7IwU8KZvF6ypz8JrnM5qcjNTt2
    xn2pqDZPGytYTrWa+vEK/WNAQdeslQcf3m5ROi/3CwKKk9TM+kKxpf2Ey6AXg3Dl
    o6TiyXnwqR+SN28WYs0SLiAB2RiObNBgBmG7XV1tTh3LE+xD147Bf62f2a6Q+zwK
    /+/eUDUSkU9xIxj0/tnRc4mv5RZkFYDKeY02vjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833271; bh=wC7Y2Tzx/77Xnk6FuQ0
    AdfX9m52ihDKEyxrBK6UVifA=; b=txvSAZfiptQ2bqULv0Lr97PY5+0k0+eQ37I
    6YK7D9iD/QaIeTro2JShgIR+C+pAEckalWv+UohNitUyT4j+TUKtfMo9JT1cOxs1
    H8mb+VgDmFA6/AnVfa39EdacrnCRSsSOWQk7HO+knBDwlQFdiwUljUh3YxcVNk82
    DDFNwbiUGtHNQqGy88neroVipyAQet/X3VjXb/s0IOzUneO3Vqy+MaTfgkCJkD+O
    om5nfg2+TSKbtY8wJLSjfbB9sG5b0usCSVYJmaNDbQOYGZNcMRqrpQt2vCKdbPTW
    cFBBSE4NJ4Cj0DhASVHANBJUCy2URxaohXGgnNUdHlmu7qUMT1Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932966AbeB1Py2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:54:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34459 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933777AbeB1Pxd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:53:33 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@osg.samsung.com>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.185997385@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 236/254] [media] V4L2: fix VIDIOC_CREATE_BUFS 32-bit
 compatibility mode data copy-back
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

commit 6ed9b28504326f8cf542e6b68245b2f7ce009216 upstream.

Similar to an earlier patch, fixing reading user-space data for the
VIDIOC_CREATE_BUFS ioctl() in 32-bit compatibility mode, this patch fixes
writing back of the possibly modified struct to the user. However, unlike
the former bug, this one is much less harmful, because it only results in
the kernel failing to write the .type field back to the user, but in fact
this is likely unneeded, because the kernel will hardly want to change
that field. Therefore this bug is more of a theoretical nature.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -222,6 +222,9 @@ static int get_v4l2_create32(struct v4l2
 
 static int __put_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 __user *up)
 {
+	if (put_user(kp->type, &up->type))
+		return -EFAULT;
+
 	switch (kp->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
@@ -248,8 +251,7 @@ static int __put_v4l2_format32(struct v4
 
 static int put_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_format32)) ||
-		put_user(kp->type, &up->type))
+	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_format32)))
 		return -EFAULT;
 	return __put_v4l2_format32(kp, up);
 }
@@ -257,8 +259,8 @@ static int put_v4l2_format32(struct v4l2
 static int put_v4l2_create32(struct v4l2_create_buffers *kp, struct v4l2_create_buffers32 __user *up)
 {
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_create_buffers32)) ||
-	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format.fmt)))
-			return -EFAULT;
+	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format)))
+		return -EFAULT;
 	return __put_v4l2_format32(&kp->format, &up->format);
 }
 
