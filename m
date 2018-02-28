Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834386-2-7345354632218718666
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834386; b=csCz6ywiUHyTfr2QssI25XKibIB1UQXEYsYsVp2kovlubmA
    3ae7jqfhh++0iiybhR+p80FvBmf8LtPKCNKSdWFKx1/9d501umZkH4GDYuPTaEfR
    GDnHZ+aOGwbFunssRmXfH843cmuradGVwE+riXy3I9j/bij9ZbkDtdx4bnHOeTzZ
    +m/7hqNcwx3jZh8gyVFv9FnWCC6Fe7xOf3+9la6jD+tMMGHQQvLRRU62fjAlJZ01
    09kWB4ZfZr4b40eAT0NGMgMwJ1YkGvXs1qclwvSOuXKSkfQUbptxBAr2poawn8a9
    TBDTMkfy8aA2Z73kOEaX4ioM2uMijF46P/uQV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834386; bh=DvKMAdHhncXRkDTJtR+
    K98OpeeVDfiP5pdMJsuRR0J0=; b=bHsCeJO95rlBrgj9xtgX/+T06jYtFn94ctJ
    Wdz49k0XHLNrIEAsJ3i9pEsCe6YN0dM4cmEK/1ul1DKkPy7bww2+d0MtULmbpCNb
    WV1GDwPHB/JQJ1Es5sNLS/X8ksbLPfr8TdkG+1n1+FwHaMp8/S18ZYspsz77iGv2
    fQf3VbRfTyxrV3arCYjWaIlgNIkgqENTv9DtYrOwaqIxw7XP4IdMmZFhKhITVq++
    7fcdsUnoZjD2EKd2+N5FKyKwDe6DKZJhMmiOqYimfLX1WCvpFv5xWvNF1+gOfbcH
    lobzxOLoyIzs+cLDYCEl2CvRlPsFyhikZINoknvOdrjtFkVXfZw==
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
        id S934475AbeB1QM0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:12:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35034 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932702AbeB1QMT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:12:19 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        "Hans Verkuil" <hans.verkuil@cisco.com>,
        "Ricardo Ribalda" <ricardo.ribalda@gmail.com>,
        "Dimitrios Katsaros" <patcherwork@gmail.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.561298105@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 241/254] vb2: V4L2_BUF_FLAG_DONE is set after DQBUF
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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/v4l2-core/videobuf2-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-core/videobuf2-core.c
index e63a7904bf5b..ee8b697972bb 100644
--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -2069,6 +2069,11 @@ static int vb2_internal_dqbuf(struct vb2_queue *q, struct v4l2_buffer *b, bool n
 	dprintk(1, "dqbuf of buffer %d, with state %d\n",
 			vb->v4l2_buf.index, vb->state);
 
+	/*
+	 * After calling the VIDIOC_DQBUF V4L2_BUF_FLAG_DONE must be
+	 * cleared.
+	 */
+	b->flags &= ~V4L2_BUF_FLAG_DONE;
 	return 0;
 }
 
