Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834436-2-11599693492770901875
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834435; b=cUV46dWqAqf0ofT/OP2yW+nqmeFb4m5n/VMCiJhCBLBcjKS
    tSi20ynMnExnqb+EG8suGtU1a0bLdEn0DcycNT9q1faiCj194yrdBPlFc1NoIrhB
    Lgpt/mz9qQ48PsL+eYuqS99BqczClBa+iRq1eBzaPqlWn/hrvqrKrWlnSk8F1sA7
    g8mrjTTZlGFrB/pkzO/PaeIGJSr3Uu7nqIOD4GyyYxyunLLYpb7fyCtsS3aWmhyd
    0O+0POQbmbzYX/6LULKGnb3r9kR2F4NH6yMRybm0qN3zwFqCEL1UognVwdsjAVa2
    7opaPMwjNZaPFoqGQhaPfsEjz6XrncsQ19FBD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834435; bh=VZZut6chTjyUg+mhYC1
    n+HwiFEwyrI8J9sfl8qwKY10=; b=d9YA5LD0FVNbuBqdKb0BsjSFeAvlnoE6Pu5
    Y7oNKcC5SKlRLIJt953Z3Ib83tZPnlD2LS9evn/OfHmp7A/shDfSJMfEtk1N7R8k
    UJkN0tNC4lQnpK0KxMWQims4BVOjqtQRua8901x8jDr0vt1aR9/j/hT4ez2MwT/c
    PSjbeUJh3UPvQTFVoB6HoruGcoX/t8t8Mhyuup8xi6hexSwexPlUCcUO06cGi9w8
    s7YAyCabqVRK5lQhY+RFYUfe9ClWFR7aScpr0HQ1qMpxd+YCsCZh3BuTOtTjiKFM
    AyoYmabtc4zO0zZb0BgYGArPvWCbwQXeKILza1QfB9OL0TTOMRQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932298AbeB1QNw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:13:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35071 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932383AbeB1QNv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:13:51 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        "Mauro Carvalho Chehab" <mchehab@osg.samsung.com>,
        "Hans Verkuil" <hans.verkuil@cisco.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.112261708@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 237/254] [media] media: v4l2-compat-ioctl32: fix
 missing reserved field copy in put_v4l2_create32
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

From: Tiffany Lin <tiffany.lin@mediatek.com>

commit baf43c6eace43868e490f18560287fa3481b2159 upstream.

In v4l2-compliance utility, test VIDIOC_CREATE_BUFS will check whether reserved
filed of v4l2_create_buffers filled with zero
Reserved field is filled with zero in v4l_create_bufs.
This patch copy reserved field of v4l2_create_buffer from kernel space to user
space

Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -259,7 +259,8 @@ static int put_v4l2_format32(struct v4l2
 static int put_v4l2_create32(struct v4l2_create_buffers *kp, struct v4l2_create_buffers32 __user *up)
 {
 	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_create_buffers32)) ||
-	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format)))
+	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format)) ||
+	    copy_to_user(up->reserved, kp->reserved, sizeof(kp->reserved)))
 		return -EFAULT;
 	return __put_v4l2_format32(&kp->format, &up->format);
 }
