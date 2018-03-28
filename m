Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2888441-1522260927-2-638642357480909837
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522260926; b=EmPmmbA7sZK0omggrinmpNQaSSvPB/DfkqjtSQOfa4oTB87
    4SznU/cY5rkXuIX4jS1OU5QbCzSIYidgt0iGfo5s0X6/rF6JfkTqK6Am+gob4/mB
    pwab9BTryJHsEbr1lnegxs2S0TPH+qZ5ad296BFttjfFdYzImuQaIpwUdfAJmHvM
    7upAEWIH9z5wcnMFib/e7E8NA29l5Bq0JtPfYx5VnOkn4skGRxR0MB1pK3J+WT80
    76oq4E2A4TNAeQPQ9iPllug/d1GcMUNAP9m9EjmMazoONnWKA3JXL4khkB3c5iok
    5oyadxT3Yrj/qLeY6+y4xMzSw+DYKIwV/ESH0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522260926; bh=8wM3IfifgbEu0LwVia3Bd8n08iABGE6QaWz
    BgNqsDFE=; b=jSpiGKdQcRTrTFodVNiD3RjmFmLPVxOObQy7YcPYWVnVebgX28Z
    PvZ4uZFj8lp42d8TW5IweP1SFG9YiB1xyD2nnFnL6uT5i6xVSNKy1AFuccibJyCg
    6UScoM2D6ZBkn/RXb/qIKDrNhaKjmGBZEDfkEsyox8aNscOZmjFTyAfuZ/PHZqkL
    5wNmWKw2f8jIyaTiKWVMgi18AcmbfZPvdG7r5hkZONKbILOhEtNWu7CR7w/ktOhb
    OEDhnkQZ9egK0iMbffTBrfX1nRNDf0kZ2Jf3uM2aGayXPQKAJn55/aUjP4Dxhf0q
    ycGKt38Mc7dDgOqDCXxkQjxMhhG57Ag4pCA==
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
X-CM-Envelope: MS4wfBmkJlkE3j6NwEYhC2ptScIkqw+Vp6pNl3743S/ovDonxrMQoTyBL4MoGglJmgoO2UAMd48/jFIVotAH4SGKUBi4XjHfVu9y2JEU92yyYIqaW3tqLM0D
    BeXRYgGokdLyw1AjajQa0no4sZc6pAivlCY4+oPpCF2hmdNk2FBtj3Vq+HKbnwlI+cRwDrdEX1IlcMtdCYlkDXp90gLJXiQkWnPe5RjbxCkE9ED07F3FKTKh
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=pGLkceISAAAA:8
    a=AUd_NHdVAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=XtlSBfv92ke8Y5v4JWwA:9
    a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753830AbeC1SO2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:14:28 -0400
Received: from osg.samsung.com ([64.30.133.232]:64341 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753627AbeC1SNU (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:13:20 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Ricardo Ribalda <ricardo.ribalda@gmail.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH for v3.18 02/18] vb2: V4L2_BUF_FLAG_DONE is set after DQBUF
Date: Wed, 28 Mar 2018 15:12:21 -0300
Message-Id: <9afdc5aaed16638f406ea8ee062bdee5504e32a6.1522260310.git.mchehab@s-opensource.com>
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

From: Ricardo Ribalda <ricardo.ribalda@gmail.com>

commit 3171cc2b4eb9831ab4df1d80d0410a945b8bc84e upstream.

According to the doc, V4L2_BUF_FLAG_DONE is cleared after DQBUF:

V4L2_BUF_FLAG_DONE 0x00000004  ... After calling the VIDIOC_QBUF or
VIDIOC_DQBUF it is always cleared ...

Unfortunately, it seems that videobuf2 keeps it set after DQBUF. This
can be tested with vivid and dev_debug:

[257604.338082] video1: VIDIOC_DQBUF: 71:33:25.00260479 index=3,
type=vid-cap, flags=0x00002004, field=none, sequence=163,
memory=userptr, bytesused=460800, offset/userptr=0x344b000,
length=460800

This patch forces FLAG_DONE to 0 after calling DQBUF.

Reported-by: Dimitrios Katsaros <patcherwork@gmail.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/v4l2-core/videobuf2-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-core/videobuf2-core.c
index d5c300150cf4..f0811b7e900d 100644
--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -2075,6 +2075,11 @@ static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool n
 	dprintk(1, "dqbuf of buffer %d, with state %d\n",
 			vb->v4l2_buf.index, vb->state);
 
+	/*
+	 * After calling the VIDIOC_DQBUF V4L2_BUF_FLAG_DONE must be
+	 * cleared.
+	 */
+	b->flags &= ~V4L2_BUF_FLAG_DONE;
 	return 0;
 }
 
-- 
2.14.3
