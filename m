Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2888441-1522261040-2-11769319677298318041
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
    t=1522261031; b=KzkuQdCSVO1GQd01FRgriYIT+ORvOCghTtkXJYxeh/mCzsv
    1SSvThKvCBboscl3dYW3j5j/u836Szb2Mmuhm5MAMwjl9F5GPLLIBTh9x02j38F6
    QEC/f1VTJp1nQf+VUxCxpxD621OF6acrqpCLezQiPmr8UrJCPS4YV/Oftn3bfIQ7
    0qmycBRNwCY50+Kk/guJSg5DBVPkzS+GV9vFAS70xIx86jITKKOiuWttEjBSplo9
    b3ZnF5GRGhhU/qbCuu7PZF4nQmM8zoP3d9Yr2FkF1P1LiUWI+9yceTT7/OhOrtrX
    P1j9BeuLDJMbRurBGtUMnKBoKpISTJMwX5lVqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522261031; bh=9hujvyoYN0eSRrrw8KypHsr2Pm7RGIoJcG6
    su58IBWc=; b=rQQJXJX1Rf9DkkrZ958G6ysdQ86wVIygeG1akgyfXRTngRqqClj
    XvULUovRhZ4/6aZ2bwLDu7BvQygN5uH8iIjpc1MTcn52LXRPlWrIpxTJ0JeCEnvu
    hEt2mDDq6KUn71a9qpYg/YvTfT6LmZD/nker44N7zz8yIZyq77w6rkXrMdFQlV/b
    sFQrwOHCVOI+Dvda7ATRvsVeUbPjh0ZSgm4Nb/kny5OFB0vYdWXK79mkwBnRHPiZ
    y2gwQhgLp1zogUa7eX+le9WK2yZyOgPd+clcihI1XHdFoYVe8LLTtxxjgTe8dcgH
    I4lxNd7f+aMLEt1qTNhDGAc/Cjal69lPM8Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfNXfzlC6NWOgKvEypQ//zDR7tiJd5VWLCNtNlyZEF86R6r365Vm/12fkUHAOrNjdwgXyBovSYFORAySlo3fDesqepFffXUMrx8/LUpGZ2vVtYh6NxB3a
    IAdNbw/icITYTQ/pEg/2QWfY68lIrNSpI1YkiWkIR33aWa9qiX5oxDtR07ty1uE+k3IKzRnQGrICco/59M43oX9kYqMIzVdMDw3PR1IyyzFl3merA957JJgf
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=1XWaLZrsAAAA:8
    a=AUd_NHdVAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=0wRqj8XfqH6-D3P0PDsA:9
    a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeC1SNB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:13:01 -0400
Received: from osg.samsung.com ([64.30.133.232]:34698 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753141AbeC1SM5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:12:57 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Daniel Mentz <danielmentz@google.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH for v3.18 10/18] media: v4l2-compat-ioctl32: Copy v4l2_window->global_alpha
Date: Wed, 28 Mar 2018 15:12:29 -0300
Message-Id: <63c220c11ade842157669d03bdaf10b84a6d91a9.1522260310.git.mchehab@s-opensource.com>
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

From: Daniel Mentz <danielmentz@google.com>

commit 025a26fa14f8fd55d50ab284a30c016a5be953d0 upstream.

Commit b2787845fb91 ("V4L/DVB (5289): Add support for video output
overlays.") added the field global_alpha to struct v4l2_window but did
not update the compat layer accordingly. This change adds global_alpha
to struct v4l2_window32 and copies the value for global_alpha back and
forth.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index bd4890769e0b..fd32c9ccc2bb 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -45,6 +45,7 @@ struct v4l2_window32 {
 	compat_caddr_t		clips; /* actually struct v4l2_clip32 * */
 	__u32			clipcount;
 	compat_caddr_t		bitmap;
+	__u8                    global_alpha;
 };
 
 static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user *up)
@@ -53,7 +54,8 @@ static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user
 	    copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
 	    get_user(kp->field, &up->field) ||
 	    get_user(kp->chromakey, &up->chromakey) ||
-	    get_user(kp->clipcount, &up->clipcount))
+	    get_user(kp->clipcount, &up->clipcount) ||
+	    get_user(kp->global_alpha, &up->global_alpha))
 		return -EFAULT;
 	if (kp->clipcount > 2048)
 		return -EINVAL;
@@ -86,7 +88,8 @@ static int put_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 __user
 	if (copy_to_user(&up->w, &kp->w, sizeof(kp->w)) ||
 	    put_user(kp->field, &up->field) ||
 	    put_user(kp->chromakey, &up->chromakey) ||
-	    put_user(kp->clipcount, &up->clipcount))
+	    put_user(kp->clipcount, &up->clipcount) ||
+	    put_user(kp->global_alpha, &up->global_alpha))
 		return -EFAULT;
 	return 0;
 }
-- 
2.14.3
