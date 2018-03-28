Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859260-1522260879-2-17344963365843175057
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
    t=1522260878; b=wGQSNxatcD0pswWC7yICO0un8nIATwszGCqsgn4/C4uAc16
    IebO8dV1A/+jT6ZabMIuM7qzvGHVfDcBMIwftr/qFlzGZeuxG329YlabhueiEQ0I
    KdHhBPr9WcYp5NtZv5+jzDsLo9azGspiih8K64LxI3sZg7xY/t8k2REHOWEJEq7M
    4bPVF/Xk0nMIVlM7Qr5BmhXNbfUlFJcpFOLxxYsXBLeXJhVESfWdnAhSDcjKXU7+
    x30mL/BGI49SPZD5ohP4166HsUVp/QYZzCMp/wwimn7JTPrrWIO3FJbwxI7TakBq
    iyAEvb+l0p8wF3kVeGCTyJTZRzehuAxCpr7Uliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522260878; bh=+2LlCH7MMhN7ts61n+4KgYBGBqakoPVk6QC
    ZScpNmFY=; b=XlmA00ML507D8hpYx4W4u7wB6PUB+As1S5EYezox8w9XROeN5CS
    aK/prz69q0TRarbZ5Wl1s7Gr6gJkD2gxIA6cskdpjbHGgvTXyGC+5AooK8GlzlFV
    nfo+c9HnBa2CNgunO3wXowb3q1rfddmJaQ+bUwpH1yT1FP9RX4K9DCsmKCAH5ZgL
    m4qFGMuNA7KDVbInDaBrzWc0PlbDN3XDhPB2l7A37mvYAlksPKTV7LAvacJLELr1
    +HF4H0RhCV3KaO6dV63QVxhALdFTlaqZuuFtDnCs+6/cCT/mgblWJxqIde0nl5sg
    5ZdgLOMXNJExcrAxlMJ+PNffe/VebNAeImw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfNmRYywoipZP0yLYmjergtKFwGSwJ8JOuIn1jH8u7v9y9hDMqDoDlk4HenJu4i5F6WJYjOu3Z1e1HryB8TRYVYoFs5mifh9lRalDEF/USdlGEUbMID+F
    wtc7lbDQt0a+230BTk08r3acVB3AAatv8nFOAKltbE154dLvcAkONpM+9MarIRMlDHuGtY7cFvkH0JkecdoezdWjFv1oKI/c2/ye2qMRUi3dsWWSQlnJY6eb
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=AUd_NHdVAAAA:8
    a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=e2e2kAKvei7LNm6H0eYA:9
    a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753871AbeC1SO3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:14:29 -0400
Received: from osg.samsung.com ([64.30.133.232]:36053 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753607AbeC1SNR (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:13:17 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH for v3.18 12/18] media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
Date: Wed, 28 Mar 2018 15:12:31 -0300
Message-Id: <8f000de7f9babd3f104eacbd7e79fbd72372c9d1.1522260310.git.mchehab@s-opensource.com>
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

commit 169f24ca68bf0f247d111aef07af00dd3a02ae88 upstream.

There is nothing wrong with using an unknown buffer type. So
stop spamming the kernel log whenever this happens. The kernel
will just return -EINVAL to signal this.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index 8a5c93ce4348..a5f74a508f58 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -170,8 +170,6 @@ static int __get_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 __us
 		return copy_from_user(&kp->fmt.sliced, &up->fmt.sliced,
 				      sizeof(kp->fmt.sliced)) ? -EFAULT : 0;
 	default:
-		printk(KERN_INFO "compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-		       kp->type);
 		return -EINVAL;
 	}
 }
@@ -214,8 +212,6 @@ static int __put_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 __us
 		return copy_to_user(&up->fmt.sliced, &kp->fmt.sliced,
 				    sizeof(kp->fmt.sliced)) ?  -EFAULT : 0;
 	default:
-		printk(KERN_INFO "compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-		       kp->type);
 		return -EINVAL;
 	}
 }
-- 
2.14.3
