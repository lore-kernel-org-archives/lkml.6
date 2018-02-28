Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519839467-2-305523208506049412
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
    t=1519839466; b=gBksJ4OngV6JHxydyTjrYEmYt7XqGRaLZZ1A0sxHNHU98fZ
    T+pWhcvuTi4O57Crq8gCwR+ngwqj+UFK+EDHTqChzzN8HpfSNdyKygseSATsgouk
    F7oNQP207Y6KqDjo27CT+ztie0WFh6XwSB5RLWtYp53hCVj4F6tuWN/+XvBweNGB
    TjFwyiY0v2tBR9sMG6BWlLgJyYwu6krm6vCPZIDocgkHw/+b9MAH2HeV/qsv1gCm
    2PCmC8mL7S843Dr3kbiewLEXTR8fLDcr1Gx+9SSdunSiB9bAcO0ZDVW2dGipYmDp
    ZS/IG3bsjQIwfpi2WVkrksVdofeZzt7uAE8lR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839466; bh=KYlA8kOiHKn3w4adDXW
    0+FTJ/Z+eN4RsyMpJR3o41vU=; b=L5NBx700WpBzmXc6x4/Vy+al6pBUCYYnMvy
    JBZgOyKkJv87JqL34Ol70+5VdE/S+WKX8w0Zrv2sLarRIcfhCdpADXMu3OiinVIz
    09RSKybnqUEl86sBI/gxCV+nlS/XVwUbmMeV4dnQZtUNOPasTlmyw/G+SoCTDS0Y
    Wje3H5b/nk/rV8IETqHdfCnPW3skx1haKNudb28kNyIpCS2tKtt0ONEcgneW5m6S
    9QcUtW+AXOgy60DsM1rzjtBuymTWod1U9jjmtvpildRf2OFyaMrn1L8zLLQhlk3x
    EsmGg/BKWSA604f3RMaaqWM1VdoJ09FEgoVGi6RjfZTn1B9WEbA==
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
        id S932961AbeB1Rg2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:36:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33173 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932532AbeB1PWO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>,
        "Mauro Carvalho Chehab" <mchehab@osg.samsung.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.490269691@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 123/140] [media] V4L2: fix VIDIOC_CREATE_BUFS 32-bit
 compatibility mode data copy-back
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
[bwh: Backported to 3.2: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/video/v4l2-compat-ioctl32.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/media/video/v4l2-compat-ioctl32.c
+++ b/drivers/media/video/v4l2-compat-ioctl32.c
@@ -226,6 +226,9 @@ static int get_v4l2_create32(struct v4l2
 
 static int __put_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 __user *up)
 {
+	if (put_user(kp->type, &up->type))
+		return -EFAULT;
+
 	switch (kp->type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
@@ -256,8 +259,7 @@ static int __put_v4l2_format32(struct v4
 
 static int put_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_format32)) ||
-		put_user(kp->type, &up->type))
+	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_format32)))
 		return -EFAULT;
 	return __put_v4l2_format32(kp, up);
 }
@@ -265,8 +267,8 @@ static int put_v4l2_format32(struct v4l2
 static int put_v4l2_create32(struct v4l2_create_buffers *kp, struct v4l2_create_buffers32 __user *up)
 {
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_create_buffers32)) ||
-	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format.fmt)))
-			return -EFAULT;
+	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format)))
+		return -EFAULT;
 	return __put_v4l2_format32(&kp->format, &up->format);
 }
 
