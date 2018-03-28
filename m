Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2888441-1522261134-2-4418642891779787516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522261133; b=beMNZLwRqm6mD5n/pzeOqCSlS45xw1+Eiie0LD3GNMnbirw
    vFOiXvlZoQx5ncdybp13V6OiGbzz/T8in0UyubIh1/HICRGppFTfUtorPQA5/3G+
    u6ajPRNQYBAWGI+0NgiOMO6WidjNrRTMkklJBk52uLEBSxrX9JXcIx10q1DYFr/H
    FGTnNKdHxJtxIBLejQZOhOzXucZvniUu9QPJCavcqAQMZ4BB4Hc4aUZmyFOtn8pG
    Lx6e4T3IMev3nvVAo4ckTReQWFiKGUMfnNLunvFKhmgtlvQX+wWuYKpFJxpgesWs
    9Cf2ctQeIqb91BuCcCqfJUt3NXTu5yQzkp8wJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522261133; bh=CkMpwrNo5hkDupeZh6OclbPcS4y3QYS6Km+
    Q06+DK9A=; b=u0E/jWxV86pZaYJoHj8uJ/xHqqdYJ9ld7vvg8xVYHjXU33LgexA
    sWyXIrn/l5PFT145TMlxVkIYPSEU5OW9LiixHaIJNptdyMZnXsnpgsbrSNUcpmIi
    XIruczr1IyRP0puIZABh6lA7lJeghQUe3tBlwUMA/AliJdJmkHp0lSy1edyb53Qv
    iY//MOF8WwANQi/hIJU2xEGZLz8aZX+37kZhcpm0dOzPBHXijYoCCgW33RhUan94
    u3sP8tQky2kRN1/iDAVYklg/fRRPK3aoCx0oiTjZje3wZmhHoY6CJwy8sQyfjl/6
    091jLgLpdfTpmJPDLb0whUWICGSxOe4meiQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfMuoOLbCah6aHzTWOsfE9OR45sfuSKXpdJKOuvDI7aWVNJY3CoI/uP/qst4nU0Q8DD3DYGvXbeBzWu0G40jg43qdHbY2zbnrx64N8+u7jFJ/tMHW0VIa
    BLbWSDPmPO0ZqFdsb5PfKAsjEESZBoGLRdGvOFm+VTWcvWEt0jmLt9ptmW0Wfik3S3EeXcnPKixEM9Vs4uOkovUDShHrrW53iI2sgKB4HcmfV2Tyk/Z2mY07
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=AUd_NHdVAAAA:8
    a=QyXUC8HyAAAA:8 a=P1BnusSwAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8
    a=2BAZI-xr0tr88uGGf80A:9 a=D0XLA9XvdZm18NrgonBM:22 a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753315AbeC1SMv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:12:51 -0400
Received: from osg.samsung.com ([64.30.133.232]:49062 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752318AbeC1SMs (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:12:48 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH for v3.18 09/18] media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
Date: Wed, 28 Mar 2018 15:12:28 -0300
Message-Id: <39d6997be9988f81bce42a00115b062aac7b0a51.1522260310.git.mchehab@s-opensource.com>
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

From: Hans Verkuil <hansverk@cisco.com>

commit 273caa260035c03d89ad63d72d8cd3d9e5c5e3f1 upstream.

If the device is of type VFL_TYPE_SUBDEV then vdev->ioctl_ops
is NULL so the 'if (!ops->vidioc_query_ext_ctrl)' check would crash.
Add a test for !ops to the condition.

All sub-devices that have controls will use the control framework,
so they do not have an equivalent to ops->vidioc_query_ext_ctrl.
Returning false if ops is NULL is the correct thing to do here.

Fixes: b8c601e8af ("v4l2-compat-ioctl32.c: fix ctrl_is_pointer")

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index c78462e79a0a..bd4890769e0b 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -600,7 +600,7 @@ static inline bool ctrl_is_pointer(struct file *file, u32 id)
 		return ctrl && ctrl->is_ptr;
 	}
 
-	if (!ops->vidioc_query_ext_ctrl)
+	if (!ops || !ops->vidioc_query_ext_ctrl)
 		return false;
 
 	return !ops->vidioc_query_ext_ctrl(file, fh, &qec) &&
-- 
2.14.3
